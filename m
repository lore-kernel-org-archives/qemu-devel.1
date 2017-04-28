Received: from eggs.gnu.org ([2001:4830:134:3::10]:38762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d44oj-00014e-4C
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d44oe-0001Cq-5C
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:16:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d44od-0001Bk-TC
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:16:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A448A08F6
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 12:16:02 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 28 Apr 2017 13:15:53 +0100
Message-Id: <20170428121553.22408-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] sockets: ensure we can bind to both ipv4 &
 ipv6 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When binding to an IPv6 socket we currently force the
IPV6_V6ONLY flag to off. This means that the IPv6 socket
will accept both IPv4 & IPv6 sockets when QEMU is launched
with something like

  -vnc :::1

While this is good for that case, it is bad for other
cases. For example if an empty hostname is given,
getaddrinfo resolves it to 2 addresses 0.0.0.0 and ::,
in that order. We will thus bind to 0.0.0.0 first, and
then fail to bind to :: on the same port. The same
problem can happen if any other hostname lookup causes
the IPv4 address to be reported before the IPv6 address.

When we get an IPv6 bind failure, we should re-try the
same port, but with IPV6_V6ONLY turned on again, to
avoid clash with any IPv4 listener.

This ensures that

  -vnc :1

will bind successfully to both 0.0.0.0 and ::, and also
avoid

  -vnc :1,to=2

from mistakenly using a 2nd port for the :: listener.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8188d9a..75d1e0f 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -207,22 +207,36 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
         }
 
         socket_set_fast_reuse(slisten);
-#ifdef IPV6_V6ONLY
-        if (e->ai_family == PF_INET6) {
-            /* listen on both ipv4 and ipv6 */
-            const int off = 0;
-            qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &off,
-                            sizeof(off));
-        }
-#endif
 
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
             inet_setport(e, p);
+#ifdef IPV6_V6ONLY
+            if (e->ai_family == PF_INET6) {
+                /* listen on both ipv4 and ipv6 */
+                const int off = 0;
+                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &off,
+                                sizeof(off));
+            }
+#endif
             if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
                 goto listen;
             }
+
+#ifdef IPV6_V6ONLY
+            if (e->ai_family == PF_INET6 && errno == EADDRINUSE) {
+                /* listen on only ipv6 */
+                const int on = 1;
+                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &on,
+                                sizeof(on));
+
+                if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
+                    goto listen;
+                }
+            }
+#endif
+
             if (p == port_max) {
                 if (!e->ai_next) {
                     error_setg_errno(errp, errno, "Failed to bind socket");
-- 
2.9.3
