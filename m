Received: from eggs.gnu.org ([2001:4830:134:3::10]:58879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXV-0005RU-FB
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXS-0003GX-JJ
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:25 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:43425)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXS-0003En-Cl
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:22 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 27 May 2017 23:46:18 +0200
Message-Id: <20170527214618.32626-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170527214618.32626-1-samuel.thibault@ens-lyon.org>
References: <20170527214618.32626-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 3/3] Fix total IP header length in forwarded TCP
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sjors Gielen <sjors@sjorsgielen.nl>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Sjors Gielen <sjors@sjorsgielen.nl>

When forwarding TCP packets, the internal tcpiphdr struct length was wrongly
used inside the IP header. This commit changes the behaviour to what is used
by tcp_output.c, using the correct full IP header + payload length.

Signed-off-by: Sjors Gielen <sjors@sjorsgielen.nl>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tcp_subr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index ed16e1807f..dc8b4bbb50 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -204,7 +204,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, struct mbuf *m,
 	    m->m_len  -= sizeof(struct tcpiphdr) - sizeof(struct tcphdr)
 	                                         - sizeof(struct ip);
 	    ip = mtod(m, struct ip *);
-	    ip->ip_len = tlen;
+	    ip->ip_len = m->m_len;
 	    ip->ip_dst = tcpiph_save.ti_dst;
 	    ip->ip_src = tcpiph_save.ti_src;
 	    ip->ip_p = tcpiph_save.ti_pr;
@@ -224,7 +224,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, struct mbuf *m,
 	    m->m_len  -= sizeof(struct tcpiphdr) - sizeof(struct tcphdr)
 	                                         - sizeof(struct ip6);
 	    ip6 = mtod(m, struct ip6 *);
-	    ip6->ip_pl = tlen;
+	    ip6->ip_pl = tcpiph_save.ti_len;
 	    ip6->ip_dst = tcpiph_save.ti_dst6;
 	    ip6->ip_src = tcpiph_save.ti_src6;
 	    ip6->ip_nh = tcpiph_save.ti_nh6;
-- 
2.11.0
