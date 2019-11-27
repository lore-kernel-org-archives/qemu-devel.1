Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D3C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292B720678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hepntnhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292B720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxX2-0006ak-S4
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCA-0004Kx-PD
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxC9-000729-BP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxC9-00071n-72
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LgrvK3KPLWks3s/MYg78IsZQRLJBVuhjQlGuPhR2cdY=;
 b=hepntnhczJcLEBF3NG93CaHTK2gHvoDqMb5g8y4RymHudMCdK6+4hkB0fACaTVJLsRufoL
 UFzdWLGgj/rUIVWtemH2oZWUAJAVYPj8J7jQ0g7E4XmpuyU/3etDmhosJc4C4U/arKvI8S
 gpzO3w61vGvxEGU4uQSnFnAreLWYzUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-YtaG4zwJPc6OwuZqGwUsHg-1; Wed, 27 Nov 2019 08:17:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A04A106C00E;
 Wed, 27 Nov 2019 13:17:22 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20ECF19481;
 Wed, 27 Nov 2019 13:17:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 23/31] block: Make filter drivers use child_of_bds
Date: Wed, 27 Nov 2019 14:16:16 +0100
Message-Id: <20191127131624.1062403-24-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YtaG4zwJPc6OwuZqGwUsHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that some filters have secondary children, namely blkverify (the
image to be verified) and blklogwrites (the log).  This patch does not
touch those children.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkdebug.c     | 4 +++-
 block/blklogwrites.c | 3 ++-
 block/blkverify.c    | 5 ++++-
 block/copy-on-read.c | 5 +++--
 block/replication.c  | 3 ++-
 block/throttle.c     | 5 +++--
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 8dd8ed6055..b31fa40b0e 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -497,7 +497,9 @@ static int blkdebug_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
=20
     /* Open the image file */
     bs->file =3D bdrv_open_child(qemu_opt_get(opts, "x-image"), options, "=
image",
-                               bs, &child_file, 0, false, &local_err);
+                               bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
+                               false, &local_err);
     if (local_err) {
         ret =3D -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 4faf912ef1..78b0c49460 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -157,7 +157,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QD=
ict *options, int flags,
     }
=20
     /* Open the file */
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
, false,
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY, f=
alse,
                                &local_err);
     if (local_err) {
         ret =3D -EINVAL;
diff --git a/block/blkverify.c b/block/blkverify.c
index 4f4d079b12..7df4cb8007 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -125,7 +125,10 @@ static int blkverify_open(BlockDriverState *bs, QDict =
*options, int flags,
=20
     /* Open the raw file */
     bs->file =3D bdrv_open_child(qemu_opt_get(opts, "x-raw"), options, "ra=
w",
-                               bs, &child_file, 0, false, &local_err);
+                               bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PROTOCOL |
+                               BDRV_CHILD_PRIMARY,
+                               false, &local_err);
     if (local_err) {
         ret =3D -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index a2d92ac394..c857ea0da7 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -28,8 +28,9 @@
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
, false,
-                               errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
+                               false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/replication.c b/block/replication.c
index 9ca5c9368e..ec512ae1c3 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -90,7 +90,8 @@ static int replication_open(BlockDriverState *bs, QDict *=
options,
     const char *mode;
     const char *top_id;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
diff --git a/block/throttle.c b/block/throttle.c
index 2dea913be7..47b0a3522d 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -81,8 +81,9 @@ static int throttle_open(BlockDriverState *bs, QDict *opt=
ions,
     char *group;
     int ret;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs,
-                               &child_file, 0, false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
+                               false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
--=20
2.23.0


