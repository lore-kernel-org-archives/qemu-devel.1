Received: from eggs.gnu.org ([209.51.188.92]:37223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4e-00006l-V4
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4c-0000rJ-SQ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:56 +0100
Message-Id: <20190225152053.15976-15-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/71] nbd: Move nbd_read_eof() to nbd/client.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The only caller of nbd_read_eof() is nbd_receive_reply(), so it doesn't
have to live in the header file, but can move next to its caller.

Also add the missing coroutine_fn to the function and its caller.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  3 ++-
 nbd/nbd-internal.h  | 19 -------------------
 nbd/client.c        | 22 +++++++++++++++++++++-
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 96cfb1d7d5..cad975e00c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -300,7 +300,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
-int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp);
+int coroutine_fn nbd_receive_reply(QIOChannel *ioc, NBDReply *reply,
+                                   Error **errp);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
 int nbd_errno_to_system_errno(int err);
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 82aa221227..049f83df77 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -64,25 +64,6 @@
 #define NBD_SET_TIMEOUT             _IO(0xab, 9)
 #define NBD_SET_FLAGS               _IO(0xab, 10)
=20
-/* nbd_read_eof
- * Tries to read @size bytes from @ioc.
- * Returns 1 on success
- *         0 on eof, when no data was read (errp is not set)
- *         negative errno on failure (errp is set)
- */
-static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t siz=
e,
-                               Error **errp)
-{
-    int ret;
-
-    assert(size);
-    ret =3D qio_channel_read_all_eof(ioc, buffer, size, errp);
-    if (ret < 0) {
-        ret =3D -EIO;
-    }
-    return ret;
-}
-
 /* nbd_write
  * Writes @size bytes to @ioc. Returns 0 on success.
  */
diff --git a/nbd/client.c b/nbd/client.c
index 10a52ad7d0..28d174c0f3 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1387,12 +1387,32 @@ static int nbd_receive_structured_reply_chunk(QIO=
Channel *ioc,
     return 0;
 }
=20
+/* nbd_read_eof
+ * Tries to read @size bytes from @ioc.
+ * Returns 1 on success
+ *         0 on eof, when no data was read (errp is not set)
+ *         negative errno on failure (errp is set)
+ */
+static inline int coroutine_fn
+nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size, Error **errp)
+{
+    int ret;
+
+    assert(size);
+    ret =3D qio_channel_read_all_eof(ioc, buffer, size, errp);
+    if (ret < 0) {
+        ret =3D -EIO;
+    }
+    return ret;
+}
+
 /* nbd_receive_reply
  * Returns 1 on success
  *         0 on eof, when no data was read (errp is not set)
  *         negative errno on failure (errp is set)
  */
-int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
+int coroutine_fn nbd_receive_reply(QIOChannel *ioc, NBDReply *reply,
+                                   Error **errp)
 {
     int ret;
     const char *type;
--=20
2.20.1
