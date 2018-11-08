Received: from eggs.gnu.org ([2001:4830:134:3::10]:43373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFI-0005Gc-LZ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFF-0003iw-VE
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:32 +1100
Message-Id: <20181108121646.26173-9-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/22] target/ppc: Introduce fp number
 classification
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

Having a separate, logical classifiation of numbers will
unify more error paths for different formats.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 94 ++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index c9198f826d..9ae55b1e93 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -114,54 +114,62 @@ static inline int ppc_float64_get_unbiased_exp(floa=
t64 f)
     return ((f >> 52) & 0x7FF) - 1023;
 }
=20
-#define COMPUTE_FPRF(tp)                                       \
-void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
+/* Classify a floating-point number.  */
+enum {
+    is_normal   =3D 1,
+    is_zero     =3D 2,
+    is_denormal =3D 4,
+    is_inf      =3D 8,
+    is_qnan     =3D 16,
+    is_snan     =3D 32,
+    is_neg      =3D 64,
+};
+
+#define COMPUTE_CLASS(tp)                                      \
+static int tp##_classify(tp arg)                               \
 {                                                              \
-    int isneg;                                                 \
-    int fprf;                                                  \
-                                                               \
-    isneg =3D tp##_is_neg(arg);                                  \
+    int ret =3D tp##_is_neg(arg) * is_neg;                       \
     if (unlikely(tp##_is_any_nan(arg))) {                      \
-        if (tp##_is_signaling_nan(arg, &env->fp_status)) {     \
-            /* Signaling NaN: flags are undefined */           \
-            fprf =3D 0x00;                                       \
-        } else {                                               \
-            /* Quiet NaN */                                    \
-            fprf =3D 0x11;                                       \
-        }                                                      \
+        float_status dummy =3D { };  /* snan_bit_is_one =3D 0 */   \
+        ret |=3D (tp##_is_signaling_nan(arg, &dummy)             \
+                ? is_snan : is_qnan);                          \
     } else if (unlikely(tp##_is_infinity(arg))) {              \
-        /* +/- infinity */                                     \
-        if (isneg) {                                           \
-            fprf =3D 0x09;                                       \
-        } else {                                               \
-            fprf =3D 0x05;                                       \
-        }                                                      \
+        ret |=3D is_inf;                                         \
+    } else if (tp##_is_zero(arg)) {                            \
+        ret |=3D is_zero;                                        \
+    } else if (tp##_is_zero_or_denormal(arg)) {                \
+        ret |=3D is_denormal;                                    \
     } else {                                                   \
-        if (tp##_is_zero(arg)) {                               \
-            /* +/- zero */                                     \
-            if (isneg) {                                       \
-                fprf =3D 0x12;                                   \
-            } else {                                           \
-                fprf =3D 0x02;                                   \
-            }                                                  \
-        } else {                                               \
-            if (tp##_is_zero_or_denormal(arg)) {               \
-                /* Denormalized numbers */                     \
-                fprf =3D 0x10;                                   \
-            } else {                                           \
-                /* Normalized numbers */                       \
-                fprf =3D 0x00;                                   \
-            }                                                  \
-            if (isneg) {                                       \
-                fprf |=3D 0x08;                                  \
-            } else {                                           \
-                fprf |=3D 0x04;                                  \
-            }                                                  \
-        }                                                      \
+        ret |=3D is_normal;                                      \
     }                                                          \
-    /* We update FPSCR_FPRF */                                 \
-    env->fpscr &=3D ~(0x1F << FPSCR_FPRF);                       \
-    env->fpscr |=3D fprf << FPSCR_FPRF;                          \
+    return ret;                                                \
+}
+
+COMPUTE_CLASS(float16)
+COMPUTE_CLASS(float32)
+COMPUTE_CLASS(float64)
+COMPUTE_CLASS(float128)
+
+static void set_fprf_from_class(CPUPPCState *env, int class)
+{
+    static const uint8_t fprf[6][2] =3D {
+        { 0x04, 0x08 },  /* normalized */
+        { 0x02, 0x12 },  /* zero */
+        { 0x14, 0x18 },  /* denormalized */
+        { 0x05, 0x09 },  /* infinity */
+        { 0x11, 0x11 },  /* qnan */
+        { 0x00, 0x00 },  /* snan -- flags are undefined */
+    };
+    bool isneg =3D class & is_neg;
+
+    env->fpscr &=3D ~(0x1F << FPSCR_FPRF);
+    env->fpscr |=3D fprf[ctz32(class)][isneg] << FPSCR_FPRF;
+}
+
+#define COMPUTE_FPRF(tp)                                \
+void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
+{                                                       \
+    set_fprf_from_class(env, tp##_classify(arg));       \
 }
=20
 COMPUTE_FPRF(float16)
--=20
2.19.1
