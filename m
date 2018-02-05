Received: from eggs.gnu.org ([2001:4830:134:3::10]:38137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eihrI-0002At-8p
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eihrD-0006CQ-6B
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:35:00 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:05 +0200
Message-Id: <7c1b262344375d52544525f85bbbf0548d5ba575.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 05/39] qcow2: Remove BDS parameter from
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
index 3749d55595..5ff2cbf5c5 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -71,8 +71,7 @@ static inline const char *qcow2_cache_get_name(BDRVQcow2State *s, Qcow2Cache *c)
     }
 }
 
-static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
-                                      int i, int num_tables)
+static void qcow2_cache_table_release(Qcow2Cache *c, int i, int num_tables)
 {
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
@@ -114,7 +113,7 @@ void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c)
         }
 
         if (to_clean > 0) {
-            qcow2_cache_table_release(bs, c, i - to_clean, to_clean);
+            qcow2_cache_table_release(c, i - to_clean, to_clean);
         }
     }
 
@@ -306,7 +305,7 @@ int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c)
         c->entries[i].lru_counter = 0;
     }
 
-    qcow2_cache_table_release(bs, c, 0, c->size);
+    qcow2_cache_table_release(c, 0, c->size);
 
     c->lru_counter = 0;
 
@@ -453,5 +452,5 @@ void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table)
     c->entries[i].lru_counter = 0;
     c->entries[i].dirty = false;
 
-    qcow2_cache_table_release(bs, c, i, 1);
+    qcow2_cache_table_release(c, i, 1);
 }
-- 
2.11.0
