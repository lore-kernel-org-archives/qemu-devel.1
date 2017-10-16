Received: from eggs.gnu.org ([2001:4830:134:3::10]:44410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4Boz-0004cF-Tt
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4Boy-0000E9-M6
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4Boy-0000Dh-Dx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:08 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 16 Oct 2017 21:16:42 +0100
Message-Id: <20171016201650.18399-4-berrange@redhat.com>
In-Reply-To: <20171016201650.18399-1-berrange@redhat.com>
References: <20171016201650.18399-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 03/11] sockets: Handle race condition between
 binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Knut Omang <knut.omang@oracle.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Knut Omang <knut.omang@oracle.com>

If an offset of ports is specified to the inet_listen_saddr function(),
and two or more processes tries to bind from these ports at the same time,
occasionally more than one process may be able to bind to the same
port. The condition is detected by listen() but too late to avoid a failure.

This function is called by socket_listen() and used
by all socket listening code in QEMU, so all cases where any form of dynamic
port selection is used should be subject to this issue.

Add code to close and re-establish the socket when this
condition is observed, hiding the race condition from the user.

Also clean up some issues with error handling to allow more
accurate reporting of the cause of an error.

This has been developed and tested by means of the
test-listen unit test in the previous commit.
Enable the test for make check now that it passes.

Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 58 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 65f6dcd5ef..b47fb45885 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -206,7 +206,10 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     char port[33];
     char uaddr[INET6_ADDRSTRLEN+1];
     char uport[33];
-    int slisten, rc, port_min, port_max, p;
+    int rc, port_min, port_max, p;
+    int slisten = 0;
+    int saved_errno = 0;
+    bool socket_created = false;
     Error *err = NULL;
 
     memset(&ai,0, sizeof(ai));
@@ -258,7 +261,7 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
         return -1;
     }
 
-    /* create socket + bind */
+    /* create socket + bind/listen */
     for (e = res; e != NULL; e = e->ai_next) {
         getnameinfo((struct sockaddr*)e->ai_addr,e->ai_addrlen,
 		        uaddr,INET6_ADDRSTRLEN,uport,32,
@@ -266,37 +269,58 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
 
         slisten = create_fast_reuse_socket(e);
         if (slisten < 0) {
-            if (!e->ai_next) {
-                error_setg_errno(errp, errno, "Failed to create socket");
-            }
             continue;
         }
 
+        socket_created = true;
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
             inet_setport(e, p);
-            if (try_bind(slisten, saddr, e) >= 0) {
-                goto listen;
-            }
-            if (p == port_max) {
-                if (!e->ai_next) {
+            rc = try_bind(slisten, saddr, e);
+            if (rc) {
+                if (errno == EADDRINUSE) {
+                    continue;
+                } else {
                     error_setg_errno(errp, errno, "Failed to bind socket");
+                    goto listen_failed;
                 }
             }
+            if (!listen(slisten, 1)) {
+                goto listen_ok;
+            }
+            if (errno != EADDRINUSE) {
+                error_setg_errno(errp, errno, "Failed to listen on socket");
+                goto listen_failed;
+            }
+            /* Someone else managed to bind to the same port and beat us
+             * to listen on it! Socket semantics does not allow us to
+             * recover from this situation, so we need to recreate the
+             * socket to allow bind attempts for subsequent ports:
+             */
+            closesocket(slisten);
+            slisten = create_fast_reuse_socket(e);
+            if (slisten < 0) {
+                error_setg_errno(errp, errno,
+                                 "Failed to recreate failed listening socket");
+                goto listen_failed;
+            }
         }
+    }
+    error_setg_errno(errp, errno,
+                     socket_created ?
+                     "Failed to find an available port" :
+                     "Failed to create a socket");
+listen_failed:
+    saved_errno = errno;
+    if (slisten >= 0) {
         closesocket(slisten);
     }
     freeaddrinfo(res);
+    errno = saved_errno;
     return -1;
 
-listen:
-    if (listen(slisten,1) != 0) {
-        error_setg_errno(errp, errno, "Failed to listen on socket");
-        closesocket(slisten);
-        freeaddrinfo(res);
-        return -1;
-    }
+listen_ok:
     if (update_addr) {
         g_free(saddr->host);
         saddr->host = g_strdup(uaddr);
-- 
2.13.5
