Received: from eggs.gnu.org ([2001:4830:134:3::10]:41095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORa-0000j0-4G
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORY-0005HR-0S
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:29 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORX-00051F-D6
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:27 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:36 +0100
Message-Id: <20181218230442.27887-59-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 58/64] slirp: replace DEBUG_ARGS with DEBUG_ARG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

There is no clear benefit in calling an alias DEBUG_ARGS(). Replace
calls with DEBUG_ARG(), and fix the white-spacing while at it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/arp_table.c | 12 ++++++------
 slirp/debug.h     |  2 --
 slirp/ip6_icmp.c  |  2 +-
 slirp/ndp_table.c | 18 +++++++++---------
 slirp/slirp.c     | 12 ++++++------
 slirp/tcp_input.c |  6 +++---
 6 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/slirp/arp_table.c b/slirp/arp_table.c
index ce19e6e7c0..bf71b984ad 100644
--- a/slirp/arp_table.c
+++ b/slirp/arp_table.c
@@ -34,9 +34,9 @@ void arp_table_add(Slirp *slirp, uint32_t ip_addr, uint=
8_t ethaddr[ETH_ALEN])
=20
     DEBUG_CALL("arp_table_add");
     DEBUG_ARG("ip =3D %s", inet_ntoa((struct in_addr){.s_addr =3D ip_add=
r}));
-    DEBUG_ARGS(" hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x\n",
-               ethaddr[0], ethaddr[1], ethaddr[2],
-               ethaddr[3], ethaddr[4], ethaddr[5]);
+    DEBUG_ARG("hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x",
+              ethaddr[0], ethaddr[1], ethaddr[2],
+              ethaddr[3], ethaddr[4], ethaddr[5]);
=20
     if (ip_addr =3D=3D 0 || ip_addr =3D=3D 0xffffffff || ip_addr =3D=3D =
broadcast_addr) {
         /* Do not register broadcast addresses */
@@ -79,9 +79,9 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
     for (i =3D 0; i < ARP_TABLE_SIZE; i++) {
         if (arptbl->table[i].ar_sip =3D=3D ip_addr) {
             memcpy(out_ethaddr, arptbl->table[i].ar_sha,  ETH_ALEN);
-            DEBUG_ARGS(" found hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x=
\n",
-                       out_ethaddr[0], out_ethaddr[1], out_ethaddr[2],
-                       out_ethaddr[3], out_ethaddr[4], out_ethaddr[5]);
+            DEBUG_ARG("found hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x",
+                      out_ethaddr[0], out_ethaddr[1], out_ethaddr[2],
+                      out_ethaddr[3], out_ethaddr[4], out_ethaddr[5]);
             return 1;
         }
     }
diff --git a/slirp/debug.h b/slirp/debug.h
index ff920f0b87..50f30898fb 100644
--- a/slirp/debug.h
+++ b/slirp/debug.h
@@ -33,8 +33,6 @@ extern int slirp_debug;
     }                                           \
 } while (0)
