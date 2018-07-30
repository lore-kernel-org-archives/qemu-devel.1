Received: from eggs.gnu.org ([2001:4830:134:3::10]:51957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkAFe-0007sB-Aa
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkAFa-0004tD-Fb
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:38:26 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fkAFZ-0004sp-VD
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:38:22 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Mon, 30 Jul 2018 17:38:12 +0200
Message-Id: <34b6704ceb81b49e35ce1ad162bf758e5141ff87.1532963204.git.jcd@tribudubois.net>
In-Reply-To: <cover.1532963204.git.jcd@tribudubois.net>
References: <cover.1532963204.git.jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH v2 1/3] i.MX6UL: Add i.MX6UL specific CCM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---

Changes in V2:
 * move all CCM "debug" to the "trace" framework for i.MX6UL
 * remove unecessary breaks
 * prevent g_assert_not_reached triggered by guest.
 * Add assert to help static analyzer.
 * use FIELD_EX32 from hw/registerfields.h instead of defining my own.

 hw/misc/Makefile.objs        |   1 +
 hw/misc/imx6ul_ccm.c         | 890 +++++++++++++++++++++++++++++++++++
 hw/misc/trace-events         |   7 +
 include/hw/misc/imx6ul_ccm.h | 226 +++++++++
 4 files changed, 1124 insertions(+)
 create mode 100644 hw/misc/imx6ul_ccm.c
 create mode 100644 include/hw/misc/imx6ul_ccm.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 9350900845..51d27b3af1 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -36,6 +36,7 @@ obj-$(CONFIG_IMX) += imx_ccm.o
 obj-$(CONFIG_IMX) += imx31_ccm.o
 obj-$(CONFIG_IMX) += imx25_ccm.o
 obj-$(CONFIG_IMX) += imx6_ccm.o
