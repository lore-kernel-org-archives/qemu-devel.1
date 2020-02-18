Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75084C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4187520659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7yAtmmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4187520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42Ld-0001dq-Bm
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42Da-00046c-CH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42DY-00016n-UJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42DY-00016d-Q5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CUk/4bN8GAo34xsF8INvZX4Ka4KupQ2TDuZcBSaemg=;
 b=h7yAtmmhi3UZOquWkGWIviyTy5GJaaD84u95eml6gwKCa1WhsFE71U+k5AxC53LHbVb9xa
 wf6eXGQxy5HhnB8zeRC99l8CtnlIxbVpxN/wkls9ad9ExY3v+uJmS3b7XwHk4fGAzm+4pt
 oqcaZFEHBas6VXozQPwe/4ziujFdVcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-QjmkOrHIPmK6uZFI3F5Y7g-1; Tue, 18 Feb 2020 07:43:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9367E13E6;
 Tue, 18 Feb 2020 12:43:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC9425DA60;
 Tue, 18 Feb 2020 12:43:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 07/33] block: Pass parent_is_format to .inherit_options()
Date: Tue, 18 Feb 2020 13:42:16 +0100
Message-Id: <20200218124242.584644-8-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QjmkOrHIPmK6uZFI3F5Y7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

We plan to unify the generic .inherit_options() functions.  The
resulting common function will need to decide whether to force-enable
format probing, force-disable it, or leave it as-is.  To make this
decision, it will need to know whether the parent node is a format node
or not (because we never want format probing if the parent is a format
node already (except for the backing chain)).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                   | 37 +++++++++++++++++++++++++++----------
 block/block-backend.c     |  2 +-
 block/vvfat.c             |  2 +-
 include/block/block_int.h |  2 +-
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index 9fc865288d..706fae355e 100644
--- a/block.c
+++ b/block.c
@@ -1002,7 +1002,7 @@ static void bdrv_temp_snapshot_options(int *child_fla=
gs, QDict *child_options,
  * Returns the options and flags that bs->file should get if a protocol dr=
iver
  * is expected, based on the given options and flags for the parent BDS
  */
-static void bdrv_inherited_options(BdrvChildRole role,
+static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_form=
at,
                                    int *child_flags, QDict *child_options,
                                    int parent_flags, QDict *parent_options=
)
 {
@@ -1053,10 +1053,12 @@ const BdrvChildClass child_file =3D {
  * flags for the parent BDS
  */
 static void bdrv_inherited_fmt_options(BdrvChildRole role,
+                                       bool parent_is_format,
                                        int *child_flags, QDict *child_opti=
ons,
                                        int parent_flags, QDict *parent_opt=
ions)
 {
-    child_file.inherit_options(role, child_flags, child_options,
+    child_file.inherit_options(role, parent_is_format,
+                               child_flags, child_options,
                                parent_flags, parent_options);
=20
     *child_flags &=3D ~(BDRV_O_PROTOCOL | BDRV_O_NO_IO);
@@ -1137,7 +1139,7 @@ static void bdrv_backing_detach(BdrvChild *c)
  * Returns the options and flags that bs->backing should get, based on the
  * given options and flags for the parent BDS
  */
-static void bdrv_backing_options(BdrvChildRole role,
+static void bdrv_backing_options(BdrvChildRole role, bool parent_is_format=
,
                                  int *child_flags, QDict *child_options,
                                  int parent_flags, QDict *parent_options)
 {
@@ -3014,8 +3016,22 @@ static BlockDriverState *bdrv_open_inherit(const cha=
r *filename,
     bs->explicit_options =3D qdict_clone_shallow(options);
=20
     if (child_class) {
+        bool parent_is_format;
+
+        if (parent->drv) {
+            parent_is_format =3D parent->drv->is_format;
+        } else {
+            /*
+             * parent->drv is not set yet because this node is opened for
+             * (potential) format probing.  That means that @parent is goi=
ng
+             * to be a format node.
+             */
+            parent_is_format =3D true;
+        }
+
         bs->inherits_from =3D parent;
-        child_class->inherit_options(child_role, &flags, options,
+        child_class->inherit_options(child_role, parent_is_format,
+                                     &flags, options,
                                      parent->open_flags, parent->options);
     }
=20
@@ -3044,7 +3060,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                                    flags, options);
         /* Let bdrv_backing_options() override "read-only" */
         qdict_del(options, BDRV_OPT_READ_ONLY);
-        bdrv_backing_options(0, &flags, options, flags, options);
+        bdrv_backing_options(0, true, &flags, options, flags, options);
     }
=20
     bs->open_flags =3D flags;
@@ -3329,6 +3345,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
                                                  QDict *options,
                                                  const BdrvChildClass *kla=
ss,
                                                  BdrvChildRole role,
+                                                 bool parent_is_format,
                                                  QDict *parent_options,
                                                  int parent_flags,
                                                  bool keep_old_opts)
@@ -3384,7 +3401,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
     /* Inherit from parent node */
     if (parent_options) {
         flags =3D 0;
-        klass->inherit_options(role, &flags, options,
+        klass->inherit_options(role, parent_is_format, &flags, options,
                                parent_flags, parent_options);
     } else {
         flags =3D bdrv_get_flags(bs);
@@ -3476,8 +3493,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
         }
=20
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
-                                child->klass, child->role, options, flags,
-                                child_keep_old);
+                                child->klass, child->role, bs->drv->is_for=
mat,
+                                options, flags, child_keep_old);
     }
=20
     return bs_queue;
@@ -3487,8 +3504,8 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue =
*bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, bool keep_old_opts)
 {
-    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, NULL, 0=
,
-                                   keep_old_opts);
+    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, false,
+                                   NULL, 0, keep_old_opts);
 }
=20
 /*
diff --git a/block/block-backend.c b/block/block-backend.c
index 98f3167fa6..9e0078bfb5 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -120,7 +120,7 @@ static QTAILQ_HEAD(, BlockBackend) block_backends =3D
 static QTAILQ_HEAD(, BlockBackend) monitor_block_backends =3D
     QTAILQ_HEAD_INITIALIZER(monitor_block_backends);
=20
-static void blk_root_inherit_options(BdrvChildRole role,
+static void blk_root_inherit_options(BdrvChildRole role, bool parent_is_fo=
rmat,
                                      int *child_flags, QDict *child_option=
s,
                                      int parent_flags, QDict *parent_optio=
ns)
 {
diff --git a/block/vvfat.c b/block/vvfat.c
index 7ef2c9cdcc..a945eeb635 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3130,7 +3130,7 @@ static BlockDriver vvfat_write_target =3D {
     .bdrv_co_pwritev    =3D write_target_commit,
 };
=20
-static void vvfat_qcow_options(BdrvChildRole role,
+static void vvfat_qcow_options(BdrvChildRole role, bool parent_is_format,
                                int *child_flags, QDict *child_options,
                                int parent_flags, QDict *parent_options)
 {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index fbc1b90088..1f8a818f76 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -677,7 +677,7 @@ struct BdrvChildClass {
      * non-BDS parents. */
     bool parent_is_bds;
=20
-    void (*inherit_options)(BdrvChildRole role,
+    void (*inherit_options)(BdrvChildRole role, bool parent_is_format,
                             int *child_flags, QDict *child_options,
                             int parent_flags, QDict *parent_options);
=20
--=20
2.24.1


