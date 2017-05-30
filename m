Received: from eggs.gnu.org ([2001:4830:134:3::10]:54298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005QB-1v
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAl-0000Oi-SS
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:48695 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000NX-6O
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:30:59 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:47 +0300
Message-Id: <20170530143052.165002-15-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 14/19] nbd/server: nbd_negotiate: return 1 on
 NBD_OPT_ABORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Separate case when client sent NBD_OPT_ABORT from other errors.
It will be needed for the following patch, where errors will be
reported.
Considered case is not actually the error - it honestly follows NBD
protocol. Therefore it should not be reported like an error.
-EPIPE case means client not read server reply on NBD_OPT_ABORT,
which is also OK.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 30dfb81a5c..0e53d3dd91 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -369,9 +369,13 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     return QIO_CHANNEL(tioc);
 }
 
-
-/* Process all NBD_OPT_* client option commands.
- * Return -errno on error, 0 on success. */
+/* nbd_negotiate_options
+ * Process all NBD_OPT_* client option commands.
+ * Return:
+ * < 0 on error
+ * 0   on successful negotiation
+ * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect
+ */
 static int nbd_negotiate_options(NBDClient *client)
 {
     int ret;
@@ -483,7 +487,7 @@ static int nbd_negotiate_options(NBDClient *client)
                 }
                 /* Let the client keep trying, unless they asked to quit */
                 if (clientflags == NBD_OPT_ABORT) {
-                    return -EINVAL;
+                    return 1;
                 }
                 break;
             }
@@ -502,7 +506,7 @@ static int nbd_negotiate_options(NBDClient *client)
                  * guests that don't wait for our reply. */
                 ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
                                              clientflags);
-                return ret < 0 ? ret : -EINVAL;
+                return ret < 0 && ret != -EPIPE ? ret : 1;
 
             case NBD_OPT_EXPORT_NAME:
                 return nbd_negotiate_handle_export_name(client, length);
@@ -560,6 +564,12 @@ static int nbd_negotiate_options(NBDClient *client)
     }
 }
 
+/* nbd_negotiate
+ * Return:
+ * < 0 on error
+ * 0   on successful negotiation
+ * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect
+ */
 static coroutine_fn int nbd_negotiate(NBDClient *client)
 {
     char buf[8 + 8 + 8 + 128];
-- 
2.11.1
