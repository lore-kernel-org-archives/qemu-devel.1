Received: from eggs.gnu.org ([2001:4830:134:3::10]:33523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN0bh-0007Hv-5b
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 12:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN0bd-00059i-W2
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 12:04:41 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:30 +0300
Message-ID: <20161230143142.18214-7-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 06/18] block/pcache: skip large aio read
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

This change will allow more efficient use of cache memory and filter the case
for which the pcache isn't efficient.  We skip requests that are not required in
the optimization and thereby reducing the number of unnecessary readaheads.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/pcache.c b/block/pcache.c
index 296ae382b0..1f3200af63 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -16,6 +16,7 @@
 #include "qemu/rbcache.h"
 
 #define PCACHE_OPT_STATS_SIZE "pcache-stats-size"
+#define PCACHE_OPT_MAX_AIO_SIZE "pcache-max-aio-size"
 
 static QemuOptsList runtime_opts = {
     .name = "pcache",
@@ -26,15 +27,23 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "Total volume of requests for statistics",
         },
+        {
+            .name = PCACHE_OPT_MAX_AIO_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Maximum size of aio which is handled by pcache",
+        },
         { /* end of list */ }
     },
 };
 
+#define KB_BITS 10
 #define MB_BITS 20
 #define PCACHE_DEFAULT_STATS_SIZE (3 << MB_BITS)
+#define PCACHE_DEFAULT_MAX_AIO_SIZE (64 << KB_BITS)
 
 typedef struct BDRVPCacheState {
     RBCache *req_stats;
+    uint64_t max_aio_size;
 } BDRVPCacheState;
 
 static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
@@ -43,7 +52,9 @@ static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
 {
     BDRVPCacheState *s = bs->opaque;
 
-    rbcache_search_and_insert(s->req_stats, offset, bytes);
+    if (s->max_aio_size >= bytes) {
+        rbcache_search_and_insert(s->req_stats, offset, bytes);
+    }
 
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
@@ -60,6 +71,9 @@ static void pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
     uint64_t stats_size = qemu_opt_get_size(opts, PCACHE_OPT_STATS_SIZE,
                                             PCACHE_DEFAULT_STATS_SIZE);
     s->req_stats = rbcache_create(NULL, NULL, stats_size, RBCACHE_FIFO, s);
+
+    s->max_aio_size = qemu_opt_get_size(opts, PCACHE_OPT_MAX_AIO_SIZE,
+                                        PCACHE_DEFAULT_MAX_AIO_SIZE);
 }
 
 static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
-- 
2.11.0
