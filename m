Received: from eggs.gnu.org ([2001:4830:134:3::10]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkG-0003FD-6i
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkB-0006nI-TM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:04 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:13 +1100
Message-Id: <20170112020327.24882-54-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 53/67] target-ppc: Rename helper_compute_fprf to
 helper_compute_fprf_float64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Since helper_compute_fprf() works on float64 argument, rename it
to helper_compute_fprf_float64(). Also use a macro to generate
helper_compute_fprf_float64() so that float128 version of the same
helper can be introduced easily later.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c            | 121 +++++++++++++++++++------------------
 target/ppc/helper.h                |   2 +-
 target/ppc/translate/fp-impl.inc.c |  20 +++---
 3 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 5a7aa75..913d54e 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -57,54 +57,57 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
     return ((f >> 52) & 0x7FF) - 1023;
 }
 
-void helper_compute_fprf(CPUPPCState *env, float64 arg)
-{
-    int isneg;
-    int fprf;
-
-    isneg = float64_is_neg(arg);
-    if (unlikely(float64_is_any_nan(arg))) {
-        if (float64_is_signaling_nan(arg, &env->fp_status)) {
-            /* Signaling NaN: flags are undefined */
-            fprf = 0x00;
-        } else {
-            /* Quiet NaN */
-            fprf = 0x11;
-        }
-    } else if (unlikely(float64_is_infinity(arg))) {
-        /* +/- infinity */
-        if (isneg) {
-            fprf = 0x09;
-        } else {
-            fprf = 0x05;
-        }
-    } else {
-        if (float64_is_zero(arg)) {
-            /* +/- zero */
-            if (isneg) {
-                fprf = 0x12;
-            } else {
-                fprf = 0x02;
-            }
-        } else {
-            if (float64_is_zero_or_denormal(arg)) {
-                /* Denormalized numbers */
-                fprf = 0x10;
-            } else {
-                /* Normalized numbers */
-                fprf = 0x00;
-            }
-            if (isneg) {
-                fprf |= 0x08;
-            } else {
-                fprf |= 0x04;
-            }
-        }
-    }
-    /* We update FPSCR_FPRF */
-    env->fpscr &= ~(0x1F << FPSCR_FPRF);
-    env->fpscr |= fprf << FPSCR_FPRF;
-}
+#define COMPUTE_FPRF(tp)                                       \
+void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
+{                                                              \
+    int isneg;                                                 \
+    int fprf;                                                  \
+                                                               \
+    isneg = tp##_is_neg(arg);                                  \
+    if (unlikely(tp##_is_any_nan(arg))) {                      \
+        if (tp##_is_signaling_nan(arg, &env->fp_status)) {     \
+            /* Signaling NaN: flags are undefined */           \
+            fprf = 0x00;                                       \
+        } else {                                               \
+            /* Quiet NaN */                                    \
+            fprf = 0x11;                                       \
+        }                                                      \
+    } else if (unlikely(tp##_is_infinity(arg))) {              \
+        /* +/- infinity */                                     \
+        if (isneg) {                                           \
+            fprf = 0x09;                                       \
+        } else {                                               \
+            fprf = 0x05;                                       \
+        }                                                      \
+    } else {                                                   \
+        if (tp##_is_zero(arg)) {                               \
+            /* +/- zero */                                     \
+            if (isneg) {                                       \
+                fprf = 0x12;                                   \
+            } else {                                           \
+                fprf = 0x02;                                   \
+            }                                                  \
+        } else {                                               \
+            if (tp##_is_zero_or_denormal(arg)) {               \
+                /* Denormalized numbers */                     \
+                fprf = 0x10;                                   \
+            } else {                                           \
+                /* Normalized numbers */                       \
+                fprf = 0x00;                                   \
+            }                                                  \
+            if (isneg) {                                       \
+                fprf |= 0x08;                                  \
+            } else {                                           \
+                fprf |= 0x04;                                  \
+            }                                                  \
+        }                                                      \
+    }                                                          \
+    /* We update FPSCR_FPRF */                                 \
+    env->fpscr &= ~(0x1F << FPSCR_FPRF);                       \
+    env->fpscr |= fprf << FPSCR_FPRF;                          \
+}
+
+COMPUTE_FPRF(float64)
 
 /* Floating-point invalid operations exception */
 static inline __attribute__((__always_inline__))
@@ -1808,7 +1811,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf(env, xt.fld);                                \
+            helper_compute_fprf_float64(env, xt.fld);                        \
         }                                                                    \
     }                                                                        \
     putVSR(xT(opcode), &xt, env);                                            \
