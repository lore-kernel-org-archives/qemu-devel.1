Received: from eggs.gnu.org ([209.51.188.92]:48165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB83-0001x4-Dp
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB81-0007RV-RD
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:07 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 15:56:00 +0300
Message-Id: <20190211125601.86533-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-1-vsementsov@virtuozzo.com>
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/4] nbd: do qemu_coroutine_yield during tls
 handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

We always call qio_channel_tls_handshake in nbd from couroutine. Take
benefit of it and just yield instead of creating personal main loop.

Mark and rename the function and it's callers correspondingly and
trace-points too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c     | 26 +++++++++-----------------
 nbd/common.c     |  6 ++----
 nbd/server.c     | 45 +++++++++++++++++----------------------------
 nbd/trace-events | 15 +++++++--------
 4 files changed, 35 insertions(+), 57 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 2ba2220a4a..e3919be30e 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -578,13 +578,14 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error **errp)
     return 1;
 }
 
-static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
-                                        QCryptoTLSCreds *tlscreds,
-                                        const char *hostname, Error **errp)
+static QIOChannel *nbd_co_receive_starttls(
+        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostname,
+        Error **errp)
 {
     int ret;
     QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
+
+    assert(qemu_in_coroutine());
 
     ret = nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, errp);
     if (ret <= 0) {
@@ -601,23 +602,13 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
         return NULL;
     }
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
     trace_nbd_receive_starttls_tls_handshake();
     qio_channel_tls_handshake(tioc,
                               nbd_tls_handshake,
-                              &data,
+                              qemu_coroutine_self(),
                               NULL,
                               NULL);
-
-    if (!data.complete) {
-        g_main_loop_run(data.loop);
-    }
-    g_main_loop_unref(data.loop);
-    if (data.error) {
-        error_propagate(errp, data.error);
-        object_unref(OBJECT(tioc));
-        return NULL;
-    }
+    qemu_coroutine_yield();
 
     return QIO_CHANNEL(tioc);
 }
