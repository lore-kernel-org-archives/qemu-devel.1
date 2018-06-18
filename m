Received: from eggs.gnu.org ([2001:4830:134:3::10]:56702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fV1K5-0002fI-Vy
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fV1K2-0006Jt-BX
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:04:25 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:39415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linux@roeck-us.net>) id 1fV1K2-0006Dh-3b
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:04:22 -0400
From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Jun 2018 14:04:06 -0700
Message-Id: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] bcm2835_aux: Swap RX and TX interrupt
 assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

RX and TX interrupt bits were reversed, resulting in an endless sequence
of serial interupts in the emulated system and the following repeated
error message when booting Linux.

serial8250: too much work for irq61

This results in a boot failure most of the time.

Qemu command line used to reproduce the problem:

	qemu-system-aarch64 -M raspi3 -m 1024 \
	-kernel arch/arm64/boot/Image \
	--append "rdinit=/sbin/init console=ttyS1,115200"
	-initrd rootfs.cpio \
	-dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb \
	-nographic -monitor null -serial null -serial stdio

This is with arm64:defconfig. The root file system was generated using
buildroot.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/char/bcm2835_aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 370dc7e..0364596 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -39,8 +39,8 @@
 #define AUX_MU_BAUD_REG 0x68
 
 /* bits in IER/IIR registers */
-#define TX_INT  0x1
-#define RX_INT  0x2
+#define RX_INT  0x1
+#define TX_INT  0x2
 
 static void bcm2835_aux_update(BCM2835AuxState *s)
 {
-- 
2.7.4
