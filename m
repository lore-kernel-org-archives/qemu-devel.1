Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC6C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A515521479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A515521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8Wa-0007Op-Rw
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:37:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8Cj-0004ZW-E2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8Ch-0000SM-HT
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:17:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP8Cb-0000Fv-Nv; Fri, 10 May 2019 12:16:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCE2D307DA31;
	Fri, 10 May 2019 16:16:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0C6517797;
	Fri, 10 May 2019 16:16:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 18:16:12 +0200
Message-Id: <20190510161614.23236-14-kwolf@redhat.com>
In-Reply-To: <20190510161614.23236-1-kwolf@redhat.com>
References: <20190510161614.23236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 10 May 2019 16:16:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/15] qemu-img: Allow rebase with no input base
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Currently, without -u, you cannot add a backing file to an image when it
currently has none:

$ qemu-img rebase -b base.qcow2 foo.qcow2
qemu-img: Could not open old backing file '': The 'file' block driver
requires a file name

It is really simple to allow this, though (effectively by setting
old_backing_size to 0), so this patch does just that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 61 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 71c92f142a..cfa44b4153 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3312,26 +3312,30 @@ static int img_rebase(int argc, char **argv)
         char backing_name[PATH_MAX];
         QDict *options =3D NULL;
=20
-        if (bs->backing_format[0] !=3D '\0') {
-            options =3D qdict_new();
-            qdict_put_str(options, "driver", bs->backing_format);
-        }
-
-        if (force_share) {
-            if (!options) {
+        if (bs->backing) {
+            if (bs->backing_format[0] !=3D '\0') {
                 options =3D qdict_new();
+                qdict_put_str(options, "driver", bs->backing_format);
             }
-            qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
-        }
-        bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name)=
);
-        blk_old_backing =3D blk_new_open(backing_name, NULL,
-                                       options, src_flags, &local_err);
-        if (!blk_old_backing) {
-            error_reportf_err(local_err,
-                              "Could not open old backing file '%s': ",
-                              backing_name);
-            ret =3D -1;
-            goto out;
+
+            if (force_share) {
+                if (!options) {
+                    options =3D qdict_new();
+                }
+                qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
+            }
+            bdrv_get_backing_filename(bs, backing_name, sizeof(backing_n=
ame));
+            blk_old_backing =3D blk_new_open(backing_name, NULL,
+                                           options, src_flags, &local_er=
r);
+            if (!blk_old_backing) {
+                error_reportf_err(local_err,
+                                  "Could not open old backing file '%s':=
 ",
+                                  backing_name);
+                ret =3D -1;
+                goto out;
+            }
+        } else {
+            blk_old_backing =3D NULL;
         }
=20
         if (out_baseimg[0]) {
@@ -3384,7 +3388,7 @@ static int img_rebase(int argc, char **argv)
      */
     if (!unsafe) {
         int64_t size;
-        int64_t old_backing_size;
+        int64_t old_backing_size =3D 0;
         int64_t new_backing_size =3D 0;
         uint64_t offset;
         int64_t n;
@@ -3400,15 +3404,18 @@ static int img_rebase(int argc, char **argv)
             ret =3D -1;
             goto out;
         }
-        old_backing_size =3D blk_getlength(blk_old_backing);
-        if (old_backing_size < 0) {
-            char backing_name[PATH_MAX];
+        if (blk_old_backing) {
+            old_backing_size =3D blk_getlength(blk_old_backing);
+            if (old_backing_size < 0) {
+                char backing_name[PATH_MAX];
=20
-            bdrv_get_backing_filename(bs, backing_name, sizeof(backing_n=
ame));
-            error_report("Could not get size of '%s': %s",
-                         backing_name, strerror(-old_backing_size));
-            ret =3D -1;
-            goto out;
+                bdrv_get_backing_filename(bs, backing_name,
+                                          sizeof(backing_name));
+                error_report("Could not get size of '%s': %s",
+                             backing_name, strerror(-old_backing_size));
+                ret =3D -1;
+                goto out;
+            }
         }
         if (blk_new_backing) {
             new_backing_size =3D blk_getlength(blk_new_backing);
--=20
2.20.1


