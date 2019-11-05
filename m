Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFA6C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813C7206BA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813C7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1Vg-0001Jg-OO
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iS1QJ-0005Y6-Nq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iS1QI-0002un-CB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:11:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:43434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iS1QI-0002or-4V; Tue, 05 Nov 2019 11:11:14 -0500
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iS1Q9-0000Xh-W2; Tue, 05 Nov 2019 19:11:06 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Date: Tue,  5 Nov 2019 19:11:03 +0300
Message-Id: <20191105161105.19016-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

seg_max has a restriction to be less or equal to virtqueue size
according to Virtio 1.0 specification

Although seg_max can't be set directly, it's worth to express this
dependancy directly in the code for sanity purpose.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/block/virtio-blk.c | 2 +-
 hw/scsi/virtio-scsi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 06e57a4d39..21530304cf 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -903,7 +903,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     blk_get_geometry(s->blk, &capacity);
     memset(&blkcfg, 0, sizeof(blkcfg));
     virtio_stq_p(vdev, &blkcfg.capacity, capacity);
-    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
+    virtio_stl_p(vdev, &blkcfg.seg_max, s->conf.queue_size - 2);
     virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
     virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
     virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 839f120256..f7e5533cd5 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -650,7 +650,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(vdev);
 
     virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
-    virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
+    virtio_stl_p(vdev, &scsiconf->seg_max, s->conf.virtqueue_size - 2);
     virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
     virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
     virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent));
-- 
2.17.0


