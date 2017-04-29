Received: from eggs.gnu.org ([2001:4830:134:3::10]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4Xok-0007Ti-45
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4Xoj-0006lw-5N
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:06 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:55871)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4Xoi-0006ll-RV
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:05 -0400
Date: Sat, 29 Apr 2017 21:14:02 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
References: <VI1PR0601MB247952CA06D05D5041AA450D9C130@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB247995F01C0EC808ADEA07C49C180@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ezwyzy4vtrdummqh"
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
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
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>


--ezwyzy4vtrdummqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FONNEMANN Mark, on sam. 29 avril 2017 18:25:26 +0000, wrote:
> 0 packets received by filter

Ok, so nothing going out from qemu. Could you try to apply the attached
patch to qemu-2.9 and see what it makes qemu print when you resolve a
domain from the guest?

Samuel

--ezwyzy4vtrdummqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dns

--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -814,11 +814,18 @@ void sotranslate_out(struct socket *so,
 
     switch (addr->ss_family) {
     case AF_INET:
+        fprintf(stderr,"translating %x against %x %x\n",
+                so->so_faddr.s_addr,
+                slirp->vnetwork_mask.s_addr,
+                slirp->vnameserver_addr.s_addr);
         if ((so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) ==
                 slirp->vnetwork_addr.s_addr) {
             /* It's an alias */
+            fprintf(stderr,"it's an alias\n");
             if (so->so_faddr.s_addr == slirp->vnameserver_addr.s_addr) {
+                fprintf(stderr,"it's DNS\n");
                 if (get_dns_addr(&sin->sin_addr) < 0) {
+                    fprintf(stderr,"didn't get DNS address");
                     sin->sin_addr = loopback_addr;
                 }
             } else {
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -133,6 +133,10 @@ udp_input(register struct mbuf *m, int i
 	lhost4->sin_addr = ip->ip_src;
 	lhost4->sin_port = uh->uh_sport;
 
+        if (ntohs(uh->uh_dport) == 53 &&
+            ip->ip_dst.s_addr == slirp->vnameserver_addr.s_addr)
+            fprintf(stderr,"UDP packet for DNS server\n");
+
         /*
          *  handle DHCP/BOOTP
          */
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -165,6 +165,7 @@ static int get_dns_addr_resolv_conf(int
 #endif
     while (fgets(buff, 512, f) != NULL) {
         if (sscanf(buff, "nameserver%*[ \t]%256s", buff2) == 1) {
+            fprintf(stderr,"got resolv.conf entry '%s'\n", buff2);
             char *c = strchr(buff2, '%');
             if (c) {
                 if_index = if_nametoindex(c + 1);
@@ -174,10 +175,16 @@ static int get_dns_addr_resolv_conf(int
             }
 
             if (!inet_pton(af, buff2, tmp_addr)) {
+                fprintf(stderr,"couldn't parse it\n");
                 continue;
             }
             /* If it's the first one, set it to dns_addr */
             if (!found) {
+                if (af == AF_INET)
+                {
+                    struct sockaddr_in *sin = tmp_addr;
+                    fprintf(stderr,"parsed %x\n", sin->sin_addr.s_addr);
+                }
                 memcpy(pdns_addr, tmp_addr, addrlen);
                 memcpy(cached_addr, tmp_addr, addrlen);
                 if (scope_id) {
@@ -219,6 +226,7 @@ int get_dns_addr(struct in_addr *pdns_ad
 
     if (dns_addr.s_addr != 0) {
         int ret;
+        fprintf(stderr,"dns_addr is cached: %x\n", dns_addr.s_addr);
         ret = get_dns_addr_cached(pdns_addr, &dns_addr, sizeof(dns_addr),
                                   &dns_addr_stat, &dns_addr_time);
         if (ret <= 0) {

--ezwyzy4vtrdummqh--
