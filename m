Received: from eggs.gnu.org ([2001:4830:134:3::10]:53873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i3-0005Rz-LV
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i2-0002S8-Oz
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6i2-0002Rq-JR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:38 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94883A0E46
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:24 +0100
Message-Id: <20170323173928.14439-7-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] blockjob: move iostatus reset inside
 block_job_user_resume
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

Outside blockjob.c, the block_job_iostatus_reset function is used once
in the monitor and once in BlockBackend.  When we introduce the block
job mutex, block_job_iostatus_reset's client is going to be the block
layer (for which blockjob.c will take the block job mutex) rather than
the monitor (which will take the block job mutex by itself).

The monitor's call to block_job_iostatus_reset from the monitor comes
just before the sole call to block_job_user_resume, so reset the
iostatus directly from block_job_iostatus_reset.  This will avoid
the need to introduce separate block_job_iostatus_reset and
block_job_iostatus_reset_locked APIs.

After making this change, move the function together with the others
that were moved in the previous patch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockdev.c |  1 -
 blockjob.c | 11 ++++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index c5b2c2c..fbc376b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3726,7 +3726,6 @@ void qmp_block_job_resume(const char *device, Error **errp)
     }
 
     trace_qmp_block_job_resume(job);
-    block_job_iostatus_reset(job);
     block_job_user_resume(job);
     aio_context_release(aio_context);
 }
diff --git a/blockjob.c b/blockjob.c
index c5f1d19..c9cb5b1 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -481,6 +481,7 @@ void block_job_user_resume(BlockJob *job)
 {
     if (job && job->user_paused && job->pause_count > 0) {
         job->user_paused = false;
+        block_job_iostatus_reset(job);
         block_job_resume(job);
     }
 }
@@ -496,11 +497,6 @@ void block_job_cancel(BlockJob *job)
     }
 }
 
-void block_job_iostatus_reset(BlockJob *job)
-{
-    job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
-}
-
 static int block_job_finish_sync(BlockJob *job,
                                  void (*finish)(BlockJob *, Error **errp),
                                  Error **errp)
@@ -751,6 +747,11 @@ void block_job_yield(BlockJob *job)
     block_job_pause_point(job);
 }
 
+void block_job_iostatus_reset(BlockJob *job)
+{
+    job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
+}
+
 void block_job_event_ready(BlockJob *job)
 {
     job->ready = true;
-- 
2.9.3
