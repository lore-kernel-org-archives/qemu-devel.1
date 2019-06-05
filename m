Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2441EC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61382075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61382075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYYF-0000iD-37
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:14:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hYYVt-0007Wz-Bc
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hYYVp-0002ta-It
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:11:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hYYVj-0002ZJ-PQ; Wed, 05 Jun 2019 12:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C55B2F8BD2;
	Wed,  5 Jun 2019 16:11:33 +0000 (UTC)
Received: from localhost (unknown [10.40.205.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 297AF2DE98;
	Wed,  5 Jun 2019 16:11:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  5 Jun 2019 18:11:16 +0200
Message-Id: <20190605161118.14544-3-mreitz@redhat.com>
In-Reply-To: <20190605161118.14544-1-mreitz@redhat.com>
References: <20190605161118.14544-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 05 Jun 2019 16:11:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] block: Make @parent_quiesced a bool
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reliably ending the drain on a BDS's parents is quite difficult.  What
we have to achieve is to undrain exactly those parents that have been
added to the BDS while its quiesce_counter was elevated.  If we move
decrementing the quiesce_counter before the invocation of
bdrv_parent_drained_end(), that leaves us with the parents that existed
at the start of this function.  That seems simple enough, because new
parents are always added at the beginning of the list, so just iterating
through it from start to finish should give us exactly the parents we
are looking for.

Unfortunately, there is a catch.  Unquiescing one parent can lead to
another deciding to detach the child.  In the process, the BdrvChild
object may be destroyed.  That means using QLIST_FOREACH_SAFE() to
iterate the list is actually wrong: The @next pointer may be stale by
the time we get to the next iteration.  Using QLIST_FOREACH() would be
just as wrong, though, because the current BdrvChild object may be
destroyed just as well.

It follows that we cannot just iterate over the list from start to
finish.  Some ideas how to solve this problem:
- Store a list of the parent pointers at the beginning of the function,
  then try to unquiesce them all (as long as they are in bs->parents).
  Does not work because pointers may be reused by new parents.

- Add refcounts to BdrvChild objects.  Kind of silly because only the
  parent really has a valid reference.  Once that goes away, all fields
  must be cleared.  Therefore, all we could guarantee is that the list
  pointers (next/next_parent) stay valid.
  Also, parents can simply change the child a BdrvChild refers to.  If
  they do that, the BdrvChild object remains accessible, but (1) it
  refers to the wrong child, and (2) next_parent suddenly refers to a
  different list.
  So maybe this can be made to work, but it would always be kind of
  silly.

- Check the difference between the parent_quiesce_counters and the
  actual bs->quiesce_counter.  In theory, both should be equal after
  bdrv_parent_drained_end() (reduced by bdrv_drain_all_count for BDS
  parents).
  So we could reiterate the parent list (unquiescing one parent at a
  time) until all parents have the desired parent_quiesce_counter.
  In practice, this is difficult -- I have tried.  bdrv_drain_all_count
  may be one too high because somewhere down the stack there is a
  bdrv_drain_all_end() currently running.  Also, I suppose something can
  concurrently modify bs->quiesce_counter, and I am not sure how to
  handle such cases.
  In the best case, this would lead to rather complicated code that I
  could not trust but only pray that it works.  In the worst case, my
  prayers are not heard.

We can get around the whole issue by observing that it really does not
matter whether a parent is quiesced one time or ten.  We just have to
quiesce it once the moment the child tries to change from being
unquiesced to being quiesced.  We have to unquiesce it when the child is
unquiesced again.

Therefore, we can just make the parent_quiesce_counter a boolean and
call it parent_quiesced.  When bdrv_parent_drained_end() sees
bs->quiesce_counter going to 0, we unquiesce all parents.
bdrv_parent_drained_begin() in turn quiesces all unquiesced parents.

(This means we have to decrement bs->quiesce_counter before
bdrv_parent_drained_end().)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h     | 10 +------
 include/block/block_int.h |  9 +++----
 block.c                   |  7 +++--
 block/io.c                | 55 ++++++++++++++++++++++++++++-----------
 tests/test-bdrv-drain.c   | 31 +++++++++++++---------
 5 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 3c084e8222..687c03b275 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -620,18 +620,10 @@ void bdrv_parent_drained_begin_single(BdrvChild *c,=
 bool poll);
  * bdrv_parent_drained_end_single:
  *
  * End a quiesced section for the parent of @c.
+ * c->parent_quiesced must be true.
  */
 void bdrv_parent_drained_end_single(BdrvChild *c);
=20
-/**
- * bdrv_parent_drained_end:
- *
- * End a quiesced section of all users of @bs. This is part of
- * bdrv_drained_end.
- */
-void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
-                             bool ignore_bds_parents);
-
 /**
  * bdrv_drain_poll:
  *
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 84c0369fb7..58fca37ba3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -730,13 +730,10 @@ struct BdrvChild {
     bool frozen;
=20
     /*
-     * How many times the parent of this child has been drained
-     * (through role->drained_*).
-     * Usually, this is equal to bs->quiesce_counter (potentially
-     * reduced by bdrv_drain_all_count).  It may differ while the
-     * child is entering or leaving a drained section.
+     * Whether the parent of this child has been drained through
+     * role->drained_*.
      */
