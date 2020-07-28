Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 05:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0003820658
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 05:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7i7SZt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0003820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Idv-0002aR-5Y
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 01:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Icz-0001Mr-Bz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 01:58:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Icx-0007BI-OE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 01:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595915895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=3Sk+nCR7gZdtz5vJOCeGQeUmnmQKGvAkJ7TtLyJu0/k=;
 b=Q7i7SZt2gQRTAckHV7jRVNIGMA/aGDPG0tU1k7KDWtn5Vbz3LInCAZGgiOghZF7nqI652j
 uobImnjmZm/gABMDxATr/sKSYdLKzp2gfG3NAGPe2LRTHqdvlw6beVSKrzrTWo9Ag8Seht
 MSwYz9qf4gka+lVdNZXRz+xH+2zu3vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-dNYAYNeMMU6gTmtMpB-5iA-1; Tue, 28 Jul 2020 01:58:11 -0400
X-MC-Unique: dNYAYNeMMU6gTmtMpB-5iA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685978017FB;
 Tue, 28 Jul 2020 05:58:10 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-130.pek2.redhat.com
 [10.72.13.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92EA41002388;
 Tue, 28 Jul 2020 05:58:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 2/4] virtio-pci: fix virtio_pci_queue_enabled()
Date: Tue, 28 Jul 2020 13:57:56 +0800
Message-Id: <1595915878-22568-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1595915878-22568-1-git-send-email-jasowang@redhat.com>
References: <1595915878-22568-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:56:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

In legacy mode, virtio_pci_queue_enabled() falls back to
virtio_queue_enabled() to know if the queue is enabled.

But virtio_queue_enabled() calls again virtio_pci_queue_enabled()
if k->queue_enabled is set. This ends in a crash after a stack
overflow.

The problem can be reproduced with
"-device virtio-net-pci,disable-legacy=off,disable-modern=true
 -net tap,vhost=on"

And a look to the backtrace is very explicit:

    ...
    #4  0x000000010029a438 in virtio_queue_enabled ()
    #5  0x0000000100497a9c in virtio_pci_queue_enabled ()
    ...
    #130902 0x000000010029a460 in virtio_queue_enabled ()
    #130903 0x0000000100497a9c in virtio_pci_queue_enabled ()
    #130904 0x000000010029a460 in virtio_queue_enabled ()
    #130905 0x0000000100454a20 in vhost_net_start ()
    ...

This patch fixes the problem by introducing a new function
for the legacy case and calls it from virtio_pci_queue_enabled().
It also calls it from virtio_queue_enabled() to avoid code duplication.

Fixes: f19bcdfedd53 ("virtio-pci: implement queue_enabled method")
Cc: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-pci.c     | 2 +-
 hw/virtio/virtio.c         | 7 ++++++-
 include/hw/virtio/virtio.h | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 2b1f9cc..ccdf54e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1116,7 +1116,7 @@ static bool virtio_pci_queue_enabled(DeviceState *d, int n)
         return proxy->vqs[n].enabled;
     }
 
-    return virtio_queue_enabled(vdev, n);
+    return virtio_queue_enabled_legacy(vdev, n);
 }
 
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 546a198..e983025 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3309,6 +3309,11 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
     return vdev->vq[n].vring.desc;
 }
 
+bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n)
+{
+    return virtio_queue_get_desc_addr(vdev, n) != 0;
+}
+
 bool virtio_queue_enabled(VirtIODevice *vdev, int n)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -3317,7 +3322,7 @@ bool virtio_queue_enabled(VirtIODevice *vdev, int n)
     if (k->queue_enabled) {
         return k->queue_enabled(qbus->parent, n);
     }
-    return virtio_queue_get_desc_addr(vdev, n) != 0;
+    return virtio_queue_enabled_legacy(vdev, n);
 }
 
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 198ffc7..e424df1 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -295,6 +295,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
                       VIRTIO_F_RING_PACKED, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
+bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
 bool virtio_queue_enabled(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
-- 
2.7.4


