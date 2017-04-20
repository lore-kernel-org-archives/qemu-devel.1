Received: from eggs.gnu.org ([2001:4830:134:3::10]:44048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d1Ig9-0007Ij-Bm
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d1Ig8-0001Yt-F8
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:27:49 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ytht.net@gmail.com>) id 1d1Ig8-0001Yb-AB
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:27:48 -0400
Received: by mail-io0-x241.google.com with SMTP id x86so20441621ioe.3
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 13:27:48 -0700 (PDT)
From: Tao Wu <ytht.net@gmail.com>
Date: Thu, 20 Apr 2017 13:27:45 -0700
Message-Id: <20170420202745.149601-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH] Fix wrong length in IP header in tcp_respond.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>

This bug was introduced by https://github.com/qemu/qemu/commit/98c6305
And then we 'fix' it in
https://github.com/qemu/qemu/commit/27d92e
Actually I believe the root cause was that we sent out a RST packet with
wrong length and then get ignored by OS.

Signed-off-by: Tao Wu <lepton@google.com>
---
 slirp/tcp_subr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index ed16e1807f..dc8b4bbb50 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -204,7 +204,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, struct mbuf *m,
 	    m->m_len  -= sizeof(struct tcpiphdr) - sizeof(struct tcphdr)
 	                                         - sizeof(struct ip);
 	    ip = mtod(m, struct ip *);
-	    ip->ip_len = tlen;
+	    ip->ip_len = m->m_len;
 	    ip->ip_dst = tcpiph_save.ti_dst;
 	    ip->ip_src = tcpiph_save.ti_src;
 	    ip->ip_p = tcpiph_save.ti_pr;
@@ -224,7 +224,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, struct mbuf *m,
 	    m->m_len  -= sizeof(struct tcpiphdr) - sizeof(struct tcphdr)
 	                                         - sizeof(struct ip6);
 	    ip6 = mtod(m, struct ip6 *);
-	    ip6->ip_pl = tlen;
+	    ip6->ip_pl = tcpiph_save.ti_len;
 	    ip6->ip_dst = tcpiph_save.ti_dst6;
 	    ip6->ip_src = tcpiph_save.ti_src6;
 	    ip6->ip_nh = tcpiph_save.ti_nh6;
-- 
2.12.2.816.g2cccc81164-goog
