Received: from eggs.gnu.org ([2001:4830:134:3::10]:39345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjmna-00061q-I8
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjmnX-0004h9-CZ
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:35:54 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fjmnX-0004gB-67
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:35:51 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 29 Jul 2018 16:35:45 +0200
Message-Id: <20180729143545.6978-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
References: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 1/1] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com
Cc: Andrew Oates <aoates@google.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Andrew Oates <aoates@google.com>

On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
read from.  On macOS, however, the socket acts like a SOCK_RAW socket
and includes the IP header as well.

This change strips the extra IP header from the received packet on macOS
before sending it to the guest.

Signed-off-by: Andrew Oates <aoates@google.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip_icmp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 0b667a429a..6316427ed3 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -420,7 +420,21 @@ void icmp_receive(struct socket *so)
     icp = mtod(m, struct icmp *);
 
     id = icp->icmp_id;
-    len = qemu_recv(so->s, icp, m->m_len, 0);
+    len = qemu_recv(so->s, icp, M_ROOM(m), 0);
+#ifdef CONFIG_DARWIN
+    if (len >= sizeof(struct ip)) {
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
2.18.0
