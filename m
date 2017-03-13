Received: from eggs.gnu.org ([2001:4830:134:3::10]:43059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4k-0000oh-IF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4i-0002Zo-Kv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4i-0002Za-BC
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:12 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D5AE68E0C
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:35 -0500
Message-Id: <20170313195547.21466-19-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/30] trace: Fix parameter types in hw/intc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/intc/apic_common.c |  2 +-
 hw/intc/trace-events  | 40 ++++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 7a6e771..7c41793 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -57,7 +57,7 @@ uint64_t cpu_get_apic_base(DeviceState *dev)
         trace_cpu_get_apic_base((uint64_t)s->apicbase);
         return s->apicbase;
     } else {
-        trace_cpu_get_apic_base(MSR_IA32_APICBASE_BSP);
+        trace_cpu_get_apic_base((uint64_t) MSR_IA32_APICBASE_BSP);
         return MSR_IA32_APICBASE_BSP;
     }
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 729c128..5e9dc56 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -18,18 +18,18 @@ apic_mem_writel(uint64_t addr, uint32_t val) "%"PRIx64" = %08x"
 ioapic_set_remote_irr(int n) "set remote irr for pin %d"
 ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %d vector %d"
 ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
-ioapic_mem_read(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem read addr 0x%"PRIx8" size 0x%"PRIx8" retval 0x%"PRIx32
-ioapic_mem_write(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
+ioapic_mem_read(hwaddr addr, uint8_t size, uint32_t val) "ioapic mem read addr 0x%" HWADDR_PRIx " size 0x%"PRIx8" retval 0x%"PRIx32
+ioapic_mem_write(hwaddr addr, uint8_t size, uint64_t val) "ioapic mem write addr 0x%" HWADDR_PRIx " size 0x%"PRIx8" val 0x%" PRIx64

 # hw/intc/slavio_intctl.c
 slavio_intctl_mem_readl(uint32_t cpu, uint64_t addr, uint32_t ret) "read cpu %d reg 0x%"PRIx64" = %x"
-slavio_intctl_mem_writel(uint32_t cpu, uint64_t addr, uint32_t val) "write cpu %d reg 0x%"PRIx64" = %x"
-slavio_intctl_mem_writel_clear(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Cleared cpu %d irq mask %x, curmask %x"
-slavio_intctl_mem_writel_set(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Set cpu %d irq mask %x, curmask %x"
+slavio_intctl_mem_writel(uint32_t cpu, uint64_t addr, uint64_t val) "write cpu %d reg 0x%"PRIx64" = %" PRIx64
+slavio_intctl_mem_writel_clear(uint32_t cpu, uint64_t val, uint32_t intreg_pending) "Cleared cpu %d irq mask %" PRIx64 ", curmask %x"
+slavio_intctl_mem_writel_set(uint32_t cpu, uint64_t val, uint32_t intreg_pending) "Set cpu %d irq mask %" PRIx64 ", curmask %x"
 slavio_intctlm_mem_readl(uint64_t addr, uint32_t ret) "read system reg 0x%"PRIx64" = %x"
-slavio_intctlm_mem_writel(uint64_t addr, uint32_t val) "write system reg 0x%"PRIx64" = %x"
-slavio_intctlm_mem_writel_enable(uint32_t val, uint32_t intregm_disabled) "Enabled master irq mask %x, curmask %x"
-slavio_intctlm_mem_writel_disable(uint32_t val, uint32_t intregm_disabled) "Disabled master irq mask %x, curmask %x"
+slavio_intctlm_mem_writel(uint64_t addr, uint64_t val) "write system reg 0x%"PRIx64" = %" PRIx64
+slavio_intctlm_mem_writel_enable(uint64_t val, uint32_t intregm_disabled) "Enabled master irq mask %" PRIx64 ", curmask %x"
+slavio_intctlm_mem_writel_disable(uint64_t val, uint32_t intregm_disabled) "Disabled master irq mask %" PRIx64 ", curmask %x"
 slavio_intctlm_mem_writel_target(uint32_t cpu) "Set master irq cpu %d"
 slavio_check_interrupts(uint32_t pending, uint32_t intregm_disabled) "pending %x disabled %x"
 slavio_set_irq(uint32_t target_cpu, int irq, uint32_t pil, int level) "Set cpu %d irq %d -> pil %d level %d"
@@ -40,7 +40,7 @@ grlib_irqmp_check_irqs(uint32_t pend, uint32_t force, uint32_t mask, uint32_t lv
 grlib_irqmp_ack(int intno) "interrupt:%d"
 grlib_irqmp_set_irq(int irq) "Raise CPU IRQ %d"
 grlib_irqmp_readl_unknown(uint64_t addr) "addr 0x%"PRIx64
-grlib_irqmp_writel_unknown(uint64_t addr, uint32_t value) "addr 0x%"PRIx64" value 0x%x"
+grlib_irqmp_writel_unknown(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%" PRIx64

 # hw/intc/lm32_pic.c
 lm32_pic_raise_irq(void) "Raise CPU interrupt"
@@ -77,8 +77,8 @@ flic_reset_failed(int err) "flic: reset failed %d"
 aspeed_vic_set_irq(int irq, int level) "Enabling IRQ %d: %d"
 aspeed_vic_update_fiq(int flags) "Raising FIQ: %d"
 aspeed_vic_update_irq(int flags) "Raising IRQ: %d"
-aspeed_vic_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
-aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_vic_read(uint64_t offset, unsigned size, uint64_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx64
+aspeed_vic_write(uint64_t offset, unsigned size, uint64_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx64

 # hw/intc/arm_gic.c
 gic_enable_irq(int irq) "irq %d enabled"
@@ -89,7 +89,7 @@ gic_update_set_irq(int cpu, const char *name, int level) "cpu[%d]: %s = %d"
 gic_acknowledge_irq(int cpu, int irq) "cpu %d acknowledged irq %d"

 # hw/intc/arm_gicv3_cpuif.c
-gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu %x value 0x%" PRIx64
+gicv3_icc_pmr_read(uint32_t cpu, uint32_t val) "GICv3 ICC_PMR read cpu %x value 0x%" PRIx32
 gicv3_icc_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR write cpu %x value 0x%" PRIx64
 gicv3_icc_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d read cpu %x value 0x%" PRIx64
 gicv3_icc_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d write cpu %x value 0x%" PRIx64
@@ -105,14 +105,14 @@ gicv3_icc_ctlr_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 read cpu
 gicv3_icc_ctlr_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 write cpu %x value 0x%" PRIx64
 gicv3_cpuif_update(uint32_t cpuid, int irq, int grp, int prio) "GICv3 CPU i/f %x HPPI update: irq %d group %d prio %d"
 gicv3_cpuif_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f %x HPPI update: setting FIQ %d IRQ %d"
-gicv3_icc_generate_sgi(uint32_t cpuid, int irq, int irm, uint32_t aff, uint32_t targetlist) "GICv3 CPU i/f %x generating SGI %d IRM %d target affinity 0x%xxx targetlist 0x%x"
+gicv3_icc_generate_sgi(uint32_t cpuid, int irq, int irm, uint64_t aff, uint32_t targetlist) "GICv3 CPU i/f %x generating SGI %d IRM %d target affinity 0x%" PRIx64 "xx targetlist 0x%x"
 gicv3_icc_iar0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR0 read cpu %x value 0x%" PRIx64
 gicv3_icc_iar1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR1 read cpu %x value 0x%" PRIx64
 gicv3_icc_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_EOIR%d write cpu %x value 0x%" PRIx64
 gicv3_icc_hppir0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR0 read cpu %x value 0x%" PRIx64
 gicv3_icc_hppir1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR1 read cpu %x value 0x%" PRIx64
 gicv3_icc_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICC_DIR write cpu %x value 0x%" PRIx64
-gicv3_icc_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_RPR read cpu %x value 0x%" PRIx64
+gicv3_icc_rpr_read(uint32_t cpu, int val) "GICv3 ICC_RPR read cpu %x value 0x%x"
 gicv3_ich_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d read cpu %x value 0x%" PRIx64
 gicv3_ich_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d write cpu %x value 0x%" PRIx64
 gicv3_ich_hcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 read cpu %x value 0x%" PRIx64
@@ -120,11 +120,11 @@ gicv3_ich_hcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 write cpu %x
 gicv3_ich_vmcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 read cpu %x value 0x%" PRIx64
 gicv3_ich_vmcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 write cpu %x value 0x%" PRIx64
 gicv3_ich_lr_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 read cpu %x value 0x%" PRIx64
-gicv3_ich_lr32_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d read cpu %x value 0x%" PRIx32
-gicv3_ich_lrc_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d read cpu %x value 0x%" PRIx32
+gicv3_ich_lr32_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d read cpu %x value 0x%" PRIx64
+gicv3_ich_lrc_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LRC%d read cpu %x value 0x%" PRIx64
 gicv3_ich_lr_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 write cpu %x value 0x%" PRIx64
-gicv3_ich_lr32_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d write cpu %x value 0x%" PRIx32
-gicv3_ich_lrc_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d write cpu %x value 0x%" PRIx32
+gicv3_ich_lr32_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d write cpu %x value 0x%" PRIx64
+gicv3_ich_lrc_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LRC%d write cpu %x value 0x%" PRIx64
 gicv3_ich_vtr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VTR read cpu %x value 0x%" PRIx64
 gicv3_ich_misr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_MISR read cpu %x value 0x%" PRIx64
 gicv3_ich_eisr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_EISR read cpu %x value 0x%" PRIx64
@@ -139,7 +139,7 @@ gicv3_icv_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d r
 gicv3_icv_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d write cpu %x value 0x%" PRIx64
 gicv3_icv_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR read cpu %x value 0x%" PRIx64
 gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu %x value 0x%" PRIx64
-gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu %x value 0x%" PRIx64
+gicv3_icv_rpr_read(uint32_t cpu, int val) "GICv3 ICV_RPR read cpu %x value 0x%x"
 gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu %x value 0x%" PRIx64
 gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu %x value 0x%" PRIx64
 gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu %x value 0x%" PRIx64
@@ -175,4 +175,4 @@ nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (pr
 nvic_complete_irq(int irq) "NVIC complete IRQ %d"
 nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
 nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nvic_sysreg_write(uint64_t addr, uint64_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.9.3
