Received: from eggs.gnu.org ([2001:4830:134:3::10]:52011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4m-0002Do-IV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4i-0004TR-8K
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4h-0004Si-UA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id u23so5459639wma.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:30 +0200
Message-Id: <1499955874-10954-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/41] nbd: Implement NBD_OPT_GO on client
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

NBD_OPT_EXPORT_NAME is lousy: per the NBD protocol, any failure
requires the server to close the connection rather than report an
error to us.  Therefore, upstream NBD recently added NBD_OPT_GO as
the improved version of the option that does what we want [1]: it
reports sane errors on failures, and on success provides at least
as much info as NBD_OPT_EXPORT_NAME.

[1] https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md

This is a first cut at use of the information types.  Note that we
do not need to use NBD_OPT_INFO, and that use of NBD_OPT_GO means
we no longer have to use NBD_OPT_LIST to learn whether a server
requires TLS (this requires servers that gracefully handle unknown
NBD_OPT, many servers prior to qemu 2.5 were buggy, but I have patched
qemu, upstream nbd, and nbdkit in the meantime, in part because of
interoperability testing with this patch).  We still fall back to
NBD_OPT_LIST when NBD_OPT_GO is not supported on the server, as it
is still one last chance for a nicer error message.  Later patches
will use further info, like NBD_INFO_BLOCK_SIZE.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707203049.534-8-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/client.c       | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 nbd/nbd-internal.h |   3 ++
 nbd/trace-events   |   3 ++
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index a443e51..1e98ca9 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -350,6 +350,114 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
 }
 
 
+/* Returns -1 if NBD_OPT_GO proves the export @wantname cannot be
+ * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
+ * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
+ * go (with @info populated). */
+static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
+                      NBDExportInfo *info, Error **errp)
+{
+    nbd_opt_reply reply;
+    uint32_t len = strlen(wantname);
+    uint16_t type;
+    int error;
+    char *buf;
+
+    /* The protocol requires that the server send NBD_INFO_EXPORT with
+     * a non-zero flags (at least NBD_FLAG_HAS_FLAGS must be set); so
+     * flags still 0 is a witness of a broken server. */
+    info->flags = 0;
+
+    trace_nbd_opt_go_start(wantname);
+    buf = g_malloc(4 + len + 2 + 1);
+    stl_be_p(buf, len);
+    memcpy(buf + 4, wantname, len);
+    /* No requests, live with whatever server sends */
+    stw_be_p(buf + 4 + len, 0);
+    if (nbd_send_option_request(ioc, NBD_OPT_GO, len + 6, buf, errp) < 0) {
+        return -1;
+    }
+
+    while (1) {
+        if (nbd_receive_option_reply(ioc, NBD_OPT_GO, &reply, errp) < 0) {
+            return -1;
+        }
+        error = nbd_handle_reply_err(ioc, &reply, errp);
+        if (error <= 0) {
+            return error;
+        }
+        len = reply.length;
+
+        if (reply.type == NBD_REP_ACK) {
+            /* Server is done sending info and moved into transmission
+               phase, but make sure it sent flags */
+            if (len) {
+                error_setg(errp, "server sent invalid NBD_REP_ACK");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (!info->flags) {
+                error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            trace_nbd_opt_go_success();
+            return 1;
+        }
+        if (reply.type != NBD_REP_INFO) {
+            error_setg(errp, "unexpected reply type %" PRIx32 ", expected %x",
+                       reply.type, NBD_REP_INFO);
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
+        if (len < sizeof(type)) {
+            error_setg(errp, "NBD_REP_INFO length %" PRIu32 " is too short",
+                       len);
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
+        if (nbd_read(ioc, &type, sizeof(type), errp) < 0) {
+            error_prepend(errp, "failed to read info type");
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
+        len -= sizeof(type);
+        be16_to_cpus(&type);
+        switch (type) {
+        case NBD_INFO_EXPORT:
+            if (len != sizeof(info->size) + sizeof(info->flags)) {
+                error_setg(errp, "remaining export info len %" PRIu32
+                           " is unexpected size", len);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
+                error_prepend(errp, "failed to read info size");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be64_to_cpus(&info->size);
+            if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
+                error_prepend(errp, "failed to read info flags");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be16_to_cpus(&info->flags);
+            trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
+            break;
+
+        default:
+            trace_nbd_opt_go_info_unknown(type, nbd_info_lookup(type));
+            if (nbd_drop(ioc, len, errp) < 0) {
+                error_prepend(errp, "Failed to read info payload");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            break;
+        }
+    }
+}
+
 /* Return -1 on failure, 0 if wantname is an available export. */
 static int nbd_receive_query_exports(QIOChannel *ioc,
                                      const char *wantname,
@@ -531,11 +639,25 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
             name = "";
         }
         if (fixedNewStyle) {
+            int result;
+
+            /* Try NBD_OPT_GO first - if it works, we are done (it
+             * also gives us a good message if the server requires
+             * TLS).  If it is not available, fall back to
+             * NBD_OPT_LIST for nicer error messages about a missing
+             * export, then use NBD_OPT_EXPORT_NAME.  */
+            result = nbd_opt_go(ioc, name, info, errp);
+            if (result < 0) {
+                goto fail;
+            }
+            if (result > 0) {
+                return 0;
+            }
             /* Check our desired export is present in the
              * server export list. Since NBD_OPT_EXPORT_NAME
              * cannot return an error message, running this
-             * query gives us good error reporting if the
-             * server required TLS
+             * query gives us better error reporting if the
+             * export name is not available.
              */
             if (nbd_receive_query_exports(ioc, name, errp) < 0) {
                 goto fail;
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index bf95601..4065bc6 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -37,8 +37,11 @@
  * https://github.com/yoe/nbd/blob/master/doc/proto.md
  */
 
+/* Size of all NBD_OPT_*, without payload */
 #define NBD_REQUEST_SIZE        (4 + 2 + 2 + 8 + 8 + 4)
+/* Size of all NBD_REP_* sent in answer to most NBD_OPT_*, without payload */
 #define NBD_REPLY_SIZE          (4 + 4 + 8)
+
 #define NBD_REQUEST_MAGIC       0x25609513
 #define NBD_REPLY_MAGIC         0x67446698
 #define NBD_OPTS_MAGIC          0x49484156454F5054LL
diff --git a/nbd/trace-events b/nbd/trace-events
index 5230c61..bd09fab 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -3,6 +3,9 @@ nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIx32" (%s), type %" PRIx32" (%s), len %" PRIu32
 nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIx32 " (%s), attempting fallback"
+nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
+nbd_opt_go_success(void) "Export is good to go"
+nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_request(void) "Requesting TLS from server"
-- 
1.8.3.1
