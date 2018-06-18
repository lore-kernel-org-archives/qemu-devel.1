Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHI-0004hY-BR
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHH-0006BI-3s
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:31 +0200
Message-Id: <20180618164504.24488-3-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/35] block: Use bdrv_do_drain_begin/end in
 bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

bdrv_do_drain_begin/end() implement already everything that
bdrv_drain_all_begin/end() need and currently still do manually: Disable
external events, call parent drain callbacks, call block driver
callbacks.

It also does two more things:

The first is incrementing bs->quiesce_counter. bdrv_drain_all() already
stood out in the test case by behaving different from the other drain
variants. Adding this is not only safe, but in fact a bug fix.

The second is calling bdrv_drain_recurse(). We already do that later in
the same function in a loop, so basically doing an early first iteration
doesn't hurt.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c              | 10 ++--------
 tests/test-bdrv-drain.c | 14 ++++----------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5f286bcedb..b355009f2c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -413,11 +413,8 @@ void bdrv_drain_all_begin(void)
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
-        /* Stop things in parent-to-child order */
         aio_context_acquire(aio_context);
-        aio_disable_external(aio_context);
-        bdrv_parent_drained_begin(bs, NULL);
-        bdrv_drain_invoke(bs, true, true);
+        bdrv_do_drained_begin(bs, true, NULL);
         aio_context_release(aio_context);
 
         if (!g_slist_find(aio_ctxs, aio_context)) {
@@ -458,11 +455,8 @@ void bdrv_drain_all_end(void)
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
-        /* Re-enable things in child-to-parent order */
         aio_context_acquire(aio_context);
-        bdrv_drain_invoke(bs, false, true);
-        bdrv_parent_drained_end(bs, NULL);
-        aio_enable_external(aio_context);
+        bdrv_do_drained_end(bs, true, NULL);
         aio_context_release(aio_context);
     }
 }
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index fb68539d17..c7f107142c 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -276,8 +276,7 @@ static void test_quiesce_common(enum drain_type drain_type, bool recursive)
 
 static void test_quiesce_drain_all(void)
 {
-    // XXX drain_all doesn't quiesce
-    //test_quiesce_common(BDRV_DRAIN_ALL, true);
+    test_quiesce_common(BDRV_DRAIN_ALL, true);
 }
 
 static void test_quiesce_drain(void)
@@ -319,12 +318,7 @@ static void test_nested(void)
 
     for (outer = 0; outer < DRAIN_TYPE_MAX; outer++) {
         for (inner = 0; inner < DRAIN_TYPE_MAX; inner++) {
-            /* XXX bdrv_drain_all() doesn't increase the quiesce_counter */
-            int bs_quiesce      = (outer != BDRV_DRAIN_ALL) +
-                                  (inner != BDRV_DRAIN_ALL);
-            int backing_quiesce = (outer == BDRV_SUBTREE_DRAIN) +
-                                  (inner == BDRV_SUBTREE_DRAIN);
-            int backing_cb_cnt  = (outer != BDRV_DRAIN) +
+            int backing_quiesce = (outer != BDRV_DRAIN) +
                                   (inner != BDRV_DRAIN);
 
             g_assert_cmpint(bs->quiesce_counter, ==, 0);
@@ -335,10 +329,10 @@ static void test_nested(void)
             do_drain_begin(outer, bs);
             do_drain_begin(inner, bs);
 
-            g_assert_cmpint(bs->quiesce_counter, ==, bs_quiesce);
+            g_assert_cmpint(bs->quiesce_counter, ==, 2);
             g_assert_cmpint(backing->quiesce_counter, ==, backing_quiesce);
             g_assert_cmpint(s->drain_count, ==, 2);
-            g_assert_cmpint(backing_s->drain_count, ==, backing_cb_cnt);
+            g_assert_cmpint(backing_s->drain_count, ==, backing_quiesce);
 
             do_drain_end(inner, bs);
             do_drain_end(outer, bs);
-- 
2.13.6
