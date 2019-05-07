Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC4C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B8820449
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B8820449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO6tU-00025Q-As
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 16:40:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6oS-0005KQ-5K
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6oQ-00040M-7D
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO6oK-0003Ws-Gv; Tue, 07 May 2019 16:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D87B588305;
	Tue,  7 May 2019 20:35:13 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EA072E03A;
	Tue,  7 May 2019 20:35:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 22:35:02 +0200
Message-Id: <20190507203508.18026-2-mreitz@redhat.com>
In-Reply-To: <20190507203508.18026-1-mreitz@redhat.com>
References: <20190507203508.18026-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 20:35:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 1/7] qemu-img: Move quiet into
 ImgConvertState
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move img_convert()'s quiet flag into the ImgConvertState so it is
accessible by nested functions.  -q dictates that it suppresses anything
but errors, so if those functions want to emit warnings, they need to
query this flag first.  (There currently are no such warnings, but there
will be as of the next patch.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e6ad5978e0..f606675933 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1578,6 +1578,7 @@ typedef struct ImgConvertState {
     int64_t target_backing_sectors; /* negative if unknown */
     bool wr_in_order;
     bool copy_range;
+    bool quiet;
     int min_sparse;
     int alignment;
     size_t cluster_sectors;
@@ -2009,7 +2010,7 @@ static int img_convert(int argc, char **argv)
     QDict *open_opts =3D NULL;
     char *options =3D NULL;
     Error *local_err =3D NULL;
-    bool writethrough, src_writethrough, quiet =3D false, image_opts =3D=
 false,
+    bool writethrough, src_writethrough, image_opts =3D false,
          skip_create =3D false, progress =3D false, tgt_image_opts =3D f=
alse;
     int64_t ret =3D -EINVAL;
     bool force_share =3D false;
@@ -2117,7 +2118,7 @@ static int img_convert(int argc, char **argv)
             src_cache =3D optarg;
             break;
         case 'q':
-            quiet =3D true;
+            s.quiet =3D true;
             break;
         case 'n':
             skip_create =3D true;
@@ -2206,7 +2207,7 @@ static int img_convert(int argc, char **argv)
     }
=20
     /* Initialize before goto out */
-    if (quiet) {
+    if (s.quiet) {
         progress =3D false;
     }
     qemu_progress_init(progress, 1.0);
@@ -2217,7 +2218,7 @@ static int img_convert(int argc, char **argv)
=20
     for (bs_i =3D 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] =3D img_open(image_opts, argv[optind + bs_i],
-                               fmt, src_flags, src_writethrough, quiet,
+                               fmt, src_flags, src_writethrough, s.quiet=
,
                                force_share);
         if (!s.src[bs_i]) {
             ret =3D -1;
@@ -2380,7 +2381,7 @@ static int img_convert(int argc, char **argv)
=20
     if (skip_create) {
         s.target =3D img_open(tgt_image_opts, out_filename, out_fmt,
-                            flags, writethrough, quiet, false);
+                            flags, writethrough, s.quiet, false);
     } else {
         /* TODO ultimately we should allow --target-image-opts
          * to be used even when -n is not given.
@@ -2388,7 +2389,7 @@ static int img_convert(int argc, char **argv)
          * to allow filenames in option syntax
          */
         s.target =3D img_open_file(out_filename, open_opts, out_fmt,
-                                 flags, writethrough, quiet, false);
+                                 flags, writethrough, s.quiet, false);
         open_opts =3D NULL; /* blk_new_open will have freed it */
     }
     if (!s.target) {
--=20
2.20.1


