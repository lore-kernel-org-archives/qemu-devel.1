Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C11C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA2E204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA2E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEKLf-0003fq-Ks
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 17:01:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHd-0000bs-Kl
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHc-000879-Dg
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEKHZ-000857-Jd; Wed, 10 Apr 2019 16:57:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D727E7DCE6;
	Wed, 10 Apr 2019 20:57:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A2C55D719;
	Wed, 10 Apr 2019 20:57:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:57:10 +0200
Message-Id: <20190410205715.2209-2-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-1-mreitz@redhat.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 10 Apr 2019 20:57:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/6] qemu-img: Move quiet into
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
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	"Denis V . Lunev" <den@openvz.org>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410205710.UvCKUFy9ubMIjYc7npTbpbvA9kN-gD7zwEQjSYo_pKY@z>

Move img_convert()'s quiet flag into the ImgConvertState so it is
accessible by nested functions.  -q dictates that it suppresses anything
but errors, so if those functions want to emit warnings, they need to
query this flag first.  (There currently are no such warnings, but there
will be as of the next patch.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index aa6f81f1ea..c53666aa41 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1569,6 +1569,7 @@ typedef struct ImgConvertState {
     int64_t target_backing_sectors; /* negative if unknown */
     bool wr_in_order;
     bool copy_range;
+    bool quiet;
     int min_sparse;
     int alignment;
     size_t cluster_sectors;
@@ -2005,7 +2006,7 @@ static int img_convert(int argc, char **argv)
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
@@ -2113,7 +2114,7 @@ static int img_convert(int argc, char **argv)
             src_cache =3D optarg;
             break;
         case 'q':
-            quiet =3D true;
+            s.quiet =3D true;
             break;
         case 'n':
             skip_create =3D true;
@@ -2202,7 +2203,7 @@ static int img_convert(int argc, char **argv)
     }
=20
     /* Initialize before goto out */
-    if (quiet) {
+    if (s.quiet) {
         progress =3D false;
     }
     qemu_progress_init(progress, 1.0);
@@ -2213,7 +2214,7 @@ static int img_convert(int argc, char **argv)
=20
     for (bs_i =3D 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] =3D img_open(image_opts, argv[optind + bs_i],
-                               fmt, src_flags, src_writethrough, quiet,
+                               fmt, src_flags, src_writethrough, s.quiet=
,
                                force_share);
         if (!s.src[bs_i]) {
             ret =3D -1;
@@ -2376,7 +2377,7 @@ static int img_convert(int argc, char **argv)
=20
     if (skip_create) {
         s.target =3D img_open(tgt_image_opts, out_filename, out_fmt,
-                            flags, writethrough, quiet, false);
+                            flags, writethrough, s.quiet, false);
     } else {
         /* TODO ultimately we should allow --target-image-opts
          * to be used even when -n is not given.
@@ -2384,7 +2385,7 @@ static int img_convert(int argc, char **argv)
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


