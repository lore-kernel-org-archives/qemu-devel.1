Received: from eggs.gnu.org ([2001:4830:134:3::10]:53612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsA-0001Tl-GB
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXs6-0005IN-Dt
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:30 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCXs2-00051y-RM
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id l81-v6so12152420pfg.3
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:31:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:31:08 -0700
Message-Id: <20181016223115.24100-2-richard.henderson@linaro.org>
In-Reply-To: <20181016223115.24100-1-richard.henderson@linaro.org>
References: <20181016223115.24100-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 1/8] target/arm: Move some system registers
 into a substructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Create struct ARMISARegisters, to be accessed during translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h      |  32 ++++----
 hw/intc/armv7m_nvic.c |  12 +--
 target/arm/cpu.c      | 178 +++++++++++++++++++++---------------------
 target/arm/cpu64.c    |  70 ++++++++---------
 target/arm/helper.c   |  28 +++----
 5 files changed, 162 insertions(+), 158 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f00c0444c4..cff739b74d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -788,13 +788,28 @@ struct ARMCPU {
      * ARMv7AR ARM Architecture Reference Manual. A reset_ prefix
      * is used for reset values of non-constant registers; no reset_
      * prefix means a constant register.
+     * Some of these registers are split out into a substructure that
+     * is shared with the translators to control the ISA.
      */
+    struct ARMISARegisters {
+        uint32_t id_isar0;
+        uint32_t id_isar1;
+        uint32_t id_isar2;
+        uint32_t id_isar3;
+        uint32_t id_isar4;
+        uint32_t id_isar5;
+        uint32_t id_isar6;
+        uint32_t mvfr0;
+        uint32_t mvfr1;
+        uint32_t mvfr2;
+        uint64_t id_aa64isar0;
+        uint64_t id_aa64isar1;
+        uint64_t id_aa64pfr0;
+        uint64_t id_aa64pfr1;
+    } isar;
     uint32_t midr;
     uint32_t revidr;
     uint32_t reset_fpsid;
-    uint32_t mvfr0;
-    uint32_t mvfr1;
-    uint32_t mvfr2;
     uint32_t ctr;
     uint32_t reset_sctlr;
     uint32_t id_pfr0;
@@ -808,21 +823,10 @@ struct ARMCPU {
     uint32_t id_mmfr2;
     uint32_t id_mmfr3;
     uint32_t id_mmfr4;
-    uint32_t id_isar0;
-    uint32_t id_isar1;
-    uint32_t id_isar2;
-    uint32_t id_isar3;
-    uint32_t id_isar4;
-    uint32_t id_isar5;
-    uint32_t id_isar6;
-    uint64_t id_aa64pfr0;
-    uint64_t id_aa64pfr1;
     uint64_t id_aa64dfr0;
     uint64_t id_aa64dfr1;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
-    uint64_t id_aa64isar0;
-    uint64_t id_aa64isar1;
     uint64_t id_aa64mmfr0;
     uint64_t id_aa64mmfr1;
     uint32_t dbgdidr;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 0d816fdd2c..0beefb05d4 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1055,17 +1055,17 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd5c: /* MMFR3.  */
         return cpu->id_mmfr3;
     case 0xd60: /* ISAR0.  */
-        return cpu->id_isar0;
+        return cpu->isar.id_isar0;
     case 0xd64: /* ISAR1.  */
-        return cpu->id_isar1;
+        return cpu->isar.id_isar1;
     case 0xd68: /* ISAR2.  */
-        return cpu->id_isar2;
+        return cpu->isar.id_isar2;
     case 0xd6c: /* ISAR3.  */
-        return cpu->id_isar3;
+        return cpu->isar.id_isar3;
     case 0xd70: /* ISAR4.  */
-        return cpu->id_isar4;
+        return cpu->isar.id_isar4;
     case 0xd74: /* ISAR5.  */
-        return cpu->id_isar5;
+        return cpu->isar.id_isar5;
     case 0xd78: /* CLIDR */
         return cpu->clidr;
     case 0xd7c: /* CTR */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cd48ad42d8..4f6756a4e2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -144,9 +144,9 @@ static void arm_cpu_reset(CPUState *s)
     g_hash_table_foreach(cpu->cp_regs, cp_reg_check_reset, cpu);
 
     env->vfp.xregs[ARM_VFP_FPSID] = cpu->reset_fpsid;
-    env->vfp.xregs[ARM_VFP_MVFR0] = cpu->mvfr0;
-    env->vfp.xregs[ARM_VFP_MVFR1] = cpu->mvfr1;
-    env->vfp.xregs[ARM_VFP_MVFR2] = cpu->mvfr2;
+    env->vfp.xregs[ARM_VFP_MVFR0] = cpu->isar.mvfr0;
+    env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
+    env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
     cpu->power_state = cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
     s->halted = cpu->start_powered_off;
@@ -938,7 +938,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * registers as well. These are id_pfr1[7:4] and id_aa64pfr0[15:12].
          */
         cpu->id_pfr1 &= ~0xf0;
-        cpu->id_aa64pfr0 &= ~0xf000;
+        cpu->isar.id_aa64pfr0 &= ~0xf000;
     }
 
     if (!cpu->has_el2) {
@@ -955,7 +955,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * registers if we don't have EL2. These are id_pfr1[15:12] and
          * id_aa64pfr0_el1[11:8].
          */
-        cpu->id_aa64pfr0 &= ~0xf00;
+        cpu->isar.id_aa64pfr0 &= ~0xf00;
         cpu->id_pfr1 &= ~0xf000;
     }
 
@@ -1151,8 +1151,8 @@ static void arm1136_r2_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
     cpu->midr = 0x4107b362;
     cpu->reset_fpsid = 0x410120b4;
-    cpu->mvfr0 = 0x11111111;
-    cpu->mvfr1 = 0x00000000;
+    cpu->isar.mvfr0 = 0x11111111;
+    cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
@@ -1162,11 +1162,11 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
     cpu->id_mmfr2 = 0x01222110;
-    cpu->id_isar0 = 0x00140011;
-    cpu->id_isar1 = 0x12002111;
-    cpu->id_isar2 = 0x11231111;
-    cpu->id_isar3 = 0x01102131;
-    cpu->id_isar4 = 0x141;
+    cpu->isar.id_isar0 = 0x00140011;
+    cpu->isar.id_isar1 = 0x12002111;
+    cpu->isar.id_isar2 = 0x11231111;
+    cpu->isar.id_isar3 = 0x01102131;
+    cpu->isar.id_isar4 = 0x141;
     cpu->reset_auxcr = 7;
 }
 
