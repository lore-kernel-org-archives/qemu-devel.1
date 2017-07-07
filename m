Received: from eggs.gnu.org ([2001:4830:134:3::10]:40411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCM-0000sc-9c
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCG-0001E9-9h
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:4668 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTVCF-0001Cf-L3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Jul 2017 18:29:18 +0300
Message-Id: <20170707152918.23086-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 10/10] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Let NBD use the trace mechanisms already present in qemu. Now you can
use the -trace optino of qemu, or the -T/--trace option of qemu-img,
qemu-io, and qemu-nbd, to select nbd traces. For qemu, the QMP commands
trace-event-{get,set}-state can also toggle tracing on the fly.

Example:
   qemu-nbd --trace 'nbd_*' <image file> # enables all nbd traces

Recompilation with CFLAGS=-DDEBUG_NBD is no more needed, furthermore,
DEBUG_NBD macro is removed from the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 Makefile.objs      |  1 +
 nbd/client.c       | 70 ++++++++++++++++++++++++------------------------------
 nbd/nbd-internal.h | 19 ---------------
 nbd/server.c       | 67 ++++++++++++++++++++++++---------------------------
 nbd/trace-events   | 58 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 94 deletions(-)
 create mode 100644 nbd/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index b2e6322ef0..a66ea34cc4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -168,6 +168,7 @@ trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
 trace-events-subdirs += accel/tcg
 trace-events-subdirs += accel/kvm
+trace-events-subdirs += nbd
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
diff --git a/nbd/client.c b/nbd/client.c
index 1ae4ff8a8e..ab4665307b 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "trace.h"
 #include "nbd-internal.h"
 
 static int nbd_errno_to_system_errno(int err)
@@ -44,7 +45,7 @@ static int nbd_errno_to_system_errno(int err)
         ret = ESHUTDOWN;
         break;
     default:
-        TRACE("Squashing unexpected error %d to EINVAL", err);
+        trace_nbd_unknown_error(err);
         /* fallthrough */
     case NBD_EINVAL:
         ret = EINVAL;
@@ -103,7 +104,7 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
     if (len == -1) {
         req.length = len = strlen(data);
     }
-    TRACE("Sending option request %" PRIu32", len %" PRIu32, opt, len);
+    trace_nbd_send_option_request(opt, len);
 
     stq_be_p(&req.magic, NBD_OPTS_MAGIC);
     stl_be_p(&req.option, opt);
@@ -153,8 +154,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
     be32_to_cpus(&reply->type);
     be32_to_cpus(&reply->length);
 
