Received: from eggs.gnu.org ([2001:4830:134:3::10]:51929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4g-000280-SQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4c-0004R0-Oq
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:38 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4c-0004QV-E0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:34 -0400
Received: by mail-wr0-f181.google.com with SMTP id r103so54033249wrb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:26 +0200
Message-Id: <1499955874-10954-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/41] nbd: Expose and debug more NBD constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The NBD protocol has several constants defined in various extensions
that we are about to implement.  Expose them to the code, along with
an easy way to map various constants to strings during diagnostic
messages.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707203049.534-4-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/nbd.h | 37 +++++++++++++++------
 nbd/client.c        | 52 +++++++++++++++++++-----------
 nbd/common.c        | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 nbd/nbd-internal.h  | 10 +++---
 nbd/server.c        | 18 +++++++----
 nbd/trace-events    | 12 +++----
 6 files changed, 175 insertions(+), 46 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 9092374..4a22eca 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016 Red Hat, Inc.
+ *  Copyright (C) 2016-2017 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -83,18 +83,37 @@ typedef struct NBDReply NBDReply;
 #define NBD_FLAG_C_FIXED_NEWSTYLE (1 << 0) /* Fixed newstyle protocol. */
 #define NBD_FLAG_C_NO_ZEROES      (1 << 1) /* End handshake without zeroes. */
 
-/* Reply types. */
+/* Option requests. */
+#define NBD_OPT_EXPORT_NAME      (1)
+#define NBD_OPT_ABORT            (2)
+#define NBD_OPT_LIST             (3)
+/* #define NBD_OPT_PEEK_EXPORT   (4) not in use */
+#define NBD_OPT_STARTTLS         (5)
+#define NBD_OPT_INFO             (6)
+#define NBD_OPT_GO               (7)
+#define NBD_OPT_STRUCTURED_REPLY (8)
+
+/* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))
 
 #define NBD_REP_ACK             (1)             /* Data sending finished. */
 #define NBD_REP_SERVER          (2)             /* Export description. */
-
-#define NBD_REP_ERR_UNSUP       NBD_REP_ERR(1)  /* Unknown option */
-#define NBD_REP_ERR_POLICY      NBD_REP_ERR(2)  /* Server denied */
-#define NBD_REP_ERR_INVALID     NBD_REP_ERR(3)  /* Invalid length */
-#define NBD_REP_ERR_PLATFORM    NBD_REP_ERR(4)  /* Not compiled in */
-#define NBD_REP_ERR_TLS_REQD    NBD_REP_ERR(5)  /* TLS required */
-#define NBD_REP_ERR_SHUTDOWN    NBD_REP_ERR(7)  /* Server shutting down */
+#define NBD_REP_INFO            (3)             /* NBD_OPT_INFO/GO. */
+
+#define NBD_REP_ERR_UNSUP           NBD_REP_ERR(1)  /* Unknown option */
+#define NBD_REP_ERR_POLICY          NBD_REP_ERR(2)  /* Server denied */
+#define NBD_REP_ERR_INVALID         NBD_REP_ERR(3)  /* Invalid length */
+#define NBD_REP_ERR_PLATFORM        NBD_REP_ERR(4)  /* Not compiled in */
+#define NBD_REP_ERR_TLS_REQD        NBD_REP_ERR(5)  /* TLS required */
+#define NBD_REP_ERR_UNKNOWN         NBD_REP_ERR(6)  /* Export unknown */
+#define NBD_REP_ERR_SHUTDOWN        NBD_REP_ERR(7)  /* Server shutting down */
+#define NBD_REP_ERR_BLOCK_SIZE_REQD NBD_REP_ERR(8)  /* Need INFO_BLOCK_SIZE */
+
+/* Info types, used during NBD_REP_INFO */
+#define NBD_INFO_EXPORT         0
+#define NBD_INFO_NAME           1
+#define NBD_INFO_DESCRIPTION    2
+#define NBD_INFO_BLOCK_SIZE     3
 
 /* Request flags, sent from client to server during transmission phase */
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
diff --git a/nbd/client.c b/nbd/client.c
index 1250273..a443e51 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016 Red Hat, Inc.
+ *  Copyright (C) 2016-2017 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -104,7 +104,7 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
     if (len == -1) {
         req.length = len = strlen(data);
     }
