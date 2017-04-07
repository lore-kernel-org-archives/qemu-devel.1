Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNoD-0000SJ-Pi
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNoC-0004x6-Js
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:55:49 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  7 Apr 2017 14:54:14 +0800
Message-Id: <20170407065414.9143-7-famz@redhat.com>
In-Reply-To: <20170407065414.9143-1-famz@redhat.com>
References: <20170407065414.9143-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] tests/block-job-txn: Don't start block
 job before adding to txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Previously, before test_block_job_start returns, the job can already
complete, as a result, the transactional state of other jobs added to
the same txn later cannot be handled correctly.

Move the block_job_start() calls to callers after
block_job_txn_add_job() calls.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/test-blockjob-txn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 4ccbda1..0f80194 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -110,7 +110,6 @@ static BlockJob *test_block_job_start(unsigned int iterations,
     s->result = result;
     data->job = s;
     data->result = result;
-    block_job_start(&s->common);
     return &s->common;
 }
 
@@ -123,6 +122,7 @@ static void test_single_job(int expected)
     txn = block_job_txn_new();
     job = test_block_job_start(1, true, expected, &result);
     block_job_txn_add_job(txn, job);
+    block_job_start(job);
 
     if (expected == -ECANCELED) {
         block_job_cancel(job);
@@ -164,6 +164,8 @@ static void test_pair_jobs(int expected1, int expected2)
     block_job_txn_add_job(txn, job1);
     job2 = test_block_job_start(2, true, expected2, &result2);
     block_job_txn_add_job(txn, job2);
+    block_job_start(job1);
+    block_job_start(job2);
 
     if (expected1 == -ECANCELED) {
         block_job_cancel(job1);
@@ -223,6 +225,8 @@ static void test_pair_jobs_fail_cancel_race(void)
     block_job_txn_add_job(txn, job1);
     job2 = test_block_job_start(2, false, 0, &result2);
     block_job_txn_add_job(txn, job2);
+    block_job_start(job1);
+    block_job_start(job2);
 
     block_job_cancel(job1);
 
-- 
2.9.3
