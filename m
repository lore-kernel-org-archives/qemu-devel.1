Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66125CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB9921D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB9921D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwKA-00019V-Cj
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 05:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iNw10-0004WN-1p
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iNw0y-0006kZ-OO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:36:13 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3483)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>)
 id 1iNw0v-0006h7-Ke; Fri, 25 Oct 2019 05:36:10 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by
 rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15db2c1eccd8-5fe29;
 Fri, 25 Oct 2019 17:35:41 +0800 (CST)
X-RM-TRANSID: 2ee15db2c1eccd8-5fe29
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.novalocal (unknown[112.25.65.41])
 by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65db2c1ea9b0-be8c8;
 Fri, 25 Oct 2019 17:35:40 +0800 (CST)
X-RM-TRANSID: 2ee65db2c1ea9b0-be8c8
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To: pbonzini@redhat.com, fam@euphon.net, dillaman@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Subject: [PATCH 2/4] block/rbd: implement bdrv_aio_compare_and_write interface
Date: Fri, 25 Oct 2019 17:36:00 +0800
Message-Id: <1571996163-27688-3-git-send-email-baiyaowei@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571996163-27688-1-git-send-email-baiyaowei@cmss.chinamobile.com>
References: <1571996163-27688-1-git-send-email-baiyaowei@cmss.chinamobile.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
Cc: baiyaowei@cmss.chinamobile.com, yangjun@cmss.chinamobile.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds librbd's SCSI COMPARE_AND_WRITE command interface
support with bdrv_aio_compare_and_write function pointer. Note
currently when a miscompare happens a mismatch offset of 0 is
always reported rather than the actual mismatch offset. This
should not be a big issue contemporarily and will be fixed
accordingly in the future.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 block/raw-format.c |  3 ++-
 block/rbd.c        | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 42c28cc..3d8f201 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -438,7 +438,8 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
 
     bs->sg = bs->file->bs->sg;
     bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
-        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
+        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags) |
+        (BDRV_REQ_COMPARE_AND_WRITE & bs->file->bs->supported_write_flags);
     bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);
diff --git a/block/rbd.c b/block/rbd.c
index c71e45d..7065343 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -73,11 +73,18 @@
 #define LIBRBD_USE_IOVEC 0
 #endif
 
+#ifdef LIBRBD_SUPPORTS_COMPARE_AND_WRITE
+#define LIBRBD_HAVE_COMPARE_AND_WRITE 1
+#else
+#define LIBRBD_HAVE_COMPARE_AND_WRITE 0
+#endif
+
 typedef enum {
     RBD_AIO_READ,
     RBD_AIO_WRITE,
     RBD_AIO_DISCARD,
-    RBD_AIO_FLUSH
+    RBD_AIO_FLUSH,
+    RBD_AIO_COMPARE_AND_WRITE
 } RBDAIOCmd;
 
 typedef struct RBDAIOCB {
@@ -798,6 +805,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    if (LIBRBD_HAVE_COMPARE_AND_WRITE)
+        bs->supported_write_flags = BDRV_REQ_COMPARE_AND_WRITE;
+
     r = 0;
     goto out;
 
@@ -933,7 +943,15 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
 
     rcb = g_new(RADOSCB, 1);
 
-    if (!LIBRBD_USE_IOVEC) {
+    if (cmd == RBD_AIO_COMPARE_AND_WRITE) {
+        acb->bounce = qemu_try_blockalign(bs, qiov->size);
+        if (acb->bounce == NULL) {
+            goto failed;
+        }
+
+        qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
+        rcb->buf = acb->bounce;
+    } else if (!LIBRBD_USE_IOVEC) {
         if (cmd == RBD_AIO_DISCARD || cmd == RBD_AIO_FLUSH) {
             acb->bounce = NULL;
         } else {
@@ -993,6 +1011,9 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     case RBD_AIO_FLUSH:
         r = rbd_aio_flush_wrapper(s->image, c);
         break;
+    case RBD_AIO_COMPARE_AND_WRITE:
+        r = rbd_aio_compare_and_write(s->image, off, size/2, rcb->buf, (rcb->buf + size/2), c, 0, 0);
+        break;
     default:
         r = -EINVAL;
     }
@@ -1056,6 +1077,18 @@ static int qemu_rbd_co_flush(BlockDriverState *bs)
 }
 #endif
 
+#ifdef LIBRBD_SUPPORTS_COMPARE_AND_WRITE
+static BlockAIOCB *qemu_rbd_aio_compare_and_write(BlockDriverState *bs,
+                                                  uint64_t offset, uint64_t bytes,
+                                                  QEMUIOVector *qiov, int flags,
+                                                  BlockCompletionFunc *cb,
+                                                  void *opaque)
+{
+    return rbd_start_aio(bs, offset, qiov, bytes, cb, opaque,
+                         RBD_AIO_COMPARE_AND_WRITE);
+}
+#endif
+
 static int qemu_rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVRBDState *s = bs->opaque;
@@ -1309,6 +1342,10 @@ static BlockDriver bdrv_rbd = {
     .bdrv_aio_pdiscard      = qemu_rbd_aio_pdiscard,
 #endif
 
+#ifdef LIBRBD_SUPPORTS_COMPARE_AND_WRITE
+    .bdrv_aio_compare_and_write = qemu_rbd_aio_compare_and_write,
+#endif
+
     .bdrv_snapshot_create   = qemu_rbd_snap_create,
     .bdrv_snapshot_delete   = qemu_rbd_snap_remove,
     .bdrv_snapshot_list     = qemu_rbd_snap_list,
-- 
1.8.3.1




