Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDCEC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8595B21721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8595B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcVm-00055T-OL
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42392)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdcTs-00037l-Cv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdcTq-00029I-Uq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdcTn-000227-Nc; Wed, 19 Jun 2019 11:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7890F2E95A2;
 Wed, 19 Jun 2019 15:26:23 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF39451DDF;
 Wed, 19 Jun 2019 15:26:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 17:25:58 +0200
Message-Id: <20190619152603.5937-5-mreitz@redhat.com>
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>
References: <20190619152603.5937-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 19 Jun 2019 15:26:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/9] block: Move polling out of
 bdrv_drain_invoke()
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead, let the root drained_end functions poll after the whole subtree
has been undrained.  These are bdrv_drain_all_end() and sometimes
bdrv_do_drained_end(); the "sometimes" implies that the latter needs a
parameter to tell whether it should poll or not.

Note that bdrv_do_drained_end() now always receives either poll=3Dtrue
(for the root level) or a pointer to a BdrvCoDrainData object list (as a
recursive call from the root bdrv_do_drained_end() invocation).
In the future, we will have callers that pass poll=3Dfalse and no list,
because they do not care about polling at all.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/block/io.c b/block/io.c
index eb84774abd..426ad5b4a1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -201,7 +201,7 @@ static void coroutine_fn bdrv_drain_invoke_entry(void=
 *opaque)
 {
     BdrvCoDrainData *data =3D opaque;
     BlockDriverState *bs =3D data->bs;
-    bool data_owned_by_caller =3D data->data_objs || !data->begin;
+    bool data_owned_by_caller =3D data->data_objs;
=20
     if (data->begin) {
         bs->drv->bdrv_co_drain_begin(bs);
@@ -246,19 +246,8 @@ static void bdrv_drain_invoke(BlockDriverState *bs, =
bool begin,
     bdrv_inc_in_flight(bs);
     data->co =3D qemu_coroutine_create(bdrv_drain_invoke_entry, data);
     aio_co_schedule(bdrv_get_aio_context(bs), data->co);
-
-    /* TODO: Drop this and make callers pass @data_objs and poll */
-    if (!begin) {
-        assert(!data_objs);
-        BDRV_POLL_WHILE(bs, !data->done);
-        g_free(data);
-    }
 }
=20
-/* TODO: Actually use this function and drop this forward declaration */
-static void bdrv_poll_drain_data_objs(GSList **data_objs, bool acquire_c=
tx)
-    __attribute__((unused));
-
 /*
  * Poll the AioContexts in the given list of BdrvCoDrainData objects
  * until all of those objects are "done" (i.e. their .done field is
@@ -349,7 +338,7 @@ static void bdrv_do_drained_begin(BlockDriverState *b=
s, bool recursive,
                                   bool poll);
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
                                 BdrvChild *parent, bool ignore_bds_paren=
ts,
-                                GSList **data_objs);
+                                bool poll, GSList **data_objs);
=20
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
@@ -376,7 +365,8 @@ static void bdrv_co_drain_bh_cb(void *opaque)
                                   data->ignore_bds_parents, data->poll);
         } else {
             bdrv_do_drained_end(bs, data->recursive, data->parent,
-                                data->ignore_bds_parents, data->data_obj=
s);
+                                data->ignore_bds_parents, data->poll,
+                                data->data_objs);
         }
         if (ctx =3D=3D co_ctx) {
             aio_context_release(ctx);
@@ -498,18 +488,24 @@ void bdrv_subtree_drained_begin(BlockDriverState *b=
s)
=20
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
                                 BdrvChild *parent, bool ignore_bds_paren=
ts,
-                                GSList **data_objs)
+                                bool poll, GSList **data_objs)
 {
     BdrvChild *child, *next;
     int old_quiesce_counter;
+    GSList *poll_data_objs =3D NULL;
=20
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, false, recursive, parent, ignore_bds_=
parents,
-                               false, data_objs);
+                               poll, data_objs);
         return;
     }
     assert(bs->quiesce_counter > 0);
=20
+    if (poll) {
+        assert(data_objs =3D=3D NULL);
+        data_objs =3D &poll_data_objs;
+    }
+
     /* Re-enable things in child-to-parent order */
     bdrv_drain_invoke(bs, false, data_objs);
     bdrv_parent_drained_end(bs, parent, ignore_bds_parents);
@@ -524,19 +520,24 @@ static void bdrv_do_drained_end(BlockDriverState *b=
s, bool recursive,
         bs->recursive_quiesce_counter--;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
             bdrv_do_drained_end(child->bs, true, child, ignore_bds_paren=
ts,
-                                data_objs);
+                                false, data_objs);
         }
     }
+
+    if (poll) {
+        assert(data_objs =3D=3D &poll_data_objs);
+        bdrv_poll_drain_data_objs(data_objs, false);
+    }
 }
=20
 void bdrv_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, false, NULL, false, NULL);
+    bdrv_do_drained_end(bs, false, NULL, false, true, NULL);
 }
=20
 void bdrv_subtree_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, true, NULL, false, NULL);
+    bdrv_do_drained_end(bs, true, NULL, false, true, NULL);
 }
=20
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pa=
rent)
@@ -553,7 +554,7 @@ void bdrv_unapply_subtree_drain(BdrvChild *child, Blo=
ckDriverState *old_parent)
     int i;
=20
     for (i =3D 0; i < old_parent->recursive_quiesce_counter; i++) {
-        bdrv_do_drained_end(child->bs, true, child, false, NULL);
+        bdrv_do_drained_end(child->bs, true, child, false, true, NULL);
     }
 }
=20
@@ -654,15 +655,18 @@ void bdrv_drain_all_begin(void)
 void bdrv_drain_all_end(void)
 {
     BlockDriverState *bs =3D NULL;
+    GSList *poll_data_objs =3D NULL;
=20
     while ((bs =3D bdrv_next_all_states(bs))) {
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
         aio_context_acquire(aio_context);
-        bdrv_do_drained_end(bs, false, NULL, true, NULL);
+        bdrv_do_drained_end(bs, false, NULL, true, false, &poll_data_obj=
s);
         aio_context_release(aio_context);
     }
=20
+    bdrv_poll_drain_data_objs(&poll_data_objs, true);
+
     assert(bdrv_drain_all_count > 0);
     bdrv_drain_all_count--;
 }
--=20
2.21.0


