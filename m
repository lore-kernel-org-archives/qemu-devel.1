Received: from eggs.gnu.org ([209.51.188.92]:37464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h24ZM-0004Vb-S2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h24ZI-0006pC-AJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:45:04 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  8 Mar 2019 12:44:20 +1100
Message-Id: <20190308014420.29178-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5] spapr: Support NVIDIA V100 GPU with
 NVLink2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>

NVIDIA V100 GPUs have on-board RAM which is mapped into the host memory
space and accessible as normal RAM via an NVLink bus. The VFIO-PCI driver
implements special regions for such GPUs and emulates an NVLink bridge.
NVLink2-enabled POWER9 CPUs also provide address translation services
which includes an ATS shootdown (ATSD) register exported via the NVLink
bridge device.

This adds a quirk to VFIO to map the GPU memory and create an MR;
the new MR is stored in a PCI device as a QOM link. The sPAPR PCI uses
this to get the MR and map it to the system address space.
Another quirk does the same for ATSD.

This adds additional steps to sPAPR PHB setup:

1. Search for specific GPUs and NPUs, collect findings in
sPAPRPHBState::nvgpus, manage system address space mappings;

2. Add device-specific properties such as "ibm,npu", "ibm,gpu",
"memory-block", "link-speed" to advertise the NVLink2 function to
the guest;

3. Add "mmio-atsd" to vPHB to advertise the ATSD capability;

4. Add new memory blocks (with extra "linux,memory-usable" to prevent
the guest OS from accessing the new memory until it is onlined) and
npuphb# nodes representing an NPU unit for every vPHB as the GPU driver
uses it for link discovery.

This allocates space for GPU RAM and ATSD like we do for MMIOs by
adding 2 new parameters to the phb_placement() hook. Older machine types
set these to zero.

This puts new memory nodes in a separate NUMA node to replicate the host
system setup as the GPU driver relies on this.

This adds requirement similar to EEH - one IOMMU group per vPHB.
The reason for this is that ATSD registers belong to a physical NPU
so they cannot invalidate translations on GPUs attached to another NPU.
It is guaranteed by the host platform as it does not mix NVLink bridges
or GPUs from different NPU in the same IOMMU group. If more than one
IOMMU group is detected on a vPHB, this disables ATSD support for that
vPHB and prints a warning.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is based on David's ppc-for-4.0 +
applied but not pushed "iommu replay": https://patchwork.ozlabs.org/patch/1052644/
acked "vfio_info_cap public": https://patchwork.ozlabs.org/patch/1052645/


Changes:
v5:
* converted MRs to VFIOQuirk - this fixed leaks

v4:
* fixed ATSD placement
* fixed spapr_phb_unrealize() to do nvgpu cleanup
* replaced warn_report() with Error*

v3:
* moved GPU RAM above PCI MMIO limit
* renamed QOM property to nvlink2-tgt
* moved nvlink2 code to its own file

---

The example command line for redbud system:

pbuild/qemu-aiku1804le-ppc64/ppc64-softmmu/qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
-enable-kvm -m 384G \
-chardev socket,id=SOCKET0,server,nowait,host=localhost,port=40000 \
-mon chardev=SOCKET0,mode=control \
-smp 80,sockets=1,threads=4 \
-netdev "tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0" \
-device "virtio-net-pci,id=vnet0,mac=52:54:00:12:34:56,netdev=TAP0" \
img/vdisk0.img \
-device "vfio-pci,id=vfio0004_04_00_0,host=0004:04:00.0" \
-device "vfio-pci,id=vfio0006_00_00_0,host=0006:00:00.0" \
-device "vfio-pci,id=vfio0006_00_00_1,host=0006:00:00.1" \
-device "vfio-pci,id=vfio0006_00_00_2,host=0006:00:00.2" \
-device "vfio-pci,id=vfio0004_05_00_0,host=0004:05:00.0" \
-device "vfio-pci,id=vfio0006_00_01_0,host=0006:00:01.0" \
-device "vfio-pci,id=vfio0006_00_01_1,host=0006:00:01.1" \
-device "vfio-pci,id=vfio0006_00_01_2,host=0006:00:01.2" \
-device spapr-pci-host-bridge,id=phb1,index=1 \
-device "vfio-pci,id=vfio0035_03_00_0,host=0035:03:00.0" \
-device "vfio-pci,id=vfio0007_00_00_0,host=0007:00:00.0" \
-device "vfio-pci,id=vfio0007_00_00_1,host=0007:00:00.1" \
-device "vfio-pci,id=vfio0007_00_00_2,host=0007:00:00.2" \
-device "vfio-pci,id=vfio0035_04_00_0,host=0035:04:00.0" \
-device "vfio-pci,id=vfio0007_00_01_0,host=0007:00:01.0" \
-device "vfio-pci,id=vfio0007_00_01_1,host=0007:00:01.1" \
-device "vfio-pci,id=vfio0007_00_01_2,host=0007:00:01.2" -snapshot \
-machine pseries \
-L /home/aik/t/qemu-ppc64-bios/ -d guest_errors

