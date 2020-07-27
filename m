Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71154C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABA42073E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYb2bVpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABA42073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k058w-0006HE-H2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1k0587-0005cz-6J
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:33:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1k0585-0003go-3f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595864008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tDjUQ2Z9JsNJEcx/9dZ18f+wBEDy9xDAp0GKz2Db+tE=;
 b=cYb2bVpReMb4eXa9oyHo9QKi6OcufT9YEFupH/9qru2clX/3vkb2lTh1Uf53chOOwp/vth
 d9UVCttdy2f9TeGccJaDPWoX7qYB4LqbqNC0Vc77Jxf9RAckBWRbabrZrTxMIxjuukOiUD
 s11xJsNvO8Ejm6JI275F13xp2oKkdsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-dutLkrI7MLeqtvbK1FJ26Q-1; Mon, 27 Jul 2020 11:33:26 -0400
X-MC-Unique: dutLkrI7MLeqtvbK1FJ26Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A9B101C8AF
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 15:33:25 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-103.ams2.redhat.com
 [10.36.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B892B712C2;
 Mon, 27 Jul 2020 15:33:20 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-pci: fix virtio_pci_queue_enabled()
Date: Mon, 27 Jul 2020 17:33:19 +0200
Message-Id: <20200727153319.43716-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-pci.c     | 2 +-
 hw/virtio/virtio.c         | 7 ++++++-
 include/hw/virtio/virtio.h | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ada1101d07bf..4ad3ad81a2cf 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1116,7 +1116,7 @@ static bool virtio_pci_queue_enabled(DeviceState *d, int n)
         return proxy->vqs[vdev->queue_sel].enabled;
     }
 
-    return virtio_queue_enabled(vdev, n);
+    return virtio_queue_enabled_legacy(vdev, n);
 }
 
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 546a198e79b0..e98302521769 100644
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
index 198ffc762678..e424df12cf6d 100644
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
2.26.2