@@ -1183,8 +1183,8 @@ static void arm1136_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
     cpu->midr = 0x4117b363;
     cpu->reset_fpsid = 0x410120b4;
-    cpu->mvfr0 = 0x11111111;
-    cpu->mvfr1 = 0x00000000;
+    cpu->isar.mvfr0 = 0x11111111;
+    cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
@@ -1194,11 +1194,11 @@ static void arm1136_initfn(Object *obj)
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
     cpu->id_mmfr2 = 0x01222110;
-    cpu->id_isar0 = 0x00140011;
-    cpu->id_isar1 = 0x12002111;
-    cpu->id_isar2 = 0x11231111;
-    cpu->id_isar3 = 0x01102131;
-    cpu->id_isar4 = 0x141;
+    cpu->isar.id_isar0 = 0x00140011;
+    cpu->isar.id_isar1 = 0x12002111;
+    cpu->isar.id_isar2 = 0x11231111;
+    cpu->isar.id_isar3 = 0x01102131;
+    cpu->isar.id_isar4 = 0x141;
     cpu->reset_auxcr = 7;
 }
 
@@ -1216,8 +1216,8 @@ static void arm1176_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->midr = 0x410fb767;
     cpu->reset_fpsid = 0x410120b5;
-    cpu->mvfr0 = 0x11111111;
-    cpu->mvfr1 = 0x00000000;
+    cpu->isar.mvfr0 = 0x11111111;
+    cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
@@ -1227,11 +1227,11 @@ static void arm1176_initfn(Object *obj)
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
     cpu->id_mmfr2 = 0x01222100;
