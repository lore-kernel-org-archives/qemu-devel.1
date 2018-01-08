Received: from eggs.gnu.org ([2001:4830:134:3::10]:33672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEi-00087S-Hc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEf-0008UQ-D0
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:24 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:42952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEf-0008Tp-8g
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:21 -0500
Received: by mail-qt0-x244.google.com with SMTP id g9so14526144qth.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:28:55 -0300
Message-Id: <20180108172904.8772-4-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/12] slirp: avoid IN6_IS_ADDR_UNSPECIFIED(),
 rather use in6_zero()
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

  slirp/ip6_icmp.c:80:38: warning: taking address of packed member 'ip_src' of class or
        structure 'ip6' may result in an unaligned pointer value
        [-Waddress-of-packed-member]
              IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                       ^~~~~~~~~~
  /usr/include/netinet6/in6.h:238:42: note: expanded from macro 'IN6_IS_ADDR_UNSPECIFIED'
          ((*(const __uint32_t *)(const void *)(&(a)->s6_addr[0]) == 0) && \
                                                  ^

Reported-by: John Arbuckle <programmingkidx@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 slirp/ip6_icmp.c  | 6 +++---
 slirp/ndp_table.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 777eb574be..ee333d05a2 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -77,7 +77,7 @@ void icmp6_send_error(struct mbuf *m, uint8_t type, uint8_t code)
     DEBUG_ARGS((dfd, " type = %d, code = %d\n", type, code));
 
     if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
-            IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
+            in6_zero(&ip->ip_src)) {
         /* TODO icmp error? */
         return;
     }
@@ -272,7 +272,7 @@ static void ndp_send_na(Slirp *slirp, struct ip6 *ip, struct icmp6 *icmp)
     struct mbuf *t = m_get(slirp);
     struct ip6 *rip = mtod(t, struct ip6 *);
     rip->ip_src = icmp->icmp6_nns.target;
-    if (IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
+    if (in6_zero(&ip->ip_src)) {
         rip->ip_dst = (struct in6_addr)ALLNODES_MULTICAST;
     } else {
         rip->ip_dst = ip->ip_src;
@@ -350,7 +350,7 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, struct ip6 *ip,
                 && icmp->icmp6_code == 0
                 && !IN6_IS_ADDR_MULTICAST(&icmp->icmp6_nns.target)
                 && ntohs(ip->ip_pl) >= ICMP6_NDP_NS_MINLEN
-                && (!IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)
+                && (!in6_zero(&ip->ip_src)
                     || in6_solicitednode_multicast(&ip->ip_dst))) {
             if (in6_equal_host(&icmp->icmp6_nns.target)) {
                 /* Gratuitous NDP */
diff --git a/slirp/ndp_table.c b/slirp/ndp_table.c
index 9d4c39b45c..e1676a0a7b 100644
--- a/slirp/ndp_table.c
+++ b/slirp/ndp_table.c
@@ -23,7 +23,7 @@ void ndp_table_add(Slirp *slirp, struct in6_addr ip_addr,
                 ethaddr[0], ethaddr[1], ethaddr[2],
                 ethaddr[3], ethaddr[4], ethaddr[5]));
 
-    if (IN6_IS_ADDR_MULTICAST(&ip_addr) || IN6_IS_ADDR_UNSPECIFIED(&ip_addr)) {
+    if (IN6_IS_ADDR_MULTICAST(&ip_addr) || in6_zero(&ip_addr)) {
         /* Do not register multicast or unspecified addresses */
         DEBUG_CALL(" abort: do not register multicast or unspecified address");
         return;
@@ -60,7 +60,7 @@ bool ndp_table_search(Slirp *slirp, struct in6_addr ip_addr,
     DEBUG_ARG("ip = %s", addrstr);
 #endif
 
-    assert(!IN6_IS_ADDR_UNSPECIFIED(&ip_addr));
+    assert(!in6_zero(&ip_addr));
 
     /* Multicast address: fec0::abcd:efgh/8 -> 33:33:ab:cd:ef:gh */
     if (IN6_IS_ADDR_MULTICAST(&ip_addr)) {
-- 
2.15.1
