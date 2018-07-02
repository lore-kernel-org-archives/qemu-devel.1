Received: from eggs.gnu.org ([2001:4830:134:3::10]:51878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4I2-000156-BO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4I0-0006qM-S4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:15:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Jul 2018 14:14:57 -0500
Message-Id: <20180702191458.28741-2-eblake@redhat.com>
In-Reply-To: <20180702191458.28741-1-eblake@redhat.com>
References: <20180702191458.28741-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] nbd/client: Add x-dirty-bitmap to query
 bitmap from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

In order to test that the NBD server is properly advertising
dirty bitmaps, we need a bare minimum client that can request
and read the context.  Since feature freeze for 3.0 is imminent,
this is the smallest workable patch, which replaces the qemu
block status report with the results of the NBD server's dirty
bitmap (making it very easy to use 'qemu-img map --output=json'
to learn where the dirty portions are).  Note that the NBD
protocol defines a dirty section with the same bit but opposite
sense that normal "base:allocation" uses to report an allocated
section; so in qemu-img map output, "data":true corresponds to
clean, "data":false corresponds to dirty.

A more complete solution that allows dirty bitmaps to be queried
at the same time as normal block status will be required before
this addition can lose the x- prefix.  Until then, the fact that
this replaces normal status with dirty status means actions
like 'qemu-img convert' will likely misbehave due to treating
dirty regions of the file as if they are unallocated.

The next patch adds an iotest to exercise this new code.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

 qapi/block-core.json |  7 ++++++-
 block/nbd-client.h   |  1 +
 include/block/nbd.h  |  1 +
 block/nbd-client.c   |  3 +++
 block/nbd.c          | 10 ++++++++--
 nbd/client.c         |  4 ++--
 6 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 577ce5e9991..90e554ed0ff 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3471,12 +3471,17 @@
 #
 # @tls-creds:   TLS credentials ID
 #
+# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place of
+#                  traditional "base:allocation" block status (see
+#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since 3.0)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
   'data': { 'server': 'SocketAddress',
             '*export': 'str',
-            '*tls-creds': 'str' } }
+            '*tls-creds': 'str',
+            '*x-dirty-bitmap': 'str' } }

 ##
 # @BlockdevOptionsRaw:
diff --git a/block/nbd-client.h b/block/nbd-client.h
index 0ece76e5aff..cfc90550b99 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -45,6 +45,7 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *export_name,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
+                    const char *x_dirty_bitmap,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);

diff --git a/include/block/nbd.h b/include/block/nbd.h
index daaeae61bf9..4638c839f51 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -259,6 +259,7 @@ static inline bool nbd_reply_type_is_error(int type)
 struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
+    char *x_dirty_bitmap;

     /* In-out fields, set by client before nbd_receive_negotiate() and
      * updated by server results during nbd_receive_negotiate() */
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 8d69eaaa32f..9686ecbd5ee 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -970,6 +970,7 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *export,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
+                    const char *x_dirty_bitmap,
                     Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
@@ -982,9 +983,11 @@ int nbd_client_init(BlockDriverState *bs,
     client->info.request_sizes = true;
     client->info.structured_reply = true;
     client->info.base_allocation = true;
+    client->info.x_dirty_bitmap = g_strdup(x_dirty_bitmap);
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
                                 tlscreds, hostname,
                                 &client->ioc, &client->info, errp);
+    g_free(client->info.x_dirty_bitmap);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
         return ret;
diff --git a/block/nbd.c b/block/nbd.c
index 13db4030e67..b198ad775fb 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -378,6 +378,12 @@ static QemuOptsList nbd_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "ID of the TLS credentials to use",
         },
+        {
+            .name = "x-dirty-bitmap",
+            .type = QEMU_OPT_STRING,
+            .help = "experimental: expose named dirty bitmap in place of "
+                    "block status",
+        },
         { /* end of list */ }
     },
 };
@@ -438,8 +444,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     }

     /* NBD handshake */
-    ret = nbd_client_init(bs, sioc, s->export,
-                          tlscreds, hostname, errp);
+    ret = nbd_client_init(bs, sioc, s->export, tlscreds, hostname,
+                          qemu_opt_get(opts, "x-dirty-bitmap"), errp);
  error:
     if (sioc) {
         object_unref(OBJECT(sioc));
diff --git a/nbd/client.c b/nbd/client.c
index 232ff4f46da..40b74d9761f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2017 Red Hat, Inc.
+ *  Copyright (C) 2016-2018 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -831,7 +831,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,

             if (info->structured_reply && base_allocation) {
                 result = nbd_negotiate_simple_meta_context(
-                        ioc, name, "base:allocation",
+                        ioc, name, info->x_dirty_bitmap ?: "base:allocation",
                         &info->meta_base_allocation_id, errp);
                 if (result < 0) {
                     goto fail;
-- 
2.14.4
