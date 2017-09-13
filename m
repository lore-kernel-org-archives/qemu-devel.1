Received: from eggs.gnu.org ([2001:4830:134:3::10]:36534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCGN-0007ou-3r
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCGM-0004nc-5t
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:18:55 +0200
Message-Id: <20170913181910.29688-4-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 03/18] blockjob: Make drained_{begin,
 end} public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

When a block job decides to be represented as a BDS and track its
associated child nodes itself instead of having the BlockJob object
track them, it needs to implement the drained_begin/drained_end child
operations.  In order to do that, it has to be able to control drainage
of the block job (i.e. to pause and resume it).  Therefore, we need to
make these operations public.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/blockjob.h | 15 +++++++++++++++
 blockjob.c               | 20 ++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 67c0968fa5..a59f316788 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -339,6 +339,21 @@ void block_job_ref(BlockJob *job);
 void block_job_unref(BlockJob *job);
 
 /**
+ * block_job_drained_begin:
+ *
+ * Inhibit I/O requests initiated by the block job.
+ */
+void block_job_drained_begin(BlockJob *job);
+
+/**
+ * block_job_drained_end:
+ *
+ * Resume I/O after it has been paused through
+ * block_job_drained_begin().
+ */
+void block_job_drained_end(BlockJob *job);
+
+/**
  * block_job_txn_unref:
  *
  * Release a reference that was previously acquired with block_job_txn_add_job
diff --git a/blockjob.c b/blockjob.c
index 3a0c49137e..4312a121fa 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -217,21 +217,29 @@ static const BdrvChildRole child_job = {
     .stay_at_node       = true,
 };
 
-static void block_job_drained_begin(void *opaque)
+void block_job_drained_begin(BlockJob *job)
 {
-    BlockJob *job = opaque;
     block_job_pause(job);
 }
 
-static void block_job_drained_end(void *opaque)
+static void block_job_drained_begin_op(void *opaque)
+{
+    block_job_drained_begin(opaque);
+}
+
+void block_job_drained_end(BlockJob *job)
 {
-    BlockJob *job = opaque;
     block_job_resume(job);
 }
 
+static void block_job_drained_end_op(void *opaque)
+{
+    block_job_drained_end(opaque);
+}
+
 static const BlockDevOps block_job_dev_ops = {
-    .drained_begin = block_job_drained_begin,
-    .drained_end = block_job_drained_end,
+    .drained_begin = block_job_drained_begin_op,
+    .drained_end = block_job_drained_end_op,
 };
 
 void block_job_remove_all_bdrv(BlockJob *job)
-- 
2.13.5
