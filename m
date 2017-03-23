Received: from eggs.gnu.org ([2001:4830:134:3::10]:53930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i8-0005V5-0d
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i4-0002SZ-29
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6i3-0002SM-SP
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:39 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6A827713
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:25 +0100
Message-Id: <20170323173928.14439-8-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] blockjob: strengthen a bit
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
Cc: jcody@redhat.com, jsnow@redhat.com

Unlike test-blockjob-txn, QMP releases the reference to the transaction
before the jobs finish.  Thus, while working on the next patch,
qemu-iotest 124 showed a failure that the unit tests did not have.
Make the unit test just a little nastier, so that it fails too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-blockjob-txn.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 4ccbda1..bfc2aaa 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -165,6 +165,11 @@ static void test_pair_jobs(int expected1, int expected2)
     job2 = test_block_job_start(2, true, expected2, &result2);
     block_job_txn_add_job(txn, job2);
 
+    /* Release our reference now to trigger as many nice
+     * use-after-free bugs as possible.
+     */
+    block_job_txn_unref(txn);
+
     if (expected1 == -ECANCELED) {
         block_job_cancel(job1);
     }
@@ -185,8 +190,6 @@ static void test_pair_jobs(int expected1, int expected2)
 
     g_assert_cmpint(result1, ==, expected1);
     g_assert_cmpint(result2, ==, expected2);
-
-    block_job_txn_unref(txn);
 }
 
 static void test_pair_jobs_success(void)
-- 
2.9.3
