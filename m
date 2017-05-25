Received: from eggs.gnu.org ([2001:4830:134:3::10]:33059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qE-K5
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002fr-In
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:29617 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002fF-79
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:24 +0300
Message-Id: <20170525152628.37628-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-1-vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/7] qcow2: add .bdrv_get_format_allocated_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Realize .bdrv_get_format_allocated_size interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |  2 ++
 block/qcow2.h          |  2 ++
 3 files changed, 65 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061aae..45adf6bd1d 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2931,3 +2931,64 @@ done:
     qemu_vfree(new_refblock);
     return ret;
 }
+
+typedef struct NbAllocatedClustersCo {
+    BlockDriverState *bs;
+    int64_t ret;
+} NbAllocatedClustersCo;
+
+static void coroutine_fn qcow2_get_format_allocated_size_co_entry(void *opaque)
+{
+    NbAllocatedClustersCo *nbco = opaque;
+    BlockDriverState *bs = nbco->bs;
+    BDRVQcow2State *s = bs->opaque;
+    int64_t size, nb_clusters, nb_allocated = 0, i;
+    int ret = 0;
+
+    size = bdrv_getlength(bs->file->bs);
+    if (size < 0) {
+        nbco->ret = size;
+        return;
+    }
+
+    nb_clusters = size_to_clusters(s, size);
+
+    qemu_co_mutex_lock(&s->lock);
+
+    for (i = 0; i < nb_clusters; ++i) {
+        uint64_t refcount;
+        ret = qcow2_get_refcount(bs, i, &refcount);
+        if (ret < 0) {
+            nbco->ret = ret;
+            qemu_co_mutex_unlock(&s->lock);
+            return;
+        }
+        if (refcount > 0) {
+            nb_allocated++;
+        }
+    }
+
+    qemu_co_mutex_unlock(&s->lock);
+
+    nbco->ret = nb_allocated << s->cluster_bits;
+}
+
+int64_t qcow2_get_format_allocated_size(BlockDriverState *bs)
+{
+    NbAllocatedClustersCo nbco = {
+        .bs = bs,
+        .ret = -EINPROGRESS
+    };
+
+    if (qemu_in_coroutine()) {
+        qcow2_get_format_allocated_size_co_entry(&nbco);
+    } else {
+        Coroutine *co =
+            qemu_coroutine_create(qcow2_get_format_allocated_size_co_entry,
+                                  &nbco);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(bs, nbco.ret == -EINPROGRESS);
+    }
+
+    return nbco.ret;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index a8d61f0981..274f213d16 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3469,6 +3469,8 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
+
+    .bdrv_get_format_allocated_size = qcow2_get_format_allocated_size,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc30dc..8cc63d9e0e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -532,6 +532,8 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 BlockDriverAmendStatusCB *status_cb,
                                 void *cb_opaque, Error **errp);
 
+int64_t qcow2_get_format_allocated_size(BlockDriverState *bs);
+
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size);
-- 
2.11.1
