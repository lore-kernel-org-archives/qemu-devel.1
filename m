Received: from eggs.gnu.org ([2001:4830:134:3::10]:45884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhX4t-0007LY-9h
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhX4r-0001nS-25
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:19:55 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue, 15 Aug 2017 11:18:54 +0300
Message-Id: <20170815081854.14568-3-el13635@mail.ntua.gr>
In-Reply-To: <20170815081854.14568-1-el13635@mail.ntua.gr>
References: <20170815081854.14568-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 2/2] block: add filter driver to
 block/write-threshold.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

With runtime insertion and removal of filters, write-threshold.c can
provide more flexible deliveries of BLOCK_WRITE_THRESHOLD events. After
the event trigger, the filter nodes are no longer useful and must be
removed.
The existing write-threshold cannot be easily converted to using the
filter driver, so it is not affected.

This is part of deprecating before write notifiers, which are hard coded
into the block layer. Block filter drivers are inserted into the graph
only when a feature is needed. This makes the block layer more modular
and reuses the block driver abstraction that is already present.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/qapi.c                    |   2 +-
 block/write-threshold.c         | 264 +++++++++++++++++++++++++++++++++++-----
 include/block/write-threshold.h |  22 ++--
 qapi/block-core.json            |  19 ++-
 tests/test-write-threshold.c    |  40 +++---
 5 files changed, 281 insertions(+), 66 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 2be44a6758..fe6cf2eae5 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -122,7 +122,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->group = g_strdup(throttle_group_get_name(tgm));
     }
 
-    info->write_threshold = bdrv_write_threshold_get(bs);
+    info->write_threshold = bdrv_write_threshold_get_legacy(bs);
 
     bs0 = bs;
     p_image_info = &info->image;
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 0bd1a01c86..4a67188ea3 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -2,9 +2,11 @@
  * QEMU System Emulator block write threshold notification
  *
  * Copyright Red Hat, Inc. 2014
+ * Copyright 2017 Manos Pitsidianakis
  *
  * Authors:
  *  Francesco Romani <fromani@redhat.com>
+ *  Manos Pitsidianakis <el13635@mail.ntua.gr>
  *
  * This work is licensed under the terms of the GNU LGPL, version 2 or later.
  * See the COPYING.LIB file in the top-level directory.
@@ -19,46 +21,35 @@
 #include "qmp-commands.h"
 
 
-uint64_t bdrv_write_threshold_get(const BlockDriverState *bs)
+uint64_t bdrv_write_threshold_get_legacy(const BlockDriverState *bs)
 {
     return bs->write_threshold_offset;
 }
 
-bool bdrv_write_threshold_is_set(const BlockDriverState *bs)
+bool bdrv_write_threshold_is_set_legacy(const BlockDriverState *bs)
 {
     return bs->write_threshold_offset > 0;
 }
 
-static void write_threshold_disable(BlockDriverState *bs)
+static void write_threshold_disable_legacy(BlockDriverState *bs)
 {
-    if (bdrv_write_threshold_is_set(bs)) {
+    if (bdrv_write_threshold_is_set_legacy(bs)) {
         notifier_with_return_remove(&bs->write_threshold_notifier);
         bs->write_threshold_offset = 0;
     }
 }
 
-uint64_t bdrv_write_threshold_exceeded(const BlockDriverState *bs,
-                                       const BdrvTrackedRequest *req)
-{
-    if (bdrv_write_threshold_is_set(bs)) {
-        if (req->offset > bs->write_threshold_offset) {
-            return (req->offset - bs->write_threshold_offset) + req->bytes;
-        }
-        if ((req->offset + req->bytes) > bs->write_threshold_offset) {
-            return (req->offset + req->bytes) - bs->write_threshold_offset;
-        }
-    }
-    return 0;
-}
-
 static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
                                             void *opaque)
 {
     BdrvTrackedRequest *req = opaque;
     BlockDriverState *bs = req->bs;
     uint64_t amount = 0;
+    uint64_t threshold = bdrv_write_threshold_get_legacy(bs);
+    uint64_t offset = req->offset;
+    uint64_t bytes = req->bytes;
 
-    amount = bdrv_write_threshold_exceeded(bs, req);
+    amount = bdrv_write_threshold_exceeded(threshold, offset, bytes);
     if (amount > 0) {
         qapi_event_send_block_write_threshold(
             bs->node_name,
@@ -67,7 +58,7 @@ static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
             &error_abort);
 
         /* autodisable to avoid flooding the monitor */
-        write_threshold_disable(bs);
+        write_threshold_disable_legacy(bs);
     }
 
     return 0; /* should always let other notifiers run */
@@ -79,25 +70,26 @@ static void write_threshold_register_notifier(BlockDriverState *bs)
     bdrv_add_before_write_notifier(bs, &bs->write_threshold_notifier);
 }
 
