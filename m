Received: from eggs.gnu.org ([2001:4830:134:3::10]:49305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVy7-00011j-2u
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVy6-0001Lk-1m
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:51 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:40 +0200
Message-Id: <20170704220346.29244-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 29/35] block: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/blkdebug.c  | 15 ++++++++++-----
 block/blkverify.c |  3 ++-
 block/io.c        |  9 ++++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a1b24b9b0d..d55e2e69c8 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -483,7 +483,8 @@ out:
     return ret;
 }
=20
-static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t by=
tes)
+static int coroutine_fn
+rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
     BlkdebugRule *rule =3D NULL;
@@ -563,7 +564,8 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t of=
fset, uint64_t bytes,
     return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
 }
=20
-static int blkdebug_co_flush(BlockDriverState *bs)
+static int coroutine_fn
+blkdebug_co_flush(BlockDriverState *bs)
 {
     int err =3D rule_check(bs, 0, 0);
=20
@@ -656,7 +658,8 @@ static void blkdebug_close(BlockDriverState *bs)
     g_free(s->config_file);
 }
=20
-static void suspend_request(BlockDriverState *bs, BlkdebugRule *rule)
+static void coroutine_fn
+suspend_request(BlockDriverState *bs, BlkdebugRule *rule)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
     BlkdebugSuspendedReq r;
@@ -681,7 +684,8 @@ static void suspend_request(BlockDriverState *bs, Blk=
debugRule *rule)
     g_free(r.tag);
 }
=20
-static bool process_rule(BlockDriverState *bs, struct BlkdebugRule *rule=
,
+static bool coroutine_fn
+process_rule(BlockDriverState *bs, struct BlkdebugRule *rule,
     bool injected)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
@@ -712,7 +716,8 @@ static bool process_rule(BlockDriverState *bs, struct=
 BlkdebugRule *rule,
     return injected;
 }
=20
-static void blkdebug_debug_event(BlockDriverState *bs, BlkdebugEvent eve=
nt)
+static void coroutine_fn
+blkdebug_debug_event(BlockDriverState *bs, BlkdebugEvent event)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
     struct BlkdebugRule *rule, *next;
diff --git a/block/blkverify.c b/block/blkverify.c
index 06369f9eac..d0c946173a 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -255,7 +255,8 @@ blkverify_co_pwritev(BlockDriverState *bs, uint64_t o=
ffset, uint64_t bytes,
     return blkverify_co_prwv(bs, &r, offset, bytes, qiov, qiov, flags, t=
rue);
 }
=20
-static int blkverify_co_flush(BlockDriverState *bs)
+static int coroutine_fn
+blkverify_co_flush(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s =3D bs->opaque;
=20
diff --git a/block/io.c b/block/io.c
index 14b88c8609..a53a86df3e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -366,7 +366,8 @@ void bdrv_drain_all(void)
  *
  * This function should be called when a tracked request is completing.
  */
-static void tracked_request_end(BdrvTrackedRequest *req)
+static void coroutine_fn
+tracked_request_end(BdrvTrackedRequest *req)
 {
     if (req->serialising) {
         atomic_dec(&req->bs->serialising_in_flight);
@@ -381,7 +382,8 @@ static void tracked_request_end(BdrvTrackedRequest *r=
eq)
 /**
  * Add an active request to the tracked requests list
  */
-static void tracked_request_begin(BdrvTrackedRequest *req,
+static void coroutine_fn
+tracked_request_begin(BdrvTrackedRequest *req,
                                   BlockDriverState *bs,
                                   int64_t offset,
                                   unsigned int bytes,
@@ -2430,7 +2432,8 @@ int bdrv_pdiscard(BlockDriverState *bs, int64_t off=
set, int bytes)
     return rwco.ret;
 }
=20
-int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
+int coroutine_fn
+bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 {
     BlockDriver *drv =3D bs->drv;
     CoroutineIOCompletion co =3D {
--=20
2.13.1.395.gf7b71de06
