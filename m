Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3490021874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jQuIahlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3490021874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FKu-0001O6-7Q
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F98-0007fA-6z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F96-0004M1-HS
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F93-0004Hy-0L; Fri, 23 Aug 2019 15:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566588165; x=1598124165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ArUqT7gctwo2CvLYjZvaT+85TujFifdpj4yt8JCxXJM=;
 b=jQuIahlw9eHvpAIjFZTl4UyPgO5bJYelovPfzyeEkHpbs4VgcP8hxZ1U
 cqAOIVY0ltG9/69SXoSGy3DdntmDii3Q1HH3fQQmM6nM+GicZ0Ot2yQou
 5ZaZT0rm0NCzKeWZwAJVGNBEOvSCR9G5Or6p3dptEejCIc/2JLY+z0Eue
 zUN5nqOD4rr7y5IqIDkP8yTCKkgB5Y3Vsi9oWKBaaxN1xJsRi9GTIygNi
 cmdRNq8opNk9nD4EBTPf2PyWPTSO3UZL0v4c6d5olwNKDT7yX2U6O1utf
 zWzbfP1cN35Ho32i6PGVsUhgMGsGCH970j1dyGjd40Up2JuClW0NreoYz A==;
IronPort-SDR: YfhTKjs8STB9HTxvBNwENlyzdn9pLsGMPtamkAqFPjvrhxPzzlHRZUdxKLjcPFk4l2gFR+AZG4
 p5NdqZkgrBlQeakTEfgYRlHo6pXugTRGRVrFdNQLTzP2pqM1HFs5rNFjaYvmrV9xgPtLK3drAz
 Bex9zc80a9vaaRVPpJrV9DVQ72Z7x/s2fyxCavp13cjZgkDhnINCfd7jlffrY8U5gsh7SiYe9j
 IkdO5HV/p8hbPgwiVCpC3flyeKVcGHLh+GlNO3FiFKTUkq9dIugvohyFB8WKMfLmC4rK7KDJxB
 QnU=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117476290"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:22:32 +0800
IronPort-SDR: zQCSFt9LrpqykH2dG0yBowDBzD3KclxS4EdduJRKqjKt6J5geD9ffrtKNpuuHwRYBqJ7/FYDli
 cSLp4+PBTAfqfMsHiIcHueja3ROF6VQJCx0AFW9Z0K6hY4NixAFmzh5hYD/0J3MyaisFoT/lcV
 bpIglbnUJ3SqDj6trdZqFlQKcMf3oXlHyeOu2cYCt+bi64lA0Ihxma7EJDRJkxZyPuVthk0SLZ
 Qa88/PuHCv4TXWwAOZ1Zgix2UdFeCfwErdeMNSq/kh5o9dWOd4bdlZLflaGJRTgMNQgl+amJZi
 Yutj8RfCR5AnNp2b7P2+d2Mj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:19:49 -0700
IronPort-SDR: d7avfQtrZfgVlbjpnhksWMzInrvVipWbbugOOciluZRzv79XzojZ2AbO2NVu3e9n5kqgU6EwmZ
 t25lekfDvwsNVRKT+ryk9A5P6KD1xVdn9NrVdBxkTXerNDvCgxFHJR2c9rhrjvTq7hhccNnBmx
 J5D2+fSTXbw239VjkDbmxrfgdeoq+z0oVghjzCB8LHKhYQhIw6UzCRjcUygPOr1aS6MvzSCdrU
 PbC9GClo29vd021if2jcepNB3sWY/egnb+gayfZDzFyxQj73XCCUy1sLXYw02Ewd1WP6qAjUQp
 80E=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 12:22:31 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:22:25 -0400
Message-Id: <20190823192226.21154-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823192226.21154-1-dmitry.fomichev@wdc.com>
References: <20190823192226.21154-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v4 3/4] block/ide/scsi: Set
 BLK_PERM_SUPPORT_ZONED
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added a new boolean argument to blkconf_apply_backend_options()
to let the common block code know whether the chosen block
backend can handle zoned block devices or not.

