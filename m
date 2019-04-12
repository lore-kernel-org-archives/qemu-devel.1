Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5293C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981D12083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981D12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtCE-0001ds-NJ
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:14:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3Z-0001NA-0k
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3W-00045Z-Nu
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt3Q-0003zZ-Ba; Fri, 12 Apr 2019 06:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8107B30AA799;
	Fri, 12 Apr 2019 10:05:03 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD2F619C65;
	Fri, 12 Apr 2019 10:05:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:36 +0200
Message-Id: <20190412100354.6409-10-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 12 Apr 2019 10:05:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 09/27] memory: Prepare for different kinds of
 IOMMU MR notifiers
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
Message-ID: <20190412100336.t6unWMvl9I6bIkKKD7JefuymuYMKSwo0NS7dZdBZZAQ@z>

Current IOMMUNotifiers dedicate to IOTLB related notifications,
ie. MAP/UNMAP. We plan to introduce new types of notifiers, for
instance to notify vIOMMU configuration changes. Those new
notifiers may not be characterized by any associated address
space range.

So let's create a specialized IOMMUIOLTBNotifier datatype.
The base IOMMUNotifier will be able to encapsulate either of
the notifier types, including looming IOMMUConfigNotifier.

We also rename:
- IOMMU_NOTIFIER_* into IOMMU_NOTIFIER_IOTLB_*
- *_notify_* into *iotlb_notify_*

All calling sites are updated.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 exec.c                   | 12 ++++-----
 hw/arm/smmu-common.c     | 10 ++++---
 hw/arm/smmuv3.c          |  8 +++---
 hw/i386/amd_iommu.c      |  2 +-
 hw/i386/intel_iommu.c    | 25 ++++++++++--------
 hw/misc/tz-mpc.c         |  8 +++---
 hw/ppc/spapr_iommu.c     |  2 +-
 hw/s390x/s390-pci-inst.c |  4 +--
 hw/vfio/common.c         | 13 ++++-----
 hw/virtio/vhost.c        | 14 +++++-----
 include/exec/memory.h    | 57 +++++++++++++++++++++++++---------------
 memory.c                 | 32 ++++++++++++----------
 12 files changed, 107 insertions(+), 80 deletions(-)

diff --git a/exec.c b/exec.c
index 6ab62f4eee..2fed338fa9 100644
--- a/exec.c
+++ b/exec.c
@@ -685,12 +685,12 @@ static void tcg_register_iommu_notifier(CPUState *c=
pu,
          * just register interest in the whole thing, on the assumption
          * that iommu reconfiguration will be rare.
          */
-        iommu_notifier_init(&notifier->n,
-                            tcg_iommu_unmap_notify,
-                            IOMMU_NOTIFIER_UNMAP,
-                            0,
-                            HWADDR_MAX,
-                            iommu_idx);
+        iommu_iotlb_notifier_init(&notifier->n,
+                                  tcg_iommu_unmap_notify,
+                                  IOMMU_NOTIFIER_IOTLB_UNMAP,
+                                  0,
+                                  HWADDR_MAX,
+                                  iommu_idx);
         memory_region_register_iommu_notifier(notifier->mr, &notifier->n=
);
     }
=20
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e94be6db6c..ee81038fc0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -391,11 +391,11 @@ static void smmu_unmap_notifier_range(IOMMUNotifier=
 *n)
     IOMMUTLBEntry entry;
=20
     entry.target_as =3D &address_space_memory;
-    entry.iova =3D n->start;
+    entry.iova =3D n->iotlb_notifier.start;
     entry.perm =3D IOMMU_NONE;
-    entry.addr_mask =3D n->end - n->start;
+    entry.addr_mask =3D n->iotlb_notifier.end - n->iotlb_notifier.start;
=20
-    memory_region_notify_one(n, &entry);
+    memory_region_iotlb_notify_one(n, &entry);
 }
=20
 /* Unmap all notifiers attached to @mr */
