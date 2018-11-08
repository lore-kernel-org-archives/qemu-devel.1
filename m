Received: from eggs.gnu.org ([2001:4830:134:3::10]:43377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFI-0005Ge-Mx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFF-0003ip-V2
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:35 +1100
Message-Id: <20181108121646.26173-12-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/22] target/ppc: Split out float_invalid_op_div
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
 target/ppc/fpu_helper.c | 52 +++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ef251d062f..127c08bcec 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -715,6 +715,21 @@ float64 helper_fmul(CPUPPCState *env, float64 arg1, =
float64 arg2)
     return ret;
 }
=20
+static void float_invalid_op_div(CPUPPCState *env, bool set_fprc,
+                                 uintptr_t retaddr, int classes)
+{
+    classes &=3D ~is_neg;
+    if (classes =3D=3D is_inf) {
+        /* Division of infinity by infinity */
+        float_invalid_op_vxidi(env, set_fprc, retaddr);
+    } else if (classes =3D=3D is_zero) {
+        /* Division of zero by zero */
+        float_invalid_op_vxzdz(env, set_fprc, retaddr);
+    } else if (classes & is_snan) {
+        float_invalid_op_vxsnan(env, retaddr);
+    }
+}
+
 /* fdiv - fdiv. */
 float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
 {
@@ -723,18 +738,9 @@ float64 helper_fdiv(CPUPPCState *env, float64 arg1, =
float64 arg2)
=20
     if (unlikely(status)) {
         if (status & float_flag_invalid) {
-            /* Determine what kind of invalid operation was seen.  */
-            if (float64_is_infinity(arg1) && float64_is_infinity(arg2)) =
{
-                /* Division of infinity by infinity */
-                float_invalid_op_vxidi(env, 1, GETPC());
-            } else if (float64_is_zero(arg1) && float64_is_zero(arg2)) {
-                /* Division of zero by zero */
-                float_invalid_op_vxzdz(env, 1, GETPC());
-            } else if (float64_is_signaling_nan(arg1, &env->fp_status) |=
|
-                       float64_is_signaling_nan(arg2, &env->fp_status)) =
{
-                /* sNaN division */
-                float_invalid_op_vxsnan(env, GETPC());
-            }
+            float_invalid_op_div(env, 1, GETPC(),
+                                 float64_classify(arg1) |
+                                 float64_classify(arg2));
         }
         if (status & float_flag_divbyzero) {
             float_zero_divide_excp(env, GETPC());
@@ -1969,14 +1975,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode=
)                           \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags;  \
                                                                         =
      \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{     \
-            if (tp##_is_infinity(xa.fld) && tp##_is_infinity(xb.fld)) { =
      \
-                float_invalid_op_vxidi(env, sfprf, GETPC());            =
      \
-            } else if (tp##_is_zero(xa.fld) && tp##_is_zero(xb.fld)) {  =
      \
-                float_invalid_op_vxzdz(env, sfprf, GETPC());            =
      \
-            } else if (tp##_is_signaling_nan(xa.fld, &tstat) ||         =
      \
-                       tp##_is_signaling_nan(xb.fld, &tstat)) {         =
      \
-                float_invalid_op_vxsnan(env, GETPC());                  =
      \
-            }                                                           =
      \
+            float_invalid_op_div(env, sfprf, GETPC(),                   =
      \
+                                 tp##_classify(xa.fld) |                =
      \
+                                 tp##_classify(xb.fld));                =
      \
         }                                                               =
      \
         if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)=
) {   \
             float_zero_divide_excp(env, GETPC());                       =
      \
@@ -2020,14 +2021,9 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opc=
ode)
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f12=
8)) {
-            float_invalid_op_vxidi(env, 1, GETPC());
-        } else if (float128_is_zero(xa.f128) && float128_is_zero(xb.f128=
)) {
-            float_invalid_op_vxzdz(env, 1, GETPC());
-        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
-                   float128_is_signaling_nan(xb.f128, &tstat)) {
-            float_invalid_op_vxsnan(env, GETPC());
-        }
+        float_invalid_op_div(env, 1, GETPC(),
+                             float128_classify(xa.f128) |
+                             float128_classify(xb.f128));
     }
     if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {
         float_zero_divide_excp(env, GETPC());
--=20
2.19.1
