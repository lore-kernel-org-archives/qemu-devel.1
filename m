Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C28DC74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494E620863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494E620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcvU-0005PC-NJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34639)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hlcul-0003JM-9Q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hlcuj-0003gP-JG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hlcue-0003b2-Tx; Thu, 11 Jul 2019 13:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27BEA356CD;
 Thu, 11 Jul 2019 17:31:20 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3E4D5C1B4;
 Thu, 11 Jul 2019 17:31:13 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Thu, 11 Jul 2019 19:28:33 +0200
Message-Id: <20190711172845.31035-18-eric.auger@redhat.com>
In-Reply-To: <20190711172845.31035-1-eric.auger@redhat.com>
References: <20190711172845.31035-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 11 Jul 2019 17:31:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 17/29] vfio: Set up nested stage mappings
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
 jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com, peterx@redhat.com,
 alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In nested mode, legacy vfio_iommu_map_notify cannot be used as
there is no "caching" mode and we do not trap on map.

On Intel, vfio_iommu_map_notify was used to DMA map the RAM
through the host single stage.

With nested mode, we need to setup the stage 2 and the stage 1
separately. This patch introduces a prereg_listener to setup
the stage 2 mapping.

The stage 1 mapping, owned by the guest, is passed to the host
when the guest invalidates the stage 1 configuration, through
a dedicated PCIPASIDOps callback. Guest IOTLB invalidations
are cascaded downto the host through another IOMMU MR UNMAP
notifier.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- use VFIO_IOMMU_SET_PASID_TABLE
- use PCIPASIDOps for config notification

v3 -> v4:
- use iommu_inv_pasid_info for ASID invalidation

v2 -> v3:
- use VFIO_IOMMU_ATTACH_PASID_TABLE
- new user API
- handle leaf

v1 -> v2:
- adapt to uapi changes
- pass the asid
- pass IOMMU_NOTIFIER_S1_CFG when initializing the config notifier
---
 hw/vfio/common.c     | 123 +++++++++++++++++++++++++++++++++++++++----
 hw/vfio/pci.c        |  21 ++++++++
 hw/vfio/trace-events |   2 +
 3 files changed, 136 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ef8452a4bc..bd975c5b83 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -444,6 +444,52 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, voi=
d **vaddr,
     return true;
 }
=20
+/* Propagate a guest IOTLB invalidation to the host (nested mode) */
+static void vfio_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iot=
lb)
+{
+    VFIOGuestIOMMU *giommu =3D container_of(n, VFIOGuestIOMMU, n);
+    hwaddr start =3D iotlb->iova + giommu->iommu_offset;
+
+    VFIOContainer *container =3D giommu->container;
+    struct vfio_iommu_type1_cache_invalidate ustruct;
+    size_t size =3D iotlb->addr_mask + 1;
+    int ret;
+
+    assert(iotlb->perm =3D=3D IOMMU_NONE);
+
+    ustruct.argsz =3D sizeof(ustruct);
+    ustruct.flags =3D 0;
+    ustruct.info.version =3D IOMMU_CACHE_INVALIDATE_INFO_VERSION_1;
+
+    if (size <=3D 0x10000) {
+        ustruct.info.cache =3D IOMMU_CACHE_INV_TYPE_IOTLB;
+        ustruct.info.granularity =3D IOMMU_INV_GRANU_ADDR;
+        ustruct.info.addr_info.flags =3D IOMMU_INV_ADDR_FLAGS_ARCHID;
+        if (iotlb->leaf) {
+            ustruct.info.addr_info.flags |=3D IOMMU_INV_ADDR_FLAGS_LEAF;
+        }
+        ustruct.info.addr_info.archid =3D iotlb->arch_id;
+        ustruct.info.addr_info.addr =3D start;
+        ustruct.info.addr_info.granule_size =3D size;
+        ustruct.info.addr_info.nb_granules =3D 1;
+        trace_vfio_iommu_addr_inv_iotlb(iotlb->arch_id, start, size, 1,
+                                        iotlb->leaf);
+    } else {
+        ustruct.info.cache =3D IOMMU_CACHE_INV_TYPE_IOTLB;
+        ustruct.info.granularity =3D IOMMU_INV_GRANU_PASID;
+        ustruct.info.pasid_info.archid =3D iotlb->arch_id;
+        ustruct.info.pasid_info.flags =3D IOMMU_INV_PASID_FLAGS_ARCHID;
+        trace_vfio_iommu_asid_inv_iotlb(iotlb->arch_id);
+    }
+
+    ret =3D ioctl(container->fd, VFIO_IOMMU_CACHE_INVALIDATE, &ustruct);
+    if (ret) {
+        error_report("%p: failed to invalidate CACHE for 0x%"PRIx64
+                     " mask=3D0x%"PRIx64" (%d)",
+                     container, start, iotlb->addr_mask, ret);
+    }
+}
+
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb=
)
 {
     VFIOGuestIOMMU *giommu =3D container_of(n, VFIOGuestIOMMU, n);
@@ -613,6 +659,32 @@ static void vfio_dma_unmap_ram_section(VFIOContainer=
 *container,
     }
 }
