Received: from eggs.gnu.org ([2001:4830:134:3::10]:53856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth1-0004fY-Ss
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth0-0001GG-6y
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:33:59 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:31 -0400
Message-Id: <20180807043349.27196-4-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 03/21] block/backup: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Utilize the job_exit shim by simply not calling job_defer_to_main_loop.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index f3bf842423..af6ee5ab54 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -380,18 +380,6 @@ static BlockErrorAction backup_error_action(BackupBlockJob *job,
     }
 }
 
-typedef struct {
-    int ret;
-} BackupCompleteData;
-
-static void backup_complete(Job *job, void *opaque)
-{
-    BackupCompleteData *data = opaque;
-
-    job_completed(job, data->ret);
-    g_free(data);
-}
-
 static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 {
     uint64_t delay_ns;
@@ -483,7 +471,6 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 static void coroutine_fn backup_run(void *opaque)
 {
     BackupBlockJob *job = opaque;
-    BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
     int64_t offset, nb_clusters;
     int ret = 0;
@@ -584,9 +571,7 @@ static void coroutine_fn backup_run(void *opaque)
     qemu_co_rwlock_unlock(&job->flush_rwlock);
     hbitmap_free(job->copy_bitmap);
 
-    data = g_malloc(sizeof(*data));
-    data->ret = ret;
-    job_defer_to_main_loop(&job->common.job, backup_complete, data);
+    job->common.job.ret = ret;
 }
 
 static const BlockJobDriver backup_job_driver = {
-- 
2.14.4