-    cpu->id_isar0 = 0x0140011;
-    cpu->id_isar1 = 0x12002111;
-    cpu->id_isar2 = 0x11231121;
-    cpu->id_isar3 = 0x01102131;
-    cpu->id_isar4 = 0x01141;
+    cpu->isar.id_isar0 = 0x0140011;
+    cpu->isar.id_isar1 = 0x12002111;
+    cpu->isar.id_isar2 = 0x11231121;
+    cpu->isar.id_isar3 = 0x01102131;
+    cpu->isar.id_isar4 = 0x01141;
     cpu->reset_auxcr = 7;
 }
 
@@ -1247,8 +1247,8 @@ static void arm11mpcore_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     cpu->midr = 0x410fb022;
     cpu->reset_fpsid = 0x410120b4;
-    cpu->mvfr0 = 0x11111111;
-    cpu->mvfr1 = 0x00000000;
+    cpu->isar.mvfr0 = 0x11111111;
+    cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
@@ -1257,11 +1257,11 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->id_mmfr0 = 0x01100103;
     cpu->id_mmfr1 = 0x10020302;
     cpu->id_mmfr2 = 0x01222000;
-    cpu->id_isar0 = 0x00100011;
-    cpu->id_isar1 = 0x12002111;
-    cpu->id_isar2 = 0x11221011;
-    cpu->id_isar3 = 0x01102131;
-    cpu->id_isar4 = 0x141;
+    cpu->isar.id_isar0 = 0x00100011;
+    cpu->isar.id_isar1 = 0x12002111;
+    cpu->isar.id_isar2 = 0x11221011;
+    cpu->isar.id_isar3 = 0x01102131;
+    cpu->isar.id_isar4 = 0x141;
     cpu->reset_auxcr = 1;
 }
 
@@ -1290,13 +1290,13 @@ static void cortex_m3_initfn(Object *obj)
     cpu->id_mmfr1 = 0x00000000;
     cpu->id_mmfr2 = 0x00000000;
     cpu->id_mmfr3 = 0x00000000;
-    cpu->id_isar0 = 0x01141110;
-    cpu->id_isar1 = 0x02111000;
-    cpu->id_isar2 = 0x21112231;
-    cpu->id_isar3 = 0x01111110;
-    cpu->id_isar4 = 0x01310102;
-    cpu->id_isar5 = 0x00000000;
-    cpu->id_isar6 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01141110;
+    cpu->isar.id_isar1 = 0x02111000;
+    cpu->isar.id_isar2 = 0x21112231;
+    cpu->isar.id_isar3 = 0x01111110;
+    cpu->isar.id_isar4 = 0x01310102;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
 }
 
 static void cortex_m4_initfn(Object *obj)
@@ -1317,13 +1317,13 @@ static void cortex_m4_initfn(Object *obj)
     cpu->id_mmfr1 = 0x00000000;
     cpu->id_mmfr2 = 0x00000000;
     cpu->id_mmfr3 = 0x00000000;
-    cpu->id_isar0 = 0x01141110;
-    cpu->id_isar1 = 0x02111000;
-    cpu->id_isar2 = 0x21112231;
-    cpu->id_isar3 = 0x01111110;
-    cpu->id_isar4 = 0x01310102;
-    cpu->id_isar5 = 0x00000000;
-    cpu->id_isar6 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01141110;
+    cpu->isar.id_isar1 = 0x02111000;
+    cpu->isar.id_isar2 = 0x21112231;
+    cpu->isar.id_isar3 = 0x01111110;
+    cpu->isar.id_isar4 = 0x01310102;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
 }
 
 static void cortex_m33_initfn(Object *obj)