blkconf_apply_backend_options() then sets BLK_PERM_SUPPORT_ZONED
permission accordingly. The raw code can then use this permission
to allow or deny opening a zone device by a particular block driver.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Acked-by: Paul Durrant <paul.durrant@citrix.com>
---
 hw/block/block.c         |  8 ++++++--
 hw/block/fdc.c           |  5 +++--
 hw/block/nvme.c          |  2 +-
 hw/block/virtio-blk.c    |  2 +-
 hw/block/xen-block.c     |  2 +-
 hw/ide/qdev.c            |  2 +-
 hw/scsi/scsi-disk.c      | 13 +++++++------
 hw/scsi/scsi-generic.c   |  2 +-
 hw/usb/dev-storage.c     |  2 +-
 include/hw/block/block.h |  3 ++-
 10 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c7612b..23fbe4d567 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -86,7 +86,8 @@ void blkconf_blocksizes(BlockConf *conf)
 }
 
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
-                                   bool resizable, Error **errp)
+                                   bool resizable, bool zoned_support,
+                                   Error **errp)
 {
     BlockBackend *blk = conf->blk;
     BlockdevOnError rerror, werror;
@@ -98,9 +99,12 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
     if (!readonly) {
         perm |= BLK_PERM_WRITE;
     }
+    if (zoned_support) {
+        perm |= BLK_PERM_SUPPORT_ZONED;
+    }
 
     shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                  BLK_PERM_GRAPH_MOD;
+                  BLK_PERM_GRAPH_MOD | BLK_PERM_SUPPORT_ZONED;
     if (resizable) {
         shared_perm |= BLK_PERM_RESIZE;
     }
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index ac5d31e8c1..c5f41b3eb6 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -477,7 +477,7 @@ static void fd_change_cb(void *opaque, bool load, Error **errp)
     } else {
         if (!blkconf_apply_backend_options(drive->conf,
                                            blk_is_read_only(drive->blk), false,
-                                           errp)) {
+                                           false, errp)) {
             return;
         }
     }
@@ -569,7 +569,8 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     dev->conf.rerror = BLOCKDEV_ON_ERROR_AUTO;
     dev->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
 
-    if (!blkconf_apply_backend_options(&dev->conf, read_only, false, errp)) {
+    if (!blkconf_apply_backend_options(&dev->conf, read_only, false, false,
+    				       errp)) {
         return;
     }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 12d8254250..07f08d0768 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1334,7 +1334,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
-                                       false, errp)) {
+                                       false, false, errp)) {
         return;
     }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 18851601cb..8be62903e2 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1127,7 +1127,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 
     if (!blkconf_apply_backend_options(&conf->conf,
                                        blk_is_read_only(conf->conf.blk), true,
-                                       errp)) {
+                                       false, errp)) {
         return;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index f77343db60..57fe970908 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -229,7 +229,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     }
 
     if (!blkconf_apply_backend_options(conf, blockdev->info & VDISK_READONLY,
-                                       true, errp)) {
+                                       true, false, errp)) {
         return;
     }
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b8..a57a8f1a8f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -200,7 +200,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         }
     }
     if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
-                                       kind != IDE_CD, errp)) {
+                                       kind != IDE_CD, false, errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 915641a0f1..8a57caafd7 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2318,7 +2318,7 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
     }
 }
 
-static void scsi_realize(SCSIDevice *dev, Error **errp)
+static void scsi_realize(SCSIDevice *dev, bool zoned_support, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
     bool read_only;
@@ -2362,7 +2362,8 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     }
 
     if (!blkconf_apply_backend_options(&dev->conf, read_only,
-                                       dev->type == TYPE_DISK, errp)) {
+                                       dev->type == TYPE_DISK, zoned_support,
+                                       errp)) {
         return;
     }
 
@@ -2421,7 +2422,7 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU HARDDISK");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     if (ctx) {
         aio_context_release(ctx);
     }
@@ -2449,7 +2450,7 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU CD-ROM");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     aio_context_release(ctx);
 }
 
@@ -2459,7 +2460,7 @@ static void scsi_disk_realize(SCSIDevice *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!dev->conf.blk) {
-        scsi_realize(dev, &local_err);
+        scsi_realize(dev, false, &local_err);
         assert(local_err);
         error_propagate(errp, local_err);
         return;
@@ -2652,7 +2653,7 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
      */
     s->features |= (1 << SCSI_DISK_F_NO_REMOVABLE_DEVOPS);
 
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, true, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
 
 out:
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e7798ebcd0..ccce710497 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -692,7 +692,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     }
     if (!blkconf_apply_backend_options(&s->conf,
                                        blk_is_read_only(s->conf.blk),
-                                       true, errp)) {
+                                       true, true, errp)) {
         return;
     }
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8545193488..c75c0dd6a5 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -603,7 +603,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 
     blkconf_blocksizes(&s->conf);
     if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
-                                       errp)) {
+                                       false, errp)) {
         return;
     }
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 607539057a..f988edc87e 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -85,7 +85,8 @@ bool blkconf_geometry(BlockConf *conf, int *trans,
                       Error **errp);
 void blkconf_blocksizes(BlockConf *conf);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
-                                   bool resizable, Error **errp);
+                                   bool resizable, bool zoned_support,
+                                   Error **errp);
 
 /* Hard disk geometry */
 
-- 
2.21.0


