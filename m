Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8860DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54375206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGMEpzZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54375206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIGn-0004TG-Ca
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9I-00020F-Sp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:41:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9F-0006Tj-Iw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bJblkKicNbkNBh8o1ZXz54TSJZeugRiWQqLrT6UAWII=;
 b=AGMEpzZr+cOMTmhRYjLB+6SUsnHaoHCQ2l+Jo+lJI+5kCiEZvec5c3FoHFGqMKShAVsZFm
 UDgy1XlX4m4LaDy3fpJ2DgXHJLye1c9dGCI7jl67QjeyDe09wZTWdH/dprN4DT50PWVE7L
 e7flDbd8Ov0vezchelnfWEYEHMd+Fyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-wVEanIs8MemjJcWf1_Jahw-1; Thu, 27 Aug 2020 09:40:58 -0400
X-MC-Unique: wVEanIs8MemjJcWf1_Jahw-1
Received: by mail-wm1-f71.google.com with SMTP id a5so2067666wmj.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bJblkKicNbkNBh8o1ZXz54TSJZeugRiWQqLrT6UAWII=;
 b=OV76QRhloG2u2Lt+W3DW9wVFQFJ98ZmPRQu0+WANKfRAgSNhG3dLcREWANbI2ePR8K
 ytaLxFu1ECuRIvbWO+7BHKADw3vwULbKTnt/xOMY65KmQJQQQ13U0XujQQqP8gb9NUdP
 MHMSh/e8oglFV3SvvS4OdQ7Gjbj1oOSkki+L44N8PxjUvt4D+37oLEiGwPbP/NFp93ka
 N7wf0bHw55V8S3AQzN0pSHhyeya8LCWIkJzOPN7I/0+IJuZnpudqdRLKp8F0+cUOB8Ec
 vEnJjstVHg965Nqn1FGSezqb6LmhqvnZ/12nJ96F4GJH9H0DkeGZLinJ0jnJDAKupMRh
 2QkQ==
X-Gm-Message-State: AOAM531tY5LMWVEfbZBg6nu/UeLZtkZndjF43450uEekl/f/sk1dXEw/
 lXotNbDCC1djIcSJaNvblohfWupinmcV708tVerv0Te2RqsQRD2xJAHH98MHPp2gq3lzlT0BdzC
 lDyTLLap9xoDOxFo=
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr8889769wmf.40.1598535656624;
 Thu, 27 Aug 2020 06:40:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygKS9Jiq8aADOMeabK9vBHTUyRb1l1DvAVxB6W+XuKtHgQV9m1m2pFG8Gy1TQSvugy1HHNwg==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr8889745wmf.40.1598535656433;
 Thu, 27 Aug 2020 06:40:56 -0700 (PDT)
Received: from redhat.com (bzq-79-180-15-82.red.bezeqint.net. [79.180.15.82])
 by smtp.gmail.com with ESMTPSA id
 h6sm6347868wrv.40.2020.08.27.06.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:55 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/13] vhost-user-blk-pci: default num_queues to -smp N
Message-ID: <20200827133954.2118749-12-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Automatically size the number of request virtqueues to match the number
of vCPUs.  This ensures that completion interrupts are handled on the
same vCPU that submitted the request.  No IPI is necessary to complete
an I/O request and performance is improved.  The maximum number of MSI-X
vectors and virtqueues limit are respected.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20200818143348.310613-8-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h | 2 ++
 hw/block/vhost-user-blk.c          | 6 +++++-
 hw/core/machine.c                  | 1 +
 hw/virtio/vhost-user-blk-pci.c     | 4 ++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 34ad6f0c0e..292d17147c 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -25,6 +25,8 @@
 #define VHOST_USER_BLK(obj) \
         OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
 
+#define VHOST_USER_BLK_AUTO_NUM_QUEUES UINT16_MAX
+
 typedef struct VHostUserBlk {
     VirtIODevice parent_obj;
     CharBackend chardev;
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a00b854736..39aec42dae 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -420,6 +420,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
+        s->num_queues = 1;
+    }
     if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "vhost-user-blk: invalid number of IO queues");
         return;
@@ -531,7 +534,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
 
 static Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
-    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
+    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
+                       VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
     DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7f65fa8743..ea26d61237 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,6 +30,7 @@
 
 GlobalProperty hw_compat_5_1[] = {
     { "vhost-scsi", "num_queues", "1"},
+    { "vhost-user-blk", "num-queues", "1"},
     { "vhost-user-scsi", "num_queues", "1"},
     { "virtio-blk-device", "num-queues", "1"},
     { "virtio-scsi-device", "num_queues", "1"},
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 4f5d5cbf44..a62a71e067 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -54,6 +54,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    if (dev->vdev.num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
+        dev->vdev.num_queues = virtio_pci_optimal_num_queues(0);
+    }
+
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
         vpci_dev->nvectors = dev->vdev.num_queues + 1;
     }
-- 
MST


