Received: from eggs.gnu.org ([2001:4830:134:3::10]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6mQo-0001Su-3L
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6mQn-00018A-3J
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:14:38 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:42107)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6mQm-00017R-T1
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:14:37 -0400
Date: Sat, 6 May 2017 01:14:33 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170505231433.ggp34jmzx4fad6jp@var.youpi.perso.aquilenet.fr>
References: <20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ua7oje7rka4cbrlm"
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>


--ua7oje7rka4cbrlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FONNEMANN Mark, on ven. 05 mai 2017 22:38:20 +0000, wrote:
> >Could you run tcpdump inside the guest so we are sure what the nslookup call emits?
> 
> Is there another way to determine this info? My guest OS is an embedded system with BusyBox 1.25 and not much else.

The attached patch should be dumping the same kind of information.

Samuel

--ua7oje7rka4cbrlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/slirp/ip_input.c b/slirp/ip_input.c
index 348e1dca5a..ada6f0d059 100644
--- a/slirp/ip_input.c
+++ b/slirp/ip_input.c
@@ -41,6 +41,7 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip_icmp.h"
+#include "qemu/log.h"
 
 static struct ip *ip_reass(Slirp *slirp, struct ip *ip, struct ipq *fp);
 static void ip_freef(Slirp *slirp, struct ipq *fp);
@@ -93,6 +94,8 @@ ip_input(struct mbuf *m)
 
 	ip = mtod(m, struct ip *);
 
+        qemu_log("ip input %x -> %x %x\n", ntohl(ip->ip_src.s_addr), ntohl(ip->ip_dst.s_addr), ip->ip_p);
+
 	if (ip->ip_v != IPVERSION) {
 		goto bad;
 	}
diff --git a/slirp/udp.c b/slirp/udp.c
index 227d779022..521c3a5a57 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -41,6 +41,7 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip_icmp.h"
+#include "qemu/log.h"
 
 static uint8_t udp_tos(struct socket *so);
 
@@ -95,6 +96,7 @@ udp_input(register struct mbuf *m, int iphlen)
 	ip = mtod(m, struct ip *);
 	uh = (struct udphdr *)((caddr_t)ip + iphlen);
 
+        qemu_log("udp input %u -> %u\n", (unsigned) ntohs(uh->uh_sport), (unsigned) ntohs(uh->uh_dport));
 	/*
 	 * Make mbuf data length reflect UDP length.
 	 * If not enough data to reflect UDP length, drop.

--ua7oje7rka4cbrlm--