-static void write_threshold_update(BlockDriverState *bs,
-                                   int64_t threshold_bytes)
+static void write_threshold_update_legacy(BlockDriverState *bs,
+                                          int64_t threshold_bytes)
 {
     bs->write_threshold_offset = threshold_bytes;
 }
 
-void bdrv_write_threshold_set(BlockDriverState *bs, uint64_t threshold_bytes)
+void bdrv_write_threshold_set_legacy(BlockDriverState *bs,
+                                     uint64_t threshold_bytes)
 {
-    if (bdrv_write_threshold_is_set(bs)) {
+    if (bdrv_write_threshold_is_set_legacy(bs)) {
         if (threshold_bytes > 0) {
-            write_threshold_update(bs, threshold_bytes);
+            write_threshold_update_legacy(bs, threshold_bytes);
         } else {
-            write_threshold_disable(bs);
+            write_threshold_disable_legacy(bs);
         }
     } else {
         if (threshold_bytes > 0) {
             /* avoid multiple registration */
             write_threshold_register_notifier(bs);
-            write_threshold_update(bs, threshold_bytes);
+            write_threshold_update_legacy(bs, threshold_bytes);
         }
         /* discard bogus disable request */
     }
@@ -119,7 +111,223 @@ void qmp_block_set_write_threshold(const char *node_name,
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
-    bdrv_write_threshold_set(bs, threshold_bytes);
+    bdrv_write_threshold_set_legacy(bs, threshold_bytes);
 
     aio_context_release(aio_context);
 }
+
+
+/* The write-threshold filter drivers delivers a one-time BLOCK_WRITE_THRESHOLD
+ * event when a passing write request exceeds the configured write threshold
+ * offset of the filter.
+ *
+ * This is useful to transparently resize thin-provisioned drives without
+ * the guest OS noticing.
+ */
+
+#define QEMU_OPT_WRITE_THRESHOLD "write-threshold"
+static BlockDriver write_threshold;
+static QemuOptsList write_threshold_opts = {
+    .name = "write-threshold",
+    .head = QTAILQ_HEAD_INITIALIZER(write_threshold_opts.head),
+    .desc = {
+        {
+            .name = QEMU_OPT_WRITE_THRESHOLD,
+            .type = QEMU_OPT_NUMBER,
+            .help = "configured threshold for the block device, bytes. Use 0"
+                    "to disable the threshold",
+        },
+        { /* end of list */ }
+    },
+};
+
+static bool bdrv_write_threshold_is_set(const BlockDriverState *bs)
+{
+    uint64_t threshold = *(uint64_t *)bs->opaque;
+    return threshold > 0;
+}
+
+static void bdrv_write_threshold_disable(BlockDriverState *bs)
+{
+    uint64_t *threshold = (uint64_t *)bs->opaque;
+    if (bdrv_write_threshold_is_set(bs)) {
+        *threshold = 0;
+    }
+}
+
+uint64_t bdrv_write_threshold_exceeded(uint64_t threshold, uint64_t offset,
+                                       uint64_t bytes)
+{
+    if (threshold) {
+        if (offset > threshold) {
+            return (offset - threshold) + bytes;
+        }
+        if ((offset + bytes) > threshold) {
+            return (offset + bytes) - threshold;
+        }
+    }
+    return 0;
+}
+
+
+static void bdrv_write_threshold_update(BlockDriverState *bs,
+                                        int64_t threshold_bytes)
+{
+    uint64_t *threshold = (uint64_t *)bs->opaque;
+    *threshold = threshold_bytes;
+}
+
+static void bdrv_write_threshold_check_amount(BlockDriverState *bs,
+                                              uint64_t offset,
+                                              uint64_t bytes)
+{
+    uint64_t threshold = *(uint64_t *)bs->opaque;
+    uint64_t amount = 0;
+
+    amount = bdrv_write_threshold_exceeded(threshold, offset, bytes);
+    if (amount > 0) {
+        qapi_event_send_block_write_threshold(child_bs(bs)->node_name,
+                                              amount,
+                                              threshold,
+                                              &error_abort);
+        /* autodisable to avoid flooding the monitor */
+        bdrv_write_threshold_disable(bs);
+    }
+}
+
+/* Filter driver methods */
+
+static int coroutine_fn write_threshold_co_preadv(BlockDriverState *bs,
+                                                  uint64_t offset,
+                                                  uint64_t bytes,
+                                                  QEMUIOVector *qiov,
+                                                  int flags)
+{
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn write_threshold_co_pwritev(BlockDriverState *bs,
+                                                   uint64_t offset,
+                                                   uint64_t bytes,
+                                                   QEMUIOVector *qiov,
+                                                   int flags)
+{
+    bdrv_write_threshold_check_amount(bs, offset, bytes);
+    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn write_threshold_co_pwrite_zeroes(
+                                                        BlockDriverState *bs,
+                                                        int64_t offset,
+                                                        int bytes,
+                                                        BdrvRequestFlags flags)
+{
+    bdrv_write_threshold_check_amount(bs, offset, bytes);
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+static int coroutine_fn write_threshold_co_pdiscard(BlockDriverState *bs,
+                                                    int64_t offset, int bytes)
+{
+    bdrv_write_threshold_check_amount(bs, offset, bytes);
+    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+}
+
+
+static int64_t write_threshold_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+static int write_threshold_open(BlockDriverState *bs, QDict *options,
+                                int flags, Error **errp)
+{
+    Error *local_err = NULL;
+    int ret = 0;
+    QemuOpts *opts = NULL;
+    uint64_t threshold = 0;
+
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    bs->supported_write_flags = bs->file->bs->supported_write_flags;
+    bs->supported_zero_flags = bs->file->bs->supported_zero_flags;
+
+    opts = qemu_opts_create(&write_threshold_opts, NULL, 0, &error_abort);
+
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto ret;
+    }
+
+    threshold = qemu_opt_get_number(opts, QEMU_OPT_WRITE_THRESHOLD, 0);
+    bdrv_write_threshold_update(bs, threshold);
+
+ret:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static void write_threshold_close(BlockDriverState *bs)
+{
+}
+
+static int write_threshold_co_flush(BlockDriverState *bs)
+{
+    return bdrv_co_flush(bs->file->bs);
+}
+
+static int64_t coroutine_fn write_threshold_co_get_block_status(
+                                                       BlockDriverState *bs,
+                                                       int64_t sector_num,
+                                                       int nb_sectors,
+                                                       int *pnum,
+                                                       BlockDriverState **file)
+{
+    assert(child_bs(bs));
+    *pnum = nb_sectors;
+    *file = child_bs(bs);
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+
+static bool write_threshold_recurse_is_first_non_filter(
+                                                   BlockDriverState *bs,
+                                                   BlockDriverState *candidate)
+{
+    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
+}
+
+static BlockDriver write_threshold = {
+    .format_name                      = "write-threshold",
+    .instance_size                    = sizeof(uint64_t),
+
+    .bdrv_open                        = write_threshold_open,
+    .bdrv_close                       = write_threshold_close,
+
+    .bdrv_co_flush                    = write_threshold_co_flush,
+    .bdrv_co_preadv                   = write_threshold_co_preadv,
+    .bdrv_co_pwritev                  = write_threshold_co_pwritev,
+    .bdrv_co_pwrite_zeroes            = write_threshold_co_pwrite_zeroes,
+    .bdrv_co_pdiscard                 = write_threshold_co_pdiscard,
+
+    .bdrv_getlength                   = write_threshold_getlength,
+    .bdrv_child_perm                  = bdrv_filter_default_perms,
+    .bdrv_co_get_block_status         = write_threshold_co_get_block_status,
+    .bdrv_recurse_is_first_non_filter =
+                                   write_threshold_recurse_is_first_non_filter,
+
+    .is_filter                        = true,
+};
+
+static void bdrv_write_threshold_init(void)
+{
+    bdrv_register(&write_threshold);
+}
+
+block_init(bdrv_write_threshold_init);
diff --git a/include/block/write-threshold.h b/include/block/write-threshold.h
index 234d2193e0..5cf378564d 100644
--- a/include/block/write-threshold.h
+++ b/include/block/write-threshold.h
@@ -15,7 +15,7 @@
 #include "qemu-common.h"
 
 /*
- * bdrv_write_threshold_set:
+ * bdrv_write_threshold_set_legacy:
  *
  * Set the write threshold for block devices, in bytes.
  * Notify when a write exceeds the threshold, meaning the device
@@ -24,22 +24,25 @@
  *
  * Use threshold_bytes == 0 to disable.
  */
-void bdrv_write_threshold_set(BlockDriverState *bs, uint64_t threshold_bytes);
+void bdrv_write_threshold_set_legacy(BlockDriverState *bs,
+                                     uint64_t threshold_bytes);
+
 
 /*
- * bdrv_write_threshold_get
+ * bdrv_write_threshold_get_legacy
  *
  * Get the configured write threshold, in bytes.
  * Zero means no threshold configured.
+ *
  */
-uint64_t bdrv_write_threshold_get(const BlockDriverState *bs);
+uint64_t bdrv_write_threshold_get_legacy(const BlockDriverState *bs);
 
 /*
- * bdrv_write_threshold_is_set
+ * bdrv_write_threshold_is_set_legacy
  *
  * Tell if a write threshold is set for a given BDS.
  */
-bool bdrv_write_threshold_is_set(const BlockDriverState *bs);
+bool bdrv_write_threshold_is_set_legacy(const BlockDriverState *bs);
 
 /*
  * bdrv_write_threshold_exceeded
@@ -51,11 +54,10 @@ bool bdrv_write_threshold_is_set(const BlockDriverState *bs);
  * NOTE: here we assume the following holds for each request this code
  * deals with:
  *
- * assert((req->offset + req->bytes) <= UINT64_MAX)
+ * assert((offset + bytes) <= UINT64_MAX)
  *
  * Please not there is *not* an actual C assert().
  */
-uint64_t bdrv_write_threshold_exceeded(const BlockDriverState *bs,
-                                       const BdrvTrackedRequest *req);
-
+uint64_t bdrv_write_threshold_exceeded(uint64_t threshold, uint64_t offset,
+                                       uint64_t bytes);
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 12fd749a94..4d6ba1baef 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2232,7 +2232,8 @@
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
-            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs',
+            'write-threshold'] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3113,6 +3114,21 @@
             'file' : 'BlockdevRef',
             '*limits' : 'ThrottleLimits'
              } }
+
+##
+# @BlockdevOptionsWriteThreshold:
+#
+# Driver specific block device options for the write-threshold driver
+#
+# @file:             reference to or definition of the data source block device
+# @write-threshold:  threshold in bytes
+# Since: 2.11
+##
+{ 'struct': 'BlockdevOptionsWriteThreshold',
+  'data': { '*file' : 'BlockdevRef',
+            'write-threshold' : 'int'
+             } }
+
 ##
 # @BlockdevOptions:
 #
@@ -3175,6 +3191,7 @@
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
       'throttle':   'BlockdevOptionsThrottle',
+      'write-threshold':   'BlockdevOptionsWriteThreshold',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
diff --git a/tests/test-write-threshold.c b/tests/test-write-threshold.c
index 97ca12f710..1c802d2de4 100644
--- a/tests/test-write-threshold.c
+++ b/tests/test-write-threshold.c
@@ -17,9 +17,9 @@ static void test_threshold_not_set_on_init(void)
     BlockDriverState bs;
     memset(&bs, 0, sizeof(bs));
 
-    g_assert(!bdrv_write_threshold_is_set(&bs));
+    g_assert(!bdrv_write_threshold_is_set_legacy(&bs));
 
-    res = bdrv_write_threshold_get(&bs);
+    res = bdrv_write_threshold_get_legacy(&bs);
     g_assert_cmpint(res, ==, 0);
 }
 
@@ -30,11 +30,11 @@ static void test_threshold_set_get(void)
     BlockDriverState bs;
     memset(&bs, 0, sizeof(bs));
 
-    bdrv_write_threshold_set(&bs, threshold);
+    bdrv_write_threshold_set_legacy(&bs, threshold);
 
-    g_assert(bdrv_write_threshold_is_set(&bs));
+    g_assert(bdrv_write_threshold_is_set_legacy(&bs));
 
-    res = bdrv_write_threshold_get(&bs);
+    res = bdrv_write_threshold_get_legacy(&bs);
     g_assert_cmpint(res, ==, threshold);
 }
 
@@ -46,9 +46,9 @@ static void test_threshold_multi_set_get(void)
     BlockDriverState bs;
     memset(&bs, 0, sizeof(bs));
 
-    bdrv_write_threshold_set(&bs, threshold1);
-    bdrv_write_threshold_set(&bs, threshold2);
-    res = bdrv_write_threshold_get(&bs);
+    bdrv_write_threshold_set_legacy(&bs, threshold1);
+    bdrv_write_threshold_set_legacy(&bs, threshold2);
+    res = bdrv_write_threshold_get_legacy(&bs);
     g_assert_cmpint(res, ==, threshold2);
 }
 