-    trace_nbd_send_option_request(opt, len);
+    trace_nbd_send_option_request(opt, nbd_opt_lookup(opt), len);
 
     stq_be_p(&req.magic, NBD_OPTS_MAGIC);
     stl_be_p(&req.option, opt);
@@ -154,7 +154,9 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
     be32_to_cpus(&reply->type);
     be32_to_cpus(&reply->length);
 
-    trace_nbd_receive_option_reply(reply->option, reply->type, reply->length);
+    trace_nbd_receive_option_reply(reply->option, nbd_opt_lookup(reply->option),
+                                   reply->type, nbd_rep_lookup(reply->type),
+                                   reply->length);
 
     if (reply->magic != NBD_REP_MAGIC) {
         error_setg(errp, "Unexpected option reply magic");
@@ -188,12 +190,16 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
 
     if (reply->length) {
         if (reply->length > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "server's error message is too long");
+            error_setg(errp, "server error 0x%" PRIx32
+                       " (%s) message is too long",
+                       reply->type, nbd_rep_lookup(reply->type));
             goto cleanup;
         }
         msg = g_malloc(reply->length + 1);
         if (nbd_read(ioc, msg, reply->length, errp) < 0) {
-            error_prepend(errp, "failed to read option error message");
+            error_prepend(errp, "failed to read option error 0x%" PRIx32
+                          " (%s) message",
+                          reply->type, nbd_rep_lookup(reply->type));
             goto cleanup;
         }
         msg[reply->length] = '\0';
@@ -201,38 +207,48 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
 
     switch (reply->type) {
     case NBD_REP_ERR_UNSUP:
-        trace_nbd_reply_err_unsup(reply->option);
+        trace_nbd_reply_err_unsup(reply->option, nbd_opt_lookup(reply->option));
         result = 0;
         goto cleanup;
 
     case NBD_REP_ERR_POLICY:
-        error_setg(errp, "Denied by server for option %" PRIx32,
-                   reply->option);
+        error_setg(errp, "Denied by server for option %" PRIx32 " (%s)",
+                   reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_INVALID:
-        error_setg(errp, "Invalid data length for option %" PRIx32,
-                   reply->option);
+        error_setg(errp, "Invalid data length for option %" PRIx32 " (%s)",
+                   reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_PLATFORM:
-        error_setg(errp, "Server lacks support for option %" PRIx32,
-                   reply->option);
+        error_setg(errp, "Server lacks support for option %" PRIx32 " (%s)",
+                   reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_TLS_REQD:
-        error_setg(errp, "TLS negotiation required before option %" PRIx32,
-                   reply->option);
+        error_setg(errp, "TLS negotiation required before option %" PRIx32
+                   " (%s)", reply->option, nbd_opt_lookup(reply->option));
+        break;
+
+    case NBD_REP_ERR_UNKNOWN:
+        error_setg(errp, "Requested export not available for option %" PRIx32
+                   " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_SHUTDOWN:
-        error_setg(errp, "Server shutting down before option %" PRIx32,
-                   reply->option);
+        error_setg(errp, "Server shutting down before option %" PRIx32 " (%s)",
+                   reply->option, nbd_opt_lookup(reply->option));
+        break;
+
+    case NBD_REP_ERR_BLOCK_SIZE_REQD:
+        error_setg(errp, "Server requires INFO_BLOCK_SIZE for option %" PRIx32
+                   " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
 
     default:
-        error_setg(errp, "Unknown error code when asking for option %" PRIx32,
-                   reply->option);
+        error_setg(errp, "Unknown error code when asking for option %" PRIx32
+                   " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
     }
 
diff --git a/nbd/common.c b/nbd/common.c
index 4dab41e..a2f28f2 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -101,3 +101,95 @@ void nbd_tls_handshake(QIOTask *task,
     data->complete = true;
     g_main_loop_quit(data->loop);
 }
+
+
+const char *nbd_opt_lookup(uint32_t opt)
+{
+    switch (opt) {
+    case NBD_OPT_EXPORT_NAME:
+        return "export name";
+    case NBD_OPT_ABORT:
+        return "abort";
+    case NBD_OPT_LIST:
+        return "list";
+    case NBD_OPT_STARTTLS:
+        return "starttls";
+    case NBD_OPT_INFO:
+        return "info";
+    case NBD_OPT_GO:
+        return "go";
+    case NBD_OPT_STRUCTURED_REPLY:
+        return "structured reply";
+    default:
+        return "<unknown>";
+    }
+}
+
+
+const char *nbd_rep_lookup(uint32_t rep)
+{
+    switch (rep) {
+    case NBD_REP_ACK:
+        return "ack";
+    case NBD_REP_SERVER:
+        return "server";
+    case NBD_REP_INFO:
+        return "info";
+    case NBD_REP_ERR_UNSUP:
+        return "unsupported";
+    case NBD_REP_ERR_POLICY:
+        return "denied by policy";
+    case NBD_REP_ERR_INVALID:
+        return "invalid";
+    case NBD_REP_ERR_PLATFORM:
+        return "platform lacks support";
+    case NBD_REP_ERR_TLS_REQD:
+        return "TLS required";
+    case NBD_REP_ERR_UNKNOWN:
+        return "export unknown";
+    case NBD_REP_ERR_SHUTDOWN:
+        return "server shutting down";
+    case NBD_REP_ERR_BLOCK_SIZE_REQD:
+        return "block size required";
+    default:
+        return "<unknown>";
+    }
+}
+
+
+const char *nbd_info_lookup(uint16_t info)
+{
+    switch (info) {
+    case NBD_INFO_EXPORT:
+        return "export";
+    case NBD_INFO_NAME:
+        return "name";
+    case NBD_INFO_DESCRIPTION:
+        return "description";
+    case NBD_INFO_BLOCK_SIZE:
+        return "block size";
+    default:
+        return "<unknown>";
+    }
+}
+
+
+const char *nbd_cmd_lookup(uint16_t cmd)
+{
+    switch (cmd) {
+    case NBD_CMD_READ:
+        return "read";
+    case NBD_CMD_WRITE:
+        return "write";
+    case NBD_CMD_DISC:
+        return "discard";
+    case NBD_CMD_FLUSH:
+        return "flush";
+    case NBD_CMD_TRIM:
+        return "trim";
+    case NBD_CMD_WRITE_ZEROES:
+        return "write zeroes";
+    default:
+        return "<unknown>";
+    }
+}
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index cf6ecbf..bf95601 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -57,12 +57,6 @@
 #define NBD_SET_TIMEOUT         _IO(0xab, 9)
 #define NBD_SET_FLAGS           _IO(0xab, 10)
 
-#define NBD_OPT_EXPORT_NAME     (1)
-#define NBD_OPT_ABORT           (2)
-#define NBD_OPT_LIST            (3)
-#define NBD_OPT_PEEK_EXPORT     (4)
-#define NBD_OPT_STARTTLS        (5)
-
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
  * but only a limited set of errno values is specified in the protocol.
  * Everything else is squashed to EINVAL.
@@ -133,6 +127,10 @@ struct NBDTLSHandshakeData {
 
 void nbd_tls_handshake(QIOTask *task,
                        void *opaque);
+const char *nbd_opt_lookup(uint32_t opt);
+const char *nbd_rep_lookup(uint32_t rep);
+const char *nbd_info_lookup(uint16_t info);
+const char *nbd_cmd_lookup(uint16_t info);
 
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
 
diff --git a/nbd/server.c b/nbd/server.c
index e15385b..27a0aab 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016 Red Hat, Inc.
+ *  Copyright (C) 2016-2017 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Server Side
@@ -139,7 +139,8 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
 {
     uint64_t magic;
 
-    trace_nbd_negotiate_send_rep_len(opt, type, len);
+    trace_nbd_negotiate_send_rep_len(opt, nbd_opt_lookup(opt),
+                                     type, nbd_rep_lookup(type), len);
 
     magic = cpu_to_be64(NBD_REP_MAGIC);
     if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
@@ -441,7 +442,8 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
         }
         length = be32_to_cpu(length);
 
-        trace_nbd_negotiate_options_check_option(option);
+        trace_nbd_negotiate_options_check_option(option,
+                                                 nbd_opt_lookup(option));
         if (client->tlscreds &&
             client->ioc == (QIOChannel *)client->sioc) {
             QIOChannel *tioc;
@@ -532,8 +534,8 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                                                  NBD_REP_ERR_UNSUP,
                                                  option, errp,
                                                  "Unsupported option 0x%"
-                                                 PRIx32,
-                                                 option);
+                                                 PRIx32 " (%s)", option,
+                                                 nbd_opt_lookup(option));
                 if (ret < 0) {
                     return ret;
                 }
@@ -549,7 +551,8 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 return nbd_negotiate_handle_export_name(client, length, errp);
 
             default:
-                error_setg(errp, "Unsupported option 0x%" PRIx32, option);
+                error_setg(errp, "Unsupported option 0x%" PRIx32 " (%s)",
+                           option, nbd_opt_lookup(option));
                 return -EINVAL;
             }
         }
@@ -1033,7 +1036,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         return -EIO;
     }
 
-    trace_nbd_co_receive_request_decode_type(request->handle, request->type);
+    trace_nbd_co_receive_request_decode_type(request->handle, request->type,
+                                             nbd_cmd_lookup(request->type));
 
     if (request->type != NBD_CMD_WRITE) {
         /* No payload, we are ready to read the next request.  */
diff --git a/nbd/trace-events b/nbd/trace-events
index c6f898e..5e2f961 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -1,8 +1,8 @@
 # nbd/client.c
 nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
-nbd_send_option_request(uint32_t opt, uint32_t len) "Sending option request %" PRIu32", len %" PRIu32
-nbd_receive_option_reply(uint32_t option, uint32_t type, uint32_t length) "Received option reply %" PRIx32", type %" PRIx32", len %" PRIu32
-nbd_reply_err_unsup(uint32_t option) "server doesn't understand request %" PRIx32 ", attempting fallback"
+nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
+nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIx32" (%s), type %" PRIx32" (%s), len %" PRIu32
+nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIx32 " (%s), attempting fallback"
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_request(void) "Requesting TLS from server"
@@ -28,7 +28,7 @@ nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, u
 nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"
 
 # nbd/server.c
-nbd_negotiate_send_rep_len(uint32_t opt, uint32_t type, uint32_t len) "Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32
+nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=%" PRIx32 " (%s), type=%" PRIx32 " (%s), len=%" PRIu32
 nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%s\""
 nbd_negotiate_send_rep_list(const char *name, const char *desc) "Advertising export name '%s' description '%s'"
 nbd_negotiate_handle_export_name(void) "Checking length"
@@ -39,7 +39,7 @@ nbd_negotiate_options_flags(void) "Checking client flags"
 nbd_negotiate_options_newstyle(void) "Client supports fixed newstyle handshake"
 nbd_negotiate_options_no_zeroes(void) "Client supports no zeroes at handshake end"
 nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
-nbd_negotiate_options_check_option(uint32_t option) "Checking option 0x%" PRIx32
+nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option 0x%" PRIx32 " (%s)"
 nbd_negotiate_begin(void) "Beginning negotiation"
 nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
@@ -49,7 +49,7 @@ nbd_send_reply(int32_t error, uint64_t handle) "Sending response to client: { .e
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
 nbd_co_send_reply(uint64_t handle, uint32_t error, int len) "Send reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d"
-nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16
+nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
 nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " byte(s)"
 nbd_trip(void) "Reading request"
-- 
1.8.3.1
