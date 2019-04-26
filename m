Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D844C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4E5206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j/cNOIy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4E5206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuBe-0007wR-Bh
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:18:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0X-0005SX-NJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0T-0004Im-9A
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:49 -0400
Received: from ozlabs.org ([203.11.71.1]:37025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0S-00042c-In; Fri, 26 Apr 2019 02:06:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tj47Qpz9s70; Fri, 26 Apr 2019 16:06:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258793;
	bh=Vqp+UUVZcNcufeM160DuaCcqBJMFkeTinRFy/CoGGxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/cNOIy7cBQEJ3xn2cuUHzOhrJeqkzZizXvuc4JQhSJ+Ag4qq/tobAsDjHTajC/By
	GY8iVUujl8x6KcQvrzjTDOEwjOkahqKq8kvcmC7ktmbyKg6qD1rtvPsGyYjn8tL7/t
	14TGT10cx2ukmHb1DfYljkmLOeq4sMFnSENcA+KU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:05:52 +1000
Message-Id: <20190426060627.18153-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 01/36] spapr: Support NVIDIA V100 GPU with
 NVLink2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, gkurz@kaod.org, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426060552.IEhqzq74JHSaB_qMaj3A6UO1Za4LA9IhW0DruRGy3Sc@z>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

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

This puts new memory nodes in a separate NUMA node to as the GPU RAM
needs to be configured equally distant from any other node in the system.
Unlike the host setup which assigns numa ids from 255 downwards, this
adds new NUMA nodes after the user configures nodes or from 1 if none
were configured.

This adds requirement similar to EEH - one IOMMU group per vPHB.
The reason for this is that ATSD registers belong to a physical NPU
so they cannot invalidate translations on GPUs attached to another NPU.
It is guaranteed by the host platform as it does not mix NVLink bridges
or GPUs from different NPU in the same IOMMU group. If more than one
IOMMU group is detected on a vPHB, this disables ATSD support for that
vPHB and prints a warning.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for vfio portions]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <20190312082103.130561-1-aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs        |   2 +-
 hw/ppc/spapr.c              |  48 +++-
 hw/ppc/spapr_pci.c          |  19 ++
 hw/ppc/spapr_pci_nvlink2.c  | 450 ++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c        | 131 +++++++++++
 hw/vfio/pci.c               |  14 ++
 hw/vfio/pci.h               |   2 +
 hw/vfio/trace-events        |   4 +
 include/hw/pci-host/spapr.h |  45 ++++
 include/hw/ppc/spapr.h      |   5 +-
 10 files changed, 711 insertions(+), 9 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_nvlink2.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 1111b218a0..636e717f20 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -9,7 +9,7 @@ obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
-obj-y +=3D spapr_pci_vfio.o
+obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
 endif
 obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
 # PowerPC 4xx boards
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b52b82d298..b81e237635 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1034,12 +1034,13 @@ static void spapr_dt_rtas(SpaprMachineState *spap=
r, void *fdt)
         0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
         cpu_to_be32(max_cpus / smp_threads),
     };
+    uint32_t maxdomain =3D cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
     uint32_t maxdomains[] =3D {
         cpu_to_be32(4),
-        cpu_to_be32(0),
-        cpu_to_be32(0),
-        cpu_to_be32(0),
-        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1),
+        maxdomain,
+        maxdomain,
+        maxdomain,
+        cpu_to_be32(spapr->gpu_numa_id),
     };
=20
     _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
@@ -1698,6 +1699,16 @@ static void spapr_machine_reset(void)
         spapr_irq_msi_reset(spapr);
     }
=20
+    /*
+     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA n=
ode.
+     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() whic=
h is
+     * called from vPHB reset handler so we initialize the counter here.
+     * If no NUMA is configured from the QEMU side, we start from 1 as G=
PU RAM
+     * must be equally distant from any other node.
+     * The final value of spapr->gpu_numa_id is going to be written to
+     * max-associativity-domains in spapr_build_fdt().
+     */
+    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
     qemu_devices_reset();
