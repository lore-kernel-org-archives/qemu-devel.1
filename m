Received: from eggs.gnu.org ([208.118.235.92]:43334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOq-0001g2-Kj
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOn-0008Er-Ek
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:28 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Sun, 30 Dec 2018 23:09:14 +0300
Message-Id: <1546200557-774583-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 3/6] The discard flag for block stream
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Adding a parameter to QMP block-stream command to allow discarding
blocks in the backing chain while blocks are being copied to the
active layer.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c      | 24 ++++++++++++++++++++++++
 block/stream.c            |  3 +--
 blockdev.c                |  8 +++++++-
 hmp-commands.hx           |  4 ++--
 hmp.c                     |  4 +++-
 include/block/block_int.h |  2 +-
 qapi/block-core.json      |  5 ++++-
 7 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 64dcc42..bf7580e 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -22,11 +22,22 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
+#include "qapi/qmp/qdict.h"
+
+typedef struct BDRVCORState {
+    bool discard;
+} BDRVCORState;
 
 
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
+    if (qdict_haskey(options, "driver.discard")) {
+        BDRVCORState *s = bs->opaque;
+        s->discard = qdict_get_bool(options, "driver.discard");
+        qdict_del(options, "driver.discard");
+    }
+
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
                                errp);
     if (!bs->file) {
@@ -66,6 +77,11 @@ static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
              (c->perm & PERM_UNCHANGED);
     *nshared = (shared & PERM_PASSTHROUGH) |
                (c->shared_perm & PERM_UNCHANGED);
+
+    BDRVCORState *s = bs->opaque;
+    if (s->discard) {
+        *nshared |= BLK_PERM_WRITE;
+    }
 }
 
 
@@ -134,8 +150,15 @@ static bool cor_recurse_is_first_non_filter(BlockDriverState *bs,
 }
 
 
+static int cor_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    return bdrv_get_info(bs->file->bs, bdi);
+}
+
+
 BlockDriver bdrv_copy_on_read = {
     .format_name                        = "copy-on-read",
+    .instance_size                      = sizeof(BDRVCORState),
 
     .bdrv_open                          = cor_open,
     .bdrv_child_perm                    = cor_child_perm,
@@ -148,6 +171,7 @@ BlockDriver bdrv_copy_on_read = {
     .bdrv_co_pwrite_zeroes              = cor_co_pwrite_zeroes,
     .bdrv_co_pdiscard                   = cor_co_pdiscard,
 
+    .bdrv_get_info                      = cor_get_info,
     .bdrv_eject                         = cor_eject,
     .bdrv_lock_medium                   = cor_lock_medium,
 
diff --git a/block/stream.c b/block/stream.c
index af2eebf..b160eee 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -465,13 +465,12 @@ static const BlockJobDriver stream_job_driver = {
 
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int creation_flags, int64_t speed,
+                  int creation_flags, int64_t speed, bool discard,
                   BlockdevOnError on_error, Error **errp)
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
-    const bool discard = false;
     int node_shared_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
     int ret;
 
diff --git a/blockdev.c b/blockdev.c
index a6f71f9..6a53cb7 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3138,6 +3138,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_base_node, const char *base_node,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
+                      bool has_discard, bool discard,
                       bool has_on_error, BlockdevOnError on_error,
                       bool has_auto_finalize, bool auto_finalize,
                       bool has_auto_dismiss, bool auto_dismiss,
@@ -3154,6 +3155,10 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         on_error = BLOCKDEV_ON_ERROR_REPORT;
     }
 
+    if (!has_discard) {
+        discard = false;
+    }
+
     bs = bdrv_lookup_bs(device, device, errp);
     if (!bs) {
         return;
@@ -3218,7 +3223,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     }
 
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
-                 job_flags, has_speed ? speed : 0, on_error, &local_err);
+                 job_flags, has_speed ? speed : 0,
+                 discard, on_error, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ba71558..12806db 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -95,8 +95,8 @@ ETEXI
 
     {
         .name       = "block_stream",
-        .args_type  = "device:B,speed:o?,base:s?",
-        .params     = "device [speed [base]]",
+        .args_type  = "device:B,speed:o?,base:s?,discard:-d",
+        .params     = "device [speed [base]] [-d]",
         .help       = "copy data from a backing file into a block device",
         .cmd        = hmp_block_stream,
     },
diff --git a/hmp.c b/hmp.c
index 80aa5ab..353a164 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1923,9 +1923,11 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     const char *device = qdict_get_str(qdict, "device");
     const char *base = qdict_get_try_str(qdict, "base");
     int64_t speed = qdict_get_try_int(qdict, "speed", 0);
+    bool discard = qdict_get_try_bool(qdict, "discard", false);
 
     qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
-                     false, NULL, qdict_haskey(qdict, "speed"), speed, true,
+                     false, NULL, qdict_haskey(qdict, "speed"), speed,
+                     true, discard, true,
                      BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
                      &error);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622..2660336 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -970,7 +970,7 @@ int is_windows_drive(const char *filename);
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int creation_flags, int64_t speed,
+                  int creation_flags, int64_t speed, bool discard,
                   BlockdevOnError on_error, Error **errp);
 
 /**
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 762000f..5005c57 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2337,6 +2337,9 @@
 #
 # @speed:  the maximum speed, in bytes per second
 #
+# @discard: true to delete blocks duplicated in old backing files.
+#           (default: false). Since 4.0.
+#
 # @on-error: the action to take on an error (default report).
 #            'stop' and 'enospc' can only be used if the block device
 #            supports io-status (see BlockInfo).  Since 1.3.
@@ -2369,7 +2372,7 @@
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
             '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
-            '*on-error': 'BlockdevOnError',
+            '*discard': 'bool', '*on-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
-- 
1.8.3.1
