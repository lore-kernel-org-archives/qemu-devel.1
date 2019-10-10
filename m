Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1BAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927C0208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927C0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXZ6-0000dj-CN
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrN-00073n-OA
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrM-0008Kw-K2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrK-0008K2-76; Thu, 10 Oct 2019 07:43:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 724171017C03;
 Thu, 10 Oct 2019 11:43:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16B7A5C231;
 Thu, 10 Oct 2019 11:43:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/36] scsi: account unmap operations
Date: Thu, 10 Oct 2019 13:42:47 +0200
Message-Id: <20191010114300.7746-24-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 10 Oct 2019 11:43:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190923121737.83281-8-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/scsi/scsi-disk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a002fdabe8..68b1675fd9 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1617,10 +1617,16 @@ static void scsi_unmap_complete_noio(UnmapCBData =
*data, int ret)
         r->sector_count =3D (ldl_be_p(&data->inbuf[8]) & 0xffffffffULL)
             * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         if (!check_lba_range(s, r->sector, r->sector_count)) {
+            block_acct_invalid(blk_get_stats(s->qdev.conf.blk),
+                               BLOCK_ACCT_UNMAP);
             scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
             goto done;
         }
=20
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                         r->sector_count * BDRV_SECTOR_SIZE,
+                         BLOCK_ACCT_UNMAP);
+
         r->req.aiocb =3D blk_aio_pdiscard(s->qdev.conf.blk,
                                         r->sector * BDRV_SECTOR_SIZE,
                                         r->sector_count * BDRV_SECTOR_SI=
ZE,
@@ -1647,10 +1653,11 @@ static void scsi_unmap_complete(void *opaque, int=
 ret)
     r->req.aiocb =3D NULL;
=20
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
@@ -1682,6 +1689,7 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r,=
 uint8_t *inbuf)
     }
=20
     if (blk_is_read_only(s->qdev.conf.blk)) {
+        block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_U=
NMAP);
         scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
         return;
     }
@@ -1697,10 +1705,12 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *=
r, uint8_t *inbuf)
     return;
=20
 invalid_param_len:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP=
);
     scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
     return;
=20
 invalid_field:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP=
);
     scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
 }
=20
--=20
2.21.0


