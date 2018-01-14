Received: from eggs.gnu.org ([2001:4830:134:3::10]:41425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxt-00006b-P4
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxs-0002KX-Vl
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:01 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ealxs-0002Jh-Ov
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:00 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 14 Jan 2018 18:20:53 +0100
Message-Id: <20180114172053.1051-6-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
References: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] slirp: add in6_dhcp_multicast()
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/dhcpv6.h | 3 +++
 slirp/udp6.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/slirp/dhcpv6.h b/slirp/dhcpv6.h
index 9189cd3f2d..3373f6cb89 100644
--- a/slirp/dhcpv6.h
+++ b/slirp/dhcpv6.h
@@ -17,6 +17,9 @@
                             0x00, 0x00, 0x00, 0x00,\
                             0x00, 0x01, 0x00, 0x02 } }
=20
+#define in6_dhcp_multicast(a)\
+    in6_equal(a, &(struct in6_addr)ALLDHCP_MULTICAST)
+
 void dhcpv6_input(struct sockaddr_in6 *srcsas, struct mbuf *m);
=20
 #endif
diff --git a/slirp/udp6.c b/slirp/udp6.c
index 9fa314bc2d..7c4a6b003a 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -65,7 +65,7 @@ void udp6_input(struct mbuf *m)
     /* handle DHCPv6 */
     if (ntohs(uh->uh_dport) =3D=3D DHCPV6_SERVER_PORT &&
         (in6_equal(&ip->ip_dst, &slirp->vhost_addr6) ||
-         in6_equal(&ip->ip_dst, &(struct in6_addr)ALLDHCP_MULTICAST))) {
+         in6_dhcp_multicast(&ip->ip_dst))) {
         m->m_data +=3D iphlen;
         m->m_len -=3D iphlen;
         dhcpv6_input(&lhost, m);
--=20
2.15.1
