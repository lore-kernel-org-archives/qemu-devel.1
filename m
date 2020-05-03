Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF5C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F2E206E9
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gashF7b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F2E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVJc7-0005nN-Jm
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 14:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVJaY-0003Hj-3i
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:43:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVJaX-0000FA-7V
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588531420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TO8u682QsRwRdaYtSFM5YjgOIDD4b/mZaLCtUEKxWg=;
 b=gashF7b/50GPkjTY48aCk5/bEn166micKt8vpcVDyQTKpX/px7DACJLnsysI95LHPpECTv
 v/YAHuau4+O3PDNTS/m6ecKcQrr6YZP8UZhskn5hb0qgatYCC3c+sapWa2dBUvANj8eIvq
 2604gG92VEzD5C6TSkiX3LJguxJNWiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-snzx3C0KP1WUUCFNBKcflA-1; Sun, 03 May 2020 14:43:38 -0400
X-MC-Unique: snzx3C0KP1WUUCFNBKcflA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD9B45F;
 Sun,  3 May 2020 18:43:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BC9B5C1B2;
 Sun,  3 May 2020 18:43:35 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/14] block/amend: add 'force' option
Date: Sun,  3 May 2020 21:43:13 +0300
Message-Id: <20200503184324.12506-4-mlevitsk@redhat.com>
In-Reply-To: <20200503184324.12506-1-mlevitsk@redhat.com>
References: <20200503184324.12506-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 14:43:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

'force' option will be used for some unsafe amend operations.

This includes things like erasing last keyslot in luks based formats
(which destroys the data, unless the master key is backed up
by external means), but that _might_ be desired result.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block.c                   | 4 +++-
 block/qcow2.c             | 1 +
 docs/tools/qemu-img.rst   | 5 ++++-
 include/block/block.h     | 1 +
 include/block/block_int.h | 1 +
 qemu-img-cmds.hx          | 4 ++--
 qemu-img.c                | 8 +++++++-
 7 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 301ec588bd..fe692202a9 100644
--- a/block.c
+++ b/block.c
@@ -6377,6 +6377,7 @@ void bdrv_remove_aio_context_notifier(BlockDriverStat=
e *bs,
=20
 int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opaqu=
e,
+                       bool force,
                        Error **errp)
 {
     if (!bs->drv) {
@@ -6388,7 +6389,8 @@ int bdrv_amend_options(BlockDriverState *bs, QemuOpts=
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
 /*
diff --git a/block/qcow2.c b/block/qcow2.c
index 2ba0b17c39..ffb6b22e2d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5200,6 +5200,7 @@ static void qcow2_amend_helper_cb(BlockDriverState *b=
s,
 static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                                BlockDriverAmendStatusCB *status_cb,
                                void *cb_opaque,
+                               bool force,
                                Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 0080f83a76..fc2dca6649 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -249,11 +249,14 @@ Command description:
=20
 .. program:: qemu-img-commands
=20
-.. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT] [=
-t CACHE] -o OPTIONS FILENAME
+.. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT] [=
-t CACHE] [--force] -o OPTIONS FILENAME
=20
   Amends the image format specific *OPTIONS* for the image file
   *FILENAME*. Not all file formats support this operation.
=20
+  --force allows some unsafe operations. Currently for -f luks, it allows =
to
+  erase last encryption key, and to overwrite an active encryption key.
+
 .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=3DFLUSH=
_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=3DPATTERN] [-q=
] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
=20
   Run a simple sequential I/O benchmark on the specified image. If ``-w`` =
is
diff --git a/include/block/block.h b/include/block/block.h
index 8b62429aa4..0ca53b5598 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -392,6 +392,7 @@ typedef void BlockDriverAmendStatusCB(BlockDriverState =
*bs, int64_t offset,
                                       int64_t total_work_size, void *opaqu=
e);
 int bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opaqu=
e,
+                       bool force,
                        Error **errp);
=20
 /* check if a named node can be replaced when doing drive-mirror */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 92335f33c7..98671ecdf6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -432,6 +432,7 @@ struct BlockDriver {
     int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
                               BlockDriverAmendStatusCB *status_cb,
                               void *cb_opaque,
+                              bool force,
                               Error **errp);
=20
     void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9c54de1df..9920f1f9d4 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -10,9 +10,9 @@ HXCOMM When amending the rST sections, please remember to=
 copy the usage
 HXCOMM over to the per-command sections in qemu-img.texi.
=20
 DEF("amend", img_amend,
-    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cach=
e] -o options filename")
+    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cach=
e] [--force] -o options filename")
 SRST
-.. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT] [=
-t CACHE] -o OPTIONS FILENAME
+.. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT] [=
-t CACHE] [--force] -o OPTIONS FILENAME
 ERST
=20
 DEF("bench", img_bench,
diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba..ef422d5471 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -71,6 +71,7 @@ enum {
     OPTION_SHRINK =3D 266,
     OPTION_SALVAGE =3D 267,
     OPTION_TARGET_IS_ZERO =3D 268,
+    OPTION_FORCE =3D 269,
 };
=20
 typedef enum OutputFormat {
@@ -3958,6 +3959,7 @@ static int img_amend(int argc, char **argv)
     BlockBackend *blk =3D NULL;
     BlockDriverState *bs =3D NULL;
     bool image_opts =3D false;
+    bool force =3D false;
=20
     cache =3D BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -3965,6 +3967,7 @@ static int img_amend(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force", no_argument, 0, OPTION_FORCE},
             {0, 0, 0, 0}
         };
         c =3D getopt_long(argc, argv, ":ho:f:t:pq",
@@ -4012,6 +4015,9 @@ static int img_amend(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts =3D true;
             break;
+        case OPTION_FORCE:
+            force =3D true;
+            break;
         }
     }
=20
@@ -4089,7 +4095,7 @@ static int img_amend(int argc, char **argv)
=20
     /* In case the driver does not call amend_status_cb() */
     qemu_progress_print(0.f, 0);
-    ret =3D bdrv_amend_options(bs, opts, &amend_status_cb, NULL, &err);
+    ret =3D bdrv_amend_options(bs, opts, &amend_status_cb, NULL, force, &e=
rr);
     qemu_progress_print(100.f, 0);
     if (ret < 0) {
         error_report_err(err);
--=20
2.17.2


