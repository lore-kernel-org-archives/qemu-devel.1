Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDBC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB280214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB280214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0ib-00054o-QG
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iT0hB-0003F7-Fw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iT0h9-0002UL-Hi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:36:45 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:4899)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>)
 id 1iT0h4-0002LD-80; Fri, 08 Nov 2019 04:36:39 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65dc536d6057-8550e;
 Fri, 08 Nov 2019 17:35:18 +0800 (CST)
X-RM-TRANSID: 2ee65dc536d6057-8550e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.novalocal (unknown[112.25.65.41])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25dc536d2c26-16e3e;
 Fri, 08 Nov 2019 17:35:17 +0800 (CST)
X-RM-TRANSID: 2ee25dc536d2c26-16e3e
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To: pbonzini@redhat.com, fam@euphon.net, dillaman@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Subject: [PATCH 1/4 V2] block: add SCSI COMPARE_AND_WRITE support
Date: Fri,  8 Nov 2019 17:35:38 +0800
Message-Id: <1573205741-2094-2-git-send-email-baiyaowei@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573205741-2094-1-git-send-email-baiyaowei@cmss.chinamobile.com>
References: <1573205741-2094-1-git-send-email-baiyaowei@cmss.chinamobile.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.80
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

Some storages(i.e. librbd) already have interfaces to handle some SCSI
commands directly. This patch adds COMPARE_AND_WRITE command support
through the write path in the block io layer by introducing a new element
BDRV_REQ_COMPARE_AND_WRITE into BdrvRequestFlags which indicates a
COMPARE_AND_WRITE request. In this way we could easily extend to other
SCSI commands support like WRITE_SAME in the future.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 block/io.c                | 20 ++++++++++++++++++++
 include/block/block.h     |  5 +++--
 include/block/block_int.h |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index f75777f..3507d71 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1186,6 +1186,26 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
         goto emulate_flags;
     }
 
+    if (drv->bdrv_aio_compare_and_write &&
+                              (flags & BDRV_REQ_COMPARE_AND_WRITE)) {
+        BlockAIOCB *acb;
+        CoroutineIOCompletion co = {
+            .coroutine = qemu_coroutine_self(),
+        };
+
+        acb = drv->bdrv_aio_compare_and_write(bs, offset, bytes, qiov,
+                                    flags & bs->supported_write_flags,
+                                    bdrv_co_io_em_complete, &co);
+        flags &= ~bs->supported_write_flags;
+        if (acb == NULL) {
+            ret = -EIO;
+        } else {
+            qemu_coroutine_yield();
+            ret = co.ret;
+        }
+        goto emulate_flags;
+    }
+
     if (drv->bdrv_aio_pwritev) {
         BlockAIOCB *acb;
         CoroutineIOCompletion co = {
diff --git a/include/block/block.h b/include/block/block.h
index 1df9848..f71aa4f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -92,9 +92,10 @@ typedef enum {
      * on read request and means that caller doesn't really need data to be
      * written to qiov parameter which may be NULL.
      */
-    BDRV_REQ_PREFETCH  = 0x200,
+    BDRV_REQ_PREFETCH           = 0x200,
+    BDRV_REQ_COMPARE_AND_WRITE  = 0x400,
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3ff,
+    BDRV_REQ_MASK               = 0x7ff,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0..96096e0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -189,6 +189,9 @@ struct BlockDriver {
     BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
         int64_t offset, int bytes,
         BlockCompletionFunc *cb, void *opaque);
+    BlockAIOCB *(*bdrv_aio_compare_and_write)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
+        BlockCompletionFunc *cb, void *opaque);
 
     int coroutine_fn (*bdrv_co_readv)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
-- 
1.8.3.1




