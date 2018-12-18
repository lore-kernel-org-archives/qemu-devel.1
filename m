Received: from eggs.gnu.org ([2001:4830:134:3::10]:41240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORd-0000jk-2X
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORZ-0005Ja-5f
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:32 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORY-0004e7-Ik
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:28 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:25 +0100
Message-Id: <20181218230442.27887-48-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 47/64] slirp: drop <Vista compatibility
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

Since commit 12f8def0e02232d7c6416ad9b66640f973c531d1 (v2.9), qemu
requires Vista. Let's remove some conditional code.

Note that this introduces a missing declaration warning with mingw.
warning: implicit declaration of function 'inet_ntop'

See also: https://sourceforge.net/p/mingw-w64/mailman/message/36473782/

We could workaround it by declaring it ourself depending on __MINGW64_VER=
SION_*:
WINSOCK_API_LINKAGE INT WSAAPI inet_pton(int Family, PCTSTR pszAddrString=
, PVOID pAddrBuf);

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c       | 22 ----------------------
 slirp/ip6_icmp.c  | 10 ++++------
 slirp/ndp_table.c | 14 ++++++--------
 3 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 30eda2cca1..4d890287ba 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -290,17 +290,6 @@ static int net_slirp_init(NetClientState *peer, cons=
t char *model,
     }
 #endif
=20
-#if defined(_WIN32) && (_WIN32_WINNT < 0x0600)
-    /* No inet_pton helper before Vista... */
-    if (vprefix6) {
-        /* Unsupported */
-        error_setg(errp, "IPv6 prefix not supported");
-        return -1;
-    }
-    memset(&ip6_prefix, 0, sizeof(ip6_prefix));
-    ip6_prefix.s6_addr[0] =3D 0xfe;
-    ip6_prefix.s6_addr[1] =3D 0xc0;
-#else
     if (!vprefix6) {
         vprefix6 =3D "fec0::";
     }
@@ -308,7 +297,6 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
         error_setg(errp, "Failed to parse IPv6 prefix");
         return -1;
     }
