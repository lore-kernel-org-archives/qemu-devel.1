Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE8C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E5020675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E5020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONAk-0007wY-Pt
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:03:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hON8w-0006Yt-4t
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hON8v-00021m-6d
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hON8s-0001uo-NG; Wed, 08 May 2019 10:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 529ECC067C19;
	Wed,  8 May 2019 14:01:46 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E024E60C74;
	Wed,  8 May 2019 14:01:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 16:01:38 +0200
Message-Id: <20190508140139.32722-3-mreitz@redhat.com>
In-Reply-To: <20190508140139.32722-1-mreitz@redhat.com>
References: <20190508140139.32722-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 08 May 2019 14:01:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-img: Use zero writes after source
 backing EOF
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Past the end of the source backing file, we memset() buf_old to zero, so
it is clearly easy to use blk_pwrite_zeroes() instead of blk_pwrite()
then.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e22a4fda17..cfad922816 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3431,6 +3431,8 @@ static int img_rebase(int argc, char **argv)
         }
=20
         for (offset =3D 0; offset < size; offset +=3D n) {
+            bool buf_old_is_zero =3D false;
+
             /* How many bytes can we handle with the next read? */
             n =3D MIN(IO_BUF_SIZE, size - offset);
=20
@@ -3451,6 +3453,7 @@ static int img_rebase(int argc, char **argv)
              */
             if (offset >=3D old_backing_size) {
                 memset(buf_old, 0, n);
+                buf_old_is_zero =3D true;
             } else {
                 if (offset + n > old_backing_size) {
                     n =3D old_backing_size - offset;
@@ -3486,8 +3489,12 @@ static int img_rebase(int argc, char **argv)
                 if (compare_buffers(buf_old + written, buf_new + written=
,
                                     n - written, &pnum))
                 {
-                    ret =3D blk_pwrite(blk, offset + written,
-                                     buf_old + written, pnum, 0);
+                    if (buf_old_is_zero) {
+                        ret =3D blk_pwrite_zeroes(blk, offset + written,=
 pnum, 0);
+                    } else {
+                        ret =3D blk_pwrite(blk, offset + written,
+                                         buf_old + written, pnum, 0);
+                    }
                     if (ret < 0) {
                         error_report("Error while writing to COW image: =
%s",
                             strerror(-ret));
--=20
2.20.1


