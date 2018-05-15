Received: from eggs.gnu.org ([2001:4830:134:3::10]:38729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4Q-0006fs-Qw
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4P-0001SN-KS
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:07 +0200
Message-Id: <20180515154033.19899-12-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/37] blockjob: Fix assertion in
 block_job_finalize()
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

Every job gets a non-NULL job->txn on creation, but it doesn't
necessarily keep it until it is decommissioned: Finalising a job removes
it from its transaction. Therefore, calling 'blockdev-job-finalize' a
second time on an already concluded job causes an assertion failure.

Remove job->txn from the assertion in block_job_finalize() to fix this.
block_job_do_finalize() still has the same assertion, but if a job is
already removed from its transaction, block_job_apply_verb() will
already error out before we run into that assertion.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 0b9b336d19..0ebc5ab178 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -702,7 +702,7 @@ void block_job_complete(BlockJob *job, Error **errp)
 
 void block_job_finalize(BlockJob *job, Error **errp)
 {
-    assert(job && job->id && job->txn);
+    assert(job && job->id);
     if (block_job_apply_verb(job, BLOCK_JOB_VERB_FINALIZE, errp)) {
         return;
     }
-- 
2.13.6
