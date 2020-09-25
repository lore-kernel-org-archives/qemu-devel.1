Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755EBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7AC2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7AC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrcw-0004cw-Sc
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kLrXl-0007Gw-5r
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:30:02 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:42864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kLrXh-0007Qt-Q9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:30:00 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-qZV5sxzfMYySinXGFhU5FA-1; Fri, 25 Sep 2020 13:29:51 -0400
X-MC-Unique: qZV5sxzfMYySinXGFhU5FA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F33E9CC03;
 Fri, 25 Sep 2020 17:29:50 +0000 (UTC)
Received: from bahia.lan (ovpn-112-195.ams2.redhat.com [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D2695D9DC;
 Fri, 25 Sep 2020 17:29:44 +0000 (UTC)
Subject: [PATCH] vhost: Ignore vrings in dirty log when using a vIOMMU
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 25 Sep 2020 19:29:43 +0200
Message-ID: <160105498386.68108.2145229309875282336.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 13:29:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a vIOMMU is present, any address comming from the guest is an IO
virtual address, including those of the vrings. The backend's accesses
to the vrings happen through vIOMMU translation : the backend hence
only logs the final guest physical address, not the IO virtual one.
It thus doesn't make sense to make room for the vring addresses in the
dirty log in this case.

This fixes a crash of the source when migrating a guest using in-kernel
vhost-net and iommu_platform=3Don on POWER, because DMA regions are put
at very high addresses and the resulting log size is likely to cause
g_malloc0() to abort.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1879349
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/virtio/vhost.c |   38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a642..0b83d6b8e65e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -106,6 +106,20 @@ static void vhost_dev_sync_region(struct vhost_dev *de=
v,
     }
 }
=20
+static int vhost_dev_has_iommu(struct vhost_dev *dev)
+{
+    VirtIODevice *vdev =3D dev->vdev;
+
+    /*
+     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
+     * incremental memory mapping API via IOTLB API. For platform that
+     * does not have IOMMU, there's no need to enable this feature
+     * which may cause unnecessary IOTLB miss/update trnasactions.
+     */
+    return vdev->dma_as !=3D &address_space_memory &&
+           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+}
+
 static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
                                    MemoryRegionSection *section,
                                    hwaddr first,
@@ -130,6 +144,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *d=
ev,
                               range_get_last(reg->guest_phys_addr,
                                              reg->memory_size));
     }
+
+    if (vhost_dev_has_iommu(dev)) {
+        return 0;
+    }
+
     for (i =3D 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq =3D dev->vqs + i;
=20
@@ -172,6 +191,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *d=
ev)
                                        reg->memory_size);
         log_size =3D MAX(log_size, last / VHOST_LOG_CHUNK + 1);
     }
+
+    if (vhost_dev_has_iommu(dev)) {
+        return log_size;
+    }
+
     for (i =3D 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq =3D dev->vqs + i;
=20
@@ -287,20 +311,6 @@ static inline void vhost_dev_log_resize(struct vhost_d=
ev *dev, uint64_t size)
     dev->log_size =3D size;
 }
=20
-static int vhost_dev_has_iommu(struct vhost_dev *dev)
-{
-    VirtIODevice *vdev =3D dev->vdev;
-
-    /*
-     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
-     * incremental memory mapping API via IOTLB API. For platform that
-     * does not have IOMMU, there's no need to enable this feature
-     * which may cause unnecessary IOTLB miss/update trnasactions.
-     */
-    return vdev->dma_as !=3D &address_space_memory &&
-           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
-}
-
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                               hwaddr *plen, bool is_write)
 {



