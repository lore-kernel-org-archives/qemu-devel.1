Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A57BC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386DE20726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6JlXDKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386DE20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC21b-0008Oi-6K
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1nA-0004cZ-TB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1n9-0002o3-90
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1n9-0002nV-3B
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/f8zi/yuoYMPXC+CLnUsUmXddDv0sJgWs+3CU7kMAE=;
 b=M6JlXDKVaaR7HfxGv0nIq2/mT38ti2zs+bodkT08FmkWwmNv9tcXX7UJY3Yf4dHqtsjP/G
 kKdHPyx0u8cuxVT6l9UUywyzxTMoz0maExoRtBtm9TW8svAXCThPgeA4ltpB3fgcMxgwIo
 6nhV+E4Y2dEgUHtts0dBOkl9mC/nqec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-fb593t8GMsu-Q6mLVD8EZQ-1; Wed, 11 Mar 2020 09:52:56 -0400
X-MC-Unique: fb593t8GMsu-Q6mLVD8EZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3B43189F767;
 Wed, 11 Mar 2020 13:52:55 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F4741001DF0;
 Wed, 11 Mar 2020 13:52:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/19] block/block-copy: specialcase first copy_range request
Date: Wed, 11 Mar 2020 14:52:07 +0100
Message-Id: <20200311135213.1242028-14-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In block_copy_do_copy we fallback to read+write if copy_range failed.
In this case copy_size is larger than defined for buffered IO, and
there is corresponding commit. Still, backup copies data cluster by
cluster, and most of requests are limited to one cluster anyway, so the
only source of this one bad-limited request is copy-before-write
operation.

Further patch will move backup to use block_copy directly, than for
cases where copy_range is not supported, first request will be
oversized in each backup. It's not good, let's change it now.

Fix is simple: just limit first copy_range request like buffer-based
request. If it succeed, set larger copy_range limit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-4-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index e2d7b3b887..ddd61c1652 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -70,16 +70,19 @@ void block_copy_state_free(BlockCopyState *s)
     g_free(s);
 }
=20
+static uint32_t block_copy_max_transfer(BdrvChild *source, BdrvChild *targ=
et)
+{
+    return MIN_NON_ZERO(INT_MAX,
+                        MIN_NON_ZERO(source->bs->bl.max_transfer,
+                                     target->bs->bl.max_transfer));
+}
+
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      int64_t cluster_size,
                                      BdrvRequestFlags write_flags, Error *=
*errp)
 {
     BlockCopyState *s;
     BdrvDirtyBitmap *copy_bitmap;
-    uint32_t max_transfer =3D
-            MIN_NON_ZERO(INT_MAX,
-                         MIN_NON_ZERO(source->bs->bl.max_transfer,
-                                      target->bs->bl.max_transfer));
=20
     copy_bitmap =3D bdrv_create_dirty_bitmap(source->bs, cluster_size, NUL=
L,
                                            errp);
@@ -99,7 +102,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, =
BdrvChild *target,
         .mem =3D shres_create(BLOCK_COPY_MAX_MEM),
     };
=20
-    if (max_transfer < cluster_size) {
+    if (block_copy_max_transfer(source, target) < cluster_size) {
         /*
          * copy_range does not respect max_transfer. We don't want to both=
er
          * with requests smaller than block-copy cluster size, so fallback=
 to
@@ -114,12 +117,11 @@ BlockCopyState *block_copy_state_new(BdrvChild *sourc=
e, BdrvChild *target,
         s->copy_size =3D cluster_size;
     } else {
         /*
-         * copy_range does not respect max_transfer (it's a TODO), so we f=
actor
-         * that in here.
+         * We enable copy-range, but keep small copy_size, until first
+         * successful copy_range (look at block_copy_do_copy).
          */
         s->use_copy_range =3D true;
-        s->copy_size =3D MIN(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
-                           QEMU_ALIGN_DOWN(max_transfer, cluster_size));
+        s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
=20
     QLIST_INIT(&s->inflight_reqs);
@@ -172,6 +174,22 @@ static int coroutine_fn block_copy_do_copy(BlockCopySt=
ate *s,
             s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
             /* Fallback to read+write with allocated buffer */
         } else {
+            if (s->use_copy_range) {
+                /*
+                 * Successful copy-range. Now increase copy_size.  copy_ra=
nge
+                 * does not respect max_transfer (it's a TODO), so we fact=
or
+                 * that in here.
+                 *
+                 * Note: we double-check s->use_copy_range for the case wh=
en
+                 * parallel block-copy request unsets it during previous
+                 * bdrv_co_copy_range call.
+                 */
+                s->copy_size =3D
+                        MIN(MAX(s->cluster_size, BLOCK_COPY_MAX_COPY_RANGE=
),
+                            QEMU_ALIGN_DOWN(block_copy_max_transfer(s->sou=
rce,
+                                                                    s->tar=
get),
+                                            s->cluster_size));
+            }
             goto out;
         }
     }
@@ -179,7 +197,10 @@ static int coroutine_fn block_copy_do_copy(BlockCopySt=
ate *s,
     /*
      * In case of failed copy_range request above, we may proceed with buf=
fered
      * request larger than BLOCK_COPY_MAX_BUFFER. Still, further requests =
will
-     * be properly limited, so don't care too much.
+     * be properly limited, so don't care too much. Moreover the most like=
ly
+     * case (copy_range is unsupported for the configuration, so the very =
first
+     * copy_range request fails) is handled by setting large copy_size onl=
y
+     * after first successful copy_range.
      */
=20
     bounce_buffer =3D qemu_blockalign(s->source->bs, nbytes);
--=20
2.24.1


