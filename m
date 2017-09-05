Received: from eggs.gnu.org ([2001:4830:134:3::10]:41189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4F-0001Bi-3m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA49-0002jd-RV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpA49-0002ia-JS
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:41 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:22:26 +0100
Message-Id: <20170905092230.8243-6-berrange@redhat.com>
In-Reply-To: <20170905092230.8243-1-berrange@redhat.com>
References: <20170905092230.8243-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 5/9] sockets: Handle race condition between
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
 tests/Makefile.include |  2 +-
 util/qemu-sockets.c    | 58 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a231754517..eef4088d5c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -151,7 +151,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
-#check-unit-y += tests/test-listen$(EXESUF)
+check-unit-y += tests/test-listen$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d0d20476e5..6a511fbf76 100644
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