Note that QEMU attaches PCI devices to the last added vPHB so first
8 devices - 4:04:00.0 till 6:00:01.2 - go to the default vPHB, and
35:03:00.0..7:00:01.2 to the vPHB with id=phb1.
---
 hw/ppc/Makefile.objs        |   2 +-
 hw/vfio/pci.h               |   2 +
 include/hw/pci-host/spapr.h |  45 ++++
 include/hw/ppc/spapr.h      |   3 +-
 hw/ppc/spapr.c              |  29 ++-
 hw/ppc/spapr_pci.c          |  19 ++
 hw/ppc/spapr_pci_nvlink2.c  | 441 ++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c        | 132 +++++++++++
 hw/vfio/pci.c               |  14 ++
 hw/vfio/trace-events        |   4 +
 10 files changed, 686 insertions(+), 5 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_nvlink2.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 1111b218a048..636e717f207c 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -9,7 +9,7 @@ obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
-obj-y += spapr_pci_vfio.o
+obj-y += spapr_pci_vfio.o spapr_pci_nvlink2.o
 endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b1ae4c07549a..706c30443617 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -194,6 +194,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
                                Error **errp);
+int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
+int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
 
 void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index ab0e3a0a6f72..912fb36807ee 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -87,6 +87,9 @@ struct sPAPRPHBState {
     uint32_t mig_liobn;
     hwaddr mig_mem_win_addr, mig_mem_win_size;
     hwaddr mig_io_win_addr, mig_io_win_size;
+    hwaddr nv2_gpa_win_addr;
+    hwaddr nv2_atsd_win_addr;
+    struct spapr_phb_pci_nvgpu_config *nvgpus;
 };
 
 #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
@@ -105,6 +108,22 @@ struct sPAPRPHBState {
 
 #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
 
+#define SPAPR_PCI_NV2RAM64_WIN_BASE  SPAPR_PCI_LIMIT
+#define SPAPR_PCI_NV2RAM64_WIN_SIZE  (2 * TiB) /* For up to 6 GPUs 256GB each */
+
+/* Max number of these GPUsper a physical box */
+#define NVGPU_MAX_NUM                6
+/* Max number of NVLinks per GPU in any physical box */
+#define NVGPU_MAX_LINKS              3
+
+/*
+ * GPU RAM starts at 64TiB so huge DMA window to cover it all ends at 128TiB
+ * which is enough. We do not need DMA for ATSD so we put them at 128TiB.
+ */
+#define SPAPR_PCI_NV2ATSD_WIN_BASE   (128 * TiB)
+#define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * \
+                                      64 * KiB)
+
 static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
@@ -135,6 +154,13 @@ int spapr_phb_vfio_eeh_get_state(sPAPRPHBState *sphb, int *state);
 int spapr_phb_vfio_eeh_reset(sPAPRPHBState *sphb, int option);
 int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
+void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb, Error **errp);
+void spapr_phb_nvgpu_free(sPAPRPHBState *sphb);
+void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void *fdt, int bus_off,
+                                 Error **errp);
+void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb, void *fdt);
+void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int offset,
+                                        sPAPRPHBState *sphb);
 #else
 static inline bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
 {
@@ -161,6 +187,25 @@ static inline int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb)
 static inline void spapr_phb_vfio_reset(DeviceState *qdev)
 {
 }
