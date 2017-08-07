Received: from eggs.gnu.org ([2001:4830:134:3::10]:49075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ9-0007RS-5P
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIt-0003xw-VQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:40 +0200
Message-Id: <1502117160-24655-37-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 36/56] blockjob: Drop unused parameter
 @errp of method set_speed()
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/backup.c               | 2 +-
 block/commit.c               | 2 +-
 block/mirror.c               | 2 +-
 block/stream.c               | 2 +-
 blockjob.c                   | 9 +--------
 include/block/blockjob_int.h | 2 +-
 6 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index b76143d..359e526 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -188,7 +188,7 @@ static int coroutine_fn backup_before_write_notify(
     return backup_do_cow(job, req->offset, req->bytes, NULL, true);
 }
 
-static void backup_set_speed(BlockJob *job, uint64_t speed, Error **errp)
+static void backup_set_speed(BlockJob *job, uint64_t speed)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common);
 
diff --git a/block/commit.c b/block/commit.c
index 5dc1c73..ae9191d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -220,7 +220,7 @@ out:
     block_job_defer_to_main_loop(&s->common, commit_complete, data);
 }
 
-static void commit_set_speed(BlockJob *job, uint64_t speed, Error **errp)
+static void commit_set_speed(BlockJob *job, uint64_t speed)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common);
 
diff --git a/block/mirror.c b/block/mirror.c
index 7959a7f..6c3b446 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -928,7 +928,7 @@ immediate_exit:
     block_job_defer_to_main_loop(&s->common, mirror_exit, data);
 }
 
-static void mirror_set_speed(BlockJob *job, uint64_t speed, Error **errp)
+static void mirror_set_speed(BlockJob *job, uint64_t speed)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
 
diff --git a/block/stream.c b/block/stream.c
index 11b6673..9a145f2 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -207,7 +207,7 @@ out:
     block_job_defer_to_main_loop(&s->common, stream_complete, data);
 }
 
-static void stream_set_speed(BlockJob *job, uint64_t speed, Error **errp)
+static void stream_set_speed(BlockJob *job, uint64_t speed)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common);
 
diff --git a/blockjob.c b/blockjob.c
index 7f77b7e..e653eef 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -454,8 +454,6 @@ static void block_job_completed_txn_success(BlockJob *job)
 
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (!job->driver->set_speed) {
         error_setg(errp, QERR_UNSUPPORTED);
         return;
@@ -467,12 +465,7 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
         return;
     }
 
-    job->driver->set_speed(job, speed, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
+    job->driver->set_speed(job, speed);
     job->speed = speed;
 }
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 2d10794..dadfd8c 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -42,7 +42,7 @@ struct BlockJobDriver {
     BlockJobType job_type;
 
     /** Optional callback for job types that support setting a speed limit */
-    void (*set_speed)(BlockJob *job, uint64_t speed, Error **errp);
+    void (*set_speed)(BlockJob *job, uint64_t speed);
 
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
-- 
2.7.5
