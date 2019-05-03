Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB2C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7482075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7482075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMVyC-0002hF-44
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:03:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMVxH-0002LC-9z
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMVxG-0002hs-CK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>)
	id 1hMVxE-0002gT-7h; Fri, 03 May 2019 07:02:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94C0D3082E91;
	Fri,  3 May 2019 11:02:09 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.36.118.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B3CB45D9C4;
	Fri,  3 May 2019 11:02:07 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:02:06 +0200
Message-Id: <20190503110206.42811-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 03 May 2019 11:02:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503110206.Vm84nuD3pYMSwPjvE9uFiVoeUdpN2NUOJ4-jwRliyPg@z>

This patch allows 'qemu-img info' to show the 'disk size' for
rbd images. We use the rbd_diff_iterate2() API to calculate the
allocated size for the image.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/rbd.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..61447bc0cb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1046,6 +1046,38 @@ static int64_t qemu_rbd_getlength(BlockDriverState=
 *bs)
     return info.size;
 }
=20
+static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists=
,
+                                 void *arg)
+{
+    int64_t *alloc_size =3D (int64_t *) arg;
+
+    if (exists) {
+        (*alloc_size) +=3D len;
+    }
+
+    return 0;
+}
+
+static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
+{
+    BDRVRBDState *s =3D bs->opaque;
+    int64_t alloc_size =3D 0;
+    int r;
+
+    /*
+     * rbd_diff_iterate2(), if the source snapshot name is NULL, invokes
+     * the callback on all allocated regions of the image.
+     */
+    r =3D rbd_diff_iterate2(s->image, NULL, 0,
+                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
+                          &rbd_allocated_size_cb, &alloc_size);
+    if (r < 0) {
+        return r;
+    }
+
+    return alloc_size;
+}
+
 static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
                                              PreallocMode prealloc,
@@ -1254,6 +1286,7 @@ static BlockDriver bdrv_rbd =3D {
     .bdrv_get_info          =3D qemu_rbd_getinfo,
     .create_opts            =3D &qemu_rbd_create_opts,
     .bdrv_getlength         =3D qemu_rbd_getlength,
+    .bdrv_get_allocated_file_size =3D qemu_rbd_get_allocated_file_size,
     .bdrv_co_truncate       =3D qemu_rbd_co_truncate,
     .protocol_name          =3D "rbd",
=20
--=20
2.20.1


