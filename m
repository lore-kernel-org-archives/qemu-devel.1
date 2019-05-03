Received: from eggs.gnu.org ([209.51.188.92]:35192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hMboy-0001yV-Me
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hMbox-00058t-QA
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:18:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  3 May 2019 19:17:43 +0200
Message-Id: <20190503171744.21589-2-kwolf@redhat.com>
In-Reply-To: <20190503171744.21589-1-kwolf@redhat.com>
References: <20190503171744.21589-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] blockjob: Fix coroutine thread after
 AioContext change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Commit 463e0be10 ('blockjob: add AioContext attached callback') tried to
make block jobs robust against AioContext changes of their main node,
but it never made sure that the job coroutine actually runs in the new
thread.

Instead of waking up the job coroutine in whatever thread it ran before,
let's always pass the AioContext where it should be running now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/job.c b/job.c
index da8e4b7bf2..2167d53717 100644
--- a/job.c
+++ b/job.c
@@ -432,7 +432,7 @@ void job_enter_cond(Job *job, bool(*fn)(Job *job))
     timer_del(&job->sleep_timer);
     job->busy =3D true;
     job_unlock();
-    aio_co_wake(job->co);
+    aio_co_enter(job->aio_context, job->co);
 }
=20
 void job_enter(Job *job)
--=20
2.20.1
