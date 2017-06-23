Received: from eggs.gnu.org ([2001:4830:134:3::10]:59065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLW-0000Ib-U4
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLW-0007Qd-1t
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:20:59 +0200
Message-Id: <1498234919-27316-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/61] commit: Fix completion with extra
 reference
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

commit_complete() can't assume that after its block_job_completed() the
job is actually immediately freed; someone else may still be holding
references. In this case, the op blockers on the intermediate nodes make
the graph reconfiguration in the completion code fail.

Call block_job_remove_all_bdrv() manually so that we know for sure that
any blockers on intermediate nodes are given up.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index af6fa68..8c09c3d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -119,6 +119,13 @@ static void commit_complete(BlockJob *job, void *opaque)
     }
     g_free(s->backing_file_str);
     blk_unref(s->top);
+
+    /* If there is more than one reference to the job (e.g. if called from
+     * block_job_finish_sync()), block_job_completed() won't free it and
+     * therefore the blockers on the intermediate nodes remain. This would
+     * cause bdrv_set_backing_hd() to fail. */
+    block_job_remove_all_bdrv(job);
+
     block_job_completed(&s->common, ret);
     g_free(data);
 
-- 
1.8.3.1
