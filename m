Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePv09-00019U-GR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePv08-0005qR-MK
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:29 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60869
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePv08-0005pA-GA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:28 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:53 +0000
Message-Id: <20171215184155.2543-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 11/13] ne2000: use inline net_crc32() and
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
 hw/net/ne2000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 3938e6ddd8..7e3b77c00f 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "ne2000.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
@@ -201,7 +202,7 @@ ssize_t ne2000_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
             /* multicast */
             if (!(s->rxcr & 0x08))
                 return size;
-            mcast_idx = compute_mcast_idx(buf);
+            mcast_idx = net_crc32(buf, ETH_ALEN) >> 26;
             if (!(s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7))))
                 return size;
         } else if (s->mem[0] == buf[0] &&
-- 
2.11.0
