Received: from eggs.gnu.org ([2001:4830:134:3::10]:43233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw5-00062A-Df
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw4-0006n3-0a
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60820
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw3-0006UX-PQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:15 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:45 +0000
Message-Id: <20171215184155.2543-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 03/13] pcnet: switch pcnet over to use
 net_crc32_le()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

Instead of lnc_mchash() using its own implementation, we can simply call
net_crc32_le() directly and apply the bit shift inline.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/pcnet.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 654455355f..39d5d93525 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -38,6 +38,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
 #include "net/net.h"
+#include "net/eth.h"
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
@@ -522,25 +523,6 @@ static inline void pcnet_rmd_store(PCNetState *s, struct pcnet_RMD *rmd,
            be16_to_cpu(hdr->ether_type));       \
 } while (0)
 
-#define MULTICAST_FILTER_LEN 8
-
-static inline uint32_t lnc_mchash(const uint8_t *ether_addr)
-{
-#define LNC_POLYNOMIAL          0xEDB88320UL
-    uint32_t crc = 0xFFFFFFFF;
-    int idx, bit;
-    uint8_t data;
-
-    for (idx = 0; idx < 6; idx++) {
-        for (data = *ether_addr++, bit = 0; bit < MULTICAST_FILTER_LEN; bit++) {
-            crc = (crc >> 1) ^ (((crc ^ data) & 1) ? LNC_POLYNOMIAL : 0);
-            data >>= 1;
-        }
-    }
-    return crc;
-#undef LNC_POLYNOMIAL
-}
-
 #define CRC(crc, ch)	 (crc = (crc >> 8) ^ crctab[(crc ^ (ch)) & 0xff])
 
 /* generated using the AUTODIN II polynomial
@@ -656,7 +638,7 @@ static inline int ladr_match(PCNetState *s, const uint8_t *buf, int size)
             s->csr[10] & 0xff, s->csr[10] >> 8,
             s->csr[11] & 0xff, s->csr[11] >> 8
         };
-        int index = lnc_mchash(hdr->ether_dhost) >> 26;
+        int index = net_crc32_le(hdr->ether_dhost, ETH_ALEN) >> 26;
         return !!(ladr[index >> 3] & (1 << (index & 7)));
     }
     return 0;
-- 
2.11.0
