Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D402EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55942070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55942070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5wQr-000193-IS
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 14:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5wOB-0006e0-Qg
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5wOA-0006AU-Lb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5wO8-000655-8y; Thu, 05 Sep 2019 14:21:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F1B83175293;
 Thu,  5 Sep 2019 18:21:43 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 100CB5D6A3;
 Thu,  5 Sep 2019 18:21:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 13:21:27 -0500
Message-Id: <20190905182132.3563-5-eblake@redhat.com>
In-Reply-To: <20190905182132.3563-1-eblake@redhat.com>
References: <20190905182132.3563-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 05 Sep 2019 18:21:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/9] block: workaround for unaligned byte range
 in fallocate()
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
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Revert the commit 118f99442d 'block/io.c: fix for the allocation failure'
and use better error handling for file systems that do not support
fallocate() for an unaligned byte range. Allow falling back to pwrite
in case fallocate() returns EINVAL.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Message-Id: <1566913973-15490-1-git-send-email-andrey.shinkevich@virtuozz=
o.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c         | 2 +-
 block/file-posix.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 0fa10831edb7..16a598fd0857 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1746,7 +1746,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }

-        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
+        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
             /* Fall back to bounce buffer if write zeroes is unsupported=
 */
             BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_ZERO_WRIT=
E;

diff --git a/block/file-posix.c b/block/file-posix.c
index 71f168ee2f13..87c5a4ccbdc8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1588,6 +1588,13 @@ static int handle_aiocb_write_zeroes(void *opaque)
     if (s->has_write_zeroes) {
         int ret =3D do_fallocate(s->fd, FALLOC_FL_ZERO_RANGE,
                                aiocb->aio_offset, aiocb->aio_nbytes);
+        if (ret =3D=3D -EINVAL) {
+            /*
+             * Allow falling back to pwrite for file systems that
+             * do not support fallocate() for an unaligned byte range.
+             */
+            return -ENOTSUP;
+        }
         if (ret =3D=3D 0 || ret !=3D -ENOTSUP) {
             return ret;
         }
--=20
2.21.0


