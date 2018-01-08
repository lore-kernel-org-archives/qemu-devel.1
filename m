Received: from eggs.gnu.org ([2001:4830:134:3::10]:33793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF1-0008OM-Bw
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEy-0000S1-9z
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:43 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEy-0000RH-5t
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:40 -0500
Received: by mail-qt0-x242.google.com with SMTP id g9so14527374qth.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:29:01 -0300
Message-Id: <20180108172904.8772-10-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/12] slirp: add in6_dhcp_multicast()
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 slirp/dhcpv6.h | 3 +++
 slirp/udp6.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/slirp/dhcpv6.h b/slirp/dhcpv6.h
index 9189cd3f2d..3373f6cb89 100644
--- a/slirp/dhcpv6.h
+++ b/slirp/dhcpv6.h
@@ -17,6 +17,9 @@
                             0x00, 0x00, 0x00, 0x00,\
                             0x00, 0x01, 0x00, 0x02 } }
 
+#define in6_dhcp_multicast(a)\
+    in6_equal(a, &(struct in6_addr)ALLDHCP_MULTICAST)
+
 void dhcpv6_input(struct sockaddr_in6 *srcsas, struct mbuf *m);
 
 #endif
diff --git a/slirp/udp6.c b/slirp/udp6.c
index 9fa314bc2d..7c4a6b003a 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -65,7 +65,7 @@ void udp6_input(struct mbuf *m)
     /* handle DHCPv6 */
     if (ntohs(uh->uh_dport) == DHCPV6_SERVER_PORT &&
         (in6_equal(&ip->ip_dst, &slirp->vhost_addr6) ||
-         in6_equal(&ip->ip_dst, &(struct in6_addr)ALLDHCP_MULTICAST))) {
+         in6_dhcp_multicast(&ip->ip_dst))) {
         m->m_data += iphlen;
         m->m_len -= iphlen;
         dhcpv6_input(&lhost, m);
-- 
2.15.1