-    TRACE("Received option reply %" PRIx32", type %" PRIx32", len %" PRIu32,
-          reply->option, reply->type, reply->length);
+    trace_nbd_receive_option_reply(reply->option, reply->type, reply->length);
 
     if (reply->magic != NBD_REP_MAGIC) {
         error_setg(errp, "Unexpected option reply magic");
@@ -201,8 +201,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
 
     switch (reply->type) {
     case NBD_REP_ERR_UNSUP:
-        TRACE("server doesn't understand request %" PRIx32
-              ", attempting fallback", reply->option);
+        trace_nbd_reply_err_unsup(reply->option);
         result = 0;
         goto cleanup;
 
@@ -342,12 +341,12 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
 {
     bool foundExport = false;
 
-    TRACE("Querying export list for '%s'", wantname);
+    trace_nbd_receive_query_exports_start(wantname);
     if (nbd_send_option_request(ioc, NBD_OPT_LIST, 0, NULL, errp) < 0) {
         return -1;
     }
 
-    TRACE("Reading available export names");
+    trace_nbd_receive_query_exports_loop();
     while (1) {
         int ret = nbd_receive_list(ioc, wantname, &foundExport, errp);
 
@@ -362,7 +361,7 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
-            TRACE("Found desired export name '%s'", wantname);
+            trace_nbd_receive_query_exports_success(wantname);
             return 0;
         }
     }
@@ -376,12 +375,12 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     QIOChannelTLS *tioc;
     struct NBDTLSHandshakeData data = { 0 };
 
-    TRACE("Requesting TLS from server");
+    trace_nbd_receive_starttls_request();
     if (nbd_send_option_request(ioc, NBD_OPT_STARTTLS, 0, NULL, errp) < 0) {
         return NULL;
     }
 
-    TRACE("Getting TLS reply from server");
+    trace_nbd_receive_starttls_reply();
     if (nbd_receive_option_reply(ioc, NBD_OPT_STARTTLS, &reply, errp) < 0) {
         return NULL;
     }
@@ -400,14 +399,14 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
         return NULL;
     }
 
-    TRACE("TLS request approved, setting up TLS");
+    trace_nbd_receive_starttls_new_client();
     tioc = qio_channel_tls_new_client(ioc, tlscreds, hostname, errp);
     if (!tioc) {
         return NULL;
     }
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
     data.loop = g_main_loop_new(g_main_context_default(), FALSE);
-    TRACE("Starting TLS handshake");
+    trace_nbd_receive_starttls_tls_handshake();
     qio_channel_tls_handshake(tioc,
                               nbd_tls_handshake,
                               &data,
@@ -437,8 +436,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
     int rc;
     bool zeroes = true;
 
-    TRACE("Receiving negotiation tlscreds=%p hostname=%s.",
-          tlscreds, hostname ? hostname : "<null>");
+    trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>");
 
     rc = -EINVAL;
 
@@ -462,7 +460,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
     }
 
     magic = ldq_be_p(buf);
-    TRACE("Magic is 0x%" PRIx64, magic);
+    trace_nbd_receive_negotiate_magic(magic);
 
     if (memcmp(buf, "NBDMAGIC", 8) != 0) {
         error_setg(errp, "Invalid magic received");
@@ -474,7 +472,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
     magic = be64_to_cpu(magic);
-    TRACE("Magic is 0x%" PRIx64, magic);
+    trace_nbd_receive_negotiate_magic2(magic);
 
     if (magic == NBD_OPTS_MAGIC) {
         uint32_t clientflags = 0;
@@ -486,7 +484,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             goto fail;
         }
         globalflags = be16_to_cpu(globalflags);
-        TRACE("Global flags are %" PRIx32, globalflags);
+        trace_nbd_receive_negotiate_server_flags(globalflags);
         if (globalflags & NBD_FLAG_FIXED_NEWSTYLE) {
             fixedNewStyle = true;
             clientflags |= NBD_FLAG_C_FIXED_NEWSTYLE;
@@ -514,7 +512,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             }
         }
         if (!name) {
-            TRACE("Using default NBD export name \"\"");
+            trace_nbd_receive_negotiate_default_name();
             name = "";
         }
         if (fixedNewStyle) {
@@ -579,7 +577,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
 
-    TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags);
+    trace_nbd_receive_negotiate_size_flags(*size, *flags);
     if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
         error_prepend(errp, "Failed to read reserved block");
         goto fail;
@@ -601,7 +599,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
         return -E2BIG;
     }
 
-    TRACE("Setting NBD socket");
+    trace_nbd_init_set_socket();
 
     if (ioctl(fd, NBD_SET_SOCK, (unsigned long) sioc->fd) < 0) {
         int serrno = errno;
@@ -609,7 +607,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
         return -serrno;
     }
 
-    TRACE("Setting block size to %lu", (unsigned long)BDRV_SECTOR_SIZE);
+    trace_nbd_init_set_block_size(BDRV_SECTOR_SIZE);
 
     if (ioctl(fd, NBD_SET_BLKSIZE, (unsigned long)BDRV_SECTOR_SIZE) < 0) {
         int serrno = errno;
@@ -617,10 +615,9 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
         return -serrno;
     }
 
