Received: from eggs.gnu.org ([2001:4830:134:3::10]:42665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHZjn-0005dG-Bw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHZjd-0007wK-GN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:31:34 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 30 Oct 2018 20:30:43 +0100
Message-Id: <20181030193044.25954-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] arm: exynos4: Add dma support for smdkc210
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

Relevant part of Linux arch/arm/boot/dts/exynos4.dtsi:

/ {
    soc: soc {
        amba {
            pdma0: pdma@12680000 {
                compatible =3D "arm,pl330", "arm,primecell";
                reg =3D <0x12680000 0x1000>;
                interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
                clocks =3D <&clock CLK_PDMA0>;
                clock-names =3D "apb_pclk";
                #dma-cells =3D <1>;
                #dma-channels =3D <8>;
                #dma-requests =3D <32>;
            };
            pdma1: pdma@12690000 {
                compatible =3D "arm,pl330", "arm,primecell";
                reg =3D <0x12690000 0x1000>;
                interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
                clocks =3D <&clock CLK_PDMA1>;
                clock-names =3D "apb_pclk";
                #dma-cells =3D <1>;
                #dma-channels =3D <8>;
                #dma-requests =3D <32>;
            };
            mdma1: mdma@12850000 {
                compatible =3D "arm,pl330", "arm,primecell";
                reg =3D <0x12850000 0x1000>;
                interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
                clocks =3D <&clock CLK_MDMA>;
                clock-names =3D "apb_pclk";
                #dma-cells =3D <1>;
                #dma-channels =3D <8>;
                #dma-requests =3D <1>;
            };
        };
    };
};

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
[PMD: Do not set default qdev properties, create the controllers in the S=
oC
      rather than the board (Peter Maydell), add dtsi in commit message]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Another intent to salvage previous work from Guenter Roeck:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06302.html

Since v2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06459.=
html
- rename init -> create
- create controllers in SoC rather than the board (Peter Maydell)
- add Linux dtsi in commit message

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06335.=
html
- Do not factor out pl330_init, which resulted in buggy v1, see:
  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06448.html

 hw/arm/exynos4210.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 827318a003..cd27b9387c 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -96,6 +96,11 @@
 /* EHCI */
 #define EXYNOS4210_EHCI_BASE_ADDR           0x12580000
=20
+/* DMA */
+#define EXYNOS4210_PL330_BASE0_ADDR         0x12680000
+#define EXYNOS4210_PL330_BASE1_ADDR         0x12690000
+#define EXYNOS4210_PL330_BASE2_ADDR         0x12850000
+
 static uint8_t chipid_and_omr[] =3D { 0x11, 0x02, 0x21, 0x43,
                                     0x09, 0x00, 0x00, 0x00 };
=20
@@ -160,6 +165,19 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return (0x9 << ARM_AFF1_SHIFT) | cpu;
 }
=20
+static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
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
 Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
 {
     Exynos4210State *s =3D g_new(Exynos4210State, 1);
@@ -410,5 +428,13 @@ Exynos4210State *exynos4210_init(MemoryRegion *syste=
m_mem)
     sysbus_create_simple(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR=
,
             s->irq_table[exynos4210_get_irq(28, 3)]);
=20
+    /*** DMA controllers ***/
+    pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
+                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(35, 1)]=
), 32);
+    pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
+                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(36, 1)]=
), 32);
+    pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
+                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(34, 1)]=
), 1);
+
     return s;
 }
--=20
2.17.2