+static inline void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb, Error **errp)
+{
+}
+static inline void spapr_phb_nvgpu_free(sPAPRPHBState *sphb)
+{
+}
+static inline void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void *fdt,
+                                               int bus_off, Error **errp)
+{
+}
+static inline void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb,
+                                                   void *fdt)
+{
+}
+static inline void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt,
+                                                      int offset,
+                                                      sPAPRPHBState *sphb)
+{
+}
 #endif
 
 void spapr_phb_dma_reset(sPAPRPHBState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f117a7ce6e90..5600f52b4386 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -122,7 +122,8 @@ struct sPAPRMachineClass {
     void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
                           hwaddr *mmio32, hwaddr *mmio64,
-                          unsigned n_dma, uint32_t *liobns, Error **errp);
+                          unsigned n_dma, uint32_t *liobns, hwaddr *nv2gpa,
+                          hwaddr *nv2atsd, Error **errp);
     sPAPRResizeHPT resize_hpt_default;
     sPAPRCapabilities default_caps;
     sPAPRIrq *irq;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 78fcc357ea68..73d25f5c96ac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3935,7 +3935,9 @@ static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     smc->phb_placement(spapr, sphb->index,
                        &sphb->buid, &sphb->io_win_addr,
                        &sphb->mem_win_addr, &sphb->mem64_win_addr,
-                       windows_supported, sphb->dma_liobn, errp);
+                       windows_supported, sphb->dma_liobn,
+                       &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win_addr,
+                       errp);
 }
 
 static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -4136,7 +4138,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
 static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
                                 uint64_t *buid, hwaddr *pio,
                                 hwaddr *mmio32, hwaddr *mmio64,
-                                unsigned n_dma, uint32_t *liobns, Error **errp)
+                                unsigned n_dma, uint32_t *liobns,
+                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
 {
     /*
      * New-style PHB window placement.
@@ -4181,6 +4184,9 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
     *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
     *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
     *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
+
+    *nv2gpa = SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM64_WIN_SIZE;
+    *nv2atsd = SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATSD_WIN_SIZE;
 }
 
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
@@ -4385,6 +4391,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
 /*
  * pseries-3.1
  */
+static void phb_placement_3_1(sPAPRMachineState *spapr, uint32_t index,
+                              uint64_t *buid, hwaddr *pio,
+                              hwaddr *mmio32, hwaddr *mmio64,
+                              unsigned n_dma, uint32_t *liobns,
+                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
+{
+    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma, liobns,
+                        nv2gpa, nv2atsd, errp);
+    *nv2gpa = 0;
+    *nv2atsd = 0;
+}
+
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4404,6 +4422,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
+    smc->phb_placement = phb_placement_3_1;
 }
 
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
@@ -4535,7 +4554,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
 static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
                               uint64_t *buid, hwaddr *pio,
                               hwaddr *mmio32, hwaddr *mmio64,
-                              unsigned n_dma, uint32_t *liobns, Error **errp)
+                              unsigned n_dma, uint32_t *liobns,
+                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
 {
     /* Legacy PHB placement for pseries-2.7 and earlier machine types */
     const uint64_t base_buid = 0x800000020000000ULL;
@@ -4579,6 +4599,9 @@ static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
      * fallback behaviour of automatically splitting a large "32-bit"
      * window into contiguous 32-bit and 64-bit windows
      */
+
+    *nv2gpa = 0;
+    *nv2atsd = 0;
 }
 
 static void spapr_machine_2_7_class_options(MachineClass *mc)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 69059c36ebb6..e908c9930d1a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1355,6 +1355,8 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
     if (sphb->pcie_ecs && pci_is_express(dev)) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
     }
+
+    spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
 }
 
 /* create OF node for pci device and required OF DT properties */
@@ -1589,6 +1591,8 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
     int i;
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
 
