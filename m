Received: from eggs.gnu.org ([2001:4830:134:3::10]:49210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJE-0007YI-Vi
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIz-00042s-B2
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:52 +0200
Message-Id: <1502117160-24655-49-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 48/56] block: Make mirror buffer size
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Byte counts should use QAPI type 'size' (uint64_t).  Parameter
@buf-size of drive-mirror and blockdev-mirror is 'int' (int64_t).  The
underlying MirrorBlockJob abstraction takes size_t.
mirror_start_job() converts from int64_t to size_t, rejecting negative
sizes (but not values exceeding SIZE_MAX).

Change the two parameters to 'size', and lift the (fixed) check and
the conversion into blockdev_mirror_common().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/mirror.c            | 11 +++--------
 blockdev.c                |  9 +++++++--
 include/block/block_int.h |  2 +-
 qapi/block-core.json      |  4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index f1adda5..f9a5416 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -333,7 +333,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     int nb_chunks = 1;
     int sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
-    int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
+    unsigned max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
 
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     offset = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
@@ -1120,7 +1120,7 @@ static BlockDriver bdrv_mirror_top = {
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              int creation_flags, BlockDriverState *target,
                              const char *replaces, uint64_t speed,
-                             uint64_t granularity, int64_t buf_size,
+                             uint64_t granularity, size_t buf_size,
                              BlockMirrorBackingMode backing_mode,
                              BlockdevOnError on_source_error,
                              BlockdevOnError on_target_error,
@@ -1147,11 +1147,6 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     /* Granularity must be large enough for sector-based dirty bitmap */
     assert(granularity >= BDRV_SECTOR_SIZE);
 
-    if (buf_size < 0) {
-        error_setg(errp, "Invalid parameter 'buf-size'");
-        return;
-    }
-
     if (buf_size == 0) {
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
@@ -1283,7 +1278,7 @@ fail:
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  uint64_t speed, uint64_t granularity, int64_t buf_size,
+                  uint64_t speed, uint64_t granularity, size_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
diff --git a/blockdev.c b/blockdev.c
index 7feed7a..ba1a960 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3403,7 +3403,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    BlockMirrorBackingMode backing_mode,
                                    bool has_speed, uint64_t speed,
                                    bool has_granularity, uint64_t granularity,
-                                   bool has_buf_size, int64_t buf_size,
+                                   bool has_buf_size, uint64_t buf_size,
                                    bool has_on_source_error,
                                    BlockdevOnError on_source_error,
                                    bool has_on_target_error,
@@ -3447,6 +3447,11 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         return;
     }
 
+    if (buf_size > SIZE_MAX) {
+        error_setg(errp, "Parameter 'buf-size' is too large");
+        return;
+    }
+
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
         return;
     }
@@ -3619,7 +3624,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          MirrorSyncMode sync,
                          bool has_speed, uint64_t speed,
                          bool has_granularity, uint64_t granularity,
-                         bool has_buf_size, int64_t buf_size,
+                         bool has_buf_size, uint64_t buf_size,
                          bool has_on_source_error,
                          BlockdevOnError on_source_error,
                          bool has_on_target_error,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 75116e5..8bde408 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -897,7 +897,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
  */
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  uint64_t speed, uint64_t granularity, int64_t buf_size,
+                  uint64_t speed, uint64_t granularity, size_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b8442f3..51caee9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1534,7 +1534,7 @@
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
             'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
             '*speed': 'size', '*granularity': 'size',
-            '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
+            '*buf-size': 'size', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*unmap': 'bool' } }
 
@@ -1733,7 +1733,7 @@
             '*replaces': 'str',
             'sync': 'MirrorSyncMode',
             '*speed': 'size', '*granularity': 'size',
-            '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
+            '*buf-size': 'size', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*filter-node-name': 'str' } }
 
-- 
2.7.5
