Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw6-00062Y-PF
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw5-0006rT-Kj
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:18 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60846
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw5-0006pE-CY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:17 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:51 +0000
Message-Id: <20171215184155.2543-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 09/13] lan9118: use inline net_crc32() and
 bitshift instead of compute_mcast_idx()
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
 hw/net/lan9118.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 3db8937cac..b9032dac59 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "hw/devices.h"
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
@@ -504,7 +505,7 @@ static int lan9118_filter(lan9118_state *s, const uint8_t *addr)
         }
     } else {
         /* Hash matching  */
-        hash = compute_mcast_idx(addr);
+        hash = net_crc32(addr, ETH_ALEN) >> 26;
         if (hash & 0x20) {
             return (s->mac_hashh >> (hash & 0x1f)) & 1;
         } else {
-- 
2.11.0