-    int parent_quiesce_counter;
+    bool parent_quiesced;
=20
     QLIST_ENTRY(BdrvChild) next;
     QLIST_ENTRY(BdrvChild) next_parent;
diff --git a/block.c b/block.c
index b336a91415..6bc51e371f 100644
--- a/block.c
+++ b/block.c
@@ -2159,7 +2159,6 @@ static void bdrv_replace_child_noperm(BdrvChild *ch=
ild,
                                       BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs =3D child->bs;
-    int i;
=20
     assert(!child->frozen);
=20
@@ -2173,12 +2172,12 @@ static void bdrv_replace_child_noperm(BdrvChild *=
child,
         if (child->role->detach) {
             child->role->detach(child);
         }
-        while (child->parent_quiesce_counter) {
+        if (child->parent_quiesced) {
             bdrv_parent_drained_end_single(child);
         }
         QLIST_REMOVE(child, next_parent);
     } else {
-        assert(child->parent_quiesce_counter =3D=3D 0);
+        assert(!child->parent_quiesced);
     }
=20
     child->bs =3D new_bs;
@@ -2191,7 +2190,7 @@ static void bdrv_replace_child_noperm(BdrvChild *ch=
ild,
                 num -=3D bdrv_drain_all_count;
             }
             assert(num >=3D 0);
-            for (i =3D 0; i < num; i++) {
+            if (num) {
                 bdrv_parent_drained_begin_single(child, true);
             }
         }
diff --git a/block/io.c b/block/io.c
index 112eed385c..2408abffd9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -57,24 +57,47 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, =
BdrvChild *ignore,
=20
 void bdrv_parent_drained_end_single(BdrvChild *c)
 {
-    assert(c->parent_quiesce_counter > 0);
-    c->parent_quiesce_counter--;
+    assert(c->parent_quiesced);
+    c->parent_quiesced =3D false;
     if (c->role->drained_end) {
         c->role->drained_end(c);
     }
 }
=20
-void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
-                             bool ignore_bds_parents)
+static void bdrv_parent_drained_end(BlockDriverState *bs)
 {
-    BdrvChild *c, *next;
+    BdrvChild *c;
=20
-    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
-            continue;
-        }
-        bdrv_parent_drained_end_single(c);
+    if (bs->quiesce_counter) {
+        return;
     }
+
+    /*
+     * The list of parents can change, so repeat until all are
+     * unquiesced (or until bs->quiesce_counter is no longer zero).
+     */
+    do {
+        QLIST_FOREACH(c, &bs->parents, next_parent) {
+            if (!c->parent_quiesced) {
+                continue;
+            }
+
+            if (bs->quiesce_counter) {
+                /*
+                 * We can just leave here.  The first thing
+                 * bdrv_parent_drained_end_single() does is to set
+                 * c->parent_quiesced to false.  If something decides
+                 * to drain @bs while we are unquiescing some parent,
+                 * it will thus redrain that parent (and everything
+                 * else that we have already unquiesced).
+                 */
+                return;
+            }
+
+            bdrv_parent_drained_end_single(c);
+            break;
+        }
+    } while (c);
 }
=20
 static bool bdrv_parent_drained_poll_single(BdrvChild *c)
