Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA49BC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AC120693
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dSFez/Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AC120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6jNp-0005RO-Ga
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 18:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM8-00041b-8q
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM6-0005dv-NL
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM3-0005aj-B1; Sat, 07 Sep 2019 18:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567895931; x=1599431931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MBBhGo+Tqtqsv62cjvG7ulZIMWT4PuuygCiGCjKrtX0=;
 b=dSFez/OaNpfU7iSQVqxbP1PZaI/b3AhE7yKEBR3tRu5aUw7Zk+iYh5Vt
 tazmDW8o2YQzlxIJ9ZKR1riZFUYccaiBr/kHWp8vcVDPzpgwwlZkOr+TV
 v/t1leXop+ZYZ0mzOPGcqR/yUHCntNvfX+UHEn6vr4+Aoo4jNonVZo0ZT
 pBaOkEtykFCB2FzF7LnPkH5VWmCsQwyd+5CZ3Nu4s3+RMaZW3kqWpC+p8
 rYmwbtuHMCwjuaRjJ27E/h2WUzsUKG+TsJuh/eXXbW7PADB3YncxrDGh6
 jY7VuZQ/SEx8KnAH9NGY2OaFyjfMlx2C4DFBlJ6BtDM1CIJWDUKfWlRRd w==;
IronPort-SDR: yLzymMVCORlnhR1b62wQw4HSRqxB8rMJeWYFqh6kX+JJMhe7C3giPdI4y9x34GDHseUoxMa9WZ
 B/XHTuTgWHFzNiGcblxP/UiB+adrsbFMJqiC5BaZBWblgW5uysU4Hi0mk0RU2RafrCCwp4Wxvd
 6EFuGJ9yJEJgYq3EujS3RnW25keuhMOf5MZ9rpMmTTXr3EGXfSc0Mg3oFvVfGR0zcQ8Nlt9E65
 BkagiIolrcwLo8BsxADaF6dqxl32VXYidAC82DqaHRZxcA/zviwcjLml4N8zjPFjdxPVUiu1d3
 zNM=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; d="scan'208";a="224505949"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 06:38:46 +0800
IronPort-SDR: 0kcpaEq3UgT4ACtW1JFpWTWYLh7tn1G8rcy5ipsrg0PGEs8hl3ZvUuh0LKQeVf+s+RjPoXd6Tx
 APY96C8xX1enSVuHdXlJzemPVPWVsJdkZT1vo1tBZyisaRYFjXgtrPoXgorQyzhJi0h5nYCsdK
 QccFm55j3rpjXqHkW4yGva1WfRGfA41/amTS3cGIH2Yk737LKAJRkTXnXaJ5qVmOxwyDO1lhI2
 kp+dMbpo0+0e1vfeHQDXWBKI8ZUsQWz1R4DNuy2x5+5Lmp9oe3x1dsTw/jmc/cSIkNBHfX63Dd
 FcOOOh7vxfEiS9eIESTN9ykC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2019 15:35:36 -0700
IronPort-SDR: tUTrHUswYyjk4QDvvd/N0qKWUuhOM1WG3aGz4snqYqEko7OTrXjqYSizL9xmi5UYM8xuG6ZRkf
 4ZfH0FRAdXbgmRKx6sJ3p/1MdgNICxq47/fQ46byIfpK7B6NXfRahzd/t5BRy348mH6LyHfZhi
 Oe+dc1gOk6mwJn7ab+jJGAzhc6FhTGdJ53dk2xZCJqBAoE5k6wFKJPq0obLUK/sAtY5g3HaHlr
 HiNsjmTMM0M8G0RKmmrscvN3kUoA64q3PZVml3zZU6wepyr1i5RxEGDaIXNZ9Lld+al1SkhN89
 GGQ=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Sep 2019 15:38:46 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Sat,  7 Sep 2019 18:38:40 -0400
Message-Id: <20190907223841.20210-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
References: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v7 3/4] block/ide/scsi: Set
 BLK_PERM_SUPPORT_HM_ZONED
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
backend can handle host managed zoned block devices.

blkconf_apply_backend_options() then sets BLK_PERM_SUPPORT_HM_ZONED
permission accordingly. The raw code can then use this permission
to allow or deny opening a zone device by a particular block driver.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Acked-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/block.c         |  6 +++++-
 hw/block/fdc.c           |  5 +++--
 hw/block/nvme.c          |  2 +-
 hw/block/virtio-blk.c    |  2 +-
 hw/block/xen-block.c     |  2 +-
 hw/ide/qdev.c            |  2 +-
 hw/scsi/scsi-disk.c      | 13 +++++++------
 hw/scsi/scsi-generic.c   |  2 +-
 hw/usb/dev-storage.c     |  2 +-
 include/hw/block/block.h |  3 ++-
 10 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c7612b..1c6019eee7 100644
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
@@ -98,6 +99,9 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
     if (!readonly) {
         perm |= BLK_PERM_WRITE;
     }
+    if (zoned_support) {
+        perm |= BLK_PERM_SUPPORT_HM_ZONED;
+    }
 
     shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                   BLK_PERM_GRAPH_MOD;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index ac5d31e8c1..673a8b39bc 100644
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
+                                       errp)) {
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


