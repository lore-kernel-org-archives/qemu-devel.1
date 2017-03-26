Received: from eggs.gnu.org ([2001:4830:134:3::10]:41900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBb-0006dO-09
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBX-0002K5-8R
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:43 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:46712)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBX-0002JO-1h
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:39 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Mar 2017 20:46:33 +0200
Message-Id: <20170326184634.25042-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
References: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH 1/2] slirp: Make RA build more flexible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, thuth@redhat.com, jan.kiszka@siemens.com

Do not hardcode the RA size at all, use a pl_size variable which
accounts the accumulated size, and fill rip->ip_pl at the end.

This will allow to make some blocks optional.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6_icmp.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 298a48dd25..d0f5cc1456 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -143,17 +143,10 @@ void ndp_send_ra(Slirp *slirp)
     /* Build IPv6 packet */
     struct mbuf *t = m_get(slirp);
     struct ip6 *rip = mtod(t, struct ip6 *);
+    size_t pl_size = 0;
     rip->ip_src = (struct in6_addr)LINKLOCAL_ADDR;
     rip->ip_dst = (struct in6_addr)ALLNODES_MULTICAST;
     rip->ip_nh = IPPROTO_ICMPV6;
-    rip->ip_pl = htons(ICMP6_NDP_RA_MINLEN
-                        + NDPOPT_LINKLAYER_LEN
-                        + NDPOPT_PREFIXINFO_LEN
-#ifndef _WIN32
-                        + NDPOPT_RDNSS_LEN
-#endif
-                        );
-    t->m_len = sizeof(struct ip6) + ntohs(rip->ip_pl);
 
     /* Build ICMPv6 packet */
     t->m_data += sizeof(struct ip6);
@@ -171,6 +164,7 @@ void ndp_send_ra(Slirp *slirp)
     ricmp->icmp6_nra.reach_time = htonl(NDP_AdvReachableTime);
     ricmp->icmp6_nra.retrans_time = htonl(NDP_AdvRetransTime);
     t->m_data += ICMP6_NDP_RA_MINLEN;
+    pl_size += ICMP6_NDP_RA_MINLEN;
 
     /* Source link-layer address (NDP option) */
     struct ndpopt *opt = mtod(t, struct ndpopt *);
@@ -178,6 +172,7 @@ void ndp_send_ra(Slirp *slirp)
     opt->ndpopt_len = NDPOPT_LINKLAYER_LEN / 8;
     in6_compute_ethaddr(rip->ip_src, opt->ndpopt_linklayer);
     t->m_data += NDPOPT_LINKLAYER_LEN;
+    pl_size += NDPOPT_LINKLAYER_LEN;
 
     /* Prefix information (NDP option) */
     struct ndpopt *opt2 = mtod(t, struct ndpopt *);
@@ -192,6 +187,7 @@ void ndp_send_ra(Slirp *slirp)
     opt2->ndpopt_prefixinfo.reserved2 = 0;
     opt2->ndpopt_prefixinfo.prefix = slirp->vprefix_addr6;
     t->m_data += NDPOPT_PREFIXINFO_LEN;
+    pl_size += NDPOPT_PREFIXINFO_LEN;
 
 #ifndef _WIN32
     /* Prefix information (NDP option) */
@@ -203,16 +199,14 @@ void ndp_send_ra(Slirp *slirp)
     opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
     opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
     t->m_data += NDPOPT_RDNSS_LEN;
+    pl_size += NDPOPT_RDNSS_LEN;
 #endif
 
+    rip->ip_pl = htons(pl_size);
+    t->m_data -= sizeof(struct ip6) + pl_size;
+    t->m_len = sizeof(struct ip6) + pl_size;
+
     /* ICMPv6 Checksum */
-#ifndef _WIN32
-    t->m_data -= NDPOPT_RDNSS_LEN;
-#endif
-    t->m_data -= NDPOPT_PREFIXINFO_LEN;
-    t->m_data -= NDPOPT_LINKLAYER_LEN;
-    t->m_data -= ICMP6_NDP_RA_MINLEN;
-    t->m_data -= sizeof(struct ip6);
     ricmp->icmp6_cksum = ip6_cksum(t);
 
     ip6_output(NULL, t, 0);
-- 
2.11.0
