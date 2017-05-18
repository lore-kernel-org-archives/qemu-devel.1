Received: from eggs.gnu.org ([2001:4830:134:3::10]:40910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dBINP-0002nO-RS
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dBINM-0005Z6-Jc
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:09:47 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47700 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dBINM-0005Z2-8I
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:09:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 18 May 2017 13:09:25 +0300
Message-Id: <20170518100925.28682-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] qcow2: add allocated-size to image specific
 info
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

Shows, how much data qcow2 allocates in underlying file. This should
be helpful on non-sparse file systems, when qemu-img info "disk size"
doesn't provide this information.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all.

Here is an allocated-size feature for qemu-img info.

 block/qcow2-refcount.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |  4 ++++
 block/qcow2.h          |  2 ++
 qapi/block-core.json   |  6 ++++-
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061aae..a2f7696a0a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2931,3 +2931,63 @@ done:
     qemu_vfree(new_refblock);
     return ret;
 }
+
+typedef struct NbAllocatedClustersCo {
+    BlockDriverState *bs;
+    int64_t ret;
+} NbAllocatedClustersCo;
+
+static void coroutine_fn qcow2_nb_allocated_clusters_co_entry(void *opaque)
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
+    nbco->ret = nb_allocated;
+}
+
+int64_t qcow2_nb_allocated_clusters(BlockDriverState *bs)
+{
+    NbAllocatedClustersCo nbco = {
+        .bs = bs,
+        .ret = -EINPROGRESS
+    };
+
+    if (qemu_in_coroutine()) {
+        qcow2_nb_allocated_clusters_co_entry(&nbco);
+    } else {
+        Coroutine *co =
+            qemu_coroutine_create(qcow2_nb_allocated_clusters_co_entry, &nbco);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(bs, nbco.ret == -EINPROGRESS);
+    }
+
+    return nbco.ret;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index a8d61f0981..9a64b89ba2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2927,6 +2927,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
             .refcount_bits      = s->refcount_bits,
         };
     } else if (s->qcow_version == 3) {
+        int64_t nb_allocated = qcow2_nb_allocated_clusters(bs);
+
         *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
             .compat             = g_strdup("1.1"),
             .lazy_refcounts     = s->compatible_features &
@@ -2936,6 +2938,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        = true,
             .refcount_bits      = s->refcount_bits,
+            .allocated_size     = MAX(0, nb_allocated) << s->cluster_bits,
+            .has_allocated_size = nb_allocated >= 0,
         };
     } else {
         /* if this assertion fails, this probably means a new version was
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc30dc..a0f0bf9358 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -532,6 +532,8 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 BlockDriverAmendStatusCB *status_cb,
                                 void *cb_opaque, Error **errp);
 
+int64_t qcow2_nb_allocated_clusters(BlockDriverState *bs);
+
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b974b952f..ddaffff830 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -44,6 +44,9 @@
 #
 # @refcount-bits: width of a refcount entry in bits (since 2.3)
 #
+# @allocated-size: number of allocated clusters (including metadata)
+#                  if available; only valid for compat >= 1.1 (since v2.10)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -51,7 +54,8 @@
       'compat': 'str',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
-      'refcount-bits': 'int'
+      'refcount-bits': 'int',
+      '*allocated-size': 'uint64'
   } }
 
 ##
-- 
2.11.1
