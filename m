Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB055C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8442F2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8442F2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTBu-0006Md-Cs
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hoTBF-0003wD-SL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hoTBD-0003Zo-K9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hoTB7-0003VF-1W; Fri, 19 Jul 2019 09:44:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 402A9300B916;
 Fri, 19 Jul 2019 13:44:04 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50D34608AB;
 Fri, 19 Jul 2019 13:44:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 15:43:39 +0200
Message-Id: <20190719134345.23526-8-kwolf@redhat.com>
In-Reply-To: <20190719134345.23526-1-kwolf@redhat.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 19 Jul 2019 13:44:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/13] block: Do not poll in
 bdrv_do_drained_end()
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

We should never poll anywhere in bdrv_do_drained_end() (including its
recursive callees like bdrv_drain_invoke()), because it does not cope
well with graph changes.  In fact, it has been written based on the
postulation that no graph changes will happen in it.

Instead, the callers that want to poll must poll, i.e. all currently
globally available wrappers: bdrv_drained_end(),
bdrv_subtree_drained_end(), bdrv_unapply_subtree_drain(), and
bdrv_drain_all_end().  Graph changes there do not matter.

They can poll simply by passing a pointer to a drained_end_counter and
wait until it reaches 0.

This patch also adds a non-polling global wrapper for
bdrv_do_drained_end() that takes a drained_end_counter pointer.  We need
such a variant because now no function called anywhere from
bdrv_do_drained_end() must poll.  This includes
BdrvChildRole.drained_end(), which already must not poll according to
its interface documentation, but bdrv_child_cb_drained_end() just
violates that by invoking bdrv_drained_end() (which does poll).
Therefore, BdrvChildRole.drained_end() must take a *drained_end_counter
parameter, which bdrv_child_cb_drained_end() can pass on to the new
bdrv_drained_end_no_poll() function.

Note that we now have a pattern of all drained_end-related functions
either polling or receiving a *drained_end_counter to let the caller
poll based on that.

A problem with a single poll loop is that when the drained section in
bdrv_set_aio_context_ignore() ends, some nodes in the subgraph may be in
the old contexts, while others are in the new context already.  To let
the collective poll in bdrv_drained_end() work correctly, we must not
hold a lock to the old context, so that the old context can make
progress in case it is different from the current context.

(In the process, remove the comment saying that the current context is
always the old context, because it is wrong.)

In all other places, all nodes in a subtree must be in the same context,
so we can just poll that.  The exception of course is
bdrv_drain_all_end(), but that always runs in the main context, so we
can just poll NULL (like bdrv_drain_all_begin() does).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     | 25 ++++++++++++
 include/block/block_int.h |  6 ++-
 block.c                   | 37 ++++++++++++++----
 block/block-backend.c     |  6 +--
 block/io.c                | 80 ++++++++++++++++++++++++++++-----------
 blockjob.c                |  2 +-
 6 files changed, 120 insertions(+), 36 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index a81645e8a3..60f00479e0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -612,6 +612,9 @@ void bdrv_parent_drained_begin_single(BdrvChild *c, b=
ool poll);
  * bdrv_parent_drained_end_single:
  *
  * End a quiesced section for the parent of @c.
+ *
+ * This polls @bs's AioContext until all scheduled sub-drained_ends
+ * have settled, which may result in graph changes.
  */
 void bdrv_parent_drained_end_single(BdrvChild *c);
=20
@@ -661,9 +664,31 @@ void bdrv_subtree_drained_begin(BlockDriverState *bs=
);
  * bdrv_drained_end:
  *
  * End a quiescent section started by bdrv_drained_begin().
+ *
+ * This polls @bs's AioContext until all scheduled sub-drained_ends
+ * have settled.  On one hand, that may result in graph changes.  On
+ * the other, this requires that all involved nodes (@bs and all of
+ * its parents) are in the same AioContext, and that the caller has
+ * acquired it.
+ * If there are any nodes that are in different contexts from @bs,
+ * these contexts must not be acquired.
  */
 void bdrv_drained_end(BlockDriverState *bs);
