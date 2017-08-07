Received: from eggs.gnu.org ([2001:4830:134:3::10]:49175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJC-0007WA-Vl
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIw-00040u-Rw
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:49 +0200
Message-Id: <1502117160-24655-46-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 45/56] blockjob: Lift speed sign conversion
 out of commit_start() etc.
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

commit_start() takes int64_t speed.  The underlying BlockJob
abstraction takes uint64_t.  commit_start() converts from int64_t to
uint64_t, rejecting negative speed.

Lift this check and conversion out of commit_start() and
commit_active_start() into their caller qmp_block_commit().  I'm going
to lift it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/commit.c            | 9 ++-------
 block/mirror.c            | 8 +-------
 blockdev.c                | 6 ++++++
 include/block/block_int.h | 5 +++--
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 86d780e..f61421f 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -282,7 +282,8 @@ static BlockDriver bdrv_commit_top = {
 };
 
 void commit_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, BlockDriverState *top, int64_t speed,
+                  BlockDriverState *base, BlockDriverState *top,
+                  uint64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
                   const char *filter_node_name, Error **errp)
 {
@@ -309,12 +310,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
                          speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
diff --git a/block/mirror.c b/block/mirror.c
index af0c989..f1adda5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1307,7 +1307,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
 
 void commit_active_start(const char *job_id, BlockDriverState *bs,
                          BlockDriverState *base, int creation_flags,
-                         int64_t speed, BlockdevOnError on_error,
+                         uint64_t speed, BlockdevOnError on_error,
                          const char *filter_node_name,
                          BlockCompletionFunc *cb, void *opaque,
                          bool auto_complete, Error **errp)
@@ -1317,12 +1317,6 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 
     orig_base_flags = bdrv_get_flags(base);
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     if (bdrv_reopen(base, bs->open_flags, errp)) {
         return;
     }
diff --git a/blockdev.c b/blockdev.c
index 13df88b..e679f5d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3102,6 +3102,12 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        goto out;
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3ff5536..75116e5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -840,7 +840,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
  *
  */
 void commit_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, BlockDriverState *top, int64_t speed,
+                  BlockDriverState *base, BlockDriverState *top,
+                  uint64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
                   const char *filter_node_name, Error **errp);
 /**
@@ -864,7 +865,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
  */
 void commit_active_start(const char *job_id, BlockDriverState *bs,
                          BlockDriverState *base, int creation_flags,
-                         int64_t speed, BlockdevOnError on_error,
+                         uint64_t speed, BlockdevOnError on_error,
                          const char *filter_node_name,
                          BlockCompletionFunc *cb, void *opaque,
                          bool auto_complete, Error **errp);
-- 
2.7.5
