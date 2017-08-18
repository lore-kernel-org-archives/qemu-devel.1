Received: from eggs.gnu.org ([2001:4830:134:3::10]:54959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3p-0006Pk-9z
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3m-0006OF-It
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:41 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57474
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dii3m-0006DO-6Q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:38 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 18 Aug 2017 15:15:08 +0100
Message-Id: <1503065708-28277-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/4] eepro100: switch e100_compute_mcast_idx()
 over to use net_crc32()
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
 hw/net/eepro100.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 5a4774a..4226572 100644
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
1.7.10.4
