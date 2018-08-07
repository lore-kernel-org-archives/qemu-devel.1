Received: from eggs.gnu.org ([2001:4830:134:3::10]:53932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth3-0004gK-JR
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth1-0001Hc-MZ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:01 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:35 -0400
Message-Id: <20180807043349.27196-8-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 07/21] block/create: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Utilize the job_exit shim by simply not calling job_defer_to_main_loop.
While we're here, we don't need to duplicate the core job object's `ret`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/create.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/create.c b/block/create.c
index 84bc74b7de..3aeafc68cf 100644
--- a/block/create.c
+++ b/block/create.c
@@ -34,26 +34,17 @@ typedef struct BlockdevCreateJob {
     Job common;
     BlockDriver *drv;
     BlockdevCreateOptions *opts;
-    int ret;
 } BlockdevCreateJob;
 
-static void blockdev_create_complete(Job *job, void *opaque)
-{
-    BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
-
-    job_completed(job, s->ret);
-}
-
 static void coroutine_fn blockdev_create_run(void *opaque)
 {
     BlockdevCreateJob *s = opaque;
 
     job_progress_set_remaining(&s->common, 1);
-    s->ret = s->drv->bdrv_co_create(s->opts, &s->common.err);
+    s->common.ret = s->drv->bdrv_co_create(s->opts, &s->common.err);
     job_progress_update(&s->common, 1);
 
     qapi_free_BlockdevCreateOptions(s->opts);
-    job_defer_to_main_loop(&s->common, blockdev_create_complete, NULL);
 }
 
 static const JobDriver blockdev_create_job_driver = {
-- 
2.14.4
