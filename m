Received: from eggs.gnu.org ([2001:4830:134:3::10]:40475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csD4N-00054S-7E
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csD4M-0007OC-4h
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:39:15 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:47417)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csD4L-0007LD-Rw
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:39:14 -0400
Date: Sun, 26 Mar 2017 20:39:08 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170326183908.cogmdiisen2jlsh5@var.youpi.perso.aquilenet.fr>
References: <db8ccb55-0570-4b6f-1635-7df2ff0b9ec3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6qsvlox7nhrbawdd"
Content-Disposition: inline
In-Reply-To: <db8ccb55-0570-4b6f-1635-7df2ff0b9ec3@redhat.com>
Subject: Re: [Qemu-devel] slirp + ipxe + ipv6 dns issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: ondrejj@salstar.sk, qemu-devel <qemu-devel@nongnu.org>


--6qsvlox7nhrbawdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Cole Robinson, on ven. 24 mars 2017 21:17:43 -0400, wrote:
> I bisected to this commit:
> 
>     slirp: Add RDNSS advertisement

Mmm, I see.  Could you try the attached patch to confirm that it fixes
the issue for you too?

Samuel

--6qsvlox7nhrbawdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 298a48dd25..00183e5945 100644
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
@@ -192,27 +187,30 @@ void ndp_send_ra(Slirp *slirp)
     opt2->ndpopt_prefixinfo.reserved2 = 0;
     opt2->ndpopt_prefixinfo.prefix = slirp->vprefix_addr6;
     t->m_data += NDPOPT_PREFIXINFO_LEN;
+    pl_size += NDPOPT_PREFIXINFO_LEN;
 
-#ifndef _WIN32
     /* Prefix information (NDP option) */
-    /* disabled for windows for now, until get_dns6_addr is implemented */
-    struct ndpopt *opt3 = mtod(t, struct ndpopt *);
-    opt3->ndpopt_type = NDPOPT_RDNSS;
-    opt3->ndpopt_len = NDPOPT_RDNSS_LEN / 8;
-    opt3->ndpopt_rdnss.reserved = 0;
-    opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
-    opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
-    t->m_data += NDPOPT_RDNSS_LEN;
-#endif
+    {
+        struct in6_addr addr;
+        uint32_t scope_id;
+        if (get_dns6_addr(&addr, &scope_id) >= 0) {
+            /* Host system does have an IPv6 DNS server, announce our proxy.  */
+            struct ndpopt *opt3 = mtod(t, struct ndpopt *);
+            opt3->ndpopt_type = NDPOPT_RDNSS;
+            opt3->ndpopt_len = NDPOPT_RDNSS_LEN / 8;
+            opt3->ndpopt_rdnss.reserved = 0;
+            opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
+            opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
+            t->m_data += NDPOPT_RDNSS_LEN;
+            pl_size += NDPOPT_RDNSS_LEN;
+        }
+    }
+
+    rip->ip_pl = htons(pl_size);
+    t->m_data -= sizeof(struct ip6) + pl_size;
+    t->m_len = sizeof(struct ip6) + pl_size;
 
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

--6qsvlox7nhrbawdd--
