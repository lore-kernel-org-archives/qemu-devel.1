Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED043C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B287C24695
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhZxCWk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B287C24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8cef-0004fx-UR
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 23:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8ce5-00049p-9D
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8ce3-0004D1-9f
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:25:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8ce2-0004BT-V0
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583123130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jvWNRw+Ygvti/hp7R/fcBpiZ1L2h+OOs0iNXiyAsjTo=;
 b=NhZxCWk8bDOuKZzzinW+K1k9+WrJYbAg0TGDYWFjSGvNKGMeJRkooTSXWlx5B2/YLwmOmZ
 dEtaNKED0QOpF5hnbXsdCo7HXM1ZlLYHk9Rib68GMwA3o/lU/rbtYeIQTPUAdR5jzuKVW1
 m+u/kZb75w+dCakQ4L/0/1MHrxxA9GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-Nur-VLLBPcevIN6aXo0R0g-1; Sun, 01 Mar 2020 23:25:26 -0500
X-MC-Unique: Nur-VLLBPcevIN6aXo0R0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 255A5107ACCA;
 Mon,  2 Mar 2020 04:25:25 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-131.pek2.redhat.com [10.72.13.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1769B19E9C;
 Mon,  2 Mar 2020 04:25:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com
Subject: [PATCH V3] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Date: Mon,  2 Mar 2020 12:24:54 +0800
Message-Id: <20200302042454.24814-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pasic@linux.ibm.com, thomas.lendacky@amd.com,
 Jason Wang <jasowang@redhat.com>, brijesh.singh@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
platform without IOMMU support. This can lead unnecessary IOTLB
transactions which will damage the performance.

Fixing this by check whether the device is backed by IOMMU and disable
device IOTLB.

Reported-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V2:
- remove fixes tag
- tested with guest kernel virtio drivers + vIOMMU
Changes from V1:
- do not check acked_features
- reuse vhost_dev_has_iommu()
---
 hw/virtio/vhost.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9edfadc81d..9182a00495 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -290,7 +290,14 @@ static int vhost_dev_has_iommu(struct vhost_dev *dev)
 {
     VirtIODevice *vdev =3D dev->vdev;
=20
-    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+    /*
+     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
+     * incremental memory mapping API via IOTLB API. For platform that
+     * does not have IOMMU, there's no need to enable this feature
+     * which may cause unnecessary IOTLB miss/update trnasactions.
+     */
+    return vdev->dma_as !=3D &address_space_memory &&
+           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
 }
=20
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
@@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_dev *dev=
,
     if (enable_log) {
         features |=3D 0x1ULL << VHOST_F_LOG_ALL;
     }
+    if (!vhost_dev_has_iommu(dev)) {
+        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
+    }
     r =3D dev->vhost_ops->vhost_set_features(dev, features);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_features failed");
--=20
2.19.1


