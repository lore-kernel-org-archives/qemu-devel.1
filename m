Received: from eggs.gnu.org ([2001:4830:134:3::10]:37663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbUnx-0005xb-QZ
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbUnu-00012J-MC
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:29 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47693 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dbUnu-00011O-6H
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:26 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Jul 2017 19:41:03 +0300
Message-Id: <20170729164104.29537-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170729164104.29537-1-vsementsov@virtuozzo.com>
References: <20170729164104.29537-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 2/3] qcow2: add .bdrv_get_format_alloc_stat
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

Realize .bdrv_get_format_alloc_stat interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |   2 +
 block/qcow2.h          |   2 +
 3 files changed, 156 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061aae..fd6027f0c2 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2931,3 +2931,155 @@ done:
     qemu_vfree(new_refblock);
     return ret;
 }
+
+typedef struct FormatAllocStatCo {
+    BlockDriverState *bs;
+    BlockFormatAllocInfo *bfai;
+    int64_t ret;
+} FormatAllocStatCo;
+
+static void coroutine_fn qcow2_get_format_alloc_stat_entry(void *opaque)
+{
+    int ret = 0;
+    FormatAllocStatCo *nbco = opaque;
+    BlockDriverState *bs = nbco->bs;
+    BDRVQcow2State *s = bs->opaque;
+    BlockFormatAllocInfo *bfai = nbco->bfai;
+    int64_t cluster, file_sectors, sector;
+    int refcount_block_offset;
+    uint32_t i;
+    bool used = false, f_data = false, f_zero = false;
+    int dif, num = 0, f_num = 0;
+
+    memset(bfai, 0, sizeof(*bfai));
+
+    file_sectors = bdrv_nb_sectors(bs->file->bs);
+    if (file_sectors < 0) {
+        nbco->ret = file_sectors;
+        return;
+    }
+
+    qemu_co_mutex_lock(&s->lock);
+
+    for (sector = 0; sector < file_sectors; sector += dif) {
+        if (f_num == 0) {
+            BlockDriverState *file;
+            ret = bdrv_get_block_status(bs->file->bs, sector,
+                                        file_sectors - sector, &f_num, &file);
+            if (ret < 0) {
+                goto fail;
+            }
+            f_data = ret & BDRV_BLOCK_DATA;
+            f_zero = ret & BDRV_BLOCK_ZERO;
+        }
+
+        if (num == 0) {
+            uint64_t refcount;
+            assert(((sector << BDRV_SECTOR_BITS) & (s->cluster_size - 1)) == 0);
+            ret = qcow2_get_refcount(
+                bs, (sector << BDRV_SECTOR_BITS) >> s->cluster_bits, &refcount);
+            if (ret < 0) {
+                goto fail;
+            }
+            used = refcount > 0;
+            num = s->cluster_size >> BDRV_SECTOR_BITS;
+        }
+
+        dif = MIN(f_num, MIN(num, file_sectors - sector));
+        if (used) {
+            if (f_data) {
+                bfai->used_data += dif;
+            } else if (f_zero) {
+                bfai->used_zero += dif;
+            } else {
+                bfai->used_discarded += dif;
+            }
+        } else {
+            if (f_data) {
+                bfai->unused_data += dif;
+            } else if (f_zero) {
+                bfai->unused_zero += dif;
+            } else {
+                bfai->unused_discarded += dif;
+            }
+        }
+        f_num -= dif;
+        num -= dif;
+    }
+
+    assert(f_num == 0);
+
+    if (used) {
+        bfai->used_overrun += num;
+    }
+
+    cluster = size_to_clusters(s, sector << BDRV_SECTOR_BITS);
+    refcount_block_offset = cluster & (s->refcount_block_size - 1);
+    for (i = cluster >> s->refcount_block_bits;
+         i <= s->max_refcount_table_index; i++)
+    {
+        int j;
+
+        if (!(s->refcount_table[i] & REFT_OFFSET_MASK)) {
+            refcount_block_offset = 0;
+            continue;
+        }
+
+        for (j = refcount_block_offset; j < s->refcount_block_size; j++) {
+            uint64_t refcount;
+            cluster = (i << s->refcount_block_bits) + j;
+
+            ret = qcow2_get_refcount(bs, cluster, &refcount);
+            if (ret < 0) {
+                goto fail;
+            }
+            if (refcount > 0) {
+                bfai->used_overrun++;
+            }
+        }
+
+        refcount_block_offset = 0;
+    }
+
+    qemu_co_mutex_unlock(&s->lock);
+
+    bfai->used_data = bfai->used_data << BDRV_SECTOR_BITS;
+    bfai->used_zero = bfai->used_zero << BDRV_SECTOR_BITS;
+    bfai->used_discarded = bfai->used_discarded << BDRV_SECTOR_BITS;
+    bfai->used_overrun = bfai->used_overrun << BDRV_SECTOR_BITS;
+
+    bfai->unused_data = bfai->unused_data << BDRV_SECTOR_BITS;
+    bfai->unused_zero = bfai->unused_zero << BDRV_SECTOR_BITS;
+    bfai->unused_discarded = bfai->unused_discarded << BDRV_SECTOR_BITS;
+
+    nbco->ret = 0;
+    return;
+
+fail:
+    nbco->ret = ret;
+    qemu_co_mutex_unlock(&s->lock);
+}
+
+/* qcow2_get_format_alloc_stat()
+ * Fills @bfai struct. In case of failure @bfai content is unpredicted.
+ */
+int qcow2_get_format_alloc_stat(BlockDriverState *bs,
+                                BlockFormatAllocInfo *bfai)
+{
+    FormatAllocStatCo nbco = {
+        .bs = bs,
+        .bfai = bfai,
+        .ret = -EINPROGRESS
+    };
+
+    if (qemu_in_coroutine()) {
+        qcow2_get_format_alloc_stat_entry(&nbco);
+    } else {
+        Coroutine *co =
+            qemu_coroutine_create(qcow2_get_format_alloc_stat_entry, &nbco);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(bs, nbco.ret == -EINPROGRESS);
+    }
+
+    return nbco.ret;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index a8d61f0981..0e26b548fd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3469,6 +3469,8 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
+
+    .bdrv_get_format_alloc_stat = qcow2_get_format_alloc_stat,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc30dc..16d31a8624 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -598,4 +598,6 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
 void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
 
+int qcow2_get_format_alloc_stat(BlockDriverState *bs,
+                                BlockFormatAllocInfo *bfai);
 #endif
-- 
2.11.1
