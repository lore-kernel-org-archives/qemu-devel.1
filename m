Received: from eggs.gnu.org ([208.118.235.92]:34751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gc06B-000705-7g
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 22:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gc066-0007Y4-6J
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 22:43:11 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gc066-0007XS-0n
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 22:43:06 -0500
Received: by mail-pg1-x544.google.com with SMTP id m1so7067187pgq.8
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 19:43:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 14:42:54 +1100
Message-Id: <20181226034254.17842-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

The pointer may be unaligned, so we must use our routines for that.
At the same time, we might as well use the big-endian version
instead of ntohs.

This fixes sparc64 host SIGBUS during pxe boot.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 slirp/slirp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 322edf51eb..a116f43878 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -851,7 +851,7 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
     if (pkt_len < ETH_HLEN)
         return;
 
-    proto = ntohs(*(uint16_t *)(pkt + 12));
+    proto = lduw_be_p(pkt + 12);
     switch(proto) {
     case ETH_P_ARP:
         arp_input(slirp, pkt, pkt_len);
-- 
2.17.2