@@ -1346,13 +1346,13 @@ static void cortex_m33_initfn(Object *obj)
     cpu->id_mmfr1 = 0x00000000;
     cpu->id_mmfr2 = 0x01000000;
     cpu->id_mmfr3 = 0x00000000;
-    cpu->id_isar0 = 0x01101110;
-    cpu->id_isar1 = 0x02212000;
-    cpu->id_isar2 = 0x20232232;
-    cpu->id_isar3 = 0x01111131;
-    cpu->id_isar4 = 0x01310132;
-    cpu->id_isar5 = 0x00000000;
-    cpu->id_isar6 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01101110;
+    cpu->isar.id_isar1 = 0x02212000;
+    cpu->isar.id_isar2 = 0x20232232;
+    cpu->isar.id_isar3 = 0x01111131;
+    cpu->isar.id_isar4 = 0x01310132;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
     cpu->clidr = 0x00000000;
     cpu->ctr = 0x8000c000;
 }
@@ -1397,13 +1397,13 @@ static void cortex_r5_initfn(Object *obj)
     cpu->id_mmfr1 = 0x00000000;
     cpu->id_mmfr2 = 0x01200000;
     cpu->id_mmfr3 = 0x0211;
-    cpu->id_isar0 = 0x02101111;
-    cpu->id_isar1 = 0x13112111;
-    cpu->id_isar2 = 0x21232141;
-    cpu->id_isar3 = 0x01112131;
-    cpu->id_isar4 = 0x0010142;
-    cpu->id_isar5 = 0x0;
-    cpu->id_isar6 = 0x0;
+    cpu->isar.id_isar0 = 0x02101111;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232141;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x0010142;
+    cpu->isar.id_isar5 = 0x0;
+    cpu->isar.id_isar6 = 0x0;
     cpu->mp_is_up = true;
     cpu->pmsav7_dregion = 16;
     define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
@@ -1438,8 +1438,8 @@ static void cortex_a8_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->midr = 0x410fc080;
     cpu->reset_fpsid = 0x410330c0;
-    cpu->mvfr0 = 0x11110222;
-    cpu->mvfr1 = 0x00011111;
+    cpu->isar.mvfr0 = 0x11110222;
+    cpu->isar.mvfr1 = 0x00011111;
     cpu->ctr = 0x82048004;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
@@ -1450,11 +1450,11 @@ static void cortex_a8_initfn(Object *obj)
     cpu->id_mmfr1 = 0x20000000;
     cpu->id_mmfr2 = 0x01202000;
     cpu->id_mmfr3 = 0x11;
-    cpu->id_isar0 = 0x00101111;
-    cpu->id_isar1 = 0x12112111;
-    cpu->id_isar2 = 0x21232031;
-    cpu->id_isar3 = 0x11112131;
-    cpu->id_isar4 = 0x00111142;
+    cpu->isar.id_isar0 = 0x00101111;
+    cpu->isar.id_isar1 = 0x12112111;
+    cpu->isar.id_isar2 = 0x21232031;
+    cpu->isar.id_isar3 = 0x11112131;
+    cpu->isar.id_isar4 = 0x00111142;
     cpu->dbgdidr = 0x15141000;
     cpu->clidr = (1 << 27) | (2 << 24) | 3;
     cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
@@ -1512,8 +1512,8 @@ static void cortex_a9_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CBAR);
     cpu->midr = 0x410fc090;
     cpu->reset_fpsid = 0x41033090;
-    cpu->mvfr0 = 0x11110222;
-    cpu->mvfr1 = 0x01111111;
+    cpu->isar.mvfr0 = 0x11110222;
+    cpu->isar.mvfr1 = 0x01111111;
     cpu->ctr = 0x80038003;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