@@ -1863,7 +1866,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf(env, xt.fld);                                \
+            helper_compute_fprf_float64(env, xt.fld);                        \
         }                                                                    \
     }                                                                        \
                                                                              \
@@ -1917,7 +1920,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         }                                                                     \
                                                                               \
         if (sfprf) {                                                          \
-            helper_compute_fprf(env, xt.fld);                                 \
+            helper_compute_fprf_float64(env, xt.fld);                         \
         }                                                                     \
     }                                                                         \
                                                                               \
@@ -1958,7 +1961,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         }                                                                     \
                                                                               \
         if (sfprf) {                                                          \
-            helper_compute_fprf(env, xt.fld);                                 \
+            helper_compute_fprf_float64(env, xt.fld);                         \
         }                                                                     \
     }                                                                         \
                                                                               \
@@ -2007,7 +2010,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf(env, xt.fld);                                \
+            helper_compute_fprf_float64(env, xt.fld);                        \
         }                                                                    \
     }                                                                        \
                                                                              \
@@ -2057,7 +2060,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf(env, xt.fld);                                \
+            helper_compute_fprf_float64(env, xt.fld);                        \
         }                                                                    \
     }                                                                        \
                                                                              \
@@ -2257,7 +2260,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
         }                                                                     \
                                                                               \
         if (sfprf) {                                                          \
-            helper_compute_fprf(env, xt_out.fld);                             \
+            helper_compute_fprf_float64(env, xt_out.fld);                     \
         }                                                                     \
     }                                                                         \
     putVSR(xT(opcode), &xt_out, env);                                         \
@@ -2647,7 +2650,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                \
             xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
         }                                                          \
         if (sfprf) {                                               \
-            helper_compute_fprf(env, ttp##_to_float64(xt.tfld,     \
+            helper_compute_fprf_float64(env, ttp##_to_float64(xt.tfld, \
                                 &env->fp_status));                 \
         }                                                          \
     }                                                              \
@@ -2758,7 +2761,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
             xt.tfld = helper_frsp(env, xt.tfld);                        \
         }                                                               \
         if (sfprf) {                                                    \
-            helper_compute_fprf(env, xt.tfld);                          \
+            helper_compute_fprf_float64(env, xt.tfld);                  \
         }                                                               \
     }                                                                   \
                                                                         \
@@ -2814,7 +2817,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
             xt.fld = tp##_round_to_int(xb.fld, &env->fp_status);       \
         }                                                              \
         if (sfprf) {                                                   \
-            helper_compute_fprf(env, xt.fld);                          \
+            helper_compute_fprf_float64(env, xt.fld);                  \
         }                                                              \
     }                                                                  \
                                                                        \
@@ -2854,7 +2857,7 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
 
     uint64_t xt = helper_frsp(env, xb);
 
-    helper_compute_fprf(env, xt);
+    helper_compute_fprf_float64(env, xt);
     float_check_status(env);
     return xt;
 }
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6c5b194..04e688d 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -61,7 +61,7 @@ DEF_HELPER_FLAGS_2(brinc, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 
 DEF_HELPER_1(float_check_status, void, env)
 DEF_HELPER_1(reset_fpstatus, void, env)
-DEF_HELPER_2(compute_fprf, void, env, i64)
+DEF_HELPER_2(compute_fprf_float64, void, env, i64)
 DEF_HELPER_3(store_fpscr, void, env, i64, i32)
 DEF_HELPER_2(fpscr_clrbit, void, env, i32)
 DEF_HELPER_2(fpscr_setbit, void, env, i32)
diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
index 872af7b..2fbd4d4 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -9,9 +9,9 @@ static inline void gen_reset_fpstatus(void)
     gen_helper_reset_fpstatus(cpu_env);
 }
 
