Received: from eggs.gnu.org ([2001:4830:134:3::10]:48597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d1Iuv-00036S-DM
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d1Iuu-0004Ow-Lm
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:43:05 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ytht.net@gmail.com>) id 1d1Iuu-0004OP-H0
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:43:04 -0400
Received: by mail-io0-x242.google.com with SMTP id x86so20593169ioe.3
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 13:43:04 -0700 (PDT)
From: Tao Wu <ytht.net@gmail.com>
Date: Thu, 20 Apr 2017 13:43:01 -0700
Message-Id: <20170420204301.154912-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH 1/1] slirp: don't zero ti_i since we acccess it
 later.
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

The current code looks buggy, we zero ti_i while we access
ti_dst/ti_src later.

Signed-off-by: Tao Wu <lepton@google.com>
---
 slirp/tcp_subr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index dc8b4bbb50..398d6b30d3 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -148,7 +148,6 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, struct mbuf *m,
 		m->m_data += IF_MAXLINKHDR;
 		*mtod(m, struct tcpiphdr *) = *ti;
 		ti = mtod(m, struct tcpiphdr *);
-		memset(&ti->ti, 0, sizeof(ti->ti));
 		flags = TH_ACK;
 	} else {
 		/*
-- 
2.12.2.816.g2cccc81164-goog
