Received: from eggs.gnu.org ([209.51.188.92]:56233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goqtO-0002Tc-KM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goqtN-0006Uc-KF
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:31:06 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 15:30:49 +0100
Message-Id: <1548858649-26208-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc: Move ppc40x_*reset() functions from
 ppc405_uc.c to ppc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yang.zhong@intel.com

Currently, it is not possible to build a QEMU binary without the
ppc405_uc.c file, even if you do not want to have the embedded machines
in the binary. This is bad since it's quite a bit of code and this code
pulls in some more dependencies (e.g. via the usage of serial_mm_init())
which would not be needed otherwise - especially with the upcoming
Kconfig-style configuration system for QEMU.

The only functions from this file which are really always required for
linking are the ppc40x_*reset() functions, so move these functions to
ppc.c, close to the ppc40x_set_irq() function that calls them. Now we
can flag ppc405_uc.c and ppc4xx_devs.c with the CONFIG_PPC4XX config
switch, too.

And while we're at it, replace the printf()s in these ppc40x_*reset()
functions with proper calls to qemu_log_mask().

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/Makefile.objs |  3 +--
 hw/ppc/ppc.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/ppc405_uc.c   | 58 ----------------------------------------------------
 3 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 4e0c1c0..1e753de 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -13,8 +13,7 @@ obj-y += spapr_pci_vfio.o
 endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
-obj-y += ppc4xx_devs.o ppc405_uc.o
-obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o ppc405_boards.o
+obj-$(CONFIG_PPC4XX) += ppc4xx_devs.o ppc4xx_pci.o ppc405_uc.o ppc405_boards.o
 obj-$(CONFIG_PPC4XX) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
 obj-$(CONFIG_SAM460EX) += sam460ex.o
 # PReP
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ec4be25..98b409f 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -310,6 +310,62 @@ void ppcPOWER7_irq_init(PowerPCCPU *cpu)
 }
 #endif /* defined(TARGET_PPC64) */
 
+void ppc40x_core_reset(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong dbsr;
+
+    qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC core\n");
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
+    dbsr = env->spr[SPR_40x_DBSR];
+    dbsr &= ~0x00000300;
+    dbsr |= 0x00000100;
+    env->spr[SPR_40x_DBSR] = dbsr;
+}
+
+void ppc40x_chip_reset(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong dbsr;
+
+    qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC chip\n");
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
+    /* XXX: TODO reset all internal peripherals */
+    dbsr = env->spr[SPR_40x_DBSR];
+    dbsr &= ~0x00000300;
+    dbsr |= 0x00000200;
+    env->spr[SPR_40x_DBSR] = dbsr;
+}
+
+void ppc40x_system_reset(PowerPCCPU *cpu)
+{
+    qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC system\n");
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+void store_40x_dbcr0(CPUPPCState *env, uint32_t val)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+
+    switch ((val >> 28) & 0x3) {
+    case 0x0:
+        /* No action */
+        break;
+    case 0x1:
+        /* Core reset */
+        ppc40x_core_reset(cpu);
+        break;
+    case 0x2:
+        /* Chip reset */
+        ppc40x_chip_reset(cpu);
+        break;
+    case 0x3:
+        /* System reset */
+        ppc40x_system_reset(cpu);
+        break;
+    }
+}
+
 /* PowerPC 40x internal IRQ controller */
 static void ppc40x_set_irq(void *opaque, int pin, int level)
 {
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 8d3a797..3ae7f6d 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1156,64 +1156,6 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq irqs[5])
 }
 
 /*****************************************************************************/
-/* SPR */
-void ppc40x_core_reset(PowerPCCPU *cpu)
-{
-    CPUPPCState *env = &cpu->env;
-    target_ulong dbsr;
-
-    printf("Reset PowerPC core\n");
-    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
-    dbsr = env->spr[SPR_40x_DBSR];
-    dbsr &= ~0x00000300;
-    dbsr |= 0x00000100;
-    env->spr[SPR_40x_DBSR] = dbsr;
-}
-
-void ppc40x_chip_reset(PowerPCCPU *cpu)
-{
-    CPUPPCState *env = &cpu->env;
-    target_ulong dbsr;
-
-    printf("Reset PowerPC chip\n");
-    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_RESET);
-    /* XXX: TODO reset all internal peripherals */
-    dbsr = env->spr[SPR_40x_DBSR];
-    dbsr &= ~0x00000300;
-    dbsr |= 0x00000200;
-    env->spr[SPR_40x_DBSR] = dbsr;
-}
-
-void ppc40x_system_reset(PowerPCCPU *cpu)
-{
-    printf("Reset PowerPC system\n");
-    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-}
-
-void store_40x_dbcr0 (CPUPPCState *env, uint32_t val)
-{
-    PowerPCCPU *cpu = ppc_env_get_cpu(env);
-
-    switch ((val >> 28) & 0x3) {
-    case 0x0:
-        /* No action */
-        break;
-    case 0x1:
-        /* Core reset */
-        ppc40x_core_reset(cpu);
-        break;
-    case 0x2:
-        /* Chip reset */
-        ppc40x_chip_reset(cpu);
-        break;
-    case 0x3:
-        /* System reset */
-        ppc40x_system_reset(cpu);
-        break;
-    }
-}
-
-/*****************************************************************************/
 /* PowerPC 405CR */
 enum {
     PPC405CR_CPC0_PLLMR  = 0x0B0,
-- 
1.8.3.1
