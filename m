Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9838C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F922068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZpPlhEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F922068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxJE-00019g-6o
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBP-0003qE-3K
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBJ-00062c-TU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBJ-00061m-5S
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFHnlzhNg1W8tMibBoOHLw1tQlTnHz3KOex9VgFDNrI=;
 b=LZpPlhEUvt5ZJd8oG4Q1UcSDpGi+uv0G3xp0QkT9qJfz5Q5yyf+ctvDWUbQerJqDjYd3Ew
 jI5yAgq7p7RG7Ld5nBocM812UIuQwSffs95pg0Mfn2XP5PMVh6rfA8vfqqyv1Xw8hPEKju
 0IyH1sQHVlaclE2RJ6XFIik+qznqq2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-mVNS5YR1PbSP__xlrXrIDw-1; Wed, 27 Nov 2019 08:16:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91FA3B15E5;
 Wed, 27 Nov 2019 13:16:29 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F9BF5D6A7;
 Wed, 27 Nov 2019 13:16:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 01/31] block: Rename BdrvChildRole to BdrvChildClass
Date: Wed, 27 Nov 2019 14:15:54 +0100
Message-Id: <20191127131624.1062403-2-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mVNS5YR1PbSP__xlrXrIDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This structure nearly only contains parent callbacks for child state
changes.  It cannot really reflect a child's role, because different
roles may overlap (as we will see when real roles are introduced), and
because parents can have custom callbacks even when the child fulfills a
standard role.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                     | 142 ++++++++++++++++++------------------
 block/backup-top.c          |   8 +-
 block/blkdebug.c            |   4 +-
 block/blklogwrites.c        |   8 +-
 block/block-backend.c       |   6 +-
 block/commit.c              |   2 +-
 block/copy-on-read.c        |   2 +-
 block/io.c                  |  22 +++---
 block/mirror.c              |   2 +-
 block/quorum.c              |   2 +-
 block/replication.c         |   2 +-
 block/vvfat.c               |   6 +-
 blockjob.c                  |   2 +-
 include/block/block.h       |   6 +-
 include/block/block_int.h   |  22 +++---
 tests/test-bdrv-drain.c     |  36 ++++-----
 tests/test-bdrv-graph-mod.c |   2 +-
 17 files changed, 141 insertions(+), 133 deletions(-)

diff --git a/block.c b/block.c
index 36015f1b7b..7c16cf2fe6 100644
--- a/block.c
+++ b/block.c
@@ -76,7 +76,7 @@ static BlockDriverState *bdrv_open_inherit(const char *fi=
lename,
                                            const char *reference,
                                            QDict *options, int flags,
                                            BlockDriverState *parent,
-                                           const BdrvChildRole *child_role=
,
+                                           const BdrvChildClass *child_cla=
ss,
                                            Error **errp);
=20
 /* If non-zero, use only whitelisted block drivers */
@@ -1009,7 +1009,7 @@ static void bdrv_inherited_options(int *child_flags, =
QDict *child_options,
     *child_flags =3D flags;
 }
