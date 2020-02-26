Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B6C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CBD2467D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwDbckHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CBD2467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tFz-0005K1-IX
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j6tFE-0004WO-0w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j6tFA-0004EX-Vv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:44:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j6tFA-0004DO-RN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582710280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jTBdS1JLqqCvuybDhiFI6N2Egv85tKQ0QzmPjiOJZVU=;
 b=DwDbckHZYJ5U+blu2SrMaw4PwlVQky31icgll/K27VetCeTSN46qpU/pxAYrX1Siys2hk4
 PG0UhOf7/LtB89zJUWSyMixqvK3VoFoDBlNO6FYImS2vMkNBZ6u1YVbDXeJuQZgBrDn34I
 UDoeoPI5weS8u5YISs4dpjekL+eMSF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-FM4SGMMON1yeJr4IPdPiwg-1; Wed, 26 Feb 2020 04:44:38 -0500
X-MC-Unique: FM4SGMMON1yeJr4IPdPiwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E1B313F9;
 Wed, 26 Feb 2020 09:44:37 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-217.pek2.redhat.com [10.72.13.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 611A25C545;
 Wed, 26 Feb 2020 09:44:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Date: Wed, 26 Feb 2020 17:43:57 +0800
Message-Id: <20200226094357.25061-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pasic@linux.ibm.com, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
platform without IOMMU support. This can lead unnecessary IOTLB
transactions which will damage the performance.

Fixing this by check whether the device is backed by IOMMU and disable
device IOTLB.

Reported-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
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


