Received: from eggs.gnu.org ([2001:4830:134:3::10]:43242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw5-00062C-GP
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw4-0006oT-Ia
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60843
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw4-0006mb-CI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:16 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:50 +0000
Message-Id: <20171215184155.2543-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 08/13] opencores_eth: use inline net_crc32()
 and bitshift instead of compute_mcast_idx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

This makes it much easier to compare the multicast CRC calculation endian and
bitshift against the Linux driver implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/opencores_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 268d6a7892..d42b79c08c 100644
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
2.11.0
