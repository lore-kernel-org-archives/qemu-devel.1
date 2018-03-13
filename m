Received: from eggs.gnu.org ([2001:4830:134:3::10]:59735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdQ-0001fn-0v
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdP-0004mH-2H
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:53 +0100
Message-Id: <20180313161803.1814-32-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 31/41] block: Fix flags in reopen queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Reopen flags are not synchronized according to the
bdrv_reopen_queue_child precedence until bdrv_reopen_prepare. It is a
bit too late: we already check the consistency in bdrv_check_perm before
that.

This fixes the bug that when bdrv_reopen a RO node as RW, the flags for
backing child are wrong. Before, we could recurse with flags.rw=1; now,
role->inherit_options + update_flags_from_options will make sure to
clear the bit when necessary.  Note that this will not clear an
explicitly set bit, as in the case of parallel block jobs (e.g.
test_stream_parallel in 030), because the explicit options include
'read-only=false' (for an intermediate node used by a different job).

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block.c b/block.c
index 75a9fd49de..e02d83b027 100644
--- a/block.c
+++ b/block.c
@@ -2883,8 +2883,16 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     /* Inherit from parent node */
     if (parent_options) {
+        QemuOpts *opts;
+        QDict *options_copy;
         assert(!flags);
         role->inherit_options(&flags, options, parent_flags, parent_options);
+        options_copy = qdict_clone_shallow(options);
+        opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
+        qemu_opts_absorb_qdict(opts, options_copy, NULL);
+        update_flags_from_options(&flags, opts);
+        qemu_opts_del(opts);
+        QDECREF(options_copy);
     }
 
     /* Old values are used for options that aren't set yet */
-- 
2.13.6
