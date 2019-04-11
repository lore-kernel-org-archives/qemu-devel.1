Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8D8C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D562184B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D562184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXSm-0002c6-3N
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:01:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHv-0001ma-2Y
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHt-0006fX-W5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>)
	id 1hEXHr-0006dB-Bo; Thu, 11 Apr 2019 06:50:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2FCD88AC8;
	Thu, 11 Apr 2019 10:50:30 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-245.ams2.redhat.com
	[10.36.116.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF461001E67;
	Thu, 11 Apr 2019 10:50:28 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:50:25 +0200
Message-Id: <20190411105025.97397-2-sgarzare@redhat.com>
In-Reply-To: <20190411105025.97397-1-sgarzare@redhat.com>
References: <20190411105025.97397-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 11 Apr 2019 10:50:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically the
 image size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411105025.FuZ5Qm8bd8QIdDQ1QcdXNRKBy3DM8Ud2pGg5BOXBqH0@z>

RBD APIs don't allow us to write more than the size set with rbd_create()
or rbd_resize().
In order to support growing images (eg. qcow2), we resize the image
before RW operations that exceed the current size.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1171007
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/rbd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..228658e20a 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
     rbd_image_t image;
     char *image_name;
     char *snap;
+    uint64_t image_size;
 } BDRVRBDState;
=20
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
@@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict=
 *options, int flags,
         goto failed_open;
     }
=20
+    r =3D rbd_get_size(s->image, &s->image_size);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "error reading image size from %s",
+                         s->image_name);
+        rbd_close(s->image);
+        goto failed_open;
+    }
+
     /* If we are using an rbd snapshot, we must be r/o, otherwise
      * leave as-is */
     if (s->snap !=3D NULL) {
@@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *b=
s,
         rcb->buf =3D acb->bounce;
     }
=20
+    /*
+     * RBD APIs don't allow us to write more than actual size, so in ord=
er
+     * to support growing images, we resize the image before RW operatio=
ns
+     * that exceed the current size.
+     */
+    if (s->image_size < off + size) {
+        r =3D rbd_resize(s->image, off + size);
+        if (r < 0) {
+            goto failed;
+        }
+
+        s->image_size =3D off + size;
+    }
+
     acb->ret =3D 0;
     acb->error =3D 0;
     acb->s =3D s;
@@ -1066,6 +1089,8 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockD=
riverState *bs,
         return r;
     }
=20
+    s->image_size =3D offset;
+
     return 0;
 }
=20
--=20
2.20.1


