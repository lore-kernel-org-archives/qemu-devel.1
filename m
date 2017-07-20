Received: from eggs.gnu.org ([2001:4830:134:3::10]:53439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0Q-0004Po-MV
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0O-0007pE-An
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:46 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0O-0007p2-2A
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:44 -0400
Received: by mail-wm0-x235.google.com with SMTP id w191so29678215wmw.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:08 +0100
Message-Id: <20170720150426.12393-6-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 05/23] softfloat3c: initial build
 machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This plumbs the SoftFloat3c code into the build machinery. This
requires a couple of things:

  - configure detects host type for SoftFloat3c build configuration
  - fpu/softfloat3c/platform.h maps QEMU #defines -> SoftFloat3c
  - fpu/Makefile.objs specifies which bits we need
    - disable some warnings for primitives

The SoftFloat3c code is designed to be used as a library so we can
afford to only build the bits we need. However we need to build the
primitives according to the "specialisation" we are using.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                  |  22 +++++++
 fpu/Makefile.objs          | 146 +++++++++++++++++++++++++++++++++++++++++++++
 fpu/softfloat3c/platform.h |  37 ++++++++----
 3 files changed, 195 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index a3f0522e8f..4778eaa8c8 100755
--- a/configure
+++ b/configure
@@ -407,6 +407,11 @@ supported_cpu="no"
 supported_os="no"
 bogus_os="no"
 
+# These control specialisations for the targets that use SoftFloat3
+softfloat3_fastint64="no"
+softfloat3_fastdiv32to16="no"
+softfloat3_fastdiv64to32="no"
+
 # parse CC options first
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
@@ -620,6 +625,9 @@ case "$cpu" in
   x86_64|amd64)
     cpu="x86_64"
     supported_cpu="yes"
+    softfloat3_fastint64="yes"
+    softfloat3_fastdiv32to16="yes"
+    softfloat3_fastdiv64to32="yes"
   ;;
   armv*b|armv*l|arm)
     cpu="arm"
@@ -6422,6 +6430,20 @@ fi
 echo "LDFLAGS+=$ldflags" >> $config_target_mak
 echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
+if test "$softfloat3" = "yes"; then
+  echo "CONFIG_SOFTFLOAT3=y" >> $config_target_mak
+  # These control the specialisations of SoftFloats code
+  if test "$softfloat3_fastint64" = "yes"; then
+    echo "CONFIG_SOFTFLOAT3_FAST_INT64=y" >> $config_target_mak
+  fi
+  if test "$softfloat3_fastdiv32to16" = "yes"; then
+    echo "CONFIG_SOFTFLOAT3_FAST_DIV32TO16=y" >> $config_target_mak
+  fi
+  if test "$softfloat3_fastdiv64to32" = "yes"; then
+    echo "CONFIG_SOFTFLOAT3_FAST_DIV64TO32=y" >> $config_target_mak
+  fi
+fi
+
 done # for target in $targets
 
 if [ "$pixman" = "internal" ]; then
diff --git a/fpu/Makefile.objs b/fpu/Makefile.objs
index 938b4acbd0..b8da746edf 100644
--- a/fpu/Makefile.objs
+++ b/fpu/Makefile.objs
@@ -1 +1,147 @@
 obj-y = softfloat2a/softfloat.o
