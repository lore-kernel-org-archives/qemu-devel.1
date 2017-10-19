Received: from eggs.gnu.org ([2001:4830:134:3::10]:36140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5JHH-0005Fs-PL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5JHG-0004Kj-6S
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:26:59 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 19 Oct 2017 17:26:31 -0500
Message-Id: <20171019222637.17890-6-eblake@redhat.com>
In-Reply-To: <20171019222637.17890-1-eblake@redhat.com>
References: <20171019222637.17890-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/11] nbd/server: Refactor zero-length
 option check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, pbonzini@redhat.com, qemu-block@nongnu.org

Consolidate the check for a zero-length payload to an option
into a new function, nbd_check_zero_length(); this check will
also be used when introducing support for structured replies.

By sticking a catch-all check at the end of the loop for
processing options, we can simplify several of the intermediate
cases.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 76 +++++++++++++++++++++++++++---------------------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 05ff7470d5..b3f7e0b18e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -253,21 +253,10 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp,

 /* Process the NBD_OPT_LIST command, with a potential series of replies.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length,
-                                     Error **errp)
+static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
 {
     NBDExport *exp;

-    if (length) {
-        if (nbd_drop(client->ioc, length, errp) < 0) {
-            return -EIO;
-        }
-        return nbd_negotiate_send_rep_err(client->ioc,
-                                          NBD_REP_ERR_INVALID, NBD_OPT_LIST,
-                                          errp,
-                                          "OPT_LIST should not have length");
-    }
-
     /* For each export, send a NBD_REP_SERVER reply. */
     QTAILQ_FOREACH(exp, &exports, next) {
         if (nbd_negotiate_send_rep_list(client->ioc, exp, errp)) {
@@ -531,7 +520,6 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
 static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
-                                                 uint32_t length,
                                                  Error **errp)
 {
     QIOChannel *ioc;
@@ -540,15 +528,6 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,

     trace_nbd_negotiate_handle_starttls();
     ioc = client->ioc;
-    if (length) {
-        if (nbd_drop(ioc, length, errp) < 0) {
-            return NULL;
-        }
-        nbd_negotiate_send_rep_err(ioc, NBD_REP_ERR_INVALID, NBD_OPT_STARTTLS,
-                                   errp,
-                                   "OPT_STARTTLS should not have length");
-        return NULL;
-    }

     if (nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
                                NBD_OPT_STARTTLS, errp) < 0) {
@@ -584,6 +563,25 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     return QIO_CHANNEL(tioc);
 }

+/* nbd_check_zero_length: Handle any unexpected payload.
+ * Return:
+ * -errno  on error, errp is set
+ * 0       on successful negotiation, errp is not set
+ */
+static int nbd_check_zero_length(NBDClient *client, uint32_t length,
+                                 uint32_t option, Error **errp)
+{
+    if (!length) {
+        return 0;
+    }
+    if (nbd_drop(client->ioc, length, errp) < 0) {
+        return -EIO;
+    }
+    return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, option,
+                                      errp, "option %s should have zero length",
+                                      nbd_opt_lookup(option));
+}
+
 /* nbd_negotiate_options
  * Process all NBD_OPT_* client option commands, during fixed newstyle
  * negotiation.
@@ -674,7 +672,11 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
             }
             switch (option) {
             case NBD_OPT_STARTTLS:
-                tioc = nbd_negotiate_handle_starttls(client, length, errp);
+                ret = nbd_check_zero_length(client, length, option, errp);
+                if (ret < 0) {
+                    return ret;
+                }
+                tioc = nbd_negotiate_handle_starttls(client, errp);
                 if (!tioc) {
                     return -EIO;
                 }
@@ -698,9 +700,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                  "Option 0x%" PRIx32
                                                  "not permitted before TLS",
                                                  option);
-                if (ret < 0) {
-                    return ret;
-                }
                 /* Let the client keep trying, unless they asked to
                  * quit. In this mode, we've already sent an error, so
                  * we can't ack the abort.  */
@@ -712,9 +711,9 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
         } else if (fixedNewstyle) {
             switch (option) {
             case NBD_OPT_LIST:
-                ret = nbd_negotiate_handle_list(client, length, errp);
-                if (ret < 0) {
-                    return ret;
+                ret = nbd_check_zero_length(client, length, option, errp);
+                if (!ret) {
+                    ret = nbd_negotiate_handle_list(client, errp);
                 }
                 break;

@@ -738,16 +737,12 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                     assert(option == NBD_OPT_GO);
                     return 0;
                 }
-                if (ret) {
-                    return ret;
-                }
                 break;

             case NBD_OPT_STARTTLS:
-                if (nbd_drop(client->ioc, length, errp) < 0) {
-                    return -EIO;
-                }
-                if (client->tlscreds) {
+                if (length) {
+                    ret = nbd_check_zero_length(client, length, option, errp);
+                } else if (client->tlscreds) {
                     ret = nbd_negotiate_send_rep_err(client->ioc,
                                                      NBD_REP_ERR_INVALID,
                                                      option, errp,
@@ -758,9 +753,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                      option, errp,
                                                      "TLS not configured");
                 }
-                if (ret < 0) {
-                    return ret;
-                }
                 break;
             default:
                 if (nbd_drop(client->ioc, length, errp) < 0) {
@@ -772,9 +764,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                  "Unsupported option 0x%"
                                                  PRIx32 " (%s)", option,
                                                  nbd_opt_lookup(option));
-                if (ret < 0) {
-                    return ret;
-                }
                 break;
             }
         } else {
@@ -794,6 +783,9 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 return -EINVAL;
             }
         }
+        if (ret < 0) {
+            return ret;
+        }
     }
 }

-- 
2.13.6