+    spapr_phb_nvgpu_free(sphb);
+
     if (sphb->msi) {
         g_hash_table_unref(sphb->msi);
         sphb->msi = NULL;
@@ -1877,8 +1881,14 @@ void spapr_phb_dma_reset(sPAPRPHBState *sphb)
 static void spapr_phb_reset(DeviceState *qdev)
 {
     sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(qdev);
+    Error *errp = NULL;
 
     spapr_phb_dma_reset(sphb);
+    spapr_phb_nvgpu_free(sphb);
+    spapr_phb_nvgpu_setup(sphb, &errp);
+    if (errp) {
+        error_report_err(errp);
+    }
 
     /* Reset the IOMMU state */
     object_child_foreach(OBJECT(qdev), spapr_phb_children_reset, NULL);
@@ -1911,6 +1921,8 @@ static Property spapr_phb_properties[] = {
                      pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
                      pcie_ecs, true),
+    DEFINE_PROP_UINT64("gpa", sPAPRPHBState, nv2_gpa_win_addr, 0),
+    DEFINE_PROP_UINT64("atsd", sPAPRPHBState, nv2_atsd_win_addr, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2191,6 +2203,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
     PCIBus *bus = PCI_HOST_BRIDGE(phb)->bus;
     sPAPRFDT s_fdt;
     sPAPRDRConnector *drc;
+    Error *errp = NULL;
 
     /* Start populating the FDT */
     nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
@@ -2283,6 +2296,12 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
         return ret;
     }
 
+    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &errp);
+    if (errp) {
+        error_report_err(errp);
+    }
+    spapr_phb_nvgpu_ram_populate_dt(phb, fdt);
+
     return 0;
 }
 
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
new file mode 100644
index 000000000000..902cf4a39f80
--- /dev/null
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -0,0 +1,441 @@
+/*
+ * QEMU sPAPR PCI for NVLink2 pass through
+ *
+ * Copyright (c) 2019 Alexey Kardashevskiy, IBM Corporation.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/spapr.h"
+#include "qemu/error-report.h"
+#include "hw/ppc/fdt.h"
+#include "hw/pci/pci_bridge.h"
+
+#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
+                                     (((phb)->index) << 16) | ((pdev)->devfn))
+#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
+                                     (((phb)->index) << 16))
+/* NVLink2 wants a separate NUMA node for its RAM */
+#define GPURAM_ASSOCIATIVITY(phb, n) (255 - ((phb)->index * 3 + (n)))
+#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8) | \
+                                     ((gn) << 4) | (nn))
+
+struct spapr_phb_pci_nvgpu_config {
+    uint64_t nv2_ram_current;
+    uint64_t nv2_atsd_current;
+    int num; /* number of non empty (i.e. tgt!=0) entries in slots[] */
+    struct spapr_phb_pci_nvgpu_slot {
+        uint64_t tgt;
+        uint64_t gpa;
+        PCIDevice *gpdev;
+        int linknum;
+        struct {
+            uint64_t atsd_gpa;
+            PCIDevice *npdev;
+            uint32_t link_speed;
+        } links[NVGPU_MAX_LINKS];
+    } slots[NVGPU_MAX_NUM];
+    Error *errp;
+};
+
+static struct spapr_phb_pci_nvgpu_slot *
+spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_config *nvgpus,
+                         uint64_t tgt)
+{
+    int i;
+
+    /* Search for partially collected "slot" */
+    for (i = 0; i < nvgpus->num; ++i) {
+        if (nvgpus->slots[i].tgt == tgt) {
+            return &nvgpus->slots[i];
+        }
+    }
+
+    if (nvgpus->num == ARRAY_SIZE(nvgpus->slots)) {
+        return NULL;
+    }
+
+    i = nvgpus->num;
+    nvgpus->slots[i].tgt = tgt;
+    ++nvgpus->num;
+
+    return &nvgpus->slots[i];
+}
+
+static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_config *nvgpus,
+                                    PCIDevice *pdev, uint64_t tgt,
+                                    MemoryRegion *mr, Error **errp)
+{
+    struct spapr_phb_pci_nvgpu_slot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
+
+    if (!nvslot) {
+        error_setg(errp, "Found too many NVLink bridges per GPU");
+        return;
+    }
+    g_assert(!nvslot->gpdev);
+    nvslot->gpdev = pdev;
+
+    nvslot->gpa = nvgpus->nv2_ram_current;
+    nvgpus->nv2_ram_current += memory_region_size(mr);
+}
+
+static void spapr_pci_collect_nvnpu(struct spapr_phb_pci_nvgpu_config *nvgpus,
+                                    PCIDevice *pdev, uint64_t tgt,
+                                    MemoryRegion *mr, Error **errp)
+{
+    struct spapr_phb_pci_nvgpu_slot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
+    int j;
+
+    if (!nvslot) {
+        error_setg(errp, "Found too many NVLink bridges per GPU");
+        return;
+    }
+
+    j = nvslot->linknum;
+    if (j == ARRAY_SIZE(nvslot->links)) {
+        error_setg(errp, "Found too many NVLink2 bridges");
+        return;
+    }
+    ++nvslot->linknum;
+
+    g_assert(!nvslot->links[j].npdev);
+    nvslot->links[j].npdev = pdev;
+    nvslot->links[j].atsd_gpa = nvgpus->nv2_atsd_current;
+    nvgpus->nv2_atsd_current += memory_region_size(mr);
+    nvslot->links[j].link_speed =
+        object_property_get_uint(OBJECT(pdev), "nvlink2-link-speed", NULL);
+}
+
+static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pdev,
+                                        void *opaque)
+{
+    PCIBus *sec_bus;
+    Object *po = OBJECT(pdev);
+    uint64_t tgt = object_property_get_uint(po, "nvlink2-tgt", NULL);
+
+    if (tgt) {
+        Error *local_err = NULL;
+        struct spapr_phb_pci_nvgpu_config *nvgpus = opaque;
+        Object *mr_gpu = object_property_get_link(po, "nvlink2-mr[0]", NULL);
+        Object *mr_npu = object_property_get_link(po, "nvlink2-atsd-mr[0]",
+                                                  NULL);
+
+        g_assert(mr_gpu || mr_npu);
+        if (mr_gpu) {
+            spapr_pci_collect_nvgpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_gpu),
+                                    &local_err);
+        } else {
+            spapr_pci_collect_nvnpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_npu),
+                                    &local_err);
+        }
+        error_propagate(&nvgpus->errp, local_err);
+    }
+    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=
+         PCI_HEADER_TYPE_BRIDGE)) {
+        return;
+    }
+
+    sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (!sec_bus) {
+        return;
+    }
+
+    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
+                        spapr_phb_pci_collect_nvgpu, opaque);
+}
+
+void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb, Error **errp)
+{
+    int i, j, valid_gpu_num;
+    PCIBus *bus;
+
+    /* Search for GPUs and NPUs */
+    if (!sphb->nv2_gpa_win_addr || !sphb->nv2_atsd_win_addr) {
+        return;
+    }
+
+    sphb->nvgpus = g_new0(struct spapr_phb_pci_nvgpu_config, 1);
+    sphb->nvgpus->nv2_ram_current = sphb->nv2_gpa_win_addr;
+    sphb->nvgpus->nv2_atsd_current = sphb->nv2_atsd_win_addr;
+
+    bus = PCI_HOST_BRIDGE(sphb)->bus;
+    pci_for_each_device(bus, pci_bus_num(bus),
+                        spapr_phb_pci_collect_nvgpu, sphb->nvgpus);
+
+    if (sphb->nvgpus->errp) {
+        error_propagate(errp, sphb->nvgpus->errp);
+        sphb->nvgpus->errp = NULL;
+        goto cleanup_exit;
+    }
+
+    /* Add found GPU RAM and ATSD MRs if found */
+    for (i = 0, valid_gpu_num = 0; i < sphb->nvgpus->num; ++i) {
+        Object *nvmrobj;
+        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+
+        if (!nvslot->gpdev) {
+            continue;
+        }
+        nvmrobj = object_property_get_link(OBJECT(nvslot->gpdev),
+                                           "nvlink2-mr[0]", NULL);
+        /* ATSD is pointless without GPU RAM MR so skip those */
+        if (!nvmrobj) {
+            continue;
+        }
+
+        ++valid_gpu_num;
+        memory_region_add_subregion(get_system_memory(), nvslot->gpa,
+                                    MEMORY_REGION(nvmrobj));
+
+        for (j = 0; j < nvslot->linknum; ++j) {
+            Object *atsdmrobj;
+
+            atsdmrobj = object_property_get_link(OBJECT(nvslot->links[j].npdev),
+                                                 "nvlink2-atsd-mr[0]", NULL);
+            if (!atsdmrobj) {
+                continue;
+            }
+            memory_region_add_subregion(get_system_memory(),
+                                        nvslot->links[j].atsd_gpa,
+                                        MEMORY_REGION(atsdmrobj));
+        }
+    }
+
+    if (valid_gpu_num) {
+        return;
+    }
+    /* We did not find any interesting GPU */
+cleanup_exit:
+    g_free(sphb->nvgpus);
+    sphb->nvgpus = NULL;
+}
+
+void spapr_phb_nvgpu_free(sPAPRPHBState *sphb)
+{
+    int i, j;
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    for (i = 0; i < sphb->nvgpus->num; ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+        Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
+                                                    "nvlink2-mr[0]", NULL);
+
+        if (nv_mrobj) {
+            memory_region_del_subregion(get_system_memory(),
+                                        MEMORY_REGION(nv_mrobj));
+        }
+        for (j = 0; j < nvslot->linknum; ++j) {
+            PCIDevice *npdev = nvslot->links[j].npdev;
+            Object *atsd_mrobj;
+            atsd_mrobj = object_property_get_link(OBJECT(npdev),
+                                                  "nvlink2-atsd-mr[0]", NULL);
+            if (atsd_mrobj) {
+                memory_region_del_subregion(get_system_memory(),
+                                            MEMORY_REGION(atsd_mrobj));
+            }
+        }
+    }
+    g_free(sphb->nvgpus);
+    sphb->nvgpus = NULL;
+}
+
+void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void *fdt, int bus_off,
+                                 Error **errp)
+{
+    int i, j, atsdnum = 0;
+    uint64_t atsd[8]; /* The existing limitation of known guests */
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    for (i = 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(atsd)); ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+
+        if (!nvslot->gpdev) {
+            continue;
+        }
+        for (j = 0; j < nvslot->linknum; ++j) {
+            if (!nvslot->links[j].atsd_gpa) {
+                continue;
+            }
+
+            if (atsdnum == ARRAY_SIZE(atsd)) {
+                error_setg(errp, "Only %ld ATSD registers supported",
+                            ARRAY_SIZE(atsd));
+                break;
+            }
+            atsd[atsdnum] = cpu_to_be64(nvslot->links[j].atsd_gpa);
+            ++atsdnum;
+        }
+    }
+
+    if (!atsdnum) {
+        error_setg(errp, "No ATSD registers found");
+        return;
+    }
+
+    if (!spapr_phb_eeh_available(sphb)) {
+        /*
+         * ibm,mmio-atsd contains ATSD registers; these belong to an NPU PHB
+         * which we do not emulate as a separate device. Instead we put
+         * ibm,mmio-atsd to the vPHB with GPU and make sure that we do not
+         * put GPUs from different IOMMU groups to the same vPHB to ensure
+         * that the guest will use ATSDs from the corresponding NPU.
+         */
+        error_prepend(errp, "ATSD requires separate vPHB per GPU IOMMU group");
+        return;
+    }
+
+    _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd", atsd,
+                      atsdnum * sizeof(atsd[0]))));
+}
+
+void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb, void *fdt)
+{
+    int i, j, linkidx, npuoff;
+    char *npuname;
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    npuname = g_strdup_printf("npuphb%d", sphb->index);
+    npuoff = fdt_add_subnode(fdt, 0, npuname);
+    _FDT(npuoff);
+    _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
+    _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
+    /* Advertise NPU as POWER9 so the guest can enable NPU2 contexts */
+    _FDT((fdt_setprop_string(fdt, npuoff, "compatible", "ibm,power9-npu")));
+    g_free(npuname);
+
+    for (i = 0, linkidx = 0; i < sphb->nvgpus->num; ++i) {
+        for (j = 0; j < sphb->nvgpus->slots[i].linknum; ++j) {
+            char *linkname = g_strdup_printf("link@%d", linkidx);
+            int off = fdt_add_subnode(fdt, npuoff, linkname);
+
+            _FDT(off);
+            /* _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx))); */
+            _FDT((fdt_setprop_string(fdt, off, "compatible",
+                                     "ibm,npu-link")));
+            _FDT((fdt_setprop_cell(fdt, off, "phandle",
+                                   PHANDLE_NVLINK(sphb, i, j))));
+            _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index", linkidx)));
+            g_free(linkname);
+            ++linkidx;
+        }
+    }
+
+    /* Add memory nodes for GPU RAM and mark them unusable */
+    for (i = 0; i < sphb->nvgpus->num; ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+        Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
+                                                    "nvlink2-mr[0]", NULL);
+        uint32_t at = cpu_to_be32(GPURAM_ASSOCIATIVITY(sphb, i));
+        uint32_t associativity[] = { cpu_to_be32(0x4), at, at, at, at };
+        uint64_t size = object_property_get_uint(nv_mrobj, "size", NULL);
+        uint64_t mem_reg[2] = { cpu_to_be64(nvslot->gpa), cpu_to_be64(size) };
+        char *mem_name = g_strdup_printf("memory@%lx", nvslot->gpa);
+        int off = fdt_add_subnode(fdt, 0, mem_name);
+
+        _FDT(off);
+        _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
+        _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
+        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
+                          sizeof(associativity))));
+
+        _FDT((fdt_setprop_string(fdt, off, "compatible",
+                                 "ibm,coherent-device-memory")));
+
+        mem_reg[1] = cpu_to_be64(0);
+        _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg,
+                          sizeof(mem_reg))));
+        _FDT((fdt_setprop_cell(fdt, off, "phandle",
+                               PHANDLE_GPURAM(sphb, i))));
+        g_free(mem_name);
+    }
+
+}
+
+void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int offset,
+                                        sPAPRPHBState *sphb)
+{
+    int i, j;
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    for (i = 0; i < sphb->nvgpus->num; ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+
+        /* Skip "slot" without attached GPU */
+        if (!nvslot->gpdev) {
+            continue;
+        }
+        if (dev == nvslot->gpdev) {
+            uint32_t npus[nvslot->linknum];
+
+            for (j = 0; j < nvslot->linknum; ++j) {
+                PCIDevice *npdev = nvslot->links[j].npdev;
+
+                npus[j] = cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
+            }
+            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
+                             j * sizeof(npus[0])));
+            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
+                                   PHANDLE_PCIDEV(sphb, dev))));
+            continue;
+        }
+
+        for (j = 0; j < nvslot->linknum; ++j) {
+            if (dev != nvslot->links[j].npdev) {
+                continue;
+            }
+
+            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
+                                   PHANDLE_PCIDEV(sphb, dev))));
+            _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
+                                  PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
+            _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
+                                   PHANDLE_NVLINK(sphb, i, j))));
+            /*
+             * If we ever want to emulate GPU RAM at the same location as on
+             * the host - here is the encoding GPA->TGT:
+             *
+             * gta  = ((sphb->nv2_gpa >> 42) & 0x1) << 42;
+             * gta |= ((sphb->nv2_gpa >> 45) & 0x3) << 43;
+             * gta |= ((sphb->nv2_gpa >> 49) & 0x3) << 45;
+             * gta |= sphb->nv2_gpa & ((1UL << 43) - 1);
+             */
+            _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
+                                  PHANDLE_GPURAM(sphb, i)));
+            _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
+                                 nvslot->tgt));
+            _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
+                                  nvslot->links[j].link_speed));
+        }
+    }
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 40a12001f580..99d4180a5479 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -2180,3 +2180,135 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return 0;
 }
