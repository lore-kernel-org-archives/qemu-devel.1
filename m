Received: from eggs.gnu.org ([2001:4830:134:3::10]:41861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBX-0006cm-V3
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBX-0002Jx-6S
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:39 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:47468)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csDBW-0002IQ-Vs
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 14:46:39 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Mar 2017 20:46:34 +0200
Message-Id: <20170326184634.25042-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
References: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH 2/2] slirp: Send RDNSS in RA only if host has
 an IPv6 DNS server
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

Previously we would always send an RDNSS option in the RA, making the guest
try to resolve DNS through IPv6, even if the host does not actually have
and IPv6 DNS server available.

This makes the RDNSS option enabled only when an IPv6 DNS server is
available.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6_icmp.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index d0f5cc1456..00183e5945 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -189,18 +189,22 @@ void ndp_send_ra(Slirp *slirp)
     t->m_data += NDPOPT_PREFIXINFO_LEN;
     pl_size += NDPOPT_PREFIXINFO_LEN;
 
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
-    pl_size += NDPOPT_RDNSS_LEN;
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
 
     rip->ip_pl = htons(pl_size);
     t->m_data -= sizeof(struct ip6) + pl_size;
-- 
2.11.0
