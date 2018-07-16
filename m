Received: from eggs.gnu.org ([2001:4830:134:3::10]:50700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aa-0008Vi-CV
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aZ-0005ao-DB
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:08 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aZ-0005ZO-51
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aX-00011L-VK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:42:58 +0100
Message-Id: <20180716164300.6731-7-peter.maydell@linaro.org>
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 6/8] bcm2835_aux: Swap RX and TX interrupt
 assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Guenter Roeck <linux@roeck-us.net>

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

NB that this error likely arises from an erratum in the
BCM2835 datasheet where the TX and RX bits were swapped
in the AU_MU_IER_REG description (but correct for IIR):
 https://elinux.org/BCM2835_datasheet_errata#p12

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 1529355846-25102-1-git-send-email-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added NB about datasheet]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/bcm2835_aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 370dc7e2968..0364596c552 100644
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
2.17.1