@@ -1524,11 +1524,11 @@ static void cortex_a9_initfn(Object *obj)
     cpu->id_mmfr1 = 0x20000000;
     cpu->id_mmfr2 = 0x01230000;
     cpu->id_mmfr3 = 0x00002111;
-    cpu->id_isar0 = 0x00101111;
-    cpu->id_isar1 = 0x13112111;
-    cpu->id_isar2 = 0x21232041;
-    cpu->id_isar3 = 0x11112131;
-    cpu->id_isar4 = 0x00111142;
+    cpu->isar.id_isar0 = 0x00101111;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232041;
+    cpu->isar.id_isar3 = 0x11112131;
+    cpu->isar.id_isar4 = 0x00111142;
     cpu->dbgdidr = 0x35141000;
     cpu->clidr = (1 << 27) | (1 << 24) | 3;
     cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
@@ -1573,8 +1573,8 @@ static void cortex_a7_initfn(Object *obj)
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A7;
     cpu->midr = 0x410fc075;
     cpu->reset_fpsid = 0x41023075;
-    cpu->mvfr0 = 0x10110222;
-    cpu->mvfr1 = 0x11111111;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x11111111;
     cpu->ctr = 0x84448003;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
@@ -1590,11 +1590,11 @@ static void cortex_a7_initfn(Object *obj)
     /* a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
      * table 4-41 gives 0x02101110, which includes the arm div insns.
      */
-    cpu->id_isar0 = 0x02101110;
-    cpu->id_isar1 = 0x13112111;
-    cpu->id_isar2 = 0x21232041;
-    cpu->id_isar3 = 0x11112131;
-    cpu->id_isar4 = 0x10011142;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232041;
+    cpu->isar.id_isar3 = 0x11112131;
+    cpu->isar.id_isar4 = 0x10011142;
     cpu->dbgdidr = 0x3515f005;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
@@ -1619,8 +1619,8 @@ static void cortex_a15_initfn(Object *obj)
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A15;
     cpu->midr = 0x412fc0f1;
     cpu->reset_fpsid = 0x410430f0;
-    cpu->mvfr0 = 0x10110222;
-    cpu->mvfr1 = 0x11111111;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x11111111;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
@@ -1633,11 +1633,11 @@ static void cortex_a15_initfn(Object *obj)
     cpu->id_mmfr1 = 0x20000000;
     cpu->id_mmfr2 = 0x01240000;
     cpu->id_mmfr3 = 0x02102211;
-    cpu->id_isar0 = 0x02101110;
-    cpu->id_isar1 = 0x13112111;
-    cpu->id_isar2 = 0x21232041;
-    cpu->id_isar3 = 0x11112131;
-    cpu->id_isar4 = 0x10011142;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232041;
+    cpu->isar.id_isar3 = 0x11112131;
+    cpu->isar.id_isar4 = 0x10011142;
     cpu->dbgdidr = 0x3515f021;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 44fdf0f6fa..79e551b618 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -121,9 +121,9 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->midr = 0x411fd070;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-    cpu->mvfr0 = 0x10110222;
-    cpu->mvfr1 = 0x12111111;
-    cpu->mvfr2 = 0x00000043;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x12111111;
+    cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
@@ -134,18 +134,18 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->id_mmfr1 = 0x40000000;
     cpu->id_mmfr2 = 0x01260000;
     cpu->id_mmfr3 = 0x02102211;
-    cpu->id_isar0 = 0x02101110;
-    cpu->id_isar1 = 0x13112111;
-    cpu->id_isar2 = 0x21232042;
-    cpu->id_isar3 = 0x01112131;
-    cpu->id_isar4 = 0x00011142;
-    cpu->id_isar5 = 0x00011121;
-    cpu->id_isar6 = 0;
-    cpu->id_aa64pfr0 = 0x00002222;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00011142;
+    cpu->isar.id_isar5 = 0x00011121;
+    cpu->isar.id_isar6 = 0;
+    cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
     cpu->pmceid0 = 0x00000000;
     cpu->pmceid1 = 0x00000000;
