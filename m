Received: from eggs.gnu.org ([2001:4830:134:3::10]:40908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fiUlS-0003Nc-RG
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fiUlP-0000uB-PW
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:08:22 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aoates@google.com>) id 1fiUlP-0000rQ-K2
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:08:19 -0400
Received: by mail-qk0-x244.google.com with SMTP id b66-v6so27909qkj.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 18:08:19 -0700 (PDT)
From: aoates@google.com
Date: Wed, 25 Jul 2018 21:08:12 -0400
Message-Id: <20180726010812.5909-1-aoates@google.com>
Subject: [Qemu-devel] [PATCH] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org
Cc: Andrew Oates <aoates@google.com>

From: Andrew Oates <aoates@google.com>

On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
read from.  On macOS, however, the socket acts like a SOCK_RAW socket
and includes the IP header as well.

This change strips the extra IP header from the received packet on macOS
before sending it to the guest.

Signed-off-by: Andrew Oates <aoates@google.com>
---
 slirp/ip_icmp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 0b667a429a..5fa67814f4 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -420,7 +420,15 @@ void icmp_receive(struct socket *so)
     icp = mtod(m, struct icmp *);
 
     id = icp->icmp_id;
-    len = qemu_recv(so->s, icp, m->m_len, 0);
+    len = qemu_recv(so->s, icp, M_ROOM(m), 0);
+#ifdef CONFIG_DARWIN
+    if (len > 0) {
+        /* Skip the IP header that OS X (unlike Linux) includes. */
+        struct ip *inner_ip = mtod(m, struct ip *);
+        int inner_hlen = inner_ip->ip_hl << 2;
+        memmove(icp, (unsigned char *)icp + inner_hlen, len - inner_hlen);
+    }
+#endif
     icp->icmp_id = id;
 
     m->m_data -= hlen;
-- 
2.17.0
