Received: from eggs.gnu.org ([2001:4830:134:3::10]:36507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPA-0006ET-GH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP9-0004GX-7n
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOP8-0004Fo-W8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:11 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP8-00026n-16
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:10 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:52 +0000
Message-Id: <20180215183700.26101-13-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/20] hw/intc/armv7m_nvic: Implement cache ID
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

M profile cores have a similar setup for cache ID registers
to A profile:
 * Cache Level ID Register (CLIDR) is a fixed value
 * Cache Type Register (CTR) is a fixed value
 * Cache Size ID Registers (CCSIDR) are a bank of registers;
   which one you see is selected by the Cache Size Selection
   Register (CSSELR)

The only difference is that they're in the NVIC memory mapped
register space rather than being coprocessor registers.
Implement the M profile view of them.

Since neither Cortex-M3 nor Cortex-M4 implement caches,
we don't need to update their init functions and can leave
the ctr/clidr/ccsidr[] fields in their ARMCPU structs at zero.
Newer cores (like the Cortex-M33) will want to be able to
set these ID registers to non-zero values, though.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-6-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 26 ++++++++++++++++++++++++++
 hw/intc/armv7m_nvic.c | 16 ++++++++++++++++
 target/arm/machine.c  | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 51a3e16275..8938a7c953 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -496,6 +496,7 @@ typedef struct CPUARMState {
         uint32_t faultmask[M_REG_NUM_BANKS];
         uint32_t aircr; /* only holds r/w state if security extn implemented */
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
+        uint32_t csselr[M_REG_NUM_BANKS];
     } v7m;
 
     /* Information associated with an exception about to be taken:
@@ -1325,6 +1326,23 @@ FIELD(V7M_MPU_CTRL, ENABLE, 0, 1)
 FIELD(V7M_MPU_CTRL, HFNMIENA, 1, 1)
 FIELD(V7M_MPU_CTRL, PRIVDEFENA, 2, 1)
 
+/* v7M CLIDR bits */
+FIELD(V7M_CLIDR, CTYPE_ALL, 0, 21)
+FIELD(V7M_CLIDR, LOUIS, 21, 3)
+FIELD(V7M_CLIDR, LOC, 24, 3)
+FIELD(V7M_CLIDR, LOUU, 27, 3)
+FIELD(V7M_CLIDR, ICB, 30, 2)
+
+FIELD(V7M_CSSELR, IND, 0, 1)
+FIELD(V7M_CSSELR, LEVEL, 1, 3)
+/* We use the combination of InD and Level to index into cpu->ccsidr[];
+ * define a mask for this and check that it doesn't permit running off
+ * the end of the array.
+ */
+FIELD(V7M_CSSELR, INDEX, 0, 4)
+
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
+
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
@@ -2487,6 +2505,14 @@ static inline int arm_debug_target_el(CPUARMState *env)
     }
 }
 
+static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
+{
+    /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
+     * CSSELR is RAZ/WI.
+     */
+    return (cpu->clidr & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
+}
+
 static inline bool aa64_generate_debug_exceptions(CPUARMState *env)
 {
     if (arm_is_secure(env)) {
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index eb49fd77c7..040f3380ec 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1025,6 +1025,17 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         return cpu->id_isar4;
     case 0xd74: /* ISAR5.  */
         return cpu->id_isar5;
+    case 0xd78: /* CLIDR */
+        return cpu->clidr;
+    case 0xd7c: /* CTR */
+        return cpu->ctr;
+    case 0xd80: /* CSSIDR */
+    {
+        int idx = cpu->env.v7m.csselr[attrs.secure] & R_V7M_CSSELR_INDEX_MASK;
+        return cpu->ccsidr[idx];
+    }
+    case 0xd84: /* CSSELR */
+        return cpu->env.v7m.csselr[attrs.secure];
     /* TODO: Implement debug registers.  */
     case 0xd90: /* MPU_TYPE */
         /* Unified MPU; if the MPU is not present this value is zero */
@@ -1385,6 +1396,11 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         qemu_log_mask(LOG_UNIMP,
                       "NVIC: Aux fault status registers unimplemented\n");
         break;
+    case 0xd84: /* CSSELR */
+        if (!arm_v7m_csselr_razwi(cpu)) {
+            cpu->env.v7m.csselr[attrs.secure] = value & R_V7M_CSSELR_INDEX_MASK;
+        }
+        break;
     case 0xd90: /* MPU_TYPE */
         return; /* RO */
     case 0xd94: /* MPU_CTRL */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 2c8b43062f..cae63c2f98 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -191,6 +191,41 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
     }
 };
 
+/* CSSELR is in a subsection because we didn't implement it previously.
+ * Migration from an old implementation will leave it at zero, which
+ * is OK since the only CPUs in the old implementation make the
+ * register RAZ/WI.
+ * Since there was no version of QEMU which implemented the CSSELR for
+ * just non-secure, we transfer both banks here rather than putting
+ * the secure banked version in the m-security subsection.
+ */
+static bool csselr_vmstate_validate(void *opaque, int version_id)
+{
+    ARMCPU *cpu = opaque;
+
+    return cpu->env.v7m.csselr[M_REG_NS] <= R_V7M_CSSELR_INDEX_MASK
+        && cpu->env.v7m.csselr[M_REG_S] <= R_V7M_CSSELR_INDEX_MASK;
+}
+
+static bool m_csselr_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return !arm_v7m_csselr_razwi(cpu);
+}
+
+static const VMStateDescription vmstate_m_csselr = {
+    .name = "cpu/m/csselr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = m_csselr_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(env.v7m.csselr, ARMCPU, M_REG_NUM_BANKS),
+        VMSTATE_VALIDATE("CSSELR is valid", csselr_vmstate_validate),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
     .version_id = 4,
@@ -212,6 +247,7 @@ static const VMStateDescription vmstate_m = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_m_faultmask_primask,
+        &vmstate_m_csselr,
         NULL
     }
 };
-- 
2.16.1