@@ -405,7 +405,9 @@ inline void smmu_inv_notifiers_mr(IOMMUMemoryRegion *=
mr)
=20
     trace_smmu_inv_notifiers_mr(mr->parent_obj.name);
     IOMMU_NOTIFIER_FOREACH(n, mr) {
-        smmu_unmap_notifier_range(n);
+        if (n->notifier_flags & IOMMU_NOTIFIER_IOTLB_UNMAP) {
+            smmu_unmap_notifier_range(n);
+        }
     }
 }
=20
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 761d722395..1744874e72 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -822,7 +822,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
     entry.addr_mask =3D (1 << tt->granule_sz) - 1;
     entry.perm =3D IOMMU_NONE;
=20
-    memory_region_notify_one(n, &entry);
+    memory_region_iotlb_notify_one(n, &entry);
 }
=20
 /* invalidate an asid/iova tuple in all mr's */
@@ -837,7 +837,9 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, i=
nt asid, dma_addr_t iova)
         trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova)=
;
=20
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, iova);
+            if (n->notifier_flags & IOMMU_NOTIFIER_IOTLB_UNMAP) {
+                smmuv3_notify_iova(mr, n, asid, iova);
+            }
         }
     }
 }
@@ -1473,7 +1475,7 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryR=
egion *iommu,
     SMMUv3State *s3 =3D sdev->smmu;
     SMMUState *s =3D &(s3->smmu_state);
=20
-    if (new & IOMMU_NOTIFIER_MAP) {
+    if (new & IOMMU_NOTIFIER_IOTLB_MAP) {
         int bus_num =3D pci_bus_num(sdev->bus);
         PCIDevice *pcidev =3D pci_find_device(sdev->bus, bus_num, sdev->=
devfn);
=20
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6eabdf9917..a1e88be809 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1470,7 +1470,7 @@ static void amdvi_iommu_notify_flag_changed(IOMMUMe=
moryRegion *iommu,
 {
     AMDVIAddressSpace *as =3D container_of(iommu, AMDVIAddressSpace, iom=
mu);
=20
-    if (new & IOMMU_NOTIFIER_MAP) {
+    if (new & IOMMU_NOTIFIER_IOTLB_MAP) {
         error_report("device %02x.%02x.%x requires iommu notifier which =
is not "
                      "currently supported", as->bus_num, PCI_SLOT(as->de=
vfn),
                      PCI_FUNC(as->devfn));
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2558f48fe6..0d0893c523 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -174,7 +174,7 @@ static void vtd_update_scalable_state(IntelIOMMUState=
 *s)
 /* Whether the address space needs to notify new mappings */
 static inline gboolean vtd_as_has_map_notifier(VTDAddressSpace *as)
 {
-    return as->notifier_flags & IOMMU_NOTIFIER_MAP;
+    return as->notifier_flags & IOMMU_NOTIFIER_IOTLB_MAP;
 }
=20
 /* GHashTable functions */
@@ -1361,7 +1361,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState=
 *s, uint8_t bus_num,
 static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
                                      void *private)
 {
-    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *entry);
+    memory_region_iotlb_notify_iommu((IOMMUMemoryRegion *)private, 0, *e=
ntry);
     return 0;
 }
=20
@@ -1928,7 +1928,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelI=
OMMUState *s,
                     .addr_mask =3D size - 1,
                     .perm =3D IOMMU_NONE,
                 };
-                memory_region_notify_iommu(&vtd_as->iommu, 0, entry);
+                memory_region_iotlb_notify_iommu(&vtd_as->iommu, 0, entr=
y);
             }
         }
     }
@@ -2393,7 +2393,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMM=
UState *s,
     entry.iova =3D addr;
     entry.perm =3D IOMMU_NONE;
     entry.translated_addr =3D 0;
-    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, entry);
+    memory_region_iotlb_notify_iommu(&vtd_dev_as->iommu, 0, entry);
=20
 done:
     return true;
@@ -2925,7 +2925,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemo=
ryRegion *iommu,
     VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iom=
mu);
     IntelIOMMUState *s =3D vtd_as->iommu_state;
