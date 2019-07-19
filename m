Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2306FC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F161421872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F161421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoWYX-0001iy-53
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 13:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hoWYN-0001BA-OO
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hoWYM-0003w5-Lc
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hoWYJ-0003th-Ry; Fri, 19 Jul 2019 13:20:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7322081111;
 Fri, 19 Jul 2019 17:20:14 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A1F52B1D8;
 Fri, 19 Jul 2019 17:20:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 12:20:01 -0500
Message-Id: <20190719172001.19770-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 19 Jul 2019 17:20:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v2] nbd: Initialize reply on failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've had two separate reports of different callers running into use
of uninitialized data if s->quit is set (one detected by gcc -O3,
another by valgrind), due to checking 'nbd_reply_is_simple(reply) ||
s->quit' in the wrong order. Rather than chasing down which callers
need to pre-initialize reply, and whether there are any other
uninitialized uses, it's easier to guarantee that reply will always be
set by nbd_co_receive_one_chunk() even on failure.

The uninitialized use happens to be harmless (the only time the
variable is uninitialized is if s->quit is set, so the conditional
results in the same action regardless of what was read from reply),
and was introduced in commit 65e01d47.

In fixing the problem, it can also be seen that all (one) callers pass
in a non-NULL reply, so there is a dead condtional to also be cleaned
up.

Reported-by: Thomas Huth <thuth@redhat.com>
Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 81edabbf35ed..57c1a205811a 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -640,12 +640,11 @@ static coroutine_fn int nbd_co_receive_one_chunk(
                                           request_ret, qiov, payload, er=
rp);

     if (ret < 0) {
+        memset(reply, 0, sizeof(*reply));
         s->quit =3D true;
     } else {
         /* For assert at loop start in nbd_connection_entry */
-        if (reply) {
-            *reply =3D s->reply;
-        }
+        *reply =3D s->reply;
         s->reply.handle =3D 0;
     }

--=20
2.20.1


