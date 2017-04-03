Received: from eggs.gnu.org ([2001:4830:134:3::10]:54999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5cy-0000QH-JA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5cx-0003kS-7l
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cv5cx-0003jy-3I
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:51 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  3 Apr 2017 18:18:41 +0100
Message-Id: <20170403171843.3363-4-dgilbert@redhat.com>
In-Reply-To: <20170403171843.3363-1-dgilbert@redhat.com>
References: <20170403171843.3363-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v5 3/5] slirp: Common lhost/fhost union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@gnu.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The socket structure has a pair of unions for lhost and fhost
addresses; the unions are identical so split them out into
a separate union declaration.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 slirp/socket.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/slirp/socket.h b/slirp/socket.h
index 8feed2a..c1be77e 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -15,6 +15,12 @@
  * Our socket structure
  */
 
+union slirp_sockaddr {
+    struct sockaddr_storage ss;
+    struct sockaddr_in sin;
+    struct sockaddr_in6 sin6;
+};
+
 struct socket {
   struct socket *so_next,*so_prev;      /* For a linked list of sockets */
 
@@ -31,22 +37,14 @@ struct socket {
   struct tcpiphdr *so_ti;	   /* Pointer to the original ti within
 				    * so_mconn, for non-blocking connections */
   int so_urgc;
-  union {   /* foreign host */
-      struct sockaddr_storage ss;
-      struct sockaddr_in sin;
-      struct sockaddr_in6 sin6;
-  } fhost;
+  union slirp_sockaddr fhost;      /* Foreign host */
 #define so_faddr fhost.sin.sin_addr
 #define so_fport fhost.sin.sin_port
 #define so_faddr6 fhost.sin6.sin6_addr
 #define so_fport6 fhost.sin6.sin6_port
 #define so_ffamily fhost.ss.ss_family
 
-  union {   /* local host */
-      struct sockaddr_storage ss;
-      struct sockaddr_in sin;
-      struct sockaddr_in6 sin6;
-  } lhost;
+  union slirp_sockaddr lhost;      /* Local host */
 #define so_laddr lhost.sin.sin_addr
 #define so_lport lhost.sin.sin_port
 #define so_laddr6 lhost.sin6.sin6_addr
-- 
2.9.3