=20
+/**
+ * bdrv_drained_end_no_poll:
+ *
+ * Same as bdrv_drained_end(), but do not poll for the subgraph to
+ * actually become unquiesced.  Therefore, no graph changes will occur
+ * with this function.
+ *
+ * *drained_end_counter is incremented for every background operation
+ * that is scheduled, and will be decremented for every operation once
+ * it settles.  The caller must poll until it reaches 0.  The counter
+ * should be accessed using atomic operations only.
+ */
+void bdrv_drained_end_no_poll(BlockDriverState *bs, int *drained_end_cou=
nter);
+
 /**
  * End a quiescent section started by bdrv_subtree_drained_begin().
  */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f5b044fcdb..3aa1e832a8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -664,11 +664,15 @@ struct BdrvChildRole {
      * These functions must not change the graph (and therefore also mus=
t not
      * call aio_poll(), which could change the graph indirectly).
      *
+     * If drained_end() schedules background operations, it must atomica=
lly
+     * increment *drained_end_counter for each such operation and atomic=
ally
+     * decrement it once the operation has settled.
+     *
      * Note that this can be nested. If drained_begin() was called twice=
, new
      * I/O is allowed only after drained_end() was called twice, too.
      */
     void (*drained_begin)(BdrvChild *child);
-    void (*drained_end)(BdrvChild *child);
+    void (*drained_end)(BdrvChild *child, int *drained_end_counter);
=20
     /*
      * Returns whether the parent has pending requests for the child. Th=
is
diff --git a/block.c b/block.c
index 8440712ca0..9c94f7f28a 100644
--- a/block.c
+++ b/block.c
@@ -911,10 +911,11 @@ static bool bdrv_child_cb_drained_poll(BdrvChild *c=
hild)
     return bdrv_drain_poll(bs, false, NULL, false);
 }
=20
-static void bdrv_child_cb_drained_end(BdrvChild *child)
+static void bdrv_child_cb_drained_end(BdrvChild *child,
+                                      int *drained_end_counter)
 {
     BlockDriverState *bs =3D child->opaque;
-    bdrv_drained_end(bs);
+    bdrv_drained_end_no_poll(bs, drained_end_counter);
 }
=20
 static void bdrv_child_cb_attach(BdrvChild *child)
@@ -5923,9 +5924,11 @@ static void bdrv_attach_aio_context(BlockDriverSta=
te *bs,
 void bdrv_set_aio_context_ignore(BlockDriverState *bs,
                                  AioContext *new_context, GSList **ignor=
e)
 {
+    AioContext *old_context =3D bdrv_get_aio_context(bs);
+    AioContext *current_context =3D qemu_get_current_aio_context();
     BdrvChild *child;
=20
-    if (bdrv_get_aio_context(bs) =3D=3D new_context) {
+    if (old_context =3D=3D new_context) {
         return;
     }
=20
@@ -5949,13 +5952,31 @@ void bdrv_set_aio_context_ignore(BlockDriverState=
 *bs,
=20
     bdrv_detach_aio_context(bs);
=20
-    /* This function executes in the old AioContext so acquire the new o=
ne in
-     * case it runs in a different thread.
-     */
-    aio_context_acquire(new_context);
+    /* Acquire the new context, if necessary */
+    if (current_context !=3D new_context) {
+        aio_context_acquire(new_context);
+    }
+
     bdrv_attach_aio_context(bs, new_context);
+
+    /*
+     * If this function was recursively called from
+     * bdrv_set_aio_context_ignore(), there may be nodes in the
+     * subtree that have not yet been moved to the new AioContext.
+     * Release the old one so bdrv_drained_end() can poll them.
+     */
+    if (current_context !=3D old_context) {
+        aio_context_release(old_context);
+    }
+
     bdrv_drained_end(bs);
-    aio_context_release(new_context);
+
+    if (current_context !=3D old_context) {
+        aio_context_acquire(old_context);
+    }
+    if (current_context !=3D new_context) {
+        aio_context_release(new_context);
+    }
 }
=20
 static bool bdrv_parent_can_set_aio_context(BdrvChild *c, AioContext *ct=
x,
diff --git a/block/block-backend.c b/block/block-backend.c
index a8d160fd5d..0056b526b8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -121,7 +121,7 @@ static void blk_root_inherit_options(int *child_flags=
, QDict *child_options,
 }
 static void blk_root_drained_begin(BdrvChild *child);
 static bool blk_root_drained_poll(BdrvChild *child);
-static void blk_root_drained_end(BdrvChild *child);
+static void blk_root_drained_end(BdrvChild *child, int *drained_end_coun=
ter);
=20
 static void blk_root_change_media(BdrvChild *child, bool load);
 static void blk_root_resize(BdrvChild *child);
@@ -1249,7 +1249,7 @@ int blk_pread_unthrottled(BlockBackend *blk, int64_=
t offset, uint8_t *buf,
=20
     blk_root_drained_begin(blk->root);
     ret =3D blk_pread(blk, offset, buf, count);
-    blk_root_drained_end(blk->root);
+    blk_root_drained_end(blk->root, NULL);
     return ret;
 }
=20
@@ -2236,7 +2236,7 @@ static bool blk_root_drained_poll(BdrvChild *child)
     return !!blk->in_flight;
 }
