Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033D7C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFFE2077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFFE2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2i2o-00008V-Py
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2huU-0006JF-Ex
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2huT-0000rn-CZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2huR-0000qO-2q; Tue, 27 Aug 2019 16:17:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DCB57BDA9;
 Tue, 27 Aug 2019 20:17:40 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74D535D9CC;
 Tue, 27 Aug 2019 20:17:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:33 +0100
Message-Id: <20190827201639.30368-7-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 27 Aug 2019 20:17:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/12] block/io: bdrv_co_do_copy_on_readv: lazy
 allocation
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Allocate bounce_buffer only if it is really needed. Also, sub-optimize
allocation size (why not?).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-7-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-7-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5817bb9405..4c7a7ac7b1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1236,7 +1236,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
      * modifying the image file.  This is critical for zero-copy guest I=
/O
      * where anything might happen inside guest memory.
      */
-    void *bounce_buffer;
+    void *bounce_buffer =3D NULL;
=20
     BlockDriver *drv =3D bs->drv;
     int64_t cluster_offset;
@@ -1271,14 +1271,6 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(B=
drvChild *child,
     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
                                    cluster_offset, cluster_bytes);
=20
-    bounce_buffer =3D qemu_try_blockalign(bs,
-                                        MIN(MIN(max_transfer, cluster_by=
tes),
-                                            MAX_BOUNCE_BUFFER));
-    if (bounce_buffer =3D=3D NULL) {
-        ret =3D -ENOMEM;
-        goto err;
-    }
-
     while (cluster_bytes) {
         int64_t pnum;
=20
@@ -1305,6 +1297,17 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(B=
drvChild *child,
=20
             /* Must copy-on-read; use the bounce buffer */
             pnum =3D MIN(pnum, MAX_BOUNCE_BUFFER);
+            if (!bounce_buffer) {
+                int64_t max_we_need =3D MAX(pnum, cluster_bytes - pnum);
+                int64_t max_allowed =3D MIN(max_transfer, MAX_BOUNCE_BUF=
FER);
+                int64_t bounce_buffer_len =3D MIN(max_we_need, max_allow=
ed);
+
+                bounce_buffer =3D qemu_try_blockalign(bs, bounce_buffer_=
len);
+                if (!bounce_buffer) {
+                    ret =3D -ENOMEM;
+                    goto err;
+                }
+            }
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
=20
             ret =3D bdrv_driver_preadv(bs, cluster_offset, pnum,
--=20
2.21.0


