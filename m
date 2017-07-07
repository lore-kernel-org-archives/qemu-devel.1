Received: from eggs.gnu.org ([2001:4830:134:3::10]:40397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCJ-0000sZ-DE
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCH-0001FY-Py
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2980 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTVCH-0001Cl-8h
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Jul 2017 18:29:16 +0300
Message-Id: <20170707152918.23086-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 08/10] nbd/server: rename clientflags var in
 nbd_negotiate_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Rename 'clientflags' to just 'option'. This variable has nothing to do
with flags, but is a single integer representing the option requested
by the client.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 1eeafccaca..c4d64fb3ad 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -415,7 +415,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
 
     while (1) {
         int ret;
-        uint32_t clientflags, length;
+        uint32_t option, length;
         uint64_t magic;
 
         if (nbd_read(client->ioc, &magic, sizeof(magic), errp) < 0) {
@@ -428,12 +428,12 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             return -EINVAL;
         }
 
-        if (nbd_read(client->ioc, &clientflags,
-                     sizeof(clientflags), errp) < 0) {
+        if (nbd_read(client->ioc, &option,
+                     sizeof(option), errp) < 0) {
             error_prepend(errp, "read failed: ");
             return -EINVAL;
         }
-        clientflags = be32_to_cpu(clientflags);
+        option = be32_to_cpu(option);
 
         if (nbd_read(client->ioc, &length, sizeof(length), errp) < 0) {
             error_prepend(errp, "read failed: ");
@@ -441,15 +441,15 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
         }
         length = be32_to_cpu(length);
 
-        TRACE("Checking option 0x%" PRIx32, clientflags);
+        TRACE("Checking option 0x%" PRIx32, option);
         if (client->tlscreds &&
             client->ioc == (QIOChannel *)client->sioc) {
             QIOChannel *tioc;
             if (!fixedNewstyle) {
-                error_setg(errp, "Unsupported option 0x%" PRIx32, clientflags);
+                error_setg(errp, "Unsupported option 0x%" PRIx32, option);
                 return -EINVAL;
             }
-            switch (clientflags) {
+            switch (option) {
             case NBD_OPT_STARTTLS:
                 tioc = nbd_negotiate_handle_starttls(client, length, errp);
                 if (!tioc) {
@@ -462,7 +462,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             case NBD_OPT_EXPORT_NAME:
                 /* No way to return an error to client, so drop connection */
                 error_setg(errp, "Option 0x%x not permitted before TLS",
-                           clientflags);
+                           option);
                 return -EINVAL;
 
             default:
@@ -471,21 +471,21 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_TLS_REQD,
-                                                 clientflags, errp,
+                                                 option, errp,
                                                  "Option 0x%" PRIx32
                                                  "not permitted before TLS",
-                                                 clientflags);
+                                                 option);
                 if (ret < 0) {
                     return ret;
                 }
                 /* Let the client keep trying, unless they asked to quit */
-                if (clientflags == NBD_OPT_ABORT) {
+                if (option == NBD_OPT_ABORT) {
                     return 1;
                 }
                 break;
             }
         } else if (fixedNewstyle) {
-            switch (clientflags) {
+            switch (option) {
             case NBD_OPT_LIST:
                 ret = nbd_negotiate_handle_list(client, length, errp);
                 if (ret < 0) {
@@ -497,7 +497,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 /* NBD spec says we must try to reply before
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
-                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clientflags,
+                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, option,
                                        &local_err);
 
                 if (local_err != NULL) {
@@ -518,12 +518,12 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 if (client->tlscreds) {
                     ret = nbd_negotiate_send_rep_err(client->ioc,
                                                      NBD_REP_ERR_INVALID,
-                                                     clientflags, errp,
+                                                     option, errp,
                                                      "TLS already enabled");
                 } else {
                     ret = nbd_negotiate_send_rep_err(client->ioc,
                                                      NBD_REP_ERR_POLICY,
-                                                     clientflags, errp,
+                                                     option, errp,
                                                      "TLS not configured");
                 }
                 if (ret < 0) {
@@ -536,10 +536,10 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_UNSUP,
-                                                 clientflags, errp,
+                                                 option, errp,
                                                  "Unsupported option 0x%"
                                                  PRIx32,
-                                                 clientflags);
+                                                 option);
                 if (ret < 0) {
                     return ret;
                 }
@@ -550,12 +550,12 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
              * If broken new-style we should drop the connection
              * for anything except NBD_OPT_EXPORT_NAME
              */
-            switch (clientflags) {
+            switch (option) {
             case NBD_OPT_EXPORT_NAME:
                 return nbd_negotiate_handle_export_name(client, length, errp);
 
             default:
-                error_setg(errp, "Unsupported option 0x%" PRIx32, clientflags);
+                error_setg(errp, "Unsupported option 0x%" PRIx32, option);
                 return -EINVAL;
             }
         }
-- 
2.11.1