+
+# Base SoftFloat3
+#
+# There is a slightly different set depending on if the host support SOFTFLOAT_FAST_INT64
+
+ifdef CONFIG_SOFTFLOAT3_FAST_INT64
+softfloat3_primitive_OBJS = \
+  softfloat3c/s_eq128.o \
+  softfloat3c/s_le128.o \
+  softfloat3c/s_lt128.o \
+  softfloat3c/s_shortShiftLeft128.o \
+  softfloat3c/s_shortShiftRight128.o \
+  softfloat3c/s_shortShiftRightJam64.o \
+  softfloat3c/s_shortShiftRightJam64Extra.o \
+  softfloat3c/s_shortShiftRightJam128.o \
+  softfloat3c/s_shortShiftRightJam128Extra.o \
+  softfloat3c/s_shiftRightJam32.o \
+  softfloat3c/s_shiftRightJam64.o \
+  softfloat3c/s_shiftRightJam64Extra.o \
+  softfloat3c/s_shiftRightJam128.o \
+  softfloat3c/s_shiftRightJam128Extra.o \
+  softfloat3c/s_shiftRightJam256M.o \
+  softfloat3c/s_countLeadingZeros8.o \
+  softfloat3c/s_countLeadingZeros16.o \
+  softfloat3c/s_countLeadingZeros32.o \
+  softfloat3c/s_countLeadingZeros64.o \
+  softfloat3c/s_add128.o \
+  softfloat3c/s_add256M.o \
+  softfloat3c/s_sub128.o \
+  softfloat3c/s_sub256M.o \
+  softfloat3c/s_mul64ByShifted32To128.o \
+  softfloat3c/s_mul64To128.o \
+  softfloat3c/s_mul128By32.o \
+  softfloat3c/s_mul128To256M.o \
+  softfloat3c/s_approxRecip_1Ks.o \
+  softfloat3c/s_approxRecip32_1.o \
+  softfloat3c/s_approxRecipSqrt_1Ks.o \
+  softfloat3c/s_approxRecipSqrt32_1.o
+else
+softfloat3_primitive_OBJS = softfloat3c/s_compare96M.o \
+  softfloat3c/s_compare128M.o \
+  softfloat3c/s_shortShiftLeft64To96M.o \
+  softfloat3c/s_shortShiftLeftM.o \
+  softfloat3c/s_shiftLeftM.o \
+  softfloat3c/s_shortShiftRightM.o \
+  softfloat3c/s_shortShiftRightJam64.o \
+  softfloat3c/s_shortShiftRightJamM.o \
+  softfloat3c/s_shiftRightJam32.o \
+  softfloat3c/s_shiftRightJam64.o \
+  softfloat3c/s_shiftRightJamM.o \
+  softfloat3c/s_shiftRightM.o \
+  softfloat3c/s_countLeadingZeros8.o \
+  softfloat3c/s_countLeadingZeros16.o \
+  softfloat3c/s_countLeadingZeros32.o \
+  softfloat3c/s_countLeadingZeros64.o \
+  softfloat3c/s_addM.o \
+  softfloat3c/s_addCarryM.o \
+  softfloat3c/s_addComplCarryM.o \
+  softfloat3c/s_negXM.o \
+  softfloat3c/s_sub1XM.o \
+  softfloat3c/s_subM.o \
+  softfloat3c/s_mul64To128M.o \
+  softfloat3c/s_mul128MTo256M.o \
+  softfloat3c/s_approxRecip_1Ks.o \
+  softfloat3c/s_approxRecip32_1.o \
+  softfloat3c/s_approxRecipSqrt_1Ks.o \
+  softfloat3c/s_approxRecipSqrt32_1.o \
+  softfloat3c/s_remStepMBy32.o \
+  softfloat3c/s_isNaNF128M.o
+endif
+
+# The softfloat3 primitives don't include declarations and avoid including the primitives themselves
+# so they can still be linked when needed. We build these files surpressing so of the normal CFLAGS.
+
+$(addprefix $(obj)/,$(softfloat3_primitive_OBJS)): QEMU_CFLAGS := $(filter-out -Wstrict-prototypes -Wmissing-prototypes, $(QEMU_CFLAGS))
+
+obj-$(CONFIG_SOFTFLOAT3) += $(softfloat3_primitive_OBJS)
+
+# These are the default specialization files
+ifdef CONFIG_SOFTFLOAT3_FAST_INT64
+softfloat3_specialize_OBJS = \
+  softfloat3c/8086-SSE/softfloat_raiseFlags.o \
+  softfloat3c/8086-SSE/s_f16UIToCommonNaN.o \
+  softfloat3c/8086-SSE/s_commonNaNToF16UI.o \
+  softfloat3c/8086-SSE/s_propagateNaNF16UI.o \
+  softfloat3c/8086-SSE/s_f32UIToCommonNaN.o \
+  softfloat3c/8086-SSE/s_commonNaNToF32UI.o \
+  softfloat3c/8086-SSE/s_propagateNaNF32UI.o \
+  softfloat3c/8086-SSE/s_f64UIToCommonNaN.o \
+  softfloat3c/8086-SSE/s_commonNaNToF64UI.o \
+  softfloat3c/8086-SSE/s_propagateNaNF64UI.o \
+  softfloat3c/8086-SSE/extF80M_isSignalingNaN.o \
+  softfloat3c/8086-SSE/s_extF80UIToCommonNaN.o \
+  softfloat3c/8086-SSE/s_commonNaNToExtF80UI.o \
+  softfloat3c/8086-SSE/s_propagateNaNExtF80UI.o \
+  softfloat3c/8086-SSE/f128M_isSignalingNaN.o \
+  softfloat3c/8086-SSE/s_f128UIToCommonNaN.o \
+  softfloat3c/8086-SSE/s_commonNaNToF128UI.o \
+  softfloat3c/8086-SSE/s_propagateNaNF128UI.o
+else
+softfloat3_specialize_OBJS = \
+  softfloat3c/8086/softfloat_raiseFlags.o \
+  softfloat3c/8086/s_f16UIToCommonNaN.o \
+  softfloat3c/8086/s_commonNaNToF16UI.o \
+  softfloat3c/8086/s_propagateNaNF16UI.o \
+  softfloat3c/8086/s_f32UIToCommonNaN.o \
+  softfloat3c/8086/s_commonNaNToF32UI.o \
+  softfloat3c/8086/s_propagateNaNF32UI.o \
+  softfloat3c/8086/s_f64UIToCommonNaN.o \
+  softfloat3c/8086/s_commonNaNToF64UI.o \
+  softfloat3c/8086/s_propagateNaNF64UI.o \
+  softfloat3c/8086/extF80M_isSignalingNaN.o \
+  softfloat3c/8086/s_extF80MToCommonNaN.o \
+  softfloat3c/8086/s_commonNaNToExtF80M.o \
+  softfloat3c/8086/s_propagateNaNExtF80M.o \
+  softfloat3c/8086/f128M_isSignalingNaN.o \
+  softfloat3c/8086/s_f128MToCommonNaN.o \
+  softfloat3c/8086/s_commonNaNToF128M.o \
+  softfloat3c/8086/s_propagateNaNF128M.o
+endif
+
+obj-$(CONFIG_SOFTFLOAT3) += $(softfloat3_specialize_OBJS)
+
+# We now include the common core files - these are used by all modes
+obj-$(CONFIG_SOFTFLOAT3) += softfloat3c/softfloat_state.o
+obj-$(CONFIG_SOFTFLOAT3) += softfloat3c/s_roundToI32.o softfloat3c/s_roundToUI32.o
+
+# Now for bits of SoftFloat3 needed for particular features
+# Half-precisison floating point files
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/s_roundPackToF16.o softfloat3c/s_normRoundPackToF16.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/s_normSubnormalF16Sig.o
+
+ifdef CONFIG_SOFTFLOAT3_FAST_INT64
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_to_f128.o
+endif
+
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_add.o softfloat3c/f16_sub.o softfloat3c/s_addMagsF16.o softfloat3c/s_subMagsF16.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_div.o softfloat3c/f16_eq.o softfloat3c/f16_eq_signaling.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_isSignalingNaN.o softfloat3c/f16_le.o softfloat3c/f16_le_quiet.o softfloat3c/f16_lt.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_lt_quiet.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_mul.o softfloat3c/f16_mulAdd.o softfloat3c/f16_rem.o softfloat3c/s_mulAddF16.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_roundToInt.o softfloat3c/f16_sqrt.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_to_f32.o softfloat3c/f16_to_f64.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_to_f128M.o softfloat3c/f16_to_i32.o softfloat3c/f16_to_i32_r_minMag.o softfloat3c/f16_to_i64.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_to_i64_r_minMag.o softfloat3c/f16_to_ui32.o softfloat3c/f16_to_ui32_r_minMag.o softfloat3c/f16_to_ui64.o
+obj-$(CONFIG_SOFTFLOAT3_FP16) += softfloat3c/f16_to_ui64_r_minMag.o
diff --git a/fpu/softfloat3c/platform.h b/fpu/softfloat3c/platform.h
index 03a9159474..f20661acc9 100644
--- a/fpu/softfloat3c/platform.h
+++ b/fpu/softfloat3c/platform.h
@@ -34,15 +34,32 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 =============================================================================*/
 
