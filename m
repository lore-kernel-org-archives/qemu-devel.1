Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHY-0003Dn-Ln
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHV-0007Gy-BO
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:28 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 14 Nov 2017 13:16:52 +0300
Message-Id: <1510654613-47868-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/5] block-stream: add compress option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, jcody@redhat.com, armbru@redhat.com, dgilbert@redhat.com

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json      |  4 ++++
 include/block/block_int.h |  4 +++-
 block/stream.c            | 16 ++++++++++++----
 blockdev.c                | 13 ++++++++++++-
 hmp.c                     |  2 ++
 hmp-commands.hx           |  4 ++--
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab96e34..b0d022f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2007,6 +2007,9 @@
 #
 # @speed:  the maximum speed, in bytes per second
 #
+# @compress: true to compress data, if the target format supports it.
+#            (default: false). Since 2.12.
+#
 # @on-error: the action to take on an error (default report).
 #            'stop' and 'enospc' can only be used if the block device
 #            supports io-status (see BlockInfo).  Since 1.3.
@@ -2026,6 +2029,7 @@
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
             '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
+            '*compress': 'bool',
             '*on-error': 'BlockdevOnError' } }
 
 ##
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a548277..093bf9b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -863,6 +863,7 @@ int is_windows_drive(const char *filename);
  * @backing_file_str: The file name that will be written to @bs as the
  * the new backing file if the job completes. Ignored if @base is %NULL.
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
+ * @compress: True to compress data.
  * @on_error: The action to take upon error.
  * @errp: Error object.
  *
@@ -875,7 +876,8 @@ int is_windows_drive(const char *filename);
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int64_t speed, BlockdevOnError on_error, Error **errp);
+                  int64_t speed, bool compress,
+                  BlockdevOnError on_error, Error **errp);
 
 /**
  * commit_start:
diff --git a/block/stream.c b/block/stream.c
index e6f7234..75c9d66 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -38,23 +38,29 @@ typedef struct StreamBlockJob {
     BlockdevOnError on_error;
     char *backing_file_str;
     int bs_flags;
+    bool compress;
 } StreamBlockJob;
 
 static int coroutine_fn stream_populate(BlockBackend *blk,
                                         int64_t offset, uint64_t bytes,
-                                        void *buf)
+                                        void *buf, bool compress)
 {
     struct iovec iov = {
         .iov_base = buf,
         .iov_len  = bytes,
     };
     QEMUIOVector qiov;
+    int flags = BDRV_REQ_COPY_ON_READ;
+
+    if (compress) {
+        flags |= BDRV_REQ_WRITE_COMPRESSED;
+    }
 
     assert(bytes < SIZE_MAX);
     qemu_iovec_init_external(&qiov, &iov, 1);
 
     /* Copy-on-read the unallocated clusters */
-    return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
+    return blk_co_preadv(blk, offset, qiov.size, &qiov, flags);
 }
 
 typedef struct {
@@ -166,7 +172,7 @@ static void coroutine_fn stream_run(void *opaque)
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n, buf);
+            ret = stream_populate(blk, offset, n, buf, s->compress);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -227,7 +233,8 @@ static const BlockJobDriver stream_job_driver = {
 
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int64_t speed, BlockdevOnError on_error, Error **errp)
+                  int64_t speed, bool compress,
+                  BlockdevOnError on_error, Error **errp)
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
@@ -267,6 +274,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_flags = orig_bs_flags;
+    s->compress = compress;
 
     s->on_error = on_error;
     trace_stream_start(bs, base, s);
diff --git a/blockdev.c b/blockdev.c
index 56a6b24..18a56d9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2968,6 +2968,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_base_node, const char *base_node,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
+                      bool has_compress, bool compress,
                       bool has_on_error, BlockdevOnError on_error,
                       Error **errp)
 {
@@ -2981,6 +2982,10 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         on_error = BLOCKDEV_ON_ERROR_REPORT;
     }
 
+    if (!has_compress) {
+        compress = false;
+    }
+
     bs = bdrv_lookup_bs(device, device, errp);
     if (!bs) {
         return;
@@ -3034,11 +3039,17 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         goto out;
     }
 
+    if (compress && bs->drv->bdrv_co_pwritev_compressed == NULL) {
+        error_setg(errp, "Compression is not supported for this drive %s",
+                   bdrv_get_device_name(bs));
+        goto out;
+    }
+
     /* backing_file string overrides base bs filename */
     base_name = has_backing_file ? backing_file : base_name;
 
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
-                 has_speed ? speed : 0, on_error, &local_err);
+                 has_speed ? speed : 0, compress, on_error, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
diff --git a/hmp.c b/hmp.c
index 35a7041..854c88e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1812,9 +1812,11 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     const char *device = qdict_get_str(qdict, "device");
     const char *base = qdict_get_try_str(qdict, "base");
     int64_t speed = qdict_get_try_int(qdict, "speed", 0);
+    bool compress = qdict_get_try_bool(qdict, "compress", false);
 
     qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
                      false, NULL, qdict_haskey(qdict, "speed"), speed,
+                     qdict_haskey(qdict, "compress"), compress,
                      true, BLOCKDEV_ON_ERROR_REPORT, &error);
 
     hmp_handle_error(mon, &error);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 4afd57c..f6794bb 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -75,8 +75,8 @@ ETEXI
 
     {
         .name       = "block_stream",
-        .args_type  = "device:B,speed:o?,base:s?",
-        .params     = "device [speed [base]]",
+        .args_type  = "device:B,speed:o?,base:s?,compress:o?",
+        .params     = "device [speed [base]] [compress]",
         .help       = "copy data from a backing file into a block device",
         .cmd        = hmp_block_stream,
     },
-- 
2.7.4
