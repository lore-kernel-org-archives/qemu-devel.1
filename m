Received: from eggs.gnu.org ([2001:4830:134:3::10]:40809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q2-0005ZW-7H
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q0-0003Wm-RJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:10 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:46 -0600
Message-Id: <20170221024248.11027-7-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-1-eblake@redhat.com>
References: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 6/8] nbd: Implement NBD_OPT_GO on client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

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

---
v4: NBD protocol changes, again
v3: revamp to match latest version of NBD protocol
---
 nbd/nbd-internal.h |   3 ++
 nbd/client.c       | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index aa5b2fd..96c204b 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -56,8 +56,11 @@
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
diff --git a/nbd/client.c b/nbd/client.c
index f96539b..b408945 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -380,6 +380,118 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
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
+    TRACE("Attempting NBD_OPT_GO for export '%s'", wantname);
+    buf = g_malloc(2 + 4 + len + 1);
+    stw_be_p(buf, 0); /* No requests, live with whatever server sends */
+    stl_be_p(buf + 2, len);
+    memcpy(buf + 6, wantname, len);
+    if (nbd_send_option_request(ioc, NBD_OPT_GO, len + 6, buf, errp) < 0) {
+        return -1;
+    }
+
+    TRACE("Reading export info");
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
+            TRACE("export is good to go");
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
+        if (read_sync(ioc, &type, sizeof(type)) != sizeof(type)) {
+            error_setg(errp, "failed to read info type");
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
+            if (read_sync(ioc, &info->size, sizeof(info->size)) !=
+                sizeof(info->size)) {
+                error_setg(errp, "failed to read info size");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be64_to_cpus(&info->size);
+            if (read_sync(ioc, &info->flags, sizeof(info->flags)) !=
+                sizeof(info->flags)) {
+                error_setg(errp, "failed to read info flags");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be16_to_cpus(&info->flags);
+            TRACE("Size is %" PRIu64 ", export flags %" PRIx16,
+                  info->size, info->flags);
+            break;
+
+        default:
+            TRACE("ignoring unknown export info %" PRIu16 " (%s)", type,
+                  nbd_info_lookup(type));
+            if (drop_sync(ioc, len) != len) {
+                error_setg(errp, "Failed to read info payload");
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
@@ -574,11 +686,25 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
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
-- 
2.9.3
