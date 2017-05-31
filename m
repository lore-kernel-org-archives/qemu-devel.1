Received: from eggs.gnu.org ([2001:4830:134:3::10]:41113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dG09W-0001ht-5w
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dG09U-0001Jr-Jm
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:42:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dG09U-0001JR-Al
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39E4F6371B
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:42:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 31 May 2017 17:42:35 +0800
Message-Id: <1496223756-24929-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1496223756-24929-1-git-send-email-peterx@redhat.com>
References: <1496223756-24929-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] msi: remove msi_nonbroken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

It was used before to know whether specific board has correct emulation
support on MSI, and originally we set this to true when the board is not
buggy with MSI.

That's not really what we should do.

For broken emulated boards, we should either blacklist it (using
something like msi_broken, when really needed), or better, fix all the
bugs that lead to the broken. No matter what, it would not be a good
idea to do it in the reversed order (correctly emulated boards setup
msi_nonbroken), then we will never know which board is really broken.

For now, let's remove msi_nonbroken once and for all.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/kvm/apic.c             |  4 ----
 hw/i386/xen/xen_apic.c         |  1 -
 hw/intc/apic.c                 |  2 --
 hw/intc/arm_gicv2m.c           |  1 -
 hw/intc/arm_gicv3_its_common.c |  2 --
 hw/intc/openpic.c              |  1 -
 hw/intc/openpic_kvm.c          |  1 -
 hw/pci/msi.c                   | 21 ---------------------
 hw/pci/msix.c                  |  6 ------
 hw/ppc/spapr.c                 |  6 +-----
 hw/ppc/spapr_pci.c             | 12 +++++-------
 hw/s390x/s390-pci-bus.c        |  1 -
 include/hw/pci/msi.h           |  2 --
 13 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1df6d26..ec790e8 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -223,10 +223,6 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_io(&s->io_memory, OBJECT(s), &kvm_apic_io_ops, s,
                           "kvm-apic-msi", APIC_SPACE_SIZE);
-
-    if (kvm_has_gsi_routing()) {
-        msi_nonbroken = true;
-    }
 }
 
 static void kvm_apic_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 55769eb..90303a3 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -44,7 +44,6 @@ static void xen_apic_realize(DeviceState *dev, Error **errp)
     s->vapic_control = 0;
     memory_region_init_io(&s->io_memory, OBJECT(s), &xen_apic_io_ops, s,
                           "xen-apic-msi", APIC_SPACE_SIZE);
-    msi_nonbroken = true;
 }
 
 static void xen_apic_set_base(APICCommonState *s, uint64_t val)
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index fe15fb6..034d729 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -890,8 +890,6 @@ static void apic_realize(DeviceState *dev, Error **errp)
 
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, apic_timer, s);
     local_apics[s->id] = s;
-
-    msi_nonbroken = true;
 }
 
 static void apic_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 3922fbc..9ecfaf3 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -151,7 +151,6 @@ static void gicv2m_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->spi[i]);
     }
 
-    msi_nonbroken = true;
     kvm_gsi_direct_mapping = true;
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 9d67c5c..38282c5 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -106,8 +106,6 @@ void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops)
     memory_region_add_subregion(&s->iomem_main, ITS_CONTROL_SIZE,
                                 &s->iomem_its_translation);
     sysbus_init_mmio(sbd, &s->iomem_main);
-
-    msi_nonbroken = true;
 }
 
 static void gicv3_its_common_reset(DeviceState *dev)
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 4349e45..c17836b 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1377,7 +1377,6 @@ static void fsl_common_init(OpenPICState *opp)
 
     opp->irq_msi = 224;
 
-    msi_nonbroken = true;
     for (i = 0; i < opp->fsl->max_ext; i++) {
         opp->src[i].level = false;
     }
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 0518e01..4b0575d 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -242,7 +242,6 @@ static void kvm_openpic_realize(DeviceState *dev, Error **errp)
     memory_listener_register(&opp->mem_listener, &address_space_memory);
 
     /* indicate pic capabilities */
-    msi_nonbroken = true;
     kvm_kernel_irqchip = true;
     kvm_async_interrupts_allowed = true;
 
diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index a87b227..82f8a21 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -35,22 +35,6 @@
 
 #define PCI_MSI_VECTORS_MAX     32
 
