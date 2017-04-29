Received: from eggs.gnu.org ([2001:4830:134:3::10]:57357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4aRE-0008Tf-UY
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4aRD-0002UY-Vm
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:02:01 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:56135)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4aRD-0002Sw-LI
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:01:59 -0400
Date: Sun, 30 Apr 2017 00:01:56 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
References: <VI1PR0601MB247952CA06D05D5041AA450D9C130@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB247995F01C0EC808ADEA07C49C180@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dburcxpx25uj5w5e"
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
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


--dburcxpx25uj5w5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FONNEMANN Mark, on sam. 29 avril 2017 20:06:09 +0000, wrote:
> [mfonnemann@localhost qemu]$ /usr/local/bin/qemu-system-i386 -display curses -readconfig qemu.cfg -D logfile

Ah, you are using curses... I've been putting logs onto stderr for
simplicity, not the proper qemu logs. Here is a fixed patch to get
output in the log.

Samuel

--dburcxpx25uj5w5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dns

--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu-common.h"
 #include "slirp.h"
 #include "ip_icmp.h"
@@ -814,11 +815,18 @@ void sotranslate_out(struct socket *so,
 
     switch (addr->ss_family) {
     case AF_INET:
+        qemu_log("translating %x against %x %x\n",
+                so->so_faddr.s_addr,
+                slirp->vnetwork_mask.s_addr,
+                slirp->vnameserver_addr.s_addr);
         if ((so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) ==
                 slirp->vnetwork_addr.s_addr) {
             /* It's an alias */
+            qemu_log("it's an alias\n");
             if (so->so_faddr.s_addr == slirp->vnameserver_addr.s_addr) {
+                qemu_log("it's DNS\n");
                 if (get_dns_addr(&sin->sin_addr) < 0) {
+                    qemu_log("didn't get DNS address");
                     sin->sin_addr = loopback_addr;
                 }
             } else {
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -39,6 +39,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "slirp.h"
 #include "ip_icmp.h"
 
@@ -133,6 +134,10 @@ udp_input(register struct mbuf *m, int i
 	lhost4->sin_addr = ip->ip_src;
 	lhost4->sin_port = uh->uh_sport;
 
+        if (ntohs(uh->uh_dport) == 53 &&
+            ip->ip_dst.s_addr == slirp->vnameserver_addr.s_addr)
+            qemu_log("UDP packet for DNS server\n");
+
         /*
          *  handle DHCP/BOOTP
          */
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
@@ -165,6 +166,7 @@ static int get_dns_addr_resolv_conf(int
 #endif
     while (fgets(buff, 512, f) != NULL) {
         if (sscanf(buff, "nameserver%*[ \t]%256s", buff2) == 1) {
+            qemu_log("got resolv.conf entry '%s'\n", buff2);
             char *c = strchr(buff2, '%');
             if (c) {
                 if_index = if_nametoindex(c + 1);
@@ -174,10 +176,16 @@ static int get_dns_addr_resolv_conf(int
             }
 
             if (!inet_pton(af, buff2, tmp_addr)) {
+                qemu_log("couldn't parse it as %d\n", af);
                 continue;
             }
             /* If it's the first one, set it to dns_addr */
             if (!found) {
+                if (af == AF_INET)
+                {
+                    struct in_addr *in = tmp_addr;
+                    qemu_log("parsed %x\n", in->s_addr);
+                }
                 memcpy(pdns_addr, tmp_addr, addrlen);
                 memcpy(cached_addr, tmp_addr, addrlen);
                 if (scope_id) {
@@ -219,6 +227,7 @@ int get_dns_addr(struct in_addr *pdns_ad
 
     if (dns_addr.s_addr != 0) {
         int ret;
+        qemu_log("dns_addr is cached: %x\n", dns_addr.s_addr);
         ret = get_dns_addr_cached(pdns_addr, &dns_addr, sizeof(dns_addr),
                                   &dns_addr_stat, &dns_addr_time);
         if (ret <= 0) {

--dburcxpx25uj5w5e--