-/*----------------------------------------------------------------------------
-*----------------------------------------------------------------------------*/
-#define LITTLEENDIAN 1
-
-/*----------------------------------------------------------------------------
-*----------------------------------------------------------------------------*/
-#ifdef __GNUC_STDC_INLINE__
-#define INLINE inline
-#else
-#define INLINE extern inline
+/*
+ * QEMU Tweaks - here we map the QEMU configs to the appropriate
+ * Softfloat Specialisations.
+ */
+
+#include "config-target.h"
+
+#if defined(CONFIG_SOFTFLOAT3_FAST_INT64)
+    #define SOFTFLOAT_FAST_INT64 1
+#endif
+
+#if defined(CONFIG_SOFTFLOAT3_FAST_DIV32TO16)
+    #define SOFTFLOAT_FAST_DIV32TO16 1
+#endif
+
+#if defined(CONFIG_SOFTFLOAT3_FAST_DIV64TO32)
+    #define SOFTFLOAT_FAST_DIV64TO32 1
+#endif
+
+#ifndef HOST_WORDS_BIGENDIAN
+    #define LITTLEENDIAN 1
 #endif
 
+#define SOFTFLOAT_ROUND_ODD 1
+#define INLINE_LEVEL 5
+#define INLINE static inline
+
+#define THREAD_LOCAL __thread
+
-- 
2.13.0
