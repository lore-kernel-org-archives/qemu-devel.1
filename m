Received: from eggs.gnu.org ([2001:4830:134:3::10]:60481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dOLsM-0006Ip-6v
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dOLsI-0001S5-4q
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:31:42 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:49479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dOLsH-0001Rd-Oc
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:31:38 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Fri, 23 Jun 2017 12:31:07 +0200
Message-Id: <7a233015767d404da2c3d6cd5aac9f9151aed878.1498213152.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
References: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v4 3/4] sockets: factor out a new try_bind()
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

Another refactoring step to prepare for the problem
exposed by the test-listen test.

This time simplify and reorganize the IPv6 specific extra
measures and move it out of the for loop to increase
code readability. No semantic changes.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 util/qemu-sockets.c | 69 ++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 699e36c..48b9319 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -163,6 +163,44 @@ static int create_fast_reuse_socket(struct addrinfo *e, Error **errp)
     return slisten;
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
@@ -238,39 +276,10 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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
