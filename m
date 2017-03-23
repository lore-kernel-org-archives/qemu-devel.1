Received: from eggs.gnu.org ([2001:4830:134:3::10]:53809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6hy-0005Oh-OH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6hx-0002Qe-F2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6hx-0002QY-8n
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:33 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4972075EDE
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:20 +0100
Message-Id: <20170323173928.14439-3-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] blockjob: remove iostatus_reset callback
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

This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatus",
2016-05-19).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c                   | 3 ---
 include/block/blockjob_int.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index a9fb624..24d1e12 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -555,9 +555,6 @@ bool block_job_is_cancelled(BlockJob *job)
 void block_job_iostatus_reset(BlockJob *job)
 {
     job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
-    if (job->driver->iostatus_reset) {
-        job->driver->iostatus_reset(job);
-    }
 }
 
 static int block_job_finish_sync(BlockJob *job,
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 3f86cc5..bfcc5d1 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -44,9 +44,6 @@ struct BlockJobDriver {
     /** Optional callback for job types that support setting a speed limit */
     void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
 
-    /** Optional callback for job types that need to forward I/O status reset */
-    void (*iostatus_reset)(BlockJob *job);
-
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
 
-- 
2.9.3
