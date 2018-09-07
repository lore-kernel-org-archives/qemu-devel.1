Received: from eggs.gnu.org ([2001:4830:134:3::10]:53445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQf-0006K5-3Z
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQa-0004Lv-LS
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Sep 2018 18:15:17 +0200
Message-Id: <20180907161520.26349-12-kwolf@redhat.com>
In-Reply-To: <20180907161520.26349-1-kwolf@redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 11/14] mirror: Fix potential use-after-free in
 active commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

When starting an active commit job, other callbacks can run before
mirror_start_job() calls bdrv_ref() where needed and cause the nodes to
go away. Add another pair of bdrv_ref/unref() around it to protect
against this case.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 6cc10df5c9..c42999eadf 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1679,6 +1679,11 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 
     orig_base_flags = bdrv_get_flags(base);
 
+    /* bdrv_reopen() drains, which might make the BDSes go away before a
+     * reference is taken in mirror_start_job(). */
+    bdrv_ref(bs);
+    bdrv_ref(base);
+
     if (bdrv_reopen(base, bs->open_flags, errp)) {
         return;
     }
@@ -1689,6 +1694,10 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
                      &local_err);
+
+    bdrv_unref(bs);
+    bdrv_unref(base);
+
     if (local_err) {
         error_propagate(errp, local_err);
         goto error_restore_flags;
-- 
2.13.6
