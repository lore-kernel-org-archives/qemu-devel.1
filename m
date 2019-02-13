Received: from eggs.gnu.org ([209.51.188.92]:39689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbv-00007M-09
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbt-0002Ng-27
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:34:02 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 13 Feb 2019 15:33:20 +0100
Message-Id: <20190213143322.31371-14-david@redhat.com>
In-Reply-To: <20190213143322.31371-1-david@redhat.com>
References: <20190213143322.31371-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/15] s390x/tcg: Implement rounding mode
 and XxC for LOAD ROUNDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

With the floating-point extension facility, LOAD ROUNDED has
a rounding mode specification and the inexact-exception control (XxC).

Handle them just like e.g. LOAD FP INTEGER.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c  | 23 +++++++++++++++++------
 target/s390x/helper.h      |  6 +++---
 target/s390x/insn-data.def |  6 +++---
 target/s390x/translate.c   | 24 +++++++++++++++++++++---
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index a9fad6b3cd..5e4b76f4aa 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -317,10 +317,14 @@ uint64_t HELPER(ldeb)(CPUS390XState *env, uint64_t f2)
 }
 
 /* convert 128-bit float to 64-bit float */
-uint64_t HELPER(ldxb)(CPUS390XState *env, uint64_t ah, uint64_t al)
+uint64_t HELPER(ldxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
+                      uint32_t m34)
 {
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float64 ret = float128_to_float64(make_float128(ah, al), &env->fpu_status);
-    handle_exceptions(env, false, GETPC());
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
@@ -341,18 +345,25 @@ uint64_t HELPER(lxeb)(CPUS390XState *env, uint64_t f2)
 }
 
 /* convert 64-bit float to 32-bit float */
-uint64_t HELPER(ledb)(CPUS390XState *env, uint64_t f2)
+uint64_t HELPER(ledb)(CPUS390XState *env, uint64_t f2, uint32_t m34)
 {
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float32 ret = float64_to_float32(f2, &env->fpu_status);
-    handle_exceptions(env, false, GETPC());
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 32-bit float */
-uint64_t HELPER(lexb)(CPUS390XState *env, uint64_t ah, uint64_t al)
+uint64_t HELPER(lexb)(CPUS390XState *env, uint64_t ah, uint64_t al,
+                      uint32_t m34)
 {
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float32 ret = float128_to_float32(make_float128(ah, al), &env->fpu_status);
-    handle_exceptions(env, false, GETPC());
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index d287d5dac0..bb659257f6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -53,11 +53,11 @@ DEF_HELPER_FLAGS_3(mdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_5(mxb, TCG_CALL_NO_WG, i64, env, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mxdb, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_2(ldeb, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_3(ldxb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(ldxb, TCG_CALL_NO_WG, i64, env, i64, i64, i32)
 DEF_HELPER_FLAGS_2(lxdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(lxeb, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_2(ledb, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_3(lexb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(ledb, TCG_CALL_NO_WG, i64, env, i64, i32)
+DEF_HELPER_FLAGS_4(lexb, TCG_CALL_NO_WG, i64, env, i64, i64, i32)
 DEF_HELPER_FLAGS_3(ceb, TCG_CALL_NO_WG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_3(cdb, TCG_CALL_NO_WG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_5(cxb, TCG_CALL_NO_WG_SE, i32, env, i64, i64, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2c9ae503c5..3a8d4f6804 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -599,9 +599,9 @@
     F(0xed05, LXDB,    RXE,   Z,   0, m2_64, new_P, x1, lxdb, 0, IF_BFP)
     F(0xed06, LXEB,    RXE,   Z,   0, m2_32u, new_P, x1, lxeb, 0, IF_BFP)
 /* LOAD ROUNDED */
-    F(0xb344, LEDBR,   RRE,   Z,   0, f2, new, e1, ledb, 0, IF_BFP)
-    F(0xb345, LDXBR,   RRE,   Z,   x2h, x2l, new, f1, ldxb, 0, IF_BFP)
-    F(0xb346, LEXBR,   RRE,   Z,   x2h, x2l, new, e1, lexb, 0, IF_BFP)
+    F(0xb344, LEDBR,   RRF_e, Z,   0, f2, new, e1, ledb, 0, IF_BFP)
+    F(0xb345, LDXBR,   RRF_e, Z,   x2h, x2l, new, f1, ldxb, 0, IF_BFP)
+    F(0xb346, LEXBR,   RRF_e, Z,   x2h, x2l, new, e1, lexb, 0, IF_BFP)
 
 /* LOAD MULTIPLE */
     C(0x9800, LM,      RS_a,  Z,   0, a2, 0, 0, lm32, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index e252ba375c..02a4bb6ac2 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2787,19 +2787,37 @@ static DisasJumpType op_ldeb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_ledb(DisasContext *s, DisasOps *o)
 {
-    gen_helper_ledb(o->out, cpu_env, o->in2);
+    TCGv_i32 m34 = fpinst_extract_m34(s, true, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_ledb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ldxb(DisasContext *s, DisasOps *o)
 {
-    gen_helper_ldxb(o->out, cpu_env, o->in1, o->in2);
+    TCGv_i32 m34 = fpinst_extract_m34(s, true, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_ldxb(o->out, cpu_env, o->in1, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_lexb(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lexb(o->out, cpu_env, o->in1, o->in2);
+    TCGv_i32 m34 = fpinst_extract_m34(s, true, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_lexb(o->out, cpu_env, o->in1, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
-- 
2.17.2
