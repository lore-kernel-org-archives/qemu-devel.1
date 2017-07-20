Received: from eggs.gnu.org ([2001:4830:134:3::10]:35330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mp-0006Ag-JW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mo-0004pt-On
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:19 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY6mo-0004pk-I0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:18 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 10:25:20 +0200
Message-Id: <1500539123-23884-6-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
References: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH 5/8] usb-ccid: Fix USB descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Fritsch <stefan_fritsch@genua.de>

From: Stefan Fritsch <stefan_fritsch@genua.de>

- We want to support both T=0 and T=1. Additionally, note that all
  fields in USB descriptors are little endian and the supported
  protocols are in the lowest byte the of the 32-Bit dwProtocols field.
- We want APDU level exchanges. This saves us from PPS exchanges and from
  APDU reassembly from T=1 packets.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
---
 hw/usb/dev-smartcard-reader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 769949144b..bc4dc35d3f 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -353,8 +353,8 @@ static const uint8_t qemu_ccid_descriptor[] = {
                      */
         0x07,       /* u8  bVoltageSupport; 01h - 5.0v, 02h - 3.0, 03 - 1.8 */
 
-        0x00, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR = 0000h.*/
-        0x01, 0x00, /* PPPP: 0001h = Protocol T=0, 0002h = Protocol T=1 */
+        0x03, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR = 0000h.*/
+        0x00, 0x00, /* PPPP: 0001h = Protocol T=0, 0002h = Protocol T=1 */
                     /* u32 dwDefaultClock; in kHZ (0x0fa0 is 4 MHz) */
         0xa0, 0x0f, 0x00, 0x00,
                     /* u32 dwMaximumClock; */
@@ -397,7 +397,7 @@ static const uint8_t qemu_ccid_descriptor[] = {
                      * insertion and removal. Must set bit 5 in bmAttributes
                      * in Configuration descriptor if 100000 is set.
                      */
-        0xfe, 0x04, 0x01, 0x00,
+        0xfe, 0x04, 0x04, 0x00,
                     /*
                      * u32 dwMaxCCIDMessageLength; For extended APDU in
                      * [261 + 10 , 65544 + 10]. Otherwise the minimum is
-- 
2.11.0
