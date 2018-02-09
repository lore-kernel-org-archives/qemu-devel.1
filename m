Received: from eggs.gnu.org ([2001:4830:134:3::10]:54035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDa-0007M5-7J
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDW-0001Ee-Vf
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:06 -0500
Received: from leibniz.telenet-ops.be ([2a02:1800:110:4::f00:d]:33980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1ekBDW-0001DH-K3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:02 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be
	[IPv6:2a02:1800:110:4::f00:1a])
	by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3zdJvz3csyzMqc1P
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:32:15 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  9 Feb 2018 16:16:52 +0100
Message-Id: <1518189413-2761-6-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
References: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH/RFC 5/6] gpio: rcar: Add virtualization
 workarounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, kvm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, qemu-devel@nongnu.org, Geert Uytterhoeven <geert+renesas@glider.be>

Allow to enable the driver if virtualization is enabled.

Handle the absence of clocks and interrupts, to support guests that
don't provide these yet.

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be dropped once clocks and interrupts are supported on the guest.
---
 drivers/gpio/Kconfig     |  2 +-
 drivers/gpio/gpio-rcar.c | 28 ++++++++++++----------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d6a8e851ad13b8e6..50eeaa3bb0749b84 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -386,7 +386,7 @@ config GPIO_PXA
 
 config GPIO_RCAR
 	tristate "Renesas R-Car GPIO"
-	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_RENESAS || VIRTIO_MMIO || COMPILE_TEST
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to support GPIO on Renesas R-Car SoCs.
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e76de57dd617d7e2..bc205b7fbb30e892 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -442,22 +442,16 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	p->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(p->clk)) {
-		if (p->needs_clk) {
-			dev_err(dev, "unable to get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err0;
-		}
+		if (p->needs_clk)
+			dev_warn(dev, "missing clock, ignoring\n");
 		p->clk = NULL;
 	}
 
 	pm_runtime_enable(dev);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(dev, "missing IRQ\n");
-		ret = -EINVAL;
-		goto err0;
-	}
+	if (!irq)
+		dev_warn(dev, "missing IRQ, ignoring\n");
 
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	p->base = devm_ioremap_resource(dev, io);
@@ -502,12 +496,14 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	p->irq_parent = irq->start;
-	if (devm_request_irq(dev, irq->start, gpio_rcar_irq_handler,
-			     IRQF_SHARED, name, p)) {
-		dev_err(dev, "failed to request IRQ\n");
-		ret = -ENOENT;
-		goto err1;
+	if (irq) {
+		p->irq_parent = irq->start;
+		if (devm_request_irq(dev, irq->start, gpio_rcar_irq_handler,
+				     IRQF_SHARED, name, p)) {
+			dev_err(dev, "failed to request IRQ\n");
+			ret = -ENOENT;
+			goto err1;
+		}
 	}
 
 	dev_info(dev, "driving %d GPIOs\n", npins);
-- 
2.7.4