-    TRACE("Setting size to %lu block(s)", sectors);
+    trace_nbd_init_set_size(sectors);
     if (size % BDRV_SECTOR_SIZE) {
-        TRACE("Ignoring trailing %d bytes of export",
-              (int) (size % BDRV_SECTOR_SIZE));
+        trace_nbd_init_trailing_bytes(size % BDRV_SECTOR_SIZE);
     }
 
     if (ioctl(fd, NBD_SET_SIZE_BLOCKS, sectors) < 0) {
@@ -632,7 +629,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
     if (ioctl(fd, NBD_SET_FLAGS, (unsigned long) flags) < 0) {
         if (errno == ENOTTY) {
             int read_only = (flags & NBD_FLAG_READ_ONLY) != 0;
-            TRACE("Setting readonly attribute");
+            trace_nbd_init_set_readonly();
 
             if (ioctl(fd, BLKROSET, (unsigned long) &read_only) < 0) {
                 int serrno = errno;
@@ -646,7 +643,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
         }
     }
 
-    TRACE("Negotiation ended");
+    trace_nbd_init_finish();
 
     return 0;
 }
@@ -656,7 +653,7 @@ int nbd_client(int fd)
     int ret;
     int serrno;
 
-    TRACE("Doing NBD loop");
+    trace_nbd_client_loop();
 
     ret = ioctl(fd, NBD_DO_IT);
     if (ret < 0 && errno == EPIPE) {
@@ -668,12 +665,12 @@ int nbd_client(int fd)
     }
     serrno = errno;
 
-    TRACE("NBD loop returned %d: %s", ret, strerror(serrno));
+    trace_nbd_client_loop_ret(ret, strerror(serrno));
 
-    TRACE("Clearing NBD queue");
+    trace_nbd_client_clear_queue();
     ioctl(fd, NBD_CLEAR_QUE);
 
-    TRACE("Clearing NBD socket");
+    trace_nbd_client_clear_socket();
     ioctl(fd, NBD_CLEAR_SOCK);
 
     errno = serrno;
@@ -710,11 +707,8 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
 {
     uint8_t buf[NBD_REQUEST_SIZE];
 
-    TRACE("Sending request to server: "
-          "{ .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64
-          ", .flags = %" PRIx16 ", .type = %" PRIu16 " }",
-          request->from, request->len, request->handle,
-          request->flags, request->type);
+    trace_nbd_send_request(request->from, request->len, request->handle,
+                           request->flags, request->type);
 
     stl_be_p(buf, NBD_REQUEST_MAGIC);
     stw_be_p(buf + 4, request->flags);
@@ -759,9 +753,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
         error_setg(errp, "server shutting down");
         return -EINVAL;
     }
-    TRACE("Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32
-          ", handle = %" PRIu64" }",
-          magic, reply->error, reply->handle);
+    trace_nbd_receive_reply(magic, reply->error, reply->handle);
 
     if (magic != NBD_REPLY_MAGIC) {
         error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 39bfed177c..cf6ecbf358 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -31,25 +31,6 @@
 #include "qemu/queue.h"
 #include "qemu/main-loop.h"
 
-/* #define DEBUG_NBD */
-
-#ifdef DEBUG_NBD
-#define DEBUG_NBD_PRINT 1
-#else
-#define DEBUG_NBD_PRINT 0
-#endif
-
-#define TRACE(msg, ...) do { \
-    if (DEBUG_NBD_PRINT) { \
-        LOG(msg, ## __VA_ARGS__); \
-    } \
-} while (0)
-
-#define LOG(msg, ...) do { \
-    fprintf(stderr, "%s:%s():L%d: " msg "\n", \
-            __FILE__, __FUNCTION__, __LINE__, ## __VA_ARGS__); \
-} while (0)
-
 /* This is all part of the "official" NBD API.
  *
  * The most up-to-date documentation is available at:
diff --git a/nbd/server.c b/nbd/server.c
index 4bbce5fe76..ca95f431d4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "trace.h"
 #include "nbd-internal.h"
 
 static int system_errno_to_nbd_errno(int err)
@@ -138,8 +139,7 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
 {
     uint64_t magic;
 
-    TRACE("Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32,
-          opt, type, len);
+    trace_nbd_negotiate_send_rep_len(opt, type, len);
 
     magic = cpu_to_be64(NBD_REP_MAGIC);
     if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
@@ -191,7 +191,7 @@ nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
     va_end(va);
     len = strlen(msg);
     assert(len < 4096);
-    TRACE("sending error message \"%s\"", msg);
+    trace_nbd_negotiate_send_rep_err(msg);
     ret = nbd_negotiate_send_rep_len(ioc, type, opt, len, errp);
     if (ret < 0) {
         goto out;
@@ -219,7 +219,7 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp,
     const char *desc = exp->description ? exp->description : "";
     int ret;
 
-    TRACE("Advertising export name '%s' description '%s'", name, desc);
+    trace_nbd_negotiate_send_rep_list(name, desc);
     name_len = strlen(name);
     desc_len = strlen(desc);
     len = name_len + desc_len + sizeof(len);
@@ -283,7 +283,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
     /* Client sends:
         [20 ..  xx]   export name (length bytes)
      */
-    TRACE("Checking length");
+    trace_nbd_negotiate_handle_export_name();
     if (length >= sizeof(name)) {
         error_setg(errp, "Bad length received");
         return -EINVAL;
@@ -294,7 +294,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
     }
     name[length] = '\0';
 
-    TRACE("Client requested export '%s'", name);
+    trace_nbd_negotiate_handle_export_name_request(name);
 
     client->exp = nbd_export_find(name);
     if (!client->exp) {
@@ -318,7 +318,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     QIOChannelTLS *tioc;
     struct NBDTLSHandshakeData data = { 0 };
 
-    TRACE("Setting up TLS");
+    trace_nbd_negotiate_handle_starttls();
     ioc = client->ioc;
     if (length) {
         if (nbd_drop(ioc, length, errp) < 0) {
@@ -344,7 +344,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     }
 
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
-    TRACE("Starting TLS handshake");
+    trace_nbd_negotiate_handle_starttls_handshake();
     data.loop = g_main_loop_new(g_main_context_default(), FALSE);
     qio_channel_tls_handshake(tioc,
                               nbd_tls_handshake,
@@ -396,15 +396,15 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
         error_prepend(errp, "read failed: ");
         return -EIO;
     }
-    TRACE("Checking client flags");
+    trace_nbd_negotiate_options_flags();
     be32_to_cpus(&flags);
     if (flags & NBD_FLAG_C_FIXED_NEWSTYLE) {
-        TRACE("Client supports fixed newstyle handshake");
+        trace_nbd_negotiate_options_newstyle();
         fixedNewstyle = true;
         flags &= ~NBD_FLAG_C_FIXED_NEWSTYLE;
     }
     if (flags & NBD_FLAG_C_NO_ZEROES) {
-        TRACE("Client supports no zeroes at handshake end");
+        trace_nbd_negotiate_options_no_zeroes();
         client->no_zeroes = true;
         flags &= ~NBD_FLAG_C_NO_ZEROES;
     }
@@ -422,7 +422,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             error_prepend(errp, "read failed: ");
             return -EINVAL;
         }
-        TRACE("Checking opts magic");
+        trace_nbd_negotiate_options_check_magic();
         if (magic != be64_to_cpu(NBD_OPTS_MAGIC)) {
             error_setg(errp, "Bad magic received");
             return -EINVAL;
@@ -441,7 +441,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
         }
         length = be32_to_cpu(length);
 
-        TRACE("Checking option 0x%" PRIx32, option);
+        trace_nbd_negotiate_options_check_option(option);
         if (client->tlscreds &&
             client->ioc == (QIOChannel *)client->sioc) {
             QIOChannel *tioc;
@@ -501,8 +501,8 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                                        &local_err);
 
                 if (local_err != NULL) {
-                    TRACE("Reply to NBD_OPT_ABORT request failed: %s",
-                          error_get_pretty(local_err));
+                    const char *error = error_get_pretty(local_err);
+                    trace_nbd_opt_abort_reply_failed(error);
                     error_free(local_err);
                 }
 
@@ -599,14 +599,14 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 
     qio_channel_set_blocking(client->ioc, false, NULL);
 
-    TRACE("Beginning negotiation.");
+    trace_nbd_negotiate_begin();
     memset(buf, 0, sizeof(buf));
     memcpy(buf, "NBDMAGIC", 8);
 
     oldStyle = client->exp != NULL && !client->tlscreds;
     if (oldStyle) {
-        TRACE("advertising size %" PRIu64 " and flags %x",
-              client->exp->size, client->exp->nbdflags | myflags);
+        trace_nbd_negotiate_old_style(client->exp->size,
+                                      client->exp->nbdflags | myflags);
         stq_be_p(buf + 8, NBD_CLIENT_MAGIC);
         stq_be_p(buf + 16, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
@@ -631,8 +631,8 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
             return ret;
         }
 
-        TRACE("advertising size %" PRIu64 " and flags %x",
-              client->exp->size, client->exp->nbdflags | myflags);
+        trace_nbd_negotiate_new_style_size_flags(
+            client->exp->size, client->exp->nbdflags | myflags);
         stq_be_p(buf + 18, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
         len = client->no_zeroes ? 10 : sizeof(buf) - 18;
@@ -643,7 +643,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
         }
     }
 
-    TRACE("Negotiation succeeded.");
+    trace_nbd_negotiate_success();
 
     return 0;
 }
@@ -676,9 +676,8 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
     request->from   = ldq_be_p(buf + 16);
     request->len    = ldl_be_p(buf + 24);
 
-    TRACE("Got request: { magic = 0x%" PRIx32 ", .flags = %" PRIx16
-          ", .type = %" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }",
-          magic, request->flags, request->type, request->from, request->len);
+    trace_nbd_receive_request(magic, request->flags, request->type,
+                              request->from, request->len);
 
     if (magic != NBD_REQUEST_MAGIC) {
         error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
@@ -693,9 +692,7 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 
     reply->error = system_errno_to_nbd_errno(reply->error);
 
-    TRACE("Sending response to client: { .error = %" PRId32
-          ", handle = %" PRIu64 " }",
-          reply->error, reply->handle);
+    trace_nbd_send_reply(reply->error, reply->handle);
 
     /* Reply
        [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
@@ -792,7 +789,7 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
-    TRACE("Export %s: Attaching clients to AIO context %p\n", exp->name, ctx);
+    trace_nbd_blk_aio_attached(exp->name, ctx);
 
     exp->ctx = ctx;
 
@@ -812,7 +809,7 @@ static void blk_aio_detach(void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
-    TRACE("Export %s: Detaching clients from AIO context %p\n", exp->name, exp->ctx);
+    trace_nbd_blk_aio_detach(exp->name, exp->ctx);
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
         qio_channel_detach_aio_context(client->ioc);
@@ -1001,8 +998,7 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
 
     g_assert(qemu_in_coroutine());
 
-    TRACE("Send reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d",
-          reply->handle, reply->error, len);
+    trace_nbd_co_send_reply(reply->handle, reply->error, len);
 
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
@@ -1043,8 +1039,7 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         return -EIO;
     }
 
-    TRACE("Decoding type: handle = %" PRIu64 ", type = %" PRIu16,
-          request->handle, request->type);
+    trace_nbd_co_receive_request_decode_type(request->handle, request->type);
 
     if (request->type != NBD_CMD_WRITE) {
         /* No payload, we are ready to read the next request.  */
@@ -1086,8 +1081,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         }
         req->complete = true;
 
-        TRACE("Payload received: handle = %" PRIu64 ", len = %" PRIu32,
-              request->handle, request->len);
+        trace_nbd_co_receive_request_payload_received(request->handle,
+                                                      request->len);
     }
 
     /* Sanity checks, part 2. */
