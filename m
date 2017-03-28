Received: from eggs.gnu.org ([2001:4830:134:3::10]:39550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzZ-0000Pu-UO
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzY-0000Hj-SL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:34 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:53288)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzY-0000HU-MP
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:32 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 29 Mar 2017 00:53:27 +0200
Message-Id: <20170328225327.16707-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
References: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] slirp: Send RDNSS in RA only if host has an
 IPv6 DNS server
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

Previously we would always send an RDNSS option in the RA, making the gue=
st
try to resolve DNS through IPv6, even if the host does not actually have
and IPv6 DNS server available.

This makes the RDNSS option enabled only when an IPv6 DNS server is
available.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 slirp/ip6_icmp.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index d0f5cc1456..777eb574be 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -144,6 +144,9 @@ void ndp_send_ra(Slirp *slirp)
     struct mbuf *t =3D m_get(slirp);
     struct ip6 *rip =3D mtod(t, struct ip6 *);
     size_t pl_size =3D 0;
+    struct in6_addr addr;
+    uint32_t scope_id;
+
     rip->ip_src =3D (struct in6_addr)LINKLOCAL_ADDR;
     rip->ip_dst =3D (struct in6_addr)ALLNODES_MULTICAST;
     rip->ip_nh =3D IPPROTO_ICMPV6;
@@ -189,18 +192,18 @@ void ndp_send_ra(Slirp *slirp)
     t->m_data +=3D NDPOPT_PREFIXINFO_LEN;
     pl_size +=3D NDPOPT_PREFIXINFO_LEN;
=20
-#ifndef _WIN32
     /* Prefix information (NDP option) */
-    /* disabled for windows for now, until get_dns6_addr is implemented =
*/
-    struct ndpopt *opt3 =3D mtod(t, struct ndpopt *);
-    opt3->ndpopt_type =3D NDPOPT_RDNSS;
-    opt3->ndpopt_len =3D NDPOPT_RDNSS_LEN / 8;
-    opt3->ndpopt_rdnss.reserved =3D 0;
-    opt3->ndpopt_rdnss.lifetime =3D htonl(2 * NDP_MaxRtrAdvInterval);
-    opt3->ndpopt_rdnss.addr =3D slirp->vnameserver_addr6;
-    t->m_data +=3D NDPOPT_RDNSS_LEN;
-    pl_size +=3D NDPOPT_RDNSS_LEN;
-#endif
+    if (get_dns6_addr(&addr, &scope_id) >=3D 0) {
+        /* Host system does have an IPv6 DNS server, announce our proxy.=
  */
+        struct ndpopt *opt3 =3D mtod(t, struct ndpopt *);
+        opt3->ndpopt_type =3D NDPOPT_RDNSS;
+        opt3->ndpopt_len =3D NDPOPT_RDNSS_LEN / 8;
+        opt3->ndpopt_rdnss.reserved =3D 0;
+        opt3->ndpopt_rdnss.lifetime =3D htonl(2 * NDP_MaxRtrAdvInterval)=
;
+        opt3->ndpopt_rdnss.addr =3D slirp->vnameserver_addr6;
+        t->m_data +=3D NDPOPT_RDNSS_LEN;
+        pl_size +=3D NDPOPT_RDNSS_LEN;
+    }
=20
     rip->ip_pl =3D htons(pl_size);
     t->m_data -=3D sizeof(struct ip6) + pl_size;
--=20
2.11.0
