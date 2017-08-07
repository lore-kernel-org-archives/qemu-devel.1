Received: from eggs.gnu.org ([2001:4830:134:3::10]:49150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJB-0007UI-QB
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIv-0003zu-MQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:43 +0200
Message-Id: <1502117160-24655-40-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 39/56] blockjob: Lift speed sign conversion
 out of block_job_create()
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

block_job_create() takes int64_t speed.  The underlying RateLimit
abstraction takes uint64_t.  block_job_create() converts from int64_t
to uint64_t, rejecting negative speed.

Lift this check and conversion out of block_job_create() into its
callers.  I'm going to lift it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/backup.c               | 5 +++++
 block/commit.c               | 6 ++++++
 block/mirror.c               | 6 ++++++
 block/stream.c               | 6 ++++++
 blockjob.c                   | 8 +-------
 include/block/blockjob_int.h | 2 +-
 6 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 359e526..3a97836 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -577,6 +577,11 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
+        return NULL;
+    }
+
     if (sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         if (!sync_bitmap) {
             error_setg(errp, "must provide a valid bitmap name for "
diff --git a/block/commit.c b/block/commit.c
index ae9191d..86d780e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -309,6 +309,12 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
                          speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
diff --git a/block/mirror.c b/block/mirror.c
index 6c3b446..af54163 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1139,6 +1139,12 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     Error *local_err = NULL;
     int ret;
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
diff --git a/block/stream.c b/block/stream.c
index 9a145f2..fefcdb9 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -237,6 +237,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     /* Prevent concurrent jobs trying to modify the graph structure here, we
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
diff --git a/blockjob.c b/blockjob.c
index 998ffef..335099e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -604,7 +604,7 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
 
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                        BlockDriverState *bs, uint64_t perm,
-                       uint64_t shared_perm, int64_t speed, int flags,
+                       uint64_t shared_perm, uint64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp)
 {
     BlockBackend *blk;
@@ -641,12 +641,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         }
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return NULL;
-    }
-
     blk = blk_new(perm, shared_perm);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index dadfd8c..33472ba 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -133,7 +133,7 @@ struct BlockJobDriver {
  */
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                        BlockDriverState *bs, uint64_t perm,
-                       uint64_t shared_perm, int64_t speed, int flags,
+                       uint64_t shared_perm, uint64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp);
 
 /**
-- 
2.7.5