@@ -922,7 +913,8 @@ static int coroutine_fn nbd_co_start_negotiate(
         }
         if (tlscreds) {
             if (fixedNewStyle) {
-                *outioc = nbd_receive_starttls(ioc, tlscreds, hostname, errp);
+                *outioc = nbd_co_receive_starttls(ioc, tlscreds, hostname,
+                                                  errp);
                 if (!*outioc) {
                     return -EINVAL;
                 }
diff --git a/nbd/common.c b/nbd/common.c
index cc8b278e54..8cff29ec33 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -50,11 +50,9 @@ int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
 void nbd_tls_handshake(QIOTask *task,
                        void *opaque)
 {
-    struct NBDTLSHandshakeData *data = opaque;
+    Coroutine *co = opaque;
 
-    qio_task_propagate_error(task, &data->error);
-    data->complete = true;
-    g_main_loop_quit(data->loop);
+    aio_co_wake(co);
 }
 
 
diff --git a/nbd/server.c b/nbd/server.c
index 838c150d8c..4463e8d792 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -668,16 +668,15 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
 
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
-static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
-                                                 Error **errp)
+static QIOChannel coroutine_fn *nbd_co_negotiate_handle_starttls(
+        NBDClient *client, Error **errp)
 {
     QIOChannel *ioc;
     QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
 
     assert(client->opt == NBD_OPT_STARTTLS);
 
-    trace_nbd_negotiate_handle_starttls();
+    trace_nbd_co_negotiate_handle_starttls();
     ioc = client->ioc;
 
     if (nbd_negotiate_send_rep(client, NBD_REP_ACK, errp) < 0) {
@@ -693,23 +692,13 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     }
 
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
-    trace_nbd_negotiate_handle_starttls_handshake();
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
+    trace_nbd_co_negotiate_handle_starttls_handshake();
     qio_channel_tls_handshake(tioc,
                               nbd_tls_handshake,
-                              &data,
+                              qemu_coroutine_self(),
                               NULL,
                               NULL);
-
-    if (!data.complete) {
-        g_main_loop_run(data.loop);
-    }
-    g_main_loop_unref(data.loop);
-    if (data.error) {
-        object_unref(OBJECT(tioc));
-        error_propagate(errp, data.error);
-        return NULL;
-    }
+    qemu_coroutine_yield();
 
     return QIO_CHANNEL(tioc);
 }
@@ -1023,8 +1012,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
  * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
  *         errp is not set
  */
-static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
-                                 Error **errp)
+static int coroutine_fn nbd_co_negotiate_options(
+        NBDClient *client, uint16_t myflags, Error **errp)
 {
     uint32_t flags;
     bool fixedNewstyle = false;
@@ -1048,7 +1037,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
     if (nbd_read32(client->ioc, &flags, "flags", errp) < 0) {
         return -EIO;
     }
-    trace_nbd_negotiate_options_flags(flags);
+    trace_nbd_co_negotiate_options_flags(flags);
     if (flags & NBD_FLAG_C_FIXED_NEWSTYLE) {
         fixedNewstyle = true;
         flags &= ~NBD_FLAG_C_FIXED_NEWSTYLE;
@@ -1070,7 +1059,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
         if (nbd_read64(client->ioc, &magic, "opts magic", errp) < 0) {
             return -EINVAL;
         }
-        trace_nbd_negotiate_options_check_magic(magic);
+        trace_nbd_co_negotiate_options_check_magic(magic);
         if (magic != NBD_OPTS_MAGIC) {
             error_setg(errp, "Bad magic received");
             return -EINVAL;
@@ -1093,7 +1082,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
             return -EINVAL;
         }
 
-        trace_nbd_negotiate_options_check_option(option,
+        trace_nbd_co_negotiate_options_check_option(option,
                                                  nbd_opt_lookup(option));
         if (client->tlscreds &&
             client->ioc == (QIOChannel *)client->sioc) {
@@ -1109,7 +1098,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                      * can't start a TLS negotiation correctly */
                     return nbd_reject_length(client, true, errp);
                 }
-                tioc = nbd_negotiate_handle_starttls(client, errp);
+                tioc = nbd_co_negotiate_handle_starttls(client, errp);
                 if (!tioc) {
                     return -EIO;
                 }
@@ -1241,7 +1230,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
  * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
  *         errp is not set
  */
-static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
+static coroutine_fn int nbd_co_negotiate(NBDClient *client, Error **errp)
 {
     char buf[NBD_OLDSTYLE_NEGOTIATE_SIZE] = "";
     int ret;
@@ -1265,7 +1254,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 
     qio_channel_set_blocking(client->ioc, false, NULL);
 
-    trace_nbd_negotiate_begin();
+    trace_nbd_co_negotiate_begin();
     memcpy(buf, "NBDMAGIC", 8);
 
     stq_be_p(buf + 8, NBD_OPTS_MAGIC);
@@ -1275,7 +1264,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
         error_prepend(errp, "write failed: ");
         return -EINVAL;
     }
-    ret = nbd_negotiate_options(client, myflags, errp);
+    ret = nbd_co_negotiate_options(client, myflags, errp);
     if (ret != 0) {
         if (ret < 0) {
             error_prepend(errp, "option negotiation failed: ");
@@ -1284,7 +1273,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
     }
 
     assert(!client->optlen);
-    trace_nbd_negotiate_success();
+    trace_nbd_co_negotiate_success();
 
     return 0;
 }
@@ -2408,7 +2397,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 
     qemu_co_mutex_init(&client->send_lock);
 
-    if (nbd_negotiate(client, &local_err)) {
+    if (nbd_co_negotiate(client, &local_err)) {
         if (local_err) {
             error_report_err(local_err);
         }
diff --git a/nbd/trace-events b/nbd/trace-events
index 7f10ebd4e0..0316ba0c71 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -46,19 +46,18 @@ nbd_negotiate_send_info(int info, const char *name, uint32_t length) "Sending NB
 nbd_negotiate_handle_info_requests(int requests) "Client requested %d items of info"
 nbd_negotiate_handle_info_request(int request, const char *name) "Client requested info %d (%s)"
 nbd_negotiate_handle_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "advertising minimum 0x%" PRIx32 ", preferred 0x%" PRIx32 ", maximum 0x%" PRIx32
-nbd_negotiate_handle_starttls(void) "Setting up TLS"
-nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
+nbd_co_negotiate_handle_starttls(void) "Setting up TLS"
+nbd_co_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
 nbd_negotiate_meta_context(const char *optname, const char *export, uint32_t queries) "Client requested %s for export %s, with %" PRIu32 " queries"
 nbd_negotiate_meta_query_skip(const char *reason) "Skipping meta query: %s"
 nbd_negotiate_meta_query_parse(const char *query) "Parsed meta query '%s'"
 nbd_negotiate_meta_query_reply(const char *context, uint32_t id) "Replying with meta context '%s' id %" PRIu32
-nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
-nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
-nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option %" PRIu32 " (%s)"
-nbd_negotiate_begin(void) "Beginning negotiation"
-nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
+nbd_co_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
+nbd_co_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
+nbd_co_negotiate_options_check_option(uint32_t option, const char *name) "Checking option %" PRIu32 " (%s)"
+nbd_co_negotiate_begin(void) "Beginning negotiation"
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
-nbd_negotiate_success(void) "Negotiation succeeded"
+nbd_co_negotiate_success(void) "Negotiation succeeded"
 nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
-- 
2.18.0