=20
-static void blk_root_drained_end(BdrvChild *child)
+static void blk_root_drained_end(BdrvChild *child, int *drained_end_coun=
ter)
 {
     BlockBackend *blk =3D child->opaque;
     assert(blk->quiesce_counter);
diff --git a/block/io.c b/block/io.c
index b0b33174d3..8f23cab82e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -55,17 +55,26 @@ static void bdrv_parent_drained_begin(BlockDriverStat=
e *bs, BdrvChild *ignore,
     }
 }
=20
-void bdrv_parent_drained_end_single(BdrvChild *c)
+static void bdrv_parent_drained_end_single_no_poll(BdrvChild *c,
+                                                   int *drained_end_coun=
ter)
 {
     assert(c->parent_quiesce_counter > 0);
     c->parent_quiesce_counter--;
     if (c->role->drained_end) {
-        c->role->drained_end(c);
+        c->role->drained_end(c, drained_end_counter);
     }
 }
=20
+void bdrv_parent_drained_end_single(BdrvChild *c)
+{
+    int drained_end_counter =3D 0;
+    bdrv_parent_drained_end_single_no_poll(c, &drained_end_counter);
+    BDRV_POLL_WHILE(c->bs, atomic_read(&drained_end_counter) > 0);
+}
+
 static void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ign=
ore,
-                                    bool ignore_bds_parents)
+                                    bool ignore_bds_parents,
+                                    int *drained_end_counter)
 {
     BdrvChild *c, *next;
=20
@@ -73,7 +82,7 @@ static void bdrv_parent_drained_end(BlockDriverState *b=
s, BdrvChild *ignore,
         if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
             continue;
         }
-        bdrv_parent_drained_end_single(c);
+        bdrv_parent_drained_end_single_no_poll(c, drained_end_counter);
     }
 }
=20
@@ -212,13 +221,11 @@ static void coroutine_fn bdrv_drain_invoke_entry(vo=
id *opaque)
     atomic_mb_set(&data->done, true);
     bdrv_dec_in_flight(bs);
=20
-    if (data->drained_end_counter) {
+    if (!data->begin) {
         atomic_dec(data->drained_end_counter);
     }
=20
-    if (data->begin || data->drained_end_counter) {
-        g_free(data);
-    }
+    g_free(data);
 }
=20
 /* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
@@ -240,7 +247,7 @@ static void bdrv_drain_invoke(BlockDriverState *bs, b=
ool begin,
         .drained_end_counter =3D drained_end_counter,
     };
=20
-    if (!begin && drained_end_counter) {
+    if (!begin) {
         atomic_inc(drained_end_counter);
     }
=20
@@ -249,15 +256,6 @@ static void bdrv_drain_invoke(BlockDriverState *bs, =
bool begin,
     bdrv_inc_in_flight(bs);
     data->co =3D qemu_coroutine_create(bdrv_drain_invoke_entry, data);
     aio_co_schedule(bdrv_get_aio_context(bs), data->co);
-
-    /*
-     * TODO: Drop this and make callers pass @drained_end_counter and po=
ll
-     * themselves
-     */
-    if (!begin && !drained_end_counter) {
-        BDRV_POLL_WHILE(bs, !data->done);
-        g_free(data);
-    }
 }
=20
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll(=
) */
@@ -320,9 +318,11 @@ static void bdrv_co_drain_bh_cb(void *opaque)
         }
         bdrv_dec_in_flight(bs);
         if (data->begin) {
+            assert(!data->drained_end_counter);
             bdrv_do_drained_begin(bs, data->recursive, data->parent,
                                   data->ignore_bds_parents, data->poll);
         } else {
+            assert(!data->poll);
             bdrv_do_drained_end(bs, data->recursive, data->parent,
                                 data->ignore_bds_parents,
                                 data->drained_end_counter);
@@ -438,6 +438,20 @@ void bdrv_subtree_drained_begin(BlockDriverState *bs=
)
     bdrv_do_drained_begin(bs, true, NULL, false, true);
 }