=20
-const BdrvChildRole child_file =3D {
+const BdrvChildClass child_file =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .inherit_options =3D bdrv_inherited_options,
@@ -1037,7 +1037,7 @@ static void bdrv_inherited_fmt_options(int *child_fla=
gs, QDict *child_options,
     *child_flags &=3D ~(BDRV_O_PROTOCOL | BDRV_O_NO_IO);
 }
=20
-const BdrvChildRole child_format =3D {
+const BdrvChildClass child_format =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .inherit_options =3D bdrv_inherited_fmt_options,
@@ -1161,7 +1161,7 @@ static int bdrv_backing_update_filename(BdrvChild *c,=
 BlockDriverState *base,
     return ret;
 }
=20
-const BdrvChildRole child_backing =3D {
+const BdrvChildClass child_backing =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .attach          =3D bdrv_backing_attach,
@@ -1763,13 +1763,13 @@ bool bdrv_is_writable(BlockDriverState *bs)
 }
=20
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_=
bs,
-                            BdrvChild *c, const BdrvChildRole *role,
+                            BdrvChild *c, const BdrvChildClass *child_clas=
s,
                             BlockReopenQueue *reopen_queue,
                             uint64_t parent_perm, uint64_t parent_shared,
                             uint64_t *nperm, uint64_t *nshared)
 {
     assert(bs->drv && bs->drv->bdrv_child_perm);
-    bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
+    bs->drv->bdrv_child_perm(bs, c, child_class, reopen_queue,
                              parent_perm, parent_shared,
                              nperm, nshared);
     /* TODO Take force_share from reopen_queue */
@@ -1863,7 +1863,7 @@ static int bdrv_check_perm(BlockDriverState *bs, Bloc=
kReopenQueue *q,
         uint64_t cur_perm, cur_shared;
         bool child_tighten_restr;
=20
-        bdrv_child_perm(bs, c->bs, c, c->role, q,
+        bdrv_child_perm(bs, c->bs, c, c->klass, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret =3D bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore_c=
hildren,
@@ -1930,7 +1930,7 @@ static void bdrv_set_perm(BlockDriverState *bs, uint6=
4_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
+        bdrv_child_perm(bs, c->bs, c, c->klass, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
@@ -1955,8 +1955,8 @@ static void bdrv_get_cumulative_perm(BlockDriverState=
 *bs, uint64_t *perm,
=20
 static char *bdrv_child_user_desc(BdrvChild *c)
 {
-    if (c->role->get_parent_desc) {
-        return c->role->get_parent_desc(c);
+    if (c->klass->get_parent_desc) {
+        return c->klass->get_parent_desc(c);
     }
=20
     return g_strdup("another user");
@@ -2157,14 +2157,14 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, =
BdrvChild *c, Error **errp)
     uint64_t perms, shared;
=20
     bdrv_get_cumulative_perm(bs, &parent_perms, &parent_shared);
-    bdrv_child_perm(bs, c->bs, c, c->role, NULL, parent_perms, parent_shar=
ed,
+    bdrv_child_perm(bs, c->bs, c, c->klass, NULL, parent_perms, parent_sha=
red,
                     &perms, &shared);
=20
     return bdrv_child_try_set_perm(c, perms, shared, errp);
 }
=20
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
@@ -2174,21 +2174,21 @@ void bdrv_filter_default_perms(BlockDriverState *bs=
, BdrvChild *c,
 }
=20
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
 {
-    bool backing =3D (role =3D=3D &child_backing);
-    assert(role =3D=3D &child_backing || role =3D=3D &child_file);
+    bool backing =3D (child_class =3D=3D &child_backing);
+    assert(child_class =3D=3D &child_backing || child_class =3D=3D &child_=
file);
=20
     if (!backing) {
         int flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
=20
         /* Apart from the modifications below, the same permissions are
          * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
-                                  &perm, &shared);
+        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+                                  perm, shared, &perm, &shared);
=20
         /* Format drivers may touch metadata even if the guest doesn't wri=
te */
         if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
@@ -2265,7 +2265,7 @@ static void bdrv_replace_child_noperm(BdrvChild *chil=
d,
      * If the new child node is drained but the old one was not, flush
      * all outstanding requests to the old child node.
      */
-    while (drain_saldo > 0 && child->role->drained_begin) {
+    while (drain_saldo > 0 && child->klass->drained_begin) {
         bdrv_parent_drained_begin_single(child, true);
         drain_saldo--;
     }
@@ -2274,8 +2274,8 @@ static void bdrv_replace_child_noperm(BdrvChild *chil=
d,
         /* Detach first so that the recursive drain sections coming from @=
child
          * are already gone and we only end the drain sections that came f=
rom
          * elsewhere. */
-        if (child->role->detach) {
-            child->role->detach(child);
+        if (child->klass->detach) {
+            child->klass->detach(child);
         }
         QLIST_REMOVE(child, next_parent);
     }
@@ -2297,8 +2297,8 @@ static void bdrv_replace_child_noperm(BdrvChild *chil=
d,
         /* Attach only after starting new drained sections, so that recurs=
ive
          * drain sections coming from @child don't get an extra .drained_b=
egin
          * callback. */
-        if (child->role->attach) {
-            child->role->attach(child);
+        if (child->klass->attach) {
+            child->klass->attach(child);
         }
     }
=20
@@ -2306,7 +2306,7 @@ static void bdrv_replace_child_noperm(BdrvChild *chil=
d,
      * If the old child node was drained but the new one is not, allow
      * requests to come in only after the new node has been attached.
      */
-    while (drain_saldo < 0 && child->role->drained_end) {
+    while (drain_saldo < 0 && child->klass->drained_end) {
         bdrv_parent_drained_end_single(child);
         drain_saldo++;
     }
@@ -2379,7 +2379,7 @@ static void bdrv_replace_child(BdrvChild *child, Bloc=
kDriverState *new_bs)
  */
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
-                                  const BdrvChildRole *child_role,
+                                  const BdrvChildClass *child_class,
                                   AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp)
@@ -2400,7 +2400,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *c=
hild_bs,
     *child =3D (BdrvChild) {
         .bs             =3D NULL,
         .name           =3D g_strdup(child_name),
-        .role           =3D child_role,
+        .klass          =3D child_class,
         .perm           =3D perm,
         .shared_perm    =3D shared_perm,
         .opaque         =3D opaque,
@@ -2411,15 +2411,15 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
*child_bs,
      * try moving the parent into the AioContext of child_bs instead. */
     if (bdrv_get_aio_context(child_bs) !=3D ctx) {
         ret =3D bdrv_try_set_aio_context(child_bs, ctx, &local_err);
-        if (ret < 0 && child_role->can_set_aio_ctx) {
+        if (ret < 0 && child_class->can_set_aio_ctx) {
             GSList *ignore =3D g_slist_prepend(NULL, child);;
             ctx =3D bdrv_get_aio_context(child_bs);
-            if (child_role->can_set_aio_ctx(child, ctx, &ignore, NULL)) {
+            if (child_class->can_set_aio_ctx(child, ctx, &ignore, NULL)) {
                 error_free(local_err);
                 ret =3D 0;
                 g_slist_free(ignore);
                 ignore =3D g_slist_prepend(NULL, child);;
-                child_role->set_aio_ctx(child, ctx, &ignore);
+                child_class->set_aio_ctx(child, ctx, &ignore);
             }
             g_slist_free(ignore);
         }
@@ -2451,7 +2451,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *c=
hild_bs,
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
-                             const BdrvChildRole *child_role,
+                             const BdrvChildClass *child_class,
                              Error **errp)
 {
     BdrvChild *child;
@@ -2460,10 +2460,10 @@ BdrvChild *bdrv_attach_child(BlockDriverState *pare=
nt_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
=20
     assert(parent_bs->drv);
-    bdrv_child_perm(parent_bs, child_bs, NULL, child_role, NULL,
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, NULL,
                     perm, shared_perm, &perm, &shared_perm);
=20
-    child =3D bdrv_root_attach_child(child_bs, child_name, child_role,
+    child =3D bdrv_root_attach_child(child_bs, child_name, child_class,
                                    bdrv_get_aio_context(parent_bs),
                                    perm, shared_perm, parent_bs, errp);
     if (child =3D=3D NULL) {
@@ -2539,8 +2539,8 @@ static void bdrv_parent_cb_change_media(BlockDriverSt=
ate *bs, bool load)
 {
     BdrvChild *c;
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->change_media) {
-            c->role->change_media(c, load);
+        if (c->klass->change_media) {
+            c->klass->change_media(c, load);
         }
     }
 }
@@ -2716,7 +2716,7 @@ free_exit:
=20
 static BlockDriverState *
 bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref=
_key,
-                   BlockDriverState *parent, const BdrvChildRole *child_ro=
le,
+                   BlockDriverState *parent, const BdrvChildClass *child_c=
lass,
                    bool allow_none, Error **errp)
 {
     BlockDriverState *bs =3D NULL;
@@ -2724,7 +2724,7 @@ bdrv_open_child_bs(const char *filename, QDict *optio=
ns, const char *bdref_key,
     char *bdref_key_dot;
     const char *reference;
=20
-    assert(child_role !=3D NULL);
+    assert(child_class !=3D NULL);
=20
     bdref_key_dot =3D g_strdup_printf("%s.", bdref_key);
     qdict_extract_subqdict(options, &image_options, bdref_key_dot);
@@ -2748,7 +2748,7 @@ bdrv_open_child_bs(const char *filename, QDict *optio=
ns, const char *bdref_key,
     }
=20
     bs =3D bdrv_open_inherit(filename, reference, image_options, 0,
-                           parent, child_role, errp);
+                           parent, child_class, errp);
     if (!bs) {
         goto done;
     }
@@ -2775,22 +2775,24 @@ done:
 BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
                            BlockDriverState *parent,
-                           const BdrvChildRole *child_role,
+                           const BdrvChildClass *child_class,
                            bool allow_none, Error **errp)
 {
     BlockDriverState *bs;
=20
-    bs =3D bdrv_open_child_bs(filename, options, bdref_key, parent, child_=
role,
+    bs =3D bdrv_open_child_bs(filename, options, bdref_key, parent, child_=
class,
                             allow_none, errp);
     if (bs =3D=3D NULL) {
         return NULL;
     }
=20
-    return bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
+    return bdrv_attach_child(parent, bs, bdref_key, child_class, errp);
 }
=20
-/* TODO Future callers may need to specify parent/child_role in order for
- * option inheritance to work. Existing callers use it for the root node. =
*/
+/*
+ * TODO Future callers may need to specify parent/child_class in order for
+ * option inheritance to work. Existing callers use it for the root node.
+ */
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
 {
     BlockDriverState *bs =3D NULL;
@@ -2925,7 +2927,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                                            const char *reference,
                                            QDict *options, int flags,
                                            BlockDriverState *parent,
-                                           const BdrvChildRole *child_role=
,
+                                           const BdrvChildClass *child_cla=
ss,
                                            Error **errp)
 {
     int ret;
@@ -2939,8 +2941,8 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
     QDict *snapshot_options =3D NULL;
     int snapshot_flags =3D 0;
=20
-    assert(!child_role || !flags);
-    assert(!child_role =3D=3D !parent);
+    assert(!child_class || !flags);
+    assert(!child_class =3D=3D !parent);
=20
     if (reference) {
         bool options_non_empty =3D options ? qdict_size(options) : false;
@@ -2976,10 +2978,10 @@ static BlockDriverState *bdrv_open_inherit(const ch=
ar *filename,
=20
     bs->explicit_options =3D qdict_clone_shallow(options);
=20
-    if (child_role) {
+    if (child_class) {
         bs->inherits_from =3D parent;
-        child_role->inherit_options(&flags, options,
-                                    parent->open_flags, parent->options);
+        child_class->inherit_options(&flags, options,
+                                     parent->open_flags, parent->options);
     }
=20
     ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
@@ -3290,7 +3292,7 @@ static bool bdrv_recurse_has_child(BlockDriverState *=
bs,
 static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queu=
e,
                                                  BlockDriverState *bs,
                                                  QDict *options,
-                                                 const BdrvChildRole *role=
,
+                                                 const BdrvChildClass *kla=
ss,
                                                  QDict *parent_options,
                                                  int parent_flags,
                                                  bool keep_old_opts)
@@ -3346,7 +3348,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
     /* Inherit from parent node */
     if (parent_options) {
         flags =3D 0;
-        role->inherit_options(&flags, options, parent_flags, parent_option=
s);
+        klass->inherit_options(&flags, options, parent_flags, parent_optio=
ns);
     } else {
         flags =3D bdrv_get_flags(bs);
     }
@@ -3437,7 +3439,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bloc=
kReopenQueue *bs_queue,
         }
=20
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
-                                child->role, options, flags, child_keep_ol=
d);
+                                child->klass, options, flags, child_keep_o=
ld);
     }
=20
     return bs_queue;
@@ -3608,7 +3610,7 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, Blo=
ckDriverState *bs,
         } else {
             uint64_t nperm, nshared;
=20
-            bdrv_child_perm(parent->state.bs, bs, c, c->role, q,
+            bdrv_child_perm(parent->state.bs, bs, c, c->klass, q,
                             parent->state.perm, parent->state.shared_perm,
                             &nperm, &nshared);
=20
@@ -4094,7 +4096,7 @@ static bool should_update_child(BdrvChild *c, BlockDr=
iverState *to)
     GHashTable *found;
     bool ret;
=20
-    if (c->role->stay_at_node) {
+    if (c->klass->stay_at_node) {
         return false;
     }
=20
@@ -4564,9 +4566,9 @@ int bdrv_drop_intermediate(BlockDriverState *top, Blo=
ckDriverState *base,
         }
=20
         /* If so, update the backing file path in the image file */
-        if (c->role->update_filename) {
-            ret =3D c->role->update_filename(c, base, backing_file_str,
-                                           &local_err);
+        if (c->klass->update_filename) {
+            ret =3D c->klass->update_filename(c, base, backing_file_str,
+                                            &local_err);
             if (ret < 0) {
                 bdrv_abort_perm_update(base);
                 error_report_err(local_err);
@@ -5013,8 +5015,8 @@ const char *bdrv_get_parent_name(const BlockDriverSta=
te *bs)
=20
     /* If multiple parents have a name, just pick the first one. */
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->get_name) {
-            name =3D c->role->get_name(c);
+        if (c->klass->get_name) {
+            name =3D c->klass->get_name(c);
             if (name && *name) {
                 return name;
             }
@@ -5396,8 +5398,8 @@ static void coroutine_fn bdrv_co_invalidate_cache(Blo=
ckDriverState *bs,
     }
=20
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
-        if (parent->role->activate) {
-            parent->role->activate(parent, &local_err);
+        if (parent->klass->activate) {
+            parent->klass->activate(parent, &local_err);
             if (local_err) {
                 bs->open_flags |=3D BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
@@ -5465,7 +5467,7 @@ static bool bdrv_has_bds_parent(BlockDriverState *bs,=
 bool only_active)
     BdrvChild *parent;
=20
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
-        if (parent->role->parent_is_bds) {
+        if (parent->klass->parent_is_bds) {
             BlockDriverState *parent_bs =3D parent->opaque;
             if (!only_active || !(parent_bs->open_flags & BDRV_O_INACTIVE)=
) {
                 return true;
@@ -5504,8 +5506,8 @@ static int bdrv_inactivate_recurse(BlockDriverState *=
bs)
     }
=20
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
-        if (parent->role->inactivate) {
-            ret =3D parent->role->inactivate(parent);
+        if (parent->klass->inactivate) {
+            ret =3D parent->klass->inactivate(parent);
             if (ret < 0) {
                 return ret;
             }
@@ -5999,9 +6001,9 @@ void bdrv_set_aio_context_ignore(BlockDriverState *bs=
,
         if (g_slist_find(*ignore, child)) {
             continue;
         }
-        assert(child->role->set_aio_ctx);
+        assert(child->klass->set_aio_ctx);
         *ignore =3D g_slist_prepend(*ignore, child);
-        child->role->set_aio_ctx(child, new_context, ignore);
+        child->klass->set_aio_ctx(child, new_context, ignore);
     }
=20
     bdrv_detach_aio_context(bs);
@@ -6041,15 +6043,17 @@ static bool bdrv_parent_can_set_aio_context(BdrvChi=
ld *c, AioContext *ctx,
     }
     *ignore =3D g_slist_prepend(*ignore, c);
=20
-    /* A BdrvChildRole that doesn't handle AioContext changes cannot
-     * tolerate any AioContext changes */
-    if (!c->role->can_set_aio_ctx) {
+    /*
+     * A BdrvChildClass that doesn't handle AioContext changes cannot
+     * tolerate any AioContext changes
+     */
+    if (!c->klass->can_set_aio_ctx) {
         char *user =3D bdrv_child_user_desc(c);
         error_setg(errp, "Changing iothreads is not supported by %s", user=
);
         g_free(user);
         return false;
     }
-    if (!c->role->can_set_aio_ctx(c, ctx, ignore, errp)) {
+    if (!c->klass->can_set_aio_ctx(c, ctx, ignore, errp)) {
         assert(!errp || *errp);
         return false;
     }
@@ -6464,7 +6468,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         drv->bdrv_gather_child_options(bs, opts, backing_overridden);
     } else {
         QLIST_FOREACH(child, &bs->children, next) {
-            if (child->role =3D=3D &child_backing && !backing_overridden) =
{
+            if (child->klass =3D=3D &child_backing && !backing_overridden)=
 {
                 /* We can skip the backing BDS if it has not been overridd=
en */
                 continue;
             }
diff --git a/block/backup-top.c b/block/backup-top.c
index 7cdb1f8eba..e2ded7f570 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -117,7 +117,7 @@ static void backup_top_refresh_filename(BlockDriverStat=
e *bs)
 }
=20
 static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                  const BdrvChildRole *role,
+                                  const BdrvChildClass *child_class,
                                   BlockReopenQueue *reopen_queue,
                                   uint64_t perm, uint64_t shared,
                                   uint64_t *nperm, uint64_t *nshared)
@@ -137,7 +137,7 @@ static void backup_top_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
         return;
     }
=20
-    if (role =3D=3D &child_file) {
+    if (child_class =3D=3D &child_file) {
         /*
          * Target child
          *
@@ -148,8 +148,8 @@ static void backup_top_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
         *nperm =3D BLK_PERM_WRITE;
     } else {
         /* Source child */
-        bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
-                                  nperm, nshared);
+        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+                                  perm, shared, nperm, nshared);
=20
         if (perm & BLK_PERM_WRITE) {
             *nperm =3D *nperm | BLK_PERM_CONSISTENT_READ;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index af44aa973f..f369d54ee4 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -993,14 +993,14 @@ static int blkdebug_reopen_prepare(BDRVReopenState *r=
eopen_state,
 }
=20
 static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                const BdrvChildRole *role,
+                                const BdrvChildClass *child_class,
                                 BlockReopenQueue *reopen_queue,
                                 uint64_t perm, uint64_t shared,
                                 uint64_t *nperm, uint64_t *nshared)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
=20
-    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
+    bdrv_filter_default_perms(bs, c, child_class, reopen_queue, perm, shar=
ed,
                               nperm, nshared);
=20
     *nperm |=3D s->take_child_perms;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 04d8b33607..f3b3259d8d 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -282,7 +282,7 @@ static int64_t blk_log_writes_getlength(BlockDriverStat=
e *bs)
 }
=20
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                      const BdrvChildRole *role,
+                                      const BdrvChildClass *child_class,
                                       BlockReopenQueue *ro_q,
                                       uint64_t perm, uint64_t shrd,
                                       uint64_t *nperm, uint64_t *nshrd)
@@ -294,9 +294,11 @@ static void blk_log_writes_child_perm(BlockDriverState=
 *bs, BdrvChild *c,
     }
=20
     if (!strcmp(c->name, "log")) {
-        bdrv_format_default_perms(bs, c, role, ro_q, perm, shrd, nperm, ns=
hrd);
+        bdrv_format_default_perms(bs, c, child_class, ro_q, perm, shrd, np=
erm,
+                                  nshrd);
     } else {
-        bdrv_filter_default_perms(bs, c, role, ro_q, perm, shrd, nperm, ns=
hrd);
+        bdrv_filter_default_perms(bs, c, child_class, ro_q, perm, shrd, np=
erm,
+                                  nshrd);
     }
 }
=20
diff --git a/block/block-backend.c b/block/block-backend.c
index 8b8f2a80a0..3d7e96e0d4 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -297,7 +297,7 @@ static void blk_root_detach(BdrvChild *child)
     }
 }
=20
-static const BdrvChildRole child_root =3D {
+static const BdrvChildClass child_root =3D {
     .inherit_options    =3D blk_root_inherit_options,
=20
     .change_media       =3D blk_root_change_media,
@@ -693,7 +693,7 @@ static BlockBackend *bdrv_first_blk(BlockDriverState *b=
s)
 {
     BdrvChild *child;
     QLIST_FOREACH(child, &bs->parents, next_parent) {
-        if (child->role =3D=3D &child_root) {
+        if (child->klass =3D=3D &child_root) {
             return child->opaque;
         }
     }
@@ -717,7 +717,7 @@ bool bdrv_is_root_node(BlockDriverState *bs)
     BdrvChild *c;
=20
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role !=3D &child_root) {
+        if (c->klass !=3D &child_root) {
             return false;
         }
     }
diff --git a/block/commit.c b/block/commit.c
index 23c90b3b91..f2ccb11874 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -236,7 +236,7 @@ static void bdrv_commit_top_refresh_filename(BlockDrive=
rState *bs)
 }
=20
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildRole *role,
+                                       const BdrvChildClass *child_class,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 242d3ff055..7504ca6ffc 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -51,7 +51,7 @@ static int cor_open(BlockDriverState *bs, QDict *options,=
 int flags,
 #define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
=20
 static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
-                           const BdrvChildRole *role,
+                           const BdrvChildClass *child_class,
                            BlockReopenQueue *reopen_queue,
                            uint64_t perm, uint64_t shared,
                            uint64_t *nperm, uint64_t *nshared)
diff --git a/block/io.c b/block/io.c
index f75777f5ea..8b2a0c2d12 100644
--- a/block/io.c
+++ b/block/io.c
@@ -50,7 +50,7 @@ static void bdrv_parent_drained_begin(BlockDriverState *b=
s, BdrvChild *ignore,
     BdrvChild *c, *next;
=20
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is_b=
ds)) {
+        if (c =3D=3D ignore || (ignore_bds_parents && c->klass->parent_is_=
bds)) {
             continue;
         }
         bdrv_parent_drained_begin_single(c, false);
@@ -62,8 +62,8 @@ static void bdrv_parent_drained_end_single_no_poll(BdrvCh=
ild *c,
 {
     assert(c->parent_quiesce_counter > 0);
     c->parent_quiesce_counter--;
-    if (c->role->drained_end) {
-        c->role->drained_end(c, drained_end_counter);
+    if (c->klass->drained_end) {
+        c->klass->drained_end(c, drained_end_counter);
     }
 }
=20
@@ -81,7 +81,7 @@ static void bdrv_parent_drained_end(BlockDriverState *bs,=
 BdrvChild *ignore,
     BdrvChild *c;
=20
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is_b=
ds)) {
+        if (c =3D=3D ignore || (ignore_bds_parents && c->klass->parent_is_=
bds)) {
             continue;
         }
         bdrv_parent_drained_end_single_no_poll(c, drained_end_counter);
@@ -90,8 +90,8 @@ static void bdrv_parent_drained_end(BlockDriverState *bs,=
 BdrvChild *ignore,
=20
 static bool bdrv_parent_drained_poll_single(BdrvChild *c)
 {
-    if (c->role->drained_poll) {
-        return c->role->drained_poll(c);
+    if (c->klass->drained_poll) {
+        return c->klass->drained_poll(c);
     }
     return false;
 }
@@ -103,7 +103,7 @@ static bool bdrv_parent_drained_poll(BlockDriverState *=
bs, BdrvChild *ignore,
     bool busy =3D false;
=20
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is_b=
ds)) {
+        if (c =3D=3D ignore || (ignore_bds_parents && c->klass->parent_is_=
bds)) {
             continue;
         }
         busy |=3D bdrv_parent_drained_poll_single(c);
@@ -115,8 +115,8 @@ static bool bdrv_parent_drained_poll(BlockDriverState *=
bs, BdrvChild *ignore,
 void bdrv_parent_drained_begin_single(BdrvChild *c, bool poll)
 {
     c->parent_quiesce_counter++;
-    if (c->role->drained_begin) {
-        c->role->drained_begin(c);
+    if (c->klass->drained_begin) {
+        c->klass->drained_begin(c);
     }
     if (poll) {
         BDRV_POLL_WHILE(c->bs, bdrv_parent_drained_poll_single(c));
@@ -3301,8 +3301,8 @@ static void bdrv_parent_cb_resize(BlockDriverState *b=
s)
 {
     BdrvChild *c;
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->resize) {
-            c->role->resize(c);
+        if (c->klass->resize) {
+            c->klass->resize(c);
         }
     }
 }
diff --git a/block/mirror.c b/block/mirror.c
index b258c7e98b..22930a9c30 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1496,7 +1496,7 @@ static void bdrv_mirror_top_refresh_filename(BlockDri=
verState *bs)
 }
=20
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildRole *role,
+                                       const BdrvChildClass *child_class,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/quorum.c b/block/quorum.c
index 8cd13a7b91..954e68caaa 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1174,7 +1174,7 @@ static char *quorum_dirname(BlockDriverState *bs, Err=
or **errp)
 }
=20
 static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
-                              const BdrvChildRole *role,
+                              const BdrvChildClass *child_class,
                               BlockReopenQueue *reopen_queue,
                               uint64_t perm, uint64_t shared,
                               uint64_t *nperm, uint64_t *nshared)
diff --git a/block/replication.c b/block/replication.c
index d6681b6c84..e268a6e5c5 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -160,7 +160,7 @@ static void replication_close(BlockDriverState *bs)
 }
=20
 static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                   const BdrvChildRole *role,
+                                   const BdrvChildClass *child_class,
                                    BlockReopenQueue *reopen_queue,
                                    uint64_t perm, uint64_t shared,
                                    uint64_t *nperm, uint64_t *nshared)
diff --git a/block/vvfat.c b/block/vvfat.c
index 019b8f1341..70f6985fbb 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3145,7 +3145,7 @@ static void vvfat_qcow_options(int *child_flags, QDic=
t *child_options,
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
 }
=20
-static const BdrvChildRole child_vvfat_qcow =3D {
+static const BdrvChildClass child_vvfat_qcow =3D {
     .parent_is_bds      =3D true,
     .inherit_options    =3D vvfat_qcow_options,
 };
@@ -3219,14 +3219,14 @@ err:
 }
=20
 static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildRole *role,
+                             const BdrvChildClass *child_class,
                              BlockReopenQueue *reopen_queue,
                              uint64_t perm, uint64_t shared,
                              uint64_t *nperm, uint64_t *nshared)
 {
     BDRVVVFATState *s =3D bs->opaque;
=20
-    assert(c =3D=3D s->qcow || role =3D=3D &child_backing);
+    assert(c =3D=3D s->qcow || child_class =3D=3D &child_backing);
=20
     if (c =3D=3D s->qcow) {
         /* This is a private node, nobody should try to attach to it */
diff --git a/blockjob.c b/blockjob.c
index c6e20e2fcd..b3a597b87e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -163,7 +163,7 @@ static void child_job_set_aio_ctx(BdrvChild *c, AioCont=
ext *ctx,
     job->job.aio_context =3D ctx;
 }
=20
-static const BdrvChildRole child_job =3D {
+static const BdrvChildClass child_job =3D {
     .get_parent_desc    =3D child_job_get_parent_desc,
     .drained_begin      =3D child_job_drained_begin,
     .drained_poll       =3D child_job_drained_poll,
diff --git a/include/block/block.h b/include/block/block.h
index 764a217de6..38963ef203 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -13,7 +13,7 @@
 /* block.c */
 typedef struct BlockDriver BlockDriver;
 typedef struct BdrvChild BdrvChild;
-typedef struct BdrvChildRole BdrvChildRole;
+typedef struct BdrvChildClass BdrvChildClass;
=20
 typedef struct BlockDriverInfo {
     /* in bytes, 0 if irrelevant */
@@ -305,7 +305,7 @@ int bdrv_parse_discard_flags(const char *mode, int *fla=
gs);
 BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
                            BlockDriverState* parent,
-                           const BdrvChildRole *child_role,
+                           const BdrvChildClass *child_class,
                            bool allow_none, Error **errp);
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_h=
d,
@@ -548,7 +548,7 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChi=
ld *child);
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
-                             const BdrvChildRole *child_role,
+                             const BdrvChildClass *child_class,
                              Error **errp);
=20
 bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp=
);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7064a1a4fa..0c57f76a71 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -549,14 +549,14 @@ struct BlockDriver {
      * the parents in @parent_perm and @parent_shared.
      *
      * If @c is NULL, return the permissions for attaching a new child for=
 the
-     * given @role.
+     * given @child_class.
      *
      * If @reopen_queue is non-NULL, don't return the currently needed
      * permissions, but those that will be needed after applying the
      * @reopen_queue.
      */
      void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildRole *role,
+                             const BdrvChildClass *child_class,
                              BlockReopenQueue *reopen_queue,
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
@@ -658,7 +658,7 @@ typedef struct BdrvAioNotifier {
     QLIST_ENTRY(BdrvAioNotifier) list;
 } BdrvAioNotifier;
=20
-struct BdrvChildRole {
+struct BdrvChildClass {
     /* If true, bdrv_replace_node() doesn't change the node this BdrvChild
      * points to. */
     bool stay_at_node;
@@ -731,14 +731,14 @@ struct BdrvChildRole {
     void (*set_aio_ctx)(BdrvChild *child, AioContext *ctx, GSList **ignore=
);
 };
=20
-extern const BdrvChildRole child_file;
-extern const BdrvChildRole child_format;
-extern const BdrvChildRole child_backing;
+extern const BdrvChildClass child_file;
+extern const BdrvChildClass child_format;
+extern const BdrvChildClass child_backing;
=20
 struct BdrvChild {
     BlockDriverState *bs;
     char *name;
-    const BdrvChildRole *role;
+    const BdrvChildClass *klass;
     void *opaque;
=20
     /**
@@ -765,7 +765,7 @@ struct BdrvChild {
=20
     /*
      * How many times the parent of this child has been drained
-     * (through role->drained_*).
+     * (through klass->drained_*).
      * Usually, this is equal to bs->quiesce_counter (potentially
      * reduced by bdrv_drain_all_count).  It may differ while the
      * child is entering or leaving a drained section.
@@ -1220,7 +1220,7 @@ void hmp_drive_add_node(Monitor *mon, const char *opt=
str);
=20
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
-                                  const BdrvChildRole *child_role,
+                                  const BdrvChildClass *child_class,
                                   AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp);
@@ -1248,7 +1248,7 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, Bd=
rvChild *c, Error **errp);
  * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RESI=
ZE to
  * all children */
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
@@ -1258,7 +1258,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, =
BdrvChild *c,
  * requires WRITE | RESIZE for read-write images, always requires
  * CONSISTENT_READ and doesn't share WRITE. */
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildRole *role,
+                               const BdrvChildClass *child_class,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index fa0e6a648b..9d683a6c11 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -86,18 +86,20 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriver=
State *bs,
 }
=20
 static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                 const BdrvChildRole *role,
+                                 const BdrvChildClass *child_class,
                                  BlockReopenQueue *reopen_queue,
                                  uint64_t perm, uint64_t shared,
                                  uint64_t *nperm, uint64_t *nshared)
 {
-    /* bdrv_format_default_perms() accepts only these two, so disguise
-     * detach_by_driver_cb_role as one of them. */
-    if (role !=3D &child_file && role !=3D &child_backing) {
-        role =3D &child_file;
+    /*
+     * bdrv_format_default_perms() accepts only these two, so disguise
+     * detach_by_driver_cb_parent as one of them.
+     */
+    if (child_class !=3D &child_file && child_class !=3D &child_backing) {
+        child_class =3D &child_file;
     }
=20
-    bdrv_format_default_perms(bs, c, role, reopen_queue, perm, shared,
+    bdrv_format_default_perms(bs, c, child_class, reopen_queue, perm, shar=
ed,
                               nperm, nshared);
 }
=20
@@ -1332,7 +1334,7 @@ static void detach_by_driver_cb_drained_begin(BdrvChi=
ld *child)
     child_file.drained_begin(child);
 }
=20
-static BdrvChildRole detach_by_driver_cb_role;
+static BdrvChildClass detach_by_driver_cb_class;
=20
 /*
  * Initial graph:
@@ -1349,7 +1351,7 @@ static BdrvChildRole detach_by_driver_cb_role;
  *
  * by_parent_cb =3D=3D false: Test that bdrv_drain_invoke() doesn't poll
  *
- *     PA's BdrvChildRole has a .drained_begin callback that schedules a B=
H
+ *     PA's BdrvChildClass has a .drained_begin callback that schedules a =
BH
  *     that does the same graph change. If bdrv_drain_invoke() calls it, t=
he
  *     state is messed up, but if it is only polled in the single
  *     BDRV_POLL_WHILE() at the end of the drain, this should work fine.
@@ -1364,8 +1366,8 @@ static void test_detach_indirect(bool by_parent_cb)
     QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
=20
     if (!by_parent_cb) {
-        detach_by_driver_cb_role =3D child_file;
-        detach_by_driver_cb_role.drained_begin =3D
+        detach_by_driver_cb_class =3D child_file;
+        detach_by_driver_cb_class.drained_begin =3D
             detach_by_driver_cb_drained_begin;
     }
=20
@@ -1399,7 +1401,7 @@ static void test_detach_indirect(bool by_parent_cb)
=20
     bdrv_ref(a);
     bdrv_attach_child(parent_a, a, "PA-A",
-                      by_parent_cb ? &child_file : &detach_by_driver_cb_ro=
le,
+                      by_parent_cb ? &child_file : &detach_by_driver_cb_cl=
ass,
                       &error_abort);
=20
     g_assert_cmpint(parent_a->refcnt, =3D=3D, 1);
@@ -1735,7 +1737,7 @@ static int drop_intermediate_poll_update_filename(Bdr=
vChild *child,
 /**
  * Test a poll in the midst of bdrv_drop_intermediate().
  *
- * bdrv_drop_intermediate() calls BdrvChildRole.update_filename(),
+ * bdrv_drop_intermediate() calls BdrvChildClass.update_filename(),
  * which can yield or poll.  This may lead to graph changes, unless
  * the whole subtree in question is drained.
  *
@@ -1772,7 +1774,7 @@ static int drop_intermediate_poll_update_filename(Bdr=
vChild *child,
  *
  * The solution is for bdrv_drop_intermediate() to drain top's
  * subtree.  This prevents graph changes from happening just because
- * BdrvChildRole.update_filename() yields or polls.  Thus, the block
+ * BdrvChildClass.update_filename() yields or polls.  Thus, the block
  * job is paused during that drained section and must finish before or
  * after.
  *
@@ -1780,7 +1782,7 @@ static int drop_intermediate_poll_update_filename(Bdr=
vChild *child,
  */
 static void test_drop_intermediate_poll(void)
 {
-    static BdrvChildRole chain_child_role;
+    static BdrvChildClass chain_child_class;
     BlockDriverState *chain[3];
     TestSimpleBlockJob *job;
     BlockDriverState *job_node;
@@ -1788,8 +1790,8 @@ static void test_drop_intermediate_poll(void)
     int i;
     int ret;
=20
-    chain_child_role =3D child_backing;
-    chain_child_role.update_filename =3D drop_intermediate_poll_update_fil=
ename;
+    chain_child_class =3D child_backing;
+    chain_child_class.update_filename =3D drop_intermediate_poll_update_fi=
lename;
=20
     for (i =3D 0; i < 3; i++) {
         char name[32];
@@ -1810,7 +1812,7 @@ static void test_drop_intermediate_poll(void)
         if (i) {
             /* Takes the reference to chain[i - 1] */
             chain[i]->backing =3D bdrv_attach_child(chain[i], chain[i - 1]=
,
-                                                  "chain", &chain_child_ro=
le,
+                                                  "chain", &chain_child_cl=
ass,
                                                   &error_abort);
         }
     }
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index a007754d9e..fef42cb294 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -30,7 +30,7 @@ static BlockDriver bdrv_pass_through =3D {
 };
=20
 static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
-                                         const BdrvChildRole *role,
+                                         const BdrvChildClass *child_class=
,
                                          BlockReopenQueue *reopen_queue,
                                          uint64_t perm, uint64_t shared,
                                          uint64_t *nperm, uint64_t *nshare=
d)
--=20
2.23.0