=20
     /*
@@ -3907,7 +3918,9 @@ static void spapr_phb_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
     smc->phb_placement(spapr, sphb->index,
                        &sphb->buid, &sphb->io_win_addr,
                        &sphb->mem_win_addr, &sphb->mem64_win_addr,
-                       windows_supported, sphb->dma_liobn, errp);
+                       windows_supported, sphb->dma_liobn,
+                       &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win_addr=
,
+                       errp);
 }
=20
 static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev=
,
@@ -4108,7 +4121,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch=
_ids(MachineState *machine)
 static void spapr_phb_placement(SpaprMachineState *spapr, uint32_t index=
,
                                 uint64_t *buid, hwaddr *pio,
                                 hwaddr *mmio32, hwaddr *mmio64,
-                                unsigned n_dma, uint32_t *liobns, Error =
**errp)
+                                unsigned n_dma, uint32_t *liobns,
+                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error *=
*errp)
 {
     /*
      * New-style PHB window placement.
@@ -4153,6 +4167,9 @@ static void spapr_phb_placement(SpaprMachineState *=
spapr, uint32_t index,
     *pio =3D SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
     *mmio32 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
     *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
+
+    *nv2gpa =3D SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM64=
_WIN_SIZE;
+    *nv2atsd =3D SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATSD_=
WIN_SIZE;
 }
=20
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
@@ -4357,6 +4374,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
 /*
  * pseries-3.1
  */
+static void phb_placement_3_1(SpaprMachineState *spapr, uint32_t index,
+                              uint64_t *buid, hwaddr *pio,
+                              hwaddr *mmio32, hwaddr *mmio64,
+                              unsigned n_dma, uint32_t *liobns,
+                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **e=
rrp)
+{
+    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma, =
liobns,
+                        nv2gpa, nv2atsd, errp);
+    *nv2gpa =3D 0;
+    *nv2atsd =3D 0;
+}
+
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
     SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
@@ -4372,6 +4401,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
     smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
+    smc->phb_placement =3D phb_placement_3_1;
 }
=20
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
@@ -4503,7 +4533,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
 static void phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
                               uint64_t *buid, hwaddr *pio,
                               hwaddr *mmio32, hwaddr *mmio64,
-                              unsigned n_dma, uint32_t *liobns, Error **=
errp)
+                              unsigned n_dma, uint32_t *liobns,
+                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **e=
rrp)
 {
     /* Legacy PHB placement for pseries-2.7 and earlier machine types */
     const uint64_t base_buid =3D 0x800000020000000ULL;
@@ -4547,6 +4578,9 @@ static void phb_placement_2_7(SpaprMachineState *sp=
apr, uint32_t index,
      * fallback behaviour of automatically splitting a large "32-bit"
      * window into contiguous 32-bit and 64-bit windows
      */
+
+    *nv2gpa =3D 0;
+    *nv2atsd =3D 0;
 }
=20
 static void spapr_machine_2_7_class_options(MachineClass *mc)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f62e6833b8..d6d0a7115c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1355,6 +1355,8 @@ static void spapr_populate_pci_child_dt(PCIDevice *=
dev, void *fdt, int offset,
     if (sphb->pcie_ecs && pci_is_express(dev)) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", =
0x1));
     }
+
+    spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
 }
=20
 /* create OF node for pci device and required OF DT properties */
@@ -1587,6 +1589,8 @@ static void spapr_phb_unrealize(DeviceState *dev, E=
rror **errp)
     int i;
     const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
=20
+    spapr_phb_nvgpu_free(sphb);
+
     if (sphb->msi) {
         g_hash_table_unref(sphb->msi);
         sphb->msi =3D NULL;
@@ -1898,8 +1902,14 @@ void spapr_phb_dma_reset(SpaprPhbState *sphb)
 static void spapr_phb_reset(DeviceState *qdev)
 {
     SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
+    Error *errp =3D NULL;
=20
     spapr_phb_dma_reset(sphb);
+    spapr_phb_nvgpu_free(sphb);
+    spapr_phb_nvgpu_setup(sphb, &errp);
+    if (errp) {
+        error_report_err(errp);
+    }
=20
     /* Reset the IOMMU state */
     object_child_foreach(OBJECT(qdev), spapr_phb_children_reset, NULL);
@@ -1932,6 +1942,8 @@ static Property spapr_phb_properties[] =3D {
                      pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pcie-extended-configuration-space", SpaprPhbState,
                      pcie_ecs, true),
+    DEFINE_PROP_UINT64("gpa", SpaprPhbState, nv2_gpa_win_addr, 0),
+    DEFINE_PROP_UINT64("atsd", SpaprPhbState, nv2_atsd_win_addr, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -2212,6 +2224,7 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
     PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
     SpaprFdt s_fdt;
     SpaprDrc *drc;
+    Error *errp =3D NULL;
=20
     /* Start populating the FDT */
     nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
@@ -2304,6 +2317,12 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint=
32_t intc_phandle, void *fdt,
         return ret;
     }
=20
+    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &errp);
+    if (errp) {
+        error_report_err(errp);
+    }
+    spapr_phb_nvgpu_ram_populate_dt(phb, fdt);
+
     return 0;
 }
