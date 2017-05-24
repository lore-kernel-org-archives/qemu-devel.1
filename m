Received: from eggs.gnu.org ([2001:4830:134:3::10]:49851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjors@sjorsgielen.nl>) id 1dDaRT-0000BP-0I
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjors@sjorsgielen.nl>) id 1dDaRS-0001mI-0D
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:51:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjors@sjorsgielen.nl>)
	id 1dDaRR-0001lC-LE
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:51:25 -0400
Received: by mail-wm0-x242.google.com with SMTP id k15so47461491wmh.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 10:51:24 -0700 (PDT)
MIME-Version: 1.0
From: Sjors Gielen <sjors@sjorsgielen.nl>
Date: Wed, 24 May 2017 17:51:12 +0000
Message-ID: <CAPXQAKv-sa4e5gNwPkEQzS5yZM61Lxdip+khwzt0NAYhAYiY9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] [SLIRP] Fix total IP header length in
 forwarded TCP packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org

When forwarding TCP packets, the internal tcpiphdr struct length was wrongly
used inside the IP header. This commit changes the behaviour to what is used
by tcp_output.c, using the correct full IP header + payload length.

Signed-off-by: Sjors Gielen <sjors@sjorsgielen.nl>
---
 slirp/tcp_subr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index ed16e1807f..3d6193657c 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -204,7 +204,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti,
struct mbuf *m,
     m->m_len  -= sizeof(struct tcpiphdr) - sizeof(struct tcphdr)
                                          - sizeof(struct ip);
     ip = mtod(m, struct ip *);
-    ip->ip_len = tlen;
+    ip->ip_len = m->m_len;
     ip->ip_dst = tcpiph_save.ti_dst;
     ip->ip_src = tcpiph_save.ti_src;
     ip->ip_p = tcpiph_save.ti_pr;
@@ -224,7 +224,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti,
struct mbuf *m,
     m->m_len  -= sizeof(struct tcpiphdr) - sizeof(struct tcphdr)
                                          - sizeof(struct ip6);
     ip6 = mtod(m, struct ip6 *);
-    ip6->ip_pl = tlen;
+    ip6->ip_pl = m->m_len;
     ip6->ip_dst = tcpiph_save.ti_dst6;
     ip6->ip_src = tcpiph_save.ti_src6;
     ip6->ip_nh = tcpiph_save.ti_nh6;
-- 
2.13.0