@@ -1123,7 +1118,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     int reply_data_len = 0;
     Error *local_err = NULL;
 
-    TRACE("Reading request.");
+    trace_nbd_trip();
     if (client->closing) {
         nbd_client_put(client);
         return;
diff --git a/nbd/trace-events b/nbd/trace-events
new file mode 100644
index 0000000000..b20165a585
--- /dev/null
+++ b/nbd/trace-events
@@ -0,0 +1,58 @@
+# nbd/client.c
+nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
+nbd_send_option_request(uint32_t opt, uint32_t len) "Sending option request %" PRIu32", len %" PRIu32
+nbd_receive_option_reply(uint32_t option, uint32_t type, uint32_t length) "Received option reply %" PRIx32", type %" PRIx32", len %" PRIu32
+nbd_reply_err_unsup(uint32_t option) "server doesn't understand request %" PRIx32 ", attempting fallback"
+nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
+nbd_receive_query_exports_loop(void) "Reading available export names"
+nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
+nbd_receive_starttls_request(void) "Requesting TLS from server"
+nbd_receive_starttls_reply(void) "Getting TLS reply from server"
+nbd_receive_starttls_new_client(void) "TLS request approved, setting up TLS"
+nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
+nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
+nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
+nbd_receive_negotiate_magic2(uint64_t magic) "Magic is 0x%" PRIx64
+nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are %" PRIx32
+nbd_receive_negotiate_default_name(void) "Using default NBD export name \"\""
+nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is %" PRIu64 ", export flags %" PRIx16
+nbd_init_set_socket(void) "Setting NBD socket"
+nbd_init_set_block_size(unsigned long block_size) "Setting block size to %lu"
+nbd_init_set_size(unsigned long sectors) "Setting size to %lu block(s)"
+nbd_init_trailing_bytes(int ignored_bytes) "Ignoring trailing %d bytes of export"
+nbd_init_set_readonly(void) "Setting readonly attribute"
+nbd_init_finish(void) "Negotiation ended"
+nbd_client_loop(void) "Doing NBD loop"
+nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
+nbd_client_clear_queue(void) "Clearing NBD queue"
+nbd_client_clear_socket(void) "Clearing NBD socket"
+nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = %" PRIx16 ", .type = %" PRIu16 " }"
+nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"
+
+# nbd/server.c
+nbd_negotiate_send_rep_len(uint32_t opt, uint32_t type, uint32_t len) "Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32
+nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%s\""
+nbd_negotiate_send_rep_list(const char *name, const char *desc) "Advertising export name '%s' description '%s'"
+nbd_negotiate_handle_export_name(void) "Checking length"
+nbd_negotiate_handle_export_name_request(const char *name) "Client requested export '%s'"
+nbd_negotiate_handle_starttls(void) "Setting up TLS"
+nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
+nbd_negotiate_options_flags(void) "Checking client flags"
+nbd_negotiate_options_newstyle(void) "Client supports fixed newstyle handshake"
+nbd_negotiate_options_no_zeroes(void) "Client supports no zeroes at handshake end"
+nbd_negotiate_options_check_magic(void) "Checking opts magic"
+nbd_negotiate_options_check_option(uint32_t option) "Checking option 0x%" PRIx32
+nbd_opt_abort_reply_failed(const char *error) "Reply to NBD_OPT_ABORT request failed: %s"
+nbd_negotiate_begin(void) "Beginning negotiation"
+nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
+nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
+nbd_negotiate_success(void) "Negotiation succeeded"
+nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = %" PRIx16 ", .type = %" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
+nbd_send_reply(int32_t error, uint64_t handle) "Sending response to client: { .error = %" PRId32 ", handle = %" PRIu64 " }"
+nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
+nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
+nbd_co_send_reply(uint64_t handle, uint32_t error, int len) "Send reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d"
+nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16
+nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
+nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " byte(s)"
+nbd_trip(void) "Reading request"
-- 
2.11.1
