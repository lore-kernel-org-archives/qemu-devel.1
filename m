Received: from eggs.gnu.org ([2001:4830:134:3::10]:55498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVG-0000Wn-S5
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003JV-Tz
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:14 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:37 +0100
Message-Id: <f12fbd9730ce538671581bcdefce5fb5a048644d.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 09/32] qcow2: Remove BDS parameter from
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

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
index 49f43d304a..402ae952e0 100644
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
index 32a2fb15db..bdac1c156f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -696,8 +696,8 @@ static void cache_clean_timer_cb(void *opaque)
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
index a9a6a1c0b5..a9d619576a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -649,7 +649,7 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
     Qcow2Cache *dependency);
 void qcow2_cache_depends_on_flush(Qcow2Cache *c);
 
-void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c);
+void qcow2_cache_clean_unused(Qcow2Cache *c);
 int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c);
 
 int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
-- 
2.11.0
