Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B667C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0347920830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0347920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhIG-00075G-5l
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:20:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFt-0005Wg-QW
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFs-0004uq-G6
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFp-0004rR-M8; Mon, 06 May 2019 13:18:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0550D300181F;
	Mon,  6 May 2019 17:18:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C20A11001DC1;
	Mon,  6 May 2019 17:18:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:17:59 +0200
Message-Id: <20190506171805.14236-5-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 06 May 2019 17:18:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 04/10] block: Propagate AioContext change to
 parents
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

All block nodes and users in any connected component of the block graph
must be in the same AioContext, so changing the AioContext of one node
must not only change all of its children, but all of its parents (and
in turn their children etc.) as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  2 ++
 include/block/block_int.h |  1 +
 block.c                   | 48 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 649aa5b86d..b72110f315 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -590,6 +590,8 @@ void bdrv_coroutine_enter(BlockDriverState *bs, Corou=
tine *co);
  * This function must be called with iothread lock held.
  */
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)=
;
+void bdrv_set_aio_context_ignore(BlockDriverState *bs,
+                                 AioContext *new_context, GSList **ignor=
e);
 int bdrv_try_set_aio_context(BlockDriverState *bs, AioContext *ctx,
                              Error **errp);
 int bdrv_child_try_set_aio_context(BlockDriverState *bs, AioContext *ctx=
,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index aa2c638b02..1eebc7c8f3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -694,6 +694,7 @@ struct BdrvChildRole {
=20
     bool (*can_set_aio_ctx)(BdrvChild *child, AioContext *ctx,
                             GSList **ignore, Error **errp);
+    void (*set_aio_ctx)(BdrvChild *child, AioContext *ctx, GSList **igno=
re);
 };
=20
 extern const BdrvChildRole child_file;
diff --git a/block.c b/block.c
index e36c72e297..b8bd20a234 100644
--- a/block.c
+++ b/block.c
@@ -943,6 +943,13 @@ static bool bdrv_child_cb_can_set_aio_ctx(BdrvChild =
*child, AioContext *ctx,
     return bdrv_can_set_aio_context(bs, ctx, ignore, errp);
 }
=20
+static void bdrv_child_cb_set_aio_ctx(BdrvChild *child, AioContext *ctx,
+                                      GSList **ignore)
+{
+    BlockDriverState *bs =3D child->opaque;
+    return bdrv_set_aio_context_ignore(bs, ctx, ignore);
+}
+
 /*
  * Returns the options and flags that a temporary snapshot should get, b=
ased on
  * the originally requested flags (the originally requested image will h=
ave
@@ -1011,6 +1018,7 @@ const BdrvChildRole child_file =3D {
     .detach          =3D bdrv_child_cb_detach,
     .inactivate      =3D bdrv_child_cb_inactivate,
     .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
+    .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
 };
=20
 /*
@@ -1038,6 +1046,7 @@ const BdrvChildRole child_format =3D {
     .detach          =3D bdrv_child_cb_detach,
     .inactivate      =3D bdrv_child_cb_inactivate,
     .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
+    .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
 };
=20
 static void bdrv_backing_attach(BdrvChild *c)
@@ -1162,6 +1171,7 @@ const BdrvChildRole child_backing =3D {
     .inactivate      =3D bdrv_child_cb_inactivate,
     .update_filename =3D bdrv_backing_update_filename,
     .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
+    .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
 };
=20
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
@@ -5732,10 +5742,10 @@ static void bdrv_attach_aio_context(BlockDriverSt=
ate *bs,
     bs->walking_aio_notifiers =3D false;
 }
=20
-/* The caller must own the AioContext lock for the old AioContext of bs,=
 but it
- * must not own the AioContext lock for new_context (unless new_context =
is
- * the same as the current context of bs). */
-void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
+/* @ignore will accumulate all visited BdrvChild object. The caller is
+ * responsible for freeing the list afterwards. */
+void bdrv_set_aio_context_ignore(BlockDriverState *bs,
+                                 AioContext *new_context, GSList **ignor=
e)
 {
     BdrvChild *child;
=20
@@ -5746,7 +5756,20 @@ void bdrv_set_aio_context(BlockDriverState *bs, Ai=
oContext *new_context)
     bdrv_drained_begin(bs);
=20
     QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_set_aio_context(child->bs, new_context);
+        if (g_slist_find(*ignore, child)) {
+            continue;
+        }
+        *ignore =3D g_slist_prepend(*ignore, child);
+        bdrv_set_aio_context_ignore(child->bs, new_context, ignore);
+    }
+    QLIST_FOREACH(child, &bs->parents, next_parent) {
+        if (g_slist_find(*ignore, child)) {
+            continue;
+        }
+        if (child->role->set_aio_ctx) {
+            *ignore =3D g_slist_prepend(*ignore, child);
+            child->role->set_aio_ctx(child, new_context, ignore);
+        }
     }
=20
     bdrv_detach_aio_context(bs);
@@ -5760,6 +5783,16 @@ void bdrv_set_aio_context(BlockDriverState *bs, Ai=
oContext *new_context)
     aio_context_release(new_context);
 }
=20
+/* The caller must own the AioContext lock for the old AioContext of bs,=
 but it
+ * must not own the AioContext lock for new_context (unless new_context =
is
+ * the same as the current context of bs). */
+void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
+{
+    GSList *ignore_list =3D NULL;
+    bdrv_set_aio_context_ignore(bs, new_context, &ignore_list);
+    g_slist_free(ignore_list);
+}
+
 static bool bdrv_parent_can_set_aio_context(BdrvChild *c, AioContext *ct=
x,
                                             GSList **ignore, Error **err=
p)
 {
@@ -5832,7 +5865,10 @@ int bdrv_child_try_set_aio_context(BlockDriverStat=
e *bs, AioContext *ctx,
         return -EPERM;
     }
=20
-    bdrv_set_aio_context(bs, ctx);
+    ignore =3D ignore_child ? g_slist_prepend(NULL, ignore_child) : NULL=
;
+    bdrv_set_aio_context_ignore(bs, ctx, &ignore);
+    g_slist_free(ignore);
+
     return 0;
 }
=20
--=20
2.20.1