=20
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
new file mode 100644
index 0000000000..eda8c752aa
--- /dev/null
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -0,0 +1,450 @@
+/*
+ * QEMU sPAPR PCI for NVLink2 pass through
+ *
+ * Copyright (c) 2019 Alexey Kardashevskiy, IBM Corporation.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
+                                     (((phb)->index) << 16) | ((pdev)->d=
evfn))
+#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
+                                     (((phb)->index) << 16))
+#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8)=
 | \
+                                     ((gn) << 4) | (nn))
+
+#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
+
+struct spapr_phb_pci_nvgpu_config {
+    uint64_t nv2_ram_current;
+    uint64_t nv2_atsd_current;
+    int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] *=
/
+    struct spapr_phb_pci_nvgpu_slot {
+        uint64_t tgt;
+        uint64_t gpa;
+        unsigned numa_id;
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
+spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_config *nvgpus, uint64_t=
 tgt)
+{
+    int i;
+
+    /* Search for partially collected "slot" */
+    for (i =3D 0; i < nvgpus->num; ++i) {
+        if (nvgpus->slots[i].tgt =3D=3D tgt) {
+            return &nvgpus->slots[i];
+        }
+    }
+
+    if (nvgpus->num =3D=3D ARRAY_SIZE(nvgpus->slots)) {
+        return NULL;
+    }
+
+    i =3D nvgpus->num;
+    nvgpus->slots[i].tgt =3D tgt;
+    ++nvgpus->num;
+
+    return &nvgpus->slots[i];
+}
+
+static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
+                                    PCIDevice *pdev, uint64_t tgt,
+                                    MemoryRegion *mr, Error **errp)
+{
+    MachineState *machine =3D MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
+    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
+
+    if (!nvslot) {
+        error_setg(errp, "Found too many GPUs per vPHB");
+        return;
+    }
+    g_assert(!nvslot->gpdev);
+    nvslot->gpdev =3D pdev;
+
+    nvslot->gpa =3D nvgpus->nv2_ram_current;
+    nvgpus->nv2_ram_current +=3D memory_region_size(mr);
+    nvslot->numa_id =3D spapr->gpu_numa_id;
+    ++spapr->gpu_numa_id;
+}
+
+static void spapr_pci_collect_nvnpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
+                                    PCIDevice *pdev, uint64_t tgt,
+                                    MemoryRegion *mr, Error **errp)
+{
+    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
+    int j;
+
+    if (!nvslot) {
+        error_setg(errp, "Found too many NVLink bridges per vPHB");
+        return;
+    }
+
+    j =3D nvslot->linknum;
+    if (j =3D=3D ARRAY_SIZE(nvslot->links)) {
+        error_setg(errp, "Found too many NVLink bridges per GPU");
+        return;
+    }
+    ++nvslot->linknum;
+
+    g_assert(!nvslot->links[j].npdev);
+    nvslot->links[j].npdev =3D pdev;
+    nvslot->links[j].atsd_gpa =3D nvgpus->nv2_atsd_current;
+    nvgpus->nv2_atsd_current +=3D memory_region_size(mr);
+    nvslot->links[j].link_speed =3D
+        object_property_get_uint(OBJECT(pdev), "nvlink2-link-speed", NUL=
L);
+}
+
+static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pdev,
+                                        void *opaque)
+{
+    PCIBus *sec_bus;
+    Object *po =3D OBJECT(pdev);
+    uint64_t tgt =3D object_property_get_uint(po, "nvlink2-tgt", NULL);
+
+    if (tgt) {
+        Error *local_err =3D NULL;
+        struct spapr_phb_pci_nvgpu_config *nvgpus =3D opaque;
+        Object *mr_gpu =3D object_property_get_link(po, "nvlink2-mr[0]",=
 NULL);
+        Object *mr_npu =3D object_property_get_link(po, "nvlink2-atsd-mr=
[0]",
+                                                  NULL);
+
+        g_assert(mr_gpu || mr_npu);
+        if (mr_gpu) {
+            spapr_pci_collect_nvgpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_=
gpu),
+                                    &local_err);
+        } else {
+            spapr_pci_collect_nvnpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_=
npu),
+                                    &local_err);
+        }
+        error_propagate(&nvgpus->errp, local_err);
+    }
+    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
+         PCI_HEADER_TYPE_BRIDGE)) {
+        return;
+    }
+
+    sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (!sec_bus) {
+        return;
+    }
+
+    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
+                        spapr_phb_pci_collect_nvgpu, opaque);
+}
+
+void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **errp)
+{
+    int i, j, valid_gpu_num;
+    PCIBus *bus;
+
+    /* Search for GPUs and NPUs */
+    if (!sphb->nv2_gpa_win_addr || !sphb->nv2_atsd_win_addr) {
+        return;
+    }
+
+    sphb->nvgpus =3D g_new0(struct spapr_phb_pci_nvgpu_config, 1);
+    sphb->nvgpus->nv2_ram_current =3D sphb->nv2_gpa_win_addr;
+    sphb->nvgpus->nv2_atsd_current =3D sphb->nv2_atsd_win_addr;
+
+    bus =3D PCI_HOST_BRIDGE(sphb)->bus;
+    pci_for_each_device(bus, pci_bus_num(bus),
+                        spapr_phb_pci_collect_nvgpu, sphb->nvgpus);
+
+    if (sphb->nvgpus->errp) {
+        error_propagate(errp, sphb->nvgpus->errp);
+        sphb->nvgpus->errp =3D NULL;
+        goto cleanup_exit;
+    }
+
+    /* Add found GPU RAM and ATSD MRs if found */
+    for (i =3D 0, valid_gpu_num =3D 0; i < sphb->nvgpus->num; ++i) {
+        Object *nvmrobj;
+        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+
+        if (!nvslot->gpdev) {
+            continue;
+        }
+        nvmrobj =3D object_property_get_link(OBJECT(nvslot->gpdev),
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
+        for (j =3D 0; j < nvslot->linknum; ++j) {
+            Object *atsdmrobj;
+
+            atsdmrobj =3D object_property_get_link(OBJECT(nvslot->links[=
j].npdev),
+                                                 "nvlink2-atsd-mr[0]", N=
ULL);
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
+    sphb->nvgpus =3D NULL;
+}
+
+void spapr_phb_nvgpu_free(SpaprPhbState *sphb)
+{
+    int i, j;
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+        Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
+                                                    "nvlink2-mr[0]", NUL=
L);
+
+        if (nv_mrobj) {
+            memory_region_del_subregion(get_system_memory(),
+                                        MEMORY_REGION(nv_mrobj));
+        }
+        for (j =3D 0; j < nvslot->linknum; ++j) {
+            PCIDevice *npdev =3D nvslot->links[j].npdev;
+            Object *atsd_mrobj;
+            atsd_mrobj =3D object_property_get_link(OBJECT(npdev),
+                                                  "nvlink2-atsd-mr[0]", =
NULL);
+            if (atsd_mrobj) {
+                memory_region_del_subregion(get_system_memory(),
+                                            MEMORY_REGION(atsd_mrobj));
+            }
+        }
+    }
+    g_free(sphb->nvgpus);
+    sphb->nvgpus =3D NULL;
+}
+
+void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void *fdt, int bus=
_off,
+                                 Error **errp)
+{
+    int i, j, atsdnum =3D 0;
+    uint64_t atsd[8]; /* The existing limitation of known guests */
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    for (i =3D 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(atsd)=
); ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+
+        if (!nvslot->gpdev) {
+            continue;
+        }
+        for (j =3D 0; j < nvslot->linknum; ++j) {
+            if (!nvslot->links[j].atsd_gpa) {
+                continue;
+            }
+
+            if (atsdnum =3D=3D ARRAY_SIZE(atsd)) {
+                error_report("Only %"PRIuPTR" ATSD registers supported",
+                             ARRAY_SIZE(atsd));
+                break;
+            }
+            atsd[atsdnum] =3D cpu_to_be64(nvslot->links[j].atsd_gpa);
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
+         * ibm,mmio-atsd contains ATSD registers; these belong to an NPU=
 PHB
+         * which we do not emulate as a separate device. Instead we put
+         * ibm,mmio-atsd to the vPHB with GPU and make sure that we do n=
ot
+         * put GPUs from different IOMMU groups to the same vPHB to ensu=
re
+         * that the guest will use ATSDs from the corresponding NPU.
+         */
+        error_setg(errp, "ATSD requires separate vPHB per GPU IOMMU grou=
p");
+        return;
+    }
+
+    _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd", atsd,
+                      atsdnum * sizeof(atsd[0]))));
+}
+
+void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
+{
+    int i, j, linkidx, npuoff;
+    char *npuname;
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    npuname =3D g_strdup_printf("npuphb%d", sphb->index);
+    npuoff =3D fdt_add_subnode(fdt, 0, npuname);
+    _FDT(npuoff);
+    _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
+    _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
+    /* Advertise NPU as POWER9 so the guest can enable NPU2 contexts */
+    _FDT((fdt_setprop_string(fdt, npuoff, "compatible", "ibm,power9-npu"=
)));
+    g_free(npuname);
+
+    for (i =3D 0, linkidx =3D 0; i < sphb->nvgpus->num; ++i) {
+        for (j =3D 0; j < sphb->nvgpus->slots[i].linknum; ++j) {
+            char *linkname =3D g_strdup_printf("link@%d", linkidx);
+            int off =3D fdt_add_subnode(fdt, npuoff, linkname);
+
+            _FDT(off);
+            /* _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx))); */
+            _FDT((fdt_setprop_string(fdt, off, "compatible",
+                                     "ibm,npu-link")));
+            _FDT((fdt_setprop_cell(fdt, off, "phandle",
+                                   PHANDLE_NVLINK(sphb, i, j))));
+            _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index", linki=
dx)));
+            g_free(linkname);
+            ++linkidx;
+        }
+    }
+
+    /* Add memory nodes for GPU RAM and mark them unusable */
+    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+        Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
+                                                    "nvlink2-mr[0]", NUL=
L);
+        uint32_t associativity[] =3D {
+            cpu_to_be32(0x4),
+            SPAPR_GPU_NUMA_ID,
+            SPAPR_GPU_NUMA_ID,
+            SPAPR_GPU_NUMA_ID,
+            cpu_to_be32(nvslot->numa_id)
+        };
+        uint64_t size =3D object_property_get_uint(nv_mrobj, "size", NUL=
L);
+        uint64_t mem_reg[2] =3D { cpu_to_be64(nvslot->gpa), cpu_to_be64(=
size) };
+        char *mem_name =3D g_strdup_printf("memory@%"PRIx64, nvslot->gpa=
);
+        int off =3D fdt_add_subnode(fdt, 0, mem_name);
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
+        mem_reg[1] =3D cpu_to_be64(0);
+        _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg,
+                          sizeof(mem_reg))));
+        _FDT((fdt_setprop_cell(fdt, off, "phandle",
+                               PHANDLE_GPURAM(sphb, i))));
+        g_free(mem_name);
+    }
+
+}
+
+void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
+                                        SpaprPhbState *sphb)
+{
+    int i, j;
+
+    if (!sphb->nvgpus) {
+        return;
+    }
+
+    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
+        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+
+        /* Skip "slot" without attached GPU */
+        if (!nvslot->gpdev) {
+            continue;
+        }
+        if (dev =3D=3D nvslot->gpdev) {
+            uint32_t npus[nvslot->linknum];
+
+            for (j =3D 0; j < nvslot->linknum; ++j) {
+                PCIDevice *npdev =3D nvslot->links[j].npdev;
+
+                npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
+            }
+            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
+                             j * sizeof(npus[0])));
+            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
+                                   PHANDLE_PCIDEV(sphb, dev))));
+            continue;
+        }
+
+        for (j =3D 0; j < nvslot->linknum; ++j) {
+            if (dev !=3D nvslot->links[j].npdev) {
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
+             * If we ever want to emulate GPU RAM at the same location a=
s on
+             * the host - here is the encoding GPA->TGT:
+             *
+             * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
+             * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
+             * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
+             * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
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
index 40a12001f5..29b2697fe1 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -2180,3 +2180,134 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error=
 **errp)
=20
     return 0;
 }
