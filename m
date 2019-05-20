Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF3C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DB320815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DB320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38213 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlAT-0003xg-7e
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:29:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkx8-000068-7A
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkx4-0003i6-Hu
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkwz-0003eZ-Di; Mon, 20 May 2019 12:15:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AA66309B15E;
	Mon, 20 May 2019 16:15:39 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45B27601A0;
	Mon, 20 May 2019 16:15:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:46 +0200
Message-Id: <20190520161453.30723-18-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
References: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 20 May 2019 16:15:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/24] block/file-posix: Unaligned O_DIRECT
 block-status
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

Currently, qemu crashes whenever someone queries the block status of an
unaligned image tail of an O_DIRECT image:
$ echo > foo
$ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=3Do=
n
Offset          Length          Mapped to       File
qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset'
failed.

This is because bdrv_co_block_status() checks that the result returned
by the driver's implementation is aligned to the request_alignment, but
file-posix can fail to do so, which is actually mentioned in a comment
there: "[...] possibly including a partial sector at EOF".

Fix this by rounding up those partial sectors.

There are two possible alternative fixes:
(1) We could refuse to open unaligned image files with O_DIRECT
    altogether.  That sounds reasonable until you realize that qcow2
    does necessarily not fill up its metadata clusters, and that nobody
    runs qemu-img create with O_DIRECT.  Therefore, unpreallocated qcow2
    files usually have an unaligned image tail.

(2) bdrv_co_block_status() could ignore unaligned tails.  It actually
    throws away everything past the EOF already, so that sounds
    reasonable.
    Unfortunately, the block layer knows file lengths only with a
    granularity of BDRV_SECTOR_SIZE, so bdrv_co_block_status() usually
    would have to guess whether its file length information is inexact
    or whether the driver is broken.

Fixing what raw_co_block_status() returns is the safest thing to do.

There seems to be no other block driver that sets request_alignment and
does not make sure that it always returns aligned values.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index e09e15bbf8..d018429672 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2488,6 +2488,8 @@ static int coroutine_fn raw_co_block_status(BlockDr=
iverState *bs,
     off_t data =3D 0, hole =3D 0;
     int ret;
=20
+    assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
+
     ret =3D fd_open(bs);
     if (ret < 0) {
         return ret;
@@ -2513,6 +2515,20 @@ static int coroutine_fn raw_co_block_status(BlockD=
riverState *bs,
         /* On a data extent, compute bytes to the end of the extent,
          * possibly including a partial sector at EOF. */
         *pnum =3D MIN(bytes, hole - offset);
+
+        /*
+         * We are not allowed to return partial sectors, though, so
+         * round up if necessary.
+         */
+        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
+            int64_t file_length =3D raw_getlength(bs);
+            if (file_length > 0) {
+                /* Ignore errors, this is just a safeguard */
+                assert(hole =3D=3D file_length);
+            }
+            *pnum =3D ROUND_UP(*pnum, bs->bl.request_alignment);
+        }
+
         ret =3D BDRV_BLOCK_DATA;
     } else {
         /* On a hole, compute bytes to the beginning of the next extent.=
  */
--=20
2.20.1


