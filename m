Received: from eggs.gnu.org ([2001:4830:134:3::10]:47321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUw-0007Of-1T
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUu-0000xG-MJ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:39 -0500
Message-Id: <20180313171345.659672-12-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 11/17] nbd/server: add nbd_read_opt_name helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add helper to read name in format:

  uint32 len       (<= NBD_MAX_NAME_SIZE)
  len bytes string (not 0-terminated)

The helper will be reused in following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180312152126.286890-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: grammar fixes, actually check error]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 53 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 01ea97afe98..280bdbb1040 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -273,6 +273,48 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
     return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 1;
 }

+/* nbd_opt_read_name
+ *
+ * Read a string with the format:
+ *   uint32_t len     (<= NBD_MAX_NAME_SIZE)
+ *   len bytes string (not 0-terminated)
+ *
+ * @name should be enough to store NBD_MAX_NAME_SIZE+1.
+ * If @length is non-null, it will be set to the actual string length.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success.
+ */
+static int nbd_opt_read_name(NBDClient *client, char *name, uint32_t *length,
+                             Error **errp)
+{
+    int ret;
+    uint32_t len;
+
+    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be32s(&len);
+
+    if (len > NBD_MAX_NAME_SIZE) {
+        return nbd_opt_invalid(client, errp,
+                               "Invalid name length: %" PRIu32, len);
+    }
+
+    ret = nbd_opt_read(client, name, len, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    name[len] = '\0';
+
+    if (length) {
+        *length = len;
+    }
+
+    return 1;
+}
+
 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
@@ -455,19 +497,10 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         2 bytes: N, number of requests (can be 0)
         N * 2 bytes: N requests
     */
-    rc = nbd_opt_read(client, &namelen, sizeof(namelen), errp);
+    rc = nbd_opt_read_name(client, name, &namelen, errp);
     if (rc <= 0) {
         return rc;
     }
-    be32_to_cpus(&namelen);
-    if (namelen >= sizeof(name)) {
-        return nbd_opt_invalid(client, errp, "name too long for qemu");
-    }
-    rc = nbd_opt_read(client, name, namelen, errp);
-    if (rc <= 0) {
-        return rc;
-    }
-    name[namelen] = '\0';
     trace_nbd_negotiate_handle_export_name_request(name);

     rc = nbd_opt_read(client, &requests, sizeof(requests), errp);
-- 
2.14.3
