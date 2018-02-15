Received: from eggs.gnu.org ([2001:4830:134:3::10]:36396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP4-000689-PR
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP3-0004DB-FL
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOP3-0004Cg-7r
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:05 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP2-00024i-9N
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:44 +0000
Message-Id: <20180215183700.26101-5-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/20] target/arm: Enforce FP access to FPCR/FPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180211205848.4568-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 35 ++++++++++++++++++-----------------
 target/arm/helper.c        |  6 ++++--
 target/arm/translate-a64.c |  3 +++
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 521444a5a1..e966a57f8a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1714,7 +1714,7 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 }
 
 /* ARMCPRegInfo type field bits. If the SPECIAL bit is set this is a
- * special-behaviour cp reg and bits [15..8] indicate what behaviour
+ * special-behaviour cp reg and bits [11..8] indicate what behaviour
  * it has. Otherwise it is a simple cp reg, where CONST indicates that
  * TCG can assume the value to be constant (ie load at translate time)
  * and 64BIT indicates a 64 bit wide coprocessor register. SUPPRESS_TB_END
@@ -1735,24 +1735,25 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
  * need to be surrounded by gen_io_start()/gen_io_end(). In particular,
  * registers which implement clocks or timers require this.
  */
-#define ARM_CP_SPECIAL 1
-#define ARM_CP_CONST 2
-#define ARM_CP_64BIT 4
-#define ARM_CP_SUPPRESS_TB_END 8
-#define ARM_CP_OVERRIDE 16
-#define ARM_CP_ALIAS 32
-#define ARM_CP_IO 64
-#define ARM_CP_NO_RAW 128
-#define ARM_CP_NOP (ARM_CP_SPECIAL | (1 << 8))
-#define ARM_CP_WFI (ARM_CP_SPECIAL | (2 << 8))
-#define ARM_CP_NZCV (ARM_CP_SPECIAL | (3 << 8))
-#define ARM_CP_CURRENTEL (ARM_CP_SPECIAL | (4 << 8))
-#define ARM_CP_DC_ZVA (ARM_CP_SPECIAL | (5 << 8))
-#define ARM_LAST_SPECIAL ARM_CP_DC_ZVA
+#define ARM_CP_SPECIAL           0x0001
+#define ARM_CP_CONST             0x0002
+#define ARM_CP_64BIT             0x0004
+#define ARM_CP_SUPPRESS_TB_END   0x0008
+#define ARM_CP_OVERRIDE          0x0010
+#define ARM_CP_ALIAS             0x0020
+#define ARM_CP_IO                0x0040
+#define ARM_CP_NO_RAW            0x0080
+#define ARM_CP_NOP               (ARM_CP_SPECIAL | 0x0100)
+#define ARM_CP_WFI               (ARM_CP_SPECIAL | 0x0200)
+#define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
+#define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
+#define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
+#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
+#define ARM_CP_FPU               0x1000
 /* Used only as a terminator for ARMCPRegInfo lists */
-#define ARM_CP_SENTINEL 0xffff
+#define ARM_CP_SENTINEL          0xffff
 /* Mask of only the flag bits in a type field */
-#define ARM_CP_FLAG_MASK 0xff
+#define ARM_CP_FLAG_MASK         0x10ff
 
 /* Valid values for ARMCPRegInfo state field, indicating which of
  * the AArch32 and AArch64 execution states this register is visible in.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4b102ec356..d41fb8371f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3356,10 +3356,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = aa64_daif_write, .resetfn = arm_cp_reset_ignore },
     { .name = "FPCR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 0, .crn = 4, .crm = 4,
-      .access = PL0_RW, .readfn = aa64_fpcr_read, .writefn = aa64_fpcr_write },
+      .access = PL0_RW, .type = ARM_CP_FPU,
+      .readfn = aa64_fpcr_read, .writefn = aa64_fpcr_write },
     { .name = "FPSR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 1, .crn = 4, .crm = 4,
-      .access = PL0_RW, .readfn = aa64_fpsr_read, .writefn = aa64_fpsr_write },
+      .access = PL0_RW, .type = ARM_CP_FPU,
+      .readfn = aa64_fpsr_read, .writefn = aa64_fpsr_write },
     { .name = "DCZID_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 7, .crn = 0, .crm = 0,
       .access = PL0_R, .type = ARM_CP_NO_RAW,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fb1a4cb532..89f50558a7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1631,6 +1631,9 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     default:
         break;
     }
+    if ((ri->type & ARM_CP_FPU) && !fp_access_check(s)) {
+        return;
+    }
 
     if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         gen_io_start();
-- 
2.16.1
