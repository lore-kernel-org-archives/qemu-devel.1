Received: from eggs.gnu.org ([2001:4830:134:3::10]:40826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q2-0005ZX-Oq
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q1-0003X8-29
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:10 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:44 -0600
Message-Id: <20170221024248.11027-5-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-1-eblake@redhat.com>
References: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/8] nbd: Expose and debug more NBD constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The NBD protocol has several constants defined in various extensions
that we are about to implement.  Expose them to the code, along with
an easy way to map various constants to strings during diagnostic
messages.

Doing this points out a debug message in server.c that got
parameters mixed up.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: new patch
---
 include/block/nbd.h | 34 +++++++++++++++++++-------
 nbd/nbd-internal.h  |  9 +++----
 nbd/client.c        | 56 ++++++++++++++++++++++++++++---------------
 nbd/common.c        | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 nbd/server.c        | 17 +++++++------
 5 files changed, 145 insertions(+), 40 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 8cc9cbe..c84e022 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016 Red Hat, Inc.
+ *  Copyright (C) 2016-2017 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -83,18 +83,36 @@ typedef struct NBDReply NBDReply;
 #define NBD_FLAG_C_FIXED_NEWSTYLE (1 << 0) /* Fixed newstyle protocol. */
 #define NBD_FLAG_C_NO_ZEROES      (1 << 1) /* End handshake without zeroes. */

-/* Reply types. */
+/* Option requests. */
+#define NBD_OPT_EXPORT_NAME     (1)
+#define NBD_OPT_ABORT           (2)
+#define NBD_OPT_LIST            (3)
+/* #define NBD_OPT_PEEK_EXPORT  (4) not in use */
+#define NBD_OPT_STARTTLS        (5)
+#define NBD_OPT_INFO            (6)
+#define NBD_OPT_GO              (7)
+
+/* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))

 #define NBD_REP_ACK             (1)             /* Data sending finished. */
 #define NBD_REP_SERVER          (2)             /* Export description. */
+#define NBD_REP_INFO            (3)             /* NBD_OPT_INFO/GO. */

-#define NBD_REP_ERR_UNSUP       NBD_REP_ERR(1)  /* Unknown option */
-#define NBD_REP_ERR_POLICY      NBD_REP_ERR(2)  /* Server denied */
-#define NBD_REP_ERR_INVALID     NBD_REP_ERR(3)  /* Invalid length */
-#define NBD_REP_ERR_PLATFORM    NBD_REP_ERR(4)  /* Not compiled in */
-#define NBD_REP_ERR_TLS_REQD    NBD_REP_ERR(5)  /* TLS required */
-#define NBD_REP_ERR_SHUTDOWN    NBD_REP_ERR(7)  /* Server shutting down */
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
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index f43d990..aa5b2fd 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -76,12 +76,6 @@
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
@@ -122,5 +116,8 @@ struct NBDTLSHandshakeData {

 void nbd_tls_handshake(QIOTask *task,
                        void *opaque);
+const char *nbd_opt_lookup(uint32_t opt);
+const char *nbd_rep_lookup(uint32_t rep);
+const char *nbd_info_lookup(uint16_t info);

 #endif
diff --git a/nbd/client.c b/nbd/client.c
index 69f0e09..f96539b 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016 Red Hat, Inc.
+ *  Copyright (C) 2016-2017 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -130,7 +130,8 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
     if (len == -1) {
         req.length = len = strlen(data);
     }
-    TRACE("Sending option request %" PRIu32", len %" PRIu32, opt, len);
+    TRACE("Sending option request %" PRIu32" (%s), len %" PRIu32, opt,
+          nbd_opt_lookup(opt), len);

     stq_be_p(&req.magic, NBD_OPTS_MAGIC);
     stl_be_p(&req.option, opt);
@@ -180,8 +181,10 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
     be32_to_cpus(&reply->type);
     be32_to_cpus(&reply->length);

-    TRACE("Received option reply %" PRIx32", type %" PRIx32", len %" PRIu32,
-          reply->option, reply->type, reply->length);
+    TRACE("Received option reply %" PRIx32" (%s), type %" PRIx32
+          " (%s), len %" PRIu32,
+          reply->option, nbd_opt_lookup(reply->option),
+          reply->type, nbd_rep_lookup(reply->type), reply->length);

     if (reply->magic != NBD_REP_MAGIC) {
         error_setg(errp, "Unexpected option reply magic");
@@ -215,12 +218,16 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,

     if (reply->length) {
         if (reply->length > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "server's error message is too long");
+            error_setg(errp, "server error 0x%" PRIx32
+                       " (%s) message is too long",
+                       reply->type, nbd_rep_lookup(reply->type));
             goto cleanup;
         }
         msg = g_malloc(reply->length + 1);
         if (read_sync(ioc, msg, reply->length) != reply->length) {
-            error_setg(errp, "failed to read option error message");
+            error_setg(errp, "failed to read option error 0x%" PRIx32
+                       " (%s) message",
+                       reply->type, nbd_rep_lookup(reply->type));
             goto cleanup;
         }
         msg[reply->length] = '\0';
@@ -229,38 +236,49 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
     switch (reply->type) {
     case NBD_REP_ERR_UNSUP:
         TRACE("server doesn't understand request %" PRIx32
-              ", attempting fallback", reply->option);
+              " (%s), attempting fallback",
+              reply->option, nbd_opt_lookup(reply->option));
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
index a5f39ea..85622f9 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -89,3 +89,72 @@ void nbd_tls_handshake(QIOTask *task,
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
diff --git a/nbd/server.c b/nbd/server.c
index efe5cb8..767ca0f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016 Red Hat, Inc.
+ *  Copyright (C) 2016-2017 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Server Side
@@ -206,8 +206,8 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
 {
     uint64_t magic;

-    TRACE("Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32,
-          type, opt, len);
+    TRACE("Reply opt=%" PRIx32 " (%s), type=%" PRIx32 " (%s), len=%" PRIu32,
+          opt, nbd_opt_lookup(opt), type, nbd_rep_lookup(type), len);

     magic = cpu_to_be64(NBD_REP_MAGIC);
     if (nbd_negotiate_write(ioc, &magic, sizeof(magic)) != sizeof(magic)) {
@@ -493,7 +493,8 @@ static int nbd_negotiate_options(NBDClient *client)
         }
         length = be32_to_cpu(length);

-        TRACE("Checking option 0x%" PRIx32, clientflags);
+        TRACE("Checking option 0x%" PRIx32 " (%s)", clientflags,
+              nbd_opt_lookup(clientflags));
         if (client->tlscreds &&
             client->ioc == (QIOChannel *)client->sioc) {
             QIOChannel *tioc;
@@ -581,8 +582,9 @@ static int nbd_negotiate_options(NBDClient *client)
                                                  NBD_REP_ERR_UNSUP,
                                                  clientflags,
                                                  "Unsupported option 0x%"
-                                                 PRIx32,
-                                                 clientflags);
+                                                 PRIx32 " (%s)",
+                                                 clientflags,
+                                                 nbd_opt_lookup(clientflags));
                 if (ret < 0) {
                     return ret;
                 }
@@ -598,7 +600,8 @@ static int nbd_negotiate_options(NBDClient *client)
                 return nbd_negotiate_handle_export_name(client, length);

             default:
-                TRACE("Unsupported option 0x%" PRIx32, clientflags);
+                TRACE("Unsupported option 0x%" PRIx32 " (%s)", clientflags,
+                      nbd_opt_lookup(clientflags));
                 return -EINVAL;
             }
         }
-- 
2.9.3
