Received: from eggs.gnu.org ([2001:4830:134:3::10]:43374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFI-0005Gd-M8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFF-0003j1-Vd
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:33 +1100
Message-Id: <20181108121646.26173-10-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/22] target/ppc: Split out
 float_invalid_op_addsub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 60 ++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 9ae55b1e93..111ce12a37 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -648,6 +648,17 @@ void helper_reset_fpstatus(CPUPPCState *env)
     set_float_exception_flags(0, &env->fp_status);
 }
=20
+static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
+                                    uintptr_t retaddr, int classes)
+{
+    if ((classes & ~is_neg) =3D=3D is_inf) {
+        /* Magnitude subtraction of infinities */
+        float_invalid_op_vxisi(env, set_fpcc, retaddr);
+    } else if (classes & is_snan) {
+        float_invalid_op_vxsnan(env, retaddr);
+    }
+}
+
 /* fadd - fadd. */
 float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
 {
@@ -655,14 +666,9 @@ float64 helper_fadd(CPUPPCState *env, float64 arg1, =
float64 arg2)
     int status =3D get_float_exception_flags(&env->fp_status);
=20
     if (unlikely(status & float_flag_invalid)) {
-        if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
-            /* Magnitude subtraction of infinities */
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
-                   float64_is_signaling_nan(arg2, &env->fp_status)) {
-            /* sNaN addition */
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float64_classify(arg1) |
+                                float64_classify(arg2));
     }
=20
     return ret;
@@ -675,14 +681,9 @@ float64 helper_fsub(CPUPPCState *env, float64 arg1, =
float64 arg2)
     int status =3D get_float_exception_flags(&env->fp_status);
=20
     if (unlikely(status & float_flag_invalid)) {
-        if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) {
-            /* Magnitude subtraction of infinities */
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float64_is_signaling_nan(arg1, &env->fp_status) ||
-                   float64_is_signaling_nan(arg2, &env->fp_status)) {
-            /* sNaN addition */
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float64_classify(arg1) |
+                                float64_classify(arg2));
     }
=20
     return ret;
@@ -1803,12 +1804,9 @@ void helper_##name(CPUPPCState *env, uint32_t opco=
de)                        \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags; \
                                                                         =
     \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{    \
-            if (tp##_is_infinity(xa.fld) && tp##_is_infinity(xb.fld)) { =
     \
-                float_invalid_op_vxisi(env, sfprf, GETPC());            =
     \
-            } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||         =
     \
-                       tp##_is_signaling_nan(xb.fld, &tstat)) {         =
     \
-                float_invalid_op_vxsnan(env, GETPC());                  =
     \
-            }                                                           =
     \
+            float_invalid_op_addsub(env, sfprf, GETPC(),                =
     \
+                                    tp##_classify(xa.fld) |             =
     \
+                                    tp##_classify(xb.fld));             =
     \
         }                                                               =
     \
                                                                         =
     \
         if (r2sp) {                                                     =
     \
@@ -1852,12 +1850,9 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opc=
ode)
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f12=
8)) {
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-                   float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float128_classify(xa.f128) |
+                                float128_classify(xb.f128));
     }
=20
     helper_compute_fprf_float128(env, xt.f128);
@@ -3518,12 +3513,9 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opc=
ode)
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f12=
8)) {
-            float_invalid_op_vxisi(env, 1, GETPC());
-        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-                   float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_addsub(env, 1, GETPC(),
+                                float128_classify(xa.f128) |
+                                float128_classify(xb.f128));
     }
=20
     helper_compute_fprf_float128(env, xt.f128);
--=20
2.19.1
