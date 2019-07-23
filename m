Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B859C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F4121926
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="msa0SpA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F4121926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq39U-00038L-9M
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 18:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38Q-0007PS-EZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38O-0001DS-Pk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38O-0001AZ-Hm; Tue, 23 Jul 2019 18:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563920389; x=1595456389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MhJpWEfDEuC+iblFD4CMKkboTq+c8XmTlRNIMN/AG54=;
 b=msa0SpA0g6WaxJt2gK27zqC84x/WLbjlm1Yvwztt4swmt3CwdxwYWCTT
 8l9H+2Wr+HkAplFATWwJZztdRlzkOGqA1YtpQ4Bhah4pzECIuyBA3wGyX
 U3GGDyA8I7OFfi3MEunruqRYW+cSG/SUNcfocuQQVgawKACI+Ja2qWIPl
 F1jDtr+QBwzl9rx7p7OM99aC5GOspJ5L6HEbCtk4sytr/oUgxByCKUPz0
 e59qo7JJ91fPYKEBbTVmMkMjI8aHeAtawrC4U4FyDmgHLOCm+sTm394dh
 H0P6b8N+d0erTCmL50Vyzpp45UqGorTEKZUYscuIal2zDSrsluo482zS1 A==;
IronPort-SDR: t4yLiTT7GJbRz+D0Hqyqg0LVVFD6tZgL6MpuSE9yI9fqG4YqmI4F9A6ykd63ch4RykW8QuXrRU
 SK5V7Hb/mupSPuUSXxQ093xzb41qZEl8kLtW06PXXEOpa3EpeVe8a9uicK8ZhfEJVNTodSG/NM
 le73D1ZvKzjhu3SCRt/OZr1yw+ODlEKWZVJK61F6KTDM+YdEZoQUXeSp4JRGgAf+jhxfJoF3ca
 QBfa2zrclkFJk/YYH7wcVWOawrs6ThhgmKninAqvqdep1MwOjcAW5BhBJZ64aNIni8LiINlvGr
 8GI=
X-IronPort-AV: E=Sophos;i="5.64,300,1559491200"; d="scan'208";a="113843262"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2019 06:19:46 +0800
IronPort-SDR: 5WJivhTvRCs8j4+9ktQuCj8OfOjD6OZTWGtqeSsIWUWUH3V5ROKLlbqbMeWvodkbeRkCoGlnii
 0cFmtM40CEdLMBvTLVLjvOVevFpb+tqk2no+zr4AJRzI8TO4WCunqLBpFmMB8PJKumqDmMgCv4
 6zpisBOhLGnlulqzaUteXTnGr2qfOYEBNjhbxP9M5zS/2Gnbq72DUSo4pROBbRWSh8Mt/XQiAx
 XR2YZRXGTo2sSr3HSFwbjW7bGHt6/qzfu1/ajUk1GSYfLDw8dmsEPQZNgDpzcAuNUlWngNuYqY
 +4fvZpOeIOnTpXKk4Ly7eMpY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 23 Jul 2019 15:17:59 -0700
IronPort-SDR: wVZ3V9paXqvdqPGwaYtaXqdFsLK7KNa33Gjs9HD6Wfo5Cs+PeUtPzmmUYQfEdnfyb24EoLKqbC
 ODMVp1XmjopeGpVQ3sYINLYWj7EYN0zLZeSyWC2qIwCRDAqBFb9QWtH8BhKocMmdlOt56IzU8y
 JGi8jEjLgoJM4A2ITzQLB4uJn7ZL7/+TXTi67wfRpMXpQapZdZdwHISKER0xk3KjpR8PFV3CsF
 LDesmyZW/FhTnlIGAe8oaxbN0dlvlnjPj1NVfp71KL45fgUu7Xl17vOXUcK7LfKtfEesc61SV5
 fVw=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2019 15:19:44 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 23 Jul 2019 18:19:39 -0400