=20
+static void vfio_prereg_listener_region_add(MemoryListener *listener,
+                                            MemoryRegionSection *section=
)
+{
+    VFIOContainer *container =3D
+        container_of(listener, VFIOContainer, prereg_listener);
+
+    if (!memory_region_is_ram(section->mr)) {
+        return;
+    }
+
+    vfio_dma_map_ram_section(container, section);
+
+}
+static void vfio_prereg_listener_region_del(MemoryListener *listener,
+                                     MemoryRegionSection *section)
+{
+    VFIOContainer *container =3D
+        container_of(listener, VFIOContainer, prereg_listener);
+
+    if (!memory_region_is_ram(section->mr)) {
+        return;
+    }
+
+    vfio_dma_unmap_ram_section(container, section);
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -709,10 +781,11 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
     memory_region_ref(section->mr);
=20
     if (memory_region_is_iommu(section->mr)) {
+        IOMMUNotify notify;
         VFIOGuestIOMMU *giommu;
         IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr)=
;
         bool nested;
-        int iommu_idx;
+        int iommu_idx, flags;
=20
         trace_vfio_listener_region_add_iommu(iova, end);
=20
@@ -738,15 +811,26 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
         llend =3D int128_sub(llend, int128_one());
         iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
                                                        MEMTXATTRS_UNSPEC=
IFIED);
-        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
-                            IOMMU_NOTIFIER_ALL,
-                            section->offset_within_region,
-                            int128_get64(llend),
-                            iommu_idx);
-        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
=20
+        if (container->iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
+            /* IOTLB unmap notifier to propagate guest IOTLB invalidatio=
ns */
+            flags =3D IOMMU_NOTIFIER_UNMAP;
+            notify =3D vfio_iommu_unmap_notify;
+        } else {
+            /* MAP/UNMAP IOTLB notifier */
+            flags =3D IOMMU_NOTIFIER_ALL;
+            notify =3D vfio_iommu_map_notify;
+        }
+
+        iommu_notifier_init(&giommu->n, notify, flags,
+                            section->offset_within_region,
+                            int128_get64(llend), iommu_idx);
+        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
         memory_region_register_iommu_notifier(section->mr, &giommu->n);
-        memory_region_iommu_replay(giommu->iommu, &giommu->n);
+
+        if (flags & IOMMU_NOTIFIER_MAP) {
+            memory_region_iommu_replay(giommu->iommu, &giommu->n);
+        }
=20
         return;
     }
@@ -835,15 +919,21 @@ static void vfio_listener_region_del(MemoryListener=
 *listener,
     }
 }
=20
-static const MemoryListener vfio_memory_listener =3D {
+static MemoryListener vfio_memory_listener =3D {
     .region_add =3D vfio_listener_region_add,
     .region_del =3D vfio_listener_region_del,
 };
=20
+static MemoryListener vfio_memory_prereg_listener =3D {
+    .region_add =3D vfio_prereg_listener_region_add,
+    .region_del =3D vfio_prereg_listener_region_del,
+};
+
 static void vfio_listener_release(VFIOContainer *container)
 {
     memory_listener_unregister(&container->listener);
-    if (container->iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU) {
+    if (container->iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU ||
+        container->iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
         memory_listener_unregister(&container->prereg_listener);
     }
 }
@@ -1340,6 +1430,19 @@ static int vfio_connect_container(VFIOGroup *group=
, AddressSpace *as,
         }
         vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
         container->pgsizes =3D info.iova_pgsizes;
+
+        if (container->iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
+            container->prereg_listener =3D vfio_memory_prereg_listener;
+            memory_listener_register(&container->prereg_listener,
+                                     &address_space_memory);
+            if (container->error) {
+                memory_listener_unregister(&container->prereg_listener);
+                ret =3D container->error;
+                error_setg(errp, "RAM memory listener initialization fai=
led "
+                          " for container");
+                goto free_container_exit;
+            }
+        }
         break;
     }
     case VFIO_SPAPR_TCE_v2_IOMMU:
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7a4e1875c..729f1f353e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2693,6 +2693,25 @@ static void vfio_unregister_req_notifier(VFIOPCIDe=
vice *vdev)
     vdev->req_enabled =3D false;
 }
=20
+static int vfio_iommu_set_pasid_table(PCIBus *bus, int32_t devfn,
+                                      IOMMUConfig *config)
+{
+    PCIDevice *pdev =3D bus->devices[devfn];
+    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOContainer *container =3D vdev->vbasedev.group->container;
+    struct vfio_iommu_type1_set_pasid_table info;
+
+    info.argsz =3D sizeof(info);
+    info.flags =3D VFIO_PASID_TABLE_FLAG_SET;
+    memcpy(&info.config, &config->pasid_cfg, sizeof(config->pasid_cfg));
+
+    return ioctl(container->fd, VFIO_IOMMU_SET_PASID_TABLE, &info);
+}
+
+static PCIPASIDOps vfio_pci_pasid_ops =3D {
+    .set_pasid_table =3D vfio_iommu_set_pasid_table,
+};
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
@@ -2994,6 +3013,8 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
=20
+    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
+
     return;
=20
 out_teardown:
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 410801de6e..9f1868af2d 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -115,6 +115,8 @@ vfio_region_sparse_mmap_header(const char *name, int =
index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long =
end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t=
 subtype) "%s index %d, %08x/%0x8"
 vfio_dma_unmap_overflow_workaround(void) ""
+vfio_iommu_addr_inv_iotlb(int asid, uint64_t addr, uint64_t size, uint64=
_t nb_granules, bool leaf) "nested IOTLB invalidate asid=3D%d, addr=3D0x%=
"PRIx64" granule_size=3D0x%"PRIx64" nb_granules=3D0x%"PRIx64" leaf=3D%d"
+vfio_iommu_asid_inv_iotlb(int asid) "nested IOTLB invalidate asid=3D%d"
=20
 # platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to g=
roup #%d"
--=20
2.20.1


