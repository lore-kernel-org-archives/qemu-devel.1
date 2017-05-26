Received: from eggs.gnu.org ([2001:4830:134:3::10]:46290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqZ-0002UD-4S
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqY-0005yM-A6
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:27 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 26 May 2017 15:24:01 -0400
Message-Id: <20170526192404.32186-10-jcody@redhat.com>
In-Reply-To: <20170526192404.32186-1-jcody@redhat.com>
References: <20170526192404.32186-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 09/12] blockjob: strengthen a bit
 test-blockjob-txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Unlike test-blockjob-txn, QMP releases the reference to the transaction
before the jobs finish.  Thus, qemu-iotest 124 showed a failure while
working on the next patch that the unit tests did not have.  Make
the test a little nastier.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20170508141310.8674-10-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/test-blockjob-txn.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 0f80194..c77343f 100644
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
2.9.3