=20
-    if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
+    if (!s->caching_mode && new & IOMMU_NOTIFIER_IOTLB_MAP) {
         error_report("We need to set caching-mode=3Don for intel-iommu t=
o enable "
                      "device assignment with IOMMU protection.");
         exit(1);
@@ -3368,8 +3368,9 @@ static void vtd_address_space_unmap(VTDAddressSpace=
 *as, IOMMUNotifier *n)
 {
     IOMMUTLBEntry entry;
     hwaddr size;
-    hwaddr start =3D n->start;
-    hwaddr end =3D n->end;
+
+    hwaddr start =3D n->iotlb_notifier.start;
+    hwaddr end =3D n->iotlb_notifier.end;
     IntelIOMMUState *s =3D as->iommu_state;
     DMAMap map;
=20
@@ -3405,7 +3406,7 @@ static void vtd_address_space_unmap(VTDAddressSpace=
 *as, IOMMUNotifier *n)
=20
     entry.target_as =3D &address_space_memory;
     /* Adjust iova for the size */
-    entry.iova =3D n->start & ~(size - 1);
+    entry.iova =3D n->iotlb_notifier.start & ~(size - 1);
     /* This field is meaningless for unmap */
     entry.translated_addr =3D 0;
     entry.perm =3D IOMMU_NONE;
@@ -3420,7 +3421,7 @@ static void vtd_address_space_unmap(VTDAddressSpace=
 *as, IOMMUNotifier *n)
     map.size =3D entry.addr_mask;
     iova_tree_remove(as->iova_tree, &map);
=20
-    memory_region_notify_one(n, &entry);
+    memory_region_iotlb_notify_one(n, &entry);
 }
=20
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
@@ -3430,7 +3431,9 @@ static void vtd_address_space_unmap_all(IntelIOMMUS=
tate *s)
=20
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
         IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
-            vtd_address_space_unmap(vtd_as, n);
+            if (n->notifier_flags & IOMMU_NOTIFIER_IOTLB_UNMAP) {
+                vtd_address_space_unmap(vtd_as, n);
+            }
         }
     }
 }
@@ -3443,7 +3446,7 @@ static void vtd_address_space_refresh_all(IntelIOMM=
UState *s)
=20
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
-    memory_region_notify_one((IOMMUNotifier *)private, entry);
+    memory_region_iotlb_notify_one((IOMMUNotifier *)private, entry);
     return 0;
 }
=20
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 9a84be75ed..f735d60e0f 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -100,8 +100,8 @@ static void tz_mpc_iommu_notify(TZMPC *s, uint32_t lu=
tidx,
         entry.translated_addr =3D addr;
=20
         entry.perm =3D IOMMU_NONE;
-        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
-        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
+        memory_region_iotlb_notify_iommu(&s->upstream, IOMMU_IDX_S, entr=
y);
+        memory_region_iotlb_notify_iommu(&s->upstream, IOMMU_IDX_NS, ent=
ry);
=20
         entry.perm =3D IOMMU_RW;
         if (block_is_ns) {
@@ -109,13 +109,13 @@ static void tz_mpc_iommu_notify(TZMPC *s, uint32_t =
lutidx,
         } else {
             entry.target_as =3D &s->downstream_as;
         }
-        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
+        memory_region_iotlb_notify_iommu(&s->upstream, IOMMU_IDX_S, entr=
y);
         if (block_is_ns) {
             entry.target_as =3D &s->downstream_as;
         } else {
             entry.target_as =3D &s->blocked_io_as;
         }
-        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
+        memory_region_iotlb_notify_iommu(&s->upstream, IOMMU_IDX_NS, ent=
ry);
     }
 }
