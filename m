Received: from eggs.gnu.org ([2001:4830:134:3::10]:49312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMzf5-0001XH-Jx
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 11:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMzf2-0002dX-A7
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 11:04:07 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:29 +0300
Message-ID: <20161230143142.18214-6-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 05/18] block/pcache: statistics collection
 read requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, armbru@redhat.com

Here the rbcache is used as a repository statistics requests, in fact, data
requests are not cached, so we have the ability to store a large  number of
requests. We need statistics requests to determine the sequential requests.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/block/pcache.c b/block/pcache.c
index 7a67618408..296ae382b0 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -13,20 +13,38 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/rbcache.h"
 
+#define PCACHE_OPT_STATS_SIZE "pcache-stats-size"
 
 static QemuOptsList runtime_opts = {
     .name = "pcache",
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
     .desc = {
+        {
+            .name = PCACHE_OPT_STATS_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Total volume of requests for statistics",
+        },
         { /* end of list */ }
     },
 };
 
+#define MB_BITS 20
+#define PCACHE_DEFAULT_STATS_SIZE (3 << MB_BITS)
+
+typedef struct BDRVPCacheState {
+    RBCache *req_stats;
+} BDRVPCacheState;
+
 static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
 {
+    BDRVPCacheState *s = bs->opaque;
+
+    rbcache_search_and_insert(s->req_stats, offset, bytes);
+
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
@@ -37,6 +55,13 @@ static coroutine_fn int pcache_co_pwritev(BlockDriverState *bs, uint64_t offset,
     return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
 }
 
+static void pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
+{
+    uint64_t stats_size = qemu_opt_get_size(opts, PCACHE_OPT_STATS_SIZE,
+                                            PCACHE_DEFAULT_STATS_SIZE);
+    s->req_stats = rbcache_create(NULL, NULL, stats_size, RBCACHE_FIFO, s);
+}
+
 static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
                             Error **errp)
 {
@@ -58,7 +83,9 @@ static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
     if (local_err) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
+        goto fail;
     }
+    pcache_state_init(opts, bs->opaque);
 fail:
     qemu_opts_del(opts);
     return ret;
@@ -66,6 +93,9 @@ fail:
 
 static void pcache_close(BlockDriverState *bs)
 {
+    BDRVPCacheState *s = bs->opaque;
+
+    rbcache_destroy(s->req_stats);
 }
 
 static int64_t pcache_getlength(BlockDriverState *bs)
@@ -81,7 +111,7 @@ static bool pcache_recurse_is_first_non_filter(BlockDriverState *bs,
 
 static BlockDriver bdrv_pcache = {
     .format_name                        = "pcache",
-    .instance_size                      = 0,
+    .instance_size                      = sizeof(BDRVPCacheState),
 
     .bdrv_file_open                     = pcache_file_open,
     .bdrv_close                         = pcache_close,
-- 
2.11.0
