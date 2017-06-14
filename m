Received: from eggs.gnu.org ([2001:4830:134:3::10]:42230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dLBYX-0006lE-VI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dLBYU-0008Qh-Qm
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:54:10 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dLBYU-0008QQ-Dg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:54:06 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Wed, 14 Jun 2017 18:53:52 +0200
Message-Id: <a4d75d4de785ee9be7bd24e8a74f5cf3c46dd1a0.1497458933.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.121ea9b14e06a8c4e19f8a16ed6e963e8310c301.1497458933.git-series.knut.omang@oracle.com>
References: <cover.121ea9b14e06a8c4e19f8a16ed6e963e8310c301.1497458933.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v3 2/2] sockets: Handle race condition between
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
 util/qemu-sockets.c    | 159 ++++++++++++++++++++++++++++--------------
 2 files changed, 108 insertions(+), 53 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 22bb97e..c38f94e 100644
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
index 852773d..7b118b4 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -149,6 +149,94 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
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
+    return slisten;
+}
+
+static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
+{
+#ifndef IPV6_V6ONLY
+    return bind(socket, e->ai_addr, e->ai_addrlen);
+#else
+    /*
+     * Deals with first & last cases in matrix in comment
+     * for inet_ai_family_from_address().
+     */
+    int v6only =
+        ((!saddr->has_ipv4 && !saddr->has_ipv6) ||
+         (saddr->has_ipv4 && saddr->ipv4 &&
+          saddr->has_ipv6 && saddr->ipv6)) ? 0 : 1;
+    int stat;
+
+ rebind:
+    if (e->ai_family == PF_INET6) {
+        qemu_setsockopt(socket, IPPROTO_IPV6, IPV6_V6ONLY, &v6only,
+                        sizeof(v6only));
+    }
+
+    stat = bind(socket, e->ai_addr, e->ai_addrlen);
+    if (!stat) {
+        return 0;
+    }
+
+    /* If we got EADDRINUSE from an IPv6 bind & v6only is unset,
+     * it could be that the IPv4 port is already claimed, so retry
+     * with v6only set
+     */
+    if (e->ai_family == PF_INET6 && errno == EADDRINUSE && !v6only) {
+        v6only = 1;
+        goto rebind;
+    }
+    return stat;
+#endif
+}
+
+static int try_bind_listen(int *socket, InetSocketAddress *saddr,
+                           struct addrinfo *e, int port, Error **errp)
+{
+    int s = *socket;
+    int ret;
+
+    inet_setport(e, port);
+    ret = try_bind(s, saddr, e);
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
@@ -158,7 +246,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     char port[33];
     char uaddr[INET6_ADDRSTRLEN+1];
     char uport[33];
-    int slisten, rc, port_min, port_max, p;
+    int rc, port_min, port_max, p;
+    int slisten = 0;
+    int saved_errno = 0;
     Error *err = NULL;
 
     memset(&ai,0, sizeof(ai));
@@ -210,75 +300,40 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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
 
-        socket_set_fast_reuse(slisten);
-
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
-#ifdef IPV6_V6ONLY
-            /*
-             * Deals with first & last cases in matrix in comment
-             * for inet_ai_family_from_address().
-             */
-            int v6only =
-                ((!saddr->has_ipv4 && !saddr->has_ipv6) ||
-                 (saddr->has_ipv4 && saddr->ipv4 &&
-                  saddr->has_ipv6 && saddr->ipv6)) ? 0 : 1;
-#endif
-            inet_setport(e, p);
-#ifdef IPV6_V6ONLY
-        rebind:
-            if (e->ai_family == PF_INET6) {
-                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &v6only,
-                                sizeof(v6only));
-            }
-#endif
-            if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
-                goto listen;
-            }
-
-#ifdef IPV6_V6ONLY
-            /* If we got EADDRINUSE from an IPv6 bind & V6ONLY is unset,
-             * it could be that the IPv4 port is already claimed, so retry
-             * with V6ONLY set
-             */
-            if (e->ai_family == PF_INET6 && errno == EADDRINUSE && !v6only) {
-                v6only = 1;
-                goto rebind;
-            }
-#endif
-
-            if (p == port_max) {
-                if (!e->ai_next) {
-                    error_setg_errno(errp, errno, "Failed to bind socket");
-                }
+            int eno = try_bind_listen(&slisten, saddr, e, p, &err);
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
