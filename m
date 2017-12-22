Received: from eggs.gnu.org ([2001:4830:134:3::10]:38215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsp-0007gC-Kq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCso-0000fD-QA
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCso-0000dR-Js
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:22 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:29 +0800
Message-Id: <1513908937-16034-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 10/18] opencores_eth: use inline net_crc32() and
 bitshift instead of compute_mcast_idx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This makes it much easier to compare the multicast CRC calculation endian and
bitshift against the Linux driver implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/opencores_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 268d6a7..d42b79c 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -36,6 +36,7 @@
 #include "hw/net/mii.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
@@ -373,7 +374,7 @@ static ssize_t open_eth_receive(NetClientState *nc,
         if (memcmp(buf, bcast_addr, sizeof(bcast_addr)) == 0) {
             miss = GET_REGBIT(s, MODER, BRO);
         } else if ((buf[0] & 0x1) || GET_REGBIT(s, MODER, IAM)) {
-            unsigned mcast_idx = compute_mcast_idx(buf);
+            unsigned mcast_idx = net_crc32(buf, ETH_ALEN) >> 26;
             miss = !(s->regs[HASH0 + mcast_idx / 32] &
                     (1 << (mcast_idx % 32)));
             trace_open_eth_receive_mcast(
-- 
2.7.4
