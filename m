Received: from eggs.gnu.org ([2001:4830:134:3::10]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoQ-0004YO-I3
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoP-0001UO-FA
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoP-0001TV-9U
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:29 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EDA18051D
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:28 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5F001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:27 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:14 +0200
Message-Id: <20170419144219.20371-7-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/11] blockjob: move iostatus reset inside
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockdev.c |  1 -
 blockjob.c | 11 ++++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 4927914..9098233 100644
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
index 140e176..5906266 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -412,6 +412,7 @@ void block_job_user_resume(BlockJob *job)
 {
     if (job && job->user_paused && job->pause_count > 0) {
         job->user_paused = false;
+        block_job_iostatus_reset(job);
         block_job_resume(job);
     }
 }
@@ -427,11 +428,6 @@ void block_job_cancel(BlockJob *job)
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
@@ -767,6 +763,11 @@ void block_job_yield(BlockJob *job)
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
