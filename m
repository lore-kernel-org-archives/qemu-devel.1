Received: from eggs.gnu.org ([2001:4830:134:3::10]:50422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPU9-0006Et-9x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPU3-00065f-KB
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 17:08:20 -0600
Message-Id: <20180110230825.18321-2-eblake@redhat.com>
In-Reply-To: <20180110230825.18321-1-eblake@redhat.com>
References: <20180110230825.18321-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] nbd/server: Hoist nbd_reject_length()
 earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>

No semantic change, but will make it easier for an upcoming patch
to refactor code without having to add forward declarations.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 6cf2eeb2c1..d3b457c337 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -348,6 +348,34 @@ static int nbd_negotiate_send_info(NBDClient *client, uint32_t opt,
     return 0;
 }

+/* nbd_reject_length: Handle any unexpected payload.
+ * @fatal requests that we quit talking to the client, even if we are able
+ * to successfully send an error to the guest.
+ * Return:
+ * -errno  transmission error occurred or @fatal was requested, errp is set
+ * 0       error message successfully sent to client, errp is not set
+ */
+static int nbd_reject_length(NBDClient *client, uint32_t length,
+                             uint32_t option, bool fatal, Error **errp)
+{
+    int ret;
+
+    assert(length);
+    if (nbd_drop(client->ioc, length, errp) < 0) {
+        return -EIO;
+    }
+    ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID,
+                                     option, errp,
+                                     "option '%s' should have zero length",
+                                     nbd_opt_lookup(option));
+    if (fatal && !ret) {
+        error_setg(errp, "option '%s' should have zero length",
+                   nbd_opt_lookup(option));
+        return -EINVAL;
+    }
+    return ret;
+}
+
 /* Handle NBD_OPT_INFO and NBD_OPT_GO.
  * Return -errno on error, 0 if ready for next option, and 1 to move
  * into transmission phase.  */
@@ -570,34 +598,6 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     return QIO_CHANNEL(tioc);
 }

-/* nbd_reject_length: Handle any unexpected payload.
- * @fatal requests that we quit talking to the client, even if we are able
- * to successfully send an error to the guest.
- * Return:
- * -errno  transmission error occurred or @fatal was requested, errp is set
- * 0       error message successfully sent to client, errp is not set
- */
-static int nbd_reject_length(NBDClient *client, uint32_t length,
-                             uint32_t option, bool fatal, Error **errp)
-{
-    int ret;
-
-    assert(length);
-    if (nbd_drop(client->ioc, length, errp) < 0) {
-        return -EIO;
-    }
-    ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID,
-                                     option, errp,
-                                     "option '%s' should have zero length",
-                                     nbd_opt_lookup(option));
-    if (fatal && !ret) {
-        error_setg(errp, "option '%s' should have zero length",
-                   nbd_opt_lookup(option));
-        return -EINVAL;
-    }
-    return ret;
-}
-
 /* nbd_negotiate_options
  * Process all NBD_OPT_* client option commands, during fixed newstyle
  * negotiation.
-- 
2.14.3
