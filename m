Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A3CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B122E20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B122E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUYH-0003dc-02
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jgUXa-0002d6-DO; Wed, 03 Jun 2020 10:38:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:60350 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jgUXY-0005yE-0g; Wed, 03 Jun 2020 10:38:49 -0400
Received: from [192.168.15.173] (helo=iris.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jgUXP-00043t-E6; Wed, 03 Jun 2020 17:38:39 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/1] block: propagate discard alignment from format drivers to
 the guest
Date: Wed,  3 Jun 2020 17:38:40 +0300
Message-Id: <20200603143840.31856-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 10:38:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nowaday SCSI drivers in guests are able to align UNMAP requests before
sending to the device. Right now QEMU provides an ability to set
this via "discard_granularity" property of the block device which could
be used by management layer.

Though, in particular, from the point of QEMU, there is
pdiscard_granularity on the format driver level, f.e. on QCOW2 or iSCSI.
It would be beneficial to pass this value as a default for this
property.

Technically this should reduce the amount of use less UNMAP requests
from the guest to the host. Basic test confirms this. Fedora 31 guest
during 'fstrim /' on 32 Gb disk has issued 401/415 requests with/without
proper alignment to QEMU.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: John Snow <jsnow@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Fam Zheng <fam@euphon.net>
---
 block/block-backend.c          | 11 +++++++++++
 hw/core/machine.c              | 15 ++++++++++++++-
 hw/ide/qdev.c                  |  3 ++-
 hw/scsi/scsi-disk.c            |  5 ++++-
 include/hw/block/block.h       |  2 +-
 include/sysemu/block-backend.h |  6 ++++++
 6 files changed, 38 insertions(+), 4 deletions(-)

Changes from v1:
- fixed typos in description
- added machine type compatibility layer as suggested by Kevin

diff --git a/block/block-backend.c b/block/block-backend.c
index 6936b25c83..9342a475cb 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2222,6 +2222,17 @@ int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo)
     return bdrv_probe_geometry(blk_bs(blk), geo);
 }
 
+int blk_discard_granularity(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+
+    if (bs == NULL) {
+        return DEFAULT_DISCARD_GRANULARITY;
+    }
+
+    return bs->bl.pdiscard_alignment;
+}
+
 /*
  * Updates the BlockBackendRootState object with data from the currently
  * attached BlockDriverState.
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb3a7b18b1..08a242d606 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,7 +28,20 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
 
-GlobalProperty hw_compat_5_0[] = {};
+GlobalProperty hw_compat_5_0[] = {
+    { "ide-cd", "discard_granularity", "0xffffffff" },
+    { "ide-hd", "discard_granularity", "0xffffffff" },
+    { "ide-drive", "discard_granularity", "0xffffffff" },
+    { "scsi-hd", "discard_granularity", "0xffffffff" },
+    { "scsi-cd", "discard_granularity", "0xffffffff" },
+    { "scsi-disk", "discard_granularity", "0xffffffff" },
+    { "virtio-blk-pci", "discard_granularity", "0xffffffff" },
+    { "xen-block", "discard_granularity", "0xffffffff" },
+    { "usb-storage", "discard_granularity", "0xffffffff" },
+    { "swim-drive", "discard_granularity", "0xffffffff" },
+    { "floppy", "discard_granularity", "0xffffffff" },
+    { "nvme", "discard_granularity", "0xffffffff" },
+};
 const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
 
 GlobalProperty hw_compat_4_2[] = {
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 06b11583f5..e515dbeb0e 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -179,7 +179,8 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         }
     }
 
-    if (dev->conf.discard_granularity == -1) {
+    if (dev->conf.discard_granularity == -1 ||
+        dev->conf.discard_granularity == -2) {
         dev->conf.discard_granularity = 512;
     } else if (dev->conf.discard_granularity &&
                dev->conf.discard_granularity != 512) {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 387503e11b..6b809608e4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -48,7 +48,6 @@
 #define SCSI_MAX_INQUIRY_LEN        256
 #define SCSI_MAX_MODE_LEN           256
 
-#define DEFAULT_DISCARD_GRANULARITY (4 * KiB)
 #define DEFAULT_MAX_UNMAP_SIZE      (1 * GiB)
 #define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
 
@@ -2381,6 +2380,10 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     if (s->qdev.conf.discard_granularity == -1) {
         s->qdev.conf.discard_granularity =
             MAX(s->qdev.conf.logical_block_size, DEFAULT_DISCARD_GRANULARITY);
+    } else if (s->qdev.conf.discard_granularity == -2) {
+        s->qdev.conf.discard_granularity =
+            MAX(s->qdev.conf.logical_block_size,
+                blk_discard_granularity(s->qdev.conf.blk));
     }
 
     if (!s->version) {
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index d7246f3862..53d4a38044 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -54,7 +54,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
     DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
     DEFINE_PROP_UINT32("discard_granularity", _state,                   \
-                       _conf.discard_granularity, -1),                  \
+                       _conf.discard_granularity, -2),                  \
     DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce,           \
                             ON_OFF_AUTO_AUTO),                          \
     DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8203d7f6f9..241a759432 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -13,6 +13,7 @@
 #ifndef BLOCK_BACKEND_H
 #define BLOCK_BACKEND_H
 
+#include "qemu/units.h"
 #include "qemu/iov.h"
 #include "block/throttle-groups.h"
 
@@ -25,6 +26,10 @@
  */
 #include "block/block.h"
 
+
+#define DEFAULT_DISCARD_GRANULARITY (4 * KiB)
+
+
 /* Callbacks for block device models */
 typedef struct BlockDevOps {
     /*
@@ -246,6 +251,7 @@ int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
 int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int size);
 int blk_probe_blocksizes(BlockBackend *blk, BlockSizes *bsz);
 int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo);
+int blk_discard_granularity(BlockBackend *blk);
 BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
                                   BlockCompletionFunc *cb,
                                   void *opaque, int ret);
-- 
2.17.1


