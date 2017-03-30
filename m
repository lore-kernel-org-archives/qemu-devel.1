Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cte6Z-0004PI-3K
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cte6X-00030s-J8
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:43:27 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 19:43:17 +0200
Message-Id: <1490895797-29094-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1490895797-29094-1-git-send-email-armbru@redhat.com>
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.9 9/9] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com

Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
d282f34 "sheepdog: Support blockdev-add" have different ideas on how
the QemuOpts parameters for the server address are named.  Fix that.
While there, rename BlockdevOptionsSheepdog member addr to server, for
consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
BlockdevOptionsNbd.

Commit 831acdc's example becomes

    --drive driver=sheepdog,server.type=inet,server.host=fido,server.port=7000,vdi=dolly

instead of

    --drive driver=sheepdog,host=fido,vdi=dolly

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 block/sheepdog.c     | 90 +++++++++++++++++++++++++++++++++-------------------
 qapi/block-core.json |  4 +--
 2 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 89e98ed..1b71fc8 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -13,9 +13,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qint.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -547,6 +549,47 @@ static SocketAddress *sd_socket_address(const char *path,
     return addr;
 }
 
+static SocketAddress *sd_server_config(QDict *options, Error **errp)
+{
+    QDict *server = NULL;
+    QObject *crumpled_server = NULL;
+    Visitor *iv = NULL;
+    SocketAddressFlat *saddr_flat = NULL;
+    SocketAddress *saddr = NULL;
+    Error *local_err = NULL;
+
+    qdict_extract_subqdict(options, &server, "server.");
+
+    crumpled_server = qdict_crumple(server, errp);
+    if (!crumpled_server) {
+        goto done;
+    }
+
+    /*
+     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
+     * server.type=inet.  .to doesn't matter, it's ignored anyway.
+     * That's because when @options come from -blockdev or
+     * blockdev_add, members are typed according to the QAPI schema,
+     * but when they come from -drive, they're all QString.  The
+     * visitor expects the former.
+     */
+    iv = qobject_input_visitor_new(crumpled_server);
+    visit_type_SocketAddressFlat(iv, NULL, &saddr_flat, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto done;
+    }
+
+    saddr = socket_address_crumple(saddr_flat);
+
+done:
+    qapi_free_SocketAddressFlat(saddr_flat);
+    visit_free(iv);
+    qobject_decref(crumpled_server);
+    QDECREF(server);
+    return saddr;
+}
+
 /* Return -EIO in case of error, file descriptor on success */
 static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 {
@@ -1174,15 +1217,15 @@ static void sd_parse_filename(const char *filename, QDict *options,
         return;
     }
 
-    if (cfg.host) {
-        qdict_set_default_str(options, "host", cfg.host);
-    }
-    if (cfg.port) {
-        snprintf(buf, sizeof(buf), "%d", cfg.port);
-        qdict_set_default_str(options, "port", buf);
-    }
     if (cfg.path) {
-        qdict_set_default_str(options, "path", cfg.path);
+        qdict_set_default_str(options, "server.path", cfg.path);
+        qdict_set_default_str(options, "server.type", "unix");
+    } else {
+        qdict_set_default_str(options, "server.type", "inet");
+        qdict_set_default_str(options, "server.host",
+                              cfg.host ?: SD_DEFAULT_ADDR);
+        snprintf(buf, sizeof(buf), "%d", cfg.port ?: SD_DEFAULT_PORT);
+        qdict_set_default_str(options, "server.port", buf);
     }
     qdict_set_default_str(options, "vdi", cfg.vdi);
     qdict_set_default_str(options, "tag", cfg.tag);
@@ -1510,18 +1553,6 @@ static QemuOptsList runtime_opts = {
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
     .desc = {
         {
-            .name = "host",
-            .type = QEMU_OPT_STRING,
-        },
-        {
-            .name = "port",
-            .type = QEMU_OPT_STRING,
-        },
-        {
-            .name = "path",
-            .type = QEMU_OPT_STRING,
-        },
-        {
             .name = "vdi",
             .type = QEMU_OPT_STRING,
         },
@@ -1543,7 +1574,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     int ret, fd;
     uint32_t vid = 0;
     BDRVSheepdogState *s = bs->opaque;
-    const char *host, *port, *path, *vdi, *snap_id_str, *tag;
+    const char *vdi, *snap_id_str, *tag;
     uint64_t snap_id;
     char *buf = NULL;
     QemuOpts *opts;
@@ -1560,20 +1591,17 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
         goto err_no_fd;
     }
 
-    host = qemu_opt_get(opts, "host");
-    port = qemu_opt_get(opts, "port");
-    path = qemu_opt_get(opts, "path");
+    s->addr = sd_server_config(options, errp);
+    if (!s->addr) {
+        ret = -EINVAL;
+        goto err_no_fd;
+    }
+
     vdi = qemu_opt_get(opts, "vdi");
     snap_id_str = qemu_opt_get(opts, "snap-id");
     snap_id = qemu_opt_get_number(opts, "snap-id", CURRENT_VDI_ID);
     tag = qemu_opt_get(opts, "tag");
 
-    if ((host || port) && path) {
-        error_setg(errp, "can't use 'path' together with 'host' or 'port'");
-        ret = -EINVAL;
-        goto err_no_fd;
-    }
-
     if (!vdi) {
         error_setg(errp, "parameter 'vdi' is missing");
         ret = -EINVAL;
@@ -1604,8 +1632,6 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
         goto err_no_fd;
     }
 
-    s->addr = sd_socket_address(path, host, port);
-
     QLIST_INIT(&s->inflight_aio_head);
     QLIST_INIT(&s->failed_aio_head);
     QLIST_INIT(&s->inflight_aiocb_head);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8d87962..b5f0e99 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2623,7 +2623,7 @@
 # Driver specific block device options for sheepdog
 #
 # @vdi:         Virtual disk image name
-# @addr:        The Sheepdog server to connect to
+# @server:      The Sheepdog server to connect to
 # @snap-id:     Snapshot ID
 # @tag:         Snapshot tag name
 #
@@ -2632,7 +2632,7 @@
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsSheepdog',
-  'data': { 'addr': 'SocketAddressFlat',
+  'data': { 'server': 'SocketAddressFlat',
             'vdi': 'str',
             '*snap-id': 'uint32',
             '*tag': 'str' } }
-- 
2.7.4
