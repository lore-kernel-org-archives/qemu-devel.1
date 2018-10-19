Received: from eggs.gnu.org ([2001:4830:134:3::10]:54754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXz-0007wN-UD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXw-0002Xj-Nc
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:03 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:39:02 +0100
Message-Id: <1539981546-10596-5-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 4/8] qemu-img: assert block_job_get() does
 not return NULL in img_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

Although the function block_job_get() can return NULL, it would be a
serious bug if it did so (because the job yields before executing anything
(if it started successfully); but otherwise, commit_active_start() would
have returned an error).  However, as a precaution, before dereferencing
the 'job' pointer in img_commit() assert it is not NULL.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index b12f4cd19b0a..457aa152296b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1029,6 +1029,7 @@ static int img_commit(int argc, char **argv)
     }
 
     job = block_job_get("commit");
+    assert(job);
     run_block_job(job, &local_err);
     if (local_err) {
         goto unref_backing;
-- 
1.8.3.1
