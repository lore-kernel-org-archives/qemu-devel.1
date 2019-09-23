Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3924AC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D67A20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D67A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNZg-0003Xt-W4
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNIF-0006tl-UQ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNID-0001n2-9O
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:18:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:59152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iCNI7-0001i2-5y; Mon, 23 Sep 2019 08:18:07 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iCNI5-0007xx-Bm; Mon, 23 Sep 2019 15:18:05 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 7/9] scsi: account unmap operations
Date: Mon, 23 Sep 2019 15:17:35 +0300
Message-Id: <20190923121737.83281-8-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
References: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/scsi/scsi-disk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a002fdabe8..68b1675fd9 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1617,10 +1617,16 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
         r->sector_count = (ldl_be_p(&data->inbuf[8]) & 0xffffffffULL)
             * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         if (!check_lba_range(s, r->sector, r->sector_count)) {
+            block_acct_invalid(blk_get_stats(s->qdev.conf.blk),
+                               BLOCK_ACCT_UNMAP);
             scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
             goto done;
         }
 
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                         r->sector_count * BDRV_SECTOR_SIZE,
+                         BLOCK_ACCT_UNMAP);
+
         r->req.aiocb = blk_aio_pdiscard(s->qdev.conf.blk,
                                         r->sector * BDRV_SECTOR_SIZE,
                                         r->sector_count * BDRV_SECTOR_SIZE,
@@ -1647,10 +1653,11 @@ static void scsi_unmap_complete(void *opaque, int ret)
     r->req.aiocb = NULL;
 
     aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-    if (scsi_disk_req_check_error(r, ret, false)) {
+    if (scsi_disk_req_check_error(r, ret, true)) {
         scsi_req_unref(&r->req);
         g_free(data);
     } else {
+        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
         scsi_unmap_complete_noio(data, ret);
     }
     aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
@@ -1682,6 +1689,7 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
     }
 
     if (blk_is_read_only(s->qdev.conf.blk)) {
+        block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
         scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
         return;
     }
@@ -1697,10 +1705,12 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
     return;
 
 invalid_param_len:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
     scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
     return;
 
 invalid_field:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
     scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
 }
 
-- 
2.17.1


