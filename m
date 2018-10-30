Received: from eggs.gnu.org ([2001:4830:134:3::10]:35430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHSOZ-0001GY-A1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHSOW-0003ps-TH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:41:15 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 30 Oct 2018 12:40:48 +0100
Message-Id: <20181030114048.21527-3-philmd@redhat.com>
In-Reply-To: <20181030114048.21527-1-philmd@redhat.com>
References: <20181030114048.21527-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] arm: exynos4: Add dma support for
 smdkc210
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Guenter Roeck <linux@roeck-us.net>

QEMU already supports pl330. Instantiate it for smdkc210.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
[PMD: Do not set default qdev properties]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/exynos4_boards.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 750162cc95..5696b37bf2 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -49,6 +49,9 @@
 #endif
=20
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
+#define SMDK_PL330_BASE0_ADDR       0x12680000
+#define SMDK_PL330_BASE1_ADDR       0x12690000
+#define SMDK_PL330_BASE2_ADDR       0x12850000
=20
 typedef enum Exynos4BoardType {
     EXYNOS4_BOARD_NURI,
@@ -102,6 +105,19 @@ static void lan9215_init(uint32_t base, qemu_irq irq=
)
     }
 }
=20
+static void pl330_init(uint32_t base, qemu_irq irq, int nreq)
+{
+    SysBusDevice *busdev;
+    DeviceState *dev;
+
+    dev =3D qdev_create(NULL, "pl330");
+    qdev_prop_set_uint8(dev, "num_periph_req",  nreq);
+    qdev_init_nofail(dev);
+    busdev =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, base);
+    sysbus_connect_irq(busdev, 0, irq);
+}
+
 static void exynos4_boards_init_ram(Exynos4BoardState *s,
                                     MemoryRegion *system_mem,
                                     unsigned long ram_size)
@@ -171,6 +187,14 @@ static void smdkc210_init(MachineState *machine)
=20
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]=
));
+
+    pl330_init(SMDK_PL330_BASE0_ADDR,
+            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(35, 1)]=
), 32);
+    pl330_init(SMDK_PL330_BASE1_ADDR,
+            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(36, 1)]=
), 32);
+    pl330_init(SMDK_PL330_BASE2_ADDR,
+            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(34, 1)]=
), 1);
+
     arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
 }
=20
--=20
2.17.2
