Received: from eggs.gnu.org ([2001:4830:134:3::10]:49084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ9-0007RX-Lw
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIu-0003y7-2z
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:39 +0200
Message-Id: <1502117160-24655-36-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 35/56] blockjob: Lift speed sign conversion
 into block_job_set_speed()
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

The BlockJob abstraction takes int64_t speed.  The underlying
RateLimit abstraction takes uint64_t.  We convert from int64_t to
uint64_t in the BlockJobDriver speed_set() methods.  They all reject
negative speed.

Lift this check and conversion up into the method's caller
block_job_set_speed().  I'm going to lift it further until it falls
off the top.

Improve the error message while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/backup.c               | 6 +-----
 block/commit.c               | 6 +-----
 block/mirror.c               | 6 +-----
 block/stream.c               | 6 +-----
 blockjob.c                   | 7 +++++++
 include/block/blockjob.h     | 2 +-
 include/block/blockjob_int.h | 2 +-
 7 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index a37c944..b76143d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -188,14 +188,10 @@ static int coroutine_fn backup_before_write_notify(
     return backup_do_cow(job, req->offset, req->bytes, NULL, true);
 }
 
-static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
+static void backup_set_speed(BlockJob *job, uint64_t speed, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common);
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
     ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }
 
diff --git a/block/commit.c b/block/commit.c
index c7857c3..5dc1c73 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -220,14 +220,10 @@ out:
     block_job_defer_to_main_loop(&s->common, commit_complete, data);
 }
 
-static void commit_set_speed(BlockJob *job, int64_t speed, Error **errp)
+static void commit_set_speed(BlockJob *job, uint64_t speed, Error **errp)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common);
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
     ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }
 
diff --git a/block/mirror.c b/block/mirror.c
index 37a8744..7959a7f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -928,14 +928,10 @@ immediate_exit:
     block_job_defer_to_main_loop(&s->common, mirror_exit, data);
 }
 
-static void mirror_set_speed(BlockJob *job, int64_t speed, Error **errp)
+static void mirror_set_speed(BlockJob *job, uint64_t speed, Error **errp)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
     ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }
 
diff --git a/block/stream.c b/block/stream.c
index e6f7234..11b6673 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -207,14 +207,10 @@ out:
     block_job_defer_to_main_loop(&s->common, stream_complete, data);
 }
 
-static void stream_set_speed(BlockJob *job, int64_t speed, Error **errp)
+static void stream_set_speed(BlockJob *job, uint64_t speed, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common);
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
     ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }
 
diff --git a/blockjob.c b/blockjob.c
index 70a7818..7f77b7e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -460,6 +460,13 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_UNSUPPORTED);
         return;
     }
+
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     job->driver->set_speed(job, speed, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 67c0968..bf5314b 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -110,7 +110,7 @@ typedef struct BlockJob {
     int64_t len;
 
     /** Speed that was set with @block_job_set_speed.  */
-    int64_t speed;
+    uint64_t speed;
 
     /** The completion function that will be called when the job completes.  */
     BlockCompletionFunc *cb;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f13ad05..2d10794 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -42,7 +42,7 @@ struct BlockJobDriver {
     BlockJobType job_type;
 
     /** Optional callback for job types that support setting a speed limit */
-    void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
+    void (*set_speed)(BlockJob *job, uint64_t speed, Error **errp);
 
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
-- 
2.7.5
