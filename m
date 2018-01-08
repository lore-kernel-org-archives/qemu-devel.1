Received: from eggs.gnu.org ([2001:4830:134:3::10]:33691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEj-00088L-Q4
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEi-00006s-MR
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:25 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEi-00006O-HV
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:24 -0500
Received: by mail-qt0-x241.google.com with SMTP id g10so14518174qtj.12
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:28:56 -0300
Message-Id: <20180108172904.8772-5-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/12] slirp: add in6_multicast() and use it
 instead of IN6_IS_ADDR_MULTICAST()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Host: Mac OS 10.12.5
Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)

  slirp/ip6_icmp.c:79:32: warning: taking address of packed member 'ip_src' of class or
        structure 'ip6' may result in an unaligned pointer value
        [-Waddress-of-packed-member]
      if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
                                 ^~~~~~~~~~
  /usr/include/netinet6/in6.h:299:36: note: expanded from macro 'IN6_IS_ADDR_MULTICAST'
  #define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] == 0xff)
                                            ^

Reported-by: John Arbuckle <programmingkidx@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 slirp/ip6.h       |  5 +++++
 slirp/ip6_icmp.c  | 10 +++++-----
 slirp/ndp_table.c |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/slirp/ip6.h b/slirp/ip6.h
index b1bea43b3c..6c5d4eeaa3 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -93,6 +93,11 @@ static inline bool in6_equal_mach(const struct in6_addr *a,
 #define in6_zero(a)\
     (in6_equal(a, &(struct in6_addr)ZERO_ADDR))
 
+static inline bool in6_multicast(const struct in6_addr *a)
+{
+    return a->s6_addr[0] == 0xff;
+}
+
 /* Compute emulated host MAC address from its ipv6 address */
 static inline void in6_compute_ethaddr(struct in6_addr ip,
                                        uint8_t eth[ETH_ALEN])
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index ee333d05a2..9796624648 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -76,7 +76,7 @@ void icmp6_send_error(struct mbuf *m, uint8_t type, uint8_t code)
     DEBUG_CALL("icmp6_send_error");
     DEBUG_ARGS((dfd, " type = %d, code = %d\n", type, code));
 
-    if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
+    if (in6_multicast(&ip->ip_src) ||
             in6_zero(&ip->ip_src)) {
         /* TODO icmp error? */
         return;
@@ -291,7 +291,7 @@ static void ndp_send_na(Slirp *slirp, struct ip6 *ip, struct icmp6 *icmp)
 
     /* NDP */
     ricmp->icmp6_nna.R = NDP_IsRouter;
-    ricmp->icmp6_nna.S = !IN6_IS_ADDR_MULTICAST(&rip->ip_dst);
+    ricmp->icmp6_nna.S = !in6_multicast(&rip->ip_dst);
     ricmp->icmp6_nna.O = 1;
     ricmp->icmp6_nna.reserved_hi = 0;
     ricmp->icmp6_nna.reserved_lo = 0;
@@ -348,7 +348,7 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, struct ip6 *ip,
         DEBUG_CALL(" type = Neighbor Solicitation");
         if (ip->ip_hl == 255
                 && icmp->icmp6_code == 0
-                && !IN6_IS_ADDR_MULTICAST(&icmp->icmp6_nns.target)
+                && !in6_multicast(&icmp->icmp6_nns.target)
                 && ntohs(ip->ip_pl) >= ICMP6_NDP_NS_MINLEN
                 && (!in6_zero(&ip->ip_src)
                     || in6_solicitednode_multicast(&ip->ip_dst))) {
@@ -365,8 +365,8 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, struct ip6 *ip,
         if (ip->ip_hl == 255
                 && icmp->icmp6_code == 0
                 && ntohs(ip->ip_pl) >= ICMP6_NDP_NA_MINLEN
-                && !IN6_IS_ADDR_MULTICAST(&icmp->icmp6_nna.target)
-                && (!IN6_IS_ADDR_MULTICAST(&ip->ip_dst)
+                && !in6_multicast(&icmp->icmp6_nna.target)
+                && (!in6_multicast(&ip->ip_dst)
                     || icmp->icmp6_nna.S == 0)) {
             ndp_table_add(slirp, ip->ip_src, eth->h_source);
         }
diff --git a/slirp/ndp_table.c b/slirp/ndp_table.c
index e1676a0a7b..5ff4bf2f3d 100644
--- a/slirp/ndp_table.c
+++ b/slirp/ndp_table.c
@@ -23,7 +23,7 @@ void ndp_table_add(Slirp *slirp, struct in6_addr ip_addr,
                 ethaddr[0], ethaddr[1], ethaddr[2],
                 ethaddr[3], ethaddr[4], ethaddr[5]));
 
-    if (IN6_IS_ADDR_MULTICAST(&ip_addr) || in6_zero(&ip_addr)) {
+    if (in6_multicast(&ip_addr) || in6_zero(&ip_addr)) {
         /* Do not register multicast or unspecified addresses */
         DEBUG_CALL(" abort: do not register multicast or unspecified address");
         return;
@@ -63,7 +63,7 @@ bool ndp_table_search(Slirp *slirp, struct in6_addr ip_addr,
     assert(!in6_zero(&ip_addr));
 
     /* Multicast address: fec0::abcd:efgh/8 -> 33:33:ab:cd:ef:gh */
-    if (IN6_IS_ADDR_MULTICAST(&ip_addr)) {
+    if (in6_multicast(&ip_addr)) {
         out_ethaddr[0] = 0x33; out_ethaddr[1] = 0x33;
         out_ethaddr[2] = ip_addr.s6_addr[12];
         out_ethaddr[3] = ip_addr.s6_addr[13];
-- 
2.15.1
