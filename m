Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF88C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC67C2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJMi4oQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC67C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1pk-0000ZW-3Q
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hx-0003tg-5E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hu-0003c2-OA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hu-0003aQ-JW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaEPxWNxtU1KEIjIKSkF5qzZBgYbwfHjpAO6kD0iiJg=;
 b=WJMi4oQ/D/y5FsiBjD7qVlwGFmoAHVF39i9oiTowDK8cqZiPqou9hMxv4yZHJlOYmmNtQd
 3JDHdndsNe+SLyu2FkNAdNhbhE0vKNXHj9dU2F1wSY23LS4/XJh65+5n2K5DueREdfYjeC
 7oOLF5UW5OahWTFT0LrPjw7WTTozefI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-MMnxtvlTP3y-YXmrTcIzcA-1; Tue, 04 Feb 2020 12:09:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B2C8010F2;
 Tue,  4 Feb 2020 17:09:47 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BDF45C1D8;
 Tue,  4 Feb 2020 17:09:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 19/33] raw-format: Split raw_read_options()
Date: Tue,  4 Feb 2020 18:08:34 +0100
Message-Id: <20200204170848.614480-20-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: MMnxtvlTP3y-YXmrTcIzcA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split raw_read_options() into one function that actually just reads the
options, and another that applies them.  This will allow us to detect
whether the user has specified any options before attaching the file
child (so we can decide on its role based on the options).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/raw-format.c | 110 ++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index b600dae209..33f5942474 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -71,20 +71,13 @@ static QemuOptsList raw_create_opts =3D {
     }
 };
=20
-static int raw_read_options(QDict *options, BlockDriverState *bs,
-    BDRVRawState *s, Error **errp)
+static int raw_read_options(QDict *options, uint64_t *offset, bool *has_si=
ze,
+                            uint64_t *size, Error **errp)
 {
     Error *local_err =3D NULL;
     QemuOpts *opts =3D NULL;
-    int64_t real_size =3D 0;
     int ret;
=20
-    real_size =3D bdrv_getlength(bs->file->bs);
-    if (real_size < 0) {
-        error_setg_errno(errp, -real_size, "Could not get image size");
-        return real_size;
-    }
-
     opts =3D qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -93,64 +86,84 @@ static int raw_read_options(QDict *options, BlockDriver=
State *bs,
         goto end;
     }
=20
-    s->offset =3D qemu_opt_get_size(opts, "offset", 0);
-    if (s->offset > real_size) {
-        error_setg(errp, "Offset (%" PRIu64 ") cannot be greater than "
-            "size of the containing file (%" PRId64 ")",
-            s->offset, real_size);
-        ret =3D -EINVAL;
-        goto end;
-    }
+    *offset =3D qemu_opt_get_size(opts, "offset", 0);
+    *has_size =3D qemu_opt_find(opts, "size");
+    *size =3D qemu_opt_get_size(opts, "size", 0);
=20
-    if (qemu_opt_find(opts, "size") !=3D NULL) {
-        s->size =3D qemu_opt_get_size(opts, "size", 0);
-        s->has_size =3D true;
-    } else {
-        s->has_size =3D false;
-        s->size =3D real_size - s->offset;
+    ret =3D 0;
+end:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static int raw_apply_options(BlockDriverState *bs, BDRVRawState *s,
+                             uint64_t offset, bool has_size, uint64_t size=
,
+                             Error **errp)
+{
+    int64_t real_size =3D 0;
+
+    real_size =3D bdrv_getlength(bs->file->bs);
+    if (real_size < 0) {
+        error_setg_errno(errp, -real_size, "Could not get image size");
+        return real_size;
     }
=20
     /* Check size and offset */
-    if ((real_size - s->offset) < s->size) {
+    if (offset > real_size) {
+        error_setg(errp, "Offset (%" PRIu64 ") cannot be greater than "
+                   "size of the containing file (%" PRId64 ")",
+                   s->offset, real_size);
+        return -EINVAL;
+    }
+
+    if (has_size && (real_size - offset) < size) {
         error_setg(errp, "The sum of offset (%" PRIu64 ") and size "
-            "(%" PRIu64 ") has to be smaller or equal to the "
-            " actual size of the containing file (%" PRId64 ")",
-            s->offset, s->size, real_size);
-        ret =3D -EINVAL;
-        goto end;
+                   "(%" PRIu64 ") has to be smaller or equal to the "
+                   " actual size of the containing file (%" PRId64 ")",
+                   s->offset, s->size, real_size);
+        return -EINVAL;
     }
=20
     /* Make sure size is multiple of BDRV_SECTOR_SIZE to prevent rounding
      * up and leaking out of the specified area. */
-    if (s->has_size && !QEMU_IS_ALIGNED(s->size, BDRV_SECTOR_SIZE)) {
+    if (has_size && !QEMU_IS_ALIGNED(size, BDRV_SECTOR_SIZE)) {
         error_setg(errp, "Specified size is not multiple of %llu",
-            BDRV_SECTOR_SIZE);
-        ret =3D -EINVAL;
-        goto end;
+                   BDRV_SECTOR_SIZE);
+        return -EINVAL;
     }
=20
-    ret =3D 0;
-
-end:
+    s->offset =3D offset;
+    s->has_size =3D has_size;
+    s->size =3D has_size ? size : real_size - offset;
=20
-    qemu_opts_del(opts);
-
-    return ret;
+    return 0;
 }
=20
 static int raw_reopen_prepare(BDRVReopenState *reopen_state,
                               BlockReopenQueue *queue, Error **errp)
 {
+    bool has_size;
+    uint64_t offset, size;
+    int ret;
+
     assert(reopen_state !=3D NULL);
     assert(reopen_state->bs !=3D NULL);
=20
     reopen_state->opaque =3D g_new0(BDRVRawState, 1);
=20
-    return raw_read_options(
-        reopen_state->options,
-        reopen_state->bs,
-        reopen_state->opaque,
-        errp);
+    ret =3D raw_read_options(reopen_state->options, &offset, &has_size, &s=
ize,
+                           errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D raw_apply_options(reopen_state->bs, reopen_state->opaque,
+                            offset, has_size, size, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
 }
=20
 static void raw_reopen_commit(BDRVReopenState *state)
@@ -429,8 +442,15 @@ static int raw_open(BlockDriverState *bs, QDict *optio=
ns, int flags,
                     Error **errp)
 {
     BDRVRawState *s =3D bs->opaque;
+    bool has_size;
+    uint64_t offset, size;
     int ret;
=20
+    ret =3D raw_read_options(options, &offset, &has_size, &size, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
                                false, errp);
     if (!bs->file) {
@@ -456,7 +476,7 @@ static int raw_open(BlockDriverState *bs, QDict *option=
s, int flags,
                 bs->file->bs->filename);
     }
=20
-    ret =3D raw_read_options(options, bs, s, errp);
+    ret =3D raw_apply_options(bs, s, offset, has_size, size, errp);
     if (ret < 0) {
         return ret;
     }
--=20
2.24.1