+
+static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
+                                     const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint64_t tgt =3D (uintptr_t) opaque;
+    visit_type_uint64(v, name, &tgt, errp);
+}
+
+static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
+                                                 const char *name,
+                                                 void *opaque, Error **e=
rrp)
+{
+    uint32_t link_speed =3D (uint32_t)(uintptr_t) opaque;
+    visit_type_uint32(v, name, &link_speed, errp);
+}
+
+int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
+{
+    int ret;
+    void *p;
+    struct vfio_region_info *nv2reg =3D NULL;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_region_info_cap_nvlink2_ssatgt *cap;
+    VFIOQuirk *quirk;
+
+    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
+                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
+                                   PCI_VENDOR_ID_NVIDIA,
+                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RA=
M,
+                                   &nv2reg);
+    if (ret) {
+        return ret;
+    }
+
+    hdr =3D vfio_get_region_info_cap(nv2reg, VFIO_REGION_INFO_CAP_NVLINK=
2_SSATGT);
+    if (!hdr) {
+        ret =3D -ENODEV;
+        goto free_exit;
+    }
+    cap =3D (void *) hdr;
+
+    p =3D mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
+             MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
+    if (p =3D=3D MAP_FAILED) {
+        ret =3D -errno;
+        goto free_exit;
+    }
+
+    quirk =3D vfio_quirk_alloc(1);
+    memory_region_init_ram_ptr(&quirk->mem[0], OBJECT(vdev), "nvlink2-mr=
",
+                               nv2reg->size, p);
+    QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
+
+    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
+                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
+                        (void *) (uintptr_t) cap->tgt, NULL);
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
+    struct vfio_region_info *atsdreg =3D NULL;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_region_info_cap_nvlink2_ssatgt *captgt;
+    struct vfio_region_info_cap_nvlink2_lnkspd *capspeed;
+    VFIOQuirk *quirk;
+
+    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
+                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
+                                   PCI_VENDOR_ID_IBM,
+                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
+                                   &atsdreg);
+    if (ret) {
+        return ret;
+    }
+
+    hdr =3D vfio_get_region_info_cap(atsdreg,
+                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
+    if (!hdr) {
+        ret =3D -ENODEV;
+        goto free_exit;
+    }
+    captgt =3D (void *) hdr;
+
+    hdr =3D vfio_get_region_info_cap(atsdreg,
+                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
+    if (!hdr) {
+        ret =3D -ENODEV;
+        goto free_exit;
+    }
+    capspeed =3D (void *) hdr;
+
+    /* Some NVLink bridges may not have assigned ATSD */
+    if (atsdreg->size) {
+        p =3D mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_EX=
EC,
+                 MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
+        if (p =3D=3D MAP_FAILED) {
+            ret =3D -errno;
+            goto free_exit;
+        }
+
+        quirk =3D vfio_quirk_alloc(1);
+        memory_region_init_ram_device_ptr(&quirk->mem[0], OBJECT(vdev),
+                                          "nvlink2-atsd-mr", atsdreg->si=
ze, p);
+        QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
+    }
+
+    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
+                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
+                        (void *) (uintptr_t) captgt->tgt, NULL);
+    trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captg=
t->tgt,
+                                              atsdreg->size);
+
+    object_property_add(OBJECT(vdev), "nvlink2-link-speed", "uint32",
+                        vfio_pci_nvlink2_get_link_speed, NULL, NULL,
+                        (void *) (uintptr_t) capspeed->link_speed, NULL)=
;
+    trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
+                                              capspeed->link_speed);
+free_exit:
+    g_free(atsdreg);
+
+    return ret;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0142819ea6..8cecb53d5c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3086,6 +3086,20 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
         }
     }
