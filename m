Received: from eggs.gnu.org ([2001:4830:134:3::10]:40336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCH-0000sB-8h
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCE-0001C5-1b
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:33 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23511 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTVCD-0001AQ-MQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Jul 2017 18:29:09 +0300
Message-Id: <20170707152918.23086-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 01/10] nbd/server: nbd_negotiate: return 1
 on NBD_OPT_ABORT
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

Separate the case when a client sends NBD_OPT_ABORT from all other
errors. It will be needed for the following patch, where errors will be
reported.
This particular case is not actually an error - it honestly follows the
NBD protocol. Therefore it should not be reported like an error.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 8a70c054a6..3963972337 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -349,9 +349,13 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     return QIO_CHANNEL(tioc);
 }
 
-
-/* Process all NBD_OPT_* client option commands.
- * Return -errno on error, 0 on success. */
+/* nbd_negotiate_options
+ * Process all NBD_OPT_* client option commands.
+ * Return:
+ * -errno  on error
+ * 0       on successful negotiation
+ * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect
+ */
 static int nbd_negotiate_options(NBDClient *client)
 {
     uint32_t flags;
@@ -459,7 +463,7 @@ static int nbd_negotiate_options(NBDClient *client)
                 }
                 /* Let the client keep trying, unless they asked to quit */
                 if (clientflags == NBD_OPT_ABORT) {
-                    return -EINVAL;
+                    return 1;
                 }
                 break;
             }
@@ -477,7 +481,7 @@ static int nbd_negotiate_options(NBDClient *client)
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
                 nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clientflags);
-                return -EINVAL;
+                return 1;
 
             case NBD_OPT_EXPORT_NAME:
                 return nbd_negotiate_handle_export_name(client, length);
@@ -533,6 +537,12 @@ static int nbd_negotiate_options(NBDClient *client)
     }
 }
 
+/* nbd_negotiate
+ * Return:
+ * -errno  on error
+ * 0       on successful negotiation
+ * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect
+ */
 static coroutine_fn int nbd_negotiate(NBDClient *client)
 {
     char buf[8 + 8 + 8 + 128];
-- 
2.11.1
