Received: from eggs.gnu.org ([2001:4830:134:3::10]:47876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5zX-0000mU-9A
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5zW-0002C5-DK
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:32:35 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 16:59:36 +0200
Message-Id: <9373dc21083ea85c3fded0edd717ad4f61fb68dc.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 09/39] qcow2: Remove BDS parameter from
 qcow2_cache_clean_unused()
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

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_table_release(). This is no longer necessary so this
parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-cache.c | 2 +-
 block/qcow2.c       | 4 ++--
 block/qcow2.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 6f17a28635..03b3e03c6c 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -93,7 +93,7 @@ static inline bool can_clean_entry(Qcow2Cache *c, int i)
         t->lru_counter <= c->cache_clean_lru_counter;
 }
 
-void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c)
+void qcow2_cache_clean_unused(Qcow2Cache *c)
 {
     int i = 0;
     while (i < c->size) {
diff --git a/block/qcow2.c b/block/qcow2.c
index 8e64c12605..e2d4bf7ad5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -704,8 +704,8 @@ static void cache_clean_timer_cb(void *opaque)
 {
     BlockDriverState *bs = opaque;
     BDRVQcow2State *s = bs->opaque;
-    qcow2_cache_clean_unused(bs, s->l2_table_cache);
-    qcow2_cache_clean_unused(bs, s->refcount_block_cache);
+    qcow2_cache_clean_unused(s->l2_table_cache);
+    qcow2_cache_clean_unused(s->refcount_block_cache);
     timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
               (int64_t) s->cache_clean_interval * 1000);
 }
diff --git a/block/qcow2.h b/block/qcow2.h
index e0c429aef2..7e2781ffa4 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -646,7 +646,7 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
     Qcow2Cache *dependency);
 void qcow2_cache_depends_on_flush(Qcow2Cache *c);
 
-void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c);
+void qcow2_cache_clean_unused(Qcow2Cache *c);
 int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c);
 
 int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
-- 
2.11.0
