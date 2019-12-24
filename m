Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50AC2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 08:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09F520643
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 08:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09F520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijfMB-0006Cl-Hg
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 03:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijfLL-0005gJ-Gn
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 03:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijfLK-0003ZO-78
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 03:15:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:58202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ijfLJ-0003Yd-W2
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 03:15:02 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ijfLB-0000il-0A; Tue, 24 Dec 2019 11:14:53 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] virtio-mmio: update queue size on guest write
Date: Tue, 24 Dec 2019 11:14:46 +0300
Message-Id: <20191224081446.17003-1-dplotnikov@virtuozzo.com>
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some guests read back queue size after writing it.
Always update the on size write otherwise they might be confused.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/virtio/virtio-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 94d934c44b..1e40a74869 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -295,8 +295,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
         trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
+        virtio_queue_set_num(vdev, vdev->queue_sel, value);
+
         if (proxy->legacy) {
-            virtio_queue_set_num(vdev, vdev->queue_sel, value);
             virtio_queue_update_rings(vdev, vdev->queue_sel);
         } else {
             proxy->vqs[vdev->queue_sel].num = value;
-- 
2.17.0


