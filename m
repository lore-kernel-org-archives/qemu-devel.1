Received: from eggs.gnu.org ([2001:4830:134:3::10]:52197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGY-0000sP-9D
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGU-0006cK-VD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 12 Mar 2018 18:21:20 +0300
Message-Id: <20180312152126.286890-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180312152126.286890-1-vsementsov@virtuozzo.com>
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/8] nbd/server: add nbd_read_opt_name helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add helper to read name in format:

  uint32 len       (<= NBD_MAX_NAME_SIZE)
  len bytes string (not 0-terminated)

The helper would be reused in following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: splitted and changed a lot helper from larger patch of v1

 nbd/server.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index d163964cf9..085e14afbf 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -273,6 +273,47 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
     return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 1;
 }
 
+/* nbd_opt_read_name
+ *
+ * Read string in format:
+ *   uint32_t len     (<= NBD_MAX_NAME_SIZE)
+ *   len bytes string (not 0-terminated)
+ *
+ * @name should be enough to store NBD_MAX_NAME_SIZE+1.
+ * if @length is non-zero, it would be set to read string length.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
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
@@ -455,19 +496,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         2 bytes: N, number of requests (can be 0)
         N * 2 bytes: N requests
     */
-    rc = nbd_opt_read(client, &namelen, sizeof(namelen), errp);
-    if (rc <= 0) {
-        return rc;
-    }
-    be32_to_cpus(&namelen);
-    if (namelen >= sizeof(name)) {
-        return nbd_opt_invalid(client, errp, "name too long for qemu");
-    }
-    rc = nbd_opt_read(client, name, namelen, errp);
-    if (rc <= 0) {
-        return rc;
-    }
-    name[namelen] = '\0';
+    rc = nbd_opt_read_name(client, name, &namelen, errp);
     trace_nbd_negotiate_handle_export_name_request(name);
 
     rc = nbd_opt_read(client, &requests, sizeof(requests), errp);
-- 
2.11.1
