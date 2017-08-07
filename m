Received: from eggs.gnu.org ([2001:4830:134:3::10]:49337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJK-0007gc-H6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-00047z-Ov
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:14 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:45 +0200
Message-Id: <1502117160-24655-42-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 41/56] blockjob: Lift speed sign conversion
 out of mirror_start_job()
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

mirror_start_job() takes int64_t speed.  The underlying BlockJob
abstraction takes uint64_t.  mirror_start_job() converts from int64_t
to uint64_t, rejecting negative speed.

Lift this check and conversion out of mirror_start_job() into its
callers.  I'm going to lift it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/mirror.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index af54163..27b4c7f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1119,7 +1119,7 @@ static BlockDriver bdrv_mirror_top = {
 
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              int creation_flags, BlockDriverState *target,
-                             const char *replaces, int64_t speed,
+                             const char *replaces, uint64_t speed,
                              uint64_t granularity, int64_t buf_size,
                              BlockMirrorBackingMode backing_mode,
                              BlockdevOnError on_source_error,
@@ -1139,12 +1139,6 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     Error *local_err = NULL;
     int ret;
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
@@ -1298,6 +1292,11 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
     bool is_none_mode;
     BlockDriverState *base;
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
     if (mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         error_setg(errp, "Sync mode 'incremental' not supported");
         return;
@@ -1323,6 +1322,12 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 
     orig_base_flags = bdrv_get_flags(base);
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     if (bdrv_reopen(base, bs->open_flags, errp)) {
         return;
     }
-- 
2.7.5
