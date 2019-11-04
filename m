Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1CCCA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37864222CD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqbJ9RPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37864222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYJC-0000zZ-V2
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRYHa-0007Oh-3c
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRYHX-0003Il-PK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRYHN-000326-Ko
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572858241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDK2u4eyYssTF6J7D92BnAJOpV2mcWKYyqC1Djn0bHA=;
 b=ZqbJ9RPkC9q1Stneh2KizhT1KQoovDK9AU08OiIJ2mdWQH7IBx1ZwVqEsoRVIWqPOP0IR5
 R0ZBQ/nRbSdKgWqBfexfK5QSUg7Cw1cVC1ev7iYy6iLq7xQEpleDjHxHAggoSSVKWFyov+
 rMNm4Cnq5m6WR5oMFN9ioQl29lMil6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-reAd0zRFPhyRizK0O3yarA-1; Mon, 04 Nov 2019 04:03:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63D372EDA;
 Mon,  4 Nov 2019 09:03:55 +0000 (UTC)
Received: from localhost (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 074FF5C296;
 Mon,  4 Nov 2019 09:03:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/5] block: Make wait/mark serialising requests public
Date: Mon,  4 Nov 2019 10:03:45 +0100
Message-Id: <20191104090347.27278-4-mreitz@redhat.com>
In-Reply-To: <20191104090347.27278-1-mreitz@redhat.com>
References: <20191104090347.27278-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: reAd0zRFPhyRizK0O3yarA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make both bdrv_mark_request_serialising() and
bdrv_wait_serialising_requests() public so they can be used from block
drivers.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191101152510.11719-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  3 +++
 block/io.c                | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 02dc0034a2..32fa323b63 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -999,6 +999,9 @@ extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pare=
nt);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_pa=
rent);
=20
+bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)=
;
+void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
);
+
 int get_tmp_filename(char *filename, int size);
 BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
                             const char *filename);
diff --git a/block/io.c b/block/io.c
index 02659f994d..039c0d49c9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -715,7 +715,7 @@ static void tracked_request_begin(BdrvTrackedRequest *r=
eq,
     qemu_co_mutex_unlock(&bs->reqs_lock);
 }
=20
-static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t ali=
gn)
+void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
)
 {
     int64_t overlap_offset =3D req->offset & ~(align - 1);
     uint64_t overlap_bytes =3D ROUND_UP(req->offset + req->bytes, align)
@@ -805,7 +805,7 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
=20
-static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *sel=
f)
+bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
 {
     BlockDriverState *bs =3D self->bs;
     BdrvTrackedRequest *req;
@@ -1437,14 +1437,14 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
          * with each other for the same cluster.  For example, in copy-on-=
read
          * it ensures that the CoR read and write operations are atomic an=
d
          * guest writes cannot interleave between them. */
-        mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
=20
     /* BDRV_REQ_SERIALISING is only for write operation */
     assert(!(flags & BDRV_REQ_SERIALISING));
=20
     if (!(flags & BDRV_REQ_NO_SERIALISING)) {
-        wait_serialising_requests(req);
+        bdrv_wait_serialising_requests(req);
     }
=20
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -1841,10 +1841,10 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t=
 offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
=20
     if (flags & BDRV_REQ_SERIALISING) {
-        mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
=20
-    waited =3D wait_serialising_requests(req);
+    waited =3D bdrv_wait_serialising_requests(req);
=20
     assert(!waited || !req->serialising ||
            is_request_serialising_and_aligned(req));
@@ -2008,8 +2008,8 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvC=
hild *child,
=20
     padding =3D bdrv_init_padding(bs, offset, bytes, &pad);
     if (padding) {
-        mark_request_serialising(req, align);
-        wait_serialising_requests(req);
+        bdrv_mark_request_serialising(req, align);
+        bdrv_wait_serialising_requests(req);
=20
         bdrv_padding_rmw_read(child, req, &pad, true);
=20
@@ -2111,8 +2111,8 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *chil=
d,
     }
=20
     if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) =
{
-        mark_request_serialising(&req, align);
-        wait_serialising_requests(&req);
+        bdrv_mark_request_serialising(&req, align);
+        bdrv_wait_serialising_requests(&req);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
=20
@@ -3205,7 +3205,7 @@ static int coroutine_fn bdrv_co_copy_range_internal(
         /* BDRV_REQ_SERIALISING is only for write operation */
         assert(!(read_flags & BDRV_REQ_SERIALISING));
         if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
-            wait_serialising_requests(&req);
+            bdrv_wait_serialising_requests(&req);
         }
=20
         ret =3D src->bs->drv->bdrv_co_copy_range_from(src->bs,
@@ -3336,7 +3336,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, i=
nt64_t offset, bool exact,
      * new area, we need to make sure that no write requests are made to i=
t
      * concurrently or they might be overwritten by preallocation. */
     if (new_bytes) {
-        mark_request_serialising(&req, 1);
+        bdrv_mark_request_serialising(&req, 1);
     }
     if (bs->read_only) {
         error_setg(errp, "Image is read-only");
--=20
2.21.0


