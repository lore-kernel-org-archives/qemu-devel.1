Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD7DC31E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA0421721
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA0421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmw2-0002EU-5p
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmSG-0001zA-W6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmS4-0006Cm-F7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmS1-00066d-40; Fri, 14 Jun 2019 09:41:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4ECBC0546D3;
 Fri, 14 Jun 2019 13:41:01 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E5827C5BB;
 Fri, 14 Jun 2019 13:41:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:15 +0200
Message-Id: <20190614134021.32486-15-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 14 Jun 2019 13:41:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/20] qemu-img: Move quiet into ImgConvertState
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

Move img_convert()'s quiet flag into the ImgConvertState so it is
accessible by nested functions.  -q dictates that it suppresses anything
but errors, so if those functions want to emit warnings, they need to
query this flag first.  (There currently are no such warnings, but there
will be as of the next patch.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190507203508.18026-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index da14aea46a..e15e617256 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1581,6 +1581,7 @@ typedef struct ImgConvertState {
     int64_t target_backing_sectors; /* negative if unknown */
     bool wr_in_order;
     bool copy_range;
+    bool quiet;
     int min_sparse;
     int alignment;
     size_t cluster_sectors;
@@ -2012,7 +2013,7 @@ static int img_convert(int argc, char **argv)
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
@@ -2120,7 +2121,7 @@ static int img_convert(int argc, char **argv)
             src_cache =3D optarg;
             break;
         case 'q':
-            quiet =3D true;
+            s.quiet =3D true;
             break;
         case 'n':
             skip_create =3D true;
@@ -2209,7 +2210,7 @@ static int img_convert(int argc, char **argv)
     }
=20
     /* Initialize before goto out */
-    if (quiet) {
+    if (s.quiet) {
         progress =3D false;
     }
     qemu_progress_init(progress, 1.0);
@@ -2220,7 +2221,7 @@ static int img_convert(int argc, char **argv)
=20
     for (bs_i =3D 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] =3D img_open(image_opts, argv[optind + bs_i],
-                               fmt, src_flags, src_writethrough, quiet,
+                               fmt, src_flags, src_writethrough, s.quiet=
,
                                force_share);
         if (!s.src[bs_i]) {
             ret =3D -1;
@@ -2383,7 +2384,7 @@ static int img_convert(int argc, char **argv)
=20
     if (skip_create) {
         s.target =3D img_open(tgt_image_opts, out_filename, out_fmt,
-                            flags, writethrough, quiet, false);
+                            flags, writethrough, s.quiet, false);
     } else {
         /* TODO ultimately we should allow --target-image-opts
          * to be used even when -n is not given.
@@ -2391,7 +2392,7 @@ static int img_convert(int argc, char **argv)
          * to allow filenames in option syntax
          */
         s.target =3D img_open_file(out_filename, open_opts, out_fmt,
-                                 flags, writethrough, quiet, false);
+                                 flags, writethrough, s.quiet, false);
         open_opts =3D NULL; /* blk_new_open will have freed it */
     }
     if (!s.target) {
--=20
2.21.0


