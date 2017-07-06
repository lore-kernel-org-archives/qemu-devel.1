Received: from eggs.gnu.org ([2001:4830:134:3::10]:33157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nj-0004s9-1n
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nh-00063i-Tr
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:47 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:22 +0200
Message-Id: <20170706163828.24082-6-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] block-backup: add reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Protect the list of inflight reqs and the CoQueues for dependent
requests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/backup.c               | 20 +++++++++++++++-----
 block/replication.c          |  2 +-
 include/block/block_backup.h |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9214ffcc58..0ed7726fe6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -45,6 +45,7 @@ typedef struct BackupBlockJob {
     bool compress;
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
+    CoMutex reqs_lock;
 } BackupBlockJob;
 
 /* Size of a cluster in sectors, instead of bytes. */
@@ -61,16 +62,18 @@ static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
     CowRequest *req;
     bool retry;
 
+    qemu_co_mutex_lock(&job->reqs_lock);
     do {
         retry = false;
         QLIST_FOREACH(req, &job->inflight_reqs, list) {
             if (end > req->start && start < req->end) {
-                qemu_co_queue_wait(&req->wait_queue, NULL);
+                qemu_co_queue_wait(&req->wait_queue, &job->reqs_lock);
                 retry = true;
                 break;
             }
         }
     } while (retry);
+    qemu_co_mutex_unlock(&job->reqs_lock);
 }
 
 /* Keep track of an in-flight request */
@@ -80,14 +83,18 @@ static void cow_request_begin(CowRequest *req, BackupBlockJob *job,
     req->start = start;
     req->end = end;
     qemu_co_queue_init(&req->wait_queue);
+    qemu_co_mutex_lock(&job->reqs_lock);
     QLIST_INSERT_HEAD(&job->inflight_reqs, req, list);
+    qemu_co_mutex_unlock(&job->reqs_lock);
 }
 
 /* Forget about a completed request */
-static void cow_request_end(CowRequest *req)
+static void cow_request_end(CowRequest *req, BackupBlockJob *job)
 {
+    qemu_co_mutex_lock(&job->reqs_lock);
     QLIST_REMOVE(req, list);
     qemu_co_queue_restart_all(&req->wait_queue);
+    qemu_co_mutex_unlock(&job->reqs_lock);
 }
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
@@ -175,7 +182,7 @@ out:
         qemu_vfree(bounce_buffer);
     }
 
-    cow_request_end(&cow_request);
+    cow_request_end(&cow_request, job);
 
     trace_backup_do_cow_return(job, sector_num, nb_sectors, ret);
 
@@ -311,9 +318,11 @@ void backup_cow_request_begin(CowRequest *req, BlockJob *job,
     cow_request_begin(req, backup_job, start, end);
 }
 
-void backup_cow_request_end(CowRequest *req)
+void backup_cow_request_end(CowRequest *req, BlockJob *job)
 {
-    cow_request_end(req);
+    BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
+
+    cow_request_end(req, backup_job);
 }
 
 static void backup_drain(BlockJob *job)
@@ -653,6 +662,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
+    qemu_co_mutex_init(&job->reqs_lock);
     job->on_source_error = on_source_error;
     job->on_target_error = on_target_error;
     job->sync_mode = sync_mode;
diff --git a/block/replication.c b/block/replication.c
index 3885f04c31..5d6e2ec916 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -240,7 +240,7 @@ static coroutine_fn int replication_co_readv(BlockDriverState *bs,
                                  remaining_sectors);
         ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors,
                             qiov);
-        backup_cow_request_end(&req);
+        backup_cow_request_end(&req, child->bs->job);
         goto out;
     }
 
diff --git a/include/block/block_backup.h b/include/block/block_backup.h
index 8a759477a3..2fe0cdd808 100644
--- a/include/block/block_backup.h
+++ b/include/block/block_backup.h
@@ -32,7 +32,7 @@ void backup_wait_for_overlapping_requests(BlockJob *job, int64_t sector_num,
 void backup_cow_request_begin(CowRequest *req, BlockJob *job,
                               int64_t sector_num,
                               int nb_sectors);
-void backup_cow_request_end(CowRequest *req);
+void backup_cow_request_end(CowRequest *req, BlockJob *job);
 
 void backup_do_checkpoint(BlockJob *job, Error **errp);
 
-- 
2.13.0
