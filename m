Received: from eggs.gnu.org ([2001:4830:134:3::10]:48658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCk-0001bD-SI
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCh-0005vc-Af
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38793
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCh-0005uP-3F
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EYVN065932
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:26 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmq0jb00j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:26 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:25 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:34 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-60-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 59/79] nbd: Fix regression on resiliency to
 port scan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Eric Blake <eblake@redhat.com>

Back in qemu 2.5, qemu-nbd was immune to port probes (a transient
server would not quit, regardless of how many probe connections
came and went, until a connection actually negotiated).  But we
broke that in commit ee7d7aa when removing the return value to
nbd_client_new(), although that patch also introduced a bug causing
an assertion failure on a client that fails negotiation.  We then
made it worse during refactoring in commit 1a6245a (a segfault
before we could even assert); the (masked) assertion was cleaned
up in d3780c2 (still in 2.6), and just recently we finally fixed
the segfault ("nbd: Fully intialize client in case of failed
negotiation").  But that still means that ever since we added
TLS support to qemu-nbd, we have been vulnerable to an ill-timed
port-scan being able to cause a denial of service by taking down
qemu-nbd before a real client has a chance to connect.

Since negotiation is now handled asynchronously via coroutines,
we no longer have a synchronous point of return by re-adding a
return value to nbd_client_new().  So this patch instead wires
things up to pass the negotiation status through the close_fn
callback function.

Simple test across two terminals:
$ qemu-nbd -f raw -p 30001 file
$ nmap 127.0.0.1 -p 30001 && \
  qemu-io -c 'r 0 512' -f raw nbd://localhost:30001

Note that this patch does not change what constitutes successful
negotiation (thus, a client must enter transmission phase before
that client can be considered as a reason to terminate the server
when the connection ends).  Perhaps we may want to tweak things
in a later patch to also treat a client that uses NBD_OPT_ABORT
as being a 'successful' negotiation (the client correctly talked
the NBD protocol, and informed us it was not going to use our
export after all), but that's a discussion for another day.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1451614

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170608222617.20376-1-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0c9390d978cbf61e8f16c9f580fa96b305c43568)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 blockdev-nbd.c      |  6 +++++-
 include/block/nbd.h |  2 +-
 nbd/server.c        | 24 +++++++++++++++---------
 qemu-nbd.c          |  4 ++--
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 8a11807..8d7284a 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -27,6 +27,10 @@ typedef struct NBDServerData {
 
 static NBDServerData *nbd_server;
 
+static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
+{
+    nbd_client_put(client);
+}
 
 static gboolean nbd_accept(QIOChannel *ioc, GIOCondition condition,
                            gpointer opaque)
@@ -46,7 +50,7 @@ static gboolean nbd_accept(QIOChannel *ioc, GIOCondition condition,
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
     nbd_client_new(NULL, cioc,
                    nbd_server->tlscreds, NULL,
-                   nbd_client_put);
+                   nbd_blockdev_client_closed);
     object_unref(OBJECT(cioc));
     return TRUE;
 }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3e373f0..b69c30d 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -160,7 +160,7 @@ void nbd_client_new(NBDExport *exp,
                     QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsaclname,
-                    void (*close)(NBDClient *));
+                    void (*close_fn)(NBDClient *, bool));
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
 
diff --git a/nbd/server.c b/nbd/server.c
index edfda84..a98bb21 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -81,7 +81,7 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
 
 struct NBDClient {
     int refcount;
-    void (*close)(NBDClient *client);
+    void (*close_fn)(NBDClient *client, bool negotiated);
 
     bool no_zeroes;
     NBDExport *exp;
@@ -796,7 +796,7 @@ void nbd_client_put(NBDClient *client)
     }
 }
 
-static void client_close(NBDClient *client)
+static void client_close(NBDClient *client, bool negotiated)
 {
     if (client->closing) {
         return;
@@ -811,8 +811,8 @@ static void client_close(NBDClient *client)
                          NULL);
 
     /* Also tell the client, so that they release their reference.  */
-    if (client->close) {
-        client->close(client);
+    if (client->close_fn) {
+        client->close_fn(client, negotiated);
     }
 }
 
@@ -993,7 +993,7 @@ void nbd_export_close(NBDExport *exp)
 
     nbd_export_get(exp);
     QTAILQ_FOREACH_SAFE(client, &exp->clients, next, next) {
-        client_close(client);
+        client_close(client, true);
     }
     nbd_export_set_name(exp, NULL);
     nbd_export_set_description(exp, NULL);
@@ -1355,7 +1355,7 @@ done:
 
 out:
     nbd_request_put(req);
-    client_close(client);
+    client_close(client, true);
     nbd_client_put(client);
 }
 
@@ -1381,7 +1381,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
     qemu_co_mutex_init(&client->send_lock);
 
     if (nbd_negotiate(data)) {
-        client_close(client);
+        client_close(client, false);
         goto out;
     }
 
@@ -1391,11 +1391,17 @@ out:
     g_free(data);
 }
 
+/*
+ * Create a new client listener on the given export @exp, using the
+ * given channel @sioc.  Begin servicing it in a coroutine.  When the
+ * connection closes, call @close_fn with an indication of whether the
+ * client completed negotiation.
+ */
 void nbd_client_new(NBDExport *exp,
                     QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsaclname,
-                    void (*close_fn)(NBDClient *))
+                    void (*close_fn)(NBDClient *, bool))
 {
     NBDClient *client;
     NBDClientNewData *data = g_new(NBDClientNewData, 1);
@@ -1412,7 +1418,7 @@ void nbd_client_new(NBDExport *exp,
     object_ref(OBJECT(client->sioc));
     client->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(client->ioc));
-    client->close = close_fn;
+    client->close_fn = close_fn;
 
     data->client = client;
     data->co = qemu_coroutine_create(nbd_co_client_start, data);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 14e7947..3b55ffa 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -335,10 +335,10 @@ static void nbd_export_closed(NBDExport *exp)
 
 static void nbd_update_server_watch(void);
 
-static void nbd_client_closed(NBDClient *client)
+static void nbd_client_closed(NBDClient *client, bool negotiated)
 {
     nb_fds--;
-    if (nb_fds == 0 && !persistent && state == RUNNING) {
+    if (negotiated && nb_fds == 0 && !persistent && state == RUNNING) {
         state = TERMINATE;
     }
     nbd_update_server_watch();
-- 
2.7.4
