Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfqq-0002oM-Ui
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfqn-0002XW-TJ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:24 -0400
Received: from relay.sw.ru ([195.214.232.25]:52430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fRfqn-0002WW-Gb
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:21 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat,  9 Jun 2018 18:32:15 +0300
Message-Id: <20180609153217.19683-10-vsementsov@virtuozzo.com>
In-Reply-To: <20180609153217.19683-1-vsementsov@virtuozzo.com>
References: <20180609153217.19683-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 09/11] block/nbd: add cmdline and qapi
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
index 44ac4ebc31..f22ed7f404 100644
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
@@ -1106,6 +1115,8 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *export,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
+                    uint64_t reconnect_attempts,
+                    uint64_t reconnect_timeout,
                     Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
@@ -1116,6 +1127,8 @@ int nbd_client_init(BlockDriverState *bs,
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
