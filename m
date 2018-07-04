Received: from eggs.gnu.org ([2001:4830:134:3::10]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fajG6-0001vH-TV
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fajG5-000771-MX
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:59:55 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Wed, 4 Jul 2018 17:59:35 +0300
Message-ID: <1530716376-2235-3-git-send-email-ari@tuxera.com>
In-Reply-To: <1530716376-2235-1-git-send-email-ari@tuxera.com>
References: <1530716376-2235-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/3] block/blklogwrites: Add an option for
 appending to an old log
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

Suggested by Kevin Wolf. May be useful when testing multiple batches
of writes or doing long-term testing involving restarts of the VM.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/blklogwrites.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++-----
 qapi/block-core.json |   3 +-
 2 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 272e11a..56154e7 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -24,6 +24,10 @@
 #define LOG_FUA_FLAG     (1 << 1)
 #define LOG_DISCARD_FLAG (1 << 2)
 #define LOG_MARK_FLAG    (1 << 3)
+#define LOG_FLAG_MASK    (LOG_FLUSH_FLAG \
+                         | LOG_FUA_FLAG \
+                         | LOG_DISCARD_FLAG \
+                         | LOG_MARK_FLAG)
 
 #define WRITE_LOG_VERSION 1ULL
 #define WRITE_LOG_MAGIC 0x6a736677736872ULL
@@ -58,6 +62,11 @@ static QemuOptsList runtime_opts = {
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
     .desc = {
         {
+            .name = "log-append",
+            .type = QEMU_OPT_BOOL,
+            .help = "Append to an existing log",
+        },
+        {
             .name = "log-sector-size",
             .type = QEMU_OPT_SIZE,
             .help = "Log sector size",
@@ -72,6 +81,53 @@ static inline uint32_t blk_log_writes_log2(uint32_t value)
     return 31 - clz32(value);
 }
 
+static inline bool blk_log_writes_sector_size_valid(uint32_t sector_size)
+{
+    return sector_size < (1ull << 24) && is_power_of_2(sector_size);
+}
+
+static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
+                                                   uint32_t sector_size,
+                                                   uint64_t nr_entries,
+                                                   Error **errp)
+{
+    uint64_t cur_sector = 1;
+    uint64_t cur_idx = 0;
+    uint32_t sector_bits = blk_log_writes_log2(sector_size);
+    struct log_write_entry cur_entry;
+
+    while (cur_idx < nr_entries) {
+        int read_ret = bdrv_pread(log, cur_sector << sector_bits, &cur_entry,
+                                  sizeof(cur_entry));
+        if (read_ret < 0) {
+            error_setg_errno(errp, -read_ret,
+                             "Failed to read log entry %"PRIu64, cur_idx);
+            return (uint64_t)-1ull;
+        }
+
+        if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
+            error_setg(errp, "Invalid flags 0x%"PRIx64" in log entry %"PRIu64,
+                       le64_to_cpu(cur_entry.flags), cur_idx);
+            return (uint64_t)-1ull;
+        }
+
+        /* Account for the sector of the entry itself */
+        ++cur_sector;
+
+        /*
+         * Account for the data of the write.
+         * For discards, this data is not present.
+         */
+        if (!(cur_entry.flags & cpu_to_le64(LOG_DISCARD_FLAG))) {
+            cur_sector += le64_to_cpu(cur_entry.nr_sectors);
+        }
+
+        ++cur_idx;
+    }
+
+    return cur_sector;
+}
+
 static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
                                Error **errp)
 {
@@ -80,6 +136,7 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     int ret;
     uint64_t log_sector_size;
+    bool log_append;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
@@ -98,20 +155,6 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    log_sector_size = qemu_opt_get_size(opts, "log-sector-size",
-                                        BDRV_SECTOR_SIZE);
-
-    if (log_sector_size > (1ull << 23) || !is_power_of_2(log_sector_size)) {
-        ret = -EINVAL;
-        error_setg(errp, "Invalid log sector size %"PRIu64, log_sector_size);
-        goto fail;
-    }
-
-    s->sectorsize = log_sector_size;
-    s->sectorbits = blk_log_writes_log2(log_sector_size);
-    s->cur_log_sector = 1;
-    s->nr_entries = 0;
-
     /* Open the log file */
     s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_file, false,
                                   &local_err);
