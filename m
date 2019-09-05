Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7946C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A960E2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A960E2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5wT3-0003wS-ED
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 14:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5wOG-0006kN-4e
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5wOF-0006M6-3h
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5wOC-0006EK-MF; Thu, 05 Sep 2019 14:21:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E843B3DE0B;
 Thu,  5 Sep 2019 18:21:47 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 789EE5D6A3;
 Thu,  5 Sep 2019 18:21:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 13:21:31 -0500
Message-Id: <20190905182132.3563-9-eblake@redhat.com>
In-Reply-To: <20190905182132.3563-1-eblake@redhat.com>
References: <20190905182132.3563-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 05 Sep 2019 18:21:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 8/9] nbd: Implement client use of NBD FAST_ZERO
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

The client side is fairly straightforward: if the server advertised
fast zero support, then we can map that to BDRV_REQ_NO_FALLBACK
support.  A server that advertises FAST_ZERO but not WRITE_ZEROES
is technically broken, but we can ignore that situation as it does
not change our behavior.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190823143726.27062-4-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index c4c91a158602..813c40d8f067 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1044,6 +1044,10 @@ static int nbd_client_co_pwrite_zeroes(BlockDriver=
State *bs, int64_t offset,
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
         request.flags |=3D NBD_CMD_FLAG_NO_HOLE;
     }
+    if (flags & BDRV_REQ_NO_FALLBACK) {
+        assert(s->info.flags & NBD_FLAG_SEND_FAST_ZERO);
+        request.flags |=3D NBD_CMD_FLAG_FAST_ZERO;
+    }

     if (!bytes) {
         return 0;
@@ -1239,6 +1243,9 @@ static int nbd_client_connect(BlockDriverState *bs,=
 Error **errp)
     }
     if (s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |=3D BDRV_REQ_MAY_UNMAP;
+        if (s->info.flags & NBD_FLAG_SEND_FAST_ZERO) {
+            bs->supported_zero_flags |=3D BDRV_REQ_NO_FALLBACK;
+        }
     }

     s->sioc =3D sioc;
--=20
2.21.0


