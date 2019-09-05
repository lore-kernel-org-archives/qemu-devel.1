Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906BBC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 21:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E48206CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 21:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E48206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5zBe-0006ds-Ko
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 17:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5z6q-00027Q-SA
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 17:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5z6p-0002RN-P7
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 17:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5z6m-0002PC-PS; Thu, 05 Sep 2019 17:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DB91883820;
 Thu,  5 Sep 2019 21:16:00 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AAC46061E;
 Thu,  5 Sep 2019 21:15:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 16:15:22 -0500
Message-Id: <20190905211522.2824-10-eblake@redhat.com>
In-Reply-To: <20190905211522.2824-1-eblake@redhat.com>
References: <20190905211522.2824-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 05 Sep 2019 21:16:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 9/9] nbd: Implement server use of NBD
 FAST_ZERO
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The server side is fairly straightforward: we can always advertise
support for detection of fast zero, and implement it by mapping the
request to the block layer BDRV_REQ_NO_FALLBACK.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190823143726.27062-5-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: update iotests 223, 233]
---
 nbd/server.c               | 8 ++++++--
 tests/qemu-iotests/223.out | 2 +-
 tests/qemu-iotests/233.out | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

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
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 2db0dc991a27..5d00398c11cb 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -49,7 +49,7 @@ exports available: 2
    qemu:dirty-bitmap:b
  export: 'n2'
   size:  4194304
-  flags: 0x4ed ( flush fua trim zeroes df cache )
+  flags: 0xced ( flush fua trim zeroes df cache fast-zero )
   min block: 1
   opt block: 4096
   max block: 33554432
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index a3ecc4eb5ccf..24321efa113b 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -37,7 +37,7 @@ disk size: unavailable
 exports available: 1
  export: ''
   size:  67108864
-  flags: 0x4ed ( flush fua trim zeroes df cache )
+  flags: 0xced ( flush fua trim zeroes df cache fast-zero )
   min block: 1
   opt block: 4096
   max block: 33554432
--=20
2.21.0


