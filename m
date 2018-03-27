Received: from eggs.gnu.org ([2001:4830:134:3::10]:55352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f0kRK-0002te-Mb
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f0kRF-0001rt-Of
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:58:46 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com
	([104.47.42.88]:51520
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xhdsaipava40.localdomain>)
	id 1f0kRF-0001rD-En
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:58:41 -0400
From: <saipavanboddu@gmail.com>
Date: Tue, 27 Mar 2018 12:51:13 +0530
Message-ID: <1522135274-15396-2-git-send-email-saipavanboddu@gmail.com>
In-Reply-To: <1522135274-15396-1-git-send-email-saipavanboddu@gmail.com>
References: <1522135274-15396-1-git-send-email-saipavanboddu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [qemu-devel][PATCH v1 2/2] xilinx_spi: use
 qdev_init_gpio_out for gpio init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "Peter A. G. Crosthwaite" <peter.crosthwaite@petalogix.com>
Cc: qemu-devel@nongnu.org

From: Sai Pavan Boddu <saipava@xilinx.com>

useful to connect gpio with qdev_connect_gpio_out

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/ssi/xilinx_spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 83585bc..dcd1a2f 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -323,7 +323,6 @@ static int xilinx_spi_init(SysBusDevice *sbd)
 {
     DeviceState *dev = DEVICE(sbd);
     XilinxSPI *s = XILINX_SPI(dev);
-    int i;
 
     DB_PRINT("\n");
 
@@ -332,9 +331,7 @@ static int xilinx_spi_init(SysBusDevice *sbd)
     sysbus_init_irq(sbd, &s->irq);
     s->cs_lines = g_new0(qemu_irq, s->num_cs);
     ssi_auto_connect_slaves(dev, s->cs_lines, s->spi);
-    for (i = 0; i < s->num_cs; ++i) {
-        sysbus_init_irq(sbd, &s->cs_lines[i]);
-    }
+    qdev_init_gpio_out(dev, s->cs_lines, s->num_cs);
 
     memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
                           "xilinx-spi", R_MAX * 4);
-- 
2.7.4
