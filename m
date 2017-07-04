Received: from eggs.gnu.org ([2001:4830:134:3::10]:48755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwg-0008Av-J3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwd-0000Rh-DM
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:22 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:24 +0200
Message-Id: <20170704220346.29244-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/35] nbd: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/nbd-client.h | 10 +++++-----
 block/nbd-client.c | 24 ++++++++++++++++--------
 block/nbd.c        |  3 ++-
 nbd/server.c       |  3 ++-
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 49636bc621..473d1f88fd 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -42,13 +42,13 @@ int nbd_client_init(BlockDriverState *bs,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);
=20
-int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int byt=
es);
-int nbd_client_co_flush(BlockDriverState *bs);
-int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
+int coroutine_fn nbd_client_co_pdiscard(BlockDriverState *bs, int64_t of=
fset, int bytes);
+int coroutine_fn nbd_client_co_flush(BlockDriverState *bs);
+int coroutine_fn nbd_client_co_pwritev(BlockDriverState *bs, uint64_t of=
fset,
                           uint64_t bytes, QEMUIOVector *qiov, int flags)=
;
-int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
+int coroutine_fn nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64=
_t offset,
                                 int bytes, BdrvRequestFlags flags);
-int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
+int coroutine_fn nbd_client_co_preadv(BlockDriverState *bs, uint64_t off=
set,
                          uint64_t bytes, QEMUIOVector *qiov, int flags);
=20
 void nbd_client_detach_aio_context(BlockDriverState *bs);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 02e928142e..63c0210c37 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -111,7 +111,8 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
     s->read_reply_co =3D NULL;
 }
=20
-static int nbd_co_send_request(BlockDriverState *bs,
+static int coroutine_fn
+nbd_co_send_request(BlockDriverState *bs,
                                NBDRequest *request,
                                QEMUIOVector *qiov)
 {
@@ -158,7 +159,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
     return rc;
 }
=20
-static void nbd_co_receive_reply(NBDClientSession *s,
+static void coroutine_fn
+nbd_co_receive_reply(NBDClientSession *s,
                                  NBDRequest *request,
                                  NBDReply *reply,
                                  QEMUIOVector *qiov)
@@ -185,7 +187,8 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     }
 }
=20
-static void nbd_coroutine_end(BlockDriverState *bs,
+static void coroutine_fn
+nbd_coroutine_end(BlockDriverState *bs,
                               NBDRequest *request)
 {
     NBDClientSession *s =3D nbd_get_client_session(bs);
@@ -204,7 +207,8 @@ static void nbd_coroutine_end(BlockDriverState *bs,
     qemu_co_mutex_unlock(&s->send_mutex);
 }
=20
-int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
+int coroutine_fn
+nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
@@ -229,7 +233,8 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64=
_t offset,
     return -reply.error;
 }
=20
-int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
+int coroutine_fn
+nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
@@ -258,7 +263,8 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint6=
4_t offset,
     return -reply.error;
 }
=20
-int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
+int coroutine_fn
+nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                                 int bytes, BdrvRequestFlags flags)
 {
     ssize_t ret;
@@ -292,7 +298,8 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs,=
 int64_t offset,
     return -reply.error;
 }
=20
-int nbd_client_co_flush(BlockDriverState *bs)
+int coroutine_fn
+nbd_client_co_flush(BlockDriverState *bs)
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
     NBDRequest request =3D { .type =3D NBD_CMD_FLUSH };
@@ -316,7 +323,8 @@ int nbd_client_co_flush(BlockDriverState *bs)
     return -reply.error;
 }
=20
-int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int byt=
es)
+int coroutine_fn
+nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
     NBDRequest request =3D {
diff --git a/block/nbd.c b/block/nbd.c
index d529305330..8689b27d7d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -465,7 +465,8 @@ static int nbd_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
     return ret;
 }
=20
-static int nbd_co_flush(BlockDriverState *bs)
+static int coroutine_fn
+nbd_co_flush(BlockDriverState *bs)
 {
     return nbd_client_co_flush(bs);
 }
diff --git a/nbd/server.c b/nbd/server.c
index 8a70c054a6..4112b4b184 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -960,7 +960,8 @@ void nbd_export_close_all(void)
     }
 }
=20
-static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int l=
en)
+static int coroutine_fn
+nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
 {
     NBDClient *client =3D req->client;
     int ret;
--=20
2.13.1.395.gf7b71de06
