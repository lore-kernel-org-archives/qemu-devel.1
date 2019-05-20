Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D92C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A44214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A44214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSkz4-0001dF-5O
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:17:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwq-0008EL-NM
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwp-0003XZ-4b
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkwm-0003Jo-9y; Mon, 20 May 2019 12:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B2358763B;
	Mon, 20 May 2019 16:15:05 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C15887838C;
	Mon, 20 May 2019 16:15:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:32 +0200
Message-Id: <20190520161453.30723-4-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
References: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 20 May 2019 16:15:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/24] block: Use BDRV_REQUEST_MAX_BYTES instead
 of BDRV_REQUEST_MAX_SECTORS
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

From: Alberto Garcia <berto@igalia.com>

There are a few places in which we turn a number of bytes into sectors
in order to compare the result against BDRV_REQUEST_MAX_SECTORS
instead of using BDRV_REQUEST_MAX_BYTES directly.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c     | 6 +++---
 qemu-io-cmds.c | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index aeebc9c23c..3134a60a48 100644
--- a/block/io.c
+++ b/block/io.c
@@ -769,7 +769,7 @@ static bool coroutine_fn wait_serialising_requests(Bd=
rvTrackedRequest *self)
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
                                    size_t size)
 {
-    if (size > BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS) {
+    if (size > BDRV_REQUEST_MAX_BYTES) {
         return -EIO;
     }
=20
@@ -1017,7 +1017,7 @@ static int coroutine_fn bdrv_driver_preadv(BlockDri=
verState *bs,
=20
     assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
     assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS);
+    assert(bytes <=3D BDRV_REQUEST_MAX_BYTES);
     assert(drv->bdrv_co_readv);
=20
     return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
@@ -1070,7 +1070,7 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDr=
iverState *bs,
=20
     assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
     assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-    assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS);
+    assert(bytes <=3D BDRV_REQUEST_MAX_BYTES);
=20
     assert(drv->bdrv_co_writev);
     ret =3D drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov,
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 8826bebaf6..30a7d9a13b 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -538,7 +538,7 @@ static int do_write_compressed(BlockBackend *blk, cha=
r *buf, int64_t offset,
 {
     int ret;
=20
-    if (bytes >> 9 > BDRV_REQUEST_MAX_SECTORS) {
+    if (bytes > BDRV_REQUEST_MAX_BYTES) {
         return -ERANGE;
     }
=20
@@ -1781,10 +1781,9 @@ static int discard_f(BlockBackend *blk, int argc, =
char **argv)
     if (bytes < 0) {
         print_cvtnum_err(bytes, argv[optind]);
         return bytes;
-    } else if (bytes >> BDRV_SECTOR_BITS > BDRV_REQUEST_MAX_SECTORS) {
+    } else if (bytes > BDRV_REQUEST_MAX_BYTES) {
         printf("length cannot exceed %"PRIu64", given %s\n",
-               (uint64_t)BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS,
-               argv[optind]);
+               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
         return -EINVAL;
     }
=20
--=20
2.20.1


