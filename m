Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F177C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0959E2084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0959E2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtH3-0007ur-3W
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:07:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hDtCq-0005Gg-RC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hDtCp-0008NK-Ny
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hDtCi-0008Jv-Us; Tue, 09 Apr 2019 12:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CE65C0AD1DF;
	Tue,  9 Apr 2019 16:02:30 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1A1817CE2;
	Tue,  9 Apr 2019 16:02:24 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Tue,  9 Apr 2019 18:02:19 +0200
Message-Id: <20190409160219.19026-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 09 Apr 2019 16:02:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] hw/arm/smmuv3: Remove SMMUNotifierNode
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409160219.-ni2BdUnV2pusCpAWNApGKcDUQt_ysKmeWoIthlda_0@z>

The SMMUNotifierNode struct is not necessary and brings extra
complexity so let's remove it. We now directly track the SMMUDevices
which have registered IOMMU MR notifiers.

This is inspired from the same transformation on intel-iommu
done in commit b4a4ba0d68f50f218ee3957b6638dbee32a5eeef
("intel-iommu: remove IntelIOMMUNotifierNode")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c         |  6 +++---
 hw/arm/smmuv3.c              | 28 +++++++---------------------
 include/hw/arm/smmu-common.h |  8 ++------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index bbf4b8721a..e94be6db6c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -412,10 +412,10 @@ inline void smmu_inv_notifiers_mr(IOMMUMemoryRegion=
 *mr)
 /* Unmap all notifiers of all mr's */
 void smmu_inv_notifiers_all(SMMUState *s)
 {
-    SMMUNotifierNode *node;
+    SMMUDevice *sdev;
=20
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        smmu_inv_notifiers_mr(&node->sdev->iommu);
+    QLIST_FOREACH(sdev, &s->devices_with_notifiers, next) {
+        smmu_inv_notifiers_mr(&sdev->iommu);
     }
 }
=20
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8c4e99fecc..fd8ec7860e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -828,10 +828,10 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *m=
r,
 /* invalidate an asid/iova tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t=
 iova)
 {
-    SMMUNotifierNode *node;
+    SMMUDevice *sdev;
=20
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        IOMMUMemoryRegion *mr =3D &node->sdev->iommu;
+    QLIST_FOREACH(sdev, &s->devices_with_notifiers, next) {
+        IOMMUMemoryRegion *mr =3D &sdev->iommu;
         IOMMUNotifier *n;
=20
         trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova)=
;
@@ -1472,8 +1472,6 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryR=
egion *iommu,
     SMMUDevice *sdev =3D container_of(iommu, SMMUDevice, iommu);
     SMMUv3State *s3 =3D sdev->smmu;
     SMMUState *s =3D &(s3->smmu_state);
-    SMMUNotifierNode *node =3D NULL;
-    SMMUNotifierNode *next_node =3D NULL;
=20
     if (new & IOMMU_NOTIFIER_MAP) {
         int bus_num =3D pci_bus_num(sdev->bus);
@@ -1485,22 +1483,10 @@ static void smmuv3_notify_flag_changed(IOMMUMemor=
yRegion *iommu,
=20
     if (old =3D=3D IOMMU_NOTIFIER_NONE) {
         trace_smmuv3_notify_flag_add(iommu->parent_obj.name);
-        node =3D g_malloc0(sizeof(*node));
-        node->sdev =3D sdev;
-        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
-        return;
-    }
-
-    /* update notifier node with new flags */
-    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
-        if (node->sdev =3D=3D sdev) {
-            if (new =3D=3D IOMMU_NOTIFIER_NONE) {
-                trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
-                QLIST_REMOVE(node, next);
-                g_free(node);
-            }
-            return;
-        }
+        QLIST_INSERT_HEAD(&s->devices_with_notifiers, sdev, next);
+    } else if (new =3D=3D IOMMU_NOTIFIER_NONE) {
+        trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
+        QLIST_REMOVE(sdev, next);
     }
 }
=20
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b07cadd0ef..2c7fbf4202 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -80,13 +80,9 @@ typedef struct SMMUDevice {
     AddressSpace       as;
     uint32_t           cfg_cache_hits;
     uint32_t           cfg_cache_misses;
+    QLIST_ENTRY(SMMUDevice) next;
 } SMMUDevice;
=20
-typedef struct SMMUNotifierNode {
-    SMMUDevice *sdev;
-    QLIST_ENTRY(SMMUNotifierNode) next;
-} SMMUNotifierNode;
-
 typedef struct SMMUPciBus {
     PCIBus       *bus;
     SMMUDevice   *pbdev[0]; /* Parent array is sparse, so dynamically al=
loc */
@@ -108,7 +104,7 @@ typedef struct SMMUState {
     GHashTable *iotlb;
     SMMUPciBus *smmu_pcibus_by_bus_num[SMMU_PCI_BUS_MAX];
     PCIBus *pci_bus;
-    QLIST_HEAD(, SMMUNotifierNode) notifiers_list;
+    QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
     uint8_t bus_num;
     PCIBus *primary_bus;
 } SMMUState;
--=20
2.20.1