@@ -103,9 +126,11 @@ static bool bdrv_parent_drained_poll(BlockDriverStat=
e *bs, BdrvChild *ignore,
=20
 void bdrv_parent_drained_begin_single(BdrvChild *c, bool poll)
 {
-    c->parent_quiesce_counter++;
-    if (c->role->drained_begin) {
-        c->role->drained_begin(c);
+    if (!c->parent_quiesced) {
+        c->parent_quiesced =3D true;
+        if (c->role->drained_begin) {
+            c->role->drained_begin(c);
+        }
     }
     if (poll) {
         BDRV_POLL_WHILE(c->bs, bdrv_parent_drained_poll_single(c));
@@ -433,9 +458,9 @@ static void bdrv_do_drained_end(BlockDriverState *bs,=
 bool recursive,
=20
     /* Re-enable things in child-to-parent order */
     bdrv_drain_invoke(bs, false);
-    bdrv_parent_drained_end(bs, parent, ignore_bds_parents);
-
     old_quiesce_counter =3D atomic_fetch_dec(&bs->quiesce_counter);
+    bdrv_parent_drained_end(bs);
+
     if (old_quiesce_counter =3D=3D 1) {
         aio_enable_external(bdrv_get_aio_context(bs));
     }
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 12e2ecf517..75609bf6d0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -446,10 +446,14 @@ static void test_multiparent(void)
=20
     do_drain_end(BDRV_SUBTREE_DRAIN, bs_b);
=20
-    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 1);
+    /*
+     * @backing is still drained by @bs_a, so it has not unquiesced
+     * its parents yet (and @bs_a retains its qc of 2).
+     */
+    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 2);
     g_assert_cmpint(bs_b->quiesce_counter, =3D=3D, 1);
     g_assert_cmpint(backing->quiesce_counter, =3D=3D, 1);
-    g_assert_cmpint(a_s->drain_count, =3D=3D, 1);
+    g_assert_cmpint(a_s->drain_count, =3D=3D, 2);
     g_assert_cmpint(b_s->drain_count, =3D=3D, 1);
     g_assert_cmpint(backing_s->drain_count, =3D=3D, 1);
=20
@@ -505,27 +509,28 @@ static void test_graph_change_drain_subtree(void)
     do_drain_begin(BDRV_SUBTREE_DRAIN, bs_b);
=20
     bdrv_set_backing_hd(bs_b, backing, &error_abort);
-    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 5);
-    g_assert_cmpint(bs_b->quiesce_counter, =3D=3D, 5);
-    g_assert_cmpint(backing->quiesce_counter, =3D=3D, 5);
-    g_assert_cmpint(a_s->drain_count, =3D=3D, 5);
-    g_assert_cmpint(b_s->drain_count, =3D=3D, 5);
+    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 4); /* 3 + !!2 */
+    g_assert_cmpint(bs_b->quiesce_counter, =3D=3D, 3); /* !!3 + 2 */
+    g_assert_cmpint(backing->quiesce_counter, =3D=3D, 5); /* 3 + 2 */
+    g_assert_cmpint(a_s->drain_count, =3D=3D, 4);
+    g_assert_cmpint(b_s->drain_count, =3D=3D, 3);
     g_assert_cmpint(backing_s->drain_count, =3D=3D, 5);
=20
     bdrv_set_backing_hd(bs_b, NULL, &error_abort);
-    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 3);
+    /* @backing remains quiesced, so it does not unquiesce @bs_a */
+    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 4);
     g_assert_cmpint(bs_b->quiesce_counter, =3D=3D, 2);
     g_assert_cmpint(backing->quiesce_counter, =3D=3D, 3);
-    g_assert_cmpint(a_s->drain_count, =3D=3D, 3);
+    g_assert_cmpint(a_s->drain_count, =3D=3D, 4);
     g_assert_cmpint(b_s->drain_count, =3D=3D, 2);
     g_assert_cmpint(backing_s->drain_count, =3D=3D, 3);
=20
     bdrv_set_backing_hd(bs_b, backing, &error_abort);
-    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 5);
-    g_assert_cmpint(bs_b->quiesce_counter, =3D=3D, 5);
+    g_assert_cmpint(bs_a->quiesce_counter, =3D=3D, 4);
+    g_assert_cmpint(bs_b->quiesce_counter, =3D=3D, 3);
     g_assert_cmpint(backing->quiesce_counter, =3D=3D, 5);
-    g_assert_cmpint(a_s->drain_count, =3D=3D, 5);
-    g_assert_cmpint(b_s->drain_count, =3D=3D, 5);
+    g_assert_cmpint(a_s->drain_count, =3D=3D, 4);
+    g_assert_cmpint(b_s->drain_count, =3D=3D, 3);
     g_assert_cmpint(backing_s->drain_count, =3D=3D, 5);
=20
     do_drain_end(BDRV_SUBTREE_DRAIN, bs_b);
--=20
2.21.0


