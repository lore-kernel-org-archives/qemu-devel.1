Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T2-00071M-VH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T1-0004zq-S0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Jul 2018 12:26:02 +0200
Message-Id: <20180705102604.4986-11-kwolf@redhat.com>
In-Reply-To: <20180705102604.4986-1-kwolf@redhat.com>
References: <20180705102604.4986-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/12] block/blklogwrites: Add an option for
 the update interval of the log superblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Ari Sundholm <ari@tuxera.com>

This is a way to ensure that the log superblock is periodically
updated. Before, this was only done on flush requests, which may
not be enough if the VM exits abnormally, omitting the final flush.

The default interval is 4096 write requests.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  6 +++++-
 block/blklogwrites.c | 20 ++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d1753a2ae7..38b31250f9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3057,13 +3057,17 @@
 # @log-sector-size: sector size used in logging writes to @file, determines
 #                   granularity of offsets and sizes of writes (default: 512)
 #
+# @log-super-update-interval: interval of write requests after which the log
+#                             super block is updated to disk (default: 4096)
+#
 # Since: 3.0
 ##
 { 'struct': 'BlockdevOptionsBlklogwrites',
   'data': { 'file': 'BlockdevRef',
             'log': 'BlockdevRef',
             '*log-sector-size': 'uint32',
-            '*log-append': 'bool' } }
+            '*log-append': 'bool',
+            '*log-super-update-interval': 'uint64' } }
 
 ##
 # @BlockdevOptionsBlkverify:
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 56154e7325..63bf6b34a9 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -55,6 +55,7 @@ typedef struct {
     uint32_t sectorbits;
     uint64_t cur_log_sector;
     uint64_t nr_entries;
+    uint64_t update_interval;
 } BDRVBlkLogWritesState;
 
 static QemuOptsList runtime_opts = {
@@ -71,6 +72,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "Log sector size",
         },
+        {
+            .name = "log-super-update-interval",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Log superblock update interval (# of write requests)",
+        },
         { /* end of list */ }
     },
 };
@@ -234,6 +240,14 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->sectorsize = log_sector_size;
     s->sectorbits = blk_log_writes_log2(log_sector_size);
+    s->update_interval = qemu_opt_get_number(opts, "log-super-update-interval",
+                                             4096);
+    if (!s->update_interval) {
+        ret = -EINVAL;
+        error_setg(errp, "Invalid log superblock update interval %"PRIu64,
+                   s->update_interval);
+        goto fail_log;
+    }
 
     ret = 0;
 fail_log:
@@ -360,8 +374,10 @@ static void coroutine_fn blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
                                             lr->zero_size, 0);
     }
 
-    /* Update super block on flush */
-    if (lr->log_ret == 0 && lr->entry.flags & LOG_FLUSH_FLAG) {
+    /* Update super block on flush or every update interval */
+    if (lr->log_ret == 0 && ((lr->entry.flags & LOG_FLUSH_FLAG)
+        || (s->nr_entries % s->update_interval == 0)))
+    {
         struct log_write_super super = {
             .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
             .version    = cpu_to_le64(WRITE_LOG_VERSION),
-- 
2.13.6
