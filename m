Received: from eggs.gnu.org ([2001:4830:134:3::10]:34627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOh-0005Gk-0A
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOf-0008Um-F9
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:26 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:18 -0600
Message-Id: <20181215135324.152629-17-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/22] nbd/client: Split handshake into two
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

An upcoming patch will add the ability for qemu-nbd to list
the services provided by an NBD server.  Share the common
code of the TLS handshake by splitting the initial exchange
into a separate function, leaving only the export handling
in the original function.  Functionally, there should be no
change in behavior in this patch, although some of the code
motion may be difficult to follow due to indentation changes
(view with 'git diff -w' for a smaller changeset).

I considered an enum for the return code coordinating state
between the two functions, but in the end just settled with
ample comments.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v2: improve commit message, tweak code comment formatting
---
 nbd/client.c     | 144 +++++++++++++++++++++++++++++++----------------
 nbd/trace-events |   2 +-
 2 files changed, 95 insertions(+), 51 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 64a0e5760c3..8b0ae20fae8 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -806,21 +806,24 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
     }
 }

-int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
-                          const char *hostname, QIOChannel **outioc,
-                          NBDExportInfo *info, Error **errp)
+/*
+ * nbd_start_negotiate:
+ * Start the handshake to the server.  After a positive return, the server
+ * is ready to accept additional NBD_OPT requests.
+ * Returns: negative errno: failure talking to server
+ *          0: server is oldstyle, client must still parse export size
+ *          1: server is newstyle, but can only accept EXPORT_NAME
+ *          2: server is newstyle, but lacks structured replies
+ *          3: server is newstyle and set up for structured replies
+ */
+static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                               const char *hostname, QIOChannel **outioc,
+                               bool structured_reply, bool *zeroes,
+                               Error **errp)
 {
     uint64_t magic;
-    bool zeroes = true;
-    bool structured_reply = info->structured_reply;
-    bool base_allocation = info->base_allocation;

-    trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>");
-
-    assert(info->name);
-    trace_nbd_receive_negotiate_name(info->name);
-    info->structured_reply = false;
-    info->base_allocation = false;
+    trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");

     if (outioc) {
         *outioc = NULL;
@@ -865,7 +868,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             clientflags |= NBD_FLAG_C_FIXED_NEWSTYLE;
         }
         if (globalflags & NBD_FLAG_NO_ZEROES) {
-            zeroes = false;
+            *zeroes = false;
             clientflags |= NBD_FLAG_C_NO_ZEROES;
         }
         /* client requested flags */
@@ -887,7 +890,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             }
         }
         if (fixedNewStyle) {
-            int result;
+            int result = 0;

             if (structured_reply) {
                 result = nbd_request_simple_option(ioc,
@@ -896,39 +899,85 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                 if (result < 0) {
                     return -EINVAL;
                 }
-                info->structured_reply = result == 1;
             }
+            return 2 + result;
+        } else {
+            return 1;
+        }
+    } else if (magic == NBD_CLIENT_MAGIC) {
+        if (tlscreds) {
+            error_setg(errp, "Server does not support STARTTLS");
+            return -EINVAL;
+        }
+        return 0;
+    } else {
+        error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic);
+        return -EINVAL;
+    }
+}

-            if (info->structured_reply && base_allocation) {
-                result = nbd_negotiate_simple_meta_context(ioc, info, errp);
-                if (result < 0) {
-                    return -EINVAL;
-                }
-                info->base_allocation = result == 1;
-            }
+/*
+ * nbd_receive_negotiate:
+ * Connect to server, complete negotiation, and move into transmission phase.
+ * Returns: negative errno: failure talking to server
+ *          0: server is connected
+ */
+int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+                          const char *hostname, QIOChannel **outioc,
+                          NBDExportInfo *info, Error **errp)
+{
+    int result;
+    bool zeroes = true;
+    bool base_allocation = info->base_allocation;
+    uint32_t oldflags;
+
+    assert(info->name);
+    trace_nbd_receive_negotiate_name(info->name);
+
+    result = nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
+                                 info->structured_reply, &zeroes, errp);
+
+    info->structured_reply = false;
+    info->base_allocation = false;
+    if (tlscreds && *outioc) {
+        ioc = *outioc;
+    }

-            /* Try NBD_OPT_GO first - if it works, we are done (it
-             * also gives us a good message if the server requires
-             * TLS).  If it is not available, fall back to
-             * NBD_OPT_LIST for nicer error messages about a missing
-             * export, then use NBD_OPT_EXPORT_NAME.  */
-            result = nbd_opt_go(ioc, info, errp);
+    switch (result) {
+    case 3: /* newstyle, with structured replies */
+        info->structured_reply = true;
+        if (base_allocation) {
+            result = nbd_negotiate_simple_meta_context(ioc, info, errp);
             if (result < 0) {
                 return -EINVAL;
             }
-            if (result > 0) {
-                return 0;
-            }
-            /* Check our desired export is present in the
-             * server export list. Since NBD_OPT_EXPORT_NAME
-             * cannot return an error message, running this
-             * query gives us better error reporting if the
-             * export name is not available.
-             */
-            if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
-                return -EINVAL;
-            }
+            info->base_allocation = result == 1;
         }
+        /* fall through */
+    case 2: /* newstyle, try OPT_GO */
+        /* Try NBD_OPT_GO first - if it works, we are done (it
+         * also gives us a good message if the server requires
+         * TLS).  If it is not available, fall back to
+         * NBD_OPT_LIST for nicer error messages about a missing
+         * export, then use NBD_OPT_EXPORT_NAME.  */
+        result = nbd_opt_go(ioc, info, errp);
+        if (result < 0) {
+            return -EINVAL;
+        }
+        if (result > 0) {
+            return 0;
+        }
+        /* Check our desired export is present in the
+         * server export list. Since NBD_OPT_EXPORT_NAME
+         * cannot return an error message, running this
+         * query gives us better error reporting if the
+         * export name is not available.
+         */
+        if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
+            return -EINVAL;
+        }
+        /* fall through */
+    case 1: /* newstyle, but limited to EXPORT_NAME */
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
                                     errp) < 0) {
@@ -947,17 +996,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             return -EINVAL;
         }
         info->flags = be16_to_cpu(info->flags);
-    } else if (magic == NBD_CLIENT_MAGIC) {
-        uint32_t oldflags;
-
+        break;
+    case 0: /* oldstyle, parse length and flags */
         if (*info->name) {
             error_setg(errp, "Server does not support non-empty export names");
             return -EINVAL;
         }
-        if (tlscreds) {
-            error_setg(errp, "Server does not support STARTTLS");
-            return -EINVAL;
-        }

         if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
             error_prepend(errp, "Failed to read export length: ");
@@ -975,9 +1019,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             return -EINVAL;
         }
         info->flags = oldflags;
-    } else {
-        error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic);
-        return -EINVAL;
+        break;
+    default:
+        return result;
     }

     trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
diff --git a/nbd/trace-events b/nbd/trace-events
index 02956c96042..922b36d1843 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -13,7 +13,7 @@ nbd_receive_starttls_new_client(void) "Setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_opt_meta_request(const char *optname, const char *context, const char *export) "Requesting %s %s for export %s"
 nbd_opt_meta_reply(const char *optname, const char *context, uint32_t id) "Received %s mapping of %s to id %" PRIu32
-nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
+nbd_start_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are 0x%" PRIx32
 nbd_receive_negotiate_name(const char *name) "Requesting NBD export name '%s'"
-- 
2.17.2
