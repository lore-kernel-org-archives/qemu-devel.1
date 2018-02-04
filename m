Received: from eggs.gnu.org ([2001:4830:134:3::10]:47288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBeg-0004Wv-U6
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBed-0004qO-P8
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:50 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:39320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBed-0004pk-Gp
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:47 -0500
Received: by mail-pl0-x242.google.com with SMTP id o13so9359506pli.6
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:11:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:16 -0800
Message-Id: <20180204041136.17525-5-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/24] target/*/cpu.h: remove softfloat.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

From: Alex Bennée <alex.bennee@linaro.org>

As cpu.h is another typically widely included file which doesn't need
full access to the softfloat API we can remove the includes from here
as well. Where they do need types it's typically for float_status and
the rounding modes so we move that to softfloat-types.h as well.

As a result of not having softfloat in every cpu.h call we now need to
add it to various helpers that do need the full softfloat.h
definitions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[For PPC parts]
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/fpu/softfloat-types.h   | 64 +++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h         | 53 ----------------------------------
 target/alpha/cpu.h              |  2 --
 target/arm/cpu.h                |  2 --
 target/hppa/cpu.h               |  1 -
 target/i386/cpu.h               |  4 ---
 target/m68k/cpu.h               |  1 -
 target/microblaze/cpu.h         |  2 +-
 target/moxie/cpu.h              |  1 -
 target/nios2/cpu.h              |  1 -
 target/openrisc/cpu.h           |  1 -
 target/ppc/cpu.h                |  1 -
 target/s390x/cpu.h              |  2 --
 target/sh4/cpu.h                |  2 --
 target/sparc/cpu.h              |  2 --
 target/tricore/cpu.h            |  1 -
 target/unicore32/cpu.h          |  1 -
 target/xtensa/cpu.h             |  1 -
 target/arm/cpu.c                |  1 +
 target/arm/helper-a64.c         |  1 +
 target/arm/helper.c             |  1 +
 target/arm/neon_helper.c        |  1 +
 target/hppa/cpu.c               |  1 +
 target/hppa/op_helper.c         |  1 +
 target/i386/fpu_helper.c        |  1 +
 target/m68k/cpu.c               |  2 +-
 target/m68k/fpu_helper.c        |  1 +
 target/m68k/helper.c            |  1 +
 target/m68k/translate.c         |  2 ++
 target/microblaze/cpu.c         |  1 +
 target/microblaze/op_helper.c   |  1 +
 target/openrisc/fpu_helper.c    |  1 +
 target/ppc/fpu_helper.c         |  1 +
 target/ppc/int_helper.c         |  1 +
 target/ppc/translate_init.c     |  1 +
 target/s390x/cpu.c              |  1 +
 target/s390x/fpu_helper.c       |  1 +
 target/sh4/cpu.c                |  1 +
 target/sh4/op_helper.c          |  1 +
 target/sparc/fop_helper.c       |  1 +
 target/tricore/fpu_helper.c     |  1 +
 target/tricore/helper.c         |  1 +
 target/unicore32/cpu.c          |  1 +
 target/unicore32/ucf64_helper.c |  1 +
 target/xtensa/op_helper.c       |  1 +
 45 files changed, 93 insertions(+), 78 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 8210a94ea1..4e378cb612 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -80,6 +80,12 @@ this code that are retained.
 #ifndef SOFTFLOAT_TYPES_H
 #define SOFTFLOAT_TYPES_H
 
+/* This 'flag' type must be able to hold at least 0 and 1. It should
+ * probably be replaced with 'bool' but the uses would need to be audited
+ * to check that they weren't accidentally relying on it being a larger type.
+ */
+typedef uint8_t flag;
+
 /*
  * Software IEC/IEEE floating-point types.
  */
