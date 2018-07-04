Received: from eggs.gnu.org ([2001:4830:134:3::10]:47962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fajG6-0001ul-1I
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fajG5-00076j-0T
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:59:54 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Wed, 4 Jul 2018 17:59:36 +0300
Message-ID: <1530716376-2235-4-git-send-email-ari@tuxera.com>
In-Reply-To: <1530716376-2235-1-git-send-email-ari@tuxera.com>
References: <1530716376-2235-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/3] block/blklogwrites: Add an option for
 the update interval of the log superblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "open list:blklogwrites" <qemu-block@nongnu.org>

This is a way to ensure that the log superblock is periodically
updated. Before, this was only done on flush requests, which may
not be enough if the VM exits abnormally, omitting the final flush.

The default interval is 4096 write requests.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/blklogwrites.c | 20 ++++++++++++++++++--
 qapi/block-core.json |  6 +++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 56154e7..63bf6b3 100644
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
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d1753a2..38b3125 100644
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
-- 
2.7.4
