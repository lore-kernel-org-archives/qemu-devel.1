Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52327C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A31920707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpOQ7put"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A31920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZn1-0007Sg-6Q
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZO8-0003VJ-CH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZO4-0001nJ-EW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCwklQt9sS1bGWr0feitdiQ1QfpA9UktJx3cpW47Mko=;
 b=YpOQ7putieZC2NT9CA6sx0s4rrJQyN38+XcFaw6WAqawaky/hUN+pJlfGV3e6j0L1xO8vn
 jmFY7LmXLMf6UMfy7x+FlsiLxWAXwhF5khOR06IcKrauhpN4rYY4xGNInicQjrz6zqix6v
 d8ypJu/G/3yYdvXvXRNaG6H76f5faiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-44gXWSAGPbuIIgK8LwJK8A-1; Wed, 17 Jun 2020 10:49:57 -0400
X-MC-Unique: 44gXWSAGPbuIIgK8LwJK8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D48E18A266A;
 Wed, 17 Jun 2020 14:49:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 159167CAA0;
 Wed, 17 Jun 2020 14:49:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/43] block: consolidate blocksize properties consistency
 checks
Date: Wed, 17 Jun 2020 16:48:57 +0200
Message-Id: <20200617144909.192176-32-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rvkagan@yandex-team.ru>

Several block device properties related to blocksize configuration must
be in certain relationship WRT each other: physical block must be no
smaller than logical block; min_io_size, opt_io_size, and
discard_granularity must be a multiple of a logical block.

To ensure these requirements are met, add corresponding consistency
checks to blkconf_blocksizes, adjusting its signature to communicate
possible error to the caller.  Also remove the now redundant consistency
checks from the specific devices.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20200528225516.1676602-3-rvkagan@yandex-team.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/block/block.h   |  2 +-
 hw/block/block.c           | 30 +++++++++++++++++++++++++++++-
 hw/block/fdc.c             |  5 ++++-
 hw/block/nvme.c            |  4 +++-
 hw/block/swim.c            |  5 ++++-
 hw/block/virtio-blk.c      |  7 +------
 hw/block/xen-block.c       |  6 +-----
 hw/ide/qdev.c              |  5 ++++-
 hw/scsi/scsi-disk.c        | 12 +++++-------
 hw/usb/dev-storage.c       |  5 ++++-
 tests/qemu-iotests/172.out |  2 +-
 11 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index d7246f3862..784953a237 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -87,7 +87,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
 bool blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
-void blkconf_blocksizes(BlockConf *conf);
+bool blkconf_blocksizes(BlockConf *conf, Error **errp);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c7612b..b22207c921 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -61,7 +61,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
     return true;
 }
 
-void blkconf_blocksizes(BlockConf *conf)
+bool blkconf_blocksizes(BlockConf *conf, Error **errp)
 {
     BlockBackend *blk = conf->blk;
     BlockSizes blocksizes;
@@ -83,6 +83,34 @@ void blkconf_blocksizes(BlockConf *conf)
             conf->logical_block_size = BDRV_SECTOR_SIZE;
         }
     }
+
+    if (conf->logical_block_size > conf->physical_block_size) {
+        error_setg(errp,
+                   "logical_block_size > physical_block_size not supported");
+        return false;
+    }
+
+    if (!QEMU_IS_ALIGNED(conf->min_io_size, conf->logical_block_size)) {
+        error_setg(errp,
+                   "min_io_size must be a multiple of logical_block_size");
+        return false;
+    }
+
+    if (!QEMU_IS_ALIGNED(conf->opt_io_size, conf->logical_block_size)) {
+        error_setg(errp,
+                   "opt_io_size must be a multiple of logical_block_size");
+        return false;
+    }
+
+    if (conf->discard_granularity != -1 &&
+        !QEMU_IS_ALIGNED(conf->discard_granularity,
+                         conf->logical_block_size)) {
+        error_setg(errp, "discard_granularity must be "
+                   "a multiple of logical_block_size");
+        return false;
+    }
+
+    return true;
 }
 
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 8528b9a3c7..be0674e4aa 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -554,7 +554,10 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
         read_only = !blk_bs(dev->conf.blk) || blk_is_read_only(dev->conf.blk);
     }
 
