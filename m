Received: from eggs.gnu.org ([2001:4830:134:3::10]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eviZi-0006hk-Ut
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eviZi-0006Kt-6C
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:58:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 13 Mar 2018 19:58:13 +0800
Message-Id: <20180313115814.23774-2-famz@redhat.com>
In-Reply-To: <20180313115814.23774-1-famz@redhat.com>
References: <20180313115814.23774-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] block: Fix flags in reopen queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

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
---
 block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block.c b/block.c
index 75a9fd49de..a121d2ebcc 100644
--- a/block.c
+++ b/block.c
@@ -2883,8 +2883,15 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
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
     }
 
     /* Old values are used for options that aren't set yet */
-- 
2.14.3
