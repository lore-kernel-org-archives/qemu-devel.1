Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw5-000629-DB
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw2-0006gt-A9
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60833
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw2-0006e6-4F
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:14 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:48 +0000
Message-Id: <20171215184155.2543-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 06/13] sungem: fix multicast filter CRC
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

>From the Linux sungem driver, we know that the multicast filter CRC is
implemented using ether_crc_le() which isn't the same as calling zlib's
crc32() function (the zlib implementation requires a complemented initial value
and also returns the complemented result).

Fix the multicast filter by simply using the new net_crc32_le() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/sungem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 6aa8d1117b..60f1e479f3 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -11,12 +11,11 @@
 #include "hw/pci/pci.h"
 #include "qemu/log.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "net/checksum.h"
 #include "hw/net/mii.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-/* For crc32 */
-#include <zlib.h>
 
 #define TYPE_SUNGEM "sungem"
 
@@ -595,7 +594,7 @@ static ssize_t sungem_receive(NetClientState *nc, const uint8_t *buf,
     }
 
     /* Get MAC crc */
-    mac_crc = crc32(~0, buf, 6);
+    mac_crc = net_crc32_le(buf, ETH_ALEN);
 
     /* Packet isn't for me ? */
     rx_cond = sungem_check_rx_mac(s, buf, mac_crc);
-- 
2.11.0
