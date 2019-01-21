Received: from eggs.gnu.org ([209.51.188.92]:40211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO3-0001P6-GU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNz-0005EC-Ic
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:55 -0600
Message-Id: <20190121224907.26634-10-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/21] nbd/client: Move export name into
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
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

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
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190117193658.16413-10-eblake@redhat.com>
---
 include/block/nbd.h |  8 ++++----
 block/nbd-client.c  |  5 +++--
 nbd/client.c        | 39 ++++++++++++++++++---------------------
 qemu-nbd.c          |  6 ++++--
 nbd/trace-events    |  2 +-
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 24be9570bb4..00d3eb57d9c 100644
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
-                          QCryptoTLSCreds *tlscreds, const char *hostnam=
e,
-                          QIOChannel **outioc, NBDExportInfo *info,
-                          Error **errp);
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                          const char *hostname, QIOChannel **outioc,
+                          NBDExportInfo *info, Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index ef320759716..3309376bc16 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -999,10 +999,11 @@ int nbd_client_init(BlockDriverState *bs,
     client->info.structured_reply =3D true;
     client->info.base_allocation =3D true;
     client->info.x_dirty_bitmap =3D g_strdup(x_dirty_bitmap);
-    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
-                                tlscreds, hostname,
+    client->info.name =3D g_strdup(export ?: "");
+    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
                                 &client->ioc, &client->info, errp);
     g_free(client->info.x_dirty_bitmap);
+    g_free(client->info.name);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
         return ret;
diff --git a/nbd/client.c b/nbd/client.c
index fd4ba8dec37..8227e69478a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -330,15 +330,14 @@ static int nbd_receive_list(QIOChannel *ioc, char *=
*name, char **description,
 }


-/* Returns -1 if NBD_OPT_GO proves the export @wantname cannot be
+/* Returns -1 if NBD_OPT_GO proves the export @info->name cannot be
  * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
  * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
- * go (with @info populated). */
-static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
-                      NBDExportInfo *info, Error **errp)
+ * go (with the rest of @info populated). */
+static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **errp=
)
 {
     NBDOptionReply reply;
-    uint32_t len =3D strlen(wantname);
+    uint32_t len =3D strlen(info->name);
     uint16_t type;
     int error;
     char *buf;
@@ -348,10 +347,10 @@ static int nbd_opt_go(QIOChannel *ioc, const char *=
wantname,
      * flags still 0 is a witness of a broken server. */
     info->flags =3D 0;

-    trace_nbd_opt_go_start(wantname);
+    trace_nbd_opt_go_start(info->name);
     buf =3D g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
     stl_be_p(buf, len);
-    memcpy(buf + 4, wantname, len);
+    memcpy(buf + 4, info->name, len);
     /* At most one request, everything else up to server */
     stw_be_p(buf + 4 + len, info->request_sizes);
     if (info->request_sizes) {
@@ -753,10 +752,9 @@ static int nbd_negotiate_simple_meta_context(QIOChan=
nel *ioc,
     return 0;
 }

-int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
-                          QCryptoTLSCreds *tlscreds, const char *hostnam=
e,
-                          QIOChannel **outioc, NBDExportInfo *info,
-                          Error **errp)
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                          const char *hostname, QIOChannel **outioc,
+                          NBDExportInfo *info, Error **errp)
 {
     uint64_t magic;
     int rc;
@@ -766,6 +764,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char=
 *name,

     trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>"=
);

+    assert(info->name);
+    trace_nbd_receive_negotiate_name(info->name);
     info->structured_reply =3D false;
     info->base_allocation =3D false;
     rc =3D -EINVAL;
@@ -834,10 +834,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, const cha=
r *name,
                 goto fail;
             }
         }
-        if (!name) {
-            trace_nbd_receive_negotiate_default_name();
-            name =3D "";
-        }
         if (fixedNewStyle) {
             int result;

@@ -853,7 +849,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char=
 *name,

             if (info->structured_reply && base_allocation) {
                 result =3D nbd_negotiate_simple_meta_context(
-                        ioc, name, info->x_dirty_bitmap ?: "base:allocat=
ion",
+                        ioc, info->name,
+                        info->x_dirty_bitmap ?: "base:allocation",
                         &info->meta_base_allocation_id, errp);
                 if (result < 0) {
                     goto fail;
@@ -866,7 +863,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char=
 *name,
              * TLS).  If it is not available, fall back to
              * NBD_OPT_LIST for nicer error messages about a missing
              * export, then use NBD_OPT_EXPORT_NAME.  */
-            result =3D nbd_opt_go(ioc, name, info, errp);
+            result =3D nbd_opt_go(ioc, info, errp);
             if (result < 0) {
                 goto fail;
             }
@@ -879,12 +876,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name,
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
+        if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->=
name,
                                     errp) < 0) {
             goto fail;
         }
@@ -904,8 +901,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char=
 *name,
     } else if (magic =3D=3D NBD_CLIENT_MAGIC) {
         uint32_t oldflags;

-        if (name) {
-            error_setg(errp, "Server does not support export names");
+        if (*info->name) {
+            error_setg(errp, "Server does not support non-empty export n=
ames");
             goto fail;
         }
         if (tlscreds) {
diff --git a/qemu-nbd.c b/qemu-nbd.c
index efca0e44a90..3c538700eae 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -264,7 +264,7 @@ static void *show_parts(void *arg)
 static void *nbd_client_thread(void *arg)
 {
     char *device =3D arg;
-    NBDExportInfo info =3D { .request_sizes =3D false, };
+    NBDExportInfo info =3D { .request_sizes =3D false, .name =3D g_strdu=
p("") };
     QIOChannelSocket *sioc;
     int fd;
     int ret;
@@ -279,7 +279,7 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }

-    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL,
+    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc),
                                 NULL, NULL, NULL, &info, &local_error);
     if (ret < 0) {
         if (local_error) {
@@ -318,6 +318,7 @@ static void *nbd_client_thread(void *arg)
     }
     close(fd);
     object_unref(OBJECT(sioc));
+    g_free(info.name);
     kill(getpid(), SIGTERM);
     return (void *) EXIT_SUCCESS;

@@ -326,6 +327,7 @@ out_fd:
 out_socket:
     object_unref(OBJECT(sioc));
 out:
+    g_free(info.name);
     kill(getpid(), SIGTERM);
     return (void *) EXIT_FAILURE;
 }
diff --git a/nbd/trace-events b/nbd/trace-events
index d1e1ca64ee5..c3966d2b653 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -17,7 +17,7 @@ nbd_opt_meta_reply(const char *context, uint32_t id) "R=
eceived mapping of contex
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving n=
egotiation tlscreds=3D%p hostname=3D%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags a=
re 0x%" PRIx32
-nbd_receive_negotiate_default_name(void) "Using default NBD export name =
\"\""
+nbd_receive_negotiate_name(const char *name) "Requesting NBD export name=
 '%s'"
 nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is=
 %" PRIu64 ", export flags 0x%" PRIx16
 nbd_init_set_socket(void) "Setting NBD socket"
 nbd_init_set_block_size(unsigned long block_size) "Setting block size to=
 %lu"
--=20
2.20.1
