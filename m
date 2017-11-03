Received: from eggs.gnu.org ([2001:4830:134:3::10]:49205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYG-0001aJ-P4
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYF-0000f3-Ko
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:52 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 Nov 2017 21:26:23 +0100
Message-Id: <20171103202624.5956-4-laurent@vivier.eu>
In-Reply-To: <20171103202624.5956-1-laurent@vivier.eu>
References: <20171103202624.5956-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 3/4] tricore: use make_float32() and
 float32_val()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/tricore/fpu_helper.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 7979bb6692..d233d010c5 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -21,10 +21,10 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-#define QUIET_NAN 0x7fc00000
-#define ADD_NAN   0x7fc00001
-#define DIV_NAN   0x7fc00008
-#define MUL_NAN   0x7fc00002
+#define QUIET_NAN make_float32(0x7fc00000)
+#define ADD_NAN   make_float32(0x7fc00001)
+#define DIV_NAN   make_float32(0x7fc00008)
+#define MUL_NAN   make_float32(0x7fc00002)
 #define FPU_FS PSW_USB_C
 #define FPU_FI PSW_USB_V
 #define FPU_FV PSW_USB_SV
@@ -63,13 +63,13 @@ static inline float32 f_maddsub_nan_result(float32 arg1, float32 arg2,
     } else if (float32_is_zero(arg1) && float32_is_infinity(arg2)) {
         return MUL_NAN;
     } else {
-        aSign = arg1 >> 31;
-        bSign = arg2 >> 31;
-        cSign = arg3 >> 31;
+        aSign = float32_val(arg1) >> 31;
+        bSign = float32_val(arg2) >> 31;
+        cSign = float32_val(arg3) >> 31;
 
-        aExp = (arg1 >> 23) & 0xff;
-        bExp = (arg2 >> 23) & 0xff;
-        cExp = (arg3 >> 23) & 0xff;
+        aExp = (float32_val(arg1) >> 23) & 0xff;
+        bExp = (float32_val(arg2) >> 23) & 0xff;
+        cExp = (float32_val(arg3) >> 23) & 0xff;
 
         if (muladd_negate_c) {
             cSign ^= 1;
@@ -139,7 +139,7 @@ uint32_t helper_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)          \
     } else {                                                                   \
         env->FPU_FS = 0;                                                       \
     }                                                                          \
-    return (uint32_t)f_result;                                                 \
+    return float32_val(f_result);                                              \
 }
 FADD_SUB(add)
 FADD_SUB(sub)
@@ -166,7 +166,7 @@ uint32_t helper_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     } else {
         env->FPU_FS = 0;
     }
-    return (uint32_t)f_result;
+    return float32_val(f_result);
 
 }
 
@@ -193,7 +193,7 @@ uint32_t helper_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
         env->FPU_FS = 0;
     }
 
-    return (uint32_t)f_result;
+    return float32_val(f_result);
 }
 
 uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
@@ -219,7 +219,7 @@ uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
     } else {
         env->FPU_FS = 0;
     }
-    return (uint32_t)f_result;
+    return float32_val(f_result);
 }
 
 uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
@@ -247,7 +247,7 @@ uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
     } else {
         env->FPU_FS = 0;
     }
-    return (uint32_t)f_result;
+    return float32_val(f_result);
 }
 
 uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
@@ -304,7 +304,7 @@ uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
     } else {
         env->FPU_FS = 0;
     }
-    return (uint32_t)f_result;
+    return float32_val(f_result);
 }
 
 uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
@@ -321,7 +321,7 @@ uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
         if (float32_is_any_nan(f_arg)) {
             result = 0;
         }
-    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
+    } else if (float32_lt_quiet(f_arg, float32_zero, &env->fp_status)) {
         flags = float_flag_invalid;
         result = 0;
     }
-- 
2.13.6
