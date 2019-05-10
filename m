Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA4AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D7121479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D7121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5Cl-0005TI-KM
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:04:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5B8-0004VM-Ks
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5B7-0004V9-MU
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5B5-0004Sl-L7; Fri, 10 May 2019 09:03:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DB34300271C;
	Fri, 10 May 2019 13:03:05 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABAF16013D;
	Fri, 10 May 2019 13:03:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:40 +0100
Message-Id: <20190510130243.8887-6-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
References: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 10 May 2019 13:03:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/8] block/io.c: fix for the allocation failure
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-block@nongnu.org, "Denis V . Lunev" <den@openvz.org>,
	Max Reitz <mreitz@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

On a file system used by the customer, fallocate() returns an error
if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
fails. We can handle that case the same way as it is done for the
unsupported cases, namely, call to bdrv_driver_pwritev() that writes
zeroes to an image for the unaligned chunk of the block.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozz=
o.com
Message-Id: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuoz=
zo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index dfc153b8d8..0412a51314 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1516,7 +1516,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
=20
-        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
+        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
             /* Fall back to bounce buffer if write zeroes is unsupported=
 */
             BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_ZERO_WRIT=
E;
=20
--=20
2.21.0


