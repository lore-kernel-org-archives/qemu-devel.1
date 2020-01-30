Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034AEC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C470E20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jmiftbca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C470E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHTE-0003sO-SS
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHPV-0006lE-W4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHPU-0004pz-Jw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38449
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHPU-0004mR-G0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCXifKAz8zdxy0qXQ36bHA8fkm12N4h0f95Q6RTvdGc=;
 b=JmiftbcaTWO+bqn1t+yiUMOCuTj+0ByRsvQLoBHpH67R5kQSTtsgb5GxisG1UIXjge6noA
 qCP8hsR5HimqJSWVexZ6Uohh+wzB67/ONWg8nphFxMWFrce8ObPGv/Cd/V9SpFF4/0YDzx
 UQcCRWnZTmB0KHaamAgSLt55M6Ow6lA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Gh2ATA1DMfCbOoPsok2cJA-1; Thu, 30 Jan 2020 16:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B425610054E3;
 Thu, 30 Jan 2020 21:31:29 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 498CC84BCE;
 Thu, 30 Jan 2020 21:31:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] block/io: wait for serialising requests when a request
 becomes serialising
Date: Thu, 30 Jan 2020 21:30:58 +0000
Message-Id: <20200130213114.325157-3-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
References: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Gh2ATA1DMfCbOoPsok2cJA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Marking without waiting would not result in actual serialising behavior.
Thus, make a call bdrv_mark_request_serialising sufficient for
serialisation to happen.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 1578495356-46219-3-git-send-email-pbonzini@redhat.com
Message-Id: <1578495356-46219-3-git-send-email-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c        |  1 -
 block/io.c                | 40 +++++++++++++++++----------------------
 include/block/block_int.h |  3 +--
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1b805bd938..2b08b02d27 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2753,7 +2753,6 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t of=
fset, int bytes,
         req->overlap_bytes =3D req->bytes;
=20
         bdrv_mark_request_serialising(req, bs->bl.request_alignment);
-        bdrv_wait_serialising_requests(req);
     }
 #endif
=20
diff --git a/block/io.c b/block/io.c
index b3a67fe1db..c466df8ed5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -41,6 +41,7 @@
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
=20
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
+static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest=
 *self);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
=20
@@ -715,7 +716,7 @@ static void tracked_request_begin(BdrvTrackedRequest *r=
eq,
     qemu_co_mutex_unlock(&bs->reqs_lock);
 }
=20
-void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
)
+bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
)
 {
     int64_t overlap_offset =3D req->offset & ~(align - 1);
     uint64_t overlap_bytes =3D ROUND_UP(req->offset + req->bytes, align)
@@ -728,18 +729,7 @@ void bdrv_mark_request_serialising(BdrvTrackedRequest =
*req, uint64_t align)
=20
     req->overlap_offset =3D MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes =3D MAX(req->overlap_bytes, overlap_bytes);
-}
-
-static bool is_request_serialising_and_aligned(BdrvTrackedRequest *req)
-{
-    /*
-     * If the request is serialising, overlap_offset and overlap_bytes are=
 set,
-     * so we can check if the request is aligned. Otherwise, don't care an=
d
-     * return false.
-     */
-
-    return req->serialising && (req->offset =3D=3D req->overlap_offset) &&
-           (req->bytes =3D=3D req->overlap_bytes);
+    return bdrv_wait_serialising_requests(req);
 }
=20
 /**
@@ -823,7 +813,7 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
=20
-bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
+static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest=
 *self)
 {
     BlockDriverState *bs =3D self->bs;
     BdrvTrackedRequest *req;
@@ -1455,10 +1445,10 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
          * it ensures that the CoR read and write operations are atomic an=
d
          * guest writes cannot interleave between them. */
         bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+    } else {
+        bdrv_wait_serialising_requests(req);
     }
=20
-    bdrv_wait_serialising_requests(req);
-
     if (flags & BDRV_REQ_COPY_ON_READ) {
         int64_t pnum;
=20
@@ -1851,13 +1841,19 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t=
 offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
=20
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        waited =3D bdrv_mark_request_serialising(req, bdrv_get_cluster_siz=
e(bs));
+        /*
+         * For a misaligned request we should have already waited earlier,
+         * because we come after bdrv_padding_rmw_read which must be calle=
d
+         * with the request already marked as serialising.
+         */
+        assert(!waited ||
+               (req->offset =3D=3D req->overlap_offset &&
+                req->bytes =3D=3D req->overlap_bytes));
+    } else {
+        bdrv_wait_serialising_requests(req);
     }
=20
-    waited =3D bdrv_wait_serialising_requests(req);
-
-    assert(!waited || !req->serialising ||
-           is_request_serialising_and_aligned(req));
     assert(req->overlap_offset <=3D offset);
     assert(offset + bytes <=3D req->overlap_offset + req->overlap_bytes);
     assert(end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RES=
IZE);
@@ -2019,7 +2015,6 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvC=
hild *child,
     padding =3D bdrv_init_padding(bs, offset, bytes, &pad);
     if (padding) {
         bdrv_mark_request_serialising(req, align);
-        bdrv_wait_serialising_requests(req);
=20
         bdrv_padding_rmw_read(child, req, &pad, true);
=20
@@ -2122,7 +2117,6 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *chil=
d,
=20
     if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) =
{
         bdrv_mark_request_serialising(&req, align);
-        bdrv_wait_serialising_requests(&req);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
=20
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0b37..640fb82c78 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -999,8 +999,7 @@ extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pare=
nt);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_pa=
rent);
=20
-bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)=
;
-void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
);
+bool coroutine_fn bdrv_mark_request_serialising(BdrvTrackedRequest *req, u=
int64_t align);
 BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState=
 *bs);
=20
 int get_tmp_filename(char *filename, int size);
--=20
2.24.1


