Received: from eggs.gnu.org ([2001:4830:134:3::10]:44084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cNp81-00070d-Gj
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 18:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cNp7y-0002Qz-GA
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 18:01:25 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cNp7y-0002Pa-5p
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 18:01:22 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  2 Jan 2017 00:00:35 +0100
Message-Id: <1483311635-27905-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] dp8393x: fix dp8393x_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

address_space_rw() access size must be multiplied by width.
dp8393x_receive() must return the number of bytes read, not the length
of the last memory access.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 17f0338..3506bca 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -766,10 +766,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
+        size = sizeof(uint16_t) * width;
         data[0 * width] = 0; /* in_use */
         address_space_rw(&s->as,
             ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) + sizeof(uint16_t) * 6 * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
@@ -783,7 +784,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* Done */
     dp8393x_update_irq(s);
 
-    return size;
+    return rx_len;
 }
 
 static void dp8393x_reset(DeviceState *dev)
-- 
2.7.4