-static inline void gen_compute_fprf(TCGv_i64 arg)
+static inline void gen_compute_fprf_float64(TCGv_i64 arg)
 {
-    gen_helper_compute_fprf(cpu_env, arg);
+    gen_helper_compute_fprf_float64(cpu_env, arg);
     gen_helper_float_check_status(cpu_env);
 }
 
@@ -47,7 +47,7 @@ static void gen_f##name(DisasContext *ctx)                                    \
                         cpu_fpr[rD(ctx->opcode)]);                            \
     }                                                                         \
     if (set_fprf) {                                                           \
-        gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);                           \
+        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);                   \
     }                                                                         \
     if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
         gen_set_cr1_from_fpscr(ctx);                                          \
@@ -74,7 +74,7 @@ static void gen_f##name(DisasContext *ctx)                                    \
                         cpu_fpr[rD(ctx->opcode)]);                            \
     }                                                                         \
     if (set_fprf) {                                                           \
-        gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);                           \
+        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);                   \
     }                                                                         \
     if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
         gen_set_cr1_from_fpscr(ctx);                                          \
@@ -100,7 +100,7 @@ static void gen_f##name(DisasContext *ctx)                                    \
                         cpu_fpr[rD(ctx->opcode)]);                            \
     }                                                                         \
     if (set_fprf) {                                                           \
-        gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);                           \
+        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);                   \
     }                                                                         \
     if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
         gen_set_cr1_from_fpscr(ctx);                                          \
@@ -121,7 +121,7 @@ static void gen_f##name(DisasContext *ctx)                                    \
     gen_helper_f##name(cpu_fpr[rD(ctx->opcode)], cpu_env,                     \
                        cpu_fpr[rB(ctx->opcode)]);                             \
     if (set_fprf) {                                                           \
-        gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);                           \
+        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);                   \
     }                                                                         \
     if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
         gen_set_cr1_from_fpscr(ctx);                                          \
@@ -139,7 +139,7 @@ static void gen_f##name(DisasContext *ctx)                                    \
     gen_helper_f##name(cpu_fpr[rD(ctx->opcode)], cpu_env,                     \
                        cpu_fpr[rB(ctx->opcode)]);                             \
     if (set_fprf) {                                                           \
-        gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);                           \
+        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);                   \
     }                                                                         \
     if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
         gen_set_cr1_from_fpscr(ctx);                                          \
@@ -174,7 +174,7 @@ static void gen_frsqrtes(DisasContext *ctx)
                        cpu_fpr[rB(ctx->opcode)]);
     gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,
                     cpu_fpr[rD(ctx->opcode)]);
-    gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);
+    gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_cr1_from_fpscr(ctx);
     }
@@ -196,7 +196,7 @@ static void gen_fsqrt(DisasContext *ctx)
     gen_reset_fpstatus();
     gen_helper_fsqrt(cpu_fpr[rD(ctx->opcode)], cpu_env,
                      cpu_fpr[rB(ctx->opcode)]);
-    gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);
+    gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_cr1_from_fpscr(ctx);
     }
@@ -213,7 +213,7 @@ static void gen_fsqrts(DisasContext *ctx)
                      cpu_fpr[rB(ctx->opcode)]);
     gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,
                     cpu_fpr[rD(ctx->opcode)]);
-    gen_compute_fprf(cpu_fpr[rD(ctx->opcode)]);
+    gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_cr1_from_fpscr(ctx);
     }
-- 
2.9.3
