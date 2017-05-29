Received: from eggs.gnu.org ([2001:4830:134:3::10]:38884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHd-0006U8-On
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00075M-HZ
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHa-00072p-4y
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:37 +0200
Message-Id: <20170529192440.5990-27-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 26/29] target/s390x: implement UNPACK UNICODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 49 ++++++++++++++++++++++++++++++++++++----------
 target/s390x/translate.c   | 18 +++++++++++++++++
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 97f03e7b79..b2e269b6a5 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -87,6 +87,7 @@ DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(unpka, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
+DEF_HELPER_FLAGS_4(unpku, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
 DEF_HELPER_4(trt, i32, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 33434a31d0..683f91bf7f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -877,6 +877,8 @@
     C(0xf300, UNPK,    SS_a,  Z,   la1, a2, 0, 0, unpk, 0)
 /* UNPACK ASCII */
     C(0xea00, UNPKA,   SS_a,  E2,  la1, a2, 0, 0, unpka, 0)
+/* UNPACK UNICODE */
+    C(0xe200, UNPKU,   SS_a,  E2,  la1, a2, 0, 0, unpku, 0)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 261c23733d..8063f42eb3 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -93,6 +93,23 @@ static inline uint64_t cpu_ldusize_data_ra(CPUS390XState *env, uint64_t addr,
     }
 }
 
+/* Store a to memory according to its size.  */
+static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
+                                      uint64_t value, int wordsize,
+                                      uintptr_t ra)
+{
+    switch (wordsize) {
+    case 1:
+        cpu_stb_data_ra(env, addr, value, ra);
+        break;
+    case 2:
+        cpu_stw_data_ra(env, addr, value, ra);
+        break;
+    default:
+        abort();
+    }
+}
+
 static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
                         uint32_t l, uintptr_t ra)
 {
@@ -1008,10 +1025,10 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
     }
 }
 
-uint32_t HELPER(unpka)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
-                       uint64_t src)
+static inline uint32_t do_unpkau(CPUS390XState *env, uint64_t dest,
+                                 uint32_t destlen, int dsize, uint64_t src,
+                                 uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
     int i;
     uint32_t cc;
     uint8_t b;
@@ -1020,7 +1037,7 @@ uint32_t HELPER(unpka)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
 
     /* The operands are processed from right to left.  */
     src += srclen - 1;
-    dest += destlen - 1;
+    dest += destlen - dsize;
 
     /* Check for the sign.  */
     b = cpu_ldub_data_ra(env, src, ra);
@@ -1042,23 +1059,35 @@ uint32_t HELPER(unpka)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
     }
 
     /* Now pad every nibble with 0x30, advancing one nibble at a time. */
-    for (i = 0; i < destlen; i++) {
-        if (i == 31) {
-            /* If length is 32 bytes, the leftmost byte is 0. */
+    for (i = 0; i < destlen; i += dsize) {
+        if (i == (31 * dsize)) {
+            /* If length is 32/64 bytes, the leftmost byte is 0. */
             b = 0;
-        } else if (i % 2) {
+        } else if (i % (2 * dsize)) {
             b = cpu_ldub_data_ra(env, src, ra);
             src--;
         } else {
             b >>= 4;
         }
-        cpu_stb_data_ra(env, dest, 0x30 + (b & 0xf), ra);
-        dest--;
+        cpu_stsize_data_ra(env, dest, 0x30 + (b & 0xf), dsize, ra);
+        dest -= dsize;
     }
 
     return cc;
 }
 
+uint32_t HELPER(unpka)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
+                       uint64_t src)
+{
+    return do_unpkau(env, dest, destlen, 1, src, GETPC());
+}
+
+uint32_t HELPER(unpku)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
+                       uint64_t src)
+{
+    return do_unpkau(env, dest, destlen, 2, src, GETPC());
+}
+
 static uint32_t do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
                              uint64_t trans, uintptr_t ra)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 2ff666573e..747d4ebc10 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4374,6 +4374,24 @@ static ExitStatus op_unpka(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_unpku(DisasContext *s, DisasOps *o)
+{
+    int l1 = get_field(s->fields, l1) + 1;
+    TCGv_i32 l;
+
+    /* The length must be even and should not exceed 64 bytes.  */
+    if ((l1 & 1) || (l1 > 64)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+    l = tcg_const_i32(l1);
+    gen_helper_unpku(cc_op, cpu_env, o->addr1, l, o->in2);
+    tcg_temp_free_i32(l);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+
 static ExitStatus op_xc(DisasContext *s, DisasOps *o)
 {
     int d1 = get_field(s->fields, d1);
-- 
2.11.0
