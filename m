Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474B7C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157082173B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157082173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVBrf-0002fG-AD
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:24:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVBqp-0002Lp-J9
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hVBqo-0003uG-Op
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hVBqm-0003sO-JM; Mon, 27 May 2019 05:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91CF49F736;
	Mon, 27 May 2019 09:23:23 +0000 (UTC)
Received: from localhost (unknown [10.36.118.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D920E10027D2;
	Mon, 27 May 2019 09:23:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 27 May 2019 10:23:19 +0100
Message-Id: <20190527092319.15844-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 27 May 2019 09:23:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] block/linux-aio: explictly clear laiocb->co
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_aio_get() does not zero allocated memory.  Explicitly initialize
laiocb->co to prevent an uninitialized memory access in
qemu_laio_process_completion().

Note that this bug has never manifested itself.  I guess we're lucky!

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
I challenge you to find a place where laiocb->co is initialized and then
we can drop this patch.  I've double-checked and cannot find it...

 block/linux-aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index d4b61fb251..a097653be6 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -440,6 +440,7 @@ BlockAIOCB *laio_submit(BlockDriverState *bs, LinuxAi=
oState *s, int fd,
     int ret;
=20
     laiocb =3D qemu_aio_get(&laio_aiocb_info, bs, cb, opaque);
+    laiocb->co =3D NULL;
     laiocb->nbytes =3D nb_sectors * BDRV_SECTOR_SIZE;
     laiocb->ctx =3D s;
     laiocb->ret =3D -EINPROGRESS;
--=20
2.21.0


