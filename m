Received: from eggs.gnu.org ([2001:4830:134:3::10]:52544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1r-00036R-LO
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1q-0005Sr-LM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:59 +0100
Message-Id: <20180213170529.10858-26-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/55] qcow2: Remove BDS parameter from
 qcow2_cache_clean_unused()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_table_release(). This is no longer necessary so this
parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: b74f17591af52f201de0ea3a3b2dd0a81932334d.1517840876.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h       | 2 +-
 block/qcow2-cache.c | 2 +-
 block/qcow2.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 9936cd0700..867f2e8828 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -646,7 +646,7 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
     Qcow2Cache *dependency);
 void qcow2_cache_depends_on_flush(Qcow2Cache *c);
 
-void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c);
+void qcow2_cache_clean_unused(Qcow2Cache *c);
 int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c);
 
 int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
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
index 38e7fdc4b0..461cc7ab1c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -706,8 +706,8 @@ static void cache_clean_timer_cb(void *opaque)
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
-- 
2.13.6
