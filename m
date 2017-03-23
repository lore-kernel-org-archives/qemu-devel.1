Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i8-0005V4-0A
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i5-0002T0-D0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6i5-0002Sn-6d
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:41 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A9A93F75C
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:26 +0100
Message-Id: <20170323173928.14439-9-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] blockjob: introduce
 block_job_cancel_async
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index c9cb5b1..093962b 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -373,6 +373,12 @@ static void block_job_completed_single(BlockJob *job)
     block_job_unref(job);
 }
 
+static void block_job_cancel_async(BlockJob *job)
+{
+    job->cancelled = true;
+    block_job_iostatus_reset(job);
+}
+
 static void block_job_completed_txn_abort(BlockJob *job)
 {
     AioContext *ctx;
@@ -397,7 +403,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
              * them; this job, however, may or may not be cancelled, depending
              * on the caller, so leave it. */
             if (other_job != job) {
-                other_job->cancelled = true;
+                block_job_cancel_async(other_job);
             }
             continue;
         }
@@ -489,8 +495,7 @@ void block_job_user_resume(BlockJob *job)
 void block_job_cancel(BlockJob *job)
 {
     if (block_job_started(job)) {
-        job->cancelled = true;
-        block_job_iostatus_reset(job);
+        block_job_cancel_async(job);
         block_job_enter(job);
     } else {
         block_job_completed(job, -ECANCELED);
-- 
2.9.3
