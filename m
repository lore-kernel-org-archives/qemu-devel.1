Received: from eggs.gnu.org ([2001:4830:134:3::10]:54958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3p-0006Pj-9x
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3l-0006NX-Vp
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:41 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57470
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dii3l-0006Am-DY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:37 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 18 Aug 2017 15:15:07 +0100
Message-Id: <1503065708-28277-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/4] pcnet: switch lnc_mchash() over to use
 net_crc32_le()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/pcnet.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 6544553..c050993 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -522,23 +522,9 @@ static inline void pcnet_rmd_store(PCNetState *s, struct pcnet_RMD *rmd,
            be16_to_cpu(hdr->ether_type));       \
 } while (0)
 
-#define MULTICAST_FILTER_LEN 8
-
 static inline uint32_t lnc_mchash(const uint8_t *ether_addr)
 {
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
+    return net_crc32_le(ether_addr, 6);
 }
 
 #define CRC(crc, ch)	 (crc = (crc >> 8) ^ crctab[(crc ^ (ch)) & 0xff])
-- 
1.7.10.4
