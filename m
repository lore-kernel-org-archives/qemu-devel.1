Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5910C4740C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 06:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F7B21928
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 06:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F7B21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCIIj-0007ha-DY
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 02:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iCIGf-0006FJ-Nf
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iCIGd-0006rh-Uu
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:56:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iCIGa-0006pK-Bc; Mon, 23 Sep 2019 02:56:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A551587642;
 Mon, 23 Sep 2019 06:56:11 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CACEA5EE1D;
 Mon, 23 Sep 2019 06:56:08 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com, aik@ozlabs.ru,
 david@gibson.dropbear.id.au
Subject: [PATCH v3 1/2] vfio: Turn the container error into an Error handle
Date: Mon, 23 Sep 2019 08:55:51 +0200
Message-Id: <20190923065552.10602-2-eric.auger@redhat.com>
In-Reply-To: <20190923065552.10602-1-eric.auger@redhat.com>
References: <20190923065552.10602-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 23 Sep 2019 06:56:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The container error integer field is currently used to store
the first error potentially encountered during any
vfio_listener_region_add() call. However this fails to propagate
detailed error messages up to the vfio_connect_container caller.
Instead of using an integer, let's use an Error handle.

Messages are slightly reworded to accomodate the propagation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c              | 61 +++++++++++++++++++++--------------
 hw/vfio/spapr.c               |  4 ++-
 include/hw/vfio/vfio-common.h |  2 +-
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3e03c495d8..a0670cc63a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -503,12 +503,14 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
                                      MemoryRegionSection *section)
 {
     VFIOContainer *container =3D container_of(listener, VFIOContainer, l=
istener);
+    MemoryRegion *mr =3D section->mr;
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
     int ret;
     VFIOHostDMAWindow *hostwin;
     bool hostwin_found;
+    Error *err =3D NULL;
=20
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_add_skip(
@@ -543,6 +545,9 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
                                hostwin->max_iova - hostwin->min_iova + 1=
,
                                section->offset_within_address_space,
                                int128_get64(section->size))) {
+                error_setg(&err, "Overlap with existing IOMMU range "
+                                 "[0x%"PRIx64",0x%"PRIx64"]", hostwin->m=
in_iova,
+                                 hostwin->max_iova - hostwin->min_iova +=
 1);
                 ret =3D -1;
                 goto fail;
             }
@@ -550,6 +555,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
=20
         ret =3D vfio_spapr_create_window(container, section, &pgsize);
         if (ret) {
+            error_setg_errno(&err, -ret, "Failed to create SPAPR window"=
);
             goto fail;
         }
=20
@@ -559,7 +565,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
 #ifdef CONFIG_KVM
         if (kvm_enabled()) {
             VFIOGroup *group;
-            IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section-=
>mr);
+            IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(mr);
             struct kvm_vfio_spapr_tce param;
             struct kvm_device_attr attr =3D {
                 .group =3D KVM_DEV_VFIO_GROUP,
@@ -594,18 +600,17 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
     }
=20
     if (!hostwin_found) {
-        error_report("vfio: IOMMU container %p can't map guest IOVA regi=
on"
-                     " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx,
-                     container, iova, end);
+        error_setg(&err, "Container %p can't map guest IOVA region"
+                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova,=
 end);
         ret =3D -EFAULT;
         goto fail;
     }
=20
-    memory_region_ref(section->mr);
+    memory_region_ref(mr);
=20
-    if (memory_region_is_iommu(section->mr)) {
+    if (memory_region_is_iommu(mr)) {
         VFIOGuestIOMMU *giommu;
-        IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr)=
;
+        IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(mr);
         int iommu_idx;
=20
         trace_vfio_listener_region_add_iommu(iova, end);
@@ -632,15 +637,15 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
                             iommu_idx);
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
=20
-        memory_region_register_iommu_notifier(section->mr, &giommu->n);
+        memory_region_register_iommu_notifier(mr, &giommu->n);
         memory_region_iommu_replay(giommu->iommu, &giommu->n);
=20
         return;
     }
