Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD86C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44838206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9oxddSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44838206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIFn-0003bL-IV
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9F-0001wI-Ve
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:41:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9D-0006SH-OJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQdmfd6/QNB5EFTQ/xWH3TrC1t18Cg4IqgMT2a4SAxA=;
 b=N9oxddSja2wQ+vwcMcExOzLTqqAvG7JAYXdrO9Cf/BLP43Ux1y56GQ/V7i5Dcjks4fbdIF
 JtLrEzZN+1xikc2H34Ep4+2OUksGXlrtRz1wGEFtHf7uUFYzT5HHaTi/nhPehygdyQYP/K
 aQSQ5GiyZcUubJqhvyuAZly/5XYoZSA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-Qvw_JRSZOyyj1sHVCxKPuQ-1; Thu, 27 Aug 2020 09:40:57 -0400
X-MC-Unique: Qvw_JRSZOyyj1sHVCxKPuQ-1
Received: by mail-wm1-f70.google.com with SMTP id p184so2146198wmp.7
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VQdmfd6/QNB5EFTQ/xWH3TrC1t18Cg4IqgMT2a4SAxA=;
 b=XjSU/NZFUDc8vNCA43VQ9K8bYvgwtTAWmHeYLKN62iTtB6Ie9EDXsqc0N0ivXDoJoa
 s83LANpRwNzBrJlqsrI92aBDE3qGkUI4AL63mjyW7/NsFjFbIYHFycCpNmVwz3Fw69eh
 Cb518TSiZerIhhZde3xr9d/+SZvuCWIH+PFKrPVKYYy+ccNZFfziJP4A+ku+Bh4l27Jv
 qTY2xKaTelq+yPOr00A9kru9ePXHGPaw4KRSMMEq/dBpX9Mtw0bveJABYtlr5EYYnAi3
 V9Kd9zbgtaV8hFkNi1+FtR+rF2Ru1xVrrdO7FeM4fjF2ohXI7YJdskK2B5BcseDoY5d4
 IRvA==
X-Gm-Message-State: AOAM531lAWc2cZ8R7hF1ejjnDInsZuPFx+isR0+8skyzKXFyEcPeqfgG
 XWdN6lopKrvMyp0qfz/fc8WXzijqlsWMicOwGcNS8RI0AvOgeJxaotrZUFVhV8Q0coQJRFl7deH
 P7cb61SGH39t6gMA=
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr11397768wmb.129.1598535653600; 
 Thu, 27 Aug 2020 06:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtOSgBi/CLd2/8Xi16NQTj3PZqqZdMVo/EOlTvtFjhkD8K//wmBg+8Va4p17dtfJSgwobDMw==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr11397746wmb.129.1598535653385; 
 Thu, 27 Aug 2020 06:40:53 -0700 (PDT)
Received: from redhat.com (bzq-79-180-15-82.red.bezeqint.net. [79.180.15.82])
 by smtp.gmail.com with ESMTPSA id
 a3sm5292661wme.34.2020.08.27.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:52 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/13] virtio-blk-pci: default num_queues to -smp N
Message-ID: <20200827133954.2118749-11-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Automatically size the number of virtio-blk-pci request virtqueues to
match the number of vCPUs.  Other transports continue to default to 1
request virtqueue.

A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
handled on the same vCPU that submitted the request.  No IPI is
necessary to complete an I/O request and performance is improved.  The
maximum number of MSI-X vectors and virtqueues limit are respected.

Performance improves from 78k to 104k IOPS on a 32 vCPU guest with 101
virtio-blk-pci devices (ioengine=libaio, iodepth=1, bs=4k, rw=randread
with NVMe storage).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Message-Id: <20200818143348.310613-7-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-blk.h | 2 ++
 hw/block/virtio-blk.c          | 6 +++++-
 hw/core/machine.c              | 1 +
 hw/virtio/virtio-blk-pci.c     | 7 ++++++-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index b1334c3904..7539c2b848 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -30,6 +30,8 @@ struct virtio_blk_inhdr
     unsigned char status;
 };
 
+#define VIRTIO_BLK_AUTO_NUM_QUEUES UINT16_MAX
+
 struct VirtIOBlkConf
 {
     BlockConf conf;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 413783693c..2204ba149e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1147,6 +1147,9 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "Device needs media, but drive is empty");
         return;
     }
+    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
+        conf->num_queues = 1;
+    }
     if (!conf->num_queues) {
         error_setg(errp, "num-queues property must be larger than 0");
         return;
@@ -1281,7 +1284,8 @@ static Property virtio_blk_properties[] = {
 #endif
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
-    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
+                       VIRTIO_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
     DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9ee2aa0f7b..7f65fa8743 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -31,6 +31,7 @@
 GlobalProperty hw_compat_5_1[] = {
     { "vhost-scsi", "num_queues", "1"},
     { "vhost-user-scsi", "num_queues", "1"},
+    { "virtio-blk-device", "num-queues", "1"},
     { "virtio-scsi-device", "num_queues", "1"},
 };
 const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 849cc7dfd8..37c6e0aeb4 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -50,9 +50,14 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOBlkConf *conf = &dev->vdev.conf;
+
+    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
+        conf->num_queues = virtio_pci_optimal_num_queues(0);
+    }
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
+        vpci_dev->nvectors = conf->num_queues + 1;
     }
 
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
-- 
MST