@@ -56,16 +56,10 @@ static void test_threshold_not_trigger(void)
 {
     uint64_t amount = 0;
     uint64_t threshold = 4 * 1024 * 1024;
-    BlockDriverState bs;
-    BdrvTrackedRequest req;
+    uint64_t offset = 1024;
+    uint64_t bytes = 1024;
 
-    memset(&bs, 0, sizeof(bs));
-    memset(&req, 0, sizeof(req));
-    req.offset = 1024;
-    req.bytes = 1024;
-
-    bdrv_write_threshold_set(&bs, threshold);
-    amount = bdrv_write_threshold_exceeded(&bs, &req);
+    amount = bdrv_write_threshold_exceeded(threshold, offset, bytes);
     g_assert_cmpuint(amount, ==, 0);
 }
 
@@ -74,16 +68,10 @@ static void test_threshold_trigger(void)
 {
     uint64_t amount = 0;
     uint64_t threshold = 4 * 1024 * 1024;
-    BlockDriverState bs;
-    BdrvTrackedRequest req;
+    uint64_t offset = (4 * 1024 * 1024) - 1024;
+    uint64_t bytes = 2 * 1024;
 
-    memset(&bs, 0, sizeof(bs));
-    memset(&req, 0, sizeof(req));
-    req.offset = (4 * 1024 * 1024) - 1024;
-    req.bytes = 2 * 1024;
-
-    bdrv_write_threshold_set(&bs, threshold);
-    amount = bdrv_write_threshold_exceeded(&bs, &req);
+    amount = bdrv_write_threshold_exceeded(threshold, offset, bytes);
     g_assert_cmpuint(amount, >=, 1024);
 }
 
-- 
2.11.0
