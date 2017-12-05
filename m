Received: from eggs.gnu.org ([2001:4830:134:3::10]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eM8QX-0004Uq-4s
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eM8QW-0006wE-6e
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:18:05 -0500
Received: from chuckie.co.uk ([82.165.15.123]:38204
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eM8QV-0006vn-W7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:18:04 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  5 Dec 2017 08:17:43 +0000
Message-Id: <20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 4/5] eepro100: switch
 e100_compute_mcast_idx() over to use net_crc32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/eepro100.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 1c0def555b..4fe94b7471 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -327,26 +327,9 @@ static const uint16_t eepro100_mdi_mask[] = {
 
 static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s);
 
-/* From FreeBSD (locally modified). */
 static unsigned e100_compute_mcast_idx(const uint8_t *ep)
 {
-    uint32_t crc;
-    int carry, i, j;
-    uint8_t b;
-
-    crc = 0xffffffff;
-    for (i = 0; i < 6; i++) {
-        b = *ep++;
-        for (j = 0; j < 8; j++) {
-            carry = ((crc & 0x80000000L) ? 1 : 0) ^ (b & 0x01);
-            crc <<= 1;
-            b >>= 1;
-            if (carry) {
-                crc = ((crc ^ POLYNOMIAL) | carry);
-            }
-        }
-    }
-    return (crc & BITS(7, 2)) >> 2;
+    return (net_crc32(ep, 6) & BITS(7, 2)) >> 2;
 }
 
 /* Read a 16 bit control/status (CSR) register. */
-- 
2.11.0