=20
+    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_NVIDIA) {
+        ret =3D vfio_pci_nvidia_v100_ram_init(vdev, errp);
+        if (ret && ret !=3D -ENODEV) {
+            error_report("Failed to setup NVIDIA V100 GPU RAM");
+        }
+    }
+
+    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_IBM) {
+        ret =3D vfio_pci_nvlink2_init(vdev, errp);
+        if (ret && ret !=3D -ENODEV) {
+            error_report("Failed to setup NVlink2 bridge");
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c11c3f1670..cfcd1a81b8 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -196,6 +196,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **er=
rp);
 int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
                                Error **errp);
+int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
+int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
=20
 void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index eb589930a5..b1ef55a33f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -86,6 +86,10 @@ vfio_pci_igd_opregion_enabled(const char *name) "%s"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
=20
+vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t=
 size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
+vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint=
64_t size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
+vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_spee=
d) "%s link_speed=3D0x%x"
+
 # common.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t d=
ata, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, ui=
nt64_t data) " (%s:region%d+0x%"PRIx64", %d) =3D 0x%"PRIx64
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index b4aad26798..53519c835e 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -87,6 +87,9 @@ struct SpaprPhbState {
     uint32_t mig_liobn;
     hwaddr mig_mem_win_addr, mig_mem_win_size;
     hwaddr mig_io_win_addr, mig_io_win_size;
+    hwaddr nv2_gpa_win_addr;
+    hwaddr nv2_atsd_win_addr;
+    struct spapr_phb_pci_nvgpu_config *nvgpus;
 };
