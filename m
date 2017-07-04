Received: from eggs.gnu.org ([2001:4830:134:3::10]:48424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVw5-0007ae-J1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVw4-0008Sa-NU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:45 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:18 +0200
Message-Id: <20170704220346.29244-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/35] blockjob: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

/home/elmarco/src/qemu/blockjob.c:820:9: error: calling function 'qemu_co=
routine_yield' requires holding role '_coroutine_fn' exclusively [-Werror=
,-Wthread-safety-analysis]
        qemu_coroutine_yield();
        ^
/home/elmarco/src/qemu/blockjob.c:824:5: error: calling function 'block_j=
ob_pause_point' requires holding role '_coroutine_fn' exclusively [-Werro=
r,-Wthread-safety-analysis]
    block_job_pause_point(job);
    ^
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/block/blockjob_int.h | 4 ++--
 blockjob.c                   | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f13ad05c0d..a3bc01fd51 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -145,7 +145,7 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
  * Put the job to sleep (assuming that it wasn't canceled) for @ns
  * nanoseconds.  Canceling the job will interrupt the wait immediately.
  */
-void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
+void coroutine_fn block_job_sleep_ns(BlockJob *job, QEMUClockType type, =
int64_t ns);
=20
 /**
  * block_job_yield:
@@ -153,7 +153,7 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType =
type, int64_t ns);
  *
  * Yield the block job coroutine.
  */
-void block_job_yield(BlockJob *job);
+void coroutine_fn block_job_yield(BlockJob *job);
=20
 /**
  * block_job_pause_all:
diff --git a/blockjob.c b/blockjob.c
index 70a78188b7..96424323c1 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -788,7 +788,8 @@ bool block_job_is_cancelled(BlockJob *job)
     return job->cancelled;
 }
=20
-void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
+void coroutine_fn
+block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
 {
     assert(job->busy);
=20
@@ -806,7 +807,8 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType =
type, int64_t ns)
     block_job_pause_point(job);
 }
=20
-void block_job_yield(BlockJob *job)
+void coroutine_fn
+block_job_yield(BlockJob *job)
 {
     assert(job->busy);
=20
--=20
2.13.1.395.gf7b71de06
