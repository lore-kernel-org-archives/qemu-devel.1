Received: from eggs.gnu.org ([2001:4830:134:3::10]:55144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dL1lG-0006o6-Qp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dL1lG-000827-1F
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:26:38 -0400
From: "sochin.jiang" <sochin.jiang@huawei.com>
Date: Wed, 14 Jun 2017 14:22:39 +0800
Message-ID: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] fix: avoid infinite loop when blockjob
 encountering failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

img_commit could fall into infinite loop if it's blockjob

fail encountering any I/O error. Try to fix it.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
---
 qemu-img.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 0ad698d..6ba565d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -895,8 +895,11 @@ static void run_block_job(BlockJob *job, Error **errp)
         aio_poll(aio_context, true);
         qemu_progress_print(job->len ?
                             ((float)job->offset / job->len * 100.f) : 0.0f, 0);
-    } while (!job->ready);
+    } while (!job->ready && !job->ret);
 
+    if (job->ret) {
+        return;
+    }
     block_job_complete_sync(job, errp);
     aio_context_release(aio_context);
 
-- 
1.8.3.1