-#endif
=20
     if (!vprefix6_len) {
         vprefix6_len =3D 64;
@@ -320,10 +308,6 @@ static int net_slirp_init(NetClientState *peer, cons=
t char *model,
     }
=20
     if (vhost6) {
-#if defined(_WIN32) && (_WIN32_WINNT < 0x0600)
-        error_setg(errp, "IPv6 host not supported");
-        return -1;
-#else
         if (!inet_pton(AF_INET6, vhost6, &ip6_host)) {
             error_setg(errp, "Failed to parse IPv6 host");
             return -1;
@@ -332,17 +316,12 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
             error_setg(errp, "IPv6 Host doesn't belong to network");
             return -1;
         }
-#endif
     } else {
         ip6_host =3D ip6_prefix;
         ip6_host.s6_addr[15] |=3D 2;
     }
=20
     if (vnameserver6) {
-#if defined(_WIN32) && (_WIN32_WINNT < 0x0600)
-        error_setg(errp, "IPv6 DNS not supported");
-        return -1;
-#else
         if (!inet_pton(AF_INET6, vnameserver6, &ip6_dns)) {
             error_setg(errp, "Failed to parse IPv6 DNS");
             return -1;
@@ -351,7 +330,6 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
             error_setg(errp, "IPv6 DNS doesn't belong to network");
             return -1;
         }
-#endif
     } else {
         ip6_dns =3D ip6_prefix;
         ip6_dns.s6_addr[15] |=3D 3;
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 3f74d172f4..595a62c8d4 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -74,6 +74,7 @@ void icmp6_send_error(struct mbuf *m, uint8_t type, uin=
t8_t code)
     Slirp *slirp =3D m->slirp;
     struct mbuf *t;
     struct ip6 *ip =3D mtod(m, struct ip6 *);
+    char addrstr[INET6_ADDRSTRLEN];
=20
     DEBUG_CALL("icmp6_send_error");
     DEBUG_ARGS(" type =3D %d, code =3D %d\n", type, code);
@@ -90,11 +91,8 @@ void icmp6_send_error(struct mbuf *m, uint8_t type, ui=
nt8_t code)
     struct ip6 *rip =3D mtod(t, struct ip6 *);
     rip->ip_src =3D (struct in6_addr)LINKLOCAL_ADDR;
     rip->ip_dst =3D ip->ip_src;
-#if !defined(_WIN32) || (_WIN32_WINNT >=3D 0x0600)
-    char addrstr[INET6_ADDRSTRLEN];
     inet_ntop(AF_INET6, &rip->ip_dst, addrstr, INET6_ADDRSTRLEN);
     DEBUG_ARG("target =3D %s", addrstr);
-#endif
=20
     rip->ip_nh =3D IPPROTO_ICMPV6;
     const int error_data_len =3D MIN(m->m_len,
@@ -222,12 +220,12 @@ void ndp_send_ra(Slirp *slirp)
  */
 void ndp_send_ns(Slirp *slirp, struct in6_addr addr)
 {
-    DEBUG_CALL("ndp_send_ns");
-#if !defined(_WIN32) || (_WIN32_WINNT >=3D 0x0600)
     char addrstr[INET6_ADDRSTRLEN];
+
     inet_ntop(AF_INET6, &addr, addrstr, INET6_ADDRSTRLEN);
+
+    DEBUG_CALL("ndp_send_ns");
     DEBUG_ARG("target =3D %s", addrstr);
-#endif
=20
     /* Build IPv6 packet */
     struct mbuf *t =3D m_get(slirp);
diff --git a/slirp/ndp_table.c b/slirp/ndp_table.c
index a4e6421fd3..1401e1b322 100644
--- a/slirp/ndp_table.c
+++ b/slirp/ndp_table.c
@@ -10,15 +10,14 @@
 void ndp_table_add(Slirp *slirp, struct in6_addr ip_addr,
                     uint8_t ethaddr[ETH_ALEN])
 {
+    char addrstr[INET6_ADDRSTRLEN];
     NdpTable *ndp_table =3D &slirp->ndp_table;
     int i;
=20
-    DEBUG_CALL("ndp_table_add");
-#if !defined(_WIN32) || (_WIN32_WINNT >=3D 0x0600)
-    char addrstr[INET6_ADDRSTRLEN];
     inet_ntop(AF_INET6, &(ip_addr), addrstr, INET6_ADDRSTRLEN);
+
+    DEBUG_CALL("ndp_table_add");
     DEBUG_ARG("ip =3D %s", addrstr);
-#endif
     DEBUG_ARGS(" hw addr =3D %02x:%02x:%02x:%02x:%02x:%02x\n",
                ethaddr[0], ethaddr[1], ethaddr[2],
                ethaddr[3], ethaddr[4], ethaddr[5]);
@@ -50,15 +49,14 @@ void ndp_table_add(Slirp *slirp, struct in6_addr ip_a=
ddr,
 bool ndp_table_search(Slirp *slirp, struct in6_addr ip_addr,
                       uint8_t out_ethaddr[ETH_ALEN])
 {
+    char addrstr[INET6_ADDRSTRLEN];
     NdpTable *ndp_table =3D &slirp->ndp_table;
     int i;
=20
-    DEBUG_CALL("ndp_table_search");
-#if !defined(_WIN32) || (_WIN32_WINNT >=3D 0x0600)
-    char addrstr[INET6_ADDRSTRLEN];
     inet_ntop(AF_INET6, &(ip_addr), addrstr, INET6_ADDRSTRLEN);
+
+    DEBUG_CALL("ndp_table_search");
     DEBUG_ARG("ip =3D %s", addrstr);
-#endif
=20
     assert(!in6_zero(&ip_addr));
=20
--=20
2.19.2
