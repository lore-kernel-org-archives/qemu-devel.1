Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BC7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B7F20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSr7GbhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B7F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDf6-00018H-Px
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdV-0007WV-BM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixDdT-0007mQ-E2
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixDdT-0007jP-92
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580405386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gcSulAK3g0ada/p/fOzW+hSdXGKJ7gztXkq2XhBcF8=;
 b=DSr7GbhI/DBykNTyMGQBDE+gjFpwgy6l6/UEeMWcN022cs2XxgU1dk2Fwyf8/nhPJrWsGe
 y2Fqe63cerXC2n5OJpMTYFDtttLB/Rz7cpLbIgs/bqOGeib58+RdSYFWJKrOHsEelFsbyb
 kf8RZ7rTq+McwDNz50j+kiXkRCGmhMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-v-zN9W1hNc-ZfizAS6b5jQ-1; Thu, 30 Jan 2020 12:29:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37BB48017CC;
 Thu, 30 Jan 2020 17:29:36 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 083665D9E5;
 Thu, 30 Jan 2020 17:29:33 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/14] block/amend: add 'force' option
Date: Thu, 30 Jan 2020 19:29:08 +0200
Message-Id: <20200130172919.13424-4-mlevitsk@redhat.com>
In-Reply-To: <20200130172919.13424-1-mlevitsk@redhat.com>
References: <20200130172919.13424-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: v-zN9W1hNc-ZfizAS6b5jQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'force' option will be used for some unsafe amend operations.

This includes things like erasing last keyslot in luks based formats
(which destroys the data, unless the master key is backed up
by external means), but that _might_ be desired result.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block.c                   | 4 +++-
 block/qcow2.c             | 1 +
 include/block/block.h     | 1 +
 include/block/block_int.h | 1 +
 qemu-img-cmds.hx          | 4 ++--
 qemu-img.c                | 8 +++++++-
 qemu-img.texi             | 6 +++++-
 7 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index ecd09dbbfd..cb9d5f1965 100644
--- a/block.c
+++ b/block.c
@@ -6164,6 +6164,7 @@ void bdrv_remove_aio_context_notifier(BlockDriverStat=
e *bs,
=20
 int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opaqu=
e,
+                       bool force,
                        Error **errp)
 {
     if (!bs->drv) {
@@ -6175,7 +6176,8 @@ int bdrv_amend_options(BlockDriverState *bs, QemuOpts=
 *opts,
                    bs->drv->format_name);
         return -ENOTSUP;
     }
-    return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque, err=
p);
+    return bs->drv->bdrv_amend_options(bs, opts, status_cb,
+                                       cb_opaque, force, errp);
 }
=20
 /* This function will be called by the bdrv_recurse_is_first_non_filter me=
thod
diff --git a/block/qcow2.c b/block/qcow2.c
index cef9d72b3a..6bcf4a5fc4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5150,6 +5150,7 @@ static void qcow2_amend_helper_cb(BlockDriverState *b=
s,
 static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                                BlockDriverAmendStatusCB *status_cb,
                                void *cb_opaque,
+                               bool force,
                                Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
diff --git a/include/block/block.h b/include/block/block.h
index e9dcfef7fa..d0cd1b2da0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -399,6 +399,7 @@ typedef void BlockDriverAmendStatusCB(BlockDriverState =
*bs, int64_t offset,
                                       int64_t total_work_size, void *opaqu=
e);
 int bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opaqu=
e,
+                       bool force,
                        Error **errp);
=20
 /* external snapshots */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0b37..810a9ecb86 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -427,6 +427,7 @@ struct BlockDriver {
     int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
                               BlockDriverAmendStatusCB *status_cb,
                               void *cb_opaque,
+                              bool force,
                               Error **errp);
=20
     void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1c93e6d185..323ea10ad0 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -14,9 +14,9 @@ STEXI
 ETEXI
=20
 DEF("amend", img_amend,
-    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cach=
e] -o options filename")
+    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cach=
e] [--force] -o options filename")
 STEXI
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{f=
mt}] [-t @var{cache}] -o @var{options} @var{filename}
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{f=
mt}] [-t @var{cache}] [--force] -o @var{options} @var{filename}
 ETEXI
=20
 DEF("bench", img_bench,
diff --git a/qemu-img.c b/qemu-img.c
index 6233b8ca56..a79f3904db 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -70,6 +70,7 @@ enum {
     OPTION_PREALLOCATION =3D 265,
     OPTION_SHRINK =3D 266,
     OPTION_SALVAGE =3D 267,
+    OPTION_FORCE =3D 268,
 };
=20
 typedef enum OutputFormat {
@@ -3900,6 +3901,7 @@ static int img_amend(int argc, char **argv)
     BlockBackend *blk =3D NULL;
     BlockDriverState *bs =3D NULL;
     bool image_opts =3D false;
+    bool force =3D false;
=20
     cache =3D BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -3907,6 +3909,7 @@ static int img_amend(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force", no_argument, 0, OPTION_FORCE},
             {0, 0, 0, 0}
         };
         c =3D getopt_long(argc, argv, ":ho:f:t:pq",
@@ -3962,6 +3965,9 @@ static int img_amend(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts =3D true;
             break;
+        case OPTION_FORCE:
+            force =3D true;
+            break;
         }
     }
=20
@@ -4039,7 +4045,7 @@ static int img_amend(int argc, char **argv)
=20
     /* In case the driver does not call amend_status_cb() */
     qemu_progress_print(0.f, 0);
-    ret =3D bdrv_amend_options(bs, opts, &amend_status_cb, NULL, &err);
+    ret =3D bdrv_amend_options(bs, opts, &amend_status_cb, NULL, force, &e=
rr);
     qemu_progress_print(100.f, 0);
     if (ret < 0) {
         error_report_err(err);
diff --git a/qemu-img.texi b/qemu-img.texi
index b5156d6316..b6ed4357e8 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -201,11 +201,15 @@ Command description:
=20
 @table @option
=20
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{f=
mt}] [-t @var{cache}] -o @var{options} @var{filename}
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{f=
mt}] [-t @var{cache}] [--force] -o @var{options} @var{filename}
=20
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
=20
+--force allows some unsafe operations. Currently for -f luks,
+it allows to erase last encryption key, and to overwrite an active
+encryption key.
+
 @item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-inte=
rval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=
=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var=
{cache}] [-w] [-U] @var{filename}
=20
 Run a simple sequential I/O benchmark on the specified image. If @code{-w}=
 is
--=20
2.17.2


