Received: from eggs.gnu.org ([2001:4830:134:3::10]:57435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defkW-0008Fy-Ot
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defkT-0005TO-PT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:04 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:40127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1defkT-0005Ss-GD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:01 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Mon,  7 Aug 2017 12:58:41 +0200
Message-Id: <1f1a0d6529309f4474102881e60f83aa7f88c525.1502103332.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.9aca98788e1a99635ffb85ab9c01cb0497d2b3d8.1502103332.git-series.knut.omang@oracle.com>
References: <cover.9aca98788e1a99635ffb85ab9c01cb0497d2b3d8.1502103332.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v7 3/4] sockets: factor out
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
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
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
