Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38488C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6962070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6962070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5wUW-00062S-2Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 14:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5wOG-0006ky-F0
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5wOF-0006Nc-E4
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5wOD-0006F0-3A; Thu, 05 Sep 2019 14:21:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 648253082DDD;
 Thu,  5 Sep 2019 18:21:48 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1452F5D6A3;
 Thu,  5 Sep 2019 18:21:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 13:21:32 -0500
Message-Id: <20190905182132.3563-10-eblake@redhat.com>
In-Reply-To: <20190905182132.3563-1-eblake@redhat.com>
References: <20190905182132.3563-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 05 Sep 2019 18:21:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 9/9] nbd: Implement server use of NBD FAST_ZERO
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The server side is fairly straightforward: we can always advertise
support for detection of fast zero, and implement it by mapping the
request to the block layer BDRV_REQ_NO_FALLBACK.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190823143726.27062-5-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 4992148de1c4..28c3c8be854c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1513,7 +1513,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
             exp->nbdflags |=3D NBD_FLAG_CAN_MULTI_CONN;
         }
     } else {
-        exp->nbdflags |=3D NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZERO=
ES;
+        exp->nbdflags |=3D (NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZER=
OES |
+                          NBD_FLAG_SEND_FAST_ZERO);
     }
     assert(size <=3D INT64_MAX - dev_offset);
     exp->size =3D QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
@@ -2166,7 +2167,7 @@ static int nbd_co_receive_request(NBDRequestData *r=
eq, NBDRequest *request,
     if (request->type =3D=3D NBD_CMD_READ && client->structured_reply) {
         valid_flags |=3D NBD_CMD_FLAG_DF;
     } else if (request->type =3D=3D NBD_CMD_WRITE_ZEROES) {
-        valid_flags |=3D NBD_CMD_FLAG_NO_HOLE;
+        valid_flags |=3D NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
     } else if (request->type =3D=3D NBD_CMD_BLOCK_STATUS) {
         valid_flags |=3D NBD_CMD_FLAG_REQ_ONE;
     }
@@ -2305,6 +2306,9 @@ static coroutine_fn int nbd_handle_request(NBDClien=
t *client,
         if (!(request->flags & NBD_CMD_FLAG_NO_HOLE)) {
             flags |=3D BDRV_REQ_MAY_UNMAP;
         }
+        if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
+            flags |=3D BDRV_REQ_NO_FALLBACK;
+        }
         ret =3D blk_pwrite_zeroes(exp->blk, request->from + exp->dev_off=
set,
                                 request->len, flags);
         return nbd_send_generic_reply(client, request->handle, ret,
--=20
2.21.0


