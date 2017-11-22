Received: from eggs.gnu.org ([2001:4830:134:3::10]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8Z-0001N2-4j
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8U-0004lw-3y
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:11 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:28748 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eHS8T-0004jy-HI
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 22 Nov 2017 13:19:55 +0300
Message-Id: <20171122101958.17065-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-1-vsementsov@virtuozzo.com>
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/5] nbd/server: add nbd_opt_{read,
 drop} to track client->optlen
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
 nbd/server.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index bccc0274e7..c9445a89e9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -139,6 +139,19 @@ static void nbd_client_receive_next_request(NBDClient *client);
 
 */
 
+static inline int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
+                               Error **errp)
+{
+    client->optlen -= size;
+    return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 0;
+}
+
+static inline int nbd_opt_drop(NBDClient *client, size_t size, Error **errp)
+{
+    client->optlen -= size;
+    return nbd_drop(client->ioc, size, errp);
+}
+
 /* Send a reply header, including length, but no payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_len(NBDClient *client, uint32_t type,
@@ -299,7 +312,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client,
         error_setg(errp, "Bad length received");
         return -EINVAL;
     }
-    if (nbd_read(client->ioc, name, client->optlen, errp) < 0) {
+    if (nbd_opt_read(client, name, client->optlen, errp) < 0) {
         error_prepend(errp, "read failed: ");
         return -EINVAL;
     }
@@ -383,40 +396,36 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         msg = "overall request too short";
         goto invalid;
     }
-    if (nbd_read(client->ioc, &namelen, sizeof(namelen), errp) < 0) {
+    if (nbd_opt_read(client, &namelen, sizeof(namelen), errp) < 0) {
         return -EIO;
     }
     be32_to_cpus(&namelen);
-    client->optlen -= sizeof(namelen);
     if (namelen > client->optlen - sizeof(requests) ||
         (client->optlen - namelen) % 2)
     {
         msg = "name length is incorrect";
         goto invalid;
     }
-    if (nbd_read(client->ioc, name, namelen, errp) < 0) {
+    if (nbd_opt_read(client, name, namelen, errp) < 0) {
         return -EIO;
     }
     name[namelen] = '\0';
-    client->optlen -= namelen;
     trace_nbd_negotiate_handle_export_name_request(name);
 
-    if (nbd_read(client->ioc, &requests, sizeof(requests), errp) < 0) {
+    if (nbd_opt_read(client, &requests, sizeof(requests), errp) < 0) {
         return -EIO;
     }
     be16_to_cpus(&requests);
-    client->optlen -= sizeof(requests);
     trace_nbd_negotiate_handle_info_requests(requests);
     if (requests != client->optlen / sizeof(request)) {
         msg = "incorrect number of  requests for overall length";
         goto invalid;
     }
     while (requests--) {
-        if (nbd_read(client->ioc, &request, sizeof(request), errp) < 0) {
+        if (nbd_opt_read(client, &request, sizeof(request), errp) < 0) {
             return -EIO;
         }
         be16_to_cpus(&request);
-        client->optlen -= sizeof(request);
         trace_nbd_negotiate_handle_info_request(request,
                                                 nbd_info_lookup(request));
         /* We care about NBD_INFO_NAME and NBD_INFO_BLOCK_SIZE;
@@ -521,7 +530,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     return rc;
 
  invalid:
-    if (nbd_drop(client->ioc, client->optlen, errp) < 0) {
+    if (nbd_opt_drop(client, client->optlen, errp) < 0) {
         return -EIO;
     }
     return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_INVALID,
@@ -715,7 +724,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 return -EINVAL;
 
             default:
-                if (nbd_drop(client->ioc, length, errp) < 0) {
+                if (nbd_opt_drop(client, length, errp) < 0) {
                     return -EIO;
                 }
                 ret = nbd_negotiate_send_rep_err(client,
@@ -791,7 +800,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 break;
 
             default:
-                if (nbd_drop(client->ioc, length, errp) < 0) {
+                if (nbd_opt_drop(client, length, errp) < 0) {
                     return -EIO;
                 }
                 ret = nbd_negotiate_send_rep_err(client,
@@ -821,6 +830,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
         if (ret < 0) {
             return ret;
         }
+        assert(client->optlen == 0);
     }
 }
 
-- 
2.11.1
