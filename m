Received: from eggs.gnu.org ([209.51.188.92]:58797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0v-00062g-04
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0p-00055c-UD
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:44 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 28 Apr 2019 15:38:32 +0100
Message-Id: <20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 01/14] target/ppc: remove getVSR()/putVSR()
 from fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
registers are in host endian order" functions getVSR() and putVSR() which used
to convert the VSR registers into host endian order are no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c | 707 ++++++++++++++++++++++--------------------------
 1 file changed, 317 insertions(+), 390 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 0b7308f539..148ee5ac4c 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1803,35 +1803,33 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
 #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)                    \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
 {                                                                            \
-    ppc_vsr_t xt, xa, xb;                                                    \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                   \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
-    getVSR(xA(opcode), &xa, env);                                            \
-    getVSR(xB(opcode), &xb, env);                                            \
-    getVSR(xT(opcode), &xt, env);                                            \
     helper_reset_fpstatus(env);                                              \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
         set_float_exception_flags(0, &tstat);                                \
-        xt.fld = tp##_##op(xa.fld, xb.fld, &tstat);                          \
+        xt->fld = tp##_##op(xa->fld, xb->fld, &tstat);                       \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
             float_invalid_op_addsub(env, sfprf, GETPC(),                     \
-                                    tp##_classify(xa.fld) |                  \
-                                    tp##_classify(xb.fld));                  \
+                                    tp##_classify(xa->fld) |                 \
+                                    tp##_classify(xb->fld));                 \
         }                                                                    \
                                                                              \
         if (r2sp) {                                                          \
-            xt.fld = helper_frsp(env, xt.fld);                               \
+            xt->fld = helper_frsp(env, xt->fld);                             \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf_float64(env, xt.fld);                        \
+            helper_compute_fprf_float64(env, xt->fld);                       \
         }                                                                    \
     }                                                                        \
-    putVSR(xT(opcode), &xt, env);                                            \
     do_float_check_status(env, GETPC());                                     \
 }
 
@@ -1846,12 +1844,11 @@ VSX_ADD_SUB(xvsubsp, sub, 4, float32, VsrW(i), 0, 0)
 
 void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
     helper_reset_fpstatus(env);
 
     tstat = env->fp_status;
@@ -1860,18 +1857,17 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
     }
 
     set_float_exception_flags(0, &tstat);
-    xt.f128 = float128_add(xa.f128, xb.f128, &tstat);
+    xt->f128 = float128_add(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_addsub(env, 1, GETPC(),
-                                float128_classify(xa.f128) |
-                                float128_classify(xb.f128));
+                                float128_classify(xa->f128) |
+                                float128_classify(xb->f128));
     }
 
-    helper_compute_fprf_float128(env, xt.f128);
+    helper_compute_fprf_float128(env, xt->f128);
 
-    putVSR(rD(opcode) + 32, &xt, env);
     do_float_check_status(env, GETPC());
 }
 
@@ -1886,36 +1882,34 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
 #define VSX_MUL(op, nels, tp, fld, sfprf, r2sp)                              \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
 {                                                                            \
-    ppc_vsr_t xt, xa, xb;                                                    \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                   \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
-    getVSR(xA(opcode), &xa, env);                                            \
-    getVSR(xB(opcode), &xb, env);                                            \
-    getVSR(xT(opcode), &xt, env);                                            \
     helper_reset_fpstatus(env);                                              \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
         set_float_exception_flags(0, &tstat);                                \
-        xt.fld = tp##_mul(xa.fld, xb.fld, &tstat);                           \
+        xt->fld = tp##_mul(xa->fld, xb->fld, &tstat);                        \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
             float_invalid_op_mul(env, sfprf, GETPC(),                        \
-                                 tp##_classify(xa.fld) |                     \
-                                 tp##_classify(xb.fld));                     \
+                                 tp##_classify(xa->fld) |                    \
+                                 tp##_classify(xb->fld));                    \
         }                                                                    \
                                                                              \
         if (r2sp) {                                                          \
-            xt.fld = helper_frsp(env, xt.fld);                               \
+            xt->fld = helper_frsp(env, xt->fld);                             \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf_float64(env, xt.fld);                        \
+            helper_compute_fprf_float64(env, xt->fld);                       \
         }                                                                    \
     }                                                                        \
                                                                              \
-    putVSR(xT(opcode), &xt, env);                                            \
     do_float_check_status(env, GETPC());                                     \
 }
 
@@ -1926,13 +1920,11 @@ VSX_MUL(xvmulsp, 4, float32, VsrW(i), 0, 0)
 
 void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
-
     helper_reset_fpstatus(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
@@ -1940,17 +1932,16 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
     }
 
     set_float_exception_flags(0, &tstat);
-    xt.f128 = float128_mul(xa.f128, xb.f128, &tstat);
+    xt->f128 = float128_mul(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_mul(env, 1, GETPC(),
-                             float128_classify(xa.f128) |
-                             float128_classify(xb.f128));
+                             float128_classify(xa->f128) |
+                             float128_classify(xb->f128));
     }
-    helper_compute_fprf_float128(env, xt.f128);
+    helper_compute_fprf_float128(env, xt->f128);
 
-    putVSR(rD(opcode) + 32, &xt, env);
     do_float_check_status(env, GETPC());
 }
 
@@ -1965,39 +1956,37 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
 #define VSX_DIV(op, nels, tp, fld, sfprf, r2sp)                               \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
 {                                                                             \
-    ppc_vsr_t xt, xa, xb;                                                     \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     int i;                                                                    \
                                                                               \
-    getVSR(xA(opcode), &xa, env);                                             \
-    getVSR(xB(opcode), &xb, env);                                             \
-    getVSR(xT(opcode), &xt, env);                                             \
     helper_reset_fpstatus(env);                                               \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
         float_status tstat = env->fp_status;                                  \
         set_float_exception_flags(0, &tstat);                                 \
-        xt.fld = tp##_div(xa.fld, xb.fld, &tstat);                            \
+        xt->fld = tp##_div(xa->fld, xb->fld, &tstat);                         \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags;  \
                                                                               \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {     \
             float_invalid_op_div(env, sfprf, GETPC(),                         \
-                                 tp##_classify(xa.fld) |                      \
-                                 tp##_classify(xb.fld));                      \
+                                 tp##_classify(xa->fld) |                     \
+                                 tp##_classify(xb->fld));                     \
         }                                                                     \
         if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {   \
             float_zero_divide_excp(env, GETPC());                             \
         }                                                                     \
                                                                               \
         if (r2sp) {                                                           \
-            xt.fld = helper_frsp(env, xt.fld);                                \
+            xt->fld = helper_frsp(env, xt->fld);                              \
         }                                                                     \
                                                                               \
         if (sfprf) {                                                          \
-            helper_compute_fprf_float64(env, xt.fld);                         \
+            helper_compute_fprf_float64(env, xt->fld);                        \
         }                                                                     \
     }                                                                         \
                                                                               \
-    putVSR(xT(opcode), &xt, env);                                             \
     do_float_check_status(env, GETPC());                                      \
 }
 
@@ -2008,13 +1997,11 @@ VSX_DIV(xvdivsp, 4, float32, VsrW(i), 0, 0)
 
 void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
-
     helper_reset_fpstatus(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
@@ -2022,20 +2009,19 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
     }
 
     set_float_exception_flags(0, &tstat);
-    xt.f128 = float128_div(xa.f128, xb.f128, &tstat);
+    xt->f128 = float128_div(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_div(env, 1, GETPC(),
-                             float128_classify(xa.f128) |
-                             float128_classify(xb.f128));
+                             float128_classify(xa->f128) |
+                             float128_classify(xb->f128));
     }
     if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {
         float_zero_divide_excp(env, GETPC());
     }
 
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, xt->f128);
     do_float_check_status(env, GETPC());
 }
 
