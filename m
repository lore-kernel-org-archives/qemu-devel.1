Received: from eggs.gnu.org ([2001:4830:134:3::10]:33931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8Z-0001N6-6w
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8U-0004mI-7q
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:11 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:36975 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eHS8T-0004k1-MR
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 22 Nov 2017 13:19:56 +0300
Message-Id: <20171122101958.17065-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-1-vsementsov@virtuozzo.com>
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/5] nbd/server: add helper nbd_opt_invalid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 74 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index c9445a89e9..79b937d88f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -199,20 +199,15 @@ static int nbd_negotiate_send_rep(NBDClient *client, uint32_t type,
     return nbd_negotiate_send_rep_len(client, type, 0, errp);
 }
 
-/* Send an error reply.
- * Return -errno on error, 0 on success. */
-static int GCC_FMT_ATTR(4, 5)
-nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
-                           Error **errp, const char *fmt, ...)
+static int GCC_FMT_ATTR(3, 0)
+nbd_negotiate_send_rep_err_v(NBDClient *client, uint32_t type,
+                             const char *fmt, va_list va, Error **errp)
 {
-    va_list va;
     char *msg;
     int ret;
     size_t len;
 
-    va_start(va, fmt);
     msg = g_strdup_vprintf(fmt, va);
-    va_end(va);
     len = strlen(msg);
     assert(len < 4096);
     trace_nbd_negotiate_send_rep_err(msg);
@@ -232,6 +227,43 @@ out:
     return ret;
 }
 
+static int GCC_FMT_ATTR(4, 5)
+nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
+                           Error **errp, const char *fmt, ...)
+{
+    va_list va;
+    int ret;
+
+    va_start(va, fmt);
+    ret = nbd_negotiate_send_rep_err_v(client, type, fmt, va, errp);
+    va_end(va);
+
+    return ret;
+}
+
+/* nbd_opt_invalid
+ * Drop reminded option data and reply with NBD_REP_ERR_INVALID
+ */
+static int nbd_opt_invalid(NBDClient *client,
+                          Error **errp, const char *fmt, ...)
+{
+    int ret;
+    va_list va;
+
+    if (client->optlen > 0) {
+        if (nbd_opt_drop(client, client->optlen, errp) < 0) {
+            return -EIO;
+        }
+    }
+
+    va_start(va, fmt);
+    ret = nbd_negotiate_send_rep_err_v(client, NBD_REP_ERR_INVALID,
+                                       fmt, va, errp);
+    va_end(va);
+
+    return ret;
+}
+
 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
@@ -384,7 +416,6 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     bool blocksize = false;
     uint32_t sizes[3];
     char buf[sizeof(uint64_t) + sizeof(uint16_t)];
-    const char *msg;
 
     /* Client sends:
         4 bytes: L, name length (can be 0)
@@ -393,8 +424,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         N * 2 bytes: N requests
     */
     if (client->optlen < sizeof(namelen) + sizeof(requests)) {
-        msg = "overall request too short";
-        goto invalid;
+        return nbd_opt_invalid(client, errp, "overall request too short");
     }
     if (nbd_opt_read(client, &namelen, sizeof(namelen), errp) < 0) {
         return -EIO;
@@ -403,8 +433,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     if (namelen > client->optlen - sizeof(requests) ||
         (client->optlen - namelen) % 2)
     {
-        msg = "name length is incorrect";
-        goto invalid;
+        return nbd_opt_invalid(client, errp, "name length is incorrect");
     }
     if (nbd_opt_read(client, name, namelen, errp) < 0) {
         return -EIO;
@@ -418,8 +447,8 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     be16_to_cpus(&requests);
     trace_nbd_negotiate_handle_info_requests(requests);
     if (requests != client->optlen / sizeof(request)) {
-        msg = "incorrect number of  requests for overall length";
-        goto invalid;
+        return nbd_opt_invalid(
+            client, errp, "incorrect number of requests for overall length");
     }
     while (requests--) {
         if (nbd_opt_read(client, &request, sizeof(request), errp) < 0) {
@@ -528,13 +557,6 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         rc = 1;
     }
     return rc;
-
- invalid:
-    if (nbd_opt_drop(client, client->optlen, errp) < 0) {
-        return -EIO;
-    }
-    return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID,
-                                      errp, "%s", msg);
 }
 
 
@@ -597,12 +619,8 @@ static int nbd_reject_length(NBDClient *client, bool fatal, Error **errp)
     int ret;
 
     assert(client->optlen);
-    if (nbd_drop(client->ioc, client->optlen, errp) < 0) {
-        return -EIO;
-    }
-    ret = nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID, errp,
-                                     "option '%s' should have zero length",
-                                     nbd_opt_lookup(client->opt));
+    ret = nbd_opt_invalid(client, errp, "option '%s' should have zero length",
+                         nbd_opt_lookup(client->opt));
     if (fatal && !ret) {
         error_setg(errp, "option '%s' should have zero length",
                    nbd_opt_lookup(client->opt));
-- 
2.11.1