=20
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5aff4d5a05..91da0dfb9c 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -459,7 +459,7 @@ static target_ulong put_tce_emu(SpaprTceTable *tcet, =
target_ulong ioba,
     entry.translated_addr =3D tce & page_mask;
     entry.addr_mask =3D ~page_mask;
     entry.perm =3D spapr_tce_iommu_access_flags(tce);
-    memory_region_notify_iommu(&tcet->iommu, 0, entry);
+    memory_region_iotlb_notify_iommu(&tcet->iommu, 0, entry);
=20
     return H_SUCCESS;
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index be2896232d..63bb23accd 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -594,7 +594,7 @@ static void s390_pci_update_iotlb(S390PCIIOMMU *iommu=
, S390IOTLBEntry *entry)
             }
=20
             notify.perm =3D IOMMU_NONE;
-            memory_region_notify_iommu(&iommu->iommu_mr, 0, notify);
+            memory_region_iotlb_notify_iommu(&iommu->iommu_mr, 0, notify=
);
             notify.perm =3D entry->perm;
         }
=20
@@ -606,7 +606,7 @@ static void s390_pci_update_iotlb(S390PCIIOMMU *iommu=
, S390IOTLBEntry *entry)
         g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
     }
=20
-    memory_region_notify_iommu(&iommu->iommu_mr, 0, notify);
+    memory_region_iotlb_notify_iommu(&iommu->iommu_mr, 0, notify);
 }
=20
 int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t r=
