Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dOLsL-0006Ik-S7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dOLsI-0001SF-OJ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:31:41 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:28613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dOLsI-0001Rj-By
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:31:38 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Fri, 23 Jun 2017 12:31:06 +0200
Message-Id: <b107bc13f30e0b4a8ca8de1db178aef3fade9164.1498213152.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
References: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v4 2/4] sockets: factor out
 create_fast_reuse_socket
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

First refactoring step to prepare for fixing the problem
exposed with the test-listen test in the previous commit

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 util/qemu-sockets.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 852773d..699e36c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -149,6 +149,20 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
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
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
                              bool update_addr,
@@ -210,21 +224,17 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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
-- 
git-series 0.9.1
