Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 11:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC537206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 11:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC537206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijM3H-0004mZ-QD
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 06:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijM2Q-0004JL-0P
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijM2N-0007yo-OG
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:38:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:49100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ijM2N-0007v2-Hc
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:38:11 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ijM2H-0002Ur-Ip; Mon, 23 Dec 2019 14:38:05 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] virtio-pci: store virtqueue size directly to a device
Date: Mon, 23 Dec 2019 14:37:58 +0300
Message-Id: <20191223113758.11951-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: den@virtuozzo.com, rkagan@virtuozzo.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currenly, the virtqueue size is saved to the proxy on pci writing and
is read from the device pci reading.
The virtqueue size is propagated later on form the proxy to the device
on virqueue enabling stage.

This could be a problem, if a guest, on the virtqueue configuration, sets
the size and then re-read it immediatly before the queue enabling
in order to check if the desiged size has been set.

This happens in seabios: (sebios snippet)

vp_find_vq()
{
    ...
    /* check if the queue is available */
    if (vp->use_modern) {
        num = vp_read(&vp->common, virtio_pci_common_cfg, queue_size);
        if (num > MAX_QUEUE_NUM) {
            vp_write(&vp->common, virtio_pci_common_cfg, queue_size,
                     MAX_QUEUE_NUM);
            num = vp_read(&vp->common, virtio_pci_common_cfg, queue_size);
        }
    } else {
        num = vp_read(&vp->legacy, virtio_pci_legacy, queue_num);
    }
    if (!num) {
        dprintf(1, "ERROR: queue size is 0\n");
        goto fail;
    }
    if (num > MAX_QUEUE_NUM) {
        dprintf(1, "ERROR: queue size %d > %d\n", num, MAX_QUEUE_NUM);
        goto fail;
    }
    ...
}

If the device queue num is greater then the max queue size supported by seabios,
seabios tries to reduce the queue size, then re-read it again, I suppose to
check if the setting actually happens, and then checks the virtqueue size again,
to deside whether it is satisfied with the vaule.
In this case, if device's virtqueue size is 512 and seabios max supported queue
size is 256, seabios tries to set 256 but than read 512 again and can't proceed
with that vaule, preventing the guest from successful booting.
The root case was investigated by Roman Kagan <rkagan@virtuozzo.com>

The patch fixes the problem, by propagating the queue size to the device right
away, so the written value could be read on the next step, if the value was
ok for the device.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/virtio/virtio-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..e5c759e19e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1256,6 +1256,8 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         break;
     case VIRTIO_PCI_COMMON_Q_SIZE:
         proxy->vqs[vdev->queue_sel].num = val;
+        virtio_queue_set_num(vdev, vdev->queue_sel,
+                             proxy->vqs[vdev->queue_sel].num);
         break;
     case VIRTIO_PCI_COMMON_Q_MSIX:
         msix_vector_unuse(&proxy->pci_dev,
-- 
2.17.0


