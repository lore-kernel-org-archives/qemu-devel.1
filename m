Received: from eggs.gnu.org ([2001:4830:134:3::10]:49146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxj-0000gd-HI
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxi-000173-N0
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:27 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:36 +0200
Message-Id: <20170704220346.29244-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 25/35] mirror: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/mirror.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 68744a17e8..2f0a9946d9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -224,7 +224,8 @@ static int mirror_cow_align(MirrorBlockJob *s,
     return ret;
 }
=20
-static inline void mirror_wait_for_io(MirrorBlockJob *s)
+static inline void coroutine_fn
+mirror_wait_for_io(MirrorBlockJob *s)
 {
     assert(!s->waiting_for_io);
     s->waiting_for_io =3D true;
@@ -239,7 +240,8 @@ static inline void mirror_wait_for_io(MirrorBlockJob =
*s)
  *          (new_end - sector_num) if tail is rounded up or down due to
  *          alignment or buffer limit.
  */
-static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
+static int coroutine_fn
+mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
                           int nb_sectors)
 {
     BlockBackend *source =3D s->common.blk;
@@ -490,7 +492,8 @@ static void mirror_free_init(MirrorBlockJob *s)
  * mirror_resume() because mirror_run() will begin iterating again
  * when the job is resumed.
  */
-static void mirror_wait_for_all_io(MirrorBlockJob *s)
+static void coroutine_fn
+mirror_wait_for_all_io(MirrorBlockJob *s)
 {
     while (s->in_flight > 0) {
         mirror_wait_for_io(s);
@@ -605,7 +608,8 @@ static void mirror_exit(BlockJob *job, void *opaque)
     bdrv_unref(src);
 }
=20
-static void mirror_throttle(MirrorBlockJob *s)
+static void coroutine_fn
+mirror_throttle(MirrorBlockJob *s)
 {
     int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
=20
@@ -984,7 +988,8 @@ static void mirror_complete(BlockJob *job, Error **er=
rp)
     block_job_enter(&s->common);
 }
=20
-static void mirror_pause(BlockJob *job)
+static void coroutine_fn
+mirror_pause(BlockJob *job)
 {
     MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
=20
--=20
2.13.1.395.gf7b71de06
