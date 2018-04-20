Received: from eggs.gnu.org ([2001:4830:134:3::10]:44338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1f9apu-0006lo-BC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1f9apt-0005zI-FA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:32:42 -0400
From: Jason Andryuk <jandryuk@gmail.com>
Date: Fri, 20 Apr 2018 14:32:19 -0400
Message-Id: <20180420183219.20722-1-jandryuk@gmail.com>
Subject: [Qemu-devel] [PATCH] ccid: Fix dwProtocols advertisement of T=0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: alevy@redhat.com, Jason Andryuk <jandryuk@gmail.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

Commit d7d218ef02d87c637d20d64da8f575d434ff6f78 attempted to change
dwProtocols to only advertise support for T=0 and not T=1.  The change
was incorrect as it changed 0x00000003 to 0x00010000.

lsusb -v in a linux guest shows:
"dwProtocols         65536  (Invalid values detected)", though the
smart card could still be accessed.  Windows 7 does not detect inserted
smart cards and logs the the following Error in the Event Logs:

    Source: Smart Card Service
    Event ID: 610
    Smart Card Reader 'QEMU QEMU USB CCID 0' rejected IOCTL SET_PROTOCOL:
    Incorrect function. If this error persists, your smart card or reader
    may not be functioning correctly

    Command Header: 03 00 00 00

Setting to 0x00000001 fixes the Windows issue.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Cc: qemu-stable@nongnu.org
---
 hw/usb/dev-smartcard-reader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index e6468057a0..cabb564788 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -329,8 +329,8 @@ static const uint8_t qemu_ccid_descriptor[] = {
                      */
         0x07,       /* u8  bVoltageSupport; 01h - 5.0v, 02h - 3.0, 03 - 1.8 */
 
-        0x00, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR = 0000h.*/
-        0x01, 0x00, /* PPPP: 0001h = Protocol T=0, 0002h = Protocol T=1 */
+        0x01, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR = 0000h.*/
+        0x00, 0x00, /* PPPP: 0001h = Protocol T=0, 0002h = Protocol T=1 */
                     /* u32 dwDefaultClock; in kHZ (0x0fa0 is 4 MHz) */
         0xa0, 0x0f, 0x00, 0x00,
                     /* u32 dwMaximumClock; */
-- 
2.14.3