+
+static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
+                                     const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint64_t tgt = (uint64_t) opaque;
+    visit_type_uint64(v, name, &tgt, errp);
+}
+
+static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
+                                                 const char *name,
+                                                 void *opaque, Error **errp)
+{
+    uint32_t link_speed = (uint32_t)(uint64_t) opaque;
+    visit_type_uint32(v, name, &link_speed, errp);
+}
+
+int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
+{
+    int ret;
+    void *p;
+    struct vfio_region_info *nv2reg = NULL;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_region_info_cap_nvlink2_ssatgt *cap;
+    VFIOQuirk *quirk;
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
+                                   PCI_VENDOR_ID_NVIDIA,
+                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
+                                   &nv2reg);
+    if (ret) {
+        return ret;
+    }
+
+    hdr = vfio_get_region_info_cap(nv2reg, VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
+    if (!hdr) {
+        ret = -ENODEV;
+        goto free_exit;
+    }
+    cap = (void *) hdr;
+
+    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
+             MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
+
+    if (!p) {
+        ret = -errno;
+        goto free_exit;
+    }
+
+    quirk = vfio_quirk_alloc(1);
+    memory_region_init_ram_ptr(&quirk->mem[0], OBJECT(vdev), "nvlink2-mr",
+                               nv2reg->size, p);
+    QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
+
+    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
+                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
+                        (void *) cap->tgt, NULL);
+    trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
+                                          nv2reg->size);
+free_exit:
+    g_free(nv2reg);
+
+    return ret;
+}
+
+int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
+{
+    int ret;
+    void *p;
+    struct vfio_region_info *atsdreg = NULL;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_region_info_cap_nvlink2_ssatgt *captgt;
+    struct vfio_region_info_cap_nvlink2_lnkspd *capspeed;
+    VFIOQuirk *quirk;
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
+                                   PCI_VENDOR_ID_IBM,
+                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
+                                   &atsdreg);
+    if (ret) {
+        return ret;
+    }
+
+    hdr = vfio_get_region_info_cap(atsdreg,
+                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
+    if (!hdr) {
+        ret = -ENODEV;
+        goto free_exit;
+    }
+    captgt = (void *) hdr;
+
+    hdr = vfio_get_region_info_cap(atsdreg,
+                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
+    if (!hdr) {
+        ret = -ENODEV;
+        goto free_exit;
+    }
+    capspeed = (void *) hdr;
+
+    /* Some NVLink bridges may not have assigned ATSD */
+    if (atsdreg->size) {
+        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
+                 MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
+        if (!p) {
+            ret = -errno;
+            goto free_exit;
+        }
+
+        quirk = vfio_quirk_alloc(1);
+        memory_region_init_ram_device_ptr(&quirk->mem[0], OBJECT(vdev),
+                                          "nvlink2-atsd-mr", atsdreg->size, p);
+        QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
+    }
+
+    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
+                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
+                        (void *) captgt->tgt, NULL);
+    trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captgt->tgt,
+                                              atsdreg->size);
+
+    object_property_add(OBJECT(vdev), "nvlink2-link-speed", "uint32",
+                        vfio_pci_nvlink2_get_link_speed, NULL, NULL,
+                        (void *) (uint64_t) capspeed->link_speed, NULL);
+    trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
+                                              capspeed->link_speed);
+free_exit:
+    g_free(atsdreg);
+
+    return ret;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dd12f363915d..07aa141aabe6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3069,6 +3069,20 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if (vdev->vendor_id == PCI_VENDOR_ID_NVIDIA) {
+        ret = vfio_pci_nvidia_v100_ram_init(vdev, errp);
+        if (ret && ret != -ENODEV) {
+            error_report("Failed to setup NVIDIA V100 GPU RAM");
+        }
+    }
+
+    if (vdev->vendor_id == PCI_VENDOR_ID_IBM) {
+        ret = vfio_pci_nvlink2_init(vdev, errp);
+        if (ret && ret != -ENODEV) {
+            error_report("Failed to setup NVlink2 bridge");
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index cf1e8868182b..88841e9a61da 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -87,6 +87,10 @@ vfio_pci_igd_opregion_enabled(const char *name) "%s"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 
+vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
+vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
+vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
+
 # hw/vfio/common.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
-- 
2.17.1
