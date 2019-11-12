Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB1C17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B692084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B692084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUU8Q-00028c-7d
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iUU7h-0001Hi-5G
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iUU7e-0002oY-Tv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:14:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:37396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iUU7e-0002o0-KT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:14:10 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iUU7W-00008X-0X; Tue, 12 Nov 2019 14:14:02 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] virtio: make seg_max virtqueue size dependent
Date: Tue, 12 Nov 2019 14:13:53 +0300
Message-Id: <20191112111354.26324-2-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191112111354.26324-1-dplotnikov@virtuozzo.com>
References: <20191112111354.26324-1-dplotnikov@virtuozzo.com>
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com, mst@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before the patch, seg_max parameter was immutable and hardcoded
to 126 (128 - 2) without respect to queue size. This has two negative effects:

1. when queue size is < 128, we have Virtio 1.1 specfication violation:
   (2.6.5.3.1 Driver Requirements) seq_max must be <= queue_size.
   This violation affects the old Linux guests (ver < 4.14). These guests
   crash on these queue_size setups.

2. when queue_size > 128, as was pointed out by Denis Lunev <den@virtuozzo.com>,
   seg_max restrics guest's block request length which affects guests'
   performance making them issues more block request than needed.
   https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html

To mitigate this two effects, the patch adds the property adjusting seg_max
to queue size automaticaly. Since seg_max is a guest visible parameter,
the property is machine type managable and allows to choose between
old (seg_max = 126 always) and new (seg_max = queue_size - 2) behaviors.

Not to change the behavior of the older VMs, prevent setting the default
seg_max_adjust value for older machine types.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/block/virtio-blk.c           |  9 ++++++++-
 hw/core/machine.c               |  3 +++
 hw/scsi/vhost-scsi.c            |  2 ++
 hw/scsi/virtio-scsi.c           | 10 +++++++++-
 include/hw/virtio/virtio-blk.h  |  1 +
 include/hw/virtio/virtio-scsi.h |  1 +
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 4c357d2928..f118b29c7c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -908,7 +908,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     blk_get_geometry(s->blk, &capacity);
     memset(&blkcfg, 0, sizeof(blkcfg));
     virtio_stq_p(vdev, &blkcfg.capacity, capacity);
-    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
+    virtio_stl_p(vdev, &blkcfg.seg_max,
+                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
     virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
     virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
     virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
@@ -1131,6 +1132,11 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "num-queues property must be larger than 0");
         return;
     }
+    if (conf->queue_size <= 2) {
+        error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
+                   "must be > 2", conf->queue_size);
+        return;
+    }
     if (!is_power_of_2(conf->queue_size) ||
         conf->queue_size > VIRTQUEUE_MAX_SIZE) {
         error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
@@ -1260,6 +1266,7 @@ static Property virtio_blk_properties[] = {
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
     DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
+    DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_BIT64("discard", VirtIOBlock, host_features,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..3e7df94620 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,9 @@
 
 GlobalProperty hw_compat_4_1[] = {
     { "virtio-pci", "x-pcie-flr-init", "off" },
+    { "virtio-blk-device", "seg-max-adjust", "off"},
+    { "virtio-scsi-device", "seg_max_adjust", "off"},
+    { "vhost-blk-device", "seg_max_adjust", "off"},
 };
 const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index c693fc748a..26f710d3ec 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -275,6 +275,8 @@ static Property vhost_scsi_properties[] = {
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
                        128),
+    DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adjust,
+                      true),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index e8b2b64d09..405cb6c953 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -654,7 +654,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(vdev);
 
     virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
-    virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
+    virtio_stl_p(vdev, &scsiconf->seg_max,
+                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 128 - 2);
     virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
     virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
     virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent));
@@ -893,6 +894,11 @@ void virtio_scsi_common_realize(DeviceState *dev,
         virtio_cleanup(vdev);
         return;
     }
+    if (s->conf.virtqueue_size <= 2) {
+        error_setg(errp, "invalid virtqueue_size property (= %" PRIu16 "), "
+                   "must be > 2", s->conf.virtqueue_size);
+        return;
+    }
     s->cmd_vqs = g_new0(VirtQueue *, s->conf.num_queues);
     s->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
     s->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
@@ -949,6 +955,8 @@ static Property virtio_scsi_properties[] = {
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
                                          parent_obj.conf.virtqueue_size, 128),
+    DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
+                      parent_obj.conf.seg_max_adjust, true),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
                                                   0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index cddcfbebe9..2934426050 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -38,6 +38,7 @@ struct VirtIOBlkConf
     uint32_t request_merging;
     uint16_t num_queues;
     uint16_t queue_size;
+    bool seg_max_adjust;
     uint32_t max_discard_sectors;
     uint32_t max_write_zeroes_sectors;
 };
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 122f7c4b6f..24e768909d 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -48,6 +48,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
 struct VirtIOSCSIConf {
     uint32_t num_queues;
     uint32_t virtqueue_size;
+    bool seg_max_adjust;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
 #ifdef CONFIG_VHOST_SCSI
-- 
2.17.0


