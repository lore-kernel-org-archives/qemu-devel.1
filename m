Received: from eggs.gnu.org ([2001:4830:134:3::10]:41162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4D-00019p-A0
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA48-0002iJ-FU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpA48-0002hY-A2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:40 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:22:25 +0100
Message-Id: <20170905092230.8243-5-berrange@redhat.com>
In-Reply-To: <20170905092230.8243-1-berrange@redhat.com>
References: <20170905092230.8243-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 4/9] sockets: factor out
 create_fast_reuse_socket
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

Another refactoring step to prepare for fixing the problem
exposed with the test-listen test in the previous commit

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b4a2f243f4..d0d20476e5 100644
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
2.13.5
