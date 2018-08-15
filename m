Received: from eggs.gnu.org ([2001:4830:134:3::10]:53024)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3bJFzWwYKCj8bpbufthpphmf.dpnrfnv-efwfmopohov.psh@flex--aoates.bounces.google.com>)
	id 1fpleg-0006lS-Vk
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3bJFzWwYKCj8bpbufthpphmf.dpnrfnv-efwfmopohov.psh@flex--aoates.bounces.google.com>)
	id 1fpleg-0003ed-1A
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:35:26 -0400
Received: from mail-ua1-x949.google.com ([2607:f8b0:4864:20::949]:48999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3bJFzWwYKCj8bpbufthpphmf.dpnrfnv-efwfmopohov.psh@flex--aoates.bounces.google.com>)
	id 1fplef-0003eK-GK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:35:25 -0400
Received: by mail-ua1-x949.google.com with SMTP id k17-v6so11641779uao.15
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 19:35:25 -0700 (PDT)
Date: Tue, 14 Aug 2018 22:35:21 -0400
Message-Id: <20180815023521.185705-1-aoates@google.com>
Mime-Version: 1.0
From: Andrew Oates <aoates@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH v3] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org
Cc: Andrew Oates <aoates@google.com>

On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
read from.  On macOS, however, the socket acts like a SOCK_RAW socket
and includes the IP header as well.

This change strips the extra IP header from the received packet on macOS
before sending it to the guest.  SOCK_DGRAM ICMP sockets aren't
supported on other BSDs, but we enable this behavior for them as well to
treat the sockets the same as raw sockets.

Signed-off-by: Andrew Oates <aoates@google.com>
---
v2: check validity of inner_hlen and update len appropriately
v3: CONFIG_DARWIN -> CONFIG_BSD; add comment explaining #ifdef

 slirp/ip_icmp.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 0b667a429a..0e289fd9d9 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -420,7 +420,29 @@ void icmp_receive(struct socket *so)
     icp = mtod(m, struct icmp *);
 
     id = icp->icmp_id;
-    len = qemu_recv(so->s, icp, m->m_len, 0);
+    len = qemu_recv(so->s, icp, M_ROOM(m), 0);
+    /*
+     * The behavior of reading SOCK_DGRAM+IPPROTO_ICMP sockets is inconsistent
+     * between host OSes.  On Linux, only the ICMP header and payload is
+     * included.  On macOS/Darwin, the socket acts like a raw socket and
+     * includes the IP header as well.  On other BSDs, SOCK_DGRAM+IPPROTO_ICMP
+     * sockets aren't supported at all, so we treat them like raw sockets.  It
+     * isn't possible to detect this difference at runtime, so we must use an
+     * #ifdef to determine if we need to remove the IP header.
+     */
+#ifdef CONFIG_BSD
+    if (len > 0) {
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
2.18.0.865.gffc8e1a3cd6-goog
