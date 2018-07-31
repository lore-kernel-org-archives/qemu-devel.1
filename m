Received: from eggs.gnu.org ([2001:4830:134:3::10]:36929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Ud-8k
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTo-0004FZ-EH
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:31 +0300
Message-Id: <20180731173033.75467-9-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 08/10] block/nbd: add cmdline and qapi
 parameter reconnect-delay
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

Reconnect will be implemented in the following commit, so for now,
in semantics below, disconnect itself is a "serious error".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 12 +++++++++++-
 block/nbd-client.h   |  1 +
 block/nbd-client.c   |  1 +
 block/nbd.c          | 16 +++++++++++++++-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b9084a394..cf03402ec5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3511,13 +3511,23 @@
 #                  traditional "base:allocation" block status (see
 #                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since 3.0)
 #
+# @reconnect-delay: Reconnect delay. On disconnect, nbd client tries to connect
+#                   again, until success or serious error. During first
+#                   @reconnect-delay seconds of reconnecting loop all requests
+#                   are paused and have a chance to rerun, if successful
+#                   connect occures during this time. After @reconnect-delay
+#                   seconds all delayed requests are failed and all following
+#                   requests will be failed to (until successfull reconnect).
+#                   Default 300 seconds (Since 3.1)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
   'data': { 'server': 'SocketAddress',
             '*export': 'str',
             '*tls-creds': 'str',
-            '*x-dirty-bitmap': 'str' } }
+            '*x-dirty-bitmap': 'str',
+            '*reconnect-delay': 'uint32' } }
 
 ##
 # @BlockdevOptionsRaw:
diff --git a/block/nbd-client.h b/block/nbd-client.h
index e7bda4d3c4..ef8a6a9239 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -53,6 +53,7 @@ int nbd_client_init(BlockDriverState *bs,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
                     const char *x_dirty_bitmap,
+                    uint32_t reconnect_delay,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index c184a9f0e9..41e6e6e702 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1079,6 +1079,7 @@ int nbd_client_init(BlockDriverState *bs,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
                     const char *x_dirty_bitmap,
+                    uint32_t reconnect_delay,
                     Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
diff --git a/block/nbd.c b/block/nbd.c
index 9db5eded89..b40fb5a977 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -360,6 +360,18 @@ static QemuOptsList nbd_runtime_opts = {
             .help = "experimental: expose named dirty bitmap in place of "
                     "block status",
         },
+        {
+            .name = "reconnect-delay",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Reconnect delay. On disconnect, nbd client tries to"
+                    "connect again, until success or serious error. During"
+                    "first @reconnect-delay seconds of reconnecting loop all"
+                    "requests are paused and have a chance to rerun, if"
+                    "successful connect occures during this time. After"
+                    "@reconnect-delay seconds all delayed requests are failed"
+                    "and all following requests will be failed to (until"
+                    "successfull reconnect). Default 300 seconds",
+        },
         { /* end of list */ }
     },
 };
@@ -411,7 +423,9 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* NBD handshake */
     ret = nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname,
-                          qemu_opt_get(opts, "x-dirty-bitmap"), errp);
+                          qemu_opt_get(opts, "x-dirty-bitmap"),
+                          qemu_opt_get_number(opts, "reconnect-delay", 300),
+                          errp);
 
  error:
     if (tlscreds) {
-- 
2.11.1
