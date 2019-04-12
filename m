Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A71C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EDA2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EDA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtMQ-0002xE-N9
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:24:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt4s-00035e-AL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt4r-0005D9-4m
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt4o-00055Y-9N; Fri, 12 Apr 2019 06:06:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DD7F3092642;
	Fri, 12 Apr 2019 10:06:29 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6239219C65;
	Fri, 12 Apr 2019 10:06:14 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:48 +0200
Message-Id: <20190412100354.6409-22-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 10:06:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 21/27] hw/vfio/common: Register a MAP notifier
 for MSI binding
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
Message-ID: <20190412100348.N16QzNMBjoTeW1Jg-rD-CQZUuHI8cMSe8Kgiivx8tK4@z>

Instantiate a MAP notifier to register the MSI stage 1
binding (gIOVA -> gDB) to the host. This allows the host
to build a nested mapping towards the physical doorbell:
guest IOVA -> guest Doorbell -> physical doorbell.
          Stage1          Stage 2

The unregistration is done on VFIO container deallocation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- only register the notifier if the IOMMU translates MSIs
- record the msi bindings in a container list and unregister on
  container release
---
 hw/vfio/common.c              | 69 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  8 ++++
 2 files changed, 77 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e9b729a503..051be723fd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -489,6 +489,56 @@ static void vfio_iommu_unmap_notify(IOMMUNotifier *n=
, IOMMUTLBEntry *iotlb)
     }
 }
=20
+static void vfio_iommu_msi_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *i=
otlb)
+{
+    VFIOGuestIOMMU *giommu =3D container_of(n, VFIOGuestIOMMU, n);
+    VFIOContainer *container =3D giommu->container;
+    int ret;
+
+    struct vfio_iommu_type1_bind_msi ustruct;
+    VFIOMSIBinding *binding;
+
+    QLIST_FOREACH(binding, &container->msibinding_list, next) {
+        if (binding->iova =3D=3D iotlb->iova) {
+            return;
+        }
+    }
+    ustruct.argsz =3D sizeof(struct vfio_iommu_type1_bind_msi);
+    ustruct.flags =3D 0;
+
+    ustruct.iova =3D iotlb->iova;
+    ustruct.gpa =3D iotlb->translated_addr;
+    ustruct.size =3D iotlb->addr_mask + 1;
+    ret =3D ioctl(container->fd, VFIO_IOMMU_BIND_MSI , &ustruct);
+    if (ret) {
+        error_report("%s: failed to register the stage1 MSI binding (%d)=
",
+                     __func__, ret);
+    }
+    binding =3D  g_new0(VFIOMSIBinding, 1);
+    binding->iova =3D ustruct.iova;
+    binding->gpa =3D ustruct.gpa;
+    binding->size =3D ustruct.size;
+
+    QLIST_INSERT_HEAD(&container->msibinding_list, binding, next);
+}
+
+static void vfio_container_unbind_msis(VFIOContainer *container)
+{
+    VFIOMSIBinding *binding, *tmp;
+
+    QLIST_FOREACH_SAFE(binding, &container->msibinding_list, next, tmp) =
{
+        struct vfio_iommu_type1_unbind_msi ustruct;
+
+        /* the MSI doorbell is not used anymore, unregister it */
+        ustruct.argsz =3D sizeof(struct vfio_iommu_type1_unbind_msi);
+        ustruct.flags =3D 0;
+        ustruct.iova =3D binding->iova;
+        ioctl(container->fd, VFIO_IOMMU_UNBIND_MSI , &ustruct);
+        QLIST_REMOVE(binding, next);
+        g_free(binding);
+    }
+}
+
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb=
)
 {
     VFIOGuestIOMMU *giommu =3D container_of(n, VFIOGuestIOMMU, n);
@@ -816,6 +866,8 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
                                                        MEMTXATTRS_UNSPEC=
IFIED);
=20
         if (container->iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
+            bool translate_msi;
+
             /* Config notifier to propagate guest stage 1 config changes=
 */
             giommu =3D vfio_alloc_guest_iommu(container, iommu_mr, offse=
t);
             iommu_config_notifier_init(&giommu->n, vfio_iommu_nested_not=
ify,
@@ -832,6 +884,21 @@ static void vfio_listener_region_add(MemoryListener =
*listener,
                                       iommu_idx);
             QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_ne=
xt);
             memory_region_register_iommu_notifier(section->mr, &giommu->=
n);
+
+            memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_MSI_TRANSL=
ATE,
+                                         (void *)&translate_msi);
+            if (translate_msi) {
+                giommu =3D vfio_alloc_guest_iommu(container, iommu_mr, o=
ffset);
+                iommu_iotlb_notifier_init(&giommu->n,
+                                          vfio_iommu_msi_map_notify,
+                                          IOMMU_NOTIFIER_IOTLB_MAP,
+                                          section->offset_within_region,
+                                          int128_get64(llend),
+                                          iommu_idx);
+                QLIST_INSERT_HEAD(&container->giommu_list, giommu,
+                                  giommu_next);
+                memory_region_register_iommu_notifier(section->mr, &giom=
mu->n);
+            }
         } else {
             /* MAP/UNMAP IOTLB notifier */
             giommu =3D vfio_alloc_guest_iommu(container, iommu_mr, offse=
t);
@@ -1608,6 +1675,8 @@ static void vfio_disconnect_container(VFIOGroup *gr=
oup)
             g_free(giommu);
         }
=20
+        vfio_container_unbind_msis(container);
+
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
         g_free(container);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 686d99ff8c..c862d87725 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -64,6 +64,13 @@ typedef struct VFIOAddressSpace {
     QLIST_ENTRY(VFIOAddressSpace) list;
 } VFIOAddressSpace;
=20
+typedef struct VFIOMSIBinding {
+    hwaddr iova;
+    hwaddr gpa;
+    hwaddr size;
+    QLIST_ENTRY(VFIOMSIBinding) next;
+} VFIOMSIBinding;
+
 struct VFIOGroup;
=20
 typedef struct VFIOContainer {
@@ -83,6 +90,7 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
+    QLIST_HEAD(, VFIOMSIBinding) msibinding_list;
     QLIST_ENTRY(VFIOContainer) next;
 } VFIOContainer;
=20
--=20
2.20.1


