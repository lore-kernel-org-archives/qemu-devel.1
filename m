Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D6DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD43208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD43208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXWG-0005HI-T3
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrJ-0006wX-Gd
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrI-0008Jc-9N
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrF-0008IZ-Ux; Thu, 10 Oct 2019 07:43:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 386D087638;
 Thu, 10 Oct 2019 11:43:49 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2A77600C4;
 Thu, 10 Oct 2019 11:43:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 21/36] scsi: store unmap offset and nb_sectors in request struct
Date: Thu, 10 Oct 2019 13:42:45 +0200
Message-Id: <20191010114300.7746-22-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 10 Oct 2019 11:43:49 +0000 (UTC)
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

it allows to report it in the error handler

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-id: 20190923121737.83281-6-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/scsi/scsi-disk.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 915641a0f1..b3dd21800d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1608,8 +1608,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *d=
ata, int ret)
 {
     SCSIDiskReq *r =3D data->r;
     SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    uint64_t sector_num;
-    uint32_t nb_sectors;
=20
     assert(r->req.aiocb =3D=3D NULL);
     if (scsi_disk_req_check_error(r, ret, false)) {
@@ -1617,16 +1615,18 @@ static void scsi_unmap_complete_noio(UnmapCBData =
*data, int ret)
     }
=20
     if (data->count > 0) {
-        sector_num =3D ldq_be_p(&data->inbuf[0]);
-        nb_sectors =3D ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
-        if (!check_lba_range(s, sector_num, nb_sectors)) {
+        r->sector =3D ldq_be_p(&data->inbuf[0])
+            * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+        r->sector_count =3D (ldl_be_p(&data->inbuf[8]) & 0xffffffffULL)
+            * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+        if (!check_lba_range(s, r->sector, r->sector_count)) {
             scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
             goto done;
         }
=20
         r->req.aiocb =3D blk_aio_pdiscard(s->qdev.conf.blk,
-                                        sector_num * s->qdev.blocksize,
-                                        nb_sectors * s->qdev.blocksize,
+                                        r->sector * BDRV_SECTOR_SIZE,
+                                        r->sector_count * BDRV_SECTOR_SI=
ZE,
                                         scsi_unmap_complete, data);
         data->count--;
         data->inbuf +=3D 16;
--=20
2.21.0


