Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21904C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E7C20866
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVxLRxLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E7C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAw4p-0008R0-4X
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAw4B-0007kS-Sa
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAw4A-0007jh-Qs
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:34:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36905
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAw4A-0007jc-N0
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583674442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifzc42zHTMgVkuR/YxUmyOgyuaAG9QhAqdBKjpYiBjc=;
 b=hVxLRxLZA56NOi0rTLLZipqBTv3ttWeKWYQ6BW6YmhWc8wRpID3NDn18WVwXCImpHpuPjZ
 rm1AUMizKL2n8oItVXnEKuTJ9QlyiveRtEoDgMnpC3MjryrNumoBsm8x0FP1Fw/BtnPmpO
 KWcfKNEe8W0fffmhyIQlBgi7SxmEoAw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-vYoL68D8MY2dyNpzmQd8-w-1; Sun, 08 Mar 2020 09:31:21 -0400
X-MC-Unique: vYoL68D8MY2dyNpzmQd8-w-1
Received: by mail-qt1-f197.google.com with SMTP id b10so934844qto.21
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M+8AooxZJTJvkOY3bMqR0/HozcRDxgE8lr4XPeT8sJ0=;
 b=CN2EhgV1c44Rdu/QgXvr7XZ0Rqasqx4MMNvLbK9hhSvUs2TNGipnv2VyNUckyTrGvF
 Cr/PKCEt797Za1ml6E5zxm3B7GYpPfu8Zp/ugUxXN5SPVzBSIYj/yaY7d5AMk5I3Yugg
 vodez5dYLGqhs3o0iBF2RZ14Rg7V37SXhFZdMX+ZeMGWzGZiCAiB99GrapoKbaTlhaB7
 ZDzpcQbBotnrZNNsgvfHm1uKZNXAXiLIZFXSh+ODebIkZ1PJorMWTgFsn5rNafHMurkT
 +eTQa3ItEBlXi8KkQlmm84qzQAhYbatX3m+LN8MOsurLxGUwhLpLadEJZAhMuPtJf720
 JNrg==
X-Gm-Message-State: ANhLgQ2Zu0kwCEkzIqLlTdpY4O1WZ3YnDRPDAuFAueo9lKrEbOi/PEbS
 lqKkgn35iT+Dfsu+LKxUZNFTI0TZzCPfYeJZgBMO8moeVXTXKFJaE8+2NXrCCDYTQC3ECPAxUtP
 //Sz9Mqn4abrrtwk=
X-Received: by 2002:ac8:4985:: with SMTP id f5mr10516690qtq.156.1583674281080; 
 Sun, 08 Mar 2020 06:31:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs0gH5JDUgzwOne61A7RzlMqi/JkYzalM5mfvT3srCwvhe93Gk+DeU6upWP5xzMmF1vl6GZ4w==
X-Received: by 2002:ac8:4985:: with SMTP id f5mr10516675qtq.156.1583674280871; 
 Sun, 08 Mar 2020 06:31:20 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id t3sm19096206qkt.114.2020.03.08.06.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 06:31:20 -0700 (PDT)
Date: Sun, 8 Mar 2020 09:31:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200308133054.1563705-3-mst@redhat.com>
References: <20200308133054.1563705-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308133054.1563705-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
platform without IOMMU support. This can lead unnecessary IOTLB
transactions which will damage the performance.

Fixing this by check whether the device is backed by IOMMU and disable
device IOTLB.

Reported-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20200302042454.24814-1-jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0d226dae10..01ebe12f28 100644
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
MST


