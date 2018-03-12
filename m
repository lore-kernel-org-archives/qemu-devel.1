Received: from eggs.gnu.org ([2001:4830:134:3::10]:52200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGY-0000sR-AN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGU-0006cF-U5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 12 Mar 2018 18:21:19 +0300
Message-Id: <20180312152126.286890-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180312152126.286890-1-vsementsov@virtuozzo.com>
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/8] nbd/server: add nbd_opt_invalid helper
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

NBD_REP_ERR_INVALID is often parameter to nbd_opt_drop and it would
be used more in following patches. So, let's add a helper.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

v2: add Eric's r-b

 nbd/server.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 2846ae46c5..d163964cf9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -218,22 +218,46 @@ nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
 /* Drop remainder of the current option, and send a reply with the
  * given error type and message. Return -errno on read or write
  * failure; or 0 if connection is still live. */
-static int GCC_FMT_ATTR(4, 5)
-nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
-             const char *fmt, ...)
+static int GCC_FMT_ATTR(4, 0)
+nbd_opt_vdrop(NBDClient *client, uint32_t type, Error **errp,
+              const char *fmt, va_list va)
 {
     int ret = nbd_drop(client->ioc, client->optlen, errp);
-    va_list va;
 
     client->optlen = 0;
     if (!ret) {
-        va_start(va, fmt);
         ret = nbd_negotiate_send_rep_verr(client, type, errp, fmt, va);
-        va_end(va);
     }
     return ret;
 }
 
+static int GCC_FMT_ATTR(4, 5)
+nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
+             const char *fmt, ...)
+{
+    int ret;
+    va_list va;
+
+    va_start(va, fmt);
+    ret = nbd_opt_vdrop(client, type, errp, fmt, va);
+    va_end(va);
+
+    return ret;
+}
+
+static int GCC_FMT_ATTR(3, 4)
+nbd_opt_invalid(NBDClient *client, Error **errp, const char *fmt, ...)
+{
+    int ret;
+    va_list va;
+
+    va_start(va, fmt);
+    ret = nbd_opt_vdrop(client, NBD_REP_ERR_INVALID, errp, fmt, va);
+    va_end(va);
+
+    return ret;
+}
+
 /* Read size bytes from the unparsed payload of the current option.
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
@@ -241,9 +265,9 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
                         Error **errp)
 {
     if (size > client->optlen) {
-        return nbd_opt_drop(client, NBD_REP_ERR_INVALID, errp,
-                            "Inconsistent lengths in option %s",
-                            nbd_opt_lookup(client->opt));
+        return nbd_opt_invalid(client, errp,
+                               "Inconsistent lengths in option %s",
+                               nbd_opt_lookup(client->opt));
     }
     client->optlen -= size;
     return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 1;
@@ -398,9 +422,8 @@ static int nbd_reject_length(NBDClient *client, bool fatal, Error **errp)
     int ret;
 
     assert(client->optlen);
-    ret = nbd_opt_drop(client, NBD_REP_ERR_INVALID, errp,
-                       "option '%s' has unexpected length",
-                       nbd_opt_lookup(client->opt));
+    ret = nbd_opt_invalid(client, errp, "option '%s' has unexpected length",
+                          nbd_opt_lookup(client->opt));
     if (fatal && !ret) {
         error_setg(errp, "option '%s' has unexpected length",
                    nbd_opt_lookup(client->opt));
@@ -438,8 +461,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
     }
     be32_to_cpus(&namelen);
     if (namelen >= sizeof(name)) {
-        return nbd_opt_drop(client, NBD_REP_ERR_INVALID, errp,
-                            "name too long for qemu");
+        return nbd_opt_invalid(client, errp, "name too long for qemu");
     }
     rc = nbd_opt_read(client, name, namelen, errp);
     if (rc <= 0) {
-- 
2.11.1
