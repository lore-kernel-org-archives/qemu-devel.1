Received: from eggs.gnu.org ([2001:4830:134:3::10]:49321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJK-0007g2-1H
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-00047k-Lg
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:14 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:42 +0200
Message-Id: <1502117160-24655-39-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 38/56] blockjob: Lift speed sign conversion
 out of block_job_set_speed()
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
uint64_t in block_job_set_speed().  It rejects negative speed.

Lift this check and conversion up into its callers
qmp_block_job_set_speed() and block_job_create().  I'm going to lift
it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c               |  6 ++++++
 blockjob.c               | 14 +++++++-------
 include/block/blockjob.h |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 98dbe51..f9afc32 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3697,6 +3697,12 @@ void qmp_block_job_set_speed(const char *device, int64_t speed, Error **errp)
         return;
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     block_job_set_speed(job, speed, errp);
     aio_context_release(aio_context);
 }
diff --git a/blockjob.c b/blockjob.c
index e653eef..998ffef 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -452,19 +452,13 @@ static void block_job_completed_txn_success(BlockJob *job)
     }
 }
 
-void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
+void block_job_set_speed(BlockJob *job, uint64_t speed, Error **errp)
 {
     if (!job->driver->set_speed) {
         error_setg(errp, QERR_UNSUPPORTED);
         return;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     job->driver->set_speed(job, speed);
     job->speed = speed;
 }
@@ -647,6 +641,12 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         }
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return NULL;
+    }
+
     blk = blk_new(perm, shared_perm);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index bf5314b..5eb1537 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -198,7 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job);
  * Set a rate-limiting parameter for the job; the actual meaning may
  * vary depending on the job type.
  */
-void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
+void block_job_set_speed(BlockJob *job, uint64_t speed, Error **errp);
 
 /**
  * block_job_start:
-- 
2.7.5
