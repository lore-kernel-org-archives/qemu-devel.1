Received: from eggs.gnu.org ([2001:4830:134:3::10]:32798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dbZ8D-0003ZO-La
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 17:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dbZ88-0001OB-HB
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 17:18:41 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:34342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dbZ88-0001M1-7C
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 17:18:36 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Sat, 29 Jul 2017 23:18:17 +0200
Message-Id: <bd078365e3e6f990b8e436ed77b14daf3d26675c.1501362828.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
References: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v6 3/4] sockets: factor out
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

Another refactoring step to prepare for fixing the problem
exposed with the test-listen test in the previous commit

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 util/qemu-sockets.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b4a2f24..d0d2047 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -149,6 +149,16 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
     return PF_UNSPEC;
 }
 
+static int create_fast_reuse_socket(struct addrinfo *e)
+{
+    int slisten = qemu_socket(e->ai_family, e->ai_socktype, e->ai_protocol);
+    if (slisten < 0) {
+        return -1;
+    }
+    socket_set_fast_reuse(slisten);
+    return slisten;
+}
+
 static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
 {
 #ifndef IPV6_V6ONLY
@@ -253,7 +263,8 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
         getnameinfo((struct sockaddr*)e->ai_addr,e->ai_addrlen,
 		        uaddr,INET6_ADDRSTRLEN,uport,32,
 		        NI_NUMERICHOST | NI_NUMERICSERV);
-        slisten = qemu_socket(e->ai_family, e->ai_socktype, e->ai_protocol);
+
+        slisten = create_fast_reuse_socket(e);
         if (slisten < 0) {
             if (!e->ai_next) {
                 error_setg_errno(errp, errno, "Failed to create socket");
@@ -261,8 +272,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
             continue;
         }
 
-        socket_set_fast_reuse(slisten);
-
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
-- 
git-series 0.9.1