-/*
- * Flag for interrupt controllers to declare broken MSI/MSI-X support.
- * values: false - broken; true - non-broken.
- *
- * Setting this flag to false will remove MSI/MSI-X capability from all devices.
- *
- * It is preferable for controllers to set this to true (non-broken) even if
- * they do not actually support MSI/MSI-X: guests normally probe the controller
- * type and do not attempt to enable MSI/MSI-X with interrupt controllers not
- * supporting such, so removing the capability is not required, and
- * it seems cleaner to have a given device look the same for all boards.
- *
- * TODO: some existing controllers violate the above rule. Identify and fix them.
- */
-bool msi_nonbroken;
-
 /* If we get rid of cap allocator, we won't need this. */
 static inline uint8_t msi_cap_sizeof(uint16_t flags)
 {
@@ -191,11 +175,6 @@ int msi_init(struct PCIDevice *dev, uint8_t offset,
     uint8_t cap_size;
     int config_offset;
 
-    if (!msi_nonbroken) {
-        error_setg(errp, "MSI is not supported by interrupt controller");
-        return -ENOTSUP;
-    }
-
     MSI_DEV_PRINTF(dev,
                    "init offset: 0x%"PRIx8" vector: %"PRId8
                    " 64bit %d mask %d\n",
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index bb54e8b..183e28d 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -269,12 +269,6 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
     unsigned table_size, pba_size;
     uint8_t *config;
 
-    /* Nothing to do if MSI is not supported by interrupt controller */
-    if (!msi_nonbroken) {
-        error_setg(errp, "MSI-X is not supported by interrupt controller");
-        return -ENOTSUP;
-    }
-
     if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
         error_setg(errp, "The number of MSI-X vectors is invalid");
         return -EINVAL;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab3aab1..941526a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -835,9 +835,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
                           RTAS_EVENT_SCAN_RATE));
 
-    if (msi_nonbroken) {
-        _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
-    }
+    _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
 
     /*
      * According to PAPR, rtas ibm,os-term does not guarantee a return
@@ -2056,8 +2054,6 @@ static void ppc_spapr_init(MachineState *machine)
     long load_limit, fw_size;
     char *filename;
 
-    msi_nonbroken = true;
-
     QLIST_INIT(&spapr->phbs);
     QTAILQ_INIT(&spapr->pending_dimm_unplugs);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e4daf8d..edeea35 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2251,13 +2251,11 @@ void spapr_pci_rtas_init(void)
                         rtas_ibm_read_pci_config);
     spapr_rtas_register(RTAS_IBM_WRITE_PCI_CONFIG, "ibm,write-pci-config",
                         rtas_ibm_write_pci_config);
-    if (msi_nonbroken) {
-        spapr_rtas_register(RTAS_IBM_QUERY_INTERRUPT_SOURCE_NUMBER,
-                            "ibm,query-interrupt-source-number",
-                            rtas_ibm_query_interrupt_source_number);
-        spapr_rtas_register(RTAS_IBM_CHANGE_MSI, "ibm,change-msi",
-                            rtas_ibm_change_msi);
-    }
+    spapr_rtas_register(RTAS_IBM_QUERY_INTERRUPT_SOURCE_NUMBER,
+                        "ibm,query-interrupt-source-number",
+                        rtas_ibm_query_interrupt_source_number);
+    spapr_rtas_register(RTAS_IBM_CHANGE_MSI, "ibm,change-msi",
+                        rtas_ibm_change_msi);
 
     spapr_rtas_register(RTAS_IBM_SET_EEH_OPTION,
                         "ibm,set-eeh-option",
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5651483..687d9a5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -876,7 +876,6 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
     k->init = s390_pcihost_init;
     hc->plug = s390_pcihost_hot_plug;
     hc->unplug = s390_pcihost_hot_unplug;
-    msi_nonbroken = true;
 }
 
 static const TypeInfo s390_pcihost_info = {
diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
index 4837bcf..2f82bfe 100644
--- a/include/hw/pci/msi.h
+++ b/include/hw/pci/msi.h
@@ -29,8 +29,6 @@ struct MSIMessage {
     uint32_t data;
 };
 
-extern bool msi_nonbroken;
-
 void msi_set_message(PCIDevice *dev, MSIMessage msg);
 MSIMessage msi_get_message(PCIDevice *dev, unsigned int vector);
 bool msi_enabled(const PCIDevice *dev);
-- 
2.7.4
