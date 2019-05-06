Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEBC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D494020830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D494020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59671 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhI8-0006zd-UC
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:20:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFp-0005Tb-9R
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFo-0004qE-05
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFl-0004mm-2b; Mon, 06 May 2019 13:18:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 591663002C60;
	Mon,  6 May 2019 17:18:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 232571001DF9;
	Mon,  6 May 2019 17:18:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:17:56 +0200
Message-Id: <20190506171805.14236-2-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 06 May 2019 17:18:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 01/10] block: Add bdrv_try_set_aio_context()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eventually, we want to make sure that all parents and all children of a
node are in the same AioContext as the node itself. This means that
changing the AioContext may fail because one of the other involved
parties (e.g. a guest device that was configured with an iothread)
cannot allow switching to a different AioContext.

Introduce a set of functions that allow to first check whether all
involved nodes can switch to a new context and only then do the actual
switch. The check recursively covers children and parents.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  8 ++++
 include/block/block_int.h |  3 ++
 block.c                   | 92 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa..649aa5b86d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -590,6 +590,14 @@ void bdrv_coroutine_enter(BlockDriverState *bs, Coro=
utine *co);
  * This function must be called with iothread lock held.
  */
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)=
;
+int bdrv_try_set_aio_context(BlockDriverState *bs, AioContext *ctx,
+                             Error **errp);
+int bdrv_child_try_set_aio_context(BlockDriverState *bs, AioContext *ctx=
,
+                                   BdrvChild *ignore_child, Error **errp=
);
+bool bdrv_child_can_set_aio_context(BdrvChild *c, AioContext *ctx,
+                                    GSList **ignore, Error **errp);
+bool bdrv_can_set_aio_context(BlockDriverState *bs, AioContext *ctx,
+                              GSList **ignore, Error **errp);
 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz);
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
=20
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 94d45c9708..b150c5f047 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -691,6 +691,9 @@ struct BdrvChildRole {
      * can update its reference. */
     int (*update_filename)(BdrvChild *child, BlockDriverState *new_base,
                            const char *filename, Error **errp);
+
+    bool (*can_set_aio_ctx)(BdrvChild *child, AioContext *ctx,
+                            GSList **ignore, Error **errp);
 };
=20
 extern const BdrvChildRole child_file;
diff --git a/block.c b/block.c
index 9ae5c0ed2f..a70c01effb 100644
--- a/block.c
+++ b/block.c
@@ -936,6 +936,13 @@ static int bdrv_child_cb_inactivate(BdrvChild *child=
)
     return 0;
 }
=20
+static bool bdrv_child_cb_can_set_aio_ctx(BdrvChild *child, AioContext *=
ctx,
+                                          GSList **ignore, Error **errp)
+{
+    BlockDriverState *bs =3D child->opaque;
+    return bdrv_can_set_aio_context(bs, ctx, ignore, errp);
+}
+
 /*
  * Returns the options and flags that a temporary snapshot should get, b=
ased on
  * the originally requested flags (the originally requested image will h=
ave
@@ -1003,6 +1010,7 @@ const BdrvChildRole child_file =3D {
     .attach          =3D bdrv_child_cb_attach,
     .detach          =3D bdrv_child_cb_detach,
     .inactivate      =3D bdrv_child_cb_inactivate,
+    .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
 };
=20
 /*
@@ -1029,6 +1037,7 @@ const BdrvChildRole child_format =3D {
     .attach          =3D bdrv_child_cb_attach,
     .detach          =3D bdrv_child_cb_detach,
     .inactivate      =3D bdrv_child_cb_inactivate,
+    .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
 };
=20
 static void bdrv_backing_attach(BdrvChild *c)
@@ -1152,6 +1161,7 @@ const BdrvChildRole child_backing =3D {
     .drained_end     =3D bdrv_child_cb_drained_end,
     .inactivate      =3D bdrv_child_cb_inactivate,
     .update_filename =3D bdrv_backing_update_filename,
+    .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
 };
=20
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
@@ -5751,6 +5761,88 @@ void bdrv_set_aio_context(BlockDriverState *bs, Ai=
oContext *new_context)
     aio_context_release(new_context);
 }
=20
+static bool bdrv_parent_can_set_aio_context(BdrvChild *c, AioContext *ct=
x,
+                                            GSList **ignore, Error **err=
p)
+{
+    if (g_slist_find(*ignore, c)) {
+        return true;
+    }
+    *ignore =3D g_slist_prepend(*ignore, c);
+
+    /* A BdrvChildRole that doesn't handle AioContext changes cannot
+     * tolerate any AioContext changes */
+    if (!c->role->can_set_aio_ctx) {
+        char *user =3D bdrv_child_user_desc(c);
+        error_setg(errp, "Changing iothreads is not supported by %s", us=
er);
+        g_free(user);
+        return false;
+    }
+    if (!c->role->can_set_aio_ctx(c, ctx, ignore, errp)) {
+        assert(!errp || *errp);
+        return false;
+    }
+    return true;
+}
+
+bool bdrv_child_can_set_aio_context(BdrvChild *c, AioContext *ctx,
+                                    GSList **ignore, Error **errp)
+{
+    if (g_slist_find(*ignore, c)) {
+        return true;
+    }
+    *ignore =3D g_slist_prepend(*ignore, c);
+    return bdrv_can_set_aio_context(c->bs, ctx, ignore, errp);
+}
+
+/* @ignore will accumulate all visited BdrvChild object. The caller is
+ * responsible for freeing the list afterwards. */
+bool bdrv_can_set_aio_context(BlockDriverState *bs, AioContext *ctx,
+                              GSList **ignore, Error **errp)
+{
+    BdrvChild *c;
+
+    if (bdrv_get_aio_context(bs) =3D=3D ctx) {
+        return true;
+    }
+
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        if (!bdrv_parent_can_set_aio_context(c, ctx, ignore, errp)) {
+            return false;
+        }
+    }
+    QLIST_FOREACH(c, &bs->children, next) {
+        if (!bdrv_child_can_set_aio_context(c, ctx, ignore, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+int bdrv_child_try_set_aio_context(BlockDriverState *bs, AioContext *ctx=
,
+                                   BdrvChild *ignore_child, Error **errp=
)
+{
+    GSList *ignore;
+    bool ret;
+
+    ignore =3D ignore_child ? g_slist_prepend(NULL, ignore_child) : NULL=
;
+    ret =3D bdrv_can_set_aio_context(bs, ctx, &ignore, errp);
+    g_slist_free(ignore);
+
+    if (!ret) {
+        return -EPERM;
+    }
+
+    bdrv_set_aio_context(bs, ctx);
+    return 0;
+}
+
+int bdrv_try_set_aio_context(BlockDriverState *bs, AioContext *ctx,
+                             Error **errp)
+{
+    return bdrv_child_try_set_aio_context(bs, ctx, NULL, errp);
+}
+
 void bdrv_add_aio_context_notifier(BlockDriverState *bs,
         void (*attached_aio_context)(AioContext *new_context, void *opaq=
ue),
         void (*detach_aio_context)(void *opaque), void *opaque)
--=20
2.20.1


