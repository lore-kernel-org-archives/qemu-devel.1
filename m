Received: from eggs.gnu.org ([2001:4830:134:3::10]:43076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHFB-0002gI-17
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHFA-00030P-BB
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:51 +0100
Message-Id: <1488901251-16214-28-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 27/27] commit: Don't use error_abort in
 commit_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

bdrv_set_backing_hd failure needn't be abort. Since we already have
error parameter, use it.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index e57c1cf..9c41988 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -316,8 +316,20 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    bdrv_set_backing_hd(commit_top_bs, top, &error_abort);
-    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &error_abort);
+    bdrv_set_backing_hd(commit_top_bs, top, &local_err);
+    if (local_err) {
+        bdrv_unref(commit_top_bs);
+        commit_top_bs = NULL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &local_err);
+    if (local_err) {
+        bdrv_unref(commit_top_bs);
+        commit_top_bs = NULL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
 
     s->commit_top_bs = commit_top_bs;
     bdrv_unref(commit_top_bs);
-- 
1.8.3.1
