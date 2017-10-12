Received: from eggs.gnu.org ([2001:4830:134:3::10]:44869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dJI-0003gA-GI
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dJF-0005za-4V
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:00 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:19 +0300
Message-Id: <a87e437600f689947a2289c62838e78ae7b49af7.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 05/31] qcow2: Remove BDS parameter from
 qcow2_cache_table_release()
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
index cba6a165e8..dac99e95b0 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -59,8 +59,7 @@ static inline int qcow2_cache_get_table_idx(Qcow2Cache *c, void *table)
     return idx;
 }
 
-static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
-                                      int i, int num_tables)
+static void qcow2_cache_table_release(Qcow2Cache *c, int i, int num_tables)
 {
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
@@ -102,7 +101,7 @@ void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c)
         }
 
         if (to_clean > 0) {
-            qcow2_cache_table_release(bs, c, i - to_clean, to_clean);
+            qcow2_cache_table_release(c, i - to_clean, to_clean);
         }
     }
 
@@ -294,7 +293,7 @@ int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c)
         c->entries[i].lru_counter = 0;
     }
 
-    qcow2_cache_table_release(bs, c, 0, c->size);
+    qcow2_cache_table_release(c, 0, c->size);
 
     c->lru_counter = 0;
 
@@ -432,5 +431,5 @@ void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table)
     c->entries[i].lru_counter = 0;
     c->entries[i].dirty = false;
 
-    qcow2_cache_table_release(bs, c, i, 1);
+    qcow2_cache_table_release(c, i, 1);
 }
-- 
2.11.0
