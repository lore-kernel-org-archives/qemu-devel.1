Received: from eggs.gnu.org ([2001:4830:134:3::10]:48268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvb-0007EB-Ln
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVva-0008D4-IB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:13 +0200
Message-Id: <20170704220346.29244-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/35] WIP: coroutine: manually tag the
 fast-paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Alberto Garcia <berto@igalia.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

Some functions are both regular and coroutine. They may call coroutine
functions in some cases, if it is known to be running in a coroutine.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block.c                 |  2 ++
 block/block-backend.c   |  2 ++
 block/io.c              | 16 +++++++++++++++-
 block/sheepdog.c        |  2 ++
 block/throttle-groups.c | 10 ++++++++--
 migration/rdma.c        |  2 ++
 6 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 694396281b..b08c006da4 100644
--- a/block.c
+++ b/block.c
@@ -443,7 +443,9 @@ int bdrv_create(BlockDriver *drv, const char* filenam=
e,
=20
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
+        co_role_acquire(_coroutine_fn);
         bdrv_create_co_entry(&cco);
+        co_role_release(_coroutine_fn);
     } else {
         co =3D qemu_coroutine_create(bdrv_create_co_entry, &cco);
         qemu_coroutine_enter(co);
diff --git a/block/block-backend.c b/block/block-backend.c
index 0df3457a09..56fc0a4d1e 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1072,7 +1072,9 @@ static int blk_prw(BlockBackend *blk, int64_t offse=
t, uint8_t *buf,
=20
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
+        co_role_acquire(_coroutine_fn);
         co_entry(&rwco);
+        co_role_release(_coroutine_fn);
     } else {
         Coroutine *co =3D qemu_coroutine_create(co_entry, &rwco);
         bdrv_coroutine_enter(blk_bs(blk), co);
diff --git a/block/io.c b/block/io.c
index 2de7c77983..14b88c8609 100644
--- a/block/io.c
+++ b/block/io.c
@@ -229,7 +229,9 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs)
 void bdrv_drained_begin(BlockDriverState *bs)
 {
     if (qemu_in_coroutine()) {
+        co_role_acquire(_coroutine_fn);
         bdrv_co_yield_to_drain(bs);
+        co_role_release(_coroutine_fn);
         return;
     }
=20
@@ -616,7 +618,9 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t off=
set,
=20
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
+        co_role_acquire(_coroutine_fn);
         bdrv_rw_co_entry(&rwco);
+        co_role_release(_coroutine_fn);
     } else {
         co =3D qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
         bdrv_coroutine_enter(child->bs, co);
@@ -1901,7 +1905,9 @@ int64_t bdrv_get_block_status_above(BlockDriverStat=
e *bs,
=20
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
+        co_role_acquire(_coroutine_fn);
         bdrv_get_block_status_above_co_entry(&data);
+        co_role_release(_coroutine_fn);
     } else {
         co =3D qemu_coroutine_create(bdrv_get_block_status_above_co_entr=
y,
                                    &data);
@@ -2027,7 +2033,11 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector=
 *qiov, int64_t pos,
                 bool is_read)
 {
     if (qemu_in_coroutine()) {
-        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
+        int ret;
+        co_role_acquire(_coroutine_fn);
+        ret =3D bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
+        co_role_release(_coroutine_fn);
+        return ret;
     } else {
         BdrvVmstateCo data =3D {
             .bs         =3D bs,
@@ -2259,7 +2269,9 @@ int bdrv_flush(BlockDriverState *bs)
=20
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
+        co_role_acquire(_coroutine_fn);
         bdrv_flush_co_entry(&flush_co);
+        co_role_release(_coroutine_fn);
     } else {
         co =3D qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
         bdrv_coroutine_enter(bs, co);
@@ -2406,7 +2418,9 @@ int bdrv_pdiscard(BlockDriverState *bs, int64_t off=
set, int bytes)
=20
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
+        co_role_acquire(_coroutine_fn);
         bdrv_pdiscard_co_entry(&rwco);
+        co_role_release(_coroutine_fn);
     } else {
         co =3D qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
         bdrv_coroutine_enter(bs, co);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 08d7b11e9d..83bc43dde4 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -726,7 +726,9 @@ static int do_req(int sockfd, BlockDriverState *bs, S=
heepdogReq *hdr,
     };
=20
     if (qemu_in_coroutine()) {
+        co_role_acquire(_coroutine_fn);
         do_co_req(&srco);
+        co_role_release(_coroutine_fn);
     } else {
         co =3D qemu_coroutine_create(do_co_req, &srco);
         if (bs) {
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index da2b490c38..8778f78965 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -304,9 +304,15 @@ static void schedule_next_request(BlockBackend *blk,=
 bool is_write)
=20
     /* If it doesn't have to wait, queue it for immediate execution */
     if (!must_wait) {
+        bool handled =3D false;
+
+        if (qemu_in_coroutine()) {
+            co_role_acquire(_coroutine_fn);
+            handled =3D throttle_group_co_restart_queue(blk, is_write);
+            co_role_release(_coroutine_fn);
+        }
         /* Give preference to requests from the current blk */
-        if (qemu_in_coroutine() &&
-            throttle_group_co_restart_queue(blk, is_write)) {
+        if (handled) {
             token =3D blk;
         } else {
             ThrottleTimers *tt =3D &blk_get_public(token)->throttle_time=
rs;
diff --git a/migration/rdma.c b/migration/rdma.c
index c6bc607a03..8c00d4d74c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1518,7 +1518,9 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rd=
ma, int wrid_requested,
          * so don't yield unless we know we're running inside of a corou=
tine.
          */
         if (rdma->migration_started_on_destination) {
+            co_role_acquire(_coroutine_fn);
             yield_until_fd_readable(rdma->comp_channel->fd);
+            co_role_release(_coroutine_fn);
         }
=20
         if (ibv_get_cq_event(rdma->comp_channel, &cq, &cq_ctx)) {
--=20
2.13.1.395.gf7b71de06
