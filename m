Received: from eggs.gnu.org ([2001:4830:134:3::10]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqM5r-000453-26
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqM5p-0008Ow-M9
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 26 Feb 2018 10:57:23 -0600
Message-Id: <20180226165723.17818-3-eblake@redhat.com>
In-Reply-To: <20180226165723.17818-1-eblake@redhat.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<20180226165723.17818-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] nbd/client: fix error messages in
 nbd_handle_reply_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

1. NBD_REP_ERR_INVALID is not only about length, so, make message more
   general

2. hex format is not very good: it's hard to read something like
   "option a (set meta context)", so switch to dec.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1518702707-7077-6-git-send-email-vsementsov@virtuozzo.com>
[eblake: expand scope of patch: ALL uses of nbd_opt_lookup are now
decimal, all uses of nbd_rep_lookup are prefixed hex]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c     | 20 ++++++++++----------
 nbd/server.c     |  4 ++--
 nbd/trace-events |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 89f80f95905..756e110f895 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -180,22 +180,22 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
         goto cleanup;

     case NBD_REP_ERR_POLICY:
-        error_setg(errp, "Denied by server for option %" PRIx32 " (%s)",
+        error_setg(errp, "Denied by server for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;

     case NBD_REP_ERR_INVALID:
-        error_setg(errp, "Invalid data length for option %" PRIx32 " (%s)",
+        error_setg(errp, "Invalid parameters for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;

     case NBD_REP_ERR_PLATFORM:
-        error_setg(errp, "Server lacks support for option %" PRIx32 " (%s)",
+        error_setg(errp, "Server lacks support for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;

     case NBD_REP_ERR_TLS_REQD:
-        error_setg(errp, "TLS negotiation required before option %" PRIx32
+        error_setg(errp, "TLS negotiation required before option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;

@@ -204,17 +204,17 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
         break;

     case NBD_REP_ERR_SHUTDOWN:
-        error_setg(errp, "Server shutting down before option %" PRIx32 " (%s)",
+        error_setg(errp, "Server shutting down before option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;

     case NBD_REP_ERR_BLOCK_SIZE_REQD:
-        error_setg(errp, "Server requires INFO_BLOCK_SIZE for option %" PRIx32
+        error_setg(errp, "Server requires INFO_BLOCK_SIZE for option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;

     default:
-        error_setg(errp, "Unknown error code when asking for option %" PRIx32
+        error_setg(errp, "Unknown error code when asking for option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
     }
@@ -378,8 +378,8 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             return 1;
         }
         if (reply.type != NBD_REP_INFO) {
-            error_setg(errp, "unexpected reply type %" PRIx32
-                       " (%s), expected %x",
+            error_setg(errp, "unexpected reply type 0x%" PRIx32
+                       " (%s), expected 0x%x",
                        reply.type, nbd_rep_lookup(reply.type), NBD_REP_INFO);
             nbd_send_opt_abort(ioc);
             return -1;
@@ -534,7 +534,7 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error **errp)

     if (reply.type != NBD_REP_ACK) {
         error_setg(errp, "Server answered option %d (%s) with unexpected "
-                   "reply %" PRIx32 " (%s)", opt, nbd_opt_lookup(opt),
+                   "reply 0x%" PRIx32 " (%s)", opt, nbd_opt_lookup(opt),
                    reply.type, nbd_rep_lookup(reply.type));
         nbd_send_opt_abort(ioc);
         return -1;
diff --git a/nbd/server.c b/nbd/server.c
index 112e3f69dff..4990a5826e6 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -806,7 +806,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,

             default:
                 ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
-                                   "Unsupported option 0x%" PRIx32 " (%s)",
+                                   "Unsupported option %" PRIu32 " (%s)",
                                    option, nbd_opt_lookup(option));
                 break;
             }
@@ -822,7 +822,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                         errp);

             default:
-                error_setg(errp, "Unsupported option 0x%" PRIx32 " (%s)",
+                error_setg(errp, "Unsupported option %" PRIu32 " (%s)",
                            option, nbd_opt_lookup(option));
                 return -EINVAL;
             }
diff --git a/nbd/trace-events b/nbd/trace-events
index 2b8268ce8c3..ac19a366aac 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -1,7 +1,7 @@
 # nbd/client.c
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
-nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply 0x%" PRIx32" (%s), type 0x%" PRIx32" (%s), len %" PRIu32
-nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request 0x%" PRIx32 " (%s), attempting fallback"
+nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIu32" (%s), type 0x%" PRIx32" (%s), len %" PRIu32
+nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIu32 " (%s), attempting fallback"
 nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
@@ -33,7 +33,7 @@ nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *na
 nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"

 # nbd/server.c
-nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=0x%" PRIx32 " (%s), type=0x%" PRIx32 " (%s), len=%" PRIu32
+nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=%" PRIu32 " (%s), type=0x%" PRIx32 " (%s), len=%" PRIu32
 nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%s\""
 nbd_negotiate_send_rep_list(const char *name, const char *desc) "Advertising export name '%s' description '%s'"
 nbd_negotiate_handle_export_name(void) "Checking length"
@@ -46,7 +46,7 @@ nbd_negotiate_handle_starttls(void) "Setting up TLS"
 nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
 nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
 nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
-nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option 0x%" PRIx32 " (%s)"
+nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option %" PRIu32 " (%s)"
 nbd_negotiate_begin(void) "Beginning negotiation"
 nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
-- 
2.14.3
