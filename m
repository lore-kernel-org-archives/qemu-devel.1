Received: from eggs.gnu.org ([2001:4830:134:3::10]:45443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxI-0006e0-42
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxB-0002wk-Vl
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:44 -0400
Received: from [59.151.112.132] (port=16366 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxB-0002ta-Iu
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:37 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Apr 2017 16:04:15 +0800
Message-ID: <6824abf3c4e5b865de1799c302f60e8055c8d3dc.1493191677.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/4] net/socket: Convert the non-blocking
 connection mechanism to QIOchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, pbonzini@redhat.com, jasowang@redhat.com

Currently, socket connection in net is realized by an old
mechanism which is non-blocking.

That old mechanism may cause net blocks on DNS lookups and
QEmu has already replaced it with QIOchannel in many features,
such as migration.

Convert it to QIOchannel for net as well.

CC: berrange@redhat.com, pbonzini@redhat.com, jasowang@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
The test steps like this:

    $ qemu-system-x86_64 -net nic -net socket,listen=:1234 ~/img/test.img
    $ qemu-system-x86_64 -net nic -net socket,connect=127.0.0.1:1234 ~/img/test.img

No exception.

 net/socket.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index b8c931e..52f9dce 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -33,6 +33,7 @@
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
+#include "io/channel-socket.h"
 
 typedef struct NetSocketState {
     NetClientState nc;
@@ -525,16 +526,22 @@ typedef struct {
     char *name;
 } socket_connect_data;
 
-static void socket_connect_data_free(socket_connect_data *c)
+static void socket_connect_data_free(void *opaque)
 {
+    socket_connect_data *c = opaque;
+    if (!c) {
+        return;
+    }
+
     qapi_free_SocketAddress(c->saddr);
     g_free(c->model);
     g_free(c->name);
     g_free(c);
 }
 
-static void net_socket_connected(int fd, Error *err, void *opaque)
+static void net_socket_connected(QIOTask *task, void *opaque)
 {
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     socket_connect_data *c = opaque;
     NetSocketState *s;
     char *addr_str = NULL;
@@ -543,13 +550,13 @@ static void net_socket_connected(int fd, Error *err, void *opaque)
     addr_str = socket_address_to_string(c->saddr, &local_error);
     if (addr_str == NULL) {
         error_report_err(local_error);
-        closesocket(fd);
+        closesocket(sioc->fd);
         goto end;
     }
 
-    s = net_socket_fd_init(c->peer, c->model, c->name, fd, true);
+    s = net_socket_fd_init(c->peer, c->model, c->name, sioc->fd, true);
     if (!s) {
-        closesocket(fd);
+        closesocket(sioc->fd);
         goto end;
     }
 
@@ -567,7 +574,7 @@ static int net_socket_connect_init(NetClientState *peer,
                                    const char *host_str)
 {
     socket_connect_data *c = g_new0(socket_connect_data, 1);
-    int fd = -1;
+    QIOChannelSocket *sioc;
     Error *local_error = NULL;
 
     c->peer = peer;
@@ -578,11 +585,12 @@ static int net_socket_connect_init(NetClientState *peer,
         goto err;
     }
 
-    fd = socket_connect(c->saddr, net_socket_connected, c, &local_error);
-    if (fd < 0) {
-        goto err;
-    }
-
+    sioc = qio_channel_socket_new();
+    qio_channel_socket_connect_async(sioc,
+                                     c->saddr,
+                                     net_socket_connected,
+                                     c,
+                                     NULL);
     return 0;
 
 err:
-- 
2.9.3