-    blkconf_blocksizes(&dev->conf);
+    if (!blkconf_blocksizes(&dev->conf, errp)) {
+        return;
+    }
+
     if (dev->conf.logical_block_size != 512 ||
         dev->conf.physical_block_size != 512)
     {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2a2e43f681..1aee042d4c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1425,7 +1425,9 @@ static void nvme_init_state(NvmeCtrl *n)
 
 static void nvme_init_blk(NvmeCtrl *n, Error **errp)
 {
-    blkconf_blocksizes(&n->conf);
+    if (!blkconf_blocksizes(&n->conf, errp)) {
+        return;
+    }
     blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
                                   false, errp);
 }
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 8f124782f4..74f56e8f46 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -189,7 +189,10 @@ static void swim_drive_realize(DeviceState *qdev, Error **errp)
         assert(ret == 0);
     }
 
-    blkconf_blocksizes(&dev->conf);
+    if (!blkconf_blocksizes(&dev->conf, errp)) {
+        return;
+    }
+
     if (dev->conf.logical_block_size != 512 ||
         dev->conf.physical_block_size != 512)
     {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6938a75aa5..413783693c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1174,12 +1174,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    blkconf_blocksizes(&conf->conf);
-
-    if (conf->conf.logical_block_size >
-        conf->conf.physical_block_size) {
-        error_setg(errp,
-                   "logical_block_size > physical_block_size not supported");
+    if (!blkconf_blocksizes(&conf->conf, errp)) {
         return;
     }
 
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 2827c90ac7..1b7bc5de08 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -239,11 +239,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
         return;
     }
 
-    blkconf_blocksizes(conf);
-
-    if (conf->logical_block_size > conf->physical_block_size) {
-        error_setg(
-            errp, "logical_block_size > physical_block_size not supported");
+    if (!blkconf_blocksizes(conf, errp)) {
         return;
     }
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index caa88526f5..3ccb5e2529 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -187,7 +187,10 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         return;
     }
 
-    blkconf_blocksizes(&dev->conf);
+    if (!blkconf_blocksizes(&dev->conf, errp)) {
+        return;
+    }
+
     if (dev->conf.logical_block_size != 512) {
         error_setg(errp, "logical_block_size must be 512 for IDE");
         return;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 387503e11b..8ce68a9dd6 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2346,12 +2346,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
         return;
     }
 
-    blkconf_blocksizes(&s->qdev.conf);
-
-    if (s->qdev.conf.logical_block_size >
-        s->qdev.conf.physical_block_size) {
-        error_setg(errp,
-                   "logical_block_size > physical_block_size not supported");
+    if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
         return;
     }
 
@@ -2436,7 +2431,9 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
     if (s->qdev.conf.blk) {
         ctx = blk_get_aio_context(s->qdev.conf.blk);
         aio_context_acquire(ctx);
-        blkconf_blocksizes(&s->qdev.conf);
+        if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
+            goto out;
+        }
     }
     s->qdev.blocksize = s->qdev.conf.logical_block_size;
     s->qdev.type = TYPE_DISK;
@@ -2444,6 +2441,7 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
         s->product = g_strdup("QEMU HARDDISK");
     }
     scsi_realize(&s->qdev, errp);
+out:
     if (ctx) {
         aio_context_release(ctx);
     }
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index a5204b6f2a..f5977eb72e 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -612,7 +612,10 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
         return;
     }
 
-    blkconf_blocksizes(&s->conf);
+    if (!blkconf_blocksizes(&s->conf, errp)) {
+        return;
+    }
+
     if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
                                        errp)) {
         return;
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 7abbe82427..59cc70aebb 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -1204,7 +1204,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=4096
-QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: Physical and logical block size must be 512 for floppy
+QEMU_PROG: -device floppy,drive=none0,logical_block_size=4096: logical_block_size > physical_block_size not supported
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physical_block_size=1024
 QEMU_PROG: -device floppy,drive=none0,physical_block_size=1024: Physical and logical block size must be 512 for floppy
-- 
2.25.4


