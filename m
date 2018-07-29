Received: from eggs.gnu.org ([2001:4830:134:3::10]:47240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fjav1-0001xh-Uh
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 21:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fjauy-0004xz-0I
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 21:54:48 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aoates@google.com>) id 1fjaux-0004xv-Rx
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 21:54:43 -0400
Received: by mail-qt0-x242.google.com with SMTP id h4-v6so8863614qtj.7
	for <qemu-devel@nongnu.org>; Sat, 28 Jul 2018 18:54:43 -0700 (PDT)
From: aoates@google.com
Date: Sat, 28 Jul 2018 21:54:26 -0400
Message-Id: <20180729015426.67133-1-aoates@google.com>
Subject: [Qemu-devel] [PATCH v2] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: Andrew Oates <aoates@google.com>

From: Andrew Oates <aoates@google.com>

On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
read from.  On macOS, however, the socket acts like a SOCK_RAW socket
and includes the IP header as well.

This change strips the extra IP header from the received packet on macOS
before sending it to the guest.

Signed-off-by: Andrew Oates <aoates@google.com>
---
v2: check validity of inner_hlen and update len appropriately

 slirp/ip_icmp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 0b667a429a..76c6d54b11 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -420,7 +420,21 @@ void icmp_receive(struct socket *so)
     icp = mtod(m, struct icmp *);
 
     id = icp->icmp_id;
-    len = qemu_recv(so->s, icp, m->m_len, 0);
+    len = qemu_recv(so->s, icp, M_ROOM(m), 0);
+#ifdef CONFIG_DARWIN
+    if (len > 0) {
+        /* Skip the IP header that OS X (unlike Linux) includes. */
+        struct ip *inner_ip = mtod(m, struct ip *);
+        int inner_hlen = inner_ip->ip_hl << 2;
+        if (inner_hlen > len) {
+            len = -1;
+            errno = -EINVAL;
+        } else {
+            len -= inner_hlen;
+            memmove(icp, (unsigned char *)icp + inner_hlen, len);
+        }
+    }
+#endif
     icp->icmp_id = id;
 
     m->m_data -= hlen;
-- 
2.17.0