Message-Id: <20190723221940.25585-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
References: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v3 3/4] block/ide/scsi: Set
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <paul.durrant@citrix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
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
 hw/block/fdc.c           |  4 ++--
 hw/block/nvme.c          |  2 +-
 hw/block/virtio-blk.c    |  2 +-
 hw/block/xen-block.c     |  2 +-
 hw/ide/qdev.c            |  2 +-
 hw/scsi/scsi-disk.c      | 13 +++++++------
 hw/scsi/scsi-generic.c   |  2 +-
 hw/usb/dev-storage.c     |  2 +-
 include/hw/block/block.h |  3 ++-
 10 files changed, 23 insertions(+), 17 deletions(-)

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
index 77af9979de..85efc80992 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -474,7 +474,7 @@ static void fd_change_cb(void *opaque, bool load, Error **errp)
     } else {
         if (!blkconf_apply_backend_options(drive->conf,
                                            blk_is_read_only(drive->blk), false,
-                                           errp)) {
+                                           false, errp)) {
             return;
         }
     }
@@ -561,7 +561,7 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
 
     if (!blkconf_apply_backend_options(&dev->conf,
                                        blk_is_read_only(dev->conf.blk),
-                                       false, errp)) {
+                                       false, false, errp)) {
         return;
     }
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 36d6a8bb3a..71b35bf4e7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1333,7 +1333,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
-                                       false, errp)) {
+                                       false, false, errp)) {
         return;
     }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index cbb3729158..8894bdbb0c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1123,7 +1123,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 
     if (!blkconf_apply_backend_options(&conf->conf,
                                        blk_is_read_only(conf->conf.blk), true,
-                                       errp)) {
+                                       false, errp)) {
         return;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 69d73196e2..8ed5e9d832 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -228,7 +228,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     }
 
     if (!blkconf_apply_backend_options(conf, blockdev->info & VDISK_READONLY,
-                                       true, errp)) {
+                                       true, false, errp)) {
         return;
     }
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 9d8502785d..c0b4a445e4 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -197,7 +197,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         }
     }
     if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
-                                       kind != IDE_CD, errp)) {
+                                       kind != IDE_CD, false, errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8e95e3e38d..f20815b1d7 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2315,7 +2315,7 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
     }
 }
 
-static void scsi_realize(SCSIDevice *dev, Error **errp)
+static void scsi_realize(SCSIDevice *dev, bool zoned_support, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
 
@@ -2353,7 +2353,8 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     }
     if (!blkconf_apply_backend_options(&dev->conf,
                                        blk_is_read_only(s->qdev.conf.blk),
-                                       dev->type == TYPE_DISK, errp)) {
+                                       dev->type == TYPE_DISK, zoned_support,
+                                       errp)) {
         return;
     }
 
@@ -2412,7 +2413,7 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU HARDDISK");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     if (ctx) {
         aio_context_release(ctx);
     }
@@ -2440,7 +2441,7 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
     if (!s->product) {
         s->product = g_strdup("QEMU CD-ROM");
     }
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, false, errp);
     aio_context_release(ctx);
 }
 
@@ -2450,7 +2451,7 @@ static void scsi_disk_realize(SCSIDevice *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!dev->conf.blk) {
-        scsi_realize(dev, &local_err);
+        scsi_realize(dev, false, &local_err);
         assert(local_err);
         error_propagate(errp, local_err);
         return;
@@ -2643,7 +2644,7 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
      */
     s->features |= (1 << SCSI_DISK_F_NO_REMOVABLE_DEVOPS);
 
-    scsi_realize(&s->qdev, errp);
+    scsi_realize(&s->qdev, true, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
 
 out:
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index c11a0c9a84..50b30e9541 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -690,7 +690,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     }
     if (!blkconf_apply_backend_options(&s->conf,
                                        blk_is_read_only(s->conf.blk),
-                                       true, errp)) {
+                                       true, true, errp)) {
         return;
     }
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 9ffb88ea5b..60d6a92ce1 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -601,7 +601,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 
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