=20
 #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
@@ -105,6 +108,22 @@ struct SpaprPhbState {
=20
 #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
=20
+#define SPAPR_PCI_NV2RAM64_WIN_BASE  SPAPR_PCI_LIMIT
+#define SPAPR_PCI_NV2RAM64_WIN_SIZE  (2 * TiB) /* For up to 6 GPUs 256GB=
 each */
+
+/* Max number of these GPUsper a physical box */
+#define NVGPU_MAX_NUM                6
+/* Max number of NVLinks per GPU in any physical box */
+#define NVGPU_MAX_LINKS              3
+
+/*
+ * GPU RAM starts at 64TiB so huge DMA window to cover it all ends at 12=
8TiB
+ * which is enough. We do not need DMA for ATSD so we put them at 128TiB=
.
+ */
+#define SPAPR_PCI_NV2ATSD_WIN_BASE   (128 * TiB)
+#define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * =
\
+                                      64 * KiB)
+
 static inline qemu_irq spapr_phb_lsi_qirq(struct SpaprPhbState *phb, int=
 pin)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
@@ -135,6 +154,13 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb=
, int *state);
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
 int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
+void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **errp);
+void spapr_phb_nvgpu_free(SpaprPhbState *sphb);
+void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void *fdt, int bus=
_off,
+                                 Error **errp);
+void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt);
+void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
+                                        SpaprPhbState *sphb);
 #else
 static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
