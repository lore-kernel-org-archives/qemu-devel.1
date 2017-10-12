Received: from eggs.gnu.org ([2001:4830:134:3::10]:45294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dK7-0004Jq-04
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dK3-0006fN-KP
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:50 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:18 +0300
Message-Id: <912f77493be99ef2945f0adacc2a78a3f4d62078.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 04/31] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_idx()
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

This function was only using the BlockDriverState parameter to get the
cache table size (since it was equal to the cluster size). This is no
longer necessary so this parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 98bd77f3fb..cba6a165e8 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -51,8 +51,7 @@ static inline void *qcow2_cache_get_table_addr(Qcow2Cache *c, int table)
     return (uint8_t *) c->table_array + (size_t) table * c->table_size;
 }
 
-static inline int qcow2_cache_get_table_idx(BlockDriverState *bs,
-                  Qcow2Cache *c, void *table)
+static inline int qcow2_cache_get_table_idx(Qcow2Cache *c, void *table)
 {
     ptrdiff_t table_offset = (uint8_t *) table - (uint8_t *) c->table_array;
     int idx = table_offset / c->table_size;
@@ -390,7 +389,7 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
 
 void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
 {
-    int i = qcow2_cache_get_table_idx(bs, c, *table);
+    int i = qcow2_cache_get_table_idx(c, *table);
 
     c->entries[i].ref--;
     *table = NULL;
@@ -405,7 +404,7 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
 void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
      void *table)
 {
-    int i = qcow2_cache_get_table_idx(bs, c, table);
+    int i = qcow2_cache_get_table_idx(c, table);
     assert(c->entries[i].offset != 0);
     c->entries[i].dirty = true;
 }
@@ -425,7 +424,7 @@ void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
 
 void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table)
 {
-    int i = qcow2_cache_get_table_idx(bs, c, table);
+    int i = qcow2_cache_get_table_idx(c, table);
 
     assert(c->entries[i].ref == 0);
 
-- 
2.11.0