@@ -2050,29 +2036,27 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
 #define VSX_RE(op, nels, tp, fld, sfprf, r2sp)                                \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
 {                                                                             \
-    ppc_vsr_t xt, xb;                                                         \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     int i;                                                                    \
                                                                               \
-    getVSR(xB(opcode), &xb, env);                                             \
-    getVSR(xT(opcode), &xt, env);                                             \
     helper_reset_fpstatus(env);                                               \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
-        if (unlikely(tp##_is_signaling_nan(xb.fld, &env->fp_status))) {       \
+        if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status))) {      \
             float_invalid_op_vxsnan(env, GETPC());                            \
         }                                                                     \
-        xt.fld = tp##_div(tp##_one, xb.fld, &env->fp_status);                 \
+        xt->fld = tp##_div(tp##_one, xb->fld, &env->fp_status);               \
                                                                               \
         if (r2sp) {                                                           \
-            xt.fld = helper_frsp(env, xt.fld);                                \
+            xt->fld = helper_frsp(env, xt->fld);                              \
         }                                                                     \
                                                                               \
         if (sfprf) {                                                          \
-            helper_compute_fprf_float64(env, xt.fld);                         \
+            helper_compute_fprf_float64(env, xt->fld);                        \
         }                                                                     \
     }                                                                         \
                                                                               \
-    putVSR(xT(opcode), &xt, env);                                             \
     do_float_check_status(env, GETPC());                                      \
 }
 
@@ -2092,37 +2076,35 @@ VSX_RE(xvresp, 4, float32, VsrW(i), 0, 0)
 #define VSX_SQRT(op, nels, tp, fld, sfprf, r2sp)                             \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
 {                                                                            \
-    ppc_vsr_t xt, xb;                                                        \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
-    getVSR(xB(opcode), &xb, env);                                            \
-    getVSR(xT(opcode), &xt, env);                                            \
     helper_reset_fpstatus(env);                                              \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
         set_float_exception_flags(0, &tstat);                                \
-        xt.fld = tp##_sqrt(xb.fld, &tstat);                                  \
+        xt->fld = tp##_sqrt(xb->fld, &tstat);                                \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
-            if (tp##_is_neg(xb.fld) && !tp##_is_zero(xb.fld)) {              \
+            if (tp##_is_neg(xb->fld) && !tp##_is_zero(xb->fld)) {            \
                 float_invalid_op_vxsqrt(env, sfprf, GETPC());                \
-            } else if (tp##_is_signaling_nan(xb.fld, &tstat)) {              \
+            } else if (tp##_is_signaling_nan(xb->fld, &tstat)) {             \
                 float_invalid_op_vxsnan(env, GETPC());                       \
             }                                                                \
         }                                                                    \
                                                                              \
         if (r2sp) {                                                          \
-            xt.fld = helper_frsp(env, xt.fld);                               \
+            xt->fld = helper_frsp(env, xt->fld);                             \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf_float64(env, xt.fld);                        \
+            helper_compute_fprf_float64(env, xt->fld);                       \
         }                                                                    \
     }                                                                        \
                                                                              \
-    putVSR(xT(opcode), &xt, env);                                            \
     do_float_check_status(env, GETPC());                                     \
 }
 
@@ -2142,38 +2124,36 @@ VSX_SQRT(xvsqrtsp, 4, float32, VsrW(i), 0, 0)
 #define VSX_RSQRTE(op, nels, tp, fld, sfprf, r2sp)                           \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
 {                                                                            \
-    ppc_vsr_t xt, xb;                                                        \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
-    getVSR(xB(opcode), &xb, env);                                            \
-    getVSR(xT(opcode), &xt, env);                                            \
     helper_reset_fpstatus(env);                                              \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
         set_float_exception_flags(0, &tstat);                                \
-        xt.fld = tp##_sqrt(xb.fld, &tstat);                                  \
-        xt.fld = tp##_div(tp##_one, xt.fld, &tstat);                         \
+        xt->fld = tp##_sqrt(xb->fld, &tstat);                                \
+        xt->fld = tp##_div(tp##_one, xt->fld, &tstat);                       \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
-            if (tp##_is_neg(xb.fld) && !tp##_is_zero(xb.fld)) {              \
+            if (tp##_is_neg(xb->fld) && !tp##_is_zero(xb->fld)) {            \
                 float_invalid_op_vxsqrt(env, sfprf, GETPC());                \
-            } else if (tp##_is_signaling_nan(xb.fld, &tstat)) {              \
+            } else if (tp##_is_signaling_nan(xb->fld, &tstat)) {             \
                 float_invalid_op_vxsnan(env, GETPC());                       \
             }                                                                \
         }                                                                    \
                                                                              \
         if (r2sp) {                                                          \
-            xt.fld = helper_frsp(env, xt.fld);                               \
+            xt->fld = helper_frsp(env, xt->fld);                             \
         }                                                                    \
                                                                              \
         if (sfprf) {                                                         \
-            helper_compute_fprf_float64(env, xt.fld);                        \
+            helper_compute_fprf_float64(env, xt->fld);                       \
         }                                                                    \
     }                                                                        \
                                                                              \
-    putVSR(xT(opcode), &xt, env);                                            \
     do_float_check_status(env, GETPC());                                     \
 }
 
