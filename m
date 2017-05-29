Received: from eggs.gnu.org ([2001:4830:134:3::10]:38942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHe-0006UF-Mk
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00076M-RW
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:54 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHa-00073C-Ko
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:35 +0200
Message-Id: <20170529192440.5990-25-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 24/29] target/s390x: implement PACK UNICODE
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

Use a common helper with PACK ASCII as the differences are limited to
the stride of the source operand.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 30 +++++++++++++++++++++---------
 target/s390x/translate.c   | 16 ++++++++++++++++
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9d6b59d3cc..6e167d9643 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -84,6 +84,7 @@ DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
+DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 41431affe6..16f788c86a 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -669,6 +669,8 @@
     C(0xf200, PACK,    SS_a,  Z,   la1, a2, 0, 0, pack, 0)
 /* PACK ASCII */
     C(0xe900, PKA,     SS_f,  E2,  la1, a2, 0, 0, pka, 0)
+/* PACK UNICODE */
+    C(0xe100, PKU,     SS_f,  E2,  la1, a2, 0, 0, pku, 0)
 
 /* PREFETCH */
     /* Implemented as nops of course.  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 01d6734860..4044dc4eb0 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -914,10 +914,9 @@ void HELPER(pack)(CPUS390XState *env, uint32_t len, uint64_t dest, uint64_t src)
     }
 }
 
-void HELPER(pka)(CPUS390XState *env, uint64_t dest, uint64_t src,
-                 uint32_t srclen)
+static inline void do_pkau(CPUS390XState *env, uint64_t dest, uint64_t src,
+                           uint32_t srclen, int ssize, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
     int i;
     /* The destination operand is always 16 bytes long.  */
     const int destlen = 16;
@@ -932,16 +931,16 @@ void HELPER(pka)(CPUS390XState *env, uint64_t dest, uint64_t src,
         /* Start with a positive sign */
         if (i == 0) {
             b = 0xc;
-        } else if (srclen > 1) {
+        } else if (srclen > ssize) {
             b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
-            src--;
-            srclen--;
+            src -= ssize;
+            srclen -= ssize;
         }
 
-        if (srclen > 1) {
+        if (srclen > ssize) {
             b |= cpu_ldub_data_ra(env, src, ra) << 4;
-            src--;
-            srclen--;
+            src -= ssize;
+            srclen -= ssize;
         }
 
         cpu_stb_data_ra(env, dest, b, ra);
@@ -949,6 +948,19 @@ void HELPER(pka)(CPUS390XState *env, uint64_t dest, uint64_t src,
     }
 }
 
+
+void HELPER(pka)(CPUS390XState *env, uint64_t dest, uint64_t src,
+                 uint32_t srclen)
+{
+    do_pkau(env, dest, src, srclen, 1, GETPC());
+}
+
+void HELPER(pku)(CPUS390XState *env, uint64_t dest, uint64_t src,
+                 uint32_t srclen)
+{
+    do_pkau(env, dest, src, srclen, 2, GETPC());
+}
+
 void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
                   uint64_t src)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5093995f9a..d8b0515f17 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3317,6 +3317,22 @@ static ExitStatus op_pka(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_pku(DisasContext *s, DisasOps *o)
+{
+    int l2 = get_field(s->fields, l2) + 1;
+    TCGv_i32 l;
+
+    /* The length must be even and should not exceed 64 bytes.  */
+    if ((l2 & 1) || (l2 > 64)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+    l = tcg_const_i32(l2);
+    gen_helper_pku(cpu_env, o->addr1, o->in2, l);
+    tcg_temp_free_i32(l);
+    return NO_EXIT;
+}
+
 static ExitStatus op_popcnt(DisasContext *s, DisasOps *o)
 {
     gen_helper_popcnt(o->out, o->in2);
-- 
2.11.0