=20
-    /* Here we assume that memory_region_is_ram(section->mr)=3D=3Dtrue *=
/
+    /* Here we assume that memory_region_is_ram(mr)=3D=3Dtrue */
=20
-    vaddr =3D memory_region_get_ram_ptr(section->mr) +
+    vaddr =3D memory_region_get_ram_ptr(mr) +
             section->offset_within_region +
             (iova - section->offset_within_address_space);
=20
@@ -648,12 +653,12 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
=20
     llsize =3D int128_sub(llend, int128_make64(iova));
=20
-    if (memory_region_is_ram_device(section->mr)) {
+    if (memory_region_is_ram_device(mr)) {
         hwaddr pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
=20
         if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
             trace_vfio_listener_region_add_no_dma_map(
-                memory_region_name(section->mr),
+                memory_region_name(mr),
                 section->offset_within_address_space,
                 int128_getlo(section->size),
                 pgmask + 1);
@@ -664,11 +669,12 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
     ret =3D vfio_dma_map(container, iova, int128_get64(llsize),
                        vaddr, section->readonly);
     if (ret) {
-        error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
-                     "0x%"HWADDR_PRIx", %p) =3D %d (%m)",
-                     container, iova, int128_get64(llsize), vaddr, ret);
-        if (memory_region_is_ram_device(section->mr)) {
+        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
+                   "0x%"HWADDR_PRIx", %p) =3D %d (%m)",
+                   container, iova, int128_get64(llsize), vaddr, ret);
+        if (memory_region_is_ram_device(mr)) {
             /* Allow unexpected mappings not to be fatal for RAM devices=
 */
+            error_report_err(err);
             return;
         }
         goto fail;
@@ -677,7 +683,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
     return;
=20
 fail:
-    if (memory_region_is_ram_device(section->mr)) {
+    if (memory_region_is_ram_device(mr)) {
         error_report("failed to vfio_dma_map. pci p2p may not work");
         return;
     }
@@ -688,10 +694,14 @@ fail:
      */
     if (!container->initialized) {
         if (!container->error) {
-            container->error =3D ret;
+            error_propagate_prepend(&container->error, err,
+                                    "Region %s: ", memory_region_name(mr=
));
+        } else {
+            error_free(err);
         }
     } else {
-        hw_error("vfio: DMA mapping failed, unable to continue");
+        error_reportf_err(err,
+                          "vfio: DMA mapping failed, unable to continue:=
 ");
     }
 }
=20
@@ -1251,6 +1261,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
     container =3D g_malloc0(sizeof(*container));
     container->space =3D space;
     container->fd =3D fd;
+    container->error =3D NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
=20
@@ -1308,9 +1319,9 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
                                      &address_space_memory);
             if (container->error) {
                 memory_listener_unregister(&container->prereg_listener);
-                ret =3D container->error;
-                error_setg(errp,
-                    "RAM memory listener initialization failed for conta=
iner");
+                ret =3D -1;
+                error_propagate_prepend(errp, container->error,
+                    "RAM memory listener initialization failed: ");
                 goto free_container_exit;
             }
         }
@@ -1365,9 +1376,9 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
     memory_listener_register(&container->listener, container->space->as)=
;
=20
     if (container->error) {
-        ret =3D container->error;
-        error_setg_errno(errp, -ret,
-                         "memory listener initialization failed for cont=
ainer");
+        ret =3D -1;
+        error_propagate_prepend(errp, container->error,
+            "memory listener initialization failed: ");
         goto listener_release_exit;
     }
=20
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 96c0ad9d9b..e853eebe11 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "trace.h"
=20
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *se=
ction)
@@ -85,7 +86,8 @@ static void vfio_prereg_listener_region_add(MemoryListe=
ner *listener,
          */
         if (!container->initialized) {
             if (!container->error) {
-                container->error =3D ret;
+                error_setg_errno(&container->error, -ret,
+                                 "Memory registering failed");
             }
         } else {
             hw_error("vfio: Memory registering failed, unable to continu=
e");
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 9107bd41c0..fd564209ac 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -71,7 +71,7 @@ typedef struct VFIOContainer {
     MemoryListener listener;
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    int error;
+    Error *error;
     bool initialized;
     unsigned long pgsizes;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
--=20
2.20.1


