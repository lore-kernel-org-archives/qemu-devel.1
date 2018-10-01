Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XV-00041R-04
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OF-0007Ht-Na
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OF-0007Hd-Gx
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id q8-v6so280854wmq.4
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:31 +0200
Message-Id: <20181001220942.2382-5-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/15] hw/ssi/xilinx_spi: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Move from the legacy SysBusDevice::init method to using DeviceState::realize.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ssi/xilinx_spi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 83585bc8b2..3dae303d5b 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -319,9 +319,9 @@ static const MemoryRegionOps spi_ops = {
     }
 };
 
-static int xilinx_spi_init(SysBusDevice *sbd)
+static void xilinx_spi_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     XilinxSPI *s = XILINX_SPI(dev);
     int i;
 
@@ -344,8 +344,6 @@ static int xilinx_spi_init(SysBusDevice *sbd)
 
     fifo8_create(&s->tx_fifo, FIFO_CAPACITY);
     fifo8_create(&s->rx_fifo, FIFO_CAPACITY);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_xilinx_spi = {
@@ -368,9 +366,8 @@ static Property xilinx_spi_properties[] = {
 static void xilinx_spi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = xilinx_spi_init;
+    dc->realize = xilinx_spi_realize;
     dc->reset = xlx_spi_reset;
     dc->props = xilinx_spi_properties;
     dc->vmsd = &vmstate_xilinx_spi;
-- 
2.19.0
