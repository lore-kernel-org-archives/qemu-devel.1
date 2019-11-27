Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71048C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6CC2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Njpe/7x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6CC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxNZ-0006rC-PJ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBj-0003vj-P6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBh-0006bN-5S
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBb-0006ME-0D
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6u95mXcYc9SMxlpTyEXj+2SJrduZrwXCZw0fVJc7dIE=;
 b=Njpe/7x56G+8yBQr6tAlMkfiejEUUx0pqmlZW6sNYRGB5eIbjhBrwGgTTh1jx9qeN2cOXA
 rSrP65aO+IBm2bGFFuMDHpuZvVkXA/59bBxI2KWDJUnv2Fjja/iLopNN/pSTgUY2wbijdh
 I+1lko9XeZmnlR8P6tXHj9jWCz1M90I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-FH1ATIPNNjeNLaBzwCcKNg-1; Wed, 27 Nov 2019 08:16:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 707141050905;
 Wed, 27 Nov 2019 13:16:44 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC0E5600C8;
 Wed, 27 Nov 2019 13:16:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 07/31] block: Pass BdrvChildRole to .inherit_options()
Date: Wed, 27 Nov 2019 14:16:00 +0100
Message-Id: <20191127131624.1062403-8-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FH1ATIPNNjeNLaBzwCcKNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 40 +++++++++++++++++++++++----------------
 block/block-backend.c     |  3 ++-
 block/vvfat.c             |  3 ++-
 include/block/block_int.h |  3 ++-
 4 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/block.c b/block.c
index 58252007af..f42682478e 100644
--- a/block.c
+++ b/block.c
@@ -77,6 +77,7 @@ static BlockDriverState *bdrv_open_inherit(const char *fi=
lename,
                                            QDict *options, int flags,
                                            BlockDriverState *parent,
                                            const BdrvChildClass *child_cla=
ss,
+                                           BdrvChildRole child_role,
                                            Error **errp);
=20
 /* If non-zero, use only whitelisted block drivers */
@@ -979,7 +980,8 @@ static void bdrv_temp_snapshot_options(int *child_flags=
, QDict *child_options,
  * Returns the options and flags that bs->file should get if a protocol dr=
iver
  * is expected, based on the given options and flags for the parent BDS
  */
-static void bdrv_inherited_options(int *child_flags, QDict *child_options,
+static void bdrv_inherited_options(BdrvChildRole role,
+                                   int *child_flags, QDict *child_options,
                                    int parent_flags, QDict *parent_options=
)
 {
     int flags =3D parent_flags;
@@ -1028,10 +1030,11 @@ const BdrvChildClass child_file =3D {
  * (and not only protocols) is permitted for it, based on the given option=
s and
  * flags for the parent BDS
  */
-static void bdrv_inherited_fmt_options(int *child_flags, QDict *child_opti=
ons,
+static void bdrv_inherited_fmt_options(BdrvChildRole role,
+                                       int *child_flags, QDict *child_opti=
ons,
                                        int parent_flags, QDict *parent_opt=
ions)
 {
-    child_file.inherit_options(child_flags, child_options,
+    child_file.inherit_options(role, child_flags, child_options,
                                parent_flags, parent_options);
=20
     *child_flags &=3D ~BDRV_O_PROTOCOL;
@@ -1112,7 +1115,8 @@ static void bdrv_backing_detach(BdrvChild *c)
  * Returns the options and flags that bs->backing should get, based on the
  * given options and flags for the parent BDS
  */
-static void bdrv_backing_options(int *child_flags, QDict *child_options,
+static void bdrv_backing_options(BdrvChildRole role,
+                                 int *child_flags, QDict *child_options,
                                  int parent_flags, QDict *parent_options)
 {
     int flags =3D parent_flags;
@@ -2687,7 +2691,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDic=
t *parent_options,
     }
=20
     backing_hd =3D bdrv_open_inherit(backing_filename, reference, options,=
 0, bs,
-                                   &child_backing, errp);
+                                   &child_backing, 0, errp);
     if (!backing_hd) {
         bs->open_flags |=3D BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -2722,7 +2726,7 @@ free_exit:
 static BlockDriverState *
 bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref=
_key,
                    BlockDriverState *parent, const BdrvChildClass *child_c=
lass,
-                   bool allow_none, Error **errp)
+                   BdrvChildRole child_role, bool allow_none, Error **errp=
)
 {
     BlockDriverState *bs =3D NULL;
     QDict *image_options;
@@ -2753,7 +2757,7 @@ bdrv_open_child_bs(const char *filename, QDict *optio=
ns, const char *bdref_key,
     }
=20
     bs =3D bdrv_open_inherit(filename, reference, image_options, 0,
-                           parent, child_class, errp);
+                           parent, child_class, child_role, errp);
     if (!bs) {
         goto done;
     }
@@ -2787,7 +2791,7 @@ BdrvChild *bdrv_open_child(const char *filename,
     BlockDriverState *bs;
=20
     bs =3D bdrv_open_child_bs(filename, options, bdref_key, parent, child_=
class,
-                            allow_none, errp);
+                            child_role, allow_none, errp);
     if (bs =3D=3D NULL) {
         return NULL;
     }
@@ -2836,7 +2840,7 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef =
*ref, Error **errp)
=20
     }
=20
-    bs =3D bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp);
+    bs =3D bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 0, err=
p);
     obj =3D NULL;
=20
 fail:
@@ -2935,6 +2939,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                                            QDict *options, int flags,
                                            BlockDriverState *parent,
                                            const BdrvChildClass *child_cla=
ss,
+                                           BdrvChildRole child_role,
                                            Error **errp)
 {
     int ret;
@@ -2987,7 +2992,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
=20
     if (child_class) {
         bs->inherits_from =3D parent;
-        child_class->inherit_options(&flags, options,
+        child_class->inherit_options(child_role, &flags, options,
                                      parent->open_flags, parent->options);
     }
=20
@@ -3016,7 +3021,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                                    flags, options);
         /* Let bdrv_backing_options() override "read-only" */
         qdict_del(options, BDRV_OPT_READ_ONLY);
-        bdrv_backing_options(&flags, options, flags, options);
+        bdrv_backing_options(0, &flags, options, flags, options);
     }
=20
     bs->open_flags =3D flags;
@@ -3058,7 +3063,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
         BlockDriverState *file_bs;
=20
         file_bs =3D bdrv_open_child_bs(filename, options, "file", bs,
-                                     &child_file, true, &local_err);
+                                     &child_file, 0, true, &local_err);
         if (local_err) {
             goto fail;
         }
