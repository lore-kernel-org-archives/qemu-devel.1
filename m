Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACCBC4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A087D20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A087D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8XfN-0001cZ-1W
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcB-0007kj-FQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcA-0005mC-1o
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8Xc7-0005kT-4a; Thu, 12 Sep 2019 18:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7623118CB8FE;
 Thu, 12 Sep 2019 22:30:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1185C1B2;
 Thu, 12 Sep 2019 22:30:51 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 01:30:21 +0300
Message-Id: <20190912223028.18496-5-mlevitsk@redhat.com>
In-Reply-To: <20190912223028.18496-1-mlevitsk@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 12 Sep 2019 22:30:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 04/11] block: amend: add 'force' option
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'force' optinion will be used for some unsafe option amend operations.

This includes things like erasing last keyslot in luks (which pretty much=
 guarantees
destroying the data, unless the master key is backed up by extrnal means,
but that _might_ be desired result)


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
index 5944124845..414303f76d 100644
--- a/block.c
+++ b/block.c
@@ -6141,6 +6141,7 @@ void bdrv_remove_aio_context_notifier(BlockDriverSt=
ate *bs,
=20
 int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opa=
que,
+                       bool force,
                        Error **errp)
 {
     if (!bs->drv) {
@@ -6152,7 +6153,8 @@ int bdrv_amend_options(BlockDriverState *bs, QemuOp=
ts *opts,
                    bs->drv->format_name);
         return -ENOTSUP;
     }
-    return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque, e=
rrp);
+    return bs->drv->bdrv_amend_options(bs, opts, status_cb,
+                                       cb_opaque, force, errp);
 }
=20
 /* This function will be called by the bdrv_recurse_is_first_non_filter =
method
diff --git a/block/qcow2.c b/block/qcow2.c
index 5bdb8b18f4..0618a63793 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4822,6 +4822,7 @@ static void qcow2_amend_helper_cb(BlockDriverState =
*bs,
 static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                                BlockDriverAmendStatusCB *status_cb,
                                void *cb_opaque,
+                               bool force,
                                Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..6bc89c7667 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -400,6 +400,7 @@ typedef void BlockDriverAmendStatusCB(BlockDriverStat=
e *bs, int64_t offset,
                                       int64_t total_work_size, void *opa=
que);
 int bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opa=
que,
+                       bool force,
                        Error **errp);
=20
 /* external snapshots */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c..5ea30f9d58 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -411,6 +411,7 @@ struct BlockDriver {
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
-    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t ca=
che] -o options filename")
+    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t ca=
che] [--force] -o options filename")
 STEXI
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var=
{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var=
{fmt}] [-t @var{cache}] [--force] -o @var{options} @var{filename}
 ETEXI
=20
 DEF("bench", img_bench,
diff --git a/qemu-img.c b/qemu-img.c
index 4ee436fc94..30300870ff 100644
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
@@ -3915,6 +3916,7 @@ static int img_amend(int argc, char **argv)
     BlockBackend *blk =3D NULL;
     BlockDriverState *bs =3D NULL;
     bool image_opts =3D false;
+    bool force =3D false;
=20
     cache =3D BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -3922,6 +3924,7 @@ static int img_amend(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force", no_argument, 0, OPTION_FORCE},
             {0, 0, 0, 0}
         };
         c =3D getopt_long(argc, argv, ":ho:f:t:pq",
@@ -3977,6 +3980,9 @@ static int img_amend(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts =3D true;
             break;
+        case OPTION_FORCE:
+            force =3D true;
+            break;
         }
     }
=20
@@ -4054,7 +4060,7 @@ static int img_amend(int argc, char **argv)
=20
     /* In case the driver does not call amend_status_cb() */
     qemu_progress_print(0.f, 0);
-    ret =3D bdrv_amend_options(bs, opts, &amend_status_cb, NULL, &err);
+    ret =3D bdrv_amend_options(bs, opts, &amend_status_cb, NULL, force, =
&err);
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
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var=
{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var=
{fmt}] [-t @var{cache}] [--force] -o @var{options} @var{filename}
=20
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
=20
+--force allows some unsafe operations. Currently for -f luks,
+it allows to erase last encryption key, and to overwrite an active
+encryption key.
+
 @item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-in=
terval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pat=
tern=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-=
t @var{cache}] [-w] [-U] @var{filename}
=20
 Run a simple sequential I/O benchmark on the specified image. If @code{-=
w} is
--=20
2.17.2


