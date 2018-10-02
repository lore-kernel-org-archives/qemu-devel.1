Received: from eggs.gnu.org ([2001:4830:134:3::10]:46875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1g7Lmw-0005M2-6a
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1g7LdC-0004QG-Jl
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:26:36 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Tue,  2 Oct 2018 16:24:41 +0200
Message-Id: <20181002142443.30976-8-damien.hedde@greensocs.com>
In-Reply-To: <20181002142443.30976-1-damien.hedde@greensocs.com>
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 7/9] hw/misc/zynq_slcr: add clock generation
 for uarts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, alistair@alistair23.me, saipava@xilinx.com, mark.burton@greensocs.com, luc.michel@greensocs.com, konrad@adacore.com, edgar.iglesias@xilinx.com, Damien Hedde <damien.hedde@greensocs.com>

Add 2 clock outputs for each uart (uart0 & 1):
+ the reference clock
+ the bus interface clock

The clock frequencies are computed using the internal pll & uart configur=
ation
registers.

All clocks depend on the main input clock (ps_clk), which is hard-coded
to 33.33MHz (zcu102 evaluation board frequency and frequency specified
in Xilinx's device tree file)

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/misc/zynq_slcr.c | 125 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index baa13d1316..0b599ebd97 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -33,6 +33,8 @@
         } \
     } while (0)
=20
+#define INPUT_PS_REF_CLK_FREQUENCY (33333333)
+
 #define XILINX_LOCK_KEY 0x767b
 #define XILINX_UNLOCK_KEY 0xdf0d
=20
@@ -44,15 +46,27 @@ REG32(LOCKSTA, 0x00c)
 REG32(ARM_PLL_CTRL, 0x100)
 REG32(DDR_PLL_CTRL, 0x104)
 REG32(IO_PLL_CTRL, 0x108)
+/* fields for [ARM|DDR|IO_PLL]_CTRL registers */
+    FIELD(xxx_PLL_CTRL, PLL_RESET, 0, 1)
+    FIELD(xxx_PLL_CTRL, PLL_PWRDWN, 1, 1)
+    FIELD(xxx_PLL_CTRL, PLL_BYPASS_QUAL, 3, 1)
+    FIELD(xxx_PLL_CTRL, PLL_BYPASS_FORCE, 4, 1)
+    FIELD(xxx_PLL_CTRL, PLL_FPDIV, 12, 7)
 REG32(PLL_STATUS, 0x10c)
 REG32(ARM_PLL_CFG, 0x110)
 REG32(DDR_PLL_CFG, 0x114)
 REG32(IO_PLL_CFG, 0x118)
=20
 REG32(ARM_CLK_CTRL, 0x120)
+    FIELD(ARM_CLK_CTRL, SRCSEL,  4, 2)
+    FIELD(ARM_CLK_CTRL, DIVISOR, 8, 6)
+    FIELD(ARM_CLK_CTRL, CPU_1XCLKACT, 27, 1)
+    FIELD(ARM_CLK_CTRL, CPU_PERI_CLKACT, 28, 1)
 REG32(DDR_CLK_CTRL, 0x124)
 REG32(DCI_CLK_CTRL, 0x128)
 REG32(APER_CLK_CTRL, 0x12c)
+    FIELD(APER_CLK_CTRL, UART0_CPU1XCLKACT, 20, 1)
+    FIELD(APER_CLK_CTRL, UART1_CPU1XCLKACT, 21, 1)
 REG32(USB0_CLK_CTRL, 0x130)
 REG32(USB1_CLK_CTRL, 0x134)
 REG32(GEM0_RCLK_CTRL, 0x138)
@@ -63,12 +77,19 @@ REG32(SMC_CLK_CTRL, 0x148)
 REG32(LQSPI_CLK_CTRL, 0x14c)
 REG32(SDIO_CLK_CTRL, 0x150)
 REG32(UART_CLK_CTRL, 0x154)
