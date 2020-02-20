Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19686C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59F3207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2UPYpS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59F3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oOr-0005Q0-0c
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oNc-0003Gb-F3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oNb-0005Ro-0F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oNa-0005Ou-S6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8/PRIwPN+WNDBo8H+1U+retri+fRshGQEUM+hCun2E=;
 b=N2UPYpS9W56Bj1fNcwXUHC2lFUEZVE/YuVnb1MYMt8v0d44W5wteAKxDX1Tb0/0F4gczNB
 3P8sCmLbCaUXuVeuYHCRgF+ZVYO1Re3Ywmt0oMdhGuvosFI2z78owtWNY8YgJyYRCpUXXO
 1S9POF1E9xpexr8Wj7R9ugXjNSg/iEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-_JHDCFVHP-OTx3PzqJs9lg-1; Thu, 20 Feb 2020 11:08:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8AC8010F5;
 Thu, 20 Feb 2020 16:08:41 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6765177935;
 Thu, 20 Feb 2020 16:08:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/18] qemu-img: Add --target-is-zero to convert
Date: Thu, 20 Feb 2020 17:06:58 +0100
Message-Id: <20200220160710.533297-7-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _JHDCFVHP-OTx3PzqJs9lg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: David Edmondson <david.edmondson@oracle.com>

In many cases the target of a convert operation is a newly provisioned
target that the user knows is blank (reads as zero). In this situation
there is no requirement for qemu-img to wastefully zero out the entire
device.

Add a new option, --target-is-zero, allowing the user to indicate that
an existing target device will return zeros for all reads.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
Message-Id: <20200205110248.2009589-2-david.edmondson@oracle.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qemu-img.rst |  9 ++++++++-
 qemu-img-cmds.hx          |  4 ++--
 qemu-img.c                | 26 +++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
index 42e4451db4..5f40137c10 100644
--- a/docs/interop/qemu-img.rst
+++ b/docs/interop/qemu-img.rst
@@ -214,6 +214,13 @@ Parameters to convert subcommand:
   will still be printed.  Areas that cannot be read from the source will b=
e
   treated as containing only zeroes.
=20
+.. option:: --target-is-zero
+
+  Assume that reading the destination image will always return
+  zeros. This parameter is mutually exclusive with a destination image
+  that has a backing file. It is required to also use the ``-n``
+  parameter to skip image creation.
+
 Parameters to dd subcommand:
=20
 .. program:: qemu-img-dd
@@ -366,7 +373,7 @@ Command description:
   4
     Error on reading data
=20
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OU=
TPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZ=
E] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-=
T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PA=
RAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] O=
UTPUT_FILENAME
=20
   Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
   to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index d7fbc6b1f4..c9c54de1df 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -39,9 +39,9 @@ SRST
 ERST
=20
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U=
] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fm=
t] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m =
num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename=
")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--=
target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_c=
ache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-=
S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [..=
.]] output_filename")
 SRST
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OU=
TPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZ=
E] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_F=
ILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-=
T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PA=
RAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENA=
ME2 [...]] OUTPUT_FILENAME
 ERST
=20
 DEF("create", img_create,
diff --git a/qemu-img.c b/qemu-img.c
index 2b4562b9d9..0faf2cd2f5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -70,6 +70,7 @@ enum {
     OPTION_PREALLOCATION =3D 265,
     OPTION_SHRINK =3D 266,
     OPTION_SALVAGE =3D 267,
+    OPTION_TARGET_IS_ZERO =3D 268,
 };
=20
 typedef enum OutputFormat {
@@ -1984,10 +1985,9 @@ static int convert_do_copy(ImgConvertState *s)
     int64_t sector_num =3D 0;
=20
     /* Check whether we have zero initialisation or can get it efficiently=
 */
-    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
+    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
+        !s->target_has_backing) {
         s->has_zero_init =3D bdrv_has_zero_init(blk_bs(s->target));
-    } else {
-        s->has_zero_init =3D false;
     }
=20
     if (!s->has_zero_init && !s->target_has_backing &&
@@ -2086,6 +2086,7 @@ static int img_convert(int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS=
},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
+            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
             {0, 0, 0, 0}
         };
         c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2209,6 +2210,14 @@ static int img_convert(int argc, char **argv)
         case OPTION_TARGET_IMAGE_OPTS:
             tgt_image_opts =3D true;
             break;
+        case OPTION_TARGET_IS_ZERO:
+            /*
+             * The user asserting that the target is blank has the
+             * same effect as the target driver supporting zero
+             * initialisation.
+             */
+            s.has_zero_init =3D true;
+            break;
         }
     }
=20
@@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
         warn_report("This will become an error in future QEMU versions.");
     }
=20
+    if (s.has_zero_init && !skip_create) {
+        error_report("--target-is-zero requires use of -n flag");
+        goto fail_getopt;
+    }
+
     s.src_num =3D argc - optind - 1;
     out_filename =3D s.src_num >=3D 1 ? argv[argc - 1] : NULL;
=20
@@ -2380,6 +2394,12 @@ static int img_convert(int argc, char **argv)
     }
     s.target_has_backing =3D (bool) out_baseimg;
=20
+    if (s.has_zero_init && s.target_has_backing) {
+        error_report("Cannot use --target-is-zero when the destination "
+                     "image has a backing file");
+        goto out;
+    }
+
     if (s.src_num > 1 && out_baseimg) {
         error_report("Having a backing file for the target makes no sense =
when "
                      "concatenating multiple input images");
--=20
2.24.1