a)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 49ce874244..a9004b6d20 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -606,11 +606,11 @@ static void vfio_listener_region_add(MemoryListener=
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
+        iommu_iotlb_notifier_init(&giommu->n, vfio_iommu_map_notify,
+                                  IOMMU_NOTIFIER_IOTLB_ALL,
+                                  section->offset_within_region,
+                                  int128_get64(llend),
+                                  iommu_idx);
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
=20
         memory_region_register_iommu_notifier(section->mr, &giommu->n);
@@ -704,7 +704,8 @@ static void vfio_listener_region_del(MemoryListener *=
listener,
=20
         QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
             if (MEMORY_REGION(giommu->iommu) =3D=3D section->mr &&
-                giommu->n.start =3D=3D section->offset_within_region) {
+                is_iommu_iotlb_notifier(&giommu->n) &&
+                giommu->n.iotlb_notifier.start =3D=3D section->offset_wi=
thin_region) {
                 memory_region_unregister_iommu_notifier(section->mr,
                                                         &giommu->n);
                 QLIST_REMOVE(giommu, giommu_next);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f61018f2a..263a45d05b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -677,11 +677,11 @@ static void vhost_iommu_region_add(MemoryListener *=
listener,
     end =3D int128_sub(end, int128_one());
     iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
                                                    MEMTXATTRS_UNSPECIFIE=
D);
-    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_NOTIFIER_UNMAP,
-                        section->offset_within_region,
-                        int128_get64(end),
-                        iommu_idx);
+    iommu_iotlb_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
+                              IOMMU_NOTIFIER_IOTLB_UNMAP,
+                              section->offset_within_region,
+                              int128_get64(end),
+                              iommu_idx);
     iommu->mr =3D section->mr;
     iommu->iommu_offset =3D section->offset_within_address_space -
                           section->offset_within_region;
@@ -703,8 +703,8 @@ static void vhost_iommu_region_del(MemoryListener *li=
stener,
     }
=20
     QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
-        if (iommu->mr =3D=3D section->mr &&
-            iommu->n.start =3D=3D section->offset_within_region) {
+        if (iommu->mr =3D=3D section->mr && is_iommu_iotlb_notifier(&iom=
mu->n) &&
+            iommu->n.iotlb_notifier.start =3D=3D section->offset_within_=
region) {
             memory_region_unregister_iommu_notifier(iommu->mr,
                                                     &iommu->n);
             QLIST_REMOVE(iommu, iommu_next);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index ac4d06379f..3918352a17 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -81,23 +81,29 @@ struct IOMMUTLBEntry {
 typedef enum {
     IOMMU_NOTIFIER_NONE =3D 0,
     /* Notify cache invalidations */
-    IOMMU_NOTIFIER_UNMAP =3D 0x1,
+    IOMMU_NOTIFIER_IOTLB_UNMAP =3D 0x1,
     /* Notify entry changes (newly created entries) */
-    IOMMU_NOTIFIER_MAP =3D 0x2,
+    IOMMU_NOTIFIER_IOTLB_MAP =3D 0x2,
 } IOMMUNotifierFlag;
=20
-#define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
+#define IOMMU_NOTIFIER_IOTLB_ALL (IOMMU_NOTIFIER_IOTLB_MAP | IOMMU_NOTIF=
IER_IOTLB_UNMAP)
=20
 struct IOMMUNotifier;
 typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
                             IOMMUTLBEntry *data);
=20
-struct IOMMUNotifier {
+typedef struct IOMMUIOLTBNotifier {
     IOMMUNotify notify;
-    IOMMUNotifierFlag notifier_flags;
     /* Notify for address space range start <=3D addr <=3D end */
     hwaddr start;
     hwaddr end;
+} IOMMUIOLTBNotifier;
+
+struct IOMMUNotifier {
+    IOMMUNotifierFlag notifier_flags;
+    union {
+        IOMMUIOLTBNotifier iotlb_notifier;
+    };
     int iommu_idx;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
@@ -126,15 +132,18 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 /* RAM is a persistent kind memory */
 #define RAM_PMEM (1 << 5)
=20
-static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
-                                       IOMMUNotifierFlag flags,
-                                       hwaddr start, hwaddr end,
-                                       int iommu_idx)
+static inline void iommu_iotlb_notifier_init(IOMMUNotifier *n, IOMMUNoti=
fy fn,
+                                             IOMMUNotifierFlag flags,
+                                             hwaddr start, hwaddr end,
+                                             int iommu_idx)
 {
-    n->notify =3D fn;
+    assert(flags & IOMMU_NOTIFIER_IOTLB_MAP ||
+           flags & IOMMU_NOTIFIER_IOTLB_UNMAP);
+    assert(start < end);
     n->notifier_flags =3D flags;
-    n->start =3D start;
-    n->end =3D end;
+    n->iotlb_notifier.notify =3D fn;
+    n->iotlb_notifier.start =3D start;
+    n->iotlb_notifier.end =3D end;
     n->iommu_idx =3D iommu_idx;
 }
=20
@@ -633,6 +642,11 @@ void memory_region_init_resizeable_ram(MemoryRegion =
*mr,
                                                        uint64_t length,
                                                        void *host),
                                        Error **errp);
+
+static inline bool is_iommu_iotlb_notifier(IOMMUNotifier *n)
+{
+    return n->notifier_flags & IOMMU_NOTIFIER_IOTLB_ALL;
+}
 #ifdef CONFIG_POSIX
=20
 /**
@@ -1018,7 +1032,8 @@ static inline IOMMUMemoryRegionClass *memory_region=
_get_iommu_class_nocheck(
 uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_=
mr);
=20
 /**
- * memory_region_notify_iommu: notify a change in an IOMMU translation e=
ntry.
+ * memory_region_iotlb_notify_iommu: notify a change in an IOMMU transla=
tion
+ * entry.
  *
  * The notification type will be decided by entry.perm bits:
  *
@@ -1035,15 +1050,15 @@ uint64_t memory_region_iommu_get_min_page_size(IO=
MMUMemoryRegion *iommu_mr);
  *         replaces all old entries for the same virtual I/O address ran=
ge.
  *         Deleted entries have .@perm =3D=3D 0.
  */
-void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
-                                int iommu_idx,
-                                IOMMUTLBEntry entry);
+void memory_region_iotlb_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                      int iommu_idx,
+                                      IOMMUTLBEntry entry);
=20
 /**
- * memory_region_notify_one: notify a change in an IOMMU translation
- *                           entry to a single notifier
+ * memory_region_iotlb_notify_one: notify a change in an IOMMU translati=
on
+ *                                 entry to a single notifier
  *
- * This works just like memory_region_notify_iommu(), but it only
+ * This works just like memory_region_iotlb_notify_iommu(), but it only
  * notifies a specific notifier, not all of them.
  *
  * @notifier: the notifier to be notified
@@ -1051,8 +1066,8 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *=
iommu_mr,
  *         replaces all old entries for the same virtual I/O address ran=
ge.
  *         Deleted entries have .@perm =3D=3D 0.
  */
