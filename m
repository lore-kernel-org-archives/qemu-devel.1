Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E886AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD4F2054F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD4F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkXE-00054b-1O
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:00:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOkWL-0004gw-FO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOkWH-0002Vn-MZ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>)
	id 1hOkWD-0002UL-SM; Thu, 09 May 2019 10:59:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55631307E05F;
	Thu,  9 May 2019 14:59:30 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-227.ams2.redhat.com
	[10.36.116.227])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4CAD600C7;
	Thu,  9 May 2019 14:59:28 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 16:59:27 +0200
Message-Id: <20190509145927.293369-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 09 May 2019 14:59:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3] block/rbd: increase dynamically the image
 size
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
	Jason Dillaman <jdillama@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RBD APIs don't allow us to write more than the size set with
rbd_create() or rbd_resize().
In order to support growing images (eg. qcow2), we resize the
image before write operations that exceed the current size.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
  - add 'image_size' field in the BDRVRBDState to keep track of the
    current size of the RBD image [Jason, Kevin]
---
 block/rbd.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..b0355a2ce0 100644
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
+        error_setg_errno(errp, -r, "error getting image size from %s",
+                         s->image_name);
+        rbd_close(s->image);
+        goto failed_open;
+    }
+
     /* If we are using an rbd snapshot, we must be r/o, otherwise
      * leave as-is */
     if (s->snap !=3D NULL) {
@@ -833,6 +842,22 @@ static void qemu_rbd_close(BlockDriverState *bs)
     rados_shutdown(s->cluster);
 }
=20
+/* Resize the RBD image and update the 'image_size' with the current siz=
e */
+static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
+{
+    BDRVRBDState *s =3D bs->opaque;
+    int r;
+
+    r =3D rbd_resize(s->image, size);
+    if (r < 0) {
+        return r;
+    }
+
+    s->image_size =3D size;
+
+    return 0;
+}
+
 static const AIOCBInfo rbd_aiocb_info =3D {
     .aiocb_size =3D sizeof(RBDAIOCB),
 };
@@ -934,13 +959,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *=
bs,
     }
=20
     switch (cmd) {
-    case RBD_AIO_WRITE:
+    case RBD_AIO_WRITE: {
+        /*
+         * RBD APIs don't allow us to write more than actual size, so in=
 order
+         * to support growing images, we resize the image before write
+         * operations that exceed the current size.
+         */
+        if (off + size > s->image_size) {
+            r =3D qemu_rbd_resize(bs, off + size);
+            if (r < 0) {
+                goto failed_completion;
+            }
+        }
 #ifdef LIBRBD_SUPPORTS_IOVEC
             r =3D rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c=
);
 #else
             r =3D rbd_aio_write(s->image, off, size, rcb->buf, c);
 #endif
         break;
+    }
     case RBD_AIO_READ:
 #ifdef LIBRBD_SUPPORTS_IOVEC
             r =3D rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c)=
;
@@ -1051,7 +1088,6 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockD=
riverState *bs,
                                              PreallocMode prealloc,
                                              Error **errp)
 {
-    BDRVRBDState *s =3D bs->opaque;
     int r;
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
@@ -1060,7 +1096,7 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockD=
riverState *bs,
         return -ENOTSUP;
     }
=20
-    r =3D rbd_resize(s->image, offset);
+    r =3D qemu_rbd_resize(bs, offset);
     if (r < 0) {
         error_setg_errno(errp, -r, "Failed to resize file");
         return r;
--=20
2.20.1


