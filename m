Received: from eggs.gnu.org ([2001:4830:134:3::10]:33423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjnPi-0008Et-Mb
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjnPh-0001DR-V6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:38:30 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  3 Mar 2017 21:38:16 +0800
Message-Id: <20170303133816.30303-3-famz@redhat.com>
In-Reply-To: <20170303133816.30303-1-famz@redhat.com>
References: <20170303133816.30303-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] commit: Don't use error_abort in
 commit_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

bdrv_set_backing_hd failure needn't be abort. Since we already have
error parameter, use it.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 22a0a4d..1be19e1 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -316,8 +316,16 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    bdrv_set_backing_hd(commit_top_bs, top, &error_abort);
-    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &error_abort);
+    bdrv_set_backing_hd(commit_top_bs, top, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
 
     s->commit_top_bs = commit_top_bs;
     bdrv_unref(commit_top_bs);
-- 
2.9.3
