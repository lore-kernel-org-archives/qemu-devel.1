Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC57920836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbjnYPJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC57920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHqa-00055d-89
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcy-0000rE-SK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcx-0004Xr-3L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKm01s4uoYNcg0A8gRDSfiSMGc6pTEcCI5zK0YNeAPM=;
 b=JbjnYPJybIEbQvoTzd80zVOMLM7elHMOCRVFkkDGTuoCZ8Fm7Q0Jyd4yrRfVKnmeTJGde7
 RcN12+03LbbrAQBpQJe1W53vedlqBwsnDBSBDFPmFI59J/iwPmF3E2JwqIwkugBIBZJYLr
 9JMoh+1gHDKH4eWbOOf7VmyxO6y3+tw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-Oi0hS4KXMo6kOUzPO01Bug-1; Fri, 03 Jul 2020 05:04:56 -0400
X-MC-Unique: Oi0hS4KXMo6kOUzPO01Bug-1
Received: by mail-wr1-f70.google.com with SMTP id d11so13664866wrw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YKm01s4uoYNcg0A8gRDSfiSMGc6pTEcCI5zK0YNeAPM=;
 b=MR3xDpDfaI5SZ2FroKw6SB/Pu7VCMWpw8HGEi+G7LIh0KKwDmLgkwSKyggZpmzOfbY
 Lwu9drv+imYEACpq4sxrUt6x0fO/tYgIFVhY8DBNwl/B7wLXg3qjQvrP92UPEvW1ohvh
 uuw9KMcXzJaXK+j3PWJn9/Y+1LtsRPtrvqVy06gNIy3JeXUYr0ZRVyddXO6hf/MN0hbJ
 6E5f16RPFpHNMxNR9lNXsTltHuMIjTUMqNFSjBN3U8cotQohvXMDmT+WOWJcMoIedL1t
 p1Dae/NYjEj3DTQWb+VtI0Hgo1a2S9VHvQ8idN3HN4fGmdrvhxiImJXO2adThDaQXUKt
 1iAQ==
X-Gm-Message-State: AOAM530Au1pv0WFukzJlur1YZZZjQCMn4I3NFD5QuC7J0BvjFmx4cS8d
 aDWtkYNUzbYcDcyIcZfedFL99DzKhsuJNKB6gFtiBCpdLMbok9VuUaGO02SDjBLMzqjIuCoLy+k
 SLxg93WmoAoz/2bI=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr35994531wml.95.1593767095296; 
 Fri, 03 Jul 2020 02:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE+j8JfhCoGRTyPd3wNH7Y2r8D/VAARyUoEkr8lIOXDJOiyLMDxJou2MrUXPzUD9oColpYmA==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr35994520wml.95.1593767095141; 
 Fri, 03 Jul 2020 02:04:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 z132sm13041650wmb.21.2020.07.03.02.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:54 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/41] virtio-pci: implement queue_enabled method
Message-ID: <20200703090252.368694-32-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

With version 1, we can detect whether a queue is enabled via
queue_enabled.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-5-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7bc8c1c056..8554cf2a03 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1107,6 +1107,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
     return pci_get_address_space(dev);
 }
 
+static bool virtio_pci_queue_enabled(DeviceState *d, int n)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        return proxy->vqs[vdev->queue_sel].enabled;
+    }
+
+    return virtio_queue_enabled(vdev, n);
+}
+
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
                                    struct virtio_pci_cap *cap)
 {
@@ -2064,6 +2076,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
     k->ioeventfd_enabled = virtio_pci_ioeventfd_enabled;
     k->ioeventfd_assign = virtio_pci_ioeventfd_assign;
     k->get_dma_as = virtio_pci_get_dma_as;
+    k->queue_enabled = virtio_pci_queue_enabled;
 }
 
 static const TypeInfo virtio_pci_bus_info = {
-- 
MST