@@ -112,4 +118,62 @@ typedef struct {
 #define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
 #define make_float128_init(high_, low_) { .high = high_, .low = low_ }
 
+/*
+ * Software IEC/IEEE floating-point underflow tininess-detection mode.
+ */
+
+enum {
+    float_tininess_after_rounding  = 0,
+    float_tininess_before_rounding = 1
+};
+
+/*
+ *Software IEC/IEEE floating-point rounding mode.
+ */
+
+enum {
+    float_round_nearest_even = 0,
+    float_round_down         = 1,
+    float_round_up           = 2,
+    float_round_to_zero      = 3,
+    float_round_ties_away    = 4,
+    /* Not an IEEE rounding mode: round to the closest odd mantissa value */
+    float_round_to_odd       = 5,
+};
+
+/*
+ * Software IEC/IEEE floating-point exception flags.
+ */
+
+enum {
+    float_flag_invalid   =  1,
+    float_flag_divbyzero =  4,
+    float_flag_overflow  =  8,
+    float_flag_underflow = 16,
+    float_flag_inexact   = 32,
+    float_flag_input_denormal = 64,
+    float_flag_output_denormal = 128
+};
+
+
+/*
+ * Floating Point Status. Individual architectures may maintain
+ * several versions of float_status for different functions. The
+ * correct status for the operation is then passed by reference to
+ * most of the softfloat functions.
+ */
+
+typedef struct float_status {
+    signed char float_detect_tininess;
+    signed char float_rounding_mode;
+    uint8_t     float_exception_flags;
+    signed char floatx80_rounding_precision;
+    /* should denormalised results go to zero and set the inexact flag? */
+    flag flush_to_zero;
+    /* should denormalised inputs go to zero and set the input_denormal flag? */
+    flag flush_inputs_to_zero;
+    flag default_nan_mode;
+    flag snan_bit_is_one;
+} float_status;
+
 #endif /* SOFTFLOAT_TYPES_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 4e16e22e58..f3b9008f78 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -82,12 +82,6 @@ this code that are retained.
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
 
-/* This 'flag' type must be able to hold at least 0 and 1. It should
- * probably be replaced with 'bool' but the uses would need to be audited
- * to check that they weren't accidentally relying on it being a larger type.
- */
-typedef uint8_t flag;
-
 #define LIT64( a ) a##LL
 
 /*----------------------------------------------------------------------------
@@ -102,53 +96,6 @@ enum {
 
 #include "fpu/softfloat-types.h"
 
-/*----------------------------------------------------------------------------
-| Software IEC/IEEE floating-point underflow tininess-detection mode.
-*----------------------------------------------------------------------------*/
-enum {
-    float_tininess_after_rounding  = 0,
-    float_tininess_before_rounding = 1
-};
-
-/*----------------------------------------------------------------------------
-| Software IEC/IEEE floating-point rounding mode.
-*----------------------------------------------------------------------------*/
-enum {
-    float_round_nearest_even = 0,
-    float_round_down         = 1,
-    float_round_up           = 2,
-    float_round_to_zero      = 3,
-    float_round_ties_away    = 4,
-    /* Not an IEEE rounding mode: round to the closest odd mantissa value */
-    float_round_to_odd       = 5,
-};
-
-/*----------------------------------------------------------------------------
-| Software IEC/IEEE floating-point exception flags.
-*----------------------------------------------------------------------------*/
-enum {
-    float_flag_invalid   =  1,
-    float_flag_divbyzero =  4,
-    float_flag_overflow  =  8,
-    float_flag_underflow = 16,
-    float_flag_inexact   = 32,
-    float_flag_input_denormal = 64,
-    float_flag_output_denormal = 128
-};
-
-typedef struct float_status {
-    signed char float_detect_tininess;
-    signed char float_rounding_mode;
-    uint8_t     float_exception_flags;
-    signed char floatx80_rounding_precision;
-    /* should denormalised results go to zero and set the inexact flag? */
-    flag flush_to_zero;
-    /* should denormalised inputs go to zero and set the input_denormal flag? */
-    flag flush_inputs_to_zero;
-    flag default_nan_mode;
-    flag snan_bit_is_one;
-} float_status;
-
 static inline void set_float_detect_tininess(int val, float_status *status)
 {
     status->float_detect_tininess = val;
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 09720c2f3b..a79fc2e780 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -33,8 +33,6 @@
 
 #include "exec/cpu-defs.h"
 
-#include "fpu/softfloat.h"
-
 #define ICACHE_LINE_SIZE 32
 #define DCACHE_LINE_SIZE 32
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d2bb59eded..c7c922d79b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -39,8 +39,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 
-#include "fpu/softfloat.h"
-
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7640c81221..c88d844938 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -51,7 +51,6 @@
 #define CPUArchState struct CPUHPPAState
 
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
 
 #define TARGET_PAGE_BITS 12
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f91e37d25d..faf39ec1ce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -52,10 +52,6 @@
 
 #define CPUArchState struct CPUX86State
 
-#ifdef CONFIG_TCG
-#include "fpu/softfloat.h"
-#endif
-
 enum {
     R_EAX = 0,
     R_ECX = 1,
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 627fb787b6..e250dc5278 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -28,7 +28,6 @@
 #include "qemu-common.h"
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
-#include "fpu/softfloat.h"
 
 #define OS_BYTE     0
 #define OS_WORD     1
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f3e7405a62..1fe21c8539 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -28,7 +28,7 @@
 #define CPUArchState struct CPUMBState
 
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 struct CPUMBState;
 typedef struct CPUMBState CPUMBState;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index a01f480821..d85e1fc061 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -34,7 +34,6 @@
 #define MOXIE_EX_BREAK      16
 
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
 
 #define TARGET_PAGE_BITS 12     /* 4k */
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 204b39add7..cd4e40d1b4 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -27,7 +27,6 @@
 #define CPUArchState struct CPUNios2State
 
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
 #include "qom/cpu.h"
 struct CPUNios2State;
 typedef struct CPUNios2State CPUNios2State;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index fb46cc9986..5050b1135c 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -29,7 +29,6 @@ struct OpenRISCCPU;
 
 #include "qemu-common.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
 #include "qom/cpu.h"
 
 #define TYPE_OPENRISC_CPU "or1k-cpu"
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 9f8cbbe7aa..7bde1884a1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -79,7 +79,6 @@
 
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
-#include "fpu/softfloat.h"
 
 #if defined (TARGET_PPC64)
 #define PPC_ELF_MACHINE     EM_PPC64
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a1123ad621..96264ad4cb 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -41,8 +41,6 @@
 
 #include "exec/cpu-all.h"
 
-#include "fpu/softfloat.h"
-
 #define NB_MMU_MODES 4
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 52a4568dd5..a649b68d78 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -40,8 +40,6 @@
 
 #include "exec/cpu-defs.h"
 
-#include "fpu/softfloat.h"
-
 #define TARGET_PAGE_BITS 12	/* 4k XXXXX */
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3eaffb354e..9724134a5b 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -29,8 +29,6 @@
 
 #include "exec/cpu-defs.h"
 
-#include "fpu/softfloat.h"
-
 /*#define EXCP_INTERRUPT 0x100*/
 
 /* trap definitions */
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index f41d2ceb69..e7dfe4bcc6 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -24,7 +24,6 @@
 #include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
 
 #define CPUArchState struct CPUTriCoreState
 
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index a3cc71416d..42e1d52478 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -23,7 +23,6 @@
 #include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
 
 #define NB_MMU_MODES            2
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index f300c02c07..49c2e3cf9a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -36,7 +36,6 @@
 #include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
 #include "xtensa-isa.h"
 
 #define NB_MMU_MODES 4
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9da6ea505c..2d6ac054bd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -34,6 +34,7 @@
 #include "sysemu/hw_accel.h"
 #include "kvm_arm.h"
 #include "disas/capstone.h"
+#include "fpu/softfloat.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 06fd321fae..10e08bdc1f 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -31,6 +31,7 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "tcg.h"
+#include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
 
 /* C2.4.7 Multiply and divide */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bfce09643b..4ef99882c4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -15,6 +15,7 @@
 #include <zlib.h> /* For crc32 */
 #include "exec/semihost.h"
 #include "sysemu/kvm.h"
+#include "fpu/softfloat.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 689491cad3..a1ec6537eb 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5213347720..9224331165 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "qemu-common.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat.h"
 
 
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 4ee936bf86..ff74327cda 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/cpu_ldst.h"
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
+#include "fpu/softfloat.h"
 
 
 void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 9014b6f88a..ea5a0c4861 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -24,6 +24,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
 
 #define FPU_RC_MASK         0xc00
 #define FPU_RC_NEAR         0x000
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 98919b358b..cbd5f08ce8 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
-
+#include "fpu/softfloat.h"
 
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 665e7609af..3c5a82aaa0 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
 
 /* Undefined offsets may be different on various FPU.
  * On 68040 they return 0.0 (floatx80_zero)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 20155c7801..917d46efcc 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -24,6 +24,7 @@
 #include "exec/gdbstub.h"
 
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 #define SIGNBIT (1u << 31)
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 34db97b8a0..bbbc3d8a0e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -32,6 +32,8 @@
 
 #include "trace-tcg.h"
 #include "exec/log.h"
+#include "fpu/softfloat.h"
+
 
 //#define DEBUG_DISPATCH 1
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 5700652e06..393520f3ef 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat.h"
 
 static const struct {
     const char *name;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 869072a2d1..1b4fe796e7 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -24,6 +24,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
 
 #define D(x)
 
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 1375cea948..977a1e8e55 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
+#include "fpu/softfloat.h"
 
 static inline uint32_t ieee_ex_to_openrisc(OpenRISCCPU *cpu, int fexcp)
 {
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index c4dab159e4..9ae418a577 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -21,6 +21,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "internal.h"
+#include "fpu/softfloat.h"
 
 static inline float128 float128_snan_to_qnan(float128 x)
 {
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 3a50f1e1b7..35bdf09773 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -23,6 +23,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "fpu/softfloat.h"
 
 #include "helper_regs.h"
 /*****************************************************************************/
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 55c99c97e3..54ec2e122a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -36,6 +36,7 @@
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
+#include "fpu/softfloat.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d2e6b9f5c7..7acb827f1b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -42,6 +42,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
 #endif
+#include "fpu/softfloat.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 334159119f..43f8bf1c94 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e0b99fbc89..4f8c830fe3 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -25,6 +25,7 @@
 #include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat.h"
 
 
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4b8bbf63b4..4f825bae5a 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -21,6 +21,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
 
 #ifndef CONFIG_USER_ONLY
 
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index c7fb176e4c..b6642fd1d7 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 #define QT0 (env->qt0)
 #define QT1 (env->qt1)
diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 7979bb6692..df162902d6 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 #define QUIET_NAN 0x7fc00000
 #define ADD_NAN   0x7fc00001
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 378c2a4a76..45276d3782 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -19,6 +19,7 @@
 
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat.h"
 
 enum {
     TLBRET_DIRTY = -4,
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 17dc1504d7..93cbae39d9 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -18,6 +18,7 @@
 #include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat.h"
 
 static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/unicore32/ucf64_helper.c b/target/unicore32/ucf64_helper.c
index 6c919010c3..fad3fa6618 100644
--- a/target/unicore32/ucf64_helper.c
+++ b/target/unicore32/ucf64_helper.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 /*
  * The convention used for UniCore-F64 instructions:
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 43182b113e..7486b99799 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -34,6 +34,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
 #include "qemu/timer.h"
+#include "fpu/softfloat.h"
 
 void xtensa_cpu_do_unaligned_access(CPUState *cs,
         vaddr addr, MMUAccessType access_type,
-- 
2.14.3
