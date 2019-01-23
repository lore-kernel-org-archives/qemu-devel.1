Received: from eggs.gnu.org ([209.51.188.92]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKh-0003AP-Ae
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKg-000303-7A
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMKf-0002zd-UT
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:58 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:38 +0000
Message-Id: <20190123172740.32452-15-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/16] chardev: fix race with client
 connections in tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When the 'reconnect' option is given for a client connection, the
qmp_chardev_open_socket_client method will run an asynchronous
connection attempt. The QIOChannel socket executes this is a single use
background thread, so the connection will succeed immediately (assuming
the server is listening). The chardev, however, won't get the result
from this background thread until the main loop starts running and
processes idle callbacks.

Thus when tcp_chr_wait_connected is run s->ioc will be NULL, but the
state will be TCP_CHARDEV_STATE_CONNECTING, and there may already
be an established connection that will be associated with the chardev
by the pending idle callback. tcp_chr_wait_connected doesn't check the
state, only s->ioc, so attempts to establish another connection
synchronously.

If the server allows multiple connections this is unhelpful but not a
fatal problem as the duplicate connection will get ignored by the
tcp_chr_new_client method when it sees the state is already connected.

If the server only supports a single connection, however, the
tcp_chr_wait_connected method will hang forever because the server will
not accept its synchronous connection attempt until the first connection
is closed.

To deal with this tcp_chr_wait_connected needs to synchronize with the
completion of the background connection task. To do this it needs to
create the QIOTask directly and use the qio_task_wait_thread method.
This will cancel the pending idle callback and directly dispatch the
task completion callback, allowing the connection to be associated
with the chardev. If the background connection failed, it can still
attempt a new synchronous connection.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 87 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 86c1f502d6..7c3ee25945 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -80,6 +80,8 @@ typedef struct {
     GSource *reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
+
+    QIOTask *connect_task;
 } SocketChardev;
=20
 #define SOCKET_CHARDEV(obj)                                     \
@@ -965,7 +967,54 @@ static int tcp_chr_wait_connected(Chardev *chr, Erro=
r **errp)
         }
     }
=20
-    while (!s->ioc) {
+    /*
+     * We expect states to be as follows:
+     *
+     *  - server
+     *    - wait   -> CONNECTED
+     *    - nowait -> DISCONNECTED
+     *  - client
+     *    - reconnect =3D=3D 0 -> CONNECTED
+     *    - reconnect !=3D 0 -> CONNECTING
+     *
+     */
+    if (s->state =3D=3D TCP_CHARDEV_STATE_CONNECTING) {
+        if (!s->connect_task) {
+            error_setg(errp,
+                       "Unexpected 'connecting' state without connect ta=
sk "
+                       "while waiting for connection completion");
+            return -1;
+        }
+        /*
+         * tcp_chr_wait_connected should only ever be run from the
+         * main loop thread associated with chr->gcontext, otherwise
+         * qio_task_wait_thread has a dangerous race condition with
+         * free'ing of the s->connect_task object.
+         *
+         * Acquiring the main context doesn't 100% prove we're in
+         * the main loop thread, but it does at least guarantee
+         * that the main loop won't be executed by another thread
+         * avoiding the race condition with the task idle callback.
+         */
+        g_main_context_acquire(chr->gcontext);
+        qio_task_wait_thread(s->connect_task);
+        g_main_context_release(chr->gcontext);
+
+        /*
+         * The completion callback (qemu_chr_socket_connected) for
+         * s->connect_task should have set this to NULL by the time
+         * qio_task_wait_thread has returned.
+         */
+        assert(!s->connect_task);
+
+        /*
+         * NB we are *not* guaranteed to have "s->state =3D=3D ..CONNECT=
ED"
+         * at this point as this first connect may be failed, so
+         * allow the next loop to run regardless.
+         */
+    }
+
+    while (s->state !=3D TCP_CHARDEV_STATE_CONNECTED) {
         if (s->is_listen) {
             tcp_chr_accept_server_sync(chr);
         } else {
@@ -1014,6 +1063,8 @@ static void qemu_chr_socket_connected(QIOTask *task=
, void *opaque)
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     Error *err =3D NULL;
=20
+    s->connect_task =3D NULL;
+
     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
         check_report_connect_error(chr, err);
@@ -1028,6 +1079,20 @@ cleanup:
     object_unref(OBJECT(sioc));
 }
=20
+
+static void tcp_chr_connect_client_task(QIOTask *task,
+                                        gpointer opaque)
+{
+    QIOChannelSocket *ioc =3D QIO_CHANNEL_SOCKET(qio_task_get_source(tas=
k));
+    SocketAddress *addr =3D opaque;
+    Error *err =3D NULL;
+
+    qio_channel_socket_connect_sync(ioc, addr, &err);
+
+    qio_task_set_error(task, err);
+}
+
+
 static void tcp_chr_connect_client_async(Chardev *chr)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
@@ -1036,9 +1101,23 @@ static void tcp_chr_connect_client_async(Chardev *=
chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc =3D qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
-    qio_channel_socket_connect_async(sioc, s->addr,
-                                     qemu_chr_socket_connected,
-                                     chr, NULL, chr->gcontext);
+    /*
+     * Normally code would use the qio_channel_socket_connect_async
+     * method which uses a QIOTask + qio_task_set_error internally
+     * to avoid blocking. The tcp_chr_wait_connected method, however,
+     * needs a way to synchronize with completion of the background
+     * connect task which can't be done with the QIOChannelSocket
+     * async APIs. Thus we must use QIOTask directly to implement
+     * the non-blocking concept locally.
+     */
+    s->connect_task =3D qio_task_new(OBJECT(sioc),
+                                   qemu_chr_socket_connected,
+                                   chr, NULL);
+    qio_task_run_in_thread(s->connect_task,
+                           tcp_chr_connect_client_task,
+                           s->addr,
+                           NULL,
+                           chr->gcontext);
 }
=20
 static gboolean socket_reconnect_timeout(gpointer opaque)
--=20
2.20.1