=20
-#define DEBUG_ARGS(fmt, ...) DEBUG_ARG(fmt, ##__VA_ARGS__)
-
 #define DEBUG_MISC(fmt, ...) do {               \
     if (slirp_debug & DBG_MISC) {               \
         fprintf(dfd, fmt, ##__VA_ARGS__);       \
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index bce075913c..97304a9dd9 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -77,7 +77,7 @@ void icmp6_send_error(struct mbuf *m, uint8_t type, uin=
t8_t code)
     char addrstr[INET6_ADDRSTRLEN];
=20
     DEBUG_CALL("icmp6_send_error");
-    DEBUG_ARGS(" type =3D %d, code =3D %d\n", type, code);
+    DEBUG_ARG("type =3D %d, code =3D %d", type, code);
=20
     if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
             in6_zero(&ip->ip_src)) {
diff --git a/slirp/ndp_table.c b/slirp/ndp_table.c
index 1401e1b322..b7b73722f7 100644
--- a/slirp/ndp_table.c
+++ b/slirp/ndp_table.c
@@ -18,9 +18,9 @@ void ndp_table_add(Slirp *slirp, struct in6_addr ip_add=
r,
=20
     DEBUG_CALL("ndp_table_add");
     DEBUG_ARG("ip =3D %s", addrstr);
-    DEBUG_ARGS(" hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x\n",
-               ethaddr[0], ethaddr[1], ethaddr[2],
-               ethaddr[3], ethaddr[4], ethaddr[5]);
+    DEBUG_ARG("hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x",
+              ethaddr[0], ethaddr[1], ethaddr[2],
+              ethaddr[3], ethaddr[4], ethaddr[5]);
=20
     if (IN6_IS_ADDR_MULTICAST(&ip_addr) || in6_zero(&ip_addr)) {
         /* Do not register multicast or unspecified addresses */
@@ -67,18 +67,18 @@ bool ndp_table_search(Slirp *slirp, struct in6_addr i=
p_addr,
         out_ethaddr[3] =3D ip_addr.s6_addr[13];
         out_ethaddr[4] =3D ip_addr.s6_addr[14];
         out_ethaddr[5] =3D ip_addr.s6_addr[15];
-        DEBUG_ARGS(" multicast addr =3D %02x:%02x:%02x:%02x:%02x:%02x\n"=
,
-                   out_ethaddr[0], out_ethaddr[1], out_ethaddr[2],
-                   out_ethaddr[3], out_ethaddr[4], out_ethaddr[5]);
+        DEBUG_ARG("multicast addr =3D %02x:%02x:%02x:%02x:%02x:%02x",
+                  out_ethaddr[0], out_ethaddr[1], out_ethaddr[2],
+                  out_ethaddr[3], out_ethaddr[4], out_ethaddr[5]);
         return 1;
     }
=20
     for (i =3D 0; i < NDP_TABLE_SIZE; i++) {
         if (in6_equal(&ndp_table->table[i].ip_addr, &ip_addr)) {
             memcpy(out_ethaddr, ndp_table->table[i].eth_addr,  ETH_ALEN)=
;
-            DEBUG_ARGS(" found hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x=
\n",
-                       out_ethaddr[0], out_ethaddr[1], out_ethaddr[2],
-                       out_ethaddr[3], out_ethaddr[4], out_ethaddr[5]);
+            DEBUG_ARG("found hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x",
+                      out_ethaddr[0], out_ethaddr[1], out_ethaddr[2],
+                      out_ethaddr[3], out_ethaddr[4], out_ethaddr[5]);
             return 1;
         }
     }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 31af2efbd5..c022644888 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -992,12 +992,12 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
     }
=20
     memcpy(eh->h_dest, ethaddr, ETH_ALEN);
-    DEBUG_ARGS(" src =3D %02x:%02x:%02x:%02x:%02x:%02x\n",
-               eh->h_source[0], eh->h_source[1], eh->h_source[2],
-               eh->h_source[3], eh->h_source[4], eh->h_source[5]);
-    DEBUG_ARGS(" dst =3D %02x:%02x:%02x:%02x:%02x:%02x\n",
-               eh->h_dest[0], eh->h_dest[1], eh->h_dest[2],
-               eh->h_dest[3], eh->h_dest[4], eh->h_dest[5]);
+    DEBUG_ARG("src =3D %02x:%02x:%02x:%02x:%02x:%02x",
+              eh->h_source[0], eh->h_source[1], eh->h_source[2],
+              eh->h_source[3], eh->h_source[4], eh->h_source[5]);
+    DEBUG_ARG("dst =3D %02x:%02x:%02x:%02x:%02x:%02x",
+              eh->h_dest[0], eh->h_dest[1], eh->h_dest[2],
+              eh->h_dest[3], eh->h_dest[4], eh->h_dest[5]);
     memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
     slirp->cb->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
     return 1;
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index bc4aa60046..d24295813a 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -215,8 +215,8 @@ tcp_input(struct mbuf *m, int iphlen, struct socket *=
inso, unsigned short af)
     Slirp *slirp;
=20
 	DEBUG_CALL("tcp_input");
-	DEBUG_ARGS(" m =3D %p  iphlen =3D %2d  inso =3D %p\n",
-               m, iphlen, inso);
+	DEBUG_ARG("m =3D %p  iphlen =3D %2d  inso =3D %p",
+              m, iphlen, inso);
=20
 	/*
 	 * If called with m =3D=3D 0, then we're continuing the connect
@@ -1389,7 +1389,7 @@ tcp_dooptions(struct tcpcb *tp, u_char *cp, int cnt=
, struct tcpiphdr *ti)
 	int opt, optlen;
=20
 	DEBUG_CALL("tcp_dooptions");
-	DEBUG_ARGS(" tp =3D %p  cnt=3D%i\n", tp, cnt);
+	DEBUG_ARG("tp =3D %p  cnt=3D%i", tp, cnt);
=20
 	for (; cnt > 0; cnt -=3D optlen, cp +=3D optlen) {
 		opt =3D cp[0];
--=20
2.19.2
