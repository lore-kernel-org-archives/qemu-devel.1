Received: from eggs.gnu.org ([2001:4830:134:3::10]:34209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fQyUs-0008Aw-As
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fQyUo-00084e-PN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:14:50 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Jun 2018 20:14:39 +0300
Message-Id: <20180607171441.64079-10-vsementsov@virtuozzo.com>
In-Reply-To: <20180607171441.64079-1-vsementsov@virtuozzo.com>
References: <20180607171441.64079-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 09/11] block/nbd: add cmdline and qapi
 parameters for nbd reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add two parameters:

reconnect-attempts, which defines maximum number of reconnects, after
  which:
  - open will fail
  - block operations will fail

Note: on open, we actually have reconnect-attempts+1 connection
attempts, the first one is not REconnect.

reconnect-timeout, timeout in nanoseconds between reconnects.

Realization of these options is in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 12 +++++++++++-
 block/nbd-client.h   |  2 ++
 block/nbd-client.c   | 13 +++++++++++++
 block/nbd.c          | 22 +++++++++++++++++++++-
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4b1de474a9..4abba9d38e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3356,12 +3356,22 @@
 #
 # @tls-creds:   TLS credentials ID
 #
+# @reconnect-attempts: number of connection attempts on disconnect.
+#                      Must be >= 0. Default is 0. On nbd disk open, there would
+#                      be maximum of @reconnect-attempts + 1 total tries to
+#                      connect
+#
+# @reconnect-timeout: timeout between reconnect attempts in nanoseconds. Default
+#                     is 1000000000 (one second)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
   'data': { 'server': 'SocketAddress',
             '*export': 'str',
-            '*tls-creds': 'str' } }
+            '*tls-creds': 'str',
+            '*reconnect-attempts': 'uint64',
+            '*reconnect-timeout': 'uint64' } }
 
 ##
 # @BlockdevOptionsRaw:
diff --git a/block/nbd-client.h b/block/nbd-client.h
index f6c8052573..2561e1ea42 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -56,6 +56,8 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *export_name,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
+                    uint64_t reconnect_attempts,
+                    uint64_t reconnect_timeout,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index b74b964041..17ed7575c7 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -86,6 +86,8 @@ typedef struct NBDConnection {
     const char *export;
     QCryptoTLSCreds *tlscreds;
     const char *hostname;
+    uint64_t reconnect_attempts;
+    uint64_t reconnect_timeout;
 } NBDConnection;
 
 static coroutine_fn void nbd_connection_entry(void *opaque)
@@ -96,6 +98,13 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
     int ret = 0;
     Error *local_err = NULL;
 
+    if (con->reconnect_attempts != 0) {
+        error_setg(&s->connect_err, "Reconnect is not supported yet");
+        s->connect_status = -EINVAL;
+        nbd_channel_error(s, s->connect_status);
+        return;
+    }
+
     s->connect_status = nbd_client_connect(con->bs, con->saddr,
                                            con->export, con->tlscreds,
                                            con->hostname, &s->connect_err);
@@ -1104,6 +1113,8 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *export,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
+                    uint64_t reconnect_attempts,
+                    uint64_t reconnect_timeout,
                     Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
@@ -1114,6 +1125,8 @@ int nbd_client_init(BlockDriverState *bs,
     con->export = export;
     con->tlscreds = tlscreds;
     con->hostname = hostname;
+    con->reconnect_attempts = reconnect_attempts;
+    con->reconnect_timeout = reconnect_timeout;
 
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
diff --git a/block/nbd.c b/block/nbd.c
index a851b8cd68..8c81d4a151 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -364,6 +364,20 @@ static QemuOptsList nbd_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "ID of the TLS credentials to use",
         },
+        {
+            .name = "reconnect-attempts",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Number of connection attempts on disconnect. "
+                    "Must be >= 0. Default is 0. On nbd disk open, there would "
+                    "be maximum of @reconnect-attempts + 1 total tries to "
+                    "connect",
+        },
+        {
+            .name = "reconnect-timeout",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Timeout between reconnect attempts in nanoseconds. "
+                    "Default is 1000000000 (one second)",
+        },
         { /* end of list */ }
     },
 };
@@ -376,6 +390,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     QCryptoTLSCreds *tlscreds = NULL;
     const char *hostname = NULL;
+    uint64_t reconnect_attempts;
+    uint64_t reconnect_timeout;
     int ret = -EINVAL;
 
     opts = qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
@@ -413,8 +429,12 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         hostname = s->saddr->u.inet.host;
     }
 
+    reconnect_attempts = qemu_opt_get_number(opts, "reconnect-attempts", 0);
+    reconnect_timeout = qemu_opt_get_number(opts, "reconnect-timeout",
+                                            1000000000L);
     /* NBD handshake */
-    ret = nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname, errp);
+    ret = nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname,
+                          reconnect_attempts, reconnect_timeout, errp);
 
  error:
     if (tlscreds) {
-- 
2.11.1