@@ -161,6 +187,25 @@ static inline int spapr_phb_vfio_eeh_configure(Spapr=
PhbState *sphb)
 static inline void spapr_phb_vfio_reset(DeviceState *qdev)
 {
 }
+static inline void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **er=
rp)
+{
+}
+static inline void spapr_phb_nvgpu_free(SpaprPhbState *sphb)
+{
+}
+static inline void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void=
 *fdt,
+                                               int bus_off, Error **errp=
)
+{
+}
+static inline void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb,
+                                                   void *fdt)
+{
+}
+static inline void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, vo=
id *fdt,
+                                                      int offset,
+                                                      SpaprPhbState *sph=
b)
+{
+}
 #endif
=20
 void spapr_phb_dma_reset(SpaprPhbState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5ea8081041..02b5ce7e40 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -123,7 +123,8 @@ struct SpaprMachineClass {
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio,=20
                           hwaddr *mmio32, hwaddr *mmio64,
-                          unsigned n_dma, uint32_t *liobns, Error **errp=
);
+                          unsigned n_dma, uint32_t *liobns, hwaddr *nv2g=
pa,
+                          hwaddr *nv2atsd, Error **errp);
     SpaprResizeHpt resize_hpt_default;
     SpaprCapabilities default_caps;
     SpaprIrq *irq;
@@ -199,6 +200,8 @@ struct SpaprMachineState {
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     SpaprCapabilities def, eff, mig;
+
+    unsigned gpu_numa_id;
 };
=20
 #define H_SUCCESS         0
--=20
2.20.1


