Received: from eggs.gnu.org ([2001:4830:134:3::10]:56336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYL-0005bQ-Mt
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYG-0006dA-Rn
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqGYG-0006cC-J4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:20 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  8 Sep 2017 11:30:10 +0100
Message-Id: <20170908103011.25821-3-berrange@redhat.com>
In-Reply-To: <20170908103011.25821-1-berrange@redhat.com>
References: <20170908103011.25821-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] io: include full error message in
 websocket handshake trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Brian Rak <brak@vultr.com>, "Daniel P. Berrange" <berrange@redhat.com>

When the websocket handshake fails it is useful to log the real
error message via the trace points for debugging purposes.

Fixes bug: #1715186

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 7 ++++---
 io/trace-events      | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 24920c78df..aed7a6c9b3 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -503,7 +503,7 @@ static gboolean qio_channel_websock_handshake_send(QI=
OChannel *ioc,
                             &err);
=20
     if (ret < 0) {
-        trace_qio_channel_websock_handshake_fail(ioc);
+        trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(e=
rr));
         qio_task_set_error(task, err);
         qio_task_complete(task);
         return FALSE;
@@ -512,7 +512,8 @@ static gboolean qio_channel_websock_handshake_send(QI=
OChannel *ioc,
     buffer_advance(&wioc->encoutput, ret);
     if (wioc->encoutput.offset =3D=3D 0) {
         if (wioc->io_err) {
-            trace_qio_channel_websock_handshake_fail(ioc);
+            trace_qio_channel_websock_handshake_fail(
+                ioc, error_get_pretty(wioc->io_err));
             qio_task_set_error(task, wioc->io_err);
             wioc->io_err =3D NULL;
             qio_task_complete(task);
@@ -543,7 +544,7 @@ static gboolean qio_channel_websock_handshake_io(QIOC=
hannel *ioc,
          * client connection, as most of the time we have an
          * HTTP 4xx err response to send instead
          */
-        trace_qio_channel_websock_handshake_fail(ioc);
+        trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(e=
rr));
         qio_task_set_error(task, err);
         qio_task_complete(task);
         return FALSE;
diff --git a/io/trace-events b/io/trace-events
index 3d233698d0..6459f71f5b 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -46,7 +46,7 @@ qio_channel_websock_new_server(void *ioc, void *master)=
 "Websock new client ioc=3D
 qio_channel_websock_handshake_start(void *ioc) "Websock handshake start =
ioc=3D%p"
 qio_channel_websock_handshake_pending(void *ioc, int status) "Websock ha=
ndshake pending ioc=3D%p status=3D%d"
 qio_channel_websock_handshake_reply(void *ioc) "Websock handshake reply =
ioc=3D%p"
-qio_channel_websock_handshake_fail(void *ioc) "Websock handshake fail io=
c=3D%p"
+qio_channel_websock_handshake_fail(void *ioc, const char *msg) "Websock =
handshake fail ioc=3D%p err=3D%s"
 qio_channel_websock_handshake_complete(void *ioc) "Websock handshake com=
plete ioc=3D%p"
=20
 # io/channel-command.c
--=20
2.13.5