-void memory_region_notify_one(IOMMUNotifier *notifier,
-                              IOMMUTLBEntry *entry);
+void memory_region_iotlb_notify_one(IOMMUNotifier *notifier,
+                                    IOMMUTLBEntry *entry);
=20
 /**
  * memory_region_register_iommu_notifier: register a notifier for change=
s to
diff --git a/memory.c b/memory.c
index 9fbca52e05..bd9f425f0d 100644
--- a/memory.c
+++ b/memory.c
@@ -1862,7 +1862,9 @@ void memory_region_register_iommu_notifier(MemoryRe=
gion *mr,
     /* We need to register for at least one bitfield */
     iommu_mr =3D IOMMU_MEMORY_REGION(mr);
     assert(n->notifier_flags !=3D IOMMU_NOTIFIER_NONE);
-    assert(n->start <=3D n->end);
+    if (is_iommu_iotlb_notifier(n)) {
+        assert(n->iotlb_notifier.start <=3D n->iotlb_notifier.end);
+    }
     assert(n->iommu_idx >=3D 0 &&
            n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
=20
@@ -1898,7 +1900,7 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *=
iommu_mr, IOMMUNotifier *n)
     for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
         iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, n->iommu_i=
dx);
         if (iotlb.perm !=3D IOMMU_NONE) {
-            n->notify(n, &iotlb);
+            n->iotlb_notifier.notify(n, &iotlb);
         }
=20
         /* if (2^64 - MR size) < granularity, it's possible to get an
@@ -1932,42 +1934,44 @@ void memory_region_unregister_iommu_notifier(Memo=
ryRegion *mr,
     memory_region_update_iommu_notify_flags(iommu_mr);
 }
=20
-void memory_region_notify_one(IOMMUNotifier *notifier,
-                              IOMMUTLBEntry *entry)
+void memory_region_iotlb_notify_one(IOMMUNotifier *notifier,
+                                    IOMMUTLBEntry *entry)
 {
     IOMMUNotifierFlag request_flags;
=20
+    assert(is_iommu_iotlb_notifier(notifier));
     /*
      * Skip the notification if the notification does not overlap
      * with registered range.
      */
-    if (notifier->start > entry->iova + entry->addr_mask ||
-        notifier->end < entry->iova) {
+    if (notifier->iotlb_notifier.start > entry->iova + entry->addr_mask =
||
+        notifier->iotlb_notifier.end < entry->iova) {
         return;
     }
=20
     if (entry->perm & IOMMU_RW) {
-        request_flags =3D IOMMU_NOTIFIER_MAP;
+        request_flags =3D IOMMU_NOTIFIER_IOTLB_MAP;
     } else {
-        request_flags =3D IOMMU_NOTIFIER_UNMAP;
+        request_flags =3D IOMMU_NOTIFIER_IOTLB_UNMAP;
     }
=20
     if (notifier->notifier_flags & request_flags) {
-        notifier->notify(notifier, entry);
+        notifier->iotlb_notifier.notify(notifier, entry);
     }
 }
=20
-void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
-                                int iommu_idx,
-                                IOMMUTLBEntry entry)
+void memory_region_iotlb_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                      int iommu_idx,
+                                      IOMMUTLBEntry entry)
 {
     IOMMUNotifier *iommu_notifier;
=20
     assert(memory_region_is_iommu(MEMORY_REGION(iommu_mr)));
=20
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
-        if (iommu_notifier->iommu_idx =3D=3D iommu_idx) {
-            memory_region_notify_one(iommu_notifier, &entry);
+        if (iommu_notifier->iommu_idx =3D=3D iommu_idx &&
+            is_iommu_iotlb_notifier(iommu_notifier)) {
+            memory_region_iotlb_notify_one(iommu_notifier, &entry);
         }
     }
 }
--=20
2.20.1


