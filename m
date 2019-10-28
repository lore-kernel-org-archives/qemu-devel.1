Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA6CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B113F20717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDzRW9K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B113F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4dW-0005rK-Fg
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wo-0002iM-Jc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wn-0001uW-4A
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wm-0001uG-U6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6OTm5ZJcB6kowqx+WMPInET1NNXiqV4DJc8qPb1V0s=;
 b=TDzRW9K6a7KV62vyR3tUTlktlsL1o9MTGxR7MkNI0YnKODH9mQDZePvMZx6cUc57M/mn/3
 y8cFtDyTa5nNcIAZSQocbD1emIPM6sAPiDi7FvxhYrYiUf5M6vddc7/MzhqtmYWNvhGbhW
 5e5ds3w3vzy7tg5k6COXimIXoTqR8tM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-V5pyRu0cP1mBu2iZCSaz9A-1; Mon, 28 Oct 2019 08:16:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 332C380183E;
 Mon, 28 Oct 2019 12:16:28 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEAB726199;
 Mon, 28 Oct 2019 12:16:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 41/69] block/block-copy: increase buffered copy request
Date: Mon, 28 Oct 2019 13:14:33 +0100
Message-Id: <20191028121501.15279-42-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: V5pyRu0cP1mBu2iZCSaz9A-1
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

No reason to limit buffered copy to one cluster. Let's allow up to 1
MiB.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191022111805.3432-7-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block-copy.h |  2 +-
 block/block-copy.c         | 48 +++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index edcdf0072d..0a161724d7 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -38,7 +38,7 @@ typedef struct BlockCopyState {
     BdrvDirtyBitmap *copy_bitmap;
     int64_t cluster_size;
     bool use_copy_range;
-    int64_t copy_range_size;
+    int64_t copy_size;
     uint64_t len;
     QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
=20
diff --git a/block/block-copy.c b/block/block-copy.c
index 7f0ebb58f8..c39cc9cffe 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
=20
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
+#define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
@@ -75,10 +76,8 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, =
BdrvChild *target,
 {
     BlockCopyState *s;
     BdrvDirtyBitmap *copy_bitmap;
-
-    /* Ignore BLOCK_COPY_MAX_COPY_RANGE if requested cluster_size is large=
r */
     uint32_t max_transfer =3D
-            MIN_NON_ZERO(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
+            MIN_NON_ZERO(INT_MAX,
                          MIN_NON_ZERO(source->bs->bl.max_transfer,
                                       target->bs->bl.max_transfer));
=20
@@ -100,17 +99,28 @@ BlockCopyState *block_copy_state_new(BdrvChild *source=
, BdrvChild *target,
         .mem =3D shres_create(BLOCK_COPY_MAX_MEM),
     };
=20
-    s->copy_range_size =3D QEMU_ALIGN_DOWN(max_transfer, cluster_size),
-    /*
-     * Set use_copy_range, consider the following:
-     * 1. Compression is not supported for copy_range.
-     * 2. copy_range does not respect max_transfer (it's a TODO), so we fa=
ctor
-     *    that in here. If max_transfer is smaller than the job->cluster_s=
ize,
-     *    we do not use copy_range (in that case it's zero after aligning =
down
-     *    above).
-     */
-    s->use_copy_range =3D
-        !(write_flags & BDRV_REQ_WRITE_COMPRESSED) && s->copy_range_size >=
 0;
+    if (max_transfer < cluster_size) {
+        /*
+         * copy_range does not respect max_transfer. We don't want to both=
er
+         * with requests smaller than block-copy cluster size, so fallback=
 to
+         * buffered copying (read and write respect max_transfer on their
+         * behalf).
+         */
+        s->use_copy_range =3D false;
+        s->copy_size =3D cluster_size;
+    } else if (write_flags & BDRV_REQ_WRITE_COMPRESSED) {
+        /* Compression is not supported for copy_range */
+        s->use_copy_range =3D false;
+        s->copy_size =3D MAX(cluster_size, BLOCK_COPY_MAX_BUFFER);
+    } else {
+        /*
+         * copy_range does not respect max_transfer (it's a TODO), so we f=
actor
+         * that in here.
+         */
+        s->use_copy_range =3D true;
+        s->copy_size =3D MIN(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
+                           QEMU_ALIGN_DOWN(max_transfer, cluster_size));
+    }
=20
     QLIST_INIT(&s->inflight_reqs);
=20
@@ -156,12 +166,19 @@ static int coroutine_fn block_copy_do_copy(BlockCopyS=
tate *s,
         if (ret < 0) {
             trace_block_copy_copy_range_fail(s, start, ret);
             s->use_copy_range =3D false;
+            s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
             /* Fallback to read+write with allocated buffer */
         } else {
             goto out;
         }
     }
=20
+    /*
+     * In case of failed copy_range request above, we may proceed with buf=
fered
+     * request larger than BLOCK_COPY_MAX_BUFFER. Still, further requests =
will
+     * be properly limited, so don't care too much.
+     */
+
     bounce_buffer =3D qemu_blockalign(s->source->bs, nbytes);
=20
     ret =3D bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
@@ -290,8 +307,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
=20
-        chunk_end =3D MIN(end, start + (s->use_copy_range ?
-                                      s->copy_range_size : s->cluster_size=
));
+        chunk_end =3D MIN(end, start + s->copy_size);
=20
         next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
                                                 chunk_end - start);
--=20
2.21.0


