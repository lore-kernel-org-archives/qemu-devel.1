Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500FEC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19CF20896
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19CF20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8PI-00013I-VY
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:30:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8Cj-0004ZZ-Es
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8Ch-0000SN-Ha
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:17:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP8Cb-0000HH-OF; Fri, 10 May 2019 12:16:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 043003082B46;
	Fri, 10 May 2019 16:16:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F81518504;
	Fri, 10 May 2019 16:16:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 18:16:13 +0200
Message-Id: <20190510161614.23236-15-kwolf@redhat.com>
In-Reply-To: <20190510161614.23236-1-kwolf@redhat.com>
References: <20190510161614.23236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 10 May 2019 16:16:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/15] qemu-img: Use zero writes after source
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Past the end of the source backing file, we memset() buf_old to zero, so
it is clearly easy to use blk_pwrite_zeroes() instead of blk_pwrite()
then.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index cfa44b4153..28fba1e7a7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3432,6 +3432,8 @@ static int img_rebase(int argc, char **argv)
         }
=20
         for (offset =3D 0; offset < size; offset +=3D n) {
+            bool buf_old_is_zero =3D false;
+
             /* How many bytes can we handle with the next read? */
             n =3D MIN(IO_BUF_SIZE, size - offset);
=20
@@ -3452,6 +3454,7 @@ static int img_rebase(int argc, char **argv)
              */
             if (offset >=3D old_backing_size) {
                 memset(buf_old, 0, n);
+                buf_old_is_zero =3D true;
             } else {
                 if (offset + n > old_backing_size) {
                     n =3D old_backing_size - offset;
@@ -3487,8 +3490,12 @@ static int img_rebase(int argc, char **argv)
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