@@ -3203,7 +3208,7 @@ BlockDriverState *bdrv_open(const char *filename, con=
st char *reference,
                             QDict *options, int flags, Error **errp)
 {
     return bdrv_open_inherit(filename, reference, options, flags, NULL,
-                             NULL, errp);
+                             NULL, 0, errp);
 }
=20
 /* Return true if the NULL-terminated @list contains @str */
@@ -3300,6 +3305,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
                                                  BlockDriverState *bs,
                                                  QDict *options,
                                                  const BdrvChildClass *kla=
ss,
+                                                 BdrvChildRole role,
                                                  QDict *parent_options,
                                                  int parent_flags,
                                                  bool keep_old_opts)
@@ -3355,7 +3361,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
     /* Inherit from parent node */
     if (parent_options) {
         flags =3D 0;
-        klass->inherit_options(&flags, options, parent_flags, parent_optio=
ns);
+        klass->inherit_options(role, &flags, options,
+                               parent_flags, parent_options);
     } else {
         flags =3D bdrv_get_flags(bs);
     }
@@ -3446,7 +3453,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
         }
=20
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
-                                child->klass, options, flags, child_keep_o=
ld);
+                                child->klass, child->role, options, flags,
+                                child_keep_old);
     }
=20
     return bs_queue;
@@ -3456,7 +3464,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue =
*bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, bool keep_old_opts)
 {
-    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, NULL, 0,
+    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, NULL, 0=
,
                                    keep_old_opts);
 }
=20
diff --git a/block/block-backend.c b/block/block-backend.c
index 4b79b2abb1..98f3167fa6 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -120,7 +120,8 @@ static QTAILQ_HEAD(, BlockBackend) block_backends =3D
 static QTAILQ_HEAD(, BlockBackend) monitor_block_backends =3D
     QTAILQ_HEAD_INITIALIZER(monitor_block_backends);
=20
-static void blk_root_inherit_options(int *child_flags, QDict *child_option=
s,
+static void blk_root_inherit_options(BdrvChildRole role,
+                                     int *child_flags, QDict *child_option=
s,
                                      int parent_flags, QDict *parent_optio=
ns)
 {
     /* We're not supposed to call this function for root nodes */
diff --git a/block/vvfat.c b/block/vvfat.c
index e9f64b0b24..0c2f77bece 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3137,7 +3137,8 @@ static BlockDriver vvfat_write_target =3D {
     .bdrv_close         =3D write_target_close,
 };
=20
-static void vvfat_qcow_options(int *child_flags, QDict *child_options,
+static void vvfat_qcow_options(BdrvChildRole role,
+                               int *child_flags, QDict *child_options,
                                int parent_flags, QDict *parent_options)
 {
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "off");
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 102ce7853e..7553faa5cf 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -666,7 +666,8 @@ struct BdrvChildClass {
      * non-BDS parents. */
     bool parent_is_bds;
=20
-    void (*inherit_options)(int *child_flags, QDict *child_options,
+    void (*inherit_options)(BdrvChildRole role,
+                            int *child_flags, QDict *child_options,
                             int parent_flags, QDict *parent_options);
=20
     void (*change_media)(BdrvChild *child, bool load);
--=20
2.23.0