+obj-$(CONFIG_IMX) += imx6ul_ccm.o
 obj-$(CONFIG_IMX) += imx6_src.o
 obj-$(CONFIG_IMX) += imx7_ccm.o
 obj-$(CONFIG_IMX) += imx2_wdt.o
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
new file mode 100644
index 0000000000..32197b2435
--- /dev/null
+++ b/hw/misc/imx6ul_ccm.c
@@ -0,0 +1,890 @@
+/*
+ * IMX6UL Clock Control Module
+ *
+ * Copyright (c) 2018 Jean-Christophe Dubois <jcd@tribudubois.net>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * To get the timer frequencies right, we need to emulate at least part of
+ * the CCM.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/registerfields.h"
+#include "hw/misc/imx6ul_ccm.h"
+#include "qemu/log.h"
+
+#include "trace.h"
+
+static const char *imx6ul_ccm_reg_name(uint32_t reg)
+{
+    static char unknown[20];
+
+    switch (reg) {
+    case CCM_CCR:
+        return "CCR";
+    case CCM_CCDR:
+        return "CCDR";
+    case CCM_CSR:
+        return "CSR";
+    case CCM_CCSR:
+        return "CCSR";
+    case CCM_CACRR:
+        return "CACRR";
+    case CCM_CBCDR:
+        return "CBCDR";
+    case CCM_CBCMR:
+        return "CBCMR";
+    case CCM_CSCMR1:
+        return "CSCMR1";
+    case CCM_CSCMR2:
+        return "CSCMR2";
+    case CCM_CSCDR1:
+        return "CSCDR1";
+    case CCM_CS1CDR:
+        return "CS1CDR";
+    case CCM_CS2CDR:
+        return "CS2CDR";
+    case CCM_CDCDR:
+        return "CDCDR";
+    case CCM_CHSCCDR:
+        return "CHSCCDR";
+    case CCM_CSCDR2:
+        return "CSCDR2";
+    case CCM_CSCDR3:
+        return "CSCDR3";
+    case CCM_CDHIPR:
+        return "CDHIPR";
+    case CCM_CTOR:
+        return "CTOR";
+    case CCM_CLPCR:
+        return "CLPCR";
+    case CCM_CISR:
+        return "CISR";
+    case CCM_CIMR:
+        return "CIMR";
+    case CCM_CCOSR:
+        return "CCOSR";
+    case CCM_CGPR:
+        return "CGPR";
+    case CCM_CCGR0:
+        return "CCGR0";
+    case CCM_CCGR1:
+        return "CCGR1";
+    case CCM_CCGR2:
+        return "CCGR2";
+    case CCM_CCGR3:
+        return "CCGR3";
+    case CCM_CCGR4:
+        return "CCGR4";
+    case CCM_CCGR5:
+        return "CCGR5";
+    case CCM_CCGR6:
+        return "CCGR6";
+    case CCM_CMEOR:
+        return "CMEOR";
+    default:
+        sprintf(unknown, "%d ?", reg);
+        return unknown;
+    }
+}
+
+static const char *imx6ul_analog_reg_name(uint32_t reg)
+{
+    static char unknown[20];
+
+    switch (reg) {
+    case CCM_ANALOG_PLL_ARM:
+        return "PLL_ARM";
+    case CCM_ANALOG_PLL_ARM_SET:
+        return "PLL_ARM_SET";
+    case CCM_ANALOG_PLL_ARM_CLR:
+        return "PLL_ARM_CLR";
+    case CCM_ANALOG_PLL_ARM_TOG:
+        return "PLL_ARM_TOG";
+    case CCM_ANALOG_PLL_USB1:
+        return "PLL_USB1";
+    case CCM_ANALOG_PLL_USB1_SET:
+        return "PLL_USB1_SET";
+    case CCM_ANALOG_PLL_USB1_CLR:
+        return "PLL_USB1_CLR";
+    case CCM_ANALOG_PLL_USB1_TOG:
+        return "PLL_USB1_TOG";
+    case CCM_ANALOG_PLL_USB2:
+        return "PLL_USB2";
+    case CCM_ANALOG_PLL_USB2_SET:
+        return "PLL_USB2_SET";
+    case CCM_ANALOG_PLL_USB2_CLR:
+        return "PLL_USB2_CLR";
+    case CCM_ANALOG_PLL_USB2_TOG:
+        return "PLL_USB2_TOG";
+    case CCM_ANALOG_PLL_SYS:
+        return "PLL_SYS";
+    case CCM_ANALOG_PLL_SYS_SET:
+        return "PLL_SYS_SET";
+    case CCM_ANALOG_PLL_SYS_CLR:
+        return "PLL_SYS_CLR";
+    case CCM_ANALOG_PLL_SYS_TOG:
+        return "PLL_SYS_TOG";
+    case CCM_ANALOG_PLL_SYS_SS:
+        return "PLL_SYS_SS";
+    case CCM_ANALOG_PLL_SYS_NUM:
+        return "PLL_SYS_NUM";
+    case CCM_ANALOG_PLL_SYS_DENOM:
+        return "PLL_SYS_DENOM";
+    case CCM_ANALOG_PLL_AUDIO:
+        return "PLL_AUDIO";
+    case CCM_ANALOG_PLL_AUDIO_SET:
+        return "PLL_AUDIO_SET";
+    case CCM_ANALOG_PLL_AUDIO_CLR:
+        return "PLL_AUDIO_CLR";
+    case CCM_ANALOG_PLL_AUDIO_TOG:
+        return "PLL_AUDIO_TOG";
+    case CCM_ANALOG_PLL_AUDIO_NUM:
+        return "PLL_AUDIO_NUM";
+    case CCM_ANALOG_PLL_AUDIO_DENOM:
+        return "PLL_AUDIO_DENOM";
+    case CCM_ANALOG_PLL_VIDEO:
+        return "PLL_VIDEO";
+    case CCM_ANALOG_PLL_VIDEO_SET:
+        return "PLL_VIDEO_SET";
+    case CCM_ANALOG_PLL_VIDEO_CLR:
+        return "PLL_VIDEO_CLR";
+    case CCM_ANALOG_PLL_VIDEO_TOG:
+        return "PLL_VIDEO_TOG";
+    case CCM_ANALOG_PLL_VIDEO_NUM:
+        return "PLL_VIDEO_NUM";
+    case CCM_ANALOG_PLL_VIDEO_DENOM:
+        return "PLL_VIDEO_DENOM";
+    case CCM_ANALOG_PLL_ENET:
+        return "PLL_ENET";
+    case CCM_ANALOG_PLL_ENET_SET:
+        return "PLL_ENET_SET";
+    case CCM_ANALOG_PLL_ENET_CLR:
+        return "PLL_ENET_CLR";
+    case CCM_ANALOG_PLL_ENET_TOG:
+        return "PLL_ENET_TOG";
+    case CCM_ANALOG_PFD_480:
+        return "PFD_480";
+    case CCM_ANALOG_PFD_480_SET:
+        return "PFD_480_SET";
+    case CCM_ANALOG_PFD_480_CLR:
+        return "PFD_480_CLR";
+    case CCM_ANALOG_PFD_480_TOG:
+        return "PFD_480_TOG";
+    case CCM_ANALOG_PFD_528:
+        return "PFD_528";
+    case CCM_ANALOG_PFD_528_SET:
+        return "PFD_528_SET";
+    case CCM_ANALOG_PFD_528_CLR:
+        return "PFD_528_CLR";
+    case CCM_ANALOG_PFD_528_TOG:
+        return "PFD_528_TOG";
+    case CCM_ANALOG_MISC0:
+        return "MISC0";
+    case CCM_ANALOG_MISC0_SET:
+        return "MISC0_SET";
+    case CCM_ANALOG_MISC0_CLR:
+        return "MISC0_CLR";
+    case CCM_ANALOG_MISC0_TOG:
+        return "MISC0_TOG";
+    case CCM_ANALOG_MISC2:
+        return "MISC2";
+    case CCM_ANALOG_MISC2_SET:
+        return "MISC2_SET";
+    case CCM_ANALOG_MISC2_CLR:
+        return "MISC2_CLR";
+    case CCM_ANALOG_MISC2_TOG:
+        return "MISC2_TOG";
+    case PMU_REG_1P1:
+        return "PMU_REG_1P1";
+    case PMU_REG_3P0:
+        return "PMU_REG_3P0";
+    case PMU_REG_2P5:
+        return "PMU_REG_2P5";
+    case PMU_REG_CORE:
+        return "PMU_REG_CORE";
+    case PMU_MISC1:
+        return "PMU_MISC1";
+    case PMU_MISC1_SET:
+        return "PMU_MISC1_SET";
+    case PMU_MISC1_CLR:
+        return "PMU_MISC1_CLR";
+    case PMU_MISC1_TOG:
+        return "PMU_MISC1_TOG";
+    case USB_ANALOG_DIGPROG:
+        return "USB_ANALOG_DIGPROG";
+    default:
+        sprintf(unknown, "%d ?", reg);
+        return unknown;
+    }
+}
+
+#define CKIH_FREQ 24000000 /* 24MHz crystal input */
+
+static const VMStateDescription vmstate_imx6ul_ccm = {
+    .name = TYPE_IMX6UL_CCM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ccm, IMX6ULCCMState, CCM_MAX),
+        VMSTATE_UINT32_ARRAY(analog, IMX6ULCCMState, CCM_ANALOG_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static uint64_t imx6ul_analog_get_osc_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = CKIH_FREQ;
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_analog_get_pll2_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = imx6ul_analog_get_osc_clk(dev);
+
+    if (FIELD_EX32(dev->analog[CCM_ANALOG_PLL_SYS],
+                   ANALOG_PLL_SYS, DIV_SELECT)) {
+        freq *= 22;
+    } else {
+        freq *= 20;
+    }
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_analog_get_pll3_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = imx6ul_analog_get_osc_clk(dev) * 20;
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_analog_get_pll2_pfd0_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6ul_analog_get_pll2_clk(dev) * 18
+           / FIELD_EX32(dev->analog[CCM_ANALOG_PFD_528],
+                        ANALOG_PFD_528, PFD0_FRAC);
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_analog_get_pll2_pfd2_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6ul_analog_get_pll2_clk(dev) * 18
+           / FIELD_EX32(dev->analog[CCM_ANALOG_PFD_528],
+                        ANALOG_PFD_528, PFD2_FRAC);
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_analog_pll2_bypass_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_periph_clk2_sel_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    switch (FIELD_EX32(dev->ccm[CCM_CBCMR], CBCMR, PERIPH_CLK2_SEL)) {
+    case 0:
+        freq = imx6ul_analog_get_pll3_clk(dev);
+        break;
+    case 1:
+        freq = imx6ul_analog_get_osc_clk(dev);
+        break;
+    case 2:
+        freq = imx6ul_analog_pll2_bypass_clk(dev);
+        break;
+    case 3:
+        /* We should never get there as 3 is a reserved value */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[%s]%s: unsupported PERIPH_CLK2_SEL value 3\n",
+                      TYPE_IMX6UL_CCM, __func__);
+        /* freq is set to 0 as we don't know what it should be */
+        break;
+    default:
+        /* We should never get there */
+        g_assert_not_reached();
+    }
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_periph_clk_sel_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    switch (FIELD_EX32(dev->ccm[CCM_CBCMR], CBCMR, PRE_PERIPH_CLK_SEL)) {
+    case 0:
+        freq = imx6ul_analog_get_pll2_clk(dev);
+        break;
+    case 1:
+        freq = imx6ul_analog_get_pll2_pfd2_clk(dev);
+        break;
+    case 2:
+        freq = imx6ul_analog_get_pll2_pfd0_clk(dev);
+        break;
+    case 3:
+        freq = imx6ul_analog_get_pll2_pfd2_clk(dev) / 2;
+        break;
+    default:
+        /* We should never get there */
+        g_assert_not_reached();
+    }
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_periph_clk2_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6ul_ccm_get_periph_clk2_sel_clk(dev)
+           / (1 + FIELD_EX32(dev->ccm[CCM_CBCDR], CBCDR, PERIPH_CLK2_PODF));
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_periph_sel_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    switch (FIELD_EX32(dev->ccm[CCM_CBCDR], CBCDR, PERIPH_CLK_SEL)) {
+    case 0:
+        freq = imx6ul_ccm_get_periph_clk_sel_clk(dev);
+        break;
+    case 1:
+        freq = imx6ul_ccm_get_periph_clk2_clk(dev);
+        break;
+    default:
+        /* We should never get there */
+        g_assert_not_reached();
+    }
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_ahb_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6ul_ccm_get_periph_sel_clk(dev)
+           / (1 + FIELD_EX32(dev->ccm[CCM_CBCDR], CBCDR, AHB_PODF));
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_ipg_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6ul_ccm_get_ahb_clk(dev)
+           / (1 + FIELD_EX32(dev->ccm[CCM_CBCDR], CBCDR, IPG_PODF));
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_per_sel_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    switch (FIELD_EX32(dev->ccm[CCM_CSCMR1], CSCMR1, PERCLK_CLK_SEL)) {
+    case 0:
+        freq = imx6ul_ccm_get_ipg_clk(dev);
+        break;
+    case 1:
+        freq = imx6ul_analog_get_osc_clk(dev);
+        break;
+    default:
+        /* We should never get there */
+        g_assert_not_reached();
+    }
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint64_t imx6ul_ccm_get_per_clk(IMX6ULCCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6ul_ccm_get_per_sel_clk(dev)
+           / (1 + FIELD_EX32(dev->ccm[CCM_CSCMR1], CSCMR1, PERCLK_PODF));
+
+    trace_ccm_freq((uint32_t)freq);
+
+    return freq;
+}
+
+static uint32_t imx6ul_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
+{
+    uint32_t freq = 0;
+    IMX6ULCCMState *s = IMX6UL_CCM(dev);
+
+    switch (clock) {
+    case CLK_NONE:
+        break;
+    case CLK_IPG:
+        freq = imx6ul_ccm_get_ipg_clk(s);
+        break;
+    case CLK_IPG_HIGH:
+        freq = imx6ul_ccm_get_per_clk(s);
+        break;
+    case CLK_32k:
+        freq = CKIL_FREQ;
+        break;
+    case CLK_HIGH:
+        freq = CKIH_FREQ;
+        break;
+    case CLK_HIGH_DIV:
+        freq = CKIH_FREQ / 8;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: unsupported clock %d\n",
+                      TYPE_IMX6UL_CCM, __func__, clock);
+        break;
+    }
+
+    trace_ccm_clock_freq(clock, freq);
+
+    return freq;
+}
+
+static void imx6ul_ccm_reset(DeviceState *dev)
+{
+    IMX6ULCCMState *s = IMX6UL_CCM(dev);
+
+    trace_ccm_entry();
+
+    s->ccm[CCM_CCR] = 0x0401167F;
+    s->ccm[CCM_CCDR] = 0x00000000;
+    s->ccm[CCM_CSR] = 0x00000010;
+    s->ccm[CCM_CCSR] = 0x00000100;
+    s->ccm[CCM_CACRR] = 0x00000000;
+    s->ccm[CCM_CBCDR] = 0x00018D00;
+    s->ccm[CCM_CBCMR] = 0x24860324;
+    s->ccm[CCM_CSCMR1] = 0x04900080;
+    s->ccm[CCM_CSCMR2] = 0x03192F06;
+    s->ccm[CCM_CSCDR1] = 0x00490B00;
+    s->ccm[CCM_CS1CDR] = 0x0EC102C1;
+    s->ccm[CCM_CS2CDR] = 0x000336C1;
+    s->ccm[CCM_CDCDR] = 0x33F71F92;
+    s->ccm[CCM_CHSCCDR] = 0x000248A4;
+    s->ccm[CCM_CSCDR2] = 0x00029B48;
+    s->ccm[CCM_CSCDR3] = 0x00014841;
+    s->ccm[CCM_CDHIPR] = 0x00000000;
+    s->ccm[CCM_CTOR] = 0x00000000;
+    s->ccm[CCM_CLPCR] = 0x00000079;
+    s->ccm[CCM_CISR] = 0x00000000;
+    s->ccm[CCM_CIMR] = 0xFFFFFFFF;
+    s->ccm[CCM_CCOSR] = 0x000A0001;
+    s->ccm[CCM_CGPR] = 0x0000FE62;
+    s->ccm[CCM_CCGR0] = 0xFFFFFFFF;
+    s->ccm[CCM_CCGR1] = 0xFFFFFFFF;
+    s->ccm[CCM_CCGR2] = 0xFC3FFFFF;
+    s->ccm[CCM_CCGR3] = 0xFFFFFFFF;
+    s->ccm[CCM_CCGR4] = 0xFFFFFFFF;
+    s->ccm[CCM_CCGR5] = 0xFFFFFFFF;
+    s->ccm[CCM_CCGR6] = 0xFFFFFFFF;
+    s->ccm[CCM_CMEOR] = 0xFFFFFFFF;
+
+    s->analog[CCM_ANALOG_PLL_ARM] = 0x00013063;
+    s->analog[CCM_ANALOG_PLL_USB1] = 0x00012000;
+    s->analog[CCM_ANALOG_PLL_USB2] = 0x00012000;
+    s->analog[CCM_ANALOG_PLL_SYS] = 0x00013001;
+    s->analog[CCM_ANALOG_PLL_SYS_SS] = 0x00000000;
+    s->analog[CCM_ANALOG_PLL_SYS_NUM] = 0x00000000;
+    s->analog[CCM_ANALOG_PLL_SYS_DENOM] = 0x00000012;
+    s->analog[CCM_ANALOG_PLL_AUDIO] = 0x00011006;
+    s->analog[CCM_ANALOG_PLL_AUDIO_NUM] = 0x05F5E100;
+    s->analog[CCM_ANALOG_PLL_AUDIO_DENOM] = 0x2964619C;
+    s->analog[CCM_ANALOG_PLL_VIDEO] = 0x0001100C;
+    s->analog[CCM_ANALOG_PLL_VIDEO_NUM] = 0x05F5E100;
+    s->analog[CCM_ANALOG_PLL_VIDEO_DENOM] = 0x10A24447;
+    s->analog[CCM_ANALOG_PLL_ENET] = 0x00011001;
+    s->analog[CCM_ANALOG_PFD_480] = 0x1311100C;
+    s->analog[CCM_ANALOG_PFD_528] = 0x1018101B;
+
+    s->analog[PMU_REG_1P1] = 0x00001073;
+    s->analog[PMU_REG_3P0] = 0x00000F74;
+    s->analog[PMU_REG_2P5] = 0x00001073;
+    s->analog[PMU_REG_CORE] = 0x00482012;
+    s->analog[PMU_MISC0] = 0x04000000;
+    s->analog[PMU_MISC1] = 0x00000000;
+    s->analog[PMU_MISC2] = 0x00272727;
+    s->analog[PMU_LOWPWR_CTRL] = 0x00004009;
+
+    s->analog[USB_ANALOG_USB1_VBUS_DETECT] = 0x01000004;
+    s->analog[USB_ANALOG_USB1_CHRG_DETECT] = 0x00000000;
+    s->analog[USB_ANALOG_USB1_VBUS_DETECT_STAT] = 0x00000000;
+    s->analog[USB_ANALOG_USB1_CHRG_DETECT_STAT] = 0x00000000;
+    s->analog[USB_ANALOG_USB1_MISC] = 0x00000002;
+    s->analog[USB_ANALOG_USB2_VBUS_DETECT] = 0x01000004;
+    s->analog[USB_ANALOG_USB2_CHRG_DETECT] = 0x00000000;
+    s->analog[USB_ANALOG_USB2_MISC] = 0x00000002;
+    s->analog[USB_ANALOG_DIGPROG] = 0x00640000;
+
+    /* all PLLs need to be locked */
+    s->analog[CCM_ANALOG_PLL_ARM]   |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_USB1]  |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_USB2]  |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_SYS]   |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_AUDIO] |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_VIDEO] |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_ENET]  |= CCM_ANALOG_PLL_LOCK;
+
+    s->analog[TEMPMON_TEMPSENSE0] = 0x00000001;
+    s->analog[TEMPMON_TEMPSENSE1] = 0x00000001;
+    s->analog[TEMPMON_TEMPSENSE2] = 0x00000000;
+}
+
+static uint64_t imx6ul_ccm_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t value = 0;
+    uint32_t index = offset >> 2;
+    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+
+    assert(index < CCM_MAX);
+
+    value = s->ccm[index];
+
+    trace_ccm_read_reg(imx6ul_ccm_reg_name(index), (uint32_t)value);
+
+    return (uint64_t)value;
+}
+
+static void imx6ul_ccm_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    uint32_t index = offset >> 2;
+    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+
+    assert(index < CCM_MAX);
+
+    trace_ccm_write_reg(imx6ul_ccm_reg_name(index), (uint32_t)value);
+
+    /*
+     * We will do a better implementation later. In particular some bits
+     * cannot be written to.
+     */
+    s->ccm[index] = (uint32_t)value;
+}
+
+static uint64_t imx6ul_analog_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t value;
+    uint32_t index = offset >> 2;
+    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+
+    assert(index < CCM_ANALOG_MAX);
+
+    switch (index) {
+    case CCM_ANALOG_PLL_ARM_SET:
+    case CCM_ANALOG_PLL_USB1_SET:
+    case CCM_ANALOG_PLL_USB2_SET:
+    case CCM_ANALOG_PLL_SYS_SET:
+    case CCM_ANALOG_PLL_AUDIO_SET:
+    case CCM_ANALOG_PLL_VIDEO_SET:
+    case CCM_ANALOG_PLL_ENET_SET:
+    case CCM_ANALOG_PFD_480_SET:
+    case CCM_ANALOG_PFD_528_SET:
+    case CCM_ANALOG_MISC0_SET:
+    case PMU_MISC1_SET:
+    case CCM_ANALOG_MISC2_SET:
+    case USB_ANALOG_USB1_VBUS_DETECT_SET:
+    case USB_ANALOG_USB1_CHRG_DETECT_SET:
+    case USB_ANALOG_USB1_MISC_SET:
+    case USB_ANALOG_USB2_VBUS_DETECT_SET:
+    case USB_ANALOG_USB2_CHRG_DETECT_SET:
+    case USB_ANALOG_USB2_MISC_SET:
+    case TEMPMON_TEMPSENSE0_SET:
+    case TEMPMON_TEMPSENSE1_SET:
+    case TEMPMON_TEMPSENSE2_SET:
+        /*
+         * All REG_NAME_SET register access are in fact targeting the
+         * the REG_NAME register.
+         */
+        value = s->analog[index - 1];
+        break;
+    case CCM_ANALOG_PLL_ARM_CLR:
+    case CCM_ANALOG_PLL_USB1_CLR:
+    case CCM_ANALOG_PLL_USB2_CLR:
+    case CCM_ANALOG_PLL_SYS_CLR:
+    case CCM_ANALOG_PLL_AUDIO_CLR:
+    case CCM_ANALOG_PLL_VIDEO_CLR:
+    case CCM_ANALOG_PLL_ENET_CLR:
+    case CCM_ANALOG_PFD_480_CLR:
+    case CCM_ANALOG_PFD_528_CLR:
+    case CCM_ANALOG_MISC0_CLR:
+    case PMU_MISC1_CLR:
+    case CCM_ANALOG_MISC2_CLR:
+    case USB_ANALOG_USB1_VBUS_DETECT_CLR:
+    case USB_ANALOG_USB1_CHRG_DETECT_CLR:
+    case USB_ANALOG_USB1_MISC_CLR:
+    case USB_ANALOG_USB2_VBUS_DETECT_CLR:
+    case USB_ANALOG_USB2_CHRG_DETECT_CLR:
+    case USB_ANALOG_USB2_MISC_CLR:
+    case TEMPMON_TEMPSENSE0_CLR:
+    case TEMPMON_TEMPSENSE1_CLR:
+    case TEMPMON_TEMPSENSE2_CLR:
+        /*
+         * All REG_NAME_CLR register access are in fact targeting the
+         * the REG_NAME register.
+         */
+        value = s->analog[index - 2];
+        break;
+    case CCM_ANALOG_PLL_ARM_TOG:
+    case CCM_ANALOG_PLL_USB1_TOG:
+    case CCM_ANALOG_PLL_USB2_TOG:
+    case CCM_ANALOG_PLL_SYS_TOG:
+    case CCM_ANALOG_PLL_AUDIO_TOG:
+    case CCM_ANALOG_PLL_VIDEO_TOG:
+    case CCM_ANALOG_PLL_ENET_TOG:
+    case CCM_ANALOG_PFD_480_TOG:
+    case CCM_ANALOG_PFD_528_TOG:
+    case CCM_ANALOG_MISC0_TOG:
+    case PMU_MISC1_TOG:
+    case CCM_ANALOG_MISC2_TOG:
+    case USB_ANALOG_USB1_VBUS_DETECT_TOG:
+    case USB_ANALOG_USB1_CHRG_DETECT_TOG:
+    case USB_ANALOG_USB1_MISC_TOG:
+    case USB_ANALOG_USB2_VBUS_DETECT_TOG:
+    case USB_ANALOG_USB2_CHRG_DETECT_TOG:
+    case USB_ANALOG_USB2_MISC_TOG:
+    case TEMPMON_TEMPSENSE0_TOG:
+    case TEMPMON_TEMPSENSE1_TOG:
+    case TEMPMON_TEMPSENSE2_TOG:
+        /*
+         * All REG_NAME_TOG register access are in fact targeting the
+         * the REG_NAME register.
+         */
+        value = s->analog[index - 3];
+        break;
+    default:
+        value = s->analog[index];
+        break;
+    }
+
+    trace_ccm_read_reg(imx6ul_analog_reg_name(index), (uint32_t)value);
+
+    return (uint64_t)value;
+}
+
+static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
+                              unsigned size)
+{
+    uint32_t index = offset >> 2;
+    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+
+    assert(index < CCM_ANALOG_MAX);
+
+    trace_ccm_write_reg(imx6ul_analog_reg_name(index), (uint32_t)value);
+
+    switch (index) {
+    case CCM_ANALOG_PLL_ARM_SET:
+    case CCM_ANALOG_PLL_USB1_SET:
+    case CCM_ANALOG_PLL_USB2_SET:
+    case CCM_ANALOG_PLL_SYS_SET:
+    case CCM_ANALOG_PLL_AUDIO_SET:
+    case CCM_ANALOG_PLL_VIDEO_SET:
+    case CCM_ANALOG_PLL_ENET_SET:
+    case CCM_ANALOG_PFD_480_SET:
+    case CCM_ANALOG_PFD_528_SET:
+    case CCM_ANALOG_MISC0_SET:
+    case PMU_MISC1_SET:
+    case CCM_ANALOG_MISC2_SET:
+    case USB_ANALOG_USB1_VBUS_DETECT_SET:
+    case USB_ANALOG_USB1_CHRG_DETECT_SET:
+    case USB_ANALOG_USB1_MISC_SET:
+    case USB_ANALOG_USB2_VBUS_DETECT_SET:
+    case USB_ANALOG_USB2_CHRG_DETECT_SET:
+    case USB_ANALOG_USB2_MISC_SET:
+        /*
+         * All REG_NAME_SET register access are in fact targeting the
+         * the REG_NAME register. So we change the value of the
+         * REG_NAME register, setting bits passed in the value.
+         */
+        s->analog[index - 1] |= value;
+        break;
+    case CCM_ANALOG_PLL_ARM_CLR:
+    case CCM_ANALOG_PLL_USB1_CLR:
+    case CCM_ANALOG_PLL_USB2_CLR:
+    case CCM_ANALOG_PLL_SYS_CLR:
+    case CCM_ANALOG_PLL_AUDIO_CLR:
+    case CCM_ANALOG_PLL_VIDEO_CLR:
+    case CCM_ANALOG_PLL_ENET_CLR:
+    case CCM_ANALOG_PFD_480_CLR:
+    case CCM_ANALOG_PFD_528_CLR:
+    case CCM_ANALOG_MISC0_CLR:
+    case PMU_MISC1_CLR:
+    case CCM_ANALOG_MISC2_CLR:
+    case USB_ANALOG_USB1_VBUS_DETECT_CLR:
+    case USB_ANALOG_USB1_CHRG_DETECT_CLR:
+    case USB_ANALOG_USB1_MISC_CLR:
+    case USB_ANALOG_USB2_VBUS_DETECT_CLR:
+    case USB_ANALOG_USB2_CHRG_DETECT_CLR:
+    case USB_ANALOG_USB2_MISC_CLR:
+        /*
+         * All REG_NAME_CLR register access are in fact targeting the
+         * the REG_NAME register. So we change the value of the
+         * REG_NAME register, unsetting bits passed in the value.
+         */
+        s->analog[index - 2] &= ~value;
+        break;
+    case CCM_ANALOG_PLL_ARM_TOG:
+    case CCM_ANALOG_PLL_USB1_TOG:
+    case CCM_ANALOG_PLL_USB2_TOG:
+    case CCM_ANALOG_PLL_SYS_TOG:
+    case CCM_ANALOG_PLL_AUDIO_TOG:
+    case CCM_ANALOG_PLL_VIDEO_TOG:
+    case CCM_ANALOG_PLL_ENET_TOG:
+    case CCM_ANALOG_PFD_480_TOG:
+    case CCM_ANALOG_PFD_528_TOG:
+    case CCM_ANALOG_MISC0_TOG:
+    case PMU_MISC1_TOG:
+    case CCM_ANALOG_MISC2_TOG:
+    case USB_ANALOG_USB1_VBUS_DETECT_TOG:
+    case USB_ANALOG_USB1_CHRG_DETECT_TOG:
+    case USB_ANALOG_USB1_MISC_TOG:
+    case USB_ANALOG_USB2_VBUS_DETECT_TOG:
+    case USB_ANALOG_USB2_CHRG_DETECT_TOG:
+    case USB_ANALOG_USB2_MISC_TOG:
+        /*
+         * All REG_NAME_TOG register access are in fact targeting the
+         * the REG_NAME register. So we change the value of the
+         * REG_NAME register, toggling bits passed in the value.
+         */
+        s->analog[index - 3] ^= value;
+        break;
+    default:
+        /*
+         * We will do a better implementation later. In particular some bits
+         * cannot be written to.
+         */
+        s->analog[index] = value;
+        break;
+    }
+}
+
+static const struct MemoryRegionOps imx6ul_ccm_ops = {
+    .read = imx6ul_ccm_read,
+    .write = imx6ul_ccm_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static const struct MemoryRegionOps imx6ul_analog_ops = {
+    .read = imx6ul_analog_read,
+    .write = imx6ul_analog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx6ul_ccm_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX6ULCCMState *s = IMX6UL_CCM(obj);
+
+    /* initialize a container for the all memory range */
+    memory_region_init(&s->container, OBJECT(dev), TYPE_IMX6UL_CCM, 0x8000);
+
+    /* We initialize an IO memory region for the CCM part */
+    memory_region_init_io(&s->ioccm, OBJECT(dev), &imx6ul_ccm_ops, s,
+                          TYPE_IMX6UL_CCM ".ccm", CCM_MAX * sizeof(uint32_t));
+
+    /* Add the CCM as a subregion at offset 0 */
+    memory_region_add_subregion(&s->container, 0, &s->ioccm);
+
+    /* We initialize an IO memory region for the ANALOG part */
+    memory_region_init_io(&s->ioanalog, OBJECT(dev), &imx6ul_analog_ops, s,
+                          TYPE_IMX6UL_CCM ".analog",
+                          CCM_ANALOG_MAX * sizeof(uint32_t));
+
+    /* Add the ANALOG as a subregion at offset 0x4000 */
+    memory_region_add_subregion(&s->container, 0x4000, &s->ioanalog);
+
+    sysbus_init_mmio(sd, &s->container);
+}
+
+static void imx6ul_ccm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
+
+    dc->reset = imx6ul_ccm_reset;
+    dc->vmsd = &vmstate_imx6ul_ccm;
+    dc->desc = "i.MX6UL Clock Control Module";
+
+    ccm->get_clock_frequency = imx6ul_ccm_get_clock_frequency;
+}
+
+static const TypeInfo imx6ul_ccm_info = {
+    .name          = TYPE_IMX6UL_CCM,
+    .parent        = TYPE_IMX_CCM,
+    .instance_size = sizeof(IMX6ULCCMState),
+    .instance_init = imx6ul_ccm_init,
+    .class_init    = imx6ul_ccm_class_init,
+};
+
+static void imx6ul_ccm_register_types(void)
+{
+    type_register_static(&imx6ul_ccm_info);
+}
+
+type_init(imx6ul_ccm_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c956e1419b..1341508b33 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -109,3 +109,10 @@ iotkit_secctl_s_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit Sec
 iotkit_secctl_ns_read(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 iotkit_secctl_ns_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs write: offset 0x%x data 0x%" PRIx64 " size %u"
 iotkit_secctl_reset(void) "IoTKit SecCtl: reset"
+
+# hw/misc/imx6ul_ccm.c
+ccm_entry(void) "\n"
+ccm_freq(uint32_t freq) "freq = %d\n"
+ccm_clock_freq(uint32_t clock, uint32_t freq) "(Clock = %d) = %d\n"
+ccm_read_reg(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32 "\n"
+ccm_write_reg(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32 "\n"
diff --git a/include/hw/misc/imx6ul_ccm.h b/include/hw/misc/imx6ul_ccm.h
new file mode 100644
index 0000000000..377ddca244
--- /dev/null
+++ b/include/hw/misc/imx6ul_ccm.h
@@ -0,0 +1,226 @@
+/*
+ * IMX6UL Clock Control Module
+ *
+ * Copyright (C) 2018 by Jean-Christophe Dubois <jcd@tribudubois.net>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef IMX6UL_CCM_H
+#define IMX6UL_CCM_H
+
+#include "hw/misc/imx_ccm.h"
+#include "qemu/bitops.h"
+
+#define CCM_CCR 0
+#define CCM_CCDR 1
+#define CCM_CSR 2
+#define CCM_CCSR 3
+#define CCM_CACRR 4
+#define CCM_CBCDR 5
+#define CCM_CBCMR 6
+#define CCM_CSCMR1 7
+#define CCM_CSCMR2 8
+#define CCM_CSCDR1 9
+#define CCM_CS1CDR 10
+#define CCM_CS2CDR 11
+#define CCM_CDCDR 12
+#define CCM_CHSCCDR 13
+#define CCM_CSCDR2 14
+#define CCM_CSCDR3 15
+#define CCM_CDHIPR 18
+#define CCM_CTOR 20
+#define CCM_CLPCR 21
+#define CCM_CISR 22
+#define CCM_CIMR 23
+#define CCM_CCOSR 24
+#define CCM_CGPR 25
+#define CCM_CCGR0 26
+#define CCM_CCGR1 27
+#define CCM_CCGR2 28
+#define CCM_CCGR3 29
+#define CCM_CCGR4 30
+#define CCM_CCGR5 31
+#define CCM_CCGR6 32
+#define CCM_CMEOR 34
+#define CCM_MAX 35
+
+#define CCM_ANALOG_PLL_ARM 0
+#define CCM_ANALOG_PLL_ARM_SET 1
+#define CCM_ANALOG_PLL_ARM_CLR 2
+#define CCM_ANALOG_PLL_ARM_TOG 3
+#define CCM_ANALOG_PLL_USB1 4
+#define CCM_ANALOG_PLL_USB1_SET 5
+#define CCM_ANALOG_PLL_USB1_CLR 6
+#define CCM_ANALOG_PLL_USB1_TOG 7
+#define CCM_ANALOG_PLL_USB2 8
+#define CCM_ANALOG_PLL_USB2_SET 9
+#define CCM_ANALOG_PLL_USB2_CLR 10
+#define CCM_ANALOG_PLL_USB2_TOG 11
+#define CCM_ANALOG_PLL_SYS 12
+#define CCM_ANALOG_PLL_SYS_SET 13
+#define CCM_ANALOG_PLL_SYS_CLR 14
+#define CCM_ANALOG_PLL_SYS_TOG 15
+#define CCM_ANALOG_PLL_SYS_SS 16
+#define CCM_ANALOG_PLL_SYS_NUM 20
+#define CCM_ANALOG_PLL_SYS_DENOM 24
+#define CCM_ANALOG_PLL_AUDIO 28
+#define CCM_ANALOG_PLL_AUDIO_SET 29
+#define CCM_ANALOG_PLL_AUDIO_CLR 30
+#define CCM_ANALOG_PLL_AUDIO_TOG 31
+#define CCM_ANALOG_PLL_AUDIO_NUM 32
+#define CCM_ANALOG_PLL_AUDIO_DENOM 36
+#define CCM_ANALOG_PLL_VIDEO 40
+#define CCM_ANALOG_PLL_VIDEO_SET 41
+#define CCM_ANALOG_PLL_VIDEO_CLR 42
+#define CCM_ANALOG_PLL_VIDEO_TOG 44
+#define CCM_ANALOG_PLL_VIDEO_NUM 46
+#define CCM_ANALOG_PLL_VIDEO_DENOM 48
+#define CCM_ANALOG_PLL_ENET 56
+#define CCM_ANALOG_PLL_ENET_SET 57
+#define CCM_ANALOG_PLL_ENET_CLR 58
+#define CCM_ANALOG_PLL_ENET_TOG 59
+#define CCM_ANALOG_PFD_480 60
+#define CCM_ANALOG_PFD_480_SET 61
+#define CCM_ANALOG_PFD_480_CLR 62
+#define CCM_ANALOG_PFD_480_TOG 63
+#define CCM_ANALOG_PFD_528 64
+#define CCM_ANALOG_PFD_528_SET 65
+#define CCM_ANALOG_PFD_528_CLR 66
+#define CCM_ANALOG_PFD_528_TOG 67
+
+/* PMU registers */
+#define PMU_REG_1P1 68
+#define PMU_REG_3P0 72
+#define PMU_REG_2P5 76
+#define PMU_REG_CORE 80
+
+#define CCM_ANALOG_MISC0 84
+#define PMU_MISC0 CCM_ANALOG_MISC0
+#define CCM_ANALOG_MISC0_SET 85
+#define PMU_MISC0_SET CCM_ANALOG_MISC0_SET
+#define CCM_ANALOG_MISC0_CLR 86
+#define PMU_MISC0_CLR CCM_ANALOG_MISC0_CLR
+#define CCM_ANALOG_MISC0_TOG 87
+#define PMU_MISC0_TOG CCM_ANALOG_MISC0_TOG
+
+#define CCM_ANALOG_MISC1 88
+#define PMU_MISC1 CCM_ANALOG_MISC1
+#define CCM_ANALOG_MISC1_SET 89
+#define PMU_MISC1_SET CCM_ANALOG_MISC1_SET
+#define CCM_ANALOG_MISC1_CLR 90
+#define PMU_MISC1_CLR CCM_ANALOG_MISC1_CLR
+#define CCM_ANALOG_MISC1_TOG 91
+#define PMU_MISC1_TOG CCM_ANALOG_MISC1_TOG
+
+#define CCM_ANALOG_MISC2 92
+#define PMU_MISC2 CCM_ANALOG_MISC2
+#define CCM_ANALOG_MISC2_SET 93
+#define PMU_MISC2_SET CCM_ANALOG_MISC2_SET
+#define CCM_ANALOG_MISC2_CLR 94
+#define PMU_MISC2_CLR CCM_ANALOG_MISC2_CLR
+#define CCM_ANALOG_MISC2_TOG 95
+#define PMU_MISC2_TOG CCM_ANALOG_MISC2_TOG
+
+#define TEMPMON_TEMPSENSE0 96
+#define TEMPMON_TEMPSENSE0_SET 97
+#define TEMPMON_TEMPSENSE0_CLR 98
+#define TEMPMON_TEMPSENSE0_TOG 99
+#define TEMPMON_TEMPSENSE1 100
+#define TEMPMON_TEMPSENSE1_SET 101
+#define TEMPMON_TEMPSENSE1_CLR 102
+#define TEMPMON_TEMPSENSE1_TOG 103
+#define TEMPMON_TEMPSENSE2 164
+#define TEMPMON_TEMPSENSE2_SET 165
+#define TEMPMON_TEMPSENSE2_CLR 166
+#define TEMPMON_TEMPSENSE2_TOG 167
+
+#define PMU_LOWPWR_CTRL 155
+#define PMU_LOWPWR_CTRL_SET 156
+#define PMU_LOWPWR_CTRL_CLR 157
+#define PMU_LOWPWR_CTRL_TOG 158
+
+#define USB_ANALOG_USB1_VBUS_DETECT 104
+#define USB_ANALOG_USB1_VBUS_DETECT_SET 105
+#define USB_ANALOG_USB1_VBUS_DETECT_CLR 106
+#define USB_ANALOG_USB1_VBUS_DETECT_TOG 107
+#define USB_ANALOG_USB1_CHRG_DETECT 108
+#define USB_ANALOG_USB1_CHRG_DETECT_SET 109
+#define USB_ANALOG_USB1_CHRG_DETECT_CLR 110
+#define USB_ANALOG_USB1_CHRG_DETECT_TOG 111
+#define USB_ANALOG_USB1_VBUS_DETECT_STAT 112
+#define USB_ANALOG_USB1_CHRG_DETECT_STAT 116
+#define USB_ANALOG_USB1_MISC 124
+#define USB_ANALOG_USB1_MISC_SET 125
+#define USB_ANALOG_USB1_MISC_CLR 126
+#define USB_ANALOG_USB1_MISC_TOG 127
+#define USB_ANALOG_USB2_VBUS_DETECT 128
+#define USB_ANALOG_USB2_VBUS_DETECT_SET 129
+#define USB_ANALOG_USB2_VBUS_DETECT_CLR 130
+#define USB_ANALOG_USB2_VBUS_DETECT_TOG 131
+#define USB_ANALOG_USB2_CHRG_DETECT 132
+#define USB_ANALOG_USB2_CHRG_DETECT_SET 133
+#define USB_ANALOG_USB2_CHRG_DETECT_CLR 134
+#define USB_ANALOG_USB2_CHRG_DETECT_TOG 135
+#define USB_ANALOG_USB2_VBUS_DETECT_STAT 136
+#define USB_ANALOG_USB2_CHRG_DETECT_STAT 140
+#define USB_ANALOG_USB2_MISC 148
+#define USB_ANALOG_USB2_MISC_SET 149
+#define USB_ANALOG_USB2_MISC_CLR 150
+#define USB_ANALOG_USB2_MISC_TOG 151
+#define USB_ANALOG_DIGPROG 152
+#define CCM_ANALOG_MAX 4096
+
+/* CCM_CBCMR */
+#define R_CBCMR_PRE_PERIPH_CLK_SEL_SHIFT  (18)
+#define R_CBCMR_PRE_PERIPH_CLK_SEL_LENGTH (2)
+#define R_CBCMR_PERIPH_CLK2_SEL_SHIFT    (12)
+#define R_CBCMR_PERIPH_CLK2_SEL_LENGTH   (2)
+
+/* CCM_CBCDR */
+#define R_CBCDR_AHB_PODF_SHIFT           (10)
+#define R_CBCDR_AHB_PODF_LENGTH          (3)
+#define R_CBCDR_IPG_PODF_SHIFT           (8)
+#define R_CBCDR_IPG_PODF_LENGTH          (2)
+#define R_CBCDR_PERIPH_CLK_SEL_SHIFT     (25)
+#define R_CBCDR_PERIPH_CLK_SEL_LENGTH    (1)
+#define R_CBCDR_PERIPH_CLK2_PODF_SHIFT   (27)
+#define R_CBCDR_PERIPH_CLK2_PODF_LENGTH  (3)
+
+/* CCM_CSCMR1 */
+#define R_CSCMR1_PERCLK_PODF_SHIFT        (0)
+#define R_CSCMR1_PERCLK_PODF_LENGTH       (6)
+#define R_CSCMR1_PERCLK_CLK_SEL_SHIFT     (6)
+#define R_CSCMR1_PERCLK_CLK_SEL_LENGTH    (1)
+
+/* CCM_ANALOG_PFD_528 */
+#define R_ANALOG_PFD_528_PFD0_FRAC_SHIFT          (0)
+#define R_ANALOG_PFD_528_PFD0_FRAC_LENGTH         (6)
+#define R_ANALOG_PFD_528_PFD2_FRAC_SHIFT          (16)
+#define R_ANALOG_PFD_528_PFD2_FRAC_LENGTH         (6)
+
+/* CCM_ANALOG_PLL_SYS */
+#define R_ANALOG_PLL_SYS_DIV_SELECT_SHIFT         (0)
+#define R_ANALOG_PLL_SYS_DIV_SELECT_LENGTH        (1)
+
+#define CCM_ANALOG_PLL_LOCK      (1 << 31);
+
+#define TYPE_IMX6UL_CCM "imx6ul.ccm"
+#define IMX6UL_CCM(obj) OBJECT_CHECK(IMX6ULCCMState, (obj), TYPE_IMX6UL_CCM)
+
+typedef struct IMX6ULCCMState {
+    /* <private> */
+    IMXCCMState parent_obj;
+
+    /* <public> */
+    MemoryRegion container;
+    MemoryRegion ioccm;
+    MemoryRegion ioanalog;
+
+    uint32_t ccm[CCM_MAX];
+    uint32_t analog[CCM_ANALOG_MAX];
+
+} IMX6ULCCMState;
+
+#endif /* IMX6UL_CCM_H */
-- 
2.17.1
