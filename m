Received: from eggs.gnu.org ([2001:4830:134:3::10]:58077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1cIzG8-0001Fo-O6
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1cIzG7-0006Gt-Ri
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:49:48 -0500
From: sochin jiang <sochin.jiang@huawei.com>
Date: Tue, 20 Dec 2016 06:38:26 +0800
Message-ID: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] mirror: prevent 'top' mode mirroring when no
 backing file specified on the destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, xieyingtai@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, wangjie88@huawei.com

 Mirroring using 'top' mode without backing file specified on the target can be success,
 but end with a disaster.

 For example:
   Migration can be success in this situation while the virtual machine on the destination
 is no longer usable because of backing lost.

 Remind the user earlier and return error in case of misoperation.

Signed-off-by: sochin jiang <sochin.jiang@huawei.com>
---
 block/mirror.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 301ba92..3476696 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1038,6 +1038,12 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
         error_setg(errp, "Sync mode 'incremental' not supported");
         return;
     }
+    if (mode == MIRROR_SYNC_MODE_TOP && !backing_bs(target))
+    {
+        error_setg(errp, "Target Backing required using Sync mode 'top'");
+        return;
+    }
+
     is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
     mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target, replaces,
-- 
1.8.3.1
