Received: from eggs.gnu.org ([2001:4830:134:3::10]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBx-0005oS-5e
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBw-0001JV-2h
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:48 +0200
Message-Id: <1497634636-20230-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/31] qed: Remove callback from
 qed_read_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Instead of passing the return value to a callback, return it to the
caller so that the callback can be inlined there.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed-table.c | 79 ++++++++++++++++++-------------------------------------
 1 file changed, 25 insertions(+), 54 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index f330538..4270003 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -18,8 +18,7 @@
 #include "qed.h"
 #include "qemu/bswap.h"
 
-static void qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
-                           BlockCompletionFunc *cb, void *opaque)
+static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
 {
     QEMUIOVector qiov;
     int noffsets;
@@ -50,7 +49,7 @@ static void qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
 out:
     /* Completion */
     trace_qed_read_table_cb(s, table, ret);
-    cb(opaque, ret);
+    return ret;
 }
 
 typedef struct {
@@ -156,13 +155,7 @@ static void qed_sync_cb(void *opaque, int ret)
 
 int qed_read_l1_table_sync(BDRVQEDState *s)
 {
-    int ret = -EINPROGRESS;
-
-    qed_read_table(s, s->header.l1_table_offset,
-                   s->l1_table, qed_sync_cb, &ret);
-    BDRV_POLL_WHILE(s->bs, ret == -EINPROGRESS);
-
-    return ret;
+    return qed_read_table(s, s->header.l1_table_offset, s->l1_table);
 }
 
 void qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n,
@@ -184,46 +177,10 @@ int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
     return ret;
 }
 
-typedef struct {
-    GenericCB gencb;
-    BDRVQEDState *s;
-    uint64_t l2_offset;
-    QEDRequest *request;
-} QEDReadL2TableCB;
-
-static void qed_read_l2_table_cb(void *opaque, int ret)
-{
-    QEDReadL2TableCB *read_l2_table_cb = opaque;
-    QEDRequest *request = read_l2_table_cb->request;
-    BDRVQEDState *s = read_l2_table_cb->s;
-    CachedL2Table *l2_table = request->l2_table;
-    uint64_t l2_offset = read_l2_table_cb->l2_offset;
-
-    qed_acquire(s);
-    if (ret) {
-        /* can't trust loaded L2 table anymore */
-        qed_unref_l2_cache_entry(l2_table);
-        request->l2_table = NULL;
-    } else {
-        l2_table->offset = l2_offset;
-
-        qed_commit_l2_cache_entry(&s->l2_cache, l2_table);
-
-        /* This is guaranteed to succeed because we just committed the entry
-         * to the cache.
-         */
-        request->l2_table = qed_find_l2_cache_entry(&s->l2_cache, l2_offset);
-        assert(request->l2_table != NULL);
-    }
-    qed_release(s);
-
-    gencb_complete(&read_l2_table_cb->gencb, ret);
-}
-
 void qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset,
                        BlockCompletionFunc *cb, void *opaque)
 {
-    QEDReadL2TableCB *read_l2_table_cb;
+    int ret;
 
     qed_unref_l2_cache_entry(request->l2_table);
 
@@ -237,14 +194,28 @@ void qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset,
     request->l2_table = qed_alloc_l2_cache_entry(&s->l2_cache);
     request->l2_table->table = qed_alloc_table(s);
 
-    read_l2_table_cb = gencb_alloc(sizeof(*read_l2_table_cb), cb, opaque);
-    read_l2_table_cb->s = s;
-    read_l2_table_cb->l2_offset = offset;
-    read_l2_table_cb->request = request;
-
     BLKDBG_EVENT(s->bs->file, BLKDBG_L2_LOAD);
-    qed_read_table(s, offset, request->l2_table->table,
-                   qed_read_l2_table_cb, read_l2_table_cb);
+    ret = qed_read_table(s, offset, request->l2_table->table);
+
+    qed_acquire(s);
+    if (ret) {
+        /* can't trust loaded L2 table anymore */
+        qed_unref_l2_cache_entry(request->l2_table);
+        request->l2_table = NULL;
+    } else {
+        request->l2_table->offset = offset;
+
+        qed_commit_l2_cache_entry(&s->l2_cache, request->l2_table);
+
+        /* This is guaranteed to succeed because we just committed the entry
+         * to the cache.
+         */
+        request->l2_table = qed_find_l2_cache_entry(&s->l2_cache, offset);
+        assert(request->l2_table != NULL);
+    }
+    qed_release(s);
+
+    cb(opaque, ret);
 }
 
 int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
-- 
1.8.3.1
