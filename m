Received: from eggs.gnu.org ([2001:4830:134:3::10]:57448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defkZ-0008IU-Jr
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defkW-0005U9-JC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:07 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:41182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1defkW-0005To-8R
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:04 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Mon,  7 Aug 2017 12:58:42 +0200
Message-Id: <62d96e255f9fc084ba6a0e56bb05a84dbbceece5.1502103332.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.9aca98788e1a99635ffb85ab9c01cb0497d2b3d8.1502103332.git-series.knut.omang@oracle.com>
References: <cover.9aca98788e1a99635ffb85ab9c01cb0497d2b3d8.1502103332.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v7 4/4] sockets: Handle race condition between
 binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Knut Omang <knut.omang@oracle.com>

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
---
 tests/Makefile.include |  2 +-
 util/qemu-sockets.c    | 58 ++++++++++++++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b37c0c8..9d2131d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -128,7 +128,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
-#check-unit-y += tests/test-listen$(EXESUF)
+check-unit-y += tests/test-listen$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d0d2047..6a511fb 100644
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
git-series 0.9.1
