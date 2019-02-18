Received: from eggs.gnu.org ([209.51.188.92]:34897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldR-0006MM-Fv
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldP-0002QU-D8
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:17 +0100
Message-Id: <20190218161822.3573-8-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/12] nbd: Increase bs->in_flight during
 AioContext switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

bdrv_drain() must not leave connection_co scheduled, so bs->in_flight
needs to be increased while the coroutine is waiting to be scheduled
in the new AioContext after nbd_client_attach_aio_context().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nbd-client.h  |  1 +
 include/block/nbd.h |  5 +++--
 block/nbd-client.c  | 16 ++++++++++++----
 nbd/client.c        | 23 +++++++++++++++++------
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 09e03013d2..ee4e8544fe 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -37,6 +37,7 @@ typedef struct NBDClientSession {
     NBDReply reply;
     BlockDriverState *bs;
     bool quit;
+    bool aio_ctx_switch;
 } NBDClientSession;
=20
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/include/block/nbd.h b/include/block/nbd.h
index c6ef1ef42e..73e6e95095 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -300,8 +300,9 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
-int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc=
,
-                                   NBDReply *reply, Error **errp);
+int coroutine_fn nbd_receive_reply(BlockDriverState *bs, bool *aio_ctx_s=
witch,
+                                   QIOChannel *ioc, NBDReply *reply,
+                                   Error **errp);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
 int nbd_errno_to_system_errno(int err);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 688993652d..433de9e275 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -75,6 +75,11 @@ static coroutine_fn void nbd_connection_entry(void *op=
aque)
     int ret =3D 0;
     Error *local_err =3D NULL;
=20
+    /* Keep the initial bs->in_flight increase; decrease only temporaril=
y in
+     * nbd_read_eof() and at the end of this function. */
+    assert(s->aio_ctx_switch);
+    s->aio_ctx_switch =3D false;
+
     while (!s->quit) {
         /*
          * The NBD client can only really be considered idle when it has
@@ -86,7 +91,8 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
          * only drop it temporarily here.
          */
         assert(s->reply.handle =3D=3D 0);
-        ret =3D nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err);
+        ret =3D nbd_receive_reply(s->bs, &s->aio_ctx_switch, s->ioc, &s-=
>reply,
+                                &local_err);
=20
         if (local_err) {
             trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_=
err));
@@ -983,8 +989,11 @@ void nbd_client_attach_aio_context(BlockDriverState =
*bs,
     NBDClientSession *client =3D nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context=
);
=20
-    /* FIXME Really need a bdrv_inc_in_flight() here, but the correspond=
ing
-     * bdrv_dec_in_flight() would have to be in QIOChannel code :-/ */
+    /* The corresponding bdrv_dec_in_flight() is in nbd_read_eof() */
+    assert(!client->aio_ctx_switch);
+    client->aio_ctx_switch =3D true;
+    bdrv_inc_in_flight(bs);
+
     aio_co_schedule(new_context, client->connection_co);
 }
=20
@@ -1091,7 +1100,6 @@ static int nbd_client_connect(BlockDriverState *bs,
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     client->connection_co =3D qemu_coroutine_create(nbd_connection_entry=
, client);
-    bdrv_inc_in_flight(bs);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
=20
     logout("Established connection with NBD server\n");
diff --git a/nbd/client.c b/nbd/client.c
index de7da48246..12bd24d8fe 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1394,8 +1394,8 @@ static int nbd_receive_structured_reply_chunk(QIOCh=
annel *ioc,
  *         negative errno on failure (errp is set)
  */
 static inline int coroutine_fn
-nbd_read_eof(BlockDriverState *bs, QIOChannel *ioc, void *buffer, size_t=
 size,
-             Error **errp)
+nbd_read_eof(BlockDriverState *bs, bool *aio_ctx_switch, QIOChannel *ioc=
,
+             void *buffer, size_t size, Error **errp)
 {
     bool partial =3D false;
=20
@@ -1406,9 +1406,18 @@ nbd_read_eof(BlockDriverState *bs, QIOChannel *ioc=
, void *buffer, size_t size,
=20
         len =3D qio_channel_readv(ioc, &iov, 1, errp);
         if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
+            /* aio_ctx_switch is only supposed to be set if we're sittin=
g in
+             * the qio_channel_yield() below. */
+            assert(!*aio_ctx_switch);
             bdrv_dec_in_flight(bs);
             qio_channel_yield(ioc, G_IO_IN);
-            bdrv_inc_in_flight(bs);
+            if (*aio_ctx_switch) {
+                /* nbd_client_attach_aio_context() already increased in_=
flight
+                 * when scheduling this coroutine for reentry */
+                *aio_ctx_switch =3D false;
+            } else {
+                bdrv_inc_in_flight(bs);
+            }
             continue;
         } else if (len < 0) {
             return -EIO;
@@ -1439,13 +1448,15 @@ nbd_read_eof(BlockDriverState *bs, QIOChannel *io=
c, void *buffer, size_t size,
  *         0 on eof, when no data was read (errp is not set)
  *         negative errno on failure (errp is set)
  */
-int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc=
,
-                                   NBDReply *reply, Error **errp)
+int coroutine_fn nbd_receive_reply(BlockDriverState *bs, bool *aio_ctx_s=
witch,
+                                   QIOChannel *ioc, NBDReply *reply,
+                                   Error **errp)
 {
     int ret;
     const char *type;
=20
-    ret =3D nbd_read_eof(bs, ioc, &reply->magic, sizeof(reply->magic), e=
rrp);
+    ret =3D nbd_read_eof(bs, aio_ctx_switch, ioc, &reply->magic,
+                       sizeof(reply->magic), errp);
     if (ret <=3D 0) {
         return ret;
     }
--=20
2.20.1
