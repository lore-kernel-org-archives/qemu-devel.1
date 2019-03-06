Received: from eggs.gnu.org ([209.51.188.92]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1e-0004D6-At
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1b-0005t5-0S
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:17 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:09 +0200
Message-Id: <bc270e69717cb6bbf756e56ca8581abfb206b340.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 09/13] block: Add a 'mutable_opts' field to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

If we reopen a BlockDriverState and there is an option that is present
in bs->options but missing from the new set of options then we have to
return an error unless the driver is able to reset it to its default
value.

This patch adds a new 'mutable_opts' field to BlockDriver. This is
a list of runtime options that can be modified during reopen. If an
option in this list is unspecified on reopen then it must be reset (or
return an error).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c        |  6 ++++++
 block/qcow2.c             | 25 +++++++++++++++++++++++++
 block/raw-format.c        |  3 +++
 include/block/block_int.h |  8 ++++++++
 4 files changed, 42 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index ba6ab62a38..07c91a985f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -431,6 +431,8 @@ static QemuOptsList raw_runtime_opts = {
     },
 };
 
+static const char *const mutable_opts[] = { "x-check-cache-dropped", NULL };
+
 static int raw_open_common(BlockDriverState *bs, QDict *options,
                            int bdrv_flags, int open_flags,
                            bool device, Error **errp)
@@ -2766,6 +2768,7 @@ BlockDriver bdrv_file = {
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
     .create_opts = &raw_create_opts,
+    .mutable_opts = mutable_opts,
 };
 
 /***********************************************/
@@ -3217,6 +3220,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_reopen_abort   = raw_reopen_abort,
     .bdrv_co_create_opts = hdev_co_create_opts,
     .create_opts         = &raw_create_opts,
+    .mutable_opts        = mutable_opts,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes = hdev_co_pwrite_zeroes,
 
@@ -3343,6 +3347,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_reopen_abort   = raw_reopen_abort,
     .bdrv_co_create_opts = hdev_co_create_opts,
     .create_opts         = &raw_create_opts,
+    .mutable_opts        = mutable_opts,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
 
 
@@ -3476,6 +3481,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_reopen_abort   = raw_reopen_abort,
     .bdrv_co_create_opts = hdev_co_create_opts,
     .create_opts        = &raw_create_opts,
+    .mutable_opts       = mutable_opts,
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
diff --git a/block/qcow2.c b/block/qcow2.c
index 7fb2730f09..9421f0d847 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -611,6 +611,30 @@ int qcow2_validate_table(BlockDriverState *bs, uint64_t offset,
     return 0;
 }
 
+static const char *const mutable_opts[] = {
+    QCOW2_OPT_LAZY_REFCOUNTS,
+    QCOW2_OPT_DISCARD_REQUEST,
+    QCOW2_OPT_DISCARD_SNAPSHOT,
+    QCOW2_OPT_DISCARD_OTHER,
+    QCOW2_OPT_OVERLAP,
+    QCOW2_OPT_OVERLAP_TEMPLATE,
+    QCOW2_OPT_OVERLAP_MAIN_HEADER,
+    QCOW2_OPT_OVERLAP_ACTIVE_L1,
+    QCOW2_OPT_OVERLAP_ACTIVE_L2,
+    QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
+    QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
+    QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
+    QCOW2_OPT_OVERLAP_INACTIVE_L1,
+    QCOW2_OPT_OVERLAP_INACTIVE_L2,
+    QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
+    QCOW2_OPT_CACHE_SIZE,
+    QCOW2_OPT_L2_CACHE_SIZE,
+    QCOW2_OPT_L2_CACHE_ENTRY_SIZE,
+    QCOW2_OPT_REFCOUNT_CACHE_SIZE,
+    QCOW2_OPT_CACHE_CLEAN_INTERVAL,
+    NULL
+};
+
 static QemuOptsList qcow2_runtime_opts = {
     .name = "qcow2",
     .head = QTAILQ_HEAD_INITIALIZER(qcow2_runtime_opts.head),
@@ -5053,6 +5077,7 @@ BlockDriver bdrv_qcow2 = {
 
     .create_opts         = &qcow2_create_opts,
     .strong_runtime_opts = qcow2_strong_runtime_opts,
+    .mutable_opts        = mutable_opts,
     .bdrv_co_check       = qcow2_co_check,
     .bdrv_amend_options  = qcow2_amend_options,
 
diff --git a/block/raw-format.c b/block/raw-format.c
index e3e5ba2c8a..cec29986cc 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -37,6 +37,8 @@ typedef struct BDRVRawState {
     bool has_size;
 } BDRVRawState;
 
+static const char *const mutable_opts[] = { "offset", "size", NULL };
+
 static QemuOptsList raw_runtime_opts = {
     .name = "raw",
     .head = QTAILQ_HEAD_INITIALIZER(raw_runtime_opts.head),
@@ -570,6 +572,7 @@ BlockDriver bdrv_raw = {
     .create_opts          = &raw_create_opts,
     .bdrv_has_zero_init   = &raw_has_zero_init,
     .strong_runtime_opts  = raw_strong_runtime_opts,
+    .mutable_opts         = mutable_opts,
 };
 
 static void bdrv_raw_init(void)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c8a83c3eea..8e3f3760a0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -381,6 +381,14 @@ struct BlockDriver {
 
     /* List of options for creating images, terminated by name == NULL */
     QemuOptsList *create_opts;
+    /*
+     * If this driver supports reopening images this contains a
+     * NULL-terminated list of the runtime options that can be
+     * modified. If an option in this list is unspecified during
+     * reopen then it _must_ be reset to its default value or return
+     * an error.
+     */
+    const char *const *mutable_opts;
 
     /*
      * Returns 0 for completed check, -errno for internal errors.
-- 
2.11.0
