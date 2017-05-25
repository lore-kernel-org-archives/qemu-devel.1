Received: from eggs.gnu.org ([2001:4830:134:3::10]:55280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwd-0005g3-GA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwb-0001NQ-PG
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:19 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwb-0001MP-EJ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:17 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:05:03 +0200
Message-Id: <20170525210508.4910-22-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 21/26] target/s390x: implement PACK UNICODE
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
index 253e1e679c..1011df122d 100644
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
index b6d2215d85..3335270182 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -663,6 +663,8 @@
     C(0xf200, PACK,    SS_a,  Z,   la1, a2, 0, 0, pack, 0)
 /* PACK ASCII */
     C(0xe900, PKA,     SS_f,  E2,  la1, a2, 0, 0, pka, 0)
+/* PACK UNICODE */
+    C(0xe100, PKU,     SS_f,  E2,  la1, a2, 0, 0, pku, 0)
 
 /* PREFETCH */
     /* Implemented as nops of course.  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 6d64497edc..ab34a309ce 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -959,10 +959,9 @@ void HELPER(pack)(CPUS390XState *env, uint32_t len, uint64_t dest, uint64_t src)
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
@@ -977,16 +976,16 @@ void HELPER(pka)(CPUS390XState *env, uint64_t dest, uint64_t src,
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
@@ -994,6 +993,19 @@ void HELPER(pka)(CPUS390XState *env, uint64_t dest, uint64_t src,
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
index c74a80bf60..a2a27c86ea 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3242,6 +3242,22 @@ static ExitStatus op_pka(DisasContext *s, DisasOps *o)
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
