Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12EDC35DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D4A21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D4A21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Uql-0001QK-QD
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Upe-0008N8-30
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Upc-0003av-NQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55636 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j6Upc-0003Xy-Bo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:40 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8A63CF144D291DE3A32A;
 Tue, 25 Feb 2020 15:40:36 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 15:40:28 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <mst@redhat.com>
Subject: [PATCH 1/4] vhost-user-fs: do delete virtio_queues in unrealize
Date: Tue, 25 Feb 2020 15:55:51 +0800
Message-ID: <20200225075554.10835-2-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200225075554.10835-1-pannengyuan@huawei.com>
References: <20200225075554.10835-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to other virtio device(https://patchwork.kernel.org/patch/11399237/), virtio queues forgot to delete in unrealize, and aslo error path in realize, this patch fix these memleaks, the leak stack is as follow:
Direct leak of 57344 byte(s) in 1 object(s) allocated from:
    #0 0x7f15784fb970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f157790849d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55587a1bf859 in virtio_add_queue /mnt/sdb/qemu-new/qemu_test/qemu/hw/virtio/virtio.c:2333
    #3 0x55587a2071d5 in vuf_device_realize /mnt/sdb/qemu-new/qemu_test/qemu/hw/virtio/vhost-user-fs.c:212
    #4 0x55587a1ae360 in virtio_device_realize /mnt/sdb/qemu-new/qemu_test/qemu/hw/virtio/virtio.c:3531
    #5 0x55587a63fb7b in device_set_realized /mnt/sdb/qemu-new/qemu_test/qemu/hw/core/qdev.c:891
    #6 0x55587acf03f5 in property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu/qom/object.c:2238
    #7 0x55587acfce0d in object_property_set_qobject /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qobject.c:26
    #8 0x55587acf5c8c in object_property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu/qom/object.c:1390
    #9 0x55587a8e22a2 in pci_qdev_realize /mnt/sdb/qemu-new/qemu_test/qemu/hw/pci/pci.c:2095
    #10 0x55587a63fb7b in device_set_realized /mnt/sdb/qemu-new/qemu_test/qemu/hw/core/qdev.c:891
    #11 0x55587acf03f5 in property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu/qom/object.c:2238
    #12 0x55587acfce0d in object_property_set_qobject /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qobject.c:26
    #13 0x55587acf5c8c in object_property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu/qom/object.c:1390
    #14 0x55587a496d65 in qdev_device_add /mnt/sdb/qemu-new/qemu_test/qemu/qdev-monitor.c:679

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost-user-fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 33b17848c2..4554d123b7 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -230,6 +230,10 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
 
 err_virtio:
     vhost_user_cleanup(&fs->vhost_user);
+    virtio_del_queue(vdev, 0);
+    for (i = 0; i < fs->conf.num_request_queues; i++) {
+        virtio_del_queue(vdev, i + 1);
+    }
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     return;
@@ -239,6 +243,7 @@ static void vuf_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserFS *fs = VHOST_USER_FS(dev);
+    int i;
 
     /* This will stop vhost backend if appropriate. */
     vuf_set_status(vdev, 0);
@@ -247,6 +252,10 @@ static void vuf_device_unrealize(DeviceState *dev, Error **errp)
 
     vhost_user_cleanup(&fs->vhost_user);
 
+    virtio_del_queue(vdev, 0);
+    for (i = 0; i < fs->conf.num_request_queues; i++) {
+        virtio_del_queue(vdev, i + 1);
+    }
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
     fs->vhost_dev.vqs = NULL;
-- 
2.18.2


