Received: from eggs.gnu.org ([2001:4830:134:3::10]:57762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jPy-0007ZT-7Y
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jPx-0003N6-Hi
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:13:42 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  8 May 2017 16:13:08 +0200
Message-Id: <20170508141310.8674-10-pbonzini@redhat.com>
In-Reply-To: <20170508141310.8674-1-pbonzini@redhat.com>
References: <20170508141310.8674-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] blockjob: strengthen a bit
 test-blockjob-txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, jsnow@redhat.com, stefanha@redhat.com

Unlike test-blockjob-txn, QMP releases the reference to the transaction
before the jobs finish.  Thus, qemu-iotest 124 showed a failure while
working on the next patch that the unit tests did not have.  Make
the test a little nastier.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-blockjob-txn.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 0f80194e85..c77343fc04 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -167,6 +167,11 @@ static void test_pair_jobs(int expected1, int expected2)
     block_job_start(job1);
     block_job_start(job2);
 
+    /* Release our reference now to trigger as many nice
+     * use-after-free bugs as possible.
+     */
+    block_job_txn_unref(txn);
+
     if (expected1 == -ECANCELED) {
         block_job_cancel(job1);
     }
@@ -187,8 +192,6 @@ static void test_pair_jobs(int expected1, int expected2)
 
     g_assert_cmpint(result1, ==, expected1);
     g_assert_cmpint(result2, ==, expected2);
-
-    block_job_txn_unref(txn);
 }
 
 static void test_pair_jobs_success(void)
-- 
2.12.2