@@ -2195,37 +2175,35 @@ VSX_RSQRTE(xvrsqrtesp, 4, float32, VsrW(i), 0, 0)
 #define VSX_TDIV(op, nels, tp, fld, emin, emax, nbits)                  \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
 {                                                                       \
-    ppc_vsr_t xa, xb;                                                   \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                              \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
     int fe_flag = 0;                                                    \
     int fg_flag = 0;                                                    \
                                                                         \
-    getVSR(xA(opcode), &xa, env);                                       \
-    getVSR(xB(opcode), &xb, env);                                       \
-                                                                        \
     for (i = 0; i < nels; i++) {                                        \
-        if (unlikely(tp##_is_infinity(xa.fld) ||                        \
-                     tp##_is_infinity(xb.fld) ||                        \
-                     tp##_is_zero(xb.fld))) {                           \
+        if (unlikely(tp##_is_infinity(xa->fld) ||                       \
+                     tp##_is_infinity(xb->fld) ||                       \
+                     tp##_is_zero(xb->fld))) {                          \
             fe_flag = 1;                                                \
             fg_flag = 1;                                                \
         } else {                                                        \
-            int e_a = ppc_##tp##_get_unbiased_exp(xa.fld);              \
-            int e_b = ppc_##tp##_get_unbiased_exp(xb.fld);              \
+            int e_a = ppc_##tp##_get_unbiased_exp(xa->fld);             \
+            int e_b = ppc_##tp##_get_unbiased_exp(xb->fld);             \
                                                                         \
-            if (unlikely(tp##_is_any_nan(xa.fld) ||                     \
-                         tp##_is_any_nan(xb.fld))) {                    \
+            if (unlikely(tp##_is_any_nan(xa->fld) ||                    \
+                         tp##_is_any_nan(xb->fld))) {                   \
                 fe_flag = 1;                                            \
             } else if ((e_b <= emin) || (e_b >= (emax - 2))) {          \
                 fe_flag = 1;                                            \
-            } else if (!tp##_is_zero(xa.fld) &&                         \
+            } else if (!tp##_is_zero(xa->fld) &&                        \
                        (((e_a - e_b) >= emax) ||                        \
                         ((e_a - e_b) <= (emin + 1)) ||                  \
                         (e_a <= (emin + nbits)))) {                     \
                 fe_flag = 1;                                            \
             }                                                           \
                                                                         \
-            if (unlikely(tp##_is_zero_or_denormal(xb.fld))) {           \
+            if (unlikely(tp##_is_zero_or_denormal(xb->fld))) {          \
                 /*                                                      \
                  * XB is not zero because of the above check and so     \
                  * must be denormalized.                                \
@@ -2255,34 +2233,31 @@ VSX_TDIV(xvtdivsp, 4, float32, VsrW(i), -126, 127, 23)
 #define VSX_TSQRT(op, nels, tp, fld, emin, nbits)                       \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
 {                                                                       \
-    ppc_vsr_t xa, xb;                                                   \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
     int fe_flag = 0;                                                    \
     int fg_flag = 0;                                                    \
                                                                         \
-    getVSR(xA(opcode), &xa, env);                                       \
-    getVSR(xB(opcode), &xb, env);                                       \
-                                                                        \
     for (i = 0; i < nels; i++) {                                        \
-        if (unlikely(tp##_is_infinity(xb.fld) ||                        \
-                     tp##_is_zero(xb.fld))) {                           \
+        if (unlikely(tp##_is_infinity(xb->fld) ||                       \
+                     tp##_is_zero(xb->fld))) {                          \
             fe_flag = 1;                                                \
             fg_flag = 1;                                                \
         } else {                                                        \
-            int e_b = ppc_##tp##_get_unbiased_exp(xb.fld);              \
+            int e_b = ppc_##tp##_get_unbiased_exp(xb->fld);             \
                                                                         \
-            if (unlikely(tp##_is_any_nan(xb.fld))) {                    \
+            if (unlikely(tp##_is_any_nan(xb->fld))) {                   \
                 fe_flag = 1;                                            \
-            } else if (unlikely(tp##_is_zero(xb.fld))) {                \
+            } else if (unlikely(tp##_is_zero(xb->fld))) {               \
                 fe_flag = 1;                                            \
-            } else if (unlikely(tp##_is_neg(xb.fld))) {                 \
+            } else if (unlikely(tp##_is_neg(xb->fld))) {                \
                 fe_flag = 1;                                            \
-            } else if (!tp##_is_zero(xb.fld) &&                         \
+            } else if (!tp##_is_zero(xb->fld) &&                        \
                        (e_b <= (emin + nbits))) {                       \
                 fe_flag = 1;                                            \
             }                                                           \
                                                                         \
-            if (unlikely(tp##_is_zero_or_denormal(xb.fld))) {           \
+            if (unlikely(tp##_is_zero_or_denormal(xb->fld))) {          \
                 /*                                                      \
                  * XB is not zero because of the above check and        \
                  * therefore must be denormalized.                      \
@@ -2313,24 +2288,20 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 23)
 #define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)              \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
 {                                                                             \
-    ppc_vsr_t xt_in, xa, xb, xt_out;                                          \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     ppc_vsr_t *b, *c;                                                         \
     int i;                                                                    \
                                                                               \
     if (afrm) { /* AxB + T */                                                 \
-        b = &xb;                                                              \
-        c = &xt_in;                                                           \
+        b = xb;                                                               \
+        c = xt;                                                               \
     } else { /* AxT + B */                                                    \
-        b = &xt_in;                                                           \
-        c = &xb;                                                              \
+        b = xt;                                                               \
+        c = xb;                                                               \
     }                                                                         \
                                                                               \
-    getVSR(xA(opcode), &xa, env);                                             \
-    getVSR(xB(opcode), &xb, env);                                             \
-    getVSR(xT(opcode), &xt_in, env);                                          \
-                                                                              \
-    xt_out = xt_in;                                                           \
-                                                                              \
     helper_reset_fpstatus(env);                                               \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
@@ -2342,30 +2313,29 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
              * result to odd.                                                 \
              */                                                               \
             set_float_rounding_mode(float_round_to_zero, &tstat);             \
-            xt_out.fld = tp##_muladd(xa.fld, b->fld, c->fld,                  \
-                                       maddflgs, &tstat);                     \
-            xt_out.fld |= (get_float_exception_flags(&tstat) &                \
+            xt->fld = tp##_muladd(xa->fld, b->fld, c->fld,                    \
+                                  maddflgs, &tstat);                          \
+            xt->fld |= (get_float_exception_flags(&tstat) &                   \
                               float_flag_inexact) != 0;                       \
         } else {                                                              \
-            xt_out.fld = tp##_muladd(xa.fld, b->fld, c->fld,                  \
-                                        maddflgs, &tstat);                    \
+            xt->fld = tp##_muladd(xa->fld, b->fld, c->fld,                    \
+                                  maddflgs, &tstat);                          \
         }                                                                     \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags;  \
                                                                               \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {     \
-            tp##_maddsub_update_excp(env, xa.fld, b->fld,                     \
+            tp##_maddsub_update_excp(env, xa->fld, b->fld,                    \
                                      c->fld, maddflgs, GETPC());              \
         }                                                                     \
                                                                               \
         if (r2sp) {                                                           \
-            xt_out.fld = helper_frsp(env, xt_out.fld);                        \
+            xt->fld = helper_frsp(env, xt->fld);                              \
         }                                                                     \
                                                                               \
         if (sfprf) {                                                          \
-            helper_compute_fprf_float64(env, xt_out.fld);                     \
+            helper_compute_fprf_float64(env, xt->fld);                        \
         }                                                                     \
     }                                                                         \
-    putVSR(xT(opcode), &xt_out, env);                                         \
     do_float_check_status(env, GETPC());                                      \
 }
 
@@ -2415,22 +2385,20 @@ VSX_MADD(xvnmsubmsp, 4, float32, VsrW(i), NMSUB_FLGS, 0, 0, 0)
 #define VSX_SCALAR_CMP_DP(op, cmp, exp, svxvc)                                \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
 {                                                                             \
-    ppc_vsr_t xt, xa, xb;                                                     \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     bool vxsnan_flag = false, vxvc_flag = false, vex_flag = false;            \
                                                                               \
-    getVSR(xA(opcode), &xa, env);                                             \
-    getVSR(xB(opcode), &xb, env);                                             \
-    getVSR(xT(opcode), &xt, env);                                             \
-                                                                              \
-    if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||              \
-        float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {              \
+    if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||             \
+        float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {             \
         vxsnan_flag = true;                                                   \
         if (fpscr_ve == 0 && svxvc) {                                         \
             vxvc_flag = true;                                                 \
         }                                                                     \
     } else if (svxvc) {                                                       \
-        vxvc_flag = float64_is_quiet_nan(xa.VsrD(0), &env->fp_status) ||      \
-            float64_is_quiet_nan(xb.VsrD(0), &env->fp_status);                \
+        vxvc_flag = float64_is_quiet_nan(xa->VsrD(0), &env->fp_status) ||     \
+            float64_is_quiet_nan(xb->VsrD(0), &env->fp_status);               \
     }                                                                         \
     if (vxsnan_flag) {                                                        \
         float_invalid_op_vxsnan(env, GETPC());                                \
@@ -2441,15 +2409,15 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                           \
     vex_flag = fpscr_ve && (vxvc_flag || vxsnan_flag);                        \
                                                                               \
     if (!vex_flag) {                                                          \
-        if (float64_##cmp(xb.VsrD(0), xa.VsrD(0), &env->fp_status) == exp) {  \
-            xt.VsrD(0) = -1;                                                  \
-            xt.VsrD(1) = 0;                                                   \
+        if (float64_##cmp(xb->VsrD(0), xa->VsrD(0),                           \
+                          &env->fp_status) == exp) {                          \
+            xt->VsrD(0) = -1;                                                 \
+            xt->VsrD(1) = 0;                                                  \
         } else {                                                              \
-            xt.VsrD(0) = 0;                                                   \
-            xt.VsrD(1) = 0;                                                   \
+            xt->VsrD(0) = 0;                                                  \
+            xt->VsrD(1) = 0;                                                  \
         }                                                                     \
     }                                                                         \
-    putVSR(xT(opcode), &xt, env);                                             \
     do_float_check_status(env, GETPC());                                      \
 }
 
@@ -2460,18 +2428,16 @@ VSX_SCALAR_CMP_DP(xscmpnedp, eq, 0, 0)
 
 void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xa, xb;
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     int64_t exp_a, exp_b;
     uint32_t cc;
 
-    getVSR(xA(opcode), &xa, env);
-    getVSR(xB(opcode), &xb, env);
-
-    exp_a = extract64(xa.VsrD(0), 52, 11);
-    exp_b = extract64(xb.VsrD(0), 52, 11);
+    exp_a = extract64(xa->VsrD(0), 52, 11);
+    exp_b = extract64(xb->VsrD(0), 52, 11);
 
-    if (unlikely(float64_is_any_nan(xa.VsrD(0)) ||
-                 float64_is_any_nan(xb.VsrD(0)))) {
+    if (unlikely(float64_is_any_nan(xa->VsrD(0)) ||
+                 float64_is_any_nan(xb->VsrD(0)))) {
         cc = CRF_SO;
     } else {
         if (exp_a < exp_b) {
@@ -2492,18 +2458,16 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
 
 void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xa, xb;
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     int64_t exp_a, exp_b;
     uint32_t cc;
 
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
+    exp_a = extract64(xa->VsrD(0), 48, 15);
+    exp_b = extract64(xb->VsrD(0), 48, 15);
 
-    exp_a = extract64(xa.VsrD(0), 48, 15);
-    exp_b = extract64(xb.VsrD(0), 48, 15);
-
-    if (unlikely(float128_is_any_nan(xa.f128) ||
-                 float128_is_any_nan(xb.f128))) {
+    if (unlikely(float128_is_any_nan(xa->f128) ||
+                 float128_is_any_nan(xb->f128))) {
         cc = CRF_SO;
     } else {
         if (exp_a < exp_b) {
@@ -2525,23 +2489,22 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
 #define VSX_SCALAR_CMP(op, ordered)                                      \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
 {                                                                        \
-    ppc_vsr_t xa, xb;                                                    \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                               \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                               \
     uint32_t cc = 0;                                                     \
     bool vxsnan_flag = false, vxvc_flag = false;                         \
                                                                          \
     helper_reset_fpstatus(env);                                          \
-    getVSR(xA(opcode), &xa, env);                                        \
-    getVSR(xB(opcode), &xb, env);                                        \
                                                                          \
-    if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||         \
-        float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {         \
+    if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||        \
+        float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {        \
         vxsnan_flag = true;                                              \
         cc = CRF_SO;                                                     \
         if (fpscr_ve == 0 && ordered) {                                  \
             vxvc_flag = true;                                            \
         }                                                                \
-    } else if (float64_is_quiet_nan(xa.VsrD(0), &env->fp_status) ||      \
-               float64_is_quiet_nan(xb.VsrD(0), &env->fp_status)) {      \
+    } else if (float64_is_quiet_nan(xa->VsrD(0), &env->fp_status) ||     \
+               float64_is_quiet_nan(xb->VsrD(0), &env->fp_status)) {     \
         cc = CRF_SO;                                                     \
         if (ordered) {                                                   \
             vxvc_flag = true;                                            \
@@ -2554,9 +2517,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                      \
         float_invalid_op_vxvc(env, 0, GETPC());                          \
     }                                                                    \
                                                                          \
-    if (float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {           \
+    if (float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) {         \
         cc |= CRF_LT;                                                    \
-    } else if (!float64_le(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {   \
+    } else if (!float64_le(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) { \
         cc |= CRF_GT;                                                    \
     } else {                                                             \
         cc |= CRF_EQ;                                                    \
@@ -2575,23 +2538,22 @@ VSX_SCALAR_CMP(xscmpudp, 0)
 #define VSX_SCALAR_CMPQ(op, ordered)                                    \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
 {                                                                       \
-    ppc_vsr_t xa, xb;                                                   \
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];                         \
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                         \
     uint32_t cc = 0;                                                    \
     bool vxsnan_flag = false, vxvc_flag = false;                        \
                                                                         \
     helper_reset_fpstatus(env);                                         \
-    getVSR(rA(opcode) + 32, &xa, env);                                  \
-    getVSR(rB(opcode) + 32, &xb, env);                                  \
                                                                         \
-    if (float128_is_signaling_nan(xa.f128, &env->fp_status) ||          \
-        float128_is_signaling_nan(xb.f128, &env->fp_status)) {          \
+    if (float128_is_signaling_nan(xa->f128, &env->fp_status) ||         \
+        float128_is_signaling_nan(xb->f128, &env->fp_status)) {         \
         vxsnan_flag = true;                                             \
         cc = CRF_SO;                                                    \
         if (fpscr_ve == 0 && ordered) {                                 \
             vxvc_flag = true;                                           \
         }                                                               \
-    } else if (float128_is_quiet_nan(xa.f128, &env->fp_status) ||       \
-               float128_is_quiet_nan(xb.f128, &env->fp_status)) {       \
+    } else if (float128_is_quiet_nan(xa->f128, &env->fp_status) ||      \
+               float128_is_quiet_nan(xb->f128, &env->fp_status)) {      \
         cc = CRF_SO;                                                    \
         if (ordered) {                                                  \
             vxvc_flag = true;                                           \
@@ -2604,9 +2566,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
         float_invalid_op_vxvc(env, 0, GETPC());                         \
     }                                                                   \
                                                                         \
-    if (float128_lt(xa.f128, xb.f128, &env->fp_status)) {               \
+    if (float128_lt(xa->f128, xb->f128, &env->fp_status)) {             \
         cc |= CRF_LT;                                                   \
-    } else if (!float128_le(xa.f128, xb.f128, &env->fp_status)) {       \
+    } else if (!float128_le(xa->f128, xb->f128, &env->fp_status)) {     \
         cc |= CRF_GT;                                                   \
     } else {                                                            \
         cc |= CRF_EQ;                                                   \
@@ -2633,22 +2595,19 @@ VSX_SCALAR_CMPQ(xscmpuqp, 0)
 #define VSX_MAX_MIN(name, op, nels, tp, fld)                                  \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
 {                                                                             \
-    ppc_vsr_t xt, xa, xb;                                                     \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                    \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                    \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                    \
     int i;                                                                    \
                                                                               \
-    getVSR(xA(opcode), &xa, env);                                             \
-    getVSR(xB(opcode), &xb, env);                                             \
-    getVSR(xT(opcode), &xt, env);                                             \
-                                                                              \
     for (i = 0; i < nels; i++) {                                              \
-        xt.fld = tp##_##op(xa.fld, xb.fld, &env->fp_status);                  \
-        if (unlikely(tp##_is_signaling_nan(xa.fld, &env->fp_status) ||        \
-                     tp##_is_signaling_nan(xb.fld, &env->fp_status))) {       \
+        xt->fld = tp##_##op(xa->fld, xb->fld, &env->fp_status);               \
+        if (unlikely(tp##_is_signaling_nan(xa->fld, &env->fp_status) ||       \
+                     tp##_is_signaling_nan(xb->fld, &env->fp_status))) {      \
             float_invalid_op_vxsnan(env, GETPC());                            \
         }                                                                     \
     }                                                                         \
                                                                               \
-    putVSR(xT(opcode), &xt, env);                                             \
     do_float_check_status(env, GETPC());                                      \
 }
 
@@ -2662,27 +2621,26 @@ VSX_MAX_MIN(xvminsp, minnum, 4, float32, VsrW(i))
 #define VSX_MAX_MINC(name, max)                                               \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
 {                                                                             \
-    ppc_vsr_t xt, xa, xb;                                                     \
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                               \
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];                               \
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                               \
+    ppc_vsr_t r;                                                              \
     bool vxsnan_flag = false, vex_flag = false;                               \
                                                                               \
-    getVSR(rA(opcode) + 32, &xa, env);                                        \
-    getVSR(rB(opcode) + 32, &xb, env);                                        \
-    getVSR(rD(opcode) + 32, &xt, env);                                        \
-                                                                              \
-    if (unlikely(float64_is_any_nan(xa.VsrD(0)) ||                            \
-                 float64_is_any_nan(xb.VsrD(0)))) {                           \
-        if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||          \
-            float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {          \
+    if (unlikely(float64_is_any_nan(xa->VsrD(0)) ||                           \
+                 float64_is_any_nan(xb->VsrD(0)))) {                          \
+        if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||         \
+            float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {         \
             vxsnan_flag = true;                                               \
         }                                                                     \
-        xt.VsrD(0) = xb.VsrD(0);                                              \
+        r.VsrD(0) = xb->VsrD(0);                                              \
     } else if ((max &&                                                        \
-               !float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) ||       \
+               !float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) ||     \
                (!max &&                                                       \
-               float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status))) {        \
-        xt.VsrD(0) = xa.VsrD(0);                                              \
+               float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status))) {      \
+        r.VsrD(0) = xa->VsrD(0);                                              \
     } else {                                                                  \
-        xt.VsrD(0) = xb.VsrD(0);                                              \
+        r.VsrD(0) = xb->VsrD(0);                                              \
     }                                                                         \
                                                                               \
     vex_flag = fpscr_ve & vxsnan_flag;                                        \
@@ -2690,7 +2648,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
         float_invalid_op_vxsnan(env, GETPC());                                \
     }                                                                         \
     if (!vex_flag) {                                                          \
-        putVSR(rD(opcode) + 32, &xt, env);                                    \
+        memcpy(xt, &r, sizeof(ppc_vsr_t));                                    \
     }                                                                         \
 }                                                                             \
 
@@ -2700,44 +2658,46 @@ VSX_MAX_MINC(xsmincdp, 0);
 #define VSX_MAX_MINJ(name, max)                                               \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
 {                                                                             \
-    ppc_vsr_t xt, xa, xb;                                                     \
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                               \
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];                               \
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                               \
+    ppc_vsr_t r;                                                              \
     bool vxsnan_flag = false, vex_flag = false;                               \
                                                                               \
-    getVSR(rA(opcode) + 32, &xa, env);                                        \
-    getVSR(rB(opcode) + 32, &xb, env);                                        \
-    getVSR(rD(opcode) + 32, &xt, env);                                        \
-                                                                              \
-    if (unlikely(float64_is_any_nan(xa.VsrD(0)))) {                           \
-        if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status)) {          \
+    if (unlikely(float64_is_any_nan(xa->VsrD(0)))) {                          \
+        if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status)) {         \
             vxsnan_flag = true;                                               \
         }                                                                     \
-        xt.VsrD(0) = xa.VsrD(0);                                              \
-    } else if (unlikely(float64_is_any_nan(xb.VsrD(0)))) {                    \
-        if (float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {          \
+        r.VsrD(0) = xa->VsrD(0);                                              \
+    } else if (unlikely(float64_is_any_nan(xb->VsrD(0)))) {                   \
+        if (float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {         \
             vxsnan_flag = true;                                               \
         }                                                                     \
-        xt.VsrD(0) = xb.VsrD(0);                                              \
-    } else if (float64_is_zero(xa.VsrD(0)) && float64_is_zero(xb.VsrD(0))) {  \
+        r.VsrD(0) = xb->VsrD(0);                                              \
+    } else if (float64_is_zero(xa->VsrD(0)) &&                                \
+               float64_is_zero(xb->VsrD(0))) {                                \
         if (max) {                                                            \
-            if (!float64_is_neg(xa.VsrD(0)) || !float64_is_neg(xb.VsrD(0))) { \
-                xt.VsrD(0) = 0ULL;                                            \
+            if (!float64_is_neg(xa->VsrD(0)) ||                               \
+                !float64_is_neg(xb->VsrD(0))) {                               \
+                r.VsrD(0) = 0ULL;                                             \
             } else {                                                          \
-                xt.VsrD(0) = 0x8000000000000000ULL;                           \
+                r.VsrD(0) = 0x8000000000000000ULL;                            \
             }                                                                 \
         } else {                                                              \
-            if (float64_is_neg(xa.VsrD(0)) || float64_is_neg(xb.VsrD(0))) {   \
-                xt.VsrD(0) = 0x8000000000000000ULL;                           \
+            if (float64_is_neg(xa->VsrD(0)) ||                                \
+                float64_is_neg(xb->VsrD(0))) {                                \
+                r.VsrD(0) = 0x8000000000000000ULL;                            \
             } else {                                                          \
-                xt.VsrD(0) = 0ULL;                                            \
+                r.VsrD(0) = 0ULL;                                             \
             }                                                                 \
         }                                                                     \
     } else if ((max &&                                                        \
-               !float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) ||       \
+               !float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) ||     \
                (!max &&                                                       \
-               float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status))) {        \
-        xt.VsrD(0) = xa.VsrD(0);                                              \
+               float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status))) {      \
+        r.VsrD(0) = xa->VsrD(0);                                              \
     } else {                                                                  \
-        xt.VsrD(0) = xb.VsrD(0);                                              \
+        r.VsrD(0) = xb->VsrD(0);                                              \
     }                                                                         \
                                                                               \
     vex_flag = fpscr_ve & vxsnan_flag;                                        \
@@ -2745,7 +2705,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcode)                         \
         float_invalid_op_vxsnan(env, GETPC());                                \
     }                                                                         \
     if (!vex_flag) {                                                          \
-        putVSR(rD(opcode) + 32, &xt, env);                                    \
+        memcpy(xt, &r, sizeof(ppc_vsr_t));                                    \
     }                                                                         \
 }                                                                             \
 
@@ -2765,39 +2725,36 @@ VSX_MAX_MINJ(xsminjdp, 0);
 #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                       \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
 {                                                                         \
-    ppc_vsr_t xt, xa, xb;                                                 \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                \
     int i;                                                                \
     int all_true = 1;                                                     \
     int all_false = 1;                                                    \
                                                                           \
-    getVSR(xA(opcode), &xa, env);                                         \
-    getVSR(xB(opcode), &xb, env);                                         \
-    getVSR(xT(opcode), &xt, env);                                         \
-                                                                          \
     for (i = 0; i < nels; i++) {                                          \
-        if (unlikely(tp##_is_any_nan(xa.fld) ||                           \
-                     tp##_is_any_nan(xb.fld))) {                          \
-            if (tp##_is_signaling_nan(xa.fld, &env->fp_status) ||         \
-                tp##_is_signaling_nan(xb.fld, &env->fp_status)) {         \
+        if (unlikely(tp##_is_any_nan(xa->fld) ||                          \
+                     tp##_is_any_nan(xb->fld))) {                         \
+            if (tp##_is_signaling_nan(xa->fld, &env->fp_status) ||        \
+                tp##_is_signaling_nan(xb->fld, &env->fp_status)) {        \
                 float_invalid_op_vxsnan(env, GETPC());                    \
             }                                                             \
             if (svxvc) {                                                  \
                 float_invalid_op_vxvc(env, 0, GETPC());                   \
             }                                                             \
-            xt.fld = 0;                                                   \
+            xt->fld = 0;                                                  \
             all_true = 0;                                                 \
         } else {                                                          \
-            if (tp##_##cmp(xb.fld, xa.fld, &env->fp_status) == exp) {     \
-                xt.fld = -1;                                              \
+            if (tp##_##cmp(xb->fld, xa->fld, &env->fp_status) == exp) {   \
+                xt->fld = -1;                                             \
                 all_false = 0;                                            \
             } else {                                                      \
-                xt.fld = 0;                                               \
+                xt->fld = 0;                                              \
                 all_true = 0;                                             \
             }                                                             \
         }                                                                 \
     }                                                                     \
                                                                           \
-    putVSR(xT(opcode), &xt, env);                                         \
     if ((opcode >> (31 - 21)) & 1) {                                      \
         env->crf[6] = (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);       \
     }                                                                     \
@@ -2826,25 +2783,22 @@ VSX_CMP(xvcmpnesp, 4, float32, VsrW(i), eq, 0, 0)
 #define VSX_CVT_FP_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf)    \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                \
 {                                                                  \
-    ppc_vsr_t xt, xb;                                              \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                         \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                         \
     int i;                                                         \
                                                                    \
-    getVSR(xB(opcode), &xb, env);                                  \
-    getVSR(xT(opcode), &xt, env);                                  \
-                                                                   \
     for (i = 0; i < nels; i++) {                                   \
-        xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);        \
-        if (unlikely(stp##_is_signaling_nan(xb.sfld,               \
+        xt->tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);      \
+        if (unlikely(stp##_is_signaling_nan(xb->sfld,              \
                                             &env->fp_status))) {   \
             float_invalid_op_vxsnan(env, GETPC());                 \
-            xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
+            xt->tfld = ttp##_snan_to_qnan(xt->tfld);               \
         }                                                          \
         if (sfprf) {                                               \
-            helper_compute_fprf_##ttp(env, xt.tfld);               \
+            helper_compute_fprf_##ttp(env, xt->tfld);              \
         }                                                          \
     }                                                              \
                                                                    \
-    putVSR(xT(opcode), &xt, env);                                  \
     do_float_check_status(env, GETPC());                           \
 }
 
@@ -2866,25 +2820,22 @@ VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2 * i), VsrD(i), 0)
 #define VSX_CVT_FP_TO_FP_VECTOR(op, nels, stp, ttp, sfld, tfld, sfprf)    \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                       \
 {                                                                       \
-    ppc_vsr_t xt, xb;                                                   \
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                         \
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                         \
     int i;                                                              \
                                                                         \
-    getVSR(rB(opcode) + 32, &xb, env);                                  \
-    getVSR(rD(opcode) + 32, &xt, env);                                  \
-                                                                        \
     for (i = 0; i < nels; i++) {                                        \
-        xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);             \
-        if (unlikely(stp##_is_signaling_nan(xb.sfld,                    \
+        xt->tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);           \
+        if (unlikely(stp##_is_signaling_nan(xb->sfld,                   \
                                             &env->fp_status))) {        \
             float_invalid_op_vxsnan(env, GETPC());                      \
-            xt.tfld = ttp##_snan_to_qnan(xt.tfld);                      \
+            xt->tfld = ttp##_snan_to_qnan(xt->tfld);                    \
         }                                                               \
         if (sfprf) {                                                    \
-            helper_compute_fprf_##ttp(env, xt.tfld);                    \
+            helper_compute_fprf_##ttp(env, xt->tfld);                   \
         }                                                               \
     }                                                                   \
                                                                         \
-    putVSR(rD(opcode) + 32, &xt, env);                                  \
     do_float_check_status(env, GETPC());                                \
 }
 
@@ -2904,25 +2855,24 @@ VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1)
 #define VSX_CVT_FP_TO_FP_HP(op, nels, stp, ttp, sfld, tfld, sfprf) \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                \
 {                                                                  \
-    ppc_vsr_t xt, xb;                                              \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                         \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                         \
     int i;                                                         \
                                                                    \
-    getVSR(xB(opcode), &xb, env);                                  \
-    memset(&xt, 0, sizeof(xt));                                    \
+    memset(xt, 0, sizeof(ppc_vsr_t));                              \
                                                                    \
     for (i = 0; i < nels; i++) {                                   \
-        xt.tfld = stp##_to_##ttp(xb.sfld, 1, &env->fp_status);     \
-        if (unlikely(stp##_is_signaling_nan(xb.sfld,               \
+        xt->tfld = stp##_to_##ttp(xb->sfld, 1, &env->fp_status);   \
+        if (unlikely(stp##_is_signaling_nan(xb->sfld,              \
                                             &env->fp_status))) {   \
             float_invalid_op_vxsnan(env, GETPC());                 \
-            xt.tfld = ttp##_snan_to_qnan(xt.tfld);                 \
+            xt->tfld = ttp##_snan_to_qnan(xt->tfld);               \
         }                                                          \
         if (sfprf) {                                               \
-            helper_compute_fprf_##ttp(env, xt.tfld);               \
+            helper_compute_fprf_##ttp(env, xt->tfld);              \
         }                                                          \
     }                                                              \
                                                                    \
-    putVSR(xT(opcode), &xt, env);                                  \
     do_float_check_status(env, GETPC());                           \
 }
 
@@ -2937,26 +2887,25 @@ VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32, VsrH(2 * i + 1), VsrW(i), 0)
  */
 void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     float_status tstat;
 
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
+    memset(xt, 0, sizeof(ppc_vsr_t));
 
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    xt.VsrD(0) = float128_to_float64(xb.f128, &tstat);
+    xt->VsrD(0) = float128_to_float64(xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
-    if (unlikely(float128_is_signaling_nan(xb.f128, &tstat))) {
+    if (unlikely(float128_is_signaling_nan(xb->f128, &tstat))) {
         float_invalid_op_vxsnan(env, GETPC());
-        xt.VsrD(0) = float64_snan_to_qnan(xt.VsrD(0));
+        xt->VsrD(0) = float64_snan_to_qnan(xt->VsrD(0));
     }
-    helper_compute_fprf_float64(env, xt.VsrD(0));
+    helper_compute_fprf_float64(env, xt->VsrD(0));
 
-    putVSR(rD(opcode) + 32, &xt, env);
     do_float_check_status(env, GETPC());
 }
 
@@ -2990,24 +2939,22 @@ uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
 void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
 {                                                                            \
     int all_flags = env->fp_status.float_exception_flags, flags;             \
-    ppc_vsr_t xt, xb;                                                        \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
     int i;                                                                   \
                                                                              \
-    getVSR(xB(opcode), &xb, env);                                            \
-    getVSR(xT(opcode), &xt, env);                                            \
-                                                                             \
     for (i = 0; i < nels; i++) {                                             \
         env->fp_status.float_exception_flags = 0;                            \
-        xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_status);  \
+        xt->tfld = stp##_to_##ttp##_round_to_zero(xb->sfld,                  \
+                                                  &env->fp_status);          \
         flags = env->fp_status.float_exception_flags;                        \
         if (unlikely(flags & float_flag_invalid)) {                          \
-            float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));     \
-            xt.tfld = rnan;                                                  \
+            float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb->sfld));    \
+            xt->tfld = rnan;                                                  \
         }                                                                    \
         all_flags |= flags;                                                  \
     }                                                                        \
                                                                              \
-    putVSR(xT(opcode), &xt, env);                                            \
     env->fp_status.float_exception_flags = all_flags;                        \
     do_float_check_status(env, GETPC());                                     \
 }
@@ -3042,18 +2989,17 @@ VSX_CVT_FP_TO_INT(xvcvspuxws, 4, float32, uint32, VsrW(i), VsrW(i), 0U)
 #define VSX_CVT_FP_TO_INT_VECTOR(op, stp, ttp, sfld, tfld, rnan)             \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
 {                                                                            \
-    ppc_vsr_t xt, xb;                                                        \
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                              \
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                              \
                                                                              \
-    getVSR(rB(opcode) + 32, &xb, env);                                       \
-    memset(&xt, 0, sizeof(xt));                                              \
+    memset(xt, 0, sizeof(ppc_vsr_t));                                        \
                                                                              \
-    xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_status);      \
+    xt->tfld = stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_status);    \
     if (env->fp_status.float_exception_flags & float_flag_invalid) {         \
-        float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));         \
-        xt.tfld = rnan;                                                      \
+        float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb->sfld));        \
+        xt->tfld = rnan;                                                     \
     }                                                                        \
                                                                              \
-    putVSR(rD(opcode) + 32, &xt, env);                                       \
     do_float_check_status(env, GETPC());                                     \
 }
 
@@ -3079,23 +3025,20 @@ VSX_CVT_FP_TO_INT_VECTOR(xscvqpuwz, float128, uint32, f128, VsrD(0), 0x0ULL)
 #define VSX_CVT_INT_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf, r2sp)  \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
 {                                                                       \
-    ppc_vsr_t xt, xb;                                                   \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                              \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
                                                                         \
-    getVSR(xB(opcode), &xb, env);                                       \
-    getVSR(xT(opcode), &xt, env);                                       \
-                                                                        \
     for (i = 0; i < nels; i++) {                                        \
-        xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);             \
+        xt->tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);           \
         if (r2sp) {                                                     \
-            xt.tfld = helper_frsp(env, xt.tfld);                        \
+            xt->tfld = helper_frsp(env, xt->tfld);                      \
         }                                                               \
         if (sfprf) {                                                    \
-            helper_compute_fprf_float64(env, xt.tfld);                  \
+            helper_compute_fprf_float64(env, xt->tfld);                 \
         }                                                               \
     }                                                                   \
                                                                         \
-    putVSR(xT(opcode), &xt, env);                                       \
     do_float_check_status(env, GETPC());                                \
 }
 
@@ -3123,15 +3066,12 @@ VSX_CVT_INT_TO_FP(xvcvuxwsp, 4, uint32, float32, VsrW(i), VsrW(i), 0, 0)
 #define VSX_CVT_INT_TO_FP_VECTOR(op, stp, ttp, sfld, tfld)              \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
 {                                                                       \
-    ppc_vsr_t xt, xb;                                                   \
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];                         \
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];                         \
                                                                         \
-    getVSR(rB(opcode) + 32, &xb, env);                                  \
-    getVSR(rD(opcode) + 32, &xt, env);                                  \
+    xt->tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);               \
+    helper_compute_fprf_##ttp(env, xt->tfld);                           \
                                                                         \
-    xt.tfld = stp##_to_##ttp(xb.sfld, &env->fp_status);                 \
-    helper_compute_fprf_##ttp(env, xt.tfld);                            \
-                                                                        \
-    putVSR(xT(opcode) + 32, &xt, env);                                  \
     do_float_check_status(env, GETPC());                                \
 }
 
@@ -3157,25 +3097,24 @@ VSX_CVT_INT_TO_FP_VECTOR(xscvudqp, uint64, float128, VsrD(0), f128)
 #define VSX_ROUND(op, nels, tp, fld, rmode, sfprf)                     \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
 {                                                                      \
-    ppc_vsr_t xt, xb;                                                  \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                             \
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                             \
     int i;                                                             \
-    getVSR(xB(opcode), &xb, env);                                      \
-    getVSR(xT(opcode), &xt, env);                                      \
                                                                        \
     if (rmode != FLOAT_ROUND_CURRENT) {                                \
         set_float_rounding_mode(rmode, &env->fp_status);               \
     }                                                                  \
                                                                        \
     for (i = 0; i < nels; i++) {                                       \
-        if (unlikely(tp##_is_signaling_nan(xb.fld,                     \
+        if (unlikely(tp##_is_signaling_nan(xb->fld,                    \
                                            &env->fp_status))) {        \
             float_invalid_op_vxsnan(env, GETPC());                     \
-            xt.fld = tp##_snan_to_qnan(xb.fld);                        \
+            xt->fld = tp##_snan_to_qnan(xb->fld);                      \
         } else {                                                       \
-            xt.fld = tp##_round_to_int(xb.fld, &env->fp_status);       \
+            xt->fld = tp##_round_to_int(xb->fld, &env->fp_status);     \
         }                                                              \
         if (sfprf) {                                                   \
-            helper_compute_fprf_float64(env, xt.fld);                  \
+            helper_compute_fprf_float64(env, xt->fld);                 \
         }                                                              \
     }                                                                  \
                                                                        \
@@ -3189,7 +3128,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
         env->fp_status.float_exception_flags &= ~float_flag_inexact;   \
     }                                                                  \
                                                                        \
-    putVSR(xT(opcode), &xt, env);                                      \
     do_float_check_status(env, GETPC());                               \
 }
 
@@ -3225,21 +3163,19 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
 #define VSX_XXPERM(op, indexed)                                       \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                   \
 {                                                                     \
-    ppc_vsr_t xt, xa, pcv, xto;                                       \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                            \
+    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                            \
+    ppc_vsr_t *pcv = &env->vsr[xB(opcode)];                           \
     int i, idx;                                                       \
                                                                       \
-    getVSR(xA(opcode), &xa, env);                                     \
-    getVSR(xT(opcode), &xt, env);                                     \
-    getVSR(xB(opcode), &pcv, env);                                    \
-                                                                      \
     for (i = 0; i < 16; i++) {                                        \
-        idx = pcv.VsrB(i) & 0x1F;                                     \
+        idx = pcv->VsrB(i) & 0x1F;                                    \
         if (indexed) {                                                \
             idx = 31 - idx;                                           \
         }                                                             \
-        xto.VsrB(i) = (idx <= 15) ? xa.VsrB(idx) : xt.VsrB(idx - 16); \
+        xt->VsrB(i) = (idx <= 15) ? xa->VsrB(idx)                     \
+                                  : xt->VsrB(idx - 16);               \
     }                                                                 \
-    putVSR(xT(opcode), &xto, env);                                    \
 }
 
 VSX_XXPERM(xxperm, 0)
@@ -3247,22 +3183,21 @@ VSX_XXPERM(xxpermr, 1)
 
 void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     uint32_t exp, i, fraction;
 
-    getVSR(xB(opcode), &xb, env);
-    memset(&xt, 0, sizeof(xt));
+    memset(xt, 0, sizeof(ppc_vsr_t));
 
     for (i = 0; i < 4; i++) {
-        exp = (xb.VsrW(i) >> 23) & 0xFF;
-        fraction = xb.VsrW(i) & 0x7FFFFF;
+        exp = (xb->VsrW(i) >> 23) & 0xFF;
+        fraction = xb->VsrW(i) & 0x7FFFFF;
         if (exp != 0 && exp != 255) {
-            xt.VsrW(i) = fraction | 0x00800000;
+            xt->VsrW(i) = fraction | 0x00800000;
         } else {
-            xt.VsrW(i) = fraction;
+            xt->VsrW(i) = fraction;
         }
     }
-    putVSR(xT(opcode), &xt, env);
 }
 
 /*
@@ -3279,27 +3214,28 @@ void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
 #define VSX_TEST_DC(op, nels, xbn, tp, fld, tfld, fld_max, scrf)  \
 void helper_##op(CPUPPCState *env, uint32_t opcode)         \
 {                                                           \
-    ppc_vsr_t xt, xb;                                       \
+    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                  \
+    ppc_vsr_t *xb = &env->vsr[xbn];                         \
+    ppc_vsr_t r;                                            \
     uint32_t i, sign, dcmx;                                 \
     uint32_t cc, match = 0;                                 \
                                                             \
-    getVSR(xbn, &xb, env);                                  \
     if (!scrf) {                                            \
-        memset(&xt, 0, sizeof(xt));                         \
+        memset(xt, 0, sizeof(ppc_vsr_t));                   \
         dcmx = DCMX_XV(opcode);                             \
     } else {                                                \
         dcmx = DCMX(opcode);                                \
     }                                                       \
                                                             \
     for (i = 0; i < nels; i++) {                            \
-        sign = tp##_is_neg(xb.fld);                         \
-        if (tp##_is_any_nan(xb.fld)) {                      \
+        sign = tp##_is_neg(xb->fld);                        \
+        if (tp##_is_any_nan(xb->fld)) {                     \
             match = extract32(dcmx, 6, 1);                  \
-        } else if (tp##_is_infinity(xb.fld)) {              \
+        } else if (tp##_is_infinity(xb->fld)) {             \
             match = extract32(dcmx, 4 + !sign, 1);          \
-        } else if (tp##_is_zero(xb.fld)) {                  \
+        } else if (tp##_is_zero(xb->fld)) {                 \
             match = extract32(dcmx, 2 + !sign, 1);          \
-        } else if (tp##_is_zero_or_denormal(xb.fld)) {      \
+        } else if (tp##_is_zero_or_denormal(xb->fld)) {     \
             match = extract32(dcmx, 0 + !sign, 1);          \
         }                                                   \
                                                             \
@@ -3309,12 +3245,12 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)         \
             env->fpscr |= cc << FPSCR_FPRF;                 \
             env->crf[BF(opcode)] = cc;                      \
         } else {                                            \
-            xt.tfld = match ? fld_max : 0;                  \
+            r.tfld = match ? fld_max : 0;                   \
         }                                                   \
         match = 0;                                          \
     }                                                       \
     if (!scrf) {                                            \
-        putVSR(xT(opcode), &xt, env);                       \
+        memcpy(xt, &r, sizeof(ppc_vsr_t));                  \
     }                                                       \
 }
 
@@ -3325,29 +3261,28 @@ VSX_TEST_DC(xststdcqp, 1, (rB(opcode) + 32), float128, f128, VsrD(0), 0, 1)
 
 void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
+    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     uint32_t dcmx, sign, exp;
     uint32_t cc, match = 0, not_sp = 0;
 
-    getVSR(xB(opcode), &xb, env);
     dcmx = DCMX(opcode);
-    exp = (xb.VsrD(0) >> 52) & 0x7FF;
+    exp = (xb->VsrD(0) >> 52) & 0x7FF;
 
-    sign = float64_is_neg(xb.VsrD(0));
-    if (float64_is_any_nan(xb.VsrD(0))) {
+    sign = float64_is_neg(xb->VsrD(0));
+    if (float64_is_any_nan(xb->VsrD(0))) {
         match = extract32(dcmx, 6, 1);
-    } else if (float64_is_infinity(xb.VsrD(0))) {
+    } else if (float64_is_infinity(xb->VsrD(0))) {
         match = extract32(dcmx, 4 + !sign, 1);
-    } else if (float64_is_zero(xb.VsrD(0))) {
+    } else if (float64_is_zero(xb->VsrD(0))) {
         match = extract32(dcmx, 2 + !sign, 1);
-    } else if (float64_is_zero_or_denormal(xb.VsrD(0)) ||
+    } else if (float64_is_zero_or_denormal(xb->VsrD(0)) ||
                (exp > 0 && exp < 0x381)) {
         match = extract32(dcmx, 0 + !sign, 1);
     }
 
-    not_sp = !float64_eq(xb.VsrD(0),
+    not_sp = !float64_eq(xb->VsrD(0),
                          float32_to_float64(
-                             float64_to_float32(xb.VsrD(0), &env->fp_status),
+                             float64_to_float32(xb->VsrD(0), &env->fp_status),
                              &env->fp_status), &env->fp_status);
 
     cc = sign << CRF_LT_BIT | match << CRF_EQ_BIT | not_sp << CRF_SO_BIT;
@@ -3358,16 +3293,15 @@ void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
 
 void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
-    ppc_vsr_t xt;
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     uint8_t r = Rrm(opcode);
     uint8_t ex = Rc(opcode);
     uint8_t rmc = RMC(opcode);
     uint8_t rmode = 0;
     float_status tstat;
 
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
+    memset(xt, 0, sizeof(ppc_vsr_t));
     helper_reset_fpstatus(env);
 
     if (r == 0 && rmc == 0) {
@@ -3396,13 +3330,13 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
     tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
     set_float_rounding_mode(rmode, &tstat);
-    xt.f128 = float128_round_to_int(xb.f128, &tstat);
+    xt->f128 = float128_round_to_int(xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+        if (float128_is_signaling_nan(xb->f128, &tstat)) {
             float_invalid_op_vxsnan(env, GETPC());
-            xt.f128 = float128_snan_to_qnan(xt.f128);
+            xt->f128 = float128_snan_to_qnan(xt->f128);
         }
     }
 
@@ -3410,23 +3344,21 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
         env->fp_status.float_exception_flags &= ~float_flag_inexact;
     }
 
-    helper_compute_fprf_float128(env, xt.f128);
+    helper_compute_fprf_float128(env, xt->f128);
     do_float_check_status(env, GETPC());
-    putVSR(rD(opcode) + 32, &xt, env);
 }
 
 void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
-    ppc_vsr_t xt;
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     uint8_t r = Rrm(opcode);
     uint8_t rmc = RMC(opcode);
     uint8_t rmode = 0;
     floatx80 round_res;
     float_status tstat;
 
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
+    memset(xt, 0, sizeof(ppc_vsr_t));
     helper_reset_fpstatus(env);
 
     if (r == 0 && rmc == 0) {
@@ -3455,30 +3387,28 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
     tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
     set_float_rounding_mode(rmode, &tstat);
-    round_res = float128_to_floatx80(xb.f128, &tstat);
-    xt.f128 = floatx80_to_float128(round_res, &tstat);
+    round_res = float128_to_floatx80(xb->f128, &tstat);
+    xt->f128 = floatx80_to_float128(round_res, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+        if (float128_is_signaling_nan(xb->f128, &tstat)) {
             float_invalid_op_vxsnan(env, GETPC());
-            xt.f128 = float128_snan_to_qnan(xt.f128);
+            xt->f128 = float128_snan_to_qnan(xt->f128);
         }
     }
 
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, xt->f128);
     do_float_check_status(env, GETPC());
 }
 
 void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
-    ppc_vsr_t xt;
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
+    memset(xt, 0, sizeof(ppc_vsr_t));
     helper_reset_fpstatus(env);
 
     tstat = env->fp_status;
@@ -3487,34 +3417,32 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
     }
 
     set_float_exception_flags(0, &tstat);
-    xt.f128 = float128_sqrt(xb.f128, &tstat);
+    xt->f128 = float128_sqrt(xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+        if (float128_is_signaling_nan(xb->f128, &tstat)) {
             float_invalid_op_vxsnan(env, GETPC());
-            xt.f128 = float128_snan_to_qnan(xb.f128);
-        } else if  (float128_is_quiet_nan(xb.f128, &tstat)) {
-            xt.f128 = xb.f128;
-        } else if (float128_is_neg(xb.f128) && !float128_is_zero(xb.f128)) {
+            xt->f128 = float128_snan_to_qnan(xb->f128);
+        } else if (float128_is_quiet_nan(xb->f128, &tstat)) {
+            xt->f128 = xb->f128;
+        } else if (float128_is_neg(xb->f128) && !float128_is_zero(xb->f128)) {
             float_invalid_op_vxsqrt(env, 1, GETPC());
-            xt.f128 = float128_default_nan(&env->fp_status);
+            xt->f128 = float128_default_nan(&env->fp_status);
         }
     }
 
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, xt->f128);
     do_float_check_status(env, GETPC());
 }
 
 void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
     float_status tstat;
 
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
     helper_reset_fpstatus(env);
 
     tstat = env->fp_status;
@@ -3523,16 +3451,15 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
     }
 
     set_float_exception_flags(0, &tstat);
-    xt.f128 = float128_sub(xa.f128, xb.f128, &tstat);
+    xt->f128 = float128_sub(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_addsub(env, 1, GETPC(),
-                                float128_classify(xa.f128) |
-                                float128_classify(xb.f128));
+                                float128_classify(xa->f128) |
+                                float128_classify(xb->f128));
     }
 
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, xt->f128);
     do_float_check_status(env, GETPC());
 }
-- 
2.11.0
