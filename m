Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dJc-0003vS-U5
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dJZ-0006FG-CL
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:20 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:23 +0300
Message-Id: <565e039128a3b791d66b9c469b87e4d492245065.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 09/31] qcow2: Remove BDS parameter from
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_table_release(). This is no longer necessary so this
parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 2 +-
 block/qcow2.c       | 4 ++--
 block/qcow2.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index a50a56bd8b..cc7995c4bf 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -81,7 +81,7 @@ static inline bool can_clean_entry(Qcow2Cache *c, int i)
         t->lru_counter <= c->cache_clean_lru_counter;
 }
 
-void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c)
+void qcow2_cache_clean_unused(Qcow2Cache *c)
 {
     int i = 0;
     while (i < c->size) {
diff --git a/block/qcow2.c b/block/qcow2.c
index ba8139f82c..9f55e0a9ff 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -693,8 +693,8 @@ static void cache_clean_timer_cb(void *opaque)
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
index ddf60fa290..9e6b5102f0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -655,7 +655,7 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
     Qcow2Cache *dependency);
 void qcow2_cache_depends_on_flush(Qcow2Cache *c);
 
-void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c);
+void qcow2_cache_clean_unused(Qcow2Cache *c);
 int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c);
 
 int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
-- 
2.11.0
