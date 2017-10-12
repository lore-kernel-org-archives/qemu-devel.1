Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dHv-0002YI-Ed
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dHr-0004f7-8R
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:12:35 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:22 +0300
Message-Id: <070b0cebec08d8f7445a6d58e34075f64a239269.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 08/31] qcow2: Remove BDS parameter from
 qcow2_cache_destroy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

This function was never using the BlockDriverState parameter so it can
be safely removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c |  2 +-
 block/qcow2.c       | 16 ++++++++--------
 block/qcow2.h       |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index bd2bc7e063..a50a56bd8b 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -130,7 +130,7 @@ Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables)
     return c;
 }
 
-int qcow2_cache_destroy(BlockDriverState *bs, Qcow2Cache *c)
+int qcow2_cache_destroy(Qcow2Cache *c)
 {
     int i;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index dff903e05c..ba8139f82c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1031,10 +1031,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
     int i;
 
     if (s->l2_table_cache) {
-        qcow2_cache_destroy(bs, s->l2_table_cache);
+        qcow2_cache_destroy(s->l2_table_cache);
     }
     if (s->refcount_block_cache) {
-        qcow2_cache_destroy(bs, s->refcount_block_cache);
+        qcow2_cache_destroy(s->refcount_block_cache);
     }
     s->l2_table_cache = r->l2_table_cache;
     s->refcount_block_cache = r->refcount_block_cache;
@@ -1060,10 +1060,10 @@ static void qcow2_update_options_abort(BlockDriverState *bs,
                                        Qcow2ReopenState *r)
 {
     if (r->l2_table_cache) {
-        qcow2_cache_destroy(bs, r->l2_table_cache);
+        qcow2_cache_destroy(r->l2_table_cache);
     }
     if (r->refcount_block_cache) {
-        qcow2_cache_destroy(bs, r->refcount_block_cache);
+        qcow2_cache_destroy(r->refcount_block_cache);
     }
     qapi_free_QCryptoBlockOpenOptions(r->crypto_opts);
 }
@@ -1492,10 +1492,10 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     s->l1_table = NULL;
     cache_clean_timer_del(bs);
     if (s->l2_table_cache) {
-        qcow2_cache_destroy(bs, s->l2_table_cache);
+        qcow2_cache_destroy(s->l2_table_cache);
     }
     if (s->refcount_block_cache) {
-        qcow2_cache_destroy(bs, s->refcount_block_cache);
+        qcow2_cache_destroy(s->refcount_block_cache);
     }
     qcrypto_block_free(s->crypto);
     qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
@@ -2078,8 +2078,8 @@ static void qcow2_close(BlockDriverState *bs)
     }
 
     cache_clean_timer_del(bs);
-    qcow2_cache_destroy(bs, s->l2_table_cache);
-    qcow2_cache_destroy(bs, s->refcount_block_cache);
+    qcow2_cache_destroy(s->l2_table_cache);
+    qcow2_cache_destroy(s->refcount_block_cache);
 
     qcrypto_block_free(s->crypto);
     s->crypto = NULL;
diff --git a/block/qcow2.h b/block/qcow2.h
index 7fa195bc22..ddf60fa290 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -646,7 +646,7 @@ int qcow2_read_snapshots(BlockDriverState *bs);
 
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
-int qcow2_cache_destroy(BlockDriverState* bs, Qcow2Cache *c);
+int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
 int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
-- 
2.11.0
