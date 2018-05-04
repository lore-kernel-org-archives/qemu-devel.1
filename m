Received: from eggs.gnu.org ([2001:4830:134:3::10]:44159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh5B-0006fd-Lw
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh58-0006ZH-EO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=6553081d8=Alistair.Francis@wdc.com>)
	id 1fEh58-0006Yz-1w
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:13:30 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri,  4 May 2018 13:13:12 -0700
Message-Id: <6634a98e5558a060369ac365e8ea2fd960af5b81.1525464177.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1525464177.git.alistair.francis@wdc.com>
References: <cover.1525464177.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/4] hw/riscv/sifive_plic: Use gpios instead
 of irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alistair23@gmail.com, palmer@sifive.com, mjc@sifive.com

Instead of creating the interrupt in lines with qemu_allocate_irq() use
qdev_init_gpio_in() as this gives us the ability to use the qdev*gpio*()
helpers later on.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index a4ac910ca9..81b6b5245b 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -431,7 +431,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
     SiFivePLICState *plic = SIFIVE_PLIC(dev);
-    int i;
 
     memory_region_init_io(&plic->mmio, OBJECT(dev), &sifive_plic_ops, plic,
                           TYPE_SIFIVE_PLIC, plic->aperture_size);
@@ -444,9 +443,7 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
     plic->enable = g_new0(uint32_t, plic->bitfield_words * plic->num_addrs);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &plic->mmio);
     plic->irqs = g_new0(qemu_irq, plic->num_sources + 1);
-    for (i = 0; i <= plic->num_sources; i++) {
-        plic->irqs[i] = qemu_allocate_irq(sifive_plic_irq_request, plic, i);
-    }
+    qdev_init_gpio_in(dev, sifive_plic_irq_request, plic->num_sources);
 }
 
 static void sifive_plic_class_init(ObjectClass *klass, void *data)
-- 
2.17.0
