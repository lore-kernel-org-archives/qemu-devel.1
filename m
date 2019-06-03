Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07535C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D454B26756
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D454B26756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmXp-00016T-5t
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:58:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lihangjing@baidu.com>) id 1hXgMW-0006TI-8L
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lihangjing@baidu.com>) id 1hXgGi-0006uR-3w
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:16:29 -0400
Received: from mx22.baidu.com ([220.181.50.185]:57703 helo=baidu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lihangjing@baidu.com>) id 1hXgGh-0006Nd-LB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:16:28 -0400
Received: from m1-mail-ex09.internal.baidu.com (unknown [10.44.89.49])
	by Forcepoint Email with ESMTPS id 20AB4864EA32A;
	Mon,  3 Jun 2019 14:16:14 +0800 (CST)
Received: from BC-Mail-Ex03.internal.baidu.com (172.31.40.17) by
	m1-mail-ex09.internal.baidu.com (10.44.89.49) with Microsoft SMTP
	Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
	15.1.1531.3; Mon, 3 Jun 2019 14:16:15 +0800
Received: from DDAFF7EBB9FF247.internal.baidu.com (172.31.63.8) by
	BC-Mail-Ex03.internal.baidu.com (172.31.40.17) with Microsoft SMTP
	Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
	15.1.1531.3; Mon, 3 Jun 2019 14:16:08 +0800
From: "lihangjing@baidu.com" <lihangjing@baidu.com>
To: <mst@redhat.com>
Date: Mon, 3 Jun 2019 14:15:24 +0800
Message-ID: <20190603061524.24076-1-lihangjing@baidu.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-MAIL-EX01.internal.baidu.com (172.31.40.15) To
	BC-Mail-Ex03.internal.baidu.com (172.31.40.17)
X-Baidu-BdMsfe-DateCheck: 1_BC-Mail-Ex03_2019-06-03 14:16:08:671
X-Baidu-BdMsfe-VirusCheck: BC-Mail-Ex03_GRAY_Inside_WithoutAtta_2019-06-03
	14:16:08:718
X-Baidu-BdMsfe-DateCheck: 1_BC-Mail-Ex03_2019-06-03 14:16:08:733
X-Baidu-BdMsfe-DateCheck: 1_m1-mail-ex09_2019-06-03 14:16:15:794
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.50.185
X-Mailman-Approved-At: Mon, 03 Jun 2019 08:50:25 -0400
Subject: [Qemu-devel] [PATCH] vhost: fix vhost_log size overflow during
 migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Hangjing <lihangjing@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Hangjing <lihangjing@baidu.com>

When a guest which doesn't support multiqueue is migrated with a multi queues
vhost-user-blk deivce, a crash will occur like:

0 qemu_memfd_alloc (name=<value optimized out>, size=562949953421312, seals=<value optimized out>, fd=0x7f87171fe8b4, errp=0x7f87171fe8a8) at util/memfd.c:153
1 0x00007f883559d7cf in vhost_log_alloc (size=70368744177664, share=true) at hw/virtio/vhost.c:186
2 0x00007f88355a0758 in vhost_log_get (listener=0x7f8838bd7940, enable=1) at qemu-2-12/hw/virtio/vhost.c:211
3 vhost_dev_log_resize (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:263
4 vhost_migration_log (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:787
5 0x00007f88355463d6 in memory_global_dirty_log_start () at memory.c:2503
6 0x00007f8835550577 in ram_init_bitmaps (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2173
7 ram_init_all (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2192
8 ram_save_setup (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2219
9 0x00007f88357a419d in qemu_savevm_state_setup (f=0x7f88384ce600) at migration/savevm.c:1002
10 0x00007f883579fc3e in migration_thread (opaque=0x7f8837530400) at migration/migration.c:2382
11 0x00007f8832447893 in start_thread () from /lib64/libpthread.so.0
12 0x00007f8832178bfd in clone () from /lib64/libc.so.6

This is because vhost_get_log_size() returns a overflowed vhost-log size.
In this function, it uses the uninitialized variable vqs->used_phys and
vqs->used_size to get the vhost-log size.

Signed-off-by: Li Hangjing <lihangjing@baidu.com>
Reviewed-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
---
 hw/virtio/vhost.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f61018f2a..6d3a013f49 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -131,6 +131,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         vhost_dev_sync_region(dev, section, start_addr, end_addr, vq->used_phys,
                               range_get_last(vq->used_phys, vq->used_size));
     }
@@ -168,6 +173,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         uint64_t last = vq->used_phys + vq->used_size - 1;
         log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
     }
-- 
2.15.1.windows.2


