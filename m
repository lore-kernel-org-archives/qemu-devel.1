Received: from eggs.gnu.org ([2001:4830:134:3::10]:55493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVG-0000Wk-Oq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003HC-5c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:14 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:36 +0100
Message-Id: <eb8ef83fece2863b8a209570a2a994a66f357c16.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 08/32] qcow2: Remove BDS parameter from
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This function was never using the BlockDriverState parameter so it can
be safely removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c |  2 +-
 block/qcow2.c       | 16 ++++++++--------
 block/qcow2.h       |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 10f0b7fa87..49f43d304a 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -142,7 +142,7 @@ Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables)
     return c;
 }
 
-int qcow2_cache_destroy(BlockDriverState *bs, Qcow2Cache *c)
+int qcow2_cache_destroy(Qcow2Cache *c)
 {
     int i;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 1914a940e5..32a2fb15db 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1034,10 +1034,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
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
@@ -1063,10 +1063,10 @@ static void qcow2_update_options_abort(BlockDriverState *bs,
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
@@ -1504,10 +1504,10 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -2090,8 +2090,8 @@ static void qcow2_close(BlockDriverState *bs)
     }
 
     cache_clean_timer_del(bs);
-    qcow2_cache_destroy(bs, s->l2_table_cache);
-    qcow2_cache_destroy(bs, s->refcount_block_cache);
+    qcow2_cache_destroy(s->l2_table_cache);
+    qcow2_cache_destroy(s->refcount_block_cache);
 
     qcrypto_block_free(s->crypto);
     s->crypto = NULL;
diff --git a/block/qcow2.h b/block/qcow2.h
index e78d0c2316..a9a6a1c0b5 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -640,7 +640,7 @@ int qcow2_read_snapshots(BlockDriverState *bs);
 
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
-int qcow2_cache_destroy(BlockDriverState* bs, Qcow2Cache *c);
+int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
 int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
-- 
2.11.0
