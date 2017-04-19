Received: from eggs.gnu.org ([2001:4830:134:3::10]:34294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoT-0004aV-8H
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoS-0001Wf-73
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoS-0001WF-1i
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:32 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A8228051D
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:31 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5I001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:30 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:17 +0200
Message-Id: <20170419144219.20371-10-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
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