@@ -121,7 +164,83 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    log_append = qemu_opt_get_bool(opts, "log-append", false);
+
+    if (log_append) {
+        struct log_write_super log_sb = { 0, 0, 0, 0 };
+
+        if (qemu_opt_find(opts, "log-sector-size")) {
+            ret = -EINVAL;
+            error_setg(errp, "log-append and log-sector-size are mutually "
+                       "exclusive");
+            goto fail_log;
+        }
+
+        /* Read log superblock or fake one for an empty log */
+        if (!bdrv_getlength(s->log_file->bs)) {
+            log_sb.magic      = cpu_to_le64(WRITE_LOG_MAGIC);
+            log_sb.version    = cpu_to_le64(WRITE_LOG_VERSION);
+            log_sb.nr_entries = cpu_to_le64(0);
+            log_sb.sectorsize = cpu_to_le32(BDRV_SECTOR_SIZE);
+        } else {
+            ret = bdrv_pread(s->log_file, 0, &log_sb, sizeof(log_sb));
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Could not read log superblock");
+                goto fail_log;
+            }
+        }
+
+        if (log_sb.magic != cpu_to_le64(WRITE_LOG_MAGIC)) {
+            ret = -EINVAL;
+            error_setg(errp, "Invalid log superblock magic");
+            goto fail_log;
+        }
+
+        if (log_sb.version != cpu_to_le64(WRITE_LOG_VERSION)) {
+            ret = -EINVAL;
+            error_setg(errp, "Unsupported log version %"PRIu64,
+                       le64_to_cpu(log_sb.version));
+            goto fail_log;
+        }
+
+        log_sector_size = le32_to_cpu(log_sb.sectorsize);
+        s->cur_log_sector = 1;
+        s->nr_entries = 0;
+
+        if (blk_log_writes_sector_size_valid(log_sector_size)) {
+            s->cur_log_sector =
+                blk_log_writes_find_cur_log_sector(s->log_file, log_sector_size,
+                                    le64_to_cpu(log_sb.nr_entries), &local_err);
+            if (local_err) {
+                ret = -EINVAL;
+                error_propagate(errp, local_err);
+                goto fail_log;
+            }
+
+            s->nr_entries = le64_to_cpu(log_sb.nr_entries);
+        }
+    } else {
+        log_sector_size = qemu_opt_get_size(opts, "log-sector-size",
+                                            BDRV_SECTOR_SIZE);
+        s->cur_log_sector = 1;
+        s->nr_entries = 0;
+    }
+
+    if (!blk_log_writes_sector_size_valid(log_sector_size)) {
+        ret = -EINVAL;
+        error_setg(errp, "Invalid log sector size %"PRIu64, log_sector_size);
+        goto fail_log;
+    }
+
+    s->sectorsize = log_sector_size;
+    s->sectorbits = blk_log_writes_log2(log_sector_size);
+
     ret = 0;
+fail_log:
+    if (ret < 0) {
+        bdrv_unref_child(bs, s->log_file);
+        s->log_file = NULL;
+    }
 fail:
     if (ret < 0) {
         bdrv_unref_child(bs, bs->file);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a9eab8c..d1753a2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3062,7 +3062,8 @@
 { 'struct': 'BlockdevOptionsBlklogwrites',
   'data': { 'file': 'BlockdevRef',
             'log': 'BlockdevRef',
-            '*log-sector-size': 'uint32' } }
+            '*log-sector-size': 'uint32',
+            '*log-append': 'bool' } }
 
 ##
 # @BlockdevOptionsBlkverify:
-- 
2.7.4
