Received: from eggs.gnu.org ([2001:4830:134:3::10]:45883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXP6s-0002mK-HR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXP6r-0000vn-KO
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:24:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 13 Dec 2018 11:24:34 +0000
Message-Id: <20181213112434.20039-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block/mirror: add missing coroutine_fn
 annotations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Marking a function coroutine_fn currently has no effect on the compiler,
but it documents that this function must be called from coroutine
context and it may yield.  This is important information for the
programmer.

Also, if we ever transition to a stackless coroutine implementation,
then it's likely that the annotation will become mandatory so the
compiler can use the correct calling convention for coroutine functions.

Cc: Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/mirror.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 8f52c6215d..408c49248f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -277,7 +277,8 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_=
t *offset,
     return ret;
 }
=20
-static inline void mirror_wait_for_any_operation(MirrorBlockJob *s, bool=
 active)
+static inline void coroutine_fn
+mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
 {
     MirrorOp *op;
=20
@@ -295,7 +296,8 @@ static inline void mirror_wait_for_any_operation(Mirr=
orBlockJob *s, bool active)
     abort();
 }
=20
-static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s=
)
+static inline void coroutine_fn
+mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
 {
     /* Only non-active operations use up in-flight slots */
     mirror_wait_for_any_operation(s, false);
@@ -598,7 +600,7 @@ static void mirror_free_init(MirrorBlockJob *s)
  * mirror_resume() because mirror_run() will begin iterating again
  * when the job is resumed.
  */
-static void mirror_wait_for_all_io(MirrorBlockJob *s)
+static void coroutine_fn mirror_wait_for_all_io(MirrorBlockJob *s)
 {
     while (s->in_flight > 0) {
         mirror_wait_for_free_in_flight_slot(s);
@@ -731,7 +733,7 @@ static void mirror_abort(Job *job)
     assert(ret =3D=3D 0);
 }
=20
-static void mirror_throttle(MirrorBlockJob *s)
+static void coroutine_fn mirror_throttle(MirrorBlockJob *s)
 {
     int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
=20
@@ -1106,7 +1108,7 @@ static void mirror_complete(Job *job, Error **errp)
     job_enter(job);
 }
=20
-static void mirror_pause(Job *job)
+static void coroutine_fn mirror_pause(Job *job)
 {
     MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common.job);
=20
@@ -1177,9 +1179,10 @@ static const BlockJobDriver commit_active_job_driv=
er =3D {
     .drain                  =3D mirror_drain,
 };
=20
-static void do_sync_target_write(MirrorBlockJob *job, MirrorMethod metho=
d,
-                                 uint64_t offset, uint64_t bytes,
-                                 QEMUIOVector *qiov, int flags)
+static void coroutine_fn
+do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
+                     uint64_t offset, uint64_t bytes,
+                     QEMUIOVector *qiov, int flags)
 {
     BdrvDirtyBitmapIter *iter;
     QEMUIOVector target_qiov;
--=20
2.19.2
