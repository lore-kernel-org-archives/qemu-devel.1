Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzb-0000Q4-2e
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzY-0000HN-3u
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:35 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:52522)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzX-0000Gz-QI
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:32 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 29 Mar 2017 00:53:26 +0200
Message-Id: <20170328225327.16707-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
References: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] slirp: Make RA build more flexible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

Do not hardcode the RA size at all, use a pl_size variable which
accounts the accumulated size, and fill rip->ip_pl at the end.

This will allow to make some blocks optional.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 slirp/ip6_icmp.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 298a48dd25..d0f5cc1456 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -143,17 +143,10 @@ void ndp_send_ra(Slirp *slirp)
     /* Build IPv6 packet */
     struct mbuf *t =3D m_get(slirp);
     struct ip6 *rip =3D mtod(t, struct ip6 *);
+    size_t pl_size =3D 0;
     rip->ip_src =3D (struct in6_addr)LINKLOCAL_ADDR;
     rip->ip_dst =3D (struct in6_addr)ALLNODES_MULTICAST;
     rip->ip_nh =3D IPPROTO_ICMPV6;
-    rip->ip_pl =3D htons(ICMP6_NDP_RA_MINLEN
-                        + NDPOPT_LINKLAYER_LEN
-                        + NDPOPT_PREFIXINFO_LEN
-#ifndef _WIN32
-                        + NDPOPT_RDNSS_LEN
-#endif
-                        );
-    t->m_len =3D sizeof(struct ip6) + ntohs(rip->ip_pl);
=20
     /* Build ICMPv6 packet */
     t->m_data +=3D sizeof(struct ip6);
@@ -171,6 +164,7 @@ void ndp_send_ra(Slirp *slirp)
     ricmp->icmp6_nra.reach_time =3D htonl(NDP_AdvReachableTime);
     ricmp->icmp6_nra.retrans_time =3D htonl(NDP_AdvRetransTime);
     t->m_data +=3D ICMP6_NDP_RA_MINLEN;
+    pl_size +=3D ICMP6_NDP_RA_MINLEN;
=20
     /* Source link-layer address (NDP option) */
     struct ndpopt *opt =3D mtod(t, struct ndpopt *);
@@ -178,6 +172,7 @@ void ndp_send_ra(Slirp *slirp)
     opt->ndpopt_len =3D NDPOPT_LINKLAYER_LEN / 8;
     in6_compute_ethaddr(rip->ip_src, opt->ndpopt_linklayer);
     t->m_data +=3D NDPOPT_LINKLAYER_LEN;
+    pl_size +=3D NDPOPT_LINKLAYER_LEN;
=20
     /* Prefix information (NDP option) */
     struct ndpopt *opt2 =3D mtod(t, struct ndpopt *);
@@ -192,6 +187,7 @@ void ndp_send_ra(Slirp *slirp)
     opt2->ndpopt_prefixinfo.reserved2 =3D 0;
     opt2->ndpopt_prefixinfo.prefix =3D slirp->vprefix_addr6;
     t->m_data +=3D NDPOPT_PREFIXINFO_LEN;
+    pl_size +=3D NDPOPT_PREFIXINFO_LEN;
=20
 #ifndef _WIN32
     /* Prefix information (NDP option) */
@@ -203,16 +199,14 @@ void ndp_send_ra(Slirp *slirp)
     opt3->ndpopt_rdnss.lifetime =3D htonl(2 * NDP_MaxRtrAdvInterval);
     opt3->ndpopt_rdnss.addr =3D slirp->vnameserver_addr6;
     t->m_data +=3D NDPOPT_RDNSS_LEN;
+    pl_size +=3D NDPOPT_RDNSS_LEN;
 #endif
=20
+    rip->ip_pl =3D htons(pl_size);
+    t->m_data -=3D sizeof(struct ip6) + pl_size;
+    t->m_len =3D sizeof(struct ip6) + pl_size;
+
     /* ICMPv6 Checksum */
-#ifndef _WIN32
-    t->m_data -=3D NDPOPT_RDNSS_LEN;
-#endif
-    t->m_data -=3D NDPOPT_PREFIXINFO_LEN;
-    t->m_data -=3D NDPOPT_LINKLAYER_LEN;
-    t->m_data -=3D ICMP6_NDP_RA_MINLEN;
-    t->m_data -=3D sizeof(struct ip6);
     ricmp->icmp6_cksum =3D ip6_cksum(t);
=20
     ip6_output(NULL, t, 0);
--=20
2.11.0
