Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C23C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57414206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjTEHSmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57414206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTaH-0003hO-IM
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCTVz-0005EW-0k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCTVx-0007Ps-KL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:29:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCTVx-0007OX-FN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SM4DqXapyl+nLTWQu/+pgke4fntoLVf9Sz4VN1LyjwU=;
 b=KjTEHSmqk+mPiz76R8ZV9ZZC53VHcvy3P54FvuC92YSF551OLOkqys4ardOZJ+pGXlm3Oz
 izlXcQnWBWxduu983sHRU5ASgTOI3Hr/Xr3jjCCS/YBbSsMdwus98/yG9B2q2Pu3c9qZ4k
 Hj+4R9VZOrmCpCYwmpxNbgNqIdtZp0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-JVHWs-TCM2KheHrriJX_Sg-1; Thu, 12 Mar 2020 15:29:02 -0400
X-MC-Unique: JVHWs-TCM2KheHrriJX_Sg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BFB2DB77;
 Thu, 12 Mar 2020 19:29:01 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13F1D5DA76;
 Thu, 12 Mar 2020 19:28:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/7] block: Add support to warn on backing file change
 without format
Date: Thu, 12 Mar 2020 14:28:21 -0500
Message-Id: <20200312192822.3739399-7-eblake@redhat.com>
In-Reply-To: <20200312192822.3739399-1-eblake@redhat.com>
References: <20200312192822.3739399-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, pkrempa@redhat.com,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now, this is a mechanical addition; all callers pass false. But
the next patch will use it to improve 'qemu-img rebase -u' when
selecting a backing file with no format.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 include/block/block.h |  4 ++--
 block.c               | 13 ++++++++++---
 block/qcow2.c         |  2 +-
 block/stream.c        |  2 +-
 blockdev.c            |  3 ++-
 qemu-img.c            |  4 ++--
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index e569a4d747a0..fe77a62c7284 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -350,8 +350,8 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOp=
ts *opts,
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
-int bdrv_change_backing_file(BlockDriverState *bs,
-    const char *backing_file, const char *backing_fmt);
+int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_fil=
e,
+                             const char *backing_fmt, bool warn);
 void bdrv_register(BlockDriver *bdrv);
 int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
                            const char *backing_file_str);
diff --git a/block.c b/block.c
index a2542c977b91..cd3277ab86fd 100644
--- a/block.c
+++ b/block.c
@@ -1317,7 +1317,8 @@ static int bdrv_backing_update_filename(BdrvChild *c,=
 BlockDriverState *base,
     }

     ret =3D bdrv_change_backing_file(parent, filename,
-                                   base->drv ? base->drv->format_name : ""=
);
+                                   base->drv ? base->drv->format_name : ""=
,
+                                   false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not update backing file link")=
;
     }
@@ -4560,8 +4561,8 @@ int bdrv_check(BlockDriverState *bs,
  *            image file header
  * -ENOTSUP - format driver doesn't support changing the backing file
  */
-int bdrv_change_backing_file(BlockDriverState *bs,
-    const char *backing_file, const char *backing_fmt)
+int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_fil=
e,
+                             const char *backing_fmt, bool warn)
 {
     BlockDriver *drv =3D bs->drv;
     int ret;
@@ -4575,6 +4576,12 @@ int bdrv_change_backing_file(BlockDriverState *bs,
         return -EINVAL;
     }

+    if (warn && backing_file && !backing_fmt) {
+        warn_report("Deprecated use of backing file without explicit "
+                    "backing format, use of this image requires "
+                    "potentially unsafe format probing");
+    }
+
     if (drv->bdrv_change_backing_file !=3D NULL) {
         ret =3D drv->bdrv_change_backing_file(bs, backing_file, backing_fm=
t);
     } else {
diff --git a/block/qcow2.c b/block/qcow2.c
index 97a1757156bb..592112edf379 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3507,7 +3507,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
         }

         ret =3D bdrv_change_backing_file(blk_bs(blk), qcow2_opts->backing_=
file,
-                                       backing_format);
+                                       backing_format, false);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not assign backing file '%=
s' "
                              "with format '%s'", qcow2_opts->backing_file,
diff --git a/block/stream.c b/block/stream.c
index aa2e7af98e37..310ccbaa4cfd 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -78,7 +78,7 @@ static int stream_prepare(Job *job)
             }
         }
         bdrv_set_backing_hd(bs, base, &local_err);
-        ret =3D bdrv_change_backing_file(bs, base_id, base_fmt);
+        ret =3D bdrv_change_backing_file(bs, base_id, base_fmt, false);
         if (local_err) {
             error_report_err(local_err);
             return -EPERM;
diff --git a/blockdev.c b/blockdev.c
index fa8630cb412d..5bc9d78563ab 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3692,7 +3692,8 @@ void qmp_change_backing_file(const char *device,
     }

     ret =3D bdrv_change_backing_file(image_bs, backing_file,
-                               image_bs->drv ? image_bs->drv->format_name =
: "");
+                                   image_bs->drv ? image_bs->drv->format_n=
ame : "",
+                                   false);

     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not change backing file to '%s=
'",
diff --git a/qemu-img.c b/qemu-img.c
index afddf33f08c6..4ca1d2db7307 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3639,9 +3639,9 @@ static int img_rebase(int argc, char **argv)
      * doesn't change when we switch the backing file.
      */
     if (out_baseimg && *out_baseimg) {
-        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt);
+        ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt, fal=
se);
     } else {
-        ret =3D bdrv_change_backing_file(bs, NULL, NULL);
+        ret =3D bdrv_change_backing_file(bs, NULL, NULL, false);
     }

     if (ret =3D=3D -ENOSPC) {
--=20
2.25.1


