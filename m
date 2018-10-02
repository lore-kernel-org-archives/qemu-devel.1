Received: from eggs.gnu.org ([2001:4830:134:3::10]:42923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAq-0003S9-VD
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAq-0007Mp-84
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAq-0007MP-15
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id g15-v6so1189757wru.9
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:25:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 23:25:16 +0200
Message-Id: <20181002212522.23303-8-f4bug@amsat.org>
In-Reply-To: <20181002212522.23303-1-f4bug@amsat.org>
References: <20181002212522.23303-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/12] hw/mips/gt64xxx_pci: Convert
 gt64120_reset() function into Device reset method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

Convert the gt64120_reset() function into a proper Device reset method.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/mips/gt64xxx_pci.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 24ad0ad024..dcd1a66329 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -992,9 +992,9 @@ static void gt64120_pci_set_irq(void *opaque, int irq_num, int level)
 }
 
 
-static void gt64120_reset(void *opaque)
+static void gt64120_reset(DeviceState *dev)
 {
-    GT64120State *s = opaque;
+    GT64120State *s = GT64120_PCI_HOST_BRIDGE(dev);
 
     /* FIXME: Malta specific hw assumptions ahead */
 
@@ -1184,16 +1184,6 @@ PCIBus *gt64120_register(qemu_irq *pic)
     return phb->bus;
 }
 
-static int gt64120_init(SysBusDevice *dev)
-{
-    GT64120State *s;
-
-    s = GT64120_PCI_HOST_BRIDGE(dev);
-
-    qemu_register_reset(gt64120_reset, s);
-    return 0;
-}
-
 static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
     /* FIXME: Malta specific hw assumptions ahead */
@@ -1241,9 +1231,8 @@ static const TypeInfo gt64120_pci_info = {
 static void gt64120_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
 
-    sdc->init = gt64120_init;
+    dc->reset = gt64120_reset;
     dc->vmsd = &vmstate_gt64120;
 }
 
-- 
2.19.0
