Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71681C35641
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 03:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3F520675
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 03:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3F520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j64tb-000398-Eh
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 22:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j64so-0001cU-Ch
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 22:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j64sn-00065s-Ap
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 22:58:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2724 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j64sk-00062i-RU; Sun, 23 Feb 2020 22:58:11 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6E2FE300CAFF946C47B1;
 Mon, 24 Feb 2020 11:58:02 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 11:57:56 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH v2 2/2] vhost-use-blk: convert to new virtio_delete_queue
Date: Mon, 24 Feb 2020 12:13:36 +0800
Message-ID: <20200224041336.30790-3-pannengyuan@huawei.com>
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

use the new virtio_delete_queue function to cleanup.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
V2->V1:
- rename vqs to vhost_vqs to avoid confusing with virtqs (suggented by Stefan Hajnoczi)
---
 hw/block/vhost-user-blk.c          | 19 +++++++++++--------
 include/hw/virtio/vhost-user-blk.h |  3 ++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2eba8b9db0..12925a47ec 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -306,7 +306,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
     s->connected = true;
 
     s->dev.nvqs = s->num_queues;
-    s->dev.vqs = s->vqs;
+    s->dev.vqs = s->vhost_vqs;
     s->dev.vq_index = 0;
     s->dev.backend_features = 0;
 
@@ -420,13 +420,14 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
                 sizeof(struct virtio_blk_config));
 
+    s->virtqs = g_new(VirtQueue *, s->num_queues);
     for (i = 0; i < s->num_queues; i++) {
-        virtio_add_queue(vdev, s->queue_size,
-                         vhost_user_blk_handle_output);
+        s->virtqs[i] = virtio_add_queue(vdev, s->queue_size,
+                                        vhost_user_blk_handle_output);
     }
 
     s->inflight = g_new0(struct vhost_inflight, 1);
-    s->vqs = g_new0(struct vhost_virtqueue, s->num_queues);
+    s->vhost_vqs = g_new0(struct vhost_virtqueue, s->num_queues);
     s->watch = 0;
     s->connected = false;
 
@@ -458,11 +459,12 @@ reconnect:
     return;
 
 virtio_err:
-    g_free(s->vqs);
+    g_free(s->vhost_vqs);
     g_free(s->inflight);
     for (i = 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
@@ -478,12 +480,13 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
                              NULL, NULL, NULL, false);
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
-    g_free(s->vqs);
+    g_free(s->vhost_vqs);
     g_free(s->inflight);
 
     for (i = 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 108bfadeeb..05ea0ad183 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -36,7 +36,8 @@ typedef struct VHostUserBlk {
     struct vhost_dev dev;
     struct vhost_inflight *inflight;
     VhostUserState vhost_user;
-    struct vhost_virtqueue *vqs;
+    struct vhost_virtqueue *vhost_vqs;
+    VirtQueue **virtqs;
     guint watch;
     bool connected;
 } VHostUserBlk;
-- 
2.18.2


