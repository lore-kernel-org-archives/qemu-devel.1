Received: from eggs.gnu.org ([2001:4830:134:3::10]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFC-0005CN-Hz
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjF9-0003d1-0k
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:04 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:36 +1100
Message-Id: <20181108121646.26173-13-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/22] target/ppc: Split out float_invalid_cvt
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
 target/ppc/fpu_helper.c | 67 +++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 127c08bcec..2ed4f42275 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -750,30 +750,30 @@ float64 helper_fdiv(CPUPPCState *env, float64 arg1,=
 float64 arg2)
     return ret;
 }
=20
+static void float_invalid_cvt(CPUPPCState *env, bool set_fprc,
+                              uintptr_t retaddr, int class1)
+{
+    float_invalid_op_vxcvi(env, set_fprc, retaddr);
+    if (class1 & is_snan) {
+        float_invalid_op_vxsnan(env, retaddr);
+    }
+}
=20
 #define FPU_FCTI(op, cvt, nanval)                                      \
-uint64_t helper_##op(CPUPPCState *env, uint64_t arg)                   \
+uint64_t helper_##op(CPUPPCState *env, float64 arg)                    \
 {                                                                      \
-    CPU_DoubleU farg;                                                  \
-                                                                       \
-    farg.ll =3D arg;                                                    =
 \
-    farg.ll =3D float64_to_##cvt(farg.d, &env->fp_status);              =
 \
+    uint64_t ret =3D float64_to_##cvt(arg, &env->fp_status);            =
 \
+    int status =3D get_float_exception_flags(&env->fp_status);          =
 \
                                                                        \
-    if (unlikely(env->fp_status.float_exception_flags)) {              \
-        if (float64_is_any_nan(arg)) {                                 \
-            float_invalid_op_vxcvi(env, 1, GETPC());                   \
-            if (float64_is_signaling_nan(arg, &env->fp_status)) {      \
-                float_invalid_op_vxsnan(env, GETPC());                 \
-            }                                                          \
-            farg.ll =3D nanval;                                         =
 \
-        } else if (env->fp_status.float_exception_flags &              \
-                   float_flag_invalid) {                               \
-            float_invalid_op_vxcvi(env, 1, GETPC());                   \
+    if (unlikely(status)) {                                            \
+        if (status & float_flag_invalid) {                             \
+            float_invalid_cvt(env, 1, GETPC(), float64_classify(arg)); \
+            ret =3D nanval;                                             =
 \
         }                                                              \
         do_float_check_status(env, GETPC());                           \
     }                                                                  \
-    return farg.ll;                                                    \
- }
+    return ret;                                                        \
+}
=20
 FPU_FCTI(fctiw, int32, 0x80000000U)
 FPU_FCTI(fctiwz, int32_round_to_zero, 0x80000000U)
@@ -2965,6 +2965,7 @@ uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_=
t xb)
 #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, rnan)         =
     \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
 {                                                                       =
     \
+    int all_flags =3D env->fp_status.float_exception_flags, flags;      =
       \
     ppc_vsr_t xt, xb;                                                   =
     \
     int i;                                                              =
     \
                                                                         =
     \
@@ -2972,22 +2973,18 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                          \
     getVSR(xT(opcode), &xt, env);                                       =
     \
                                                                         =
     \
     for (i =3D 0; i < nels; i++) {                                      =
       \
-        if (unlikely(stp##_is_any_nan(xb.sfld))) {                      =
     \
-            if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {     =
     \
-                float_invalid_op_vxsnan(env, GETPC());                  =
     \
-            }                                                           =
     \
-            float_invalid_op_vxcvi(env, 0, GETPC());                    =
     \
+        env->fp_status.float_exception_flags =3D 0;                     =
       \
+        xt.tfld =3D stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_sta=
tus);  \
+        flags =3D env->fp_status.float_exception_flags;                 =
       \
+        if (unlikely(flags & float_flag_invalid)) {                     =
     \
+            float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));=
     \
             xt.tfld =3D rnan;                                           =
       \
-        } else {                                                        =
     \
-            xt.tfld =3D stp##_to_##ttp##_round_to_zero(xb.sfld,         =
       \
-                          &env->fp_status);                             =
     \
-            if (env->fp_status.float_exception_flags & float_flag_invali=
d) { \
-                float_invalid_op_vxcvi(env, 0, GETPC());                =
     \
-            }                                                           =
     \
         }                                                               =
     \
+        all_flags |=3D flags;                                           =
       \
     }                                                                   =
     \
                                                                         =
     \
     putVSR(xT(opcode), &xt, env);                                       =
     \
+    env->fp_status.float_exception_flags =3D all_flags;                 =
       \
     do_float_check_status(env, GETPC());                                =
     \
 }
=20
@@ -3025,18 +3022,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                          \
     getVSR(rB(opcode) + 32, &xb, env);                                  =
     \
     memset(&xt, 0, sizeof(xt));                                         =
     \
                                                                         =
     \
-    if (unlikely(stp##_is_any_nan(xb.sfld))) {                          =
     \
-        if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {         =
     \
-            float_invalid_op_vxsnan(env, GETPC());                      =
     \
-        }                                                               =
     \
-        float_invalid_op_vxcvi(env, 0, GETPC());                        =
     \
+    xt.tfld =3D stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_status)=
;      \
+    if (env->fp_status.float_exception_flags & float_flag_invalid) {    =
     \
+        float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));    =
     \
         xt.tfld =3D rnan;                                               =
       \
-    } else {                                                            =
     \
-        xt.tfld =3D stp##_to_##ttp##_round_to_zero(xb.sfld,             =
       \
-                      &env->fp_status);                                 =
     \
-        if (env->fp_status.float_exception_flags & float_flag_invalid) {=
     \
-            float_invalid_op_vxcvi(env, 0, GETPC());                    =
     \
-        }                                                               =
     \
     }                                                                   =
     \
                                                                         =
     \
     putVSR(rD(opcode) + 32, &xt, env);                                  =
     \
--=20
2.19.1