=20
+/**
+ * This function does not poll, nor must any of its recursively called
+ * functions.  The *drained_end_counter pointee will be incremented
+ * once for every background operation scheduled, and decremented once
+ * the operation settles.  Therefore, the pointer must remain valid
+ * until the pointee reaches 0.  That implies that whoever sets up the
+ * pointee has to poll until it is 0.
+ *
+ * We use atomic operations to access *drained_end_counter, because
+ * (1) when called from bdrv_set_aio_context_ignore(), the subgraph of
+ *     @bs may contain nodes in different AioContexts,
+ * (2) bdrv_drain_all_end() uses the same counter for all nodes,
+ *     regardless of which AioContext they are in.
+ */
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
                                 BdrvChild *parent, bool ignore_bds_paren=
ts,
                                 int *drained_end_counter)
@@ -445,6 +459,8 @@ static void bdrv_do_drained_end(BlockDriverState *bs,=
 bool recursive,
     BdrvChild *child, *next;
     int old_quiesce_counter;
=20
+    assert(drained_end_counter !=3D NULL);
+
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, false, recursive, parent, ignore_bds_=
parents,
                                false, drained_end_counter);
@@ -454,7 +470,8 @@ static void bdrv_do_drained_end(BlockDriverState *bs,=
 bool recursive,
=20
     /* Re-enable things in child-to-parent order */
     bdrv_drain_invoke(bs, false, drained_end_counter);
-    bdrv_parent_drained_end(bs, parent, ignore_bds_parents);
+    bdrv_parent_drained_end(bs, parent, ignore_bds_parents,
+                            drained_end_counter);
=20
     old_quiesce_counter =3D atomic_fetch_dec(&bs->quiesce_counter);
     if (old_quiesce_counter =3D=3D 1) {
@@ -473,12 +490,21 @@ static void bdrv_do_drained_end(BlockDriverState *b=
s, bool recursive,
=20
 void bdrv_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, false, NULL, false, NULL);
+    int drained_end_counter =3D 0;
+    bdrv_do_drained_end(bs, false, NULL, false, &drained_end_counter);
+    BDRV_POLL_WHILE(bs, atomic_read(&drained_end_counter) > 0);
+}
+
+void bdrv_drained_end_no_poll(BlockDriverState *bs, int *drained_end_cou=
nter)
+{
+    bdrv_do_drained_end(bs, false, NULL, false, drained_end_counter);
 }
=20
 void bdrv_subtree_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, true, NULL, false, NULL);
+    int drained_end_counter =3D 0;
+    bdrv_do_drained_end(bs, true, NULL, false, &drained_end_counter);
+    BDRV_POLL_WHILE(bs, atomic_read(&drained_end_counter) > 0);
 }
=20
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pa=
rent)
@@ -492,11 +518,15 @@ void bdrv_apply_subtree_drain(BdrvChild *child, Blo=
ckDriverState *new_parent)
=20
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_=
parent)
 {
+    int drained_end_counter =3D 0;
     int i;
=20
     for (i =3D 0; i < old_parent->recursive_quiesce_counter; i++) {
-        bdrv_do_drained_end(child->bs, true, child, false, NULL);
+        bdrv_do_drained_end(child->bs, true, child, false,
+                            &drained_end_counter);
     }
+
+    BDRV_POLL_WHILE(child->bs, atomic_read(&drained_end_counter) > 0);
 }
=20
 /*
@@ -596,15 +626,19 @@ void bdrv_drain_all_begin(void)
 void bdrv_drain_all_end(void)
 {
     BlockDriverState *bs =3D NULL;
+    int drained_end_counter =3D 0;
=20
     while ((bs =3D bdrv_next_all_states(bs))) {
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
         aio_context_acquire(aio_context);
-        bdrv_do_drained_end(bs, false, NULL, true, NULL);
+        bdrv_do_drained_end(bs, false, NULL, true, &drained_end_counter)=
;
         aio_context_release(aio_context);
     }
=20
+    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context())=
;
+    AIO_WAIT_WHILE(NULL, atomic_read(&drained_end_counter) > 0);
+
     assert(bdrv_drain_all_count > 0);
     bdrv_drain_all_count--;
 }
diff --git a/blockjob.c b/blockjob.c
index 458ae76f51..20b7f557da 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -135,7 +135,7 @@ static bool child_job_drained_poll(BdrvChild *c)
     }
 }
=20
-static void child_job_drained_end(BdrvChild *c)
+static void child_job_drained_end(BdrvChild *c, int *drained_end_counter=
)
 {
     BlockJob *job =3D c->opaque;
     job_resume(&job->job);
--=20
2.20.1


