Received: from eggs.gnu.org ([2001:4830:134:3::10]:54015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth5-0004ib-6C
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth3-0001KS-Mi
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:38 -0400
Message-Id: <20180807043349.27196-11-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 10/21] tests/test-bdrv-drain: utilize job_exit
 shim
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-bdrv-drain.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 7b05082cae..f30310596c 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -752,11 +752,6 @@ typedef struct TestBlockJob {
     bool should_complete;
 } TestBlockJob;
 
-static void test_job_completed(Job *job, void *opaque)
-{
-    job_completed(job, 0);
-}
-
 static void coroutine_fn test_job_start(void *opaque)
 {
     TestBlockJob *s = opaque;
@@ -769,8 +764,6 @@ static void coroutine_fn test_job_start(void *opaque)
         qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
         job_pause_point(&s->common.job);
     }
-
-    job_defer_to_main_loop(&s->common.job, test_job_completed, NULL);
 }
 
 static void test_job_complete(Job *job, Error **errp)
-- 
2.14.4
