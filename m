Received: from eggs.gnu.org ([2001:4830:134:3::10]:38130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eihrI-0002An-70
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eihrD-0006CV-6V
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:35:00 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:04 +0200
Message-Id: <da3575d47c9a181a2cfd4715e53dd84a2c651017.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 04/39] qcow2: Remove BDS parameter from
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This function was only using the BlockDriverState parameter to get the
cache table size (since it was equal to the cluster size). This is no
longer necessary so this parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cache.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index a481ef499a..3749d55595 100644
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
@@ -411,7 +410,7 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
 
 void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
 {
-    int i = qcow2_cache_get_table_idx(bs, c, *table);
+    int i = qcow2_cache_get_table_idx(c, *table);
 
     c->entries[i].ref--;
     *table = NULL;
@@ -426,7 +425,7 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
 void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
      void *table)
 {
-    int i = qcow2_cache_get_table_idx(bs, c, table);
+    int i = qcow2_cache_get_table_idx(c, table);
     assert(c->entries[i].offset != 0);
     c->entries[i].dirty = true;
 }
@@ -446,7 +445,7 @@ void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
 
 void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table)
 {
-    int i = qcow2_cache_get_table_idx(bs, c, table);
+    int i = qcow2_cache_get_table_idx(c, table);
 
     assert(c->entries[i].ref == 0);
 
-- 
2.11.0
