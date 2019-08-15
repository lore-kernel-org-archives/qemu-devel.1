Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEA3C3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463EE2063F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463EE2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKaZ-0005GG-TF
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKX9-0002za-Fj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKX6-0001sl-Oa
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyKWz-0001e3-Cf; Thu, 15 Aug 2019 14:31:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 99EC8D7A52;
 Thu, 15 Aug 2019 18:31:22 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1FB084D8D;
 Thu, 15 Aug 2019 18:31:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:33 -0500
Message-Id: <20190815183039.4264-4-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
References: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 15 Aug 2019 18:31:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/9] block/stream: use BDRV_REQ_PREFETCH
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block Jobs" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This helps to avoid extra io, allocations and memory copying.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190725100550.33801-3-vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[eblake: fix comment grammar]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/stream.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 6ac1e7bec42c..0d3a6ac7c3f7 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -22,11 +22,11 @@

 enum {
     /*
-     * Size of data buffer for populating the image file.  This should b=
e large
-     * enough to process multiple clusters in a single call, so that pop=
ulating
-     * contiguous regions of the image is efficient.
+     * Maximum chunk size to feed to copy-on-read.  This should be
+     * large enough to process multiple clusters in a single call, so
+     * that populating contiguous regions of the image is efficient.
      */
-    STREAM_BUFFER_SIZE =3D 512 * 1024, /* in bytes */
+    STREAM_CHUNK =3D 512 * 1024, /* in bytes */
 };

 typedef struct StreamBlockJob {
@@ -39,13 +39,12 @@ typedef struct StreamBlockJob {
 } StreamBlockJob;

 static int coroutine_fn stream_populate(BlockBackend *blk,
-                                        int64_t offset, uint64_t bytes,
-                                        void *buf)
+                                        int64_t offset, uint64_t bytes)
 {
     assert(bytes < SIZE_MAX);

-    /* Copy-on-read the unallocated clusters */
-    return blk_co_pread(blk, offset, bytes, buf, BDRV_REQ_COPY_ON_READ);
+    return blk_co_preadv(blk, offset, bytes, NULL,
+                         BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
 }

 static void stream_abort(Job *job)
@@ -117,7 +116,6 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     int error =3D 0;
     int ret =3D 0;
     int64_t n =3D 0; /* bytes */
-    void *buf;

     if (bs =3D=3D s->bottom) {
         /* Nothing to stream */
@@ -130,8 +128,6 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     }
     job_progress_set_remaining(&s->common.job, len);

-    buf =3D qemu_blockalign(bs, STREAM_BUFFER_SIZE);
-
     /* Turn on copy-on-read for the whole block device so that guest rea=
d
      * requests help us make progress.  Only do this when copying the en=
tire
      * backing chain since the copy-on-read operation does not take base=
 into
@@ -154,7 +150,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)

         copy =3D false;

-        ret =3D bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n);
+        ret =3D bdrv_is_allocated(bs, offset, STREAM_CHUNK, &n);
         if (ret =3D=3D 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >=3D 0) {
@@ -171,7 +167,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret =3D stream_populate(blk, offset, n, buf);
+            ret =3D stream_populate(blk, offset, n);
         }
         if (ret < 0) {
             BlockErrorAction action =3D
@@ -202,8 +198,6 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
         bdrv_disable_copy_on_read(bs);
     }

-    qemu_vfree(buf);
-
     /* Do not remove the backing file if an error was there but ignored.=
 */
     return error;
 }
--=20
2.20.1


