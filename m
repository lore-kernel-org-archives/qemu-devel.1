Received: from eggs.gnu.org ([2001:4830:134:3::10]:54219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkaq-0001oA-G4
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkao-0002HA-A9
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:32931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkam-0002Co-9o
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id y18-v6so4925290pge.0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:55 -0700
Message-Id: <20181011234159.11496-4-richard.henderson@linaro.org>
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/7] target/ppc: Introduce fp number
 classification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

Having a separate, logical classifiation of numbers will
unify more error paths for different formats.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/fpu_helper.c | 94 ++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index c9198f826d..9ae55b1e93 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -114,54 +114,62 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
     return ((f >> 52) & 0x7FF) - 1023;
 }
 
-#define COMPUTE_FPRF(tp)                                       \
-void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
+/* Classify a floating-point number.  */
+enum {
+    is_normal   = 1,
+    is_zero     = 2,
+    is_denormal = 4,
+    is_inf      = 8,
+    is_qnan     = 16,
+    is_snan     = 32,
+    is_neg      = 64,
+};
+
+#define COMPUTE_CLASS(tp)                                      \
+static int tp##_classify(tp arg)                               \
 {                                                              \
-    int isneg;                                                 \
-    int fprf;                                                  \
-                                                               \
-    isneg = tp##_is_neg(arg);                                  \
+    int ret = tp##_is_neg(arg) * is_neg;                       \
     if (unlikely(tp##_is_any_nan(arg))) {                      \
-        if (tp##_is_signaling_nan(arg, &env->fp_status)) {     \
-            /* Signaling NaN: flags are undefined */           \
-            fprf = 0x00;                                       \
-        } else {                                               \
-            /* Quiet NaN */                                    \
-            fprf = 0x11;                                       \
-        }                                                      \
+        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
+        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
+                ? is_snan : is_qnan);                          \
     } else if (unlikely(tp##_is_infinity(arg))) {              \
-        /* +/- infinity */                                     \
-        if (isneg) {                                           \
-            fprf = 0x09;                                       \
-        } else {                                               \
-            fprf = 0x05;                                       \
-        }                                                      \
+        ret |= is_inf;                                         \
+    } else if (tp##_is_zero(arg)) {                            \
+        ret |= is_zero;                                        \
+    } else if (tp##_is_zero_or_denormal(arg)) {                \
+        ret |= is_denormal;                                    \
     } else {                                                   \
-        if (tp##_is_zero(arg)) {                               \
-            /* +/- zero */                                     \
-            if (isneg) {                                       \
-                fprf = 0x12;                                   \
-            } else {                                           \
-                fprf = 0x02;                                   \
-            }                                                  \
-        } else {                                               \
-            if (tp##_is_zero_or_denormal(arg)) {               \
-                /* Denormalized numbers */                     \
-                fprf = 0x10;                                   \
-            } else {                                           \
-                /* Normalized numbers */                       \
-                fprf = 0x00;                                   \
-            }                                                  \
-            if (isneg) {                                       \
-                fprf |= 0x08;                                  \
-            } else {                                           \
-                fprf |= 0x04;                                  \
-            }                                                  \
-        }                                                      \
+        ret |= is_normal;                                      \
     }                                                          \
-    /* We update FPSCR_FPRF */                                 \
-    env->fpscr &= ~(0x1F << FPSCR_FPRF);                       \
-    env->fpscr |= fprf << FPSCR_FPRF;                          \
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
+    static const uint8_t fprf[6][2] = {
+        { 0x04, 0x08 },  /* normalized */
+        { 0x02, 0x12 },  /* zero */
+        { 0x14, 0x18 },  /* denormalized */
+        { 0x05, 0x09 },  /* infinity */
+        { 0x11, 0x11 },  /* qnan */
+        { 0x00, 0x00 },  /* snan -- flags are undefined */
+    };
+    bool isneg = class & is_neg;
+
+    env->fpscr &= ~(0x1F << FPSCR_FPRF);
+    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
+}
+
+#define COMPUTE_FPRF(tp)                                \
+void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
+{                                                       \
+    set_fprf_from_class(env, tp##_classify(arg));       \
 }
 
 COMPUTE_FPRF(float16)
-- 
2.17.1
