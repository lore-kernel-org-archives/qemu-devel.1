Received: from eggs.gnu.org ([2001:4830:134:3::10]:55382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0000WR-ED
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003Gq-4b
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:41 +0100
Message-Id: <a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 13/32] qcow2: Add l2_slice_size field to
 BDRVQcow2State
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

The BDRVQcow2State structure contains an l2_size field, which stores
the number of 64-bit entries in an L2 table.

For efficiency reasons we want to be able to load slices instead of
full L2 tables, so we need to know how many entries an L2 slice can
hold.

An L2 slice is the portion of an L2 table that is loaded by the qcow2
cache. At the moment that cache can only load complete tables,
therefore an L2 slice has the same size as an L2 table (one cluster)
and l2_size == l2_slice_size.

Later we'll allow smaller slices, but until then we have to use this
new l2_slice_size field to make the rest of the code ready for that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 3 +++
 block/qcow2.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index bdac1c156f..c1e4bab391 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -797,6 +797,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
 typedef struct Qcow2ReopenState {
     Qcow2Cache *l2_table_cache;
     Qcow2Cache *refcount_block_cache;
+    int l2_slice_size;
     bool use_lazy_refcounts;
     int overlap_check;
     bool discard_passthrough[QCOW2_DISCARD_MAX];
@@ -878,6 +879,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         }
     }
 
+    r->l2_slice_size = s->cluster_size / sizeof(uint64_t);
     r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size);
     r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size);
     if (r->l2_table_cache == NULL || r->refcount_block_cache == NULL) {
@@ -1041,6 +1043,7 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
     }
     s->l2_table_cache = r->l2_table_cache;
     s->refcount_block_cache = r->refcount_block_cache;
+    s->l2_slice_size = r->l2_slice_size;
 
     s->overlap_check = r->overlap_check;
     s->use_lazy_refcounts = r->use_lazy_refcounts;
diff --git a/block/qcow2.h b/block/qcow2.h
index b9510827bb..2435fd786f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -251,6 +251,7 @@ typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
     int cluster_sectors;
+    int l2_slice_size;
     int l2_bits;
     int l2_size;
     int l1_size;
-- 
2.11.0
