Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldO-0006GK-Sp
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldL-0002NX-DT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:16 +0100
Message-Id: <20190218161822.3573-7-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/12] nbd: Use low-level QIOChannel API in
 nbd_read_eof()
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

Instead of using the convenience wrapper qio_channel_read_all_eof(), use
the lower level QIOChannel API. This means duplicating some code, but
we'll need this because this coroutine yield is special: We want it to
be interruptible so that nbd_client_attach_aio_context() can correctly
reenter the coroutine.

This moves the bdrv_dec/inc_in_flight() pair into nbd_read_eof(), so
that connection_co will always sit in this exact qio_channel_yield()
call when bdrv_drain() returns.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/nbd.h |  4 ++--
 block/nbd-client.c  |  8 +-------
 nbd/client.c        | 46 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index cad975e00c..c6ef1ef42e 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -300,8 +300,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
-int coroutine_fn nbd_receive_reply(QIOChannel *ioc, NBDReply *reply,
-                                   Error **errp);
+int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc=
,
+                                   NBDReply *reply, Error **errp);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
 int nbd_errno_to_system_errno(int err);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index e776785325..688993652d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -84,15 +84,9 @@ static coroutine_fn void nbd_connection_entry(void *op=
aque)
          *
          * Therefore we keep an additional in_flight reference all the t=
ime and
          * only drop it temporarily here.
-         *
-         * FIXME This is not safe because the QIOChannel could wake up t=
he
-         * coroutine for a second time; it is not prepared for coroutine
-         * resumption from external code.
          */
-        bdrv_dec_in_flight(s->bs);
         assert(s->reply.handle =3D=3D 0);
-        ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
-        bdrv_inc_in_flight(s->bs);
+        ret =3D nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err);
=20
         if (local_err) {
             trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_=
err));
diff --git a/nbd/client.c b/nbd/client.c
index 28d174c0f3..de7da48246 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1394,30 +1394,58 @@ static int nbd_receive_structured_reply_chunk(QIO=
Channel *ioc,
  *         negative errno on failure (errp is set)
  */
 static inline int coroutine_fn
-nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size, Error **errp)
+nbd_read_eof(BlockDriverState *bs, QIOChannel *ioc, void *buffer, size_t=
 size,
+             Error **errp)
 {
-    int ret;
+    bool partial =3D false;
=20
     assert(size);
-    ret =3D qio_channel_read_all_eof(ioc, buffer, size, errp);
-    if (ret < 0) {
-        ret =3D -EIO;
+    while (size > 0) {
+        struct iovec iov =3D { .iov_base =3D buffer, .iov_len =3D size }=
;
+        ssize_t len;
+
+        len =3D qio_channel_readv(ioc, &iov, 1, errp);
+        if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
+            bdrv_dec_in_flight(bs);
+            qio_channel_yield(ioc, G_IO_IN);
+            bdrv_inc_in_flight(bs);
+            continue;
+        } else if (len < 0) {
+            return -EIO;
+        } else if (len =3D=3D 0) {
+            if (partial) {
+                error_setg(errp,
+                           "Unexpected end-of-file before all bytes were=
 read");
+                return -EIO;
+            } else {
+                return 0;
+            }
+        }
+
+        partial =3D true;
+        size -=3D len;
+        buffer =3D (uint8_t*) buffer + len;
     }
-    return ret;
+    return 1;
 }
=20
 /* nbd_receive_reply
+ *
+ * Decreases bs->in_flight while waiting for a new reply. This yield is =
where
+ * we wait indefinitely and the coroutine must be able to be safely reen=
tered
+ * for nbd_client_attach_aio_context().
+ *
  * Returns 1 on success
  *         0 on eof, when no data was read (errp is not set)
  *         negative errno on failure (errp is set)
  */
-int coroutine_fn nbd_receive_reply(QIOChannel *ioc, NBDReply *reply,
-                                   Error **errp)
+int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc=
,
+                                   NBDReply *reply, Error **errp)
 {
     int ret;
     const char *type;
=20
-    ret =3D nbd_read_eof(ioc, &reply->magic, sizeof(reply->magic), errp)=
;
+    ret =3D nbd_read_eof(bs, ioc, &reply->magic, sizeof(reply->magic), e=
rrp);
     if (ret <=3D 0) {
         return ret;
     }
--=20
2.20.1
