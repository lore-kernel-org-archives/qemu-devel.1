Received: from eggs.gnu.org ([2001:4830:134:3::10]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc2A-0007XG-Vv
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc2A-00083i-65
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fhc29-00082M-Ty
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:58 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc28-0007jO-Mg
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:41:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 15:41:52 +0100
Message-Id: <20180723144152.13885-6-peter.maydell@linaro.org>
In-Reply-To: <20180723144152.13885-1-peter.maydell@linaro.org>
References: <20180723144152.13885-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 5/5] hw/intc/exynos4210_gic: Turn instance_init
 into realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The instance_init function of the "exynos4210.gic" device creates a
new "arm_gic" device and immediately realizes it with qdev_init_nofail().
This will leave a lot of object in the QOM tree during introspection of
the "exynos4210.gic" device, e.g. reproducible by starting QEMU like this:

qemu-system-aarch64 -M none -nodefaults -nographic -monitor stdio

And then by running "info qom-tree" at the HMP monitor, followed by
"device_add exynos4210.gic,help" and finally checking "info qom-tree"
again.

Also note that qdev_init_nofail() can exit QEMU in case of errors - and
this must never happen during an instance_init function, otherwise QEMU
could terminate unexpectedly during introspection of a device.

Since most of the code that follows the qdev_init_nofail() depends on
the realized "gicbusdev", the easiest solution to the problem is to
turn the whole instance_init function into a realize function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1532337784-334-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/exynos4210_gic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index b6b00a4f589..69f9c18d736 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -281,9 +281,9 @@ static void exynos4210_gic_set_irq(void *opaque, int irq, int level)
     qemu_set_irq(qdev_get_gpio_in(s->gic, irq), level);
 }
 
-static void exynos4210_gic_init(Object *obj)
+static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(obj);
+    Object *obj = OBJECT(dev);
     Exynos4210GicState *s = EXYNOS4210_GIC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     const char cpu_prefix[] = "exynos4210-gic-alias_cpu";
@@ -347,13 +347,13 @@ static void exynos4210_gic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->props = exynos4210_gic_properties;
+    dc->realize = exynos4210_gic_realize;
 }
 
 static const TypeInfo exynos4210_gic_info = {
     .name          = TYPE_EXYNOS4210_GIC,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Exynos4210GicState),
-    .instance_init = exynos4210_gic_init,
     .class_init    = exynos4210_gic_class_init,
 };
 
-- 
2.17.1
