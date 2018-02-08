Received: from eggs.gnu.org ([2001:4830:134:3::10]:35513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqTz-0002S5-7D
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqTw-0006sc-8s
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:39 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:43314 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1ejqTv-0006rD-Vk
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:36 -0500
From: <antonios.motakis@huawei.com>
Date: Thu, 8 Feb 2018 19:00:19 +0100
Message-ID: <20180208180019.13683-5-antonios.motakis@huawei.com>
In-Reply-To: <20180208180019.13683-1-antonios.motakis@huawei.com>
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] 9pfs: stat_to_qid: implement slow path
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

stat_to_qid attempts via qid_path_prefixmap to map unique files
(which are identified by 64bt inode nr and 32 bit device id)
to a 64 QID path value. However this implementation makes some
assumptions about inode number generation on the host.

If qid_path_prefixmap fails, we still have 48bits available in
the QID path to fall back to a less memory efficient full mapping.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
---
 hw/9pfs/9p.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h |  9 +++++++++
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f434f05..ae7845d 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -581,23 +581,72 @@ static uint32_t qpp_hash(QppEntry e)
     return tb_hash_func7(e.ino_prefix, e.dev, 0, 0, 0);
 }
 
+static uint32_t qpf_hash(QpfEntry e)
+{
+    return tb_hash_func7(e.ino, e.dev, 0, 0, 0);
+}
+
 static bool qpp_lookup_func(const void *obj, const void *userp)
 {
     const QppEntry *e1 = obj, *e2 = userp;
     return (e1->dev == e2->dev) && (e1->ino_prefix == e2->ino_prefix);
 }
 
-static void qpp_table_remove(struct qht *ht, void *p, uint32_t h, void *up)
+static bool qpf_lookup_func(const void *obj, const void *userp)
+{
+    const QpfEntry *e1 = obj, *e2 = userp;
+    return (e1->dev == e2->dev) && (e1->ino == e2->ino);
+}
+
+static void qp_table_remove(struct qht *ht, void *p, uint32_t h, void *up)
 {
     g_free(p);
 }
 
-static void qpp_table_destroy(struct qht *ht)
+static void qp_table_destroy(struct qht *ht)
 {
-    qht_iter(ht, qpp_table_remove, NULL);
+    qht_iter(ht, qp_table_remove, NULL);
     qht_destroy(ht);
 }
 
+static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
+                            uint64_t *path)
+{
+    QpfEntry lookup = {
+        .dev = stbuf->st_dev,
+        .ino = stbuf->st_ino
+    }, *val;
+    uint32_t hash = qpf_hash(lookup);
+
+    /* most users won't need the fullmap, so init the table lazily */
+    if (!pdu->s->qpf_table.map) {
+        qht_init(&pdu->s->qpf_table, 1 << 16, QHT_MODE_AUTO_RESIZE);
+    }
+
+    val = qht_lookup(&pdu->s->qpf_table, qpf_lookup_func, &lookup, hash);
+
+    if (!val) {
+        if (pdu->s->qp_fullpath_next == 0) {
+            /* no more files can be mapped :'( */
+            return -ENFILE;
+        }
+
+        val = g_malloc0(sizeof(QppEntry));
+        if (!val) {
+            return -ENOMEM;
+        }
+        *val = lookup;
+
+        /* new unique inode and device combo */
+        val->path = pdu->s->qp_fullpath_next++;
+        pdu->s->qp_fullpath_next &= QPATH_INO_MASK;
+        qht_insert(&pdu->s->qpf_table, val, hash);
+    }
+
+    *path = val->path;
+    return 0;
+}
+
 /* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
  * to a unique QID path (64 bits). To avoid having to map and keep track
  * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
@@ -646,6 +695,10 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
 
     /* map inode+device to qid path (fast path) */
     err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
+    if (err == -ENFILE) {
+        /* fast path didn't work, fal back to full map */
+        err = qid_path_fullmap(pdu, stbuf, &qidp->path);
+    }
     if (err) {
         return err;
     }
@@ -3693,6 +3746,7 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     /* QID path hash table. 1 entry ought to be enough for anybody ;) */
     qht_init(&s->qpp_table, 1, QHT_MODE_AUTO_RESIZE);
     s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+    s->qp_fullpath_next = 1;
 
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
@@ -3707,7 +3761,8 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
-        qpp_table_destroy(&s->qpp_table);
+        qp_table_destroy(&s->qpp_table);
+        qp_table_destroy(&s->qpf_table);
         v9fs_path_free(&path);
     }
     return rc;
@@ -3720,7 +3775,8 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
-    qpp_table_destroy(&s->qpp_table);
+    qp_table_destroy(&s->qpp_table);
+    qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
 }
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 80428f7..b561f4a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -241,6 +241,13 @@ typedef struct {
     uint16_t qp_prefix;
 } QppEntry;
 
+/* QID path full entry, as above */
+typedef struct {
+    dev_t dev;
+    ino_t ino;
+    uint64_t path;
+} QpfEntry;
+
 struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
@@ -263,7 +270,9 @@ struct V9fsState
     V9fsConf fsconf;
     V9fsQID root_qid;
     struct qht qpp_table;
+    struct qht qpf_table;
     uint16_t qp_prefix_next;
+    uint64_t qp_fullpath_next;
 };
 
 /* 9p2000.L open flags */
-- 
1.8.3.1
