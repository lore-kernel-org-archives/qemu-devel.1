Received: from eggs.gnu.org ([2001:4830:134:3::10]:53160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dJPS8-0007B5-4c
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dJPS4-0002ix-VR
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:20:12 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:27283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dJPS4-0002hE-Jy
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:20:08 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Fri,  9 Jun 2017 21:19:49 +0200
Message-Id: <c1871854a5510bdb24198d266c28788aa81d3f10.1497035841.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
References: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH 2/2] socket: Handle race condition between
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

This has been developed and tested by means of the
test-listen unit test in the previous commit.
Enable the test for make check now that it passes.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
---
 tests/Makefile.include |   2 +-
 util/qemu-sockets.c    | 106 +++++++++++++++++++++++++++++-------------
 2 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a492285..d8f3bde 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -127,7 +127,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
-#check-unit-y += tests/test-listen$(EXESUF)
+check-unit-y += tests/test-listen$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b39ae74..693c1ed 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -133,6 +133,64 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
     return PF_UNSPEC;
 }
 
+static int create_fast_reuse_socket(struct addrinfo *e, Error **errp)
+{
+    int slisten = qemu_socket(e->ai_family, e->ai_socktype, e->ai_protocol);
+    if (slisten < 0) {
+        if (!e->ai_next) {
+            error_setg_errno(errp, errno, "Failed to create socket");
+        }
+        return -1;
+    }
+
+    socket_set_fast_reuse(slisten);
+#ifdef IPV6_V6ONLY
+    if (e->ai_family == PF_INET6) {
+        /* listen on both ipv4 and ipv6 */
+        const int off = 0;
+        qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &off,
+                        sizeof(off));
+    }
+#endif
+    return slisten;
+}
+
+static int try_bind_listen(int *socket, struct addrinfo *e,
+                           int port, Error **errp)
+{
+    int s = *socket;
+    int ret;
+
+    inet_setport(e, port);
+    ret = bind(s, e->ai_addr, e->ai_addrlen);
+    if (ret) {
+        if (errno != EADDRINUSE) {
+            error_setg_errno(errp, errno, "Failed to bind socket");
+        }
+        return errno;
+    }
+    if (listen(s, 1) == 0) {
+            return 0;
+    }
+    if (errno == EADDRINUSE) {
+        /* We got to bind the socket to a port but someone else managed
+         * to bind to the same port and beat us to listen on it!
+         * Recreate the socket and return EADDRINUSE to preserve the
+         * expected state by the caller:
+         */
+        closesocket(s);
+        s = create_fast_reuse_socket(e, errp);
+        if (s < 0) {
+            return errno;
+        }
+        *socket = s;
+        errno = EADDRINUSE;
+        return errno;
+    }
+    error_setg_errno(errp, errno, "Failed to listen on socket");
+    return errno;
+}
+
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
                              bool update_addr,
@@ -143,6 +201,7 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     char uaddr[INET6_ADDRSTRLEN+1];
     char uport[33];
     int slisten, rc, port_min, port_max, p;
+    int saved_errno = 0;
     Error *err = NULL;
 
     memset(&ai,0, sizeof(ai));
@@ -194,54 +253,39 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
         return -1;
     }
 
-    /* create socket + bind */
+    /* create socket + bind/listen */
     for (e = res; e != NULL; e = e->ai_next) {
         getnameinfo((struct sockaddr*)e->ai_addr,e->ai_addrlen,
 		        uaddr,INET6_ADDRSTRLEN,uport,32,
 		        NI_NUMERICHOST | NI_NUMERICSERV);
-        slisten = qemu_socket(e->ai_family, e->ai_socktype, e->ai_protocol);
+
+        slisten = create_fast_reuse_socket(e, &err);
         if (slisten < 0) {
-            if (!e->ai_next) {
-                error_setg_errno(errp, errno, "Failed to create socket");
-            }
             continue;
         }
-
-        socket_set_fast_reuse(slisten);
-#ifdef IPV6_V6ONLY
-        if (e->ai_family == PF_INET6) {
-            /* listen on both ipv4 and ipv6 */
-            const int off = 0;
-            qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &off,
-                            sizeof(off));
-        }
-#endif
-
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
-            inet_setport(e, p);
-            if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
-                goto listen;
-            }
-            if (p == port_max) {
-                if (!e->ai_next) {
-                    error_setg_errno(errp, errno, "Failed to bind socket");
-                }
+            int eno = try_bind_listen(&slisten, e, p, &err);
+            if (!eno) {
+                goto listen_ok;
+            } else if (eno != EADDRINUSE) {
+                goto listen_failed;
             }
         }
+    }
+    error_setg_errno(errp, errno, "Failed to find available port");
+
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
