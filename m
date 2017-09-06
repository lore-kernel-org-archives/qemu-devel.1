Received: from eggs.gnu.org ([2001:4830:134:3::10]:35315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpXlO-0002qY-Rs
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpXlM-0000CJ-Jx
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpXlM-0000B0-31
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:40:52 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  6 Sep 2017 11:40:43 +0100
Message-Id: <20170906104043.30745-3-berrange@redhat.com>
In-Reply-To: <20170906104043.30745-1-berrange@redhat.com>
References: <20170906104043.30745-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] io: include full error message in
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
Cc: Brian Rak <brak@vultr.com>, "Daniel P. Berrange" <berrange@redhat.com>

When the websocket handshake fails it is useful to log the real
error message via the trace points for debugging purposes.

Fixes bug: #1715186

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 7 ++++---
 io/trace-events      | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index b9cc5a1371..463c04b0aa 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -503,7 +503,7 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
                             &err);
 
     if (ret < 0) {
-        trace_qio_channel_websock_handshake_fail(ioc);
+        trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
         return FALSE;
@@ -512,7 +512,8 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
     buffer_advance(&wioc->encoutput, ret);
     if (wioc->encoutput.offset == 0) {
         if (wioc->io_err) {
-            trace_qio_channel_websock_handshake_fail(ioc);
+            trace_qio_channel_websock_handshake_fail(
+                ioc, error_get_pretty(wioc->io_err));
             qio_task_set_error(task, wioc->io_err);
             wioc->io_err = NULL;
             qio_task_complete(task);
@@ -543,7 +544,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
          * client connection, as most of the time we have an
          * HTTP 4xx err response to send instead
          */
-        trace_qio_channel_websock_handshake_fail(ioc);
+        trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
         return FALSE;
diff --git a/io/trace-events b/io/trace-events
index 3d233698d0..6459f71f5b 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -46,7 +46,7 @@ qio_channel_websock_new_server(void *ioc, void *master) "Websock new client ioc=
 qio_channel_websock_handshake_start(void *ioc) "Websock handshake start ioc=%p"
 qio_channel_websock_handshake_pending(void *ioc, int status) "Websock handshake pending ioc=%p status=%d"
 qio_channel_websock_handshake_reply(void *ioc) "Websock handshake reply ioc=%p"
-qio_channel_websock_handshake_fail(void *ioc) "Websock handshake fail ioc=%p"
+qio_channel_websock_handshake_fail(void *ioc, const char *msg) "Websock handshake fail ioc=%p err=%s"
 qio_channel_websock_handshake_complete(void *ioc) "Websock handshake complete ioc=%p"
 
 # io/channel-command.c
-- 
2.13.5
