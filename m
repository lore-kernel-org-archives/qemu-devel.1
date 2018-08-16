Received: from eggs.gnu.org ([2001:4830:134:3::10]:38310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fqNHy-0006hw-1W
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fqNHx-0002OD-7j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:46:29 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Thu, 16 Aug 2018 14:46:07 -0400
Message-Id: <68da830d390658684c0b5688c4c91858c8ea3930.1534444235.git.jcody@redhat.com>
In-Reply-To: <cover.1534444235.git.jcody@redhat.com>
References: <cover.1534444235.git.jcody@redhat.com>
In-Reply-To: <cover.1534444235.git.jcody@redhat.com>
References: <cover.1534444235.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] block: for jobs,
 do not clear user_paused until after the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, eblake@redhat.com

The function job_cancel_async() will always cause an assert for blockjob
user resume.  We set job->user_paused to false, and then call
job->driver->user_resume().  In the case of blockjobs, this is the
block_job_user_resume() function.

In that function, we assert that job.user_paused is set to true.
Unfortunately, right before calling this function, it has explicitly
been set to false.

The fix is pretty simple: set job->user_paused to false only after the
job user_resume() function has been called.

Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/job.c b/job.c
index fa671b431a..e36ebaafd8 100644
--- a/job.c
+++ b/job.c
@@ -732,10 +732,10 @@ static void job_cancel_async(Job *job, bool force)
 {
     if (job->user_paused) {
         /* Do not call job_enter here, the caller will handle it.  */
-        job->user_paused = false;
         if (job->driver->user_resume) {
             job->driver->user_resume(job);
         }
+        job->user_paused = false;
         assert(job->pause_count > 0);
         job->pause_count--;
     }
-- 
2.17.1
