Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9588C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D0B2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D0B2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcbO-0003eX-S9
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdcTs-00038e-PF
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdcTr-00029Q-4Q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdcTn-0001z6-LX; Wed, 19 Jun 2019 11:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 042AA3082B69;
 Wed, 19 Jun 2019 15:26:17 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F79C19C6F;
 Wed, 19 Jun 2019 15:26:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 17:25:56 +0200
Message-Id: <20190619152603.5937-3-mreitz@redhat.com>
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>
References: <20190619152603.5937-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 15:26:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/9] block: Add @data_objs to
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

Callers can now pass a pointer to a GSList that bdrv_drain_invoke() (and
its recursive callees) will fill with all BdrvCoDrainData objects they
create.  This will allow us to move the polling for BdrvCoDrainData.done
to become true out of bdrv_drain_invoke() and into the root drain_end
function.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 65 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/block/io.c b/block/io.c
index 112eed385c..6b518e5eb0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -194,12 +194,14 @@ typedef struct {
     bool poll;
     BdrvChild *parent;
     bool ignore_bds_parents;
+    GSList **data_objs;
 } BdrvCoDrainData;
=20
 static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
 {
     BdrvCoDrainData *data =3D opaque;
     BlockDriverState *bs =3D data->bs;
+    bool data_owned_by_caller =3D data->data_objs || !data->begin;
=20
     if (data->begin) {
         bs->drv->bdrv_co_drain_begin(bs);
@@ -211,13 +213,14 @@ static void coroutine_fn bdrv_drain_invoke_entry(vo=
id *opaque)
     atomic_mb_set(&data->done, true);
     bdrv_dec_in_flight(bs);
=20
-    if (data->begin) {
+    if (!data_owned_by_caller) {
         g_free(data);
     }
 }
=20
 /* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
-static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
+static void bdrv_drain_invoke(BlockDriverState *bs, bool begin,
+                              GSList **data_objs)
 {
     BdrvCoDrainData *data;
=20
@@ -230,16 +233,23 @@ static void bdrv_drain_invoke(BlockDriverState *bs,=
 bool begin)
     *data =3D (BdrvCoDrainData) {
         .bs =3D bs,
         .done =3D false,
-        .begin =3D begin
+        .begin =3D begin,
+        .data_objs =3D data_objs,
     };
=20
+    if (data_objs) {
+        *data_objs =3D g_slist_prepend(*data_objs, data);
+    }
+
     /* Make sure the driver callback completes during the polling phase =
for
      * drain_begin. */
     bdrv_inc_in_flight(bs);
     data->co =3D qemu_coroutine_create(bdrv_drain_invoke_entry, data);
     aio_co_schedule(bdrv_get_aio_context(bs), data->co);
=20
+    /* TODO: Drop this and make callers pass @data_objs and poll */
     if (!begin) {
+        assert(!data_objs);
         BDRV_POLL_WHILE(bs, !data->done);
         g_free(data);
     }
@@ -281,7 +291,8 @@ static void bdrv_do_drained_begin(BlockDriverState *b=
s, bool recursive,
                                   BdrvChild *parent, bool ignore_bds_par=
ents,
                                   bool poll);
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent, bool ignore_bds_paren=
ts);
+                                BdrvChild *parent, bool ignore_bds_paren=
ts,
+                                GSList **data_objs);
=20
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
@@ -308,7 +319,7 @@ static void bdrv_co_drain_bh_cb(void *opaque)
                                   data->ignore_bds_parents, data->poll);
         } else {
             bdrv_do_drained_end(bs, data->recursive, data->parent,
-                                data->ignore_bds_parents);
+                                data->ignore_bds_parents, data->data_obj=
s);
         }
         if (ctx =3D=3D co_ctx) {
             aio_context_release(ctx);
@@ -326,15 +337,15 @@ static void coroutine_fn bdrv_co_yield_to_drain(Blo=
ckDriverState *bs,
                                                 bool begin, bool recursi=
ve,
                                                 BdrvChild *parent,
                                                 bool ignore_bds_parents,
-                                                bool poll)
+                                                bool poll, GSList **data=
_objs)
 {
-    BdrvCoDrainData data;
+    BdrvCoDrainData *data =3D g_new(BdrvCoDrainData, 1);
=20
     /* Calling bdrv_drain() from a BH ensures the current coroutine yiel=
ds and
      * other coroutines run if they were queued by aio_co_enter(). */
=20
     assert(qemu_in_coroutine());
-    data =3D (BdrvCoDrainData) {
+    *data =3D (BdrvCoDrainData) {
         .co =3D qemu_coroutine_self(),
         .bs =3D bs,
         .done =3D false,
@@ -343,17 +354,27 @@ static void coroutine_fn bdrv_co_yield_to_drain(Blo=
ckDriverState *bs,
         .parent =3D parent,
         .ignore_bds_parents =3D ignore_bds_parents,
         .poll =3D poll,
+        .data_objs =3D data_objs,
     };
+
+    if (data_objs) {
+        *data_objs =3D g_slist_prepend(*data_objs, data);
+    }
+
     if (bs) {
         bdrv_inc_in_flight(bs);
     }
     aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
-                            bdrv_co_drain_bh_cb, &data);
+                            bdrv_co_drain_bh_cb, data);
=20
     qemu_coroutine_yield();
     /* If we are resumed from some other event (such as an aio completio=
n or a
      * timer callback), it is a bug in the caller that should be fixed. =
*/
-    assert(data.done);
+    assert(data->done);
+
+    if (!data_objs) {
+        g_free(data);
+    }
 }
