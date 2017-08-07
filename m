Received: from eggs.gnu.org ([2001:4830:134:3::10]:49142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJB-0007Tc-DZ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIv-0003zm-GM
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:47 +0200
Message-Id: <1502117160-24655-44-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 43/56] blockjob: Lift speed sign conversion
 out of mirror_start()
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

mirror_start() takes int64_t speed.  The underlying BlockJob
abstraction takes uint64_t.  mirror_start() converts from int64_t to
uint64_t, rejecting negative speed.

Lift this check and conversion out of mirror_start() into its caller.
I'm going to lift it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/mirror.c            | 7 +------
 blockdev.c                | 5 +++++
 include/block/block_int.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 27b4c7f..af0c989 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1283,7 +1283,7 @@ fail:
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  int64_t speed, uint64_t granularity, int64_t buf_size,
+                  uint64_t speed, uint64_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
@@ -1292,11 +1292,6 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
     bool is_none_mode;
     BlockDriverState *base;
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
     if (mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         error_setg(errp, "Sync mode 'incremental' not supported");
         return;
diff --git a/blockdev.c b/blockdev.c
index 4d9a665..06f87e3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3454,6 +3454,11 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         filter_node_name = NULL;
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
     if (granularity != 0 && (granularity < 512 || granularity > 1048576 * 64)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
                    "a value in range [512B, 64MB]");
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 695d7b3..3ff5536 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -896,7 +896,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
  */
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  int64_t speed, uint64_t granularity, int64_t buf_size,
+                  uint64_t speed, uint64_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
-- 
2.7.5
