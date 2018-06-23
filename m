Received: from eggs.gnu.org ([2001:4830:134:3::10]:50238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fWYCs-0006P9-1E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 22:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fWYCo-0000mq-1p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 22:23:18 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Fri, 22 Jun 2018 22:22:58 -0400
Message-Id: <20180623022258.22158-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

When the fdiv instruction divides a finite number by zero,
the result actually depends on the FPSCR[ZE] bit. If this
bit is set, the return value is zero. If it is not set
the result should be either positive or negative infinity.
The sign of this result would depend on the sign of the
two inputs. What currently happens is only infinity is
returned even if the FPSCR[ZE] bit is set. This patch
fixes this problem by actually checking the FPSCR[ZE] bit
when deciding what the answer should be.

fdiv is suppose to only set the FPSCR's FPRF bits during a
division by zero situation when the FPSCR[ZE] is not set.
What currently happens is these bits are always set. This
patch fixes this problem by checking the FPSCR[ZE] bit to
decide if the FPRF bits should be set. 

https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html
This document has the information on the fdiv. Page 133 has the information on what action is executed when a division by zero situation takes place. 

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 target/ppc/fpu_helper.c            | 16 ++++++++++++++++
 target/ppc/translate/fp-impl.inc.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 7714bfe0f9..de694604fb 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -658,6 +658,20 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
     } else if (unlikely(float64_is_zero(farg1.d) && float64_is_zero(farg2.d))) {
         /* Division of zero by zero */
         farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1);
+    } else if (arg2 == 0) {
+        /* Division by zero */
+        float_zero_divide_excp(env, GETPC());
+        if (fpscr_ze) { /* if zero divide exception is enabled */
+            farg1.ll = 0;
+        } else {
+            uint64_t sign = (farg1.ll ^ farg2.ll) >> 63;
+            if (sign) { /* Negative sign bit */
+                farg1.ll = 0xfff0000000000000; /* Negative Infinity */
+            } else { /* Positive sign bit */
+                farg1.ll = 0x7ff0000000000000; /* Positive Infinity */
+            }
+            helper_compute_fprf_float64(env, farg1.d);
+        }
     } else {
         if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) ||
                      float64_is_signaling_nan(farg2.d, &env->fp_status))) {
@@ -665,6 +679,8 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
         }
         farg1.d = float64_div(farg1.d, farg2.d, &env->fp_status);
+        helper_compute_fprf_float64(env, farg1.d);
+        helper_float_check_status(env);
     }
 
     return farg1.ll;
diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
index 2fbd4d4f38..4e20bcceb4 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -84,6 +84,32 @@ static void gen_f##name(DisasContext *ctx)                                    \
 _GEN_FLOAT_AB(name, name, 0x3F, op2, inval, 0, set_fprf, type);               \
 _GEN_FLOAT_AB(name##s, name, 0x3B, op2, inval, 1, set_fprf, type);
 
+
+#define _GEN_FLOAT_DIV(name, op, op1, op2, inval, isfloat, set_fprf, type)    \
+static void gen_f##name(DisasContext *ctx)                                    \
+{                                                                             \
+    if (unlikely(!ctx->fpu_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
+        return;                                                               \
+    }                                                                         \
+    gen_reset_fpstatus();                                                     \
+    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                       \
+                     cpu_fpr[rA(ctx->opcode)],                                \
+                     cpu_fpr[rB(ctx->opcode)]);                               \
+    if (isfloat) {                                                            \
+        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,                    \
+                        cpu_fpr[rD(ctx->opcode)]);                            \
+    }                                                                         \
+    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
+        gen_set_cr1_from_fpscr(ctx);                                          \
+    }                                                                         \
+}
+
+#define GEN_FLOAT_DIV(name, op2, inval, set_fprf, type)                       \
+_GEN_FLOAT_DIV(name, name, 0x3F, op2, inval, 0, set_fprf, type);              \
+_GEN_FLOAT_DIV(name##s, name, 0x3B, op2, inval, 1, set_fprf, type);
+
+
 #define _GEN_FLOAT_AC(name, op, op1, op2, inval, isfloat, set_fprf, type)     \
 static void gen_f##name(DisasContext *ctx)                                    \
 {                                                                             \
@@ -149,7 +175,7 @@ static void gen_f##name(DisasContext *ctx)                                    \
 /* fadd - fadds */
 GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT);
 /* fdiv - fdivs */
-GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
+GEN_FLOAT_DIV(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
 /* fmul - fmuls */
 GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT);
 
-- 
2.14.3 (Apple Git-98)
