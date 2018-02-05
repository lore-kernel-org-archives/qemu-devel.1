Received: from eggs.gnu.org ([2001:4830:134:3::10]:40033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSw-000662-IN
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSv-0007Ex-CG
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:38 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Feb 2018 10:57:17 +0000
Message-Id: <20180205105720.14620-6-peter.maydell@linaro.org>
In-Reply-To: <20180205105720.14620-1-peter.maydell@linaro.org>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/8] hw/intc/armv7m_nvic: Implement cache ID
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

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
---
The CSSELR/CCSIDR parts are a bit under-motivated, because
the Cortex-M33 doesn't implement caches either and so they
are RAZ/WI for that as well as M3/M4, though I'd written all
the code before I realized that. This will be helpful if
we ever need a Cortex-M7 model, though (which does have
a couple of CSSIDR array entries).
---
 target/arm/cpu.h      |  9 +++++++++
 hw/intc/armv7m_nvic.c | 13 +++++++++++++
 target/arm/machine.c  | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f21f68ec4a..99c7cb996f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -453,6 +453,7 @@ typedef struct CPUARMState {
         uint32_t faultmask[M_REG_NUM_BANKS];
         uint32_t aircr; /* only holds r/w state if security extn implemented */
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
+        uint32_t csselr[M_REG_NUM_BANKS];
     } v7m;
 
     /* Information associated with an exception about to be taken:
@@ -2443,6 +2444,14 @@ static inline int arm_debug_target_el(CPUARMState *env)
     }
 }
 
+static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
+{
+    /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
+     * CSSELR is RAZ/WI.
+     */
+    return (cpu->clidr & 0x001fffff) != 0;
+}
+
 static inline bool aa64_generate_debug_exceptions(CPUARMState *env)
 {
     if (arm_is_secure(env)) {
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index eb49fd77c7..cc83c9e553 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1025,6 +1025,14 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         return cpu->id_isar4;
     case 0xd74: /* ISAR5.  */
         return cpu->id_isar5;
+    case 0xd78: /* CLIDR */
+        return cpu->clidr;
+    case 0xd7c: /* CTR */
+        return cpu->ctr;
+    case 0xd80: /* CSSIDR */
+        return cpu->ccsidr[cpu->env.v7m.csselr[attrs.secure] & 0xf];
+    case 0xd84: /* CSSELR */
+        return cpu->env.v7m.csselr[attrs.secure];
     /* TODO: Implement debug registers.  */
     case 0xd90: /* MPU_TYPE */
         /* Unified MPU; if the MPU is not present this value is zero */
@@ -1385,6 +1393,11 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         qemu_log_mask(LOG_UNIMP,
                       "NVIC: Aux fault status registers unimplemented\n");
         break;
+    case 0xd84: /* CSSELR */
+        if (!arm_v7m_csselr_razwi(cpu)) {
+            cpu->env.v7m.csselr[attrs.secure] = value & 0xf;
+        }
+        break;
     case 0xd90: /* MPU_TYPE */
         return; /* RO */
     case 0xd94: /* MPU_CTRL */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index a85c2430d3..968ec30b4a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -108,6 +108,41 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
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
+    return cpu->env.v7m.csselr[M_REG_NS] < sizeof(cpu->ccsidr)
+        && cpu->env.v7m.csselr[M_REG_S] < sizeof(cpu->ccsidr);
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
@@ -129,6 +164,7 @@ static const VMStateDescription vmstate_m = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_m_faultmask_primask,
+        &vmstate_m_csselr,
         NULL
     }
 };
-- 
2.16.1
