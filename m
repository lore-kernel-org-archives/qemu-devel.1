Received: from eggs.gnu.org ([2001:4830:134:3::10]:35538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqU0-0002Sm-CM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqTw-0006sd-8x
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:40 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:43313 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1ejqTw-0006rC-01
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:36 -0500
From: <antonios.motakis@huawei.com>
Date: Thu, 8 Feb 2018 19:00:18 +0100
Message-ID: <20180208180019.13683-4-antonios.motakis@huawei.com>
In-Reply-To: <20180208180019.13683-1-antonios.motakis@huawei.com>
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] 9pfs: stat_to_qid: use device as input to
 qid.path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, groug@kaod.org
Cc: veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, cota@braap.org, berrange@redhat.com, Antonios Motakis <antonios.motakis@huawei.com>

From: Antonios Motakis <antonios.motakis@huawei.com>

To support multiple devices on the 9p share, and avoid
qid path collisions we take the device id as input
to generate a unique QID path. The lowest 48 bits of
the path will be set equal to the file inode, and the
top bits will be uniquely assigned based on the top
16 bits of the inode and the device id.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
---
 hw/9pfs/9p.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 hw/9pfs/9p.h | 13 ++++++++-
 2 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4da858f..f434f05 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -25,6 +25,8 @@
 #include "trace.h"
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
+#include "exec/tb-hash-xx.h"
+#include "qemu/qht.h"
 
 int open_fd_hw;
 int total_open_fd;
@@ -572,20 +574,82 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
-/* This is the algorithm from ufs in spfs */
+
+/* creative abuse of tb_hash_func7, which is based on xxhash */
+static uint32_t qpp_hash(QppEntry e)
+{
+    return tb_hash_func7(e.ino_prefix, e.dev, 0, 0, 0);
+}
+
+static bool qpp_lookup_func(const void *obj, const void *userp)
+{
+    const QppEntry *e1 = obj, *e2 = userp;
+    return (e1->dev == e2->dev) && (e1->ino_prefix == e2->ino_prefix);
+}
+
+static void qpp_table_remove(struct qht *ht, void *p, uint32_t h, void *up)
+{
+    g_free(p);
+}
+
+static void qpp_table_destroy(struct qht *ht)
+{
+    qht_iter(ht, qpp_table_remove, NULL);
+    qht_destroy(ht);
+}
+
+/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
+ * to a unique QID path (64 bits). To avoid having to map and keep track
+ * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
+ * the device id to the 16 highest bits of the QID path. The 48 lowest bits
+ * of the QID path equal to the lowest bits of the inode number.
+ *
+ * This takes advantage of the fact that inode number are usually not
+ * random but allocated sequentially, so we have fewer items to keep
+ * track of.
+ */
+static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
+                                uint64_t *path)
+{
+    QppEntry lookup = {
+        .dev = stbuf->st_dev,
+        .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
+    }, *val;
+    uint32_t hash = qpp_hash(lookup);
+
+    val = qht_lookup(&pdu->s->qpp_table, qpp_lookup_func, &lookup, hash);
+
+    if (!val) {
+        if (pdu->s->qp_prefix_next == 0) {
+            /* we ran out of prefixes */
+            return -ENFILE;
+        }
+
+        val = g_malloc0(sizeof(QppEntry));
+        if (!val) {
+            return -ENOMEM;
+        }
+        *val = lookup;
+
+        /* new unique inode prefix and device combo */
+        val->qp_prefix = pdu->s->qp_prefix_next++;
+        qht_insert(&pdu->s->qpp_table, val, hash);
+    }
+
+    *path = ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
+    return 0;
+}
+
 static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
 {
-    size_t size;
+    int err;
 
-    if (pdu->s->dev_id == 0) {
-        pdu->s->dev_id = stbuf->st_dev;
-    } else if (pdu->s->dev_id != stbuf->st_dev) {
-        return -ENOSYS;
+    /* map inode+device to qid path (fast path) */
+    err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+    if (err) {
+        return err;
     }
 
-    memset(&qidp->path, 0, sizeof(qidp->path));
-    size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
-    memcpy(&qidp->path, &stbuf->st_ino, size);
     qidp->version = stbuf->st_mtime ^ (stbuf->st_size << 8);
     qidp->type = 0;
     if (S_ISDIR(stbuf->st_mode)) {
@@ -3626,7 +3690,9 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
         goto out;
     }
 
-    s->dev_id = 0;
+    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
+    qht_init(&s->qpp_table, 1, QHT_MODE_AUTO_RESIZE);
+    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
 
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
@@ -3641,6 +3707,7 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
+        qpp_table_destroy(&s->qpp_table);
         v9fs_path_free(&path);
     }
     return rc;
@@ -3653,6 +3720,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
+    qpp_table_destroy(&s->qpp_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index afb4ebd..80428f7 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -8,6 +8,7 @@
 #include "fsdev/9p-iov-marshal.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/qht.h"
 
 enum {
     P9_TLERROR = 6,
@@ -231,6 +232,15 @@ struct V9fsFidState
     V9fsFidState *rclm_lst;
 };
 
+#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
+
+/* QID path prefix entry, see stat_to_qid */
+typedef struct {
+    dev_t dev;
+    uint16_t ino_prefix;
+    uint16_t qp_prefix;
+} QppEntry;
+
 struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
@@ -252,7 +262,8 @@ struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
-    dev_t dev_id;
+    struct qht qpp_table;
+    uint16_t qp_prefix_next;
 };
 
 /* 9p2000.L open flags */
-- 
1.8.3.1