+    FIELD(UART_CLK_CTRL, CLKACT0, 0, 1)
+    FIELD(UART_CLK_CTRL, CLKACT1, 1, 1)
+    FIELD(UART_CLK_CTRL, SRCSEL,  4, 2)
+    FIELD(UART_CLK_CTRL, DIVISOR, 8, 6)
 REG32(SPI_CLK_CTRL, 0x158)
 REG32(CAN_CLK_CTRL, 0x15c)
 REG32(CAN_MIOCLK_CTRL, 0x160)
 REG32(DBG_CLK_CTRL, 0x164)
 REG32(PCAP_CLK_CTRL, 0x168)
 REG32(TOPSW_CLK_CTRL, 0x16c)
+/* common fields to lots of *_CLK_CTRL registers */
+    FIELD(xxx_CLK_CTRL, SRCSEL,  4, 2)
+    FIELD(xxx_CLK_CTRL, DIVISOR, 8, 6)
=20
 #define FPGA_CTRL_REGS(n, start) \
     REG32(FPGA ## n ## _CLK_CTRL, (start)) \
@@ -178,8 +199,92 @@ typedef struct ZynqSLCRState {
     MemoryRegion iomem;
=20
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
+
+    ClockOut *uart0_amba_clk;
+    ClockOut *uart1_amba_clk;
+    ClockOut *uart0_ref_clk;
+    ClockOut *uart1_ref_clk;
 } ZynqSLCRState;
=20
+/*
+ * return the output frequency of ARM/DDR/IO pll
+ * using input frequency and PLL_CTRL register
+ */
+static uint64_t zynq_slcr_compute_pll(uint64_t input, uint32_t ctrl_reg)
+{
+    uint32_t mult =3D ((ctrl_reg & R_xxx_PLL_CTRL_PLL_FPDIV_MASK) >>
+            R_xxx_PLL_CTRL_PLL_FPDIV_SHIFT);
+
+    /* first, check if pll is bypassed */
+    if (ctrl_reg & R_xxx_PLL_CTRL_PLL_BYPASS_FORCE_MASK) {
+        return input;
+    }
+
+    /* is pll disabled ? */
+    if (ctrl_reg & (R_xxx_PLL_CTRL_PLL_RESET_MASK |
+                    R_xxx_PLL_CTRL_PLL_PWRDWN_MASK)) {
+        return 0;
+    }
+
+    return input * mult;
+}
+
+/*
+ * return the output frequency of a clock given:
+ * + the pll's frequencies in an array corresponding to mux's indexes
+ * + the register xxx_CLK_CTRL value
+ * + enable bit index in ctrl register
+ *
+ * This function make the assumption that ctrl_reg value is organized as=
 follow:
+ * + bits[13:8] clock divisor
+ * + bits[5:4]  clock mux selector (index in array)
+ * + bits[index] clock enable
+ */
+static uint64_t zynq_slcr_compute_clock(const uint64_t plls[],
+                                        uint32_t ctrl_reg,
+                                        unsigned index)
+{
+    uint32_t divisor =3D FIELD_EX32(ctrl_reg, xxx_CLK_CTRL, DIVISOR);
+    uint32_t srcsel =3D FIELD_EX32(ctrl_reg, xxx_CLK_CTRL, SRCSEL);
+
+    if ((ctrl_reg & (1u << index)) =3D=3D 0) {
+        return 0;
+    }
+
+    return plls[srcsel] / (divisor ? divisor : 1u);
+}
+
+#define ZYNQ_CLOCK(_state, _plls, _reg, _enable_field) \
+    zynq_slcr_compute_clock((_plls), (_state)->regs[R_ ## _reg], \
+            R_ ## _reg ## _ ## _enable_field ## _SHIFT)
+#define ZYNQ_GATE(_state, _clk, _reg, _field) \
+    (ARRAY_FIELD_EX32((_state)->regs, _reg, _field) ? (_clk) : 0)
+
+static void zynq_slcr_compute_clocks(ZynqSLCRState *s)
+{
+    uint64_t ps_clk =3D INPUT_PS_REF_CLK_FREQUENCY;
+    uint64_t io_pll =3D zynq_slcr_compute_pll(ps_clk, s->regs[R_IO_PLL_C=
TRL]);
+    uint64_t arm_pll =3D zynq_slcr_compute_pll(ps_clk, s->regs[R_ARM_PLL=
_CTRL]);
+    uint64_t ddr_pll =3D zynq_slcr_compute_pll(ps_clk, s->regs[R_DDR_PLL=
_CTRL]);
+    uint64_t cpu_mux[4] =3D {arm_pll, arm_pll, ddr_pll, io_pll};
+    uint64_t uart_mux[4] =3D {io_pll, io_pll, arm_pll, ddr_pll};
+    uint64_t cpu1x_clk;
+
+    /* compute uartX amba clocks */
+    cpu1x_clk =3D ZYNQ_CLOCK(s, cpu_mux, ARM_CLK_CTRL, CPU_PERI_CLKACT);
+    cpu1x_clk =3D ZYNQ_GATE(s, cpu1x_clk, ARM_CLK_CTRL, CPU_1XCLKACT);
+    clock_set_frequency(s->uart0_amba_clk,
+            ZYNQ_GATE(s, cpu1x_clk, APER_CLK_CTRL, UART0_CPU1XCLKACT));
+    clock_set_frequency(s->uart1_amba_clk,
+            ZYNQ_GATE(s, cpu1x_clk, APER_CLK_CTRL, UART1_CPU1XCLKACT));
+
+    /* compute uartX ref clocks */
+    clock_set_frequency(s->uart0_ref_clk,
+            ZYNQ_CLOCK(s, uart_mux, UART_CLK_CTRL, CLKACT0));
+    clock_set_frequency(s->uart1_ref_clk,
+            ZYNQ_CLOCK(s, uart_mux, UART_CLK_CTRL, CLKACT1));
+}
+
 static void zynq_slcr_reset(DeviceState *d)
 {
     ZynqSLCRState *s =3D ZYNQ_SLCR(d);
@@ -274,6 +379,8 @@ static void zynq_slcr_reset(DeviceState *d)
     s->regs[R_DDRIOB + 4] =3D s->regs[R_DDRIOB + 5] =3D s->regs[R_DDRIOB=
 + 6]
                           =3D 0x00000e00;
     s->regs[R_DDRIOB + 12] =3D 0x00000021;
+
+    zynq_slcr_compute_clocks(s);
 }
=20
=20
@@ -408,6 +515,14 @@ static void zynq_slcr_write(void *opaque, hwaddr off=
set,
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
+    case R_IO_PLL_CTRL:
+    case R_ARM_PLL_CTRL:
+    case R_DDR_PLL_CTRL:
+    case R_ARM_CLK_CTRL:
+    case R_APER_CLK_CTRL:
+    case R_UART_CLK_CTRL:
+        zynq_slcr_compute_clocks(s);
+        break;
     }
 }
=20
@@ -417,6 +532,14 @@ static const MemoryRegionOps slcr_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
+static const ClockPortInitArray zynq_slcr_clocks =3D {
+    QDEV_CLOCK_OUT(ZynqSLCRState, uart0_amba_clk),
+    QDEV_CLOCK_OUT(ZynqSLCRState, uart1_amba_clk),
+    QDEV_CLOCK_OUT(ZynqSLCRState, uart0_ref_clk),
+    QDEV_CLOCK_OUT(ZynqSLCRState, uart1_ref_clk),
+    QDEV_CLOCK_END,
+};
+
 static void zynq_slcr_init(Object *obj)
 {
     ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
@@ -424,6 +547,8 @@ static void zynq_slcr_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &slcr_ops, s, "slcr",
                           ZYNQ_SLCR_MMIO_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
+    qdev_init_clocks(DEVICE(obj), zynq_slcr_clocks);
 }
=20
 static const VMStateDescription vmstate_zynq_slcr =3D {
--=20
2.19.0