=20
 void bdrv_do_drained_begin_quiesce(BlockDriverState *bs,
@@ -367,7 +388,7 @@ void bdrv_do_drained_begin_quiesce(BlockDriverState *=
bs,
     }
=20
     bdrv_parent_drained_begin(bs, parent, ignore_bds_parents);
-    bdrv_drain_invoke(bs, true);
+    bdrv_drain_invoke(bs, true, NULL);
 }
=20
 static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
@@ -378,7 +399,7 @@ static void bdrv_do_drained_begin(BlockDriverState *b=
s, bool recursive,
=20
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, true, recursive, parent, ignore_bds_p=
arents,
-                               poll);
+                               poll, NULL);
         return;
     }
=20
@@ -419,20 +440,21 @@ void bdrv_subtree_drained_begin(BlockDriverState *b=
s)
 }
=20
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent, bool ignore_bds_paren=
ts)
+                                BdrvChild *parent, bool ignore_bds_paren=
ts,
+                                GSList **data_objs)
 {
     BdrvChild *child, *next;
     int old_quiesce_counter;
=20
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, false, recursive, parent, ignore_bds_=
parents,
-                               false);
+                               false, data_objs);
         return;
     }
     assert(bs->quiesce_counter > 0);
=20
     /* Re-enable things in child-to-parent order */
-    bdrv_drain_invoke(bs, false);
+    bdrv_drain_invoke(bs, false, data_objs);
     bdrv_parent_drained_end(bs, parent, ignore_bds_parents);
=20
     old_quiesce_counter =3D atomic_fetch_dec(&bs->quiesce_counter);
@@ -444,19 +466,20 @@ static void bdrv_do_drained_end(BlockDriverState *b=
s, bool recursive,
         assert(!ignore_bds_parents);
         bs->recursive_quiesce_counter--;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-            bdrv_do_drained_end(child->bs, true, child, ignore_bds_paren=
ts);
+            bdrv_do_drained_end(child->bs, true, child, ignore_bds_paren=
ts,
+                                data_objs);
         }
     }
 }
=20
 void bdrv_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, false, NULL, false);
+    bdrv_do_drained_end(bs, false, NULL, false, NULL);
 }
=20
 void bdrv_subtree_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, true, NULL, false);
+    bdrv_do_drained_end(bs, true, NULL, false, NULL);
 }
=20
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pa=
rent)
@@ -473,7 +496,7 @@ void bdrv_unapply_subtree_drain(BdrvChild *child, Blo=
ckDriverState *old_parent)
     int i;
=20
     for (i =3D 0; i < old_parent->recursive_quiesce_counter; i++) {
-        bdrv_do_drained_end(child->bs, true, child, false);
+        bdrv_do_drained_end(child->bs, true, child, false, NULL);
     }
 }
=20
@@ -543,7 +566,7 @@ void bdrv_drain_all_begin(void)
     BlockDriverState *bs =3D NULL;
=20
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(NULL, true, false, NULL, true, true);
+        bdrv_co_yield_to_drain(NULL, true, false, NULL, true, true, NULL=
);
         return;
     }
=20
@@ -579,7 +602,7 @@ void bdrv_drain_all_end(void)
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
         aio_context_acquire(aio_context);
-        bdrv_do_drained_end(bs, false, NULL, true);
+        bdrv_do_drained_end(bs, false, NULL, true, NULL);
         aio_context_release(aio_context);
     }
=20
--=20
2.21.0


