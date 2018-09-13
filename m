Received: from eggs.gnu.org ([2001:4830:134:3::10]:46520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R6u-00021h-Q5
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R6t-0001aW-Se
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:01 +0200
Message-Id: <20180913125217.23173-2-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/17] job: Fix missing locking due to
 mismerge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

job_completed() had a problem with double locking that was recently
fixed independently by two different commits:

"job: Fix nested aio_poll() hanging in job_txn_apply"
"jobs: add exit shim"

One fix removed the first aio_context_acquire(), the other fix removed
the other one. Now we have a bug again and the code is run without any
locking.

Add it back in one of the places.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 job.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/job.c b/job.c
index 82b46929bd..5c4e84f007 100644
--- a/job.c
+++ b/job.c
@@ -847,7 +847,11 @@ static void job_completed(Job *job)
 static void job_exit(void *opaque)
 {
     Job *job = (Job *)opaque;
+    AioContext *ctx = job->aio_context;
+
+    aio_context_acquire(ctx);
     job_completed(job);
+    aio_context_release(ctx);
 }
 
 /**
-- 
2.13.6
