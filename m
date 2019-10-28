Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA5BCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B324320717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0iG9ZPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B324320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4iv-0007Iy-9r
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wc-0002Rn-Eo
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wb-0001o8-5m
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wa-0001nl-Vm
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQH891K9cRbxEVZvL7E4z3vBB3xxoYPbvBEZln4pkVQ=;
 b=R0iG9ZPstwVyO2iiS6PtuPShr0XfTn/+xgJfCrz55ipggzUE9QjsINFnLHbIm0iSBCU/kp
 XaoOeVLOPAJvAaxON8VHLqPyJP4pswa8r2lAacCQR1VnalBzjnFu7TmXDQErtqgyR+shRM
 8fNMZ3IIFipTRxbZM2RhoQLmqrklS8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-UUWKxpB8MbG7Yg3hWyY8VQ-1; Mon, 28 Oct 2019 08:16:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D26800FF1;
 Mon, 28 Oct 2019 12:16:17 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6298F6084E;
 Mon, 28 Oct 2019 12:16:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 36/69] block/block-copy: allocate buffer in
 block_copy_with_bounce_buffer
Date: Mon, 28 Oct 2019 13:14:28 +0100
Message-Id: <20191028121501.15279-37-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UUWKxpB8MbG7Yg3hWyY8VQ-1
X-Mimecast-Spam-Score: 0
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move bounce_buffer allocation block_copy_with_bounce_buffer. This
commit simplifies further work on implementing copying by larger chunks
(of different size) and further asynchronous handling of block_copy
iterations (with help of block/aio_task API).

Allocation works fast, a lot faster than disk io, so it's not a problem
that we now allocate/free bounce_buffer more times. And we anyway will
have to allocate several bounce_buffers for parallel execution of loop
iterations in future.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191022111805.3432-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 066e3a7274..ecd086010e 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -126,20 +126,17 @@ void block_copy_set_callbacks(
 static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
                                                       int64_t start,
                                                       int64_t end,
-                                                      bool *error_is_read,
-                                                      void **bounce_buffer=
)
+                                                      bool *error_is_read)
 {
     int ret;
     int nbytes;
+    void *bounce_buffer =3D qemu_blockalign(s->source->bs, s->cluster_size=
);
=20
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
     bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     nbytes =3D MIN(s->cluster_size, s->len - start);
-    if (!*bounce_buffer) {
-        *bounce_buffer =3D qemu_blockalign(s->source->bs, s->cluster_size)=
;
-    }
=20
-    ret =3D bdrv_co_pread(s->source, start, nbytes, *bounce_buffer, 0);
+    ret =3D bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
     if (ret < 0) {
         trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
         if (error_is_read) {
@@ -148,7 +145,7 @@ static int coroutine_fn block_copy_with_bounce_buffer(B=
lockCopyState *s,
         goto fail;
     }
=20
-    ret =3D bdrv_co_pwrite(s->target, start, nbytes, *bounce_buffer,
+    ret =3D bdrv_co_pwrite(s->target, start, nbytes, bounce_buffer,
                          s->write_flags);
     if (ret < 0) {
         trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
@@ -158,8 +155,11 @@ static int coroutine_fn block_copy_with_bounce_buffer(=
BlockCopyState *s,
         goto fail;
     }
=20
+    qemu_vfree(bounce_buffer);
+
     return nbytes;
 fail:
+    qemu_vfree(bounce_buffer);
     bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     return ret;
=20
@@ -271,7 +271,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
 {
     int ret =3D 0;
     int64_t end =3D bytes + start; /* bytes */
-    void *bounce_buffer =3D NULL;
     int64_t status_bytes;
     BlockCopyInFlightReq req;
=20
@@ -324,7 +323,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
         }
         if (!s->use_copy_range) {
             ret =3D block_copy_with_bounce_buffer(s, start, dirty_end,
-                                                error_is_read, &bounce_buf=
fer);
+                                                error_is_read);
         }
         if (ret < 0) {
             break;
@@ -335,10 +334,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
         ret =3D 0;
     }
=20
-    if (bounce_buffer) {
-        qemu_vfree(bounce_buffer);
-    }
-
     block_copy_inflight_req_end(&req);
=20
     return ret;
--=20
2.21.0


