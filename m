Received: from eggs.gnu.org ([2001:4830:134:3::10]:33656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fsK3P-0001iZ-Ib
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 23:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fsK3O-0001va-Ru
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 23:43:31 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Aug 2018 23:43:18 -0400
Message-Id: <20180822034319.686504-2-jcody@redhat.com>
In-Reply-To: <20180822034319.686504-1-jcody@redhat.com>
References: <20180822034319.686504-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] block: for jobs,
 do not clear user_paused until after the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

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
Message-id: bb183b77d8f2dd6bd67b8da559a90ac1e74b2052.1534868459.git.jcody@redhat.com
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
