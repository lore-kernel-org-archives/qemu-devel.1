Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19AEC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992B920883
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992B920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVEIT-0008JA-Ow
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:00:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE3l-0004lT-W4
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE3j-00051b-ML
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hVE3g-0004yP-Iv; Mon, 27 May 2019 07:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CED85821D1;
	Mon, 27 May 2019 11:44:51 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE79B5D962;
	Mon, 27 May 2019 11:44:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Mon, 27 May 2019 13:41:58 +0200
Message-Id: <20190527114203.2762-23-eric.auger@redhat.com>
In-Reply-To: <20190527114203.2762-1-eric.auger@redhat.com>
References: <20190527114203.2762-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 27 May 2019 11:44:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 22/27] vfio-pci: Expose MSI stage 1 bindings
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
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
	jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
v3 -> v4:
- move the MSI binding registration in vfio_enable_vectors
  to address the MSI use case
---
 hw/arm/smmuv3.c      |  8 -------
 hw/vfio/pci.c        | 50 +++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events |  2 ++
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index db03313672..a697968ace 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1521,14 +1521,6 @@ static void smmuv3_notify_flag_changed(IOMMUMemory=
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
index 3095379747..b613b20501 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -358,6 +358,48 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
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
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 {
     struct vfio_irq_set *irq_set;
@@ -375,7 +417,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, b=
ool msix)
     fds =3D (int32_t *)&irq_set->data;
=20
     for (i =3D 0; i < vdev->nr_vectors; i++) {
-        int fd =3D -1;
+        int ret, fd =3D -1;
=20
         /*
          * MSI vs MSI-X - The guest has direct access to MSI mask and pe=
nding
@@ -390,6 +432,12 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, =
bool msix)
             } else {
                 fd =3D event_notifier_get_fd(&vdev->msi_vectors[i].kvm_i=
nterrupt);
             }
+            ret =3D vfio_register_msi_binding(vdev, i);
+            if (ret) {
+                error_report("%s failed to register S1 MSI binding "
+                             "for vector %d(%d)", __func__, i, ret);
+                return ret;
+            }
         }
=20
         fds[i] =3D fd;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9f1868af2d..5de97a8882 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -117,6 +117,8 @@ vfio_get_dev_region(const char *name, int index, uint=
32_t type, uint32_t subtype
 vfio_dma_unmap_overflow_workaround(void) ""
 vfio_iommu_addr_inv_iotlb(int asid, uint64_t addr, uint64_t size, uint64=
_t nb_granules, bool leaf) "nested IOTLB invalidate asid=3D%d, addr=3D0x%=
"PRIx64" granule_size=3D0x%"PRIx64" nb_granules=3D0x%"PRIx64" leaf=3D%d"
 vfio_iommu_asid_inv_iotlb(int asid) "nested IOTLB invalidate asid=3D%d"
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


