Received: from eggs.gnu.org ([2001:4830:134:3::10]:56845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cj686-0002Lx-FL
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cj683-0003G1-7S
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:25:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cj683-0003Ft-0r
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:25:23 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21FOA0e006269
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 10:25:22 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wxr87vsn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 10:25:21 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 2 Mar 2017 01:25:18 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  1 Mar 2017 20:54:14 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1488381854-7275-1-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Use the softfloat api for fused multiply-add. Also, generate VXISI using
a helper function by computing intermediate result.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

---

v0:
* Use MADD/MSUB_FLAGS as used by VSX instructions
* Introduce helper float64_madd_set_vxisi()
---
 target/ppc/fpu_helper.c | 218 +++++++++++-------------------------------=
------
 1 file changed, 49 insertions(+), 169 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 58aee64..ed7e84a 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -743,178 +743,63 @@ uint64_t helper_frim(CPUPPCState *env, uint64_t ar=
g)
     return do_fri(env, arg, float_round_down);
 }
=20
-/* fmadd - fmadd. */
-uint64_t helper_fmadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                      uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll =3D arg1;
-    farg2.ll =3D arg2;
-    farg3.ll =3D arg3;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
-                 (float64_is_zero(farg1.d) && float64_is_infinity(farg2.=
d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) !=3D float64_is_neg(farg3.=
d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
-        } else {
-            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 =3D float128_add(ft0_128, ft1_128, &env->fp_status);
-            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
-        }
-    }
-
-    return farg1.ll;
-}
-
-/* fmsub - fmsub. */
-uint64_t helper_fmsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                      uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll =3D arg1;
-    farg2.ll =3D arg2;
-    farg3.ll =3D arg3;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
-                 (float64_is_zero(farg1.d) &&
-                  float64_is_infinity(farg2.d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) =3D=3D float64_is_neg(farg=
3.d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
-        } else {
-            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 =3D float128_sub(ft0_128, ft1_128, &env->fp_status);
-            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
-        }
-    }
-    return farg1.ll;
-}
+#define MADD_FLGS 0
+#define MSUB_FLGS float_muladd_negate_c
+#define NMADD_FLGS float_muladd_negate_result
+#define NMSUB_FLGS (float_muladd_negate_c | float_muladd_negate_result)
=20
-/* fnmadd - fnmadd. */
-uint64_t helper_fnmadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                       uint64_t arg3)
+static void float64_madd_set_vxisi(CPUPPCState *env, float64 a, float64 =
b,
+                                   float64 c, unsigned int flags)
 {
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll =3D arg1;
-    farg2.ll =3D arg2;
-    farg3.ll =3D arg3;
+    float64 f =3D float64_mul(a, b, &env->fp_status);
=20
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
-                 (float64_is_zero(farg1.d) && float64_is_infinity(farg2.=
d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) !=3D float64_is_neg(farg3.=
d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
-        } else {
-            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 =3D float128_add(ft0_128, ft1_128, &env->fp_status);
-            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
-        }
-        if (likely(!float64_is_any_nan(farg1.d))) {
-            farg1.d =3D float64_chs(farg1.d);
+    /* a*b =3D =E2=88=9E and c =3D =E2=88=9E, find =E2=88=9E - =E2=88=9E=
 case and set VXISI */
+    if (float64_is_infinity(f) && float64_is_infinity(c)) {
+        if ((f ^ c) =3D=3D 0) {
+            /* Both negative/positive inifinity and substraction*/
+            if (flags & MSUB_FLGS) {
+                /* 1. =E2=88=9E - =E2=88=9E
+                 * 2. (-=E2=88=9E) - (-=E2=88=9E)
+                 */
+                float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+            }
+        } else if (!(flags & MSUB_FLGS)) {
+            /* Opposite sign and addition
+             * 1) =E2=88=9E + (-=E2=88=9E)
+             * 2) (-=E2=88=9E) + =E2=88=9E
+             */
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
         }
     }
-    return farg1.ll;
 }
=20
-/* fnmsub - fnmsub. */
-uint64_t helper_fnmsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
-                       uint64_t arg3)
-{
-    CPU_DoubleU farg1, farg2, farg3;
-
-    farg1.ll =3D arg1;
-    farg2.ll =3D arg2;
-    farg3.ll =3D arg3;
-
-    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
-                 (float64_is_zero(farg1.d) &&
-                  float64_is_infinity(farg2.d)))) {
-        /* Multiplication of zero by infinity */
-        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
-    } else {
-        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
-                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
-            /* sNaN operation */
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-        }
-        /* This is the way the PowerPC specification defines it */
-        float128 ft0_128, ft1_128;
-
-        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
-        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
-        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
-        if (unlikely(float128_is_infinity(ft0_128) &&
-                     float64_is_infinity(farg3.d) &&
-                     float128_is_neg(ft0_128) =3D=3D float64_is_neg(farg=
3.d))) {
-            /* Magnitude subtraction of infinities */
-            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
-        } else {
-            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
-            ft0_128 =3D float128_sub(ft0_128, ft1_128, &env->fp_status);
-            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
-        }
-        if (likely(!float64_is_any_nan(farg1.d))) {
-            farg1.d =3D float64_chs(farg1.d);
-        }
-    }
-    return farg1.ll;
+#define FPU_FMADD(op, madd_flags)                                       =
\
+uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   =
\
+                     uint64_t arg2, uint64_t arg3)                      =
\
+{                                                                       =
\
+    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||=
 \
+                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) =
{ \
+        /* Multiplication of zero by infinity */                        =
\
+        arg1 =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);  =
   \
+    } else {                                                            =
\
+        if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) || =
\
+                     float64_is_signaling_nan(arg2, &env->fp_status) || =
\
+                     float64_is_signaling_nan(arg3, &env->fp_status))) {=
 \
+            /* sNaN operation */                                        =
\
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);      =
\
+        }                                                               =
\
+                                                                        =
\
+        float64_madd_set_vxisi(env, arg1, arg2, arg3, madd_flags);      =
\
+        arg1 =3D float64_muladd(arg1, arg2, arg3, madd_flags,           =
  \
+                              &env->fp_status);                         =
\
+        float_check_status(env);                                        =
\
+    }                                                                   =
\
+    return arg1;                                                        =
\
 }
+FPU_FMADD(fmadd, MADD_FLGS)
+FPU_FMADD(fnmadd, NMADD_FLGS)
+FPU_FMADD(fmsub, MSUB_FLGS)
+FPU_FMADD(fnmsub, NMSUB_FLGS)
=20
 /* frsp - frsp. */
 uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
@@ -2384,11 +2269,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode=
)                           \
     float_check_status(env);                                            =
      \
 }
=20
-#define MADD_FLGS 0
-#define MSUB_FLGS float_muladd_negate_c
-#define NMADD_FLGS float_muladd_negate_result
-#define NMSUB_FLGS (float_muladd_negate_c | float_muladd_negate_result)
-
 VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
 VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)
 VSX_MADD(xsmsubadp, 1, float64, VsrD(0), MSUB_FLGS, 1, 1, 0)
--=20
2.7.4
