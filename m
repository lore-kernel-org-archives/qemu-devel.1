Received: from eggs.gnu.org ([2001:4830:134:3::10]:45237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbs5-0001fS-5T
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbs3-0000uQ-L1
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:01 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbs3-0000uL-G2
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:22:59 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so27716720qka.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:22:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:18 -0700
Message-Id: <20170524192246.15905-6-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 05/33] target/s390x: Use unwind data for
 helper_xc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 44 ++++++++++++++++++++++++--------------------
 target/s390x/translate.c  |  1 -
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b4b50d1..b71437a 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -57,7 +57,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 #endif
 
 /* Reduce the length so that addr + len doesn't cross a page boundary.  */
-static inline uint64_t adj_len_to_page(uint64_t len, uint64_t addr)
+static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
 {
 #ifndef CONFIG_USER_ONLY
     if ((addr & ~TARGET_PAGE_MASK) + len - 1 >= TARGET_PAGE_SIZE) {
@@ -68,7 +68,7 @@ static inline uint64_t adj_len_to_page(uint64_t len, uint64_t addr)
 }
 
 static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
-                        uint32_t l)
+                        uint32_t l, uintptr_t ra)
 {
     int mmu_idx = cpu_mmu_index(env, false);
 
@@ -76,14 +76,14 @@ static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
         void *p = tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, mmu_idx);
         if (p) {
             /* Access to the whole page in write mode granted.  */
-            int l_adj = adj_len_to_page(l, dest);
+            uint32_t l_adj = adj_len_to_page(l, dest);
             memset(p, byte, l_adj);
             dest += l_adj;
             l -= l_adj;
         } else {
             /* We failed to get access to the whole page. The next write
                access will likely fill the QEMU TLB for the next iteration.  */
-            cpu_stb_data(env, dest, byte);
+            cpu_stb_data_ra(env, dest, byte, ra);
             dest++;
             l--;
         }
@@ -100,7 +100,7 @@ static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
         void *dest_p = tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, mmu_idx);
         if (src_p && dest_p) {
             /* Access to both whole pages granted.  */
-            int l_adj = adj_len_to_page(l, src);
+            uint32_t l_adj = adj_len_to_page(l, src);
             l_adj = adj_len_to_page(l_adj, dest);
             memmove(dest_p, src_p, l_adj);
             src += l_adj;
@@ -144,30 +144,34 @@ uint32_t HELPER(nc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 }
 
 /* xor on array */
-uint32_t HELPER(xc)(CPUS390XState *env, uint32_t l, uint64_t dest,
-                    uint64_t src)
+static uint32_t do_helper_xc(CPUS390XState *env, uint32_t l, uint64_t dest,
+                             uint64_t src, uintptr_t ra)
 {
-    int i;
-    unsigned char x;
-    uint32_t cc = 0;
+    uint32_t i;
+    uint8_t c = 0;
 
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
 
     /* xor with itself is the same as memset(0) */
     if (src == dest) {
-        fast_memset(env, dest, 0, l + 1);
+        fast_memset(env, dest, 0, l + 1, ra);
         return 0;
     }
 
     for (i = 0; i <= l; i++) {
-        x = cpu_ldub_data(env, dest + i) ^ cpu_ldub_data(env, src + i);
-        if (x) {
-            cc = 1;
-        }
-        cpu_stb_data(env, dest + i, x);
+        uint8_t x = cpu_ldub_data_ra(env, src + i, ra);
+        x ^= cpu_ldub_data_ra(env, dest + i, ra);
+        c |= x;
+        cpu_stb_data_ra(env, dest + i, x, ra);
     }
-    return cc;
+    return c != 0;
+}
+
+uint32_t HELPER(xc)(CPUS390XState *env, uint32_t l, uint64_t dest,
+                    uint64_t src)
+{
+    return do_helper_xc(env, l, dest, src, GETPC());
 }
 
 /* or on array */
@@ -206,7 +210,7 @@ void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     /* mvc with source pointing to the byte after the destination is the
        same as memset with the first source byte */
     if (dest == (src + 1)) {
-        fast_memset(env, dest, cpu_ldub_data(env, src), l + 1);
+        fast_memset(env, dest, cpu_ldub_data(env, src), l + 1, 0);
         return;
     }
 
@@ -1235,8 +1239,8 @@ uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
                               get_address(env, 0, b2, d2), 0);
             break;
         case 0x700:
-            cc = helper_xc(env, l, get_address(env, 0, b1, d1),
-                           get_address(env, 0, b2, d2));
+            cc = do_helper_xc(env, l, get_address(env, 0, b1, d1),
+                              get_address(env, 0, b2, d2), 0);
             break;
         case 0xc00:
             helper_tr(env, l, get_address(env, 0, b1, d1),
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index db86b70..40a4099 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4160,7 +4160,6 @@ static ExitStatus op_xc(DisasContext *s, DisasOps *o)
     /* But in general we'll defer to a helper.  */
     o->in2 = get_address(s, 0, b2, d2);
     t32 = tcg_const_i32(l);
-    potential_page_fault(s);
     gen_helper_xc(cc_op, cpu_env, t32, o->addr1, o->in2);
     tcg_temp_free_i32(t32);
     set_cc_static(s);
-- 
2.9.4
