Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632BEC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F6A20850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F6A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtPE-0005gN-CS
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:27:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt53-0003IU-Qj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt52-0005Ou-Jz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt4z-0005MP-La; Fri, 12 Apr 2019 06:06:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA9C6308CF8F;
	Fri, 12 Apr 2019 10:06:40 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D35C019C65;
	Fri, 12 Apr 2019 10:06:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:49 +0200
Message-Id: <20190412100354.6409-23-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 12 Apr 2019 10:06:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 22/27] vfio-pci: Expose MSI stage 1 bindings
 to the host
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
Cc: yi.l.liu@intel.com, mst@redhat.com, jean-philippe.brucker@arm.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412100349.FPKuy4Ti31vPHeAHXIxQhPxrXGvlgQlehvs_lg5qIeM@z>

When the guest is exposed with a virtual IOMMU that translates
MSIs, the guest allocates an IOVA (gIOVA) that maps the virtual
doorbell (gDB). In nested mode, when the MSI is setup, we pass
this stage1 mapping to the host so that it can use this stage1
binding to create a nested stage translating into the physical
doorbell. Conversely, when the MSI setup os torn down, we
unregister this binding.

For registration, We directly use the iommu memory region
translate() callback since the addr_mask is returned in the
IOTLB entry. address_space_translate does not return this information.

Now that we use a MAP notifier, let's remove warning against
the usage of map notifiers (historically used along with Intel's
caching mode).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c      |  8 --------
 hw/vfio/pci.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |  2 ++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2574989f2e..a7e48e7972 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1517,14 +1517,6 @@ static void smmuv3_notify_flag_changed(IOMMUMemory=
Region *iommu,
     SMMUv3State *s3 =3D sdev->smmu;
     SMMUState *s =3D &(s3->smmu_state);
=20
-    if (new & IOMMU_NOTIFIER_IOTLB_MAP) {
-        int bus_num =3D pci_bus_num(sdev->bus);
-        PCIDevice *pcidev =3D pci_find_device(sdev->bus, bus_num, sdev->=
devfn);
-
-        warn_report("SMMUv3 does not support notification on MAP: "
-                     "device %s will not function properly", pcidev->nam=
e);
-    }
-
     if (old =3D=3D IOMMU_NOTIFIER_NONE) {
         trace_smmuv3_notify_flag_add(iommu->parent_obj.name);
         QLIST_INSERT_HEAD(&s->devices_with_notifiers, sdev, next);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index cd93ff6fa3..aeb4dfa388 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -402,6 +402,48 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, =
bool msix)
     return ret;
 }
=20
+static int vfio_register_msi_binding(VFIOPCIDevice *vdev, int vector_n)
+{
+    PCIDevice *dev =3D &vdev->pdev;
+    AddressSpace *as =3D pci_device_iommu_address_space(dev);
+    MSIMessage msg =3D pci_get_msi_message(dev, vector_n);
+    IOMMUMemoryRegionClass *imrc;
+    IOMMUMemoryRegion *iommu_mr;
+    bool msi_translate =3D false, nested =3D false;;
+    IOMMUTLBEntry entry;
+
+    if (as =3D=3D &address_space_memory) {
+        return 0;
+    }
+
+    iommu_mr =3D IOMMU_MEMORY_REGION(as->root);
+    memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_MSI_TRANSLATE,
+                                 (void *)&msi_translate);
+    memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
+                                 (void *)&nested);
+    imrc =3D memory_region_get_iommu_class_nocheck(iommu_mr);
+
+    if (!nested || !msi_translate) {
+        return 0;
+    }
+
+    /* MSI doorbell address is translated by an IOMMU */
+
+    rcu_read_lock();
+    entry =3D imrc->translate(iommu_mr, msg.address, IOMMU_WO, 0);
+    rcu_read_unlock();
+
+    if (entry.perm =3D=3D IOMMU_NONE) {
+        return -ENOENT;
+    }
+
+    trace_vfio_register_msi_binding(vdev->vbasedev.name, vector_n,
+                                    msg.address, entry.translated_addr);
+
+    memory_region_iotlb_notify_iommu(iommu_mr, 0, entry);
+    return 0;
+}
+
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *ve=
ctor,
                                   int vector_n, bool msix)
 {
@@ -487,6 +529,12 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, =
unsigned int nr,
         }
     }
=20
+    ret =3D vfio_register_msi_binding(vdev, nr);
+
+    if (ret) {
+        error_report("%s failed to register S1 MSI binding(%d)", __func_=
_, ret);
+    }
+
     /*
      * We don't want to have the host allocate all possible MSI vectors
      * for a device if they're not in use, so we shutdown and incrementa=
lly
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 3c2cd15e3f..52b96ec196 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -111,6 +111,8 @@ vfio_region_sparse_mmap_header(const char *name, int =
index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long =
end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t=
 subtype) "%s index %d, %08x/%0x8"
 vfio_dma_unmap_overflow_workaround(void) ""
+vfio_register_msi_binding(const char *name, int vector, uint64_t giova, =
uint64_t gdb) "%s: register vector %d gIOVA=3D0x%"PRIx64 "-> gDB=3D0x%"PR=
Ix64" stage 1 mapping"
+vfio_unregister_msi_binding(const char *name, int vector, uint64_t giova=
) "%s: unregister vector %d gIOVA=3D0x%"PRIx64 " stage 1 mapping"
=20
 # platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to g=
roup #%d"
--=20
2.20.1


