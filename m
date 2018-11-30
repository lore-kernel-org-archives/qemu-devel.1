Received: from eggs.gnu.org ([2001:4830:134:3::10]:55995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtI-0004P0-To
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtH-0004Ff-7a
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:04 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:37 -0600
Message-Id: <20181130220344.3350618-9-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 08/14] nbd/client: Refactor nbd_receive_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Add some parameters to make this function reusable in upcoming
export listing, where we will want to capture the name and
description rather than compare against a user-supplied name.
No change in semantics to the existing caller.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 66 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 1dc8f83e19a..27785c55d0a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -232,18 +232,21 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
     return result;
 }

-/* Process another portion of the NBD_OPT_LIST reply.  Set *@match if
- * the current reply matches @want or if the server does not support
- * NBD_OPT_LIST, otherwise leave @match alone.  Return 0 if iteration
- * is complete, positive if more replies are expected, or negative
- * with @errp set if an unrecoverable error occurred. */
+/* Process another portion of the NBD_OPT_LIST reply.  If @want, then
+ * set *@match if the current reply matches @want or if the server
+ * does not support NBD_OPT_LIST, otherwise leave @match alone.
+ * Otherwise, @nameout and @description are malloc'd to contain
+ * NUL-terminated copies of the reply.  Return 0 if iteration is
+ * complete, positive if more replies are expected, or negative with
+ * @errp set if an unrecoverable error occurred. */
 static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
-                            Error **errp)
+                            char **nameout, char **description, Error **errp)
 {
     NBDOptionReply reply;
     uint32_t len;
     uint32_t namelen;
-    char name[NBD_MAX_NAME_SIZE + 1];
+    char array[NBD_MAX_NAME_SIZE + 1];
+    char *name = array;
     int error;

     if (nbd_receive_option_reply(ioc, NBD_OPT_LIST, &reply, errp) < 0) {
@@ -253,7 +256,12 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
     if (error <= 0) {
         /* The server did not support NBD_OPT_LIST, so set *match on
          * the assumption that any name will be accepted.  */
-        *match = true;
+        if (want) {
+            *match = true;
+        } else if (!error) {
+            error_setg(errp, "Server does not support export lists");
+            error = -1;
+        }
         return error;
     }
     len = reply.length;
@@ -290,30 +298,49 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    if (namelen != strlen(want)) {
-        if (nbd_drop(ioc, len, errp) < 0) {
-            error_prepend(errp,
-                          "failed to skip export name with wrong length: ");
-            nbd_send_opt_abort(ioc);
-            return -1;
+    if (want) {
+        if (namelen != strlen(want)) {
+            if (nbd_drop(ioc, len, errp) < 0) {
+                error_prepend(errp,
+                              "failed to skip export name with wrong length: ");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            return 1;
         }
-        return 1;
+        assert(namelen < sizeof(array));
+    } else {
+        assert(nameout);
+        *nameout = name = g_new(char, namelen + 1);
     }

-    assert(namelen < sizeof(name));
     if (nbd_read(ioc, name, namelen, errp) < 0) {
         error_prepend(errp, "failed to read export name: ");
         nbd_send_opt_abort(ioc);
+        if (!want) {
+            free(name);
+        }
         return -1;
     }
     name[namelen] = '\0';
     len -= namelen;
-    if (nbd_drop(ioc, len, errp) < 0) {
+    if (!want) {
+        assert(description);
+        *description = g_new(char, len + 1);
+        if (nbd_read(ioc, *description, len, errp) < 0) {
+            error_prepend(errp, "failed to read export description: ");
+            nbd_send_opt_abort(ioc);
+            free(name);
+            free(*description);
+            return -1;
+        }
+        (*description)[len] = '\0';
+    } else if (nbd_drop(ioc, len, errp) < 0) {
         error_prepend(errp, "failed to read export description: ");
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    if (!strcmp(name, want)) {
+    if (want && !strcmp(name, want)) {
         *match = true;
     }
     return 1;
@@ -498,7 +525,8 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
     }

     while (1) {
-        int ret = nbd_receive_list(ioc, wantname, &foundExport, errp);
+        int ret = nbd_receive_list(ioc, wantname, &foundExport,
+                                   NULL, NULL, errp);

         if (ret < 0) {
             /* Server gave unexpected reply */
-- 
2.17.2
