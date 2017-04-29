Received: from eggs.gnu.org ([2001:4830:134:3::10]:39240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXJ-0006tF-S4
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXI-0001Lv-1e
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:57 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:54653)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXH-0001La-RU
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:55 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 29 Apr 2017 18:47:48 +0200
Message-Id: <20170429164750.17414-8-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
References: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] slirp: Common lhost/fhost union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The socket structure has a pair of unions for lhost and fhost
addresses; the unions are identical so split them out into
a separate union declaration.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/socket.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/slirp/socket.h b/slirp/socket.h
index 8feed2aea4..c1be77eaf3 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -15,6 +15,12 @@
  * Our socket structure
  */
=20
+union slirp_sockaddr {
+    struct sockaddr_storage ss;
+    struct sockaddr_in sin;
+    struct sockaddr_in6 sin6;
+};
+
 struct socket {
   struct socket *so_next,*so_prev;      /* For a linked list of sockets =
*/
=20
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
=20
-  union {   /* local host */
-      struct sockaddr_storage ss;
-      struct sockaddr_in sin;
-      struct sockaddr_in6 sin6;
-  } lhost;
+  union slirp_sockaddr lhost;      /* Local host */
 #define so_laddr lhost.sin.sin_addr
 #define so_lport lhost.sin.sin_port
 #define so_laddr6 lhost.sin6.sin6_addr
--=20
2.11.0
