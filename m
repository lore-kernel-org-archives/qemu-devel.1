Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA745CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EBC20663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMgX7+NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EBC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwjp-0001K0-Da
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNwNF-0006Xh-Cc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNwNC-0004hW-Vn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNwNB-0004ef-RM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQ2J0lOK6C/VkGuvG9H0ogetwI5GrWwsL4uotJB2Qnk=;
 b=DMgX7+NNitDHMxl3Siq7ZFcyFGlzQeU3bt5yZOH4xpRiq/XlU5fGAf6em0pD+z94UU56G0
 PcDXvwCxIJFoD0S4koE16EWUbCUazghurGUVkcG0A+3Aed71dFGKaBJd4wzYaUGuBXzDs1
 wWLzgGMIBu8sAAufzhMVW2xBiIUN5IQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-md9qFZ0MPp-s7G59vGboqg-1; Fri, 25 Oct 2019 05:59:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4247A1005500;
 Fri, 25 Oct 2019 09:59:03 +0000 (UTC)
Received: from localhost (ovpn-117-205.ams2.redhat.com [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E07D410013A1;
 Fri, 25 Oct 2019 09:58:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC 1/3] block: Make wait/mark serialising requests public
Date: Fri, 25 Oct 2019 11:58:47 +0200
Message-Id: <20191025095849.25283-2-mreitz@redhat.com>
In-Reply-To: <20191025095849.25283-1-mreitz@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: md9qFZ0MPp-s7G59vGboqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make both bdrv_mark_request_serialising() and
bdrv_wait_serialising_requests() public so they can be used from block
drivers.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  3 +++
 block/io.c                | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ca4ccac4c1..c85733293d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -984,6 +984,9 @@ extern unsigned int bdrv_drain_all_count;
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
index f0b86c1d19..a65cc7fb61 100644
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
@@ -3332,7 +3332,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, i=
nt64_t offset,
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


