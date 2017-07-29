Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dbZ8D-0003aJ-VO
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 17:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dbZ88-0001OG-HE
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 17:18:41 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:34337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dbZ88-0001Ky-6q
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 17:18:36 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Sat, 29 Jul 2017 23:18:16 +0200
Message-Id: <02163a5a845bfc6cd34089aa3d5c3585b0321261.1501362828.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
References: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v6 2/4] sockets: factor out a new try_bind()
 function
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

A refactoring step to prepare for the problem
exposed by the test-listen test in the previous commit.

Simplify and reorganize the IPv6 specific extra
measures and move it out of the for loop to increase
code readability. No semantic changes.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 69 ++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 1358c81..b4a2f24 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -149,6 +149,44 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
     return PF_UNSPEC;
 }
 
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
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
                              bool update_addr,
@@ -228,39 +266,10 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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
             inet_setport(e, p);
-#ifdef IPV6_V6ONLY
-        rebind:
-            if (e->ai_family == PF_INET6) {
-                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &v6only,
-                                sizeof(v6only));
-            }
-#endif
-            if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
+            if (try_bind(slisten, saddr, e) >= 0) {
                 goto listen;
             }
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
             if (p == port_max) {
                 if (!e->ai_next) {
                     error_setg_errno(errp, errno, "Failed to bind socket");
-- 
git-series 0.9.1
