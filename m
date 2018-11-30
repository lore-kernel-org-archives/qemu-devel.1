Received: from eggs.gnu.org ([2001:4830:134:3::10]:56018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtJ-0004Pn-Gp
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtH-0004Fa-7K
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:05 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:35 -0600
Message-Id: <20181130220344.3350618-7-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 06/14] nbd/client: Move export name into
 NBDExportInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Refactor the 'name' parameter of nbd_receive_negotiate() from
being a separate parameter into being part of the in-out 'info'.
This also spills over to a simplification of nbd_opt_go().

The main driver for this refactoring is that an upcoming patch
would like to add support to qemu-nbd to list information about
all exports available on a server, where the name(s) will be
provided by the server instead of the client.  But another benefit
is that we can now allow the client to explicitly specify the
empty export name "" even when connecting to an oldstyle server
(even if qemu is no longer such a server after commit 7f7dfe2a).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  8 ++++----
 block/nbd-client.c  |  5 +++--
 nbd/client.c        | 39 ++++++++++++++++++---------------------
 qemu-nbd.c          |  6 ++++--
 nbd/trace-events    |  2 +-
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6a5bfe5d559..65feff8ba96 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -262,6 +262,7 @@ struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
     char *x_dirty_bitmap;
+    char *name; /* must be non-NULL */

     /* In-out fields, set by client before nbd_receive_negotiate() and
      * updated by server results during nbd_receive_negotiate() */
@@ -279,10 +280,9 @@ struct NBDExportInfo {
 };
 typedef struct NBDExportInfo NBDExportInfo;

-int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
-                          QCryptoTLSCreds *tlscreds, const char *hostname,
-                          QIOChannel **outioc, NBDExportInfo *info,
-                          Error **errp);
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                          const char *hostname, QIOChannel **outioc,
+                          NBDExportInfo *info, Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index fc5b7eda8ee..417971d8b05 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -984,10 +984,11 @@ int nbd_client_init(BlockDriverState *bs,
     client->info.structured_reply = true;
     client->info.base_allocation = true;
     client->info.x_dirty_bitmap = g_strdup(x_dirty_bitmap);
-    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
-                                tlscreds, hostname,
+    client->info.name = g_strdup(export ?: "");
+    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
                                 &client->ioc, &client->info, errp);
     g_free(client->info.x_dirty_bitmap);
+    g_free(client->info.name);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
         return ret;
diff --git a/nbd/client.c b/nbd/client.c
index 17ee24492a4..b5818a99d21 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -320,15 +320,14 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
 }


-/* Returns -1 if NBD_OPT_GO proves the export @wantname cannot be
+/* Returns -1 if NBD_OPT_GO proves the export @info->name cannot be
  * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
  * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
- * go (with @info populated). */
-static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
-                      NBDExportInfo *info, Error **errp)
+ * go (with the rest of @info populated). */
+static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp)
 {
     NBDOptionReply reply;
-    uint32_t len = strlen(wantname);
+    uint32_t len = strlen(info->name);
     uint16_t type;
     int error;
     char *buf;
@@ -338,10 +337,10 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
      * flags still 0 is a witness of a broken server. */
     info->flags = 0;

-    trace_nbd_opt_go_start(wantname);
+    trace_nbd_opt_go_start(info->name);
     buf = g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
     stl_be_p(buf, len);
-    memcpy(buf + 4, wantname, len);
+    memcpy(buf + 4, info->name, len);
     /* At most one request, everything else up to server */
     stw_be_p(buf + 4 + len, info->request_sizes);
     if (info->request_sizes) {
@@ -726,10 +725,9 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
     return 0;
 }

-int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
-                          QCryptoTLSCreds *tlscreds, const char *hostname,
-                          QIOChannel **outioc, NBDExportInfo *info,
-                          Error **errp)
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                          const char *hostname, QIOChannel **outioc,
+                          NBDExportInfo *info, Error **errp)
 {
     uint64_t magic;
     int rc;
@@ -739,6 +737,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,

     trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>");

+    assert(info->name);
+    trace_nbd_receive_negotiate_name(info->name);
     info->structured_reply = false;
     info->base_allocation = false;
     rc = -EINVAL;
@@ -807,10 +807,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                 goto fail;
             }
         }
-        if (!name) {
-            trace_nbd_receive_negotiate_default_name();
-            name = "";
-        }
         if (fixedNewStyle) {
             int result;

@@ -826,7 +822,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,

             if (info->structured_reply && base_allocation) {
                 result = nbd_negotiate_simple_meta_context(
-                        ioc, name, info->x_dirty_bitmap ?: "base:allocation",
+                        ioc, info->name,
+                        info->x_dirty_bitmap ?: "base:allocation",
                         &info->meta_base_allocation_id, errp);
                 if (result < 0) {
                     goto fail;
@@ -839,7 +836,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
              * TLS).  If it is not available, fall back to
              * NBD_OPT_LIST for nicer error messages about a missing
              * export, then use NBD_OPT_EXPORT_NAME.  */
-            result = nbd_opt_go(ioc, name, info, errp);
+            result = nbd_opt_go(ioc, info, errp);
             if (result < 0) {
                 goto fail;
             }
@@ -852,12 +849,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
              * query gives us better error reporting if the
              * export name is not available.
              */
-            if (nbd_receive_query_exports(ioc, name, errp) < 0) {
+            if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
                 goto fail;
             }
         }
         /* write the export name request */
-        if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, name,
+        if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
                                     errp) < 0) {
             goto fail;
         }
@@ -877,8 +874,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
     } else if (magic == NBD_CLIENT_MAGIC) {
         uint32_t oldflags;

-        if (name) {
-            error_setg(errp, "Server does not support export names");
+        if (*info->name) {
+            error_setg(errp, "Server does not support non-empty export names");
             goto fail;
         }
         if (tlscreds) {
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 866e64779f1..c57053a0795 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -263,7 +263,7 @@ static void *show_parts(void *arg)
 static void *nbd_client_thread(void *arg)
 {
     char *device = arg;
-    NBDExportInfo info = { .request_sizes = false, };
+    NBDExportInfo info = { .request_sizes = false, .name = g_strdup("") };
     QIOChannelSocket *sioc;
     int fd;
     int ret;
@@ -278,7 +278,7 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }

-    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL,
+    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc),
                                 NULL, NULL, NULL, &info, &local_error);
     if (ret < 0) {
         if (local_error) {
@@ -317,6 +317,7 @@ static void *nbd_client_thread(void *arg)
     }
     close(fd);
     object_unref(OBJECT(sioc));
+    free(info.name);
     kill(getpid(), SIGTERM);
     return (void *) EXIT_SUCCESS;

@@ -325,6 +326,7 @@ out_fd:
 out_socket:
     object_unref(OBJECT(sioc));
 out:
+    free(info.name);
     kill(getpid(), SIGTERM);
     return (void *) EXIT_FAILURE;
 }
diff --git a/nbd/trace-events b/nbd/trace-events
index 5e1d4afe8e6..289337d0dc3 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -15,7 +15,7 @@ nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping of contex
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are 0x%" PRIx32
-nbd_receive_negotiate_default_name(void) "Using default NBD export name \"\""
+nbd_receive_negotiate_name(const char *name) "Requesting NBD export name \"%s\""
 nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is %" PRIu64 ", export flags 0x%" PRIx16
 nbd_init_set_socket(void) "Setting NBD socket"
 nbd_init_set_block_size(unsigned long block_size) "Setting block size to %lu"
-- 
2.17.2
