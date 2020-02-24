Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97938C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 03:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB0120675
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 03:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB0120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j64tZ-00034m-Ee
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 22:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j64so-0001cV-GM
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 22:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j64sn-00065z-Du
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 22:58:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2725 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j64sk-00062g-Qu; Sun, 23 Feb 2020 22:58:11 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 68B52134498437A9FDAD;
 Mon, 24 Feb 2020 11:58:02 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 11:57:55 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH v2 1/2] vhost-user-blk: delete virtioqueues in unrealize to
 fix memleaks
Date: Mon, 24 Feb 2020 12:13:35 +0800
Message-ID: <20200224041336.30790-2-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200224041336.30790-1-pannengyuan@huawei.com>
References: <20200224041336.30790-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

virtio queues forgot to delete in unrealize, and aslo error path in
realize, this patch fix these memleaks, the leak stack is as follow:

Direct leak of 114688 byte(s) in 16 object(s) allocated from:
    #0 0x7f24024fdbf0 in calloc (/lib64/libasan.so.3+0xcabf0)
    #1 0x7f2401642015 in g_malloc0 (/lib64/libglib-2.0.so.0+0x50015)
    #2 0x55ad175a6447 in virtio_add_queue /mnt/sdb/qemu/hw/virtio/virtio.c:2327
    #3 0x55ad17570cf9 in vhost_user_blk_device_realize /mnt/sdb/qemu/hw/block/vhost-user-blk.c:419
    #4 0x55ad175a3707 in virtio_device_realize /mnt/sdb/qemu/hw/virtio/virtio.c:3509
    #5 0x55ad176ad0d1 in device_set_realized /mnt/sdb/qemu/hw/core/qdev.c:876
    #6 0x55ad1781ff9d in property_set_bool /mnt/sdb/qemu/qom/object.c:2080
    #7 0x55ad178245ae in object_property_set_qobject /mnt/sdb/qemu/qom/qom-qobject.c:26
    #8 0x55ad17821eb4 in object_property_set_bool /mnt/sdb/qemu/qom/object.c:1338
    #9 0x55ad177aeed7 in virtio_pci_realize /mnt/sdb/qemu/hw/virtio/virtio-pci.c:1801

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2->v1: There is no change in this patch(only change the patch2/2)
---
 hw/block/vhost-user-blk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index d8c459c575..2eba8b9db0 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -460,6 +460,9 @@ reconnect:
 virtio_err:
     g_free(s->vqs);
     g_free(s->inflight);
+    for (i = 0; i < s->num_queues; i++) {
+        virtio_del_queue(vdev, i);
+    }
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
@@ -468,6 +471,7 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(dev);
+    int i;
 
     virtio_set_status(vdev, 0);
     qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, NULL,
@@ -476,6 +480,10 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
     vhost_dev_free_inflight(s->inflight);
     g_free(s->vqs);
     g_free(s->inflight);
+
+    for (i = 0; i < s->num_queues; i++) {
+        virtio_del_queue(vdev, i);
+    }
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
-- 
2.18.2


