Received: from eggs.gnu.org ([2001:4830:134:3::10]:50016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZR1-0007JA-6W
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZQx-0002kQ-8c
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:27 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZQx-0002k6-2I
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:23 -0400
Received: by mail-pf0-x243.google.com with SMTP id u26so18118537pfd.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:07 -0700
Message-Id: <20170604173509.29684-8-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 07/69] target/s390x: Use unwind data for
 helper_mvc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 30 ++++++++++++++++++------------
 target/s390x/translate.c  |  1 -
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b71437a..78a9ac1 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -91,7 +91,7 @@ static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
 }
 
 static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
-                         uint32_t l)
+                         uint32_t l, uintptr_t ra)
 {
     int mmu_idx = cpu_mmu_index(env, false);
 
@@ -110,7 +110,7 @@ static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
             /* We failed to get access to one or both whole pages. The next
                read or write access will likely fill the QEMU TLB for the
                next iteration.  */
-            cpu_stb_data(env, dest, cpu_ldub_data(env, src));
+            cpu_stb_data_ra(env, dest, cpu_ldub_data_ra(env, src, ra), ra);
             src++;
             dest++;
             l--;
@@ -200,32 +200,38 @@ uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 }
 
 /* memmove */
-void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
+static void do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t dest,
+                          uint64_t src, uintptr_t ra)
 {
-    int i = 0;
+    uint32_t i;
 
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
 
     /* mvc with source pointing to the byte after the destination is the
        same as memset with the first source byte */
-    if (dest == (src + 1)) {
-        fast_memset(env, dest, cpu_ldub_data(env, src), l + 1, 0);
+    if (dest == src + 1) {
+        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l + 1, ra);
         return;
     }
 
     /* mvc and memmove do not behave the same when areas overlap! */
-    if ((dest < src) || (src + l < dest)) {
-        fast_memmove(env, dest, src, l + 1);
+    if (dest < src || src + l < dest) {
+        fast_memmove(env, dest, src, l + 1, ra);
         return;
     }
 
     /* slow version with byte accesses which always work */
     for (i = 0; i <= l; i++) {
-        cpu_stb_data(env, dest + i, cpu_ldub_data(env, src + i));
+        cpu_stb_data_ra(env, dest + i, cpu_ldub_data_ra(env, src + i, ra), ra);
     }
 }
 
+void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
+{
+    do_helper_mvc(env, l, dest, src, GETPC());
+}
+
 /* compare unsigned byte arrays */
 uint32_t HELPER(clc)(CPUS390XState *env, uint32_t l, uint64_t s1, uint64_t s2)
 {
@@ -388,7 +394,7 @@ void HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
 {
     /* XXX missing r0 handling */
     env->cc_op = 0;
-    fast_memmove(env, r1, r2, TARGET_PAGE_SIZE);
+    fast_memmove(env, r1, r2, TARGET_PAGE_SIZE, 0);
 }
 
 /* string copy (c is string terminator) */
@@ -1223,8 +1229,8 @@ uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
         d2 = insn2 & 0xfff;
         switch (insn & 0xf00) {
         case 0x200:
-            helper_mvc(env, l, get_address(env, 0, b1, d1),
-                       get_address(env, 0, b2, d2));
+            do_helper_mvc(env, l, get_address(env, 0, b1, d1),
+                          get_address(env, 0, b2, d2), 0);
             break;
         case 0x400:
             cc = do_helper_nc(env, l, get_address(env, 0, b1, d1),
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 40a4099..729924a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2866,7 +2866,6 @@ static ExitStatus op_movx(DisasContext *s, DisasOps *o)
 static ExitStatus op_mvc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_mvc(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return NO_EXIT;
-- 
2.9.4
