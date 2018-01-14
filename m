Received: from eggs.gnu.org ([2001:4830:134:3::10]:41405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxr-000062-OY
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxq-0002IM-Pp
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:20:59 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ealxq-0002H7-J4
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:20:58 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 14 Jan 2018 18:20:49 +0100
Message-Id: <20180114172053.1051-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
References: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] slirp: avoid IN6_IS_ADDR_UNSPECIFIED(),
 rather use in6_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Host: Mac OS 10.12.5
Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)

  slirp/ip6_icmp.c:80:38: warning: taking address of packed member 'ip_sr=
c' of class or
        structure 'ip6' may result in an unaligned pointer value
        [-Waddress-of-packed-member]
              IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                       ^~~~~~~~~~
  /usr/include/netinet6/in6.h:238:42: note: expanded from macro 'IN6_IS_A=
DDR_UNSPECIFIED'
          ((*(const __uint32_t *)(const void *)(&(a)->s6_addr[0]) =3D=3D =
0) && \
                                                  ^

Reported-by: John Arbuckle <programmingkidx@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6_icmp.c  | 6 +++---
 slirp/ndp_table.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 777eb574be..ee333d05a2 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -77,7 +77,7 @@ void icmp6_send_error(struct mbuf *m, uint8_t type, uin=
t8_t code)
     DEBUG_ARGS((dfd, " type =3D %d, code =3D %d\n", type, code));
=20
     if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
-            IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
+            in6_zero(&ip->ip_src)) {
         /* TODO icmp error? */
         return;
     }
@@ -272,7 +272,7 @@ static void ndp_send_na(Slirp *slirp, struct ip6 *ip,=
 struct icmp6 *icmp)
     struct mbuf *t =3D m_get(slirp);
     struct ip6 *rip =3D mtod(t, struct ip6 *);
     rip->ip_src =3D icmp->icmp6_nns.target;
-    if (IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
+    if (in6_zero(&ip->ip_src)) {
         rip->ip_dst =3D (struct in6_addr)ALLNODES_MULTICAST;
     } else {
         rip->ip_dst =3D ip->ip_src;
@@ -350,7 +350,7 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, s=
truct ip6 *ip,
                 && icmp->icmp6_code =3D=3D 0
                 && !IN6_IS_ADDR_MULTICAST(&icmp->icmp6_nns.target)
                 && ntohs(ip->ip_pl) >=3D ICMP6_NDP_NS_MINLEN
-                && (!IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)
+                && (!in6_zero(&ip->ip_src)
                     || in6_solicitednode_multicast(&ip->ip_dst))) {
             if (in6_equal_host(&icmp->icmp6_nns.target)) {
                 /* Gratuitous NDP */
diff --git a/slirp/ndp_table.c b/slirp/ndp_table.c
index 9d4c39b45c..e1676a0a7b 100644
--- a/slirp/ndp_table.c
+++ b/slirp/ndp_table.c
@@ -23,7 +23,7 @@ void ndp_table_add(Slirp *slirp, struct in6_addr ip_add=
r,
                 ethaddr[0], ethaddr[1], ethaddr[2],
                 ethaddr[3], ethaddr[4], ethaddr[5]));
=20
-    if (IN6_IS_ADDR_MULTICAST(&ip_addr) || IN6_IS_ADDR_UNSPECIFIED(&ip_a=
ddr)) {
+    if (IN6_IS_ADDR_MULTICAST(&ip_addr) || in6_zero(&ip_addr)) {
         /* Do not register multicast or unspecified addresses */
         DEBUG_CALL(" abort: do not register multicast or unspecified add=
ress");
         return;
@@ -60,7 +60,7 @@ bool ndp_table_search(Slirp *slirp, struct in6_addr ip_=
addr,
     DEBUG_ARG("ip =3D %s", addrstr);
 #endif
=20
-    assert(!IN6_IS_ADDR_UNSPECIFIED(&ip_addr));
+    assert(!in6_zero(&ip_addr));
=20
     /* Multicast address: fec0::abcd:efgh/8 -> 33:33:ab:cd:ef:gh */
     if (IN6_IS_ADDR_MULTICAST(&ip_addr)) {
--=20
2.15.1