-    cpu->id_aa64isar0 = 0x00011120;
+    cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
@@ -182,9 +182,9 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->midr = 0x410fd034;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-    cpu->mvfr0 = 0x10110222;
-    cpu->mvfr1 = 0x12111111;
-    cpu->mvfr2 = 0x00000043;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x12111111;
+    cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
@@ -195,16 +195,16 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->id_mmfr1 = 0x40000000;
     cpu->id_mmfr2 = 0x01260000;
     cpu->id_mmfr3 = 0x02102211;
-    cpu->id_isar0 = 0x02101110;
-    cpu->id_isar1 = 0x13112111;
-    cpu->id_isar2 = 0x21232042;
-    cpu->id_isar3 = 0x01112131;
-    cpu->id_isar4 = 0x00011142;
-    cpu->id_isar5 = 0x00011121;
-    cpu->id_isar6 = 0;
-    cpu->id_aa64pfr0 = 0x00002222;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00011142;
+    cpu->isar.id_isar5 = 0x00011121;
+    cpu->isar.id_isar6 = 0;
+    cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
-    cpu->id_aa64isar0 = 0x00011120;
+    cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
     cpu->dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
@@ -240,9 +240,9 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->midr = 0x410fd083;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034080;
-    cpu->mvfr0 = 0x10110222;
-    cpu->mvfr1 = 0x12111111;
-    cpu->mvfr2 = 0x00000043;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x12111111;
+    cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
@@ -253,17 +253,17 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->id_mmfr1 = 0x40000000;
     cpu->id_mmfr2 = 0x01260000;
     cpu->id_mmfr3 = 0x02102211;
-    cpu->id_isar0 = 0x02101110;
-    cpu->id_isar1 = 0x13112111;
-    cpu->id_isar2 = 0x21232042;
-    cpu->id_isar3 = 0x01112131;
-    cpu->id_isar4 = 0x00011142;
-    cpu->id_isar5 = 0x00011121;
-    cpu->id_aa64pfr0 = 0x00002222;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00011142;
+    cpu->isar.id_isar5 = 0x00011121;
+    cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
     cpu->pmceid0 = 0x00000000;
     cpu->pmceid1 = 0x00000000;
-    cpu->id_aa64isar0 = 0x00011120;
+    cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e3946562aa..342c802a95 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4873,7 +4873,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
-    uint64_t pfr0 = cpu->id_aa64pfr0;
+    uint64_t pfr0 = cpu->isar.id_aa64pfr0;
 
     if (env->gicv3state) {
         pfr0 |= 1 << 24;
@@ -4940,27 +4940,27 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_isar0 },
+              .resetvalue = cpu->isar.id_isar0 },
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_isar1 },
+              .resetvalue = cpu->isar.id_isar1 },
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_isar2 },
+              .resetvalue = cpu->isar.id_isar2 },
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_isar3 },
+              .resetvalue = cpu->isar.id_isar3 },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_isar4 },
+              .resetvalue = cpu->isar.id_isar4 },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_isar5 },
+              .resetvalue = cpu->isar.id_isar5 },
             { .name = "ID_MMFR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -4968,7 +4968,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_isar6 },
+              .resetvalue = cpu->isar.id_isar6 },
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, v6_idregs);
@@ -5039,7 +5039,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_aa64pfr1},
+              .resetvalue = cpu->isar.id_aa64pfr1},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -5100,11 +5100,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_aa64isar0 },
+              .resetvalue = cpu->isar.id_aa64isar0 },
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_aa64isar1 },
+              .resetvalue = cpu->isar.id_aa64isar1 },
             { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -5164,15 +5164,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->mvfr0 },
+              .resetvalue = cpu->isar.mvfr0 },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->mvfr1 },
+              .resetvalue = cpu->isar.mvfr1 },
             { .name = "MVFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->mvfr2 },
+              .resetvalue = cpu->isar.mvfr2 },
             { .name = "MVFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.17.2
