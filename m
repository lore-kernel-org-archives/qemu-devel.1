Received: from eggs.gnu.org ([2001:4830:134:3::10]:56795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBjPP-0000ce-Bv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBjPM-0002cg-Ie
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:33:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBjPM-0002cS-7u
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:33:52 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon,  6 Nov 2017 15:33:41 +0000
Message-Id: <20171106153342.24147-2-berrange@redhat.com>
In-Reply-To: <20171106153342.24147-1-berrange@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/2] sockets: avoid leak of listen file
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

If we iterate over the full port range without successfully binding+listening
on the socket, we'll try the next address, whereupon we overwrite the slisten
file descriptor variable without closing it.

Rather than having two places where we open + close socket FDs on different
iterations of nested for loops, re-arrange the code to always open+close
within the same loop iteration.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b47fb45885..8b75541ce4 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -207,7 +207,7 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     char uaddr[INET6_ADDRSTRLEN+1];
     char uport[33];
     int rc, port_min, port_max, p;
-    int slisten = 0;
+    int slisten = -1;
     int saved_errno = 0;
     bool socket_created = false;
     Error *err = NULL;
@@ -267,31 +267,42 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
 		        uaddr,INET6_ADDRSTRLEN,uport,32,
 		        NI_NUMERICHOST | NI_NUMERICSERV);
 
-        slisten = create_fast_reuse_socket(e);
-        if (slisten < 0) {
-            continue;
-        }
-
-        socket_created = true;
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
             inet_setport(e, p);
-            rc = try_bind(slisten, saddr, e);
-            if (rc) {
-                if (errno == EADDRINUSE) {
+
+            slisten = create_fast_reuse_socket(e);
+            if (slisten < 0) {
+                /* First time we expect we might fail to create the socket
+                 * eg if 'e' has AF_INET6 but ipv6 kmod is not loaded.
+                 * Later iterations should always succeed if first iteration
+                 * worked though, so treat that as fatal.
+                 */
+                if (p == port_min) {
                     continue;
                 } else {
-                    error_setg_errno(errp, errno, "Failed to bind socket");
+                    error_setg_errno(errp, errno,
+                                     "Failed to recreate failed listening socket");
                     goto listen_failed;
                 }
             }
-            if (!listen(slisten, 1)) {
-                goto listen_ok;
-            }
-            if (errno != EADDRINUSE) {
-                error_setg_errno(errp, errno, "Failed to listen on socket");
-                goto listen_failed;
+            socket_created = true;
+
+            rc = try_bind(slisten, saddr, e);
+            if (rc < 0) {
+                if (errno != EADDRINUSE) {
+                    error_setg_errno(errp, errno, "Failed to bind socket");
+                    goto listen_failed;
+                }
+            } else {
+                if (!listen(slisten, 1)) {
+                    goto listen_ok;
+                }
+                if (errno != EADDRINUSE) {
+                    error_setg_errno(errp, errno, "Failed to listen on socket");
+                    goto listen_failed;
+                }
             }
             /* Someone else managed to bind to the same port and beat us
              * to listen on it! Socket semantics does not allow us to
@@ -299,12 +310,7 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
              * socket to allow bind attempts for subsequent ports:
              */
             closesocket(slisten);
-            slisten = create_fast_reuse_socket(e);
-            if (slisten < 0) {
-                error_setg_errno(errp, errno,
-                                 "Failed to recreate failed listening socket");
-                goto listen_failed;
-            }
+            slisten = -1;
         }
     }
     error_setg_errno(errp, errno,
-- 
2.13.6
