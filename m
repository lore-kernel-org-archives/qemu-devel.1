Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12429C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BFC2168B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="7UTeVXTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BFC2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5V7o-0005tZ-Od
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5Upg-0006bi-Fv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5Upe-0005d5-QV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:56:20 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:45988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i5Upa-0005Yx-5D; Wed, 04 Sep 2019 08:56:14 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id CE89196F65;
 Wed,  4 Sep 2019 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1567601773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7sDKq7aWXDonSFSKGhw9/2WYTabyRQyQupDcGMYv/E=;
 b=7UTeVXTgZdy6WLIz59AfgO9wc9TiYpWuUFoCmABJHqaox3SwgB3wOp75s+Uwu2OHOB2Lzn
 kXv1XAvL+tnA4XtmkcQxEpnejhsoz1BdfI2TjDuSs4L25YhT8RpufwejZToMexr1PZkUQb
 +ZgmYQDR1M9P6wkAFuMcjTLuXe76FhE=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 14:55:29 +0200
Message-Id: <20190904125531.27545-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190904125531.27545-1-damien.hedde@greensocs.com>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1567601773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7sDKq7aWXDonSFSKGhw9/2WYTabyRQyQupDcGMYv/E=;
 b=yRTk2zxVRVo/Ktd2R4ntC76x0ww3qH7E/pXebmjmPD/zYMeFqJkPIf0XO+9+H5sX5Aex9l
 rYobSdObK66ufsIGgWS5nKzoUUKB2Bj20FscrsgelWv76Mn/cuqq1W4qGuXUq0Ftm3uQLv
 f437aaJg4Buv2Fwk1wpLbWqoXXc5rIQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1567601773; a=rsa-sha256; cv=none;
 b=5elN5/1A1Jer9V6rvMLTys4y8kF0+Ol1JK1lexd0G72xRzIRcIyFTKlZl1GkmVXbw5ZCT9
 715y6YK1y1RL4101K7BajfU0sZ5rZftg1IHcSmPXghluwjUKQA41DXx1JFI27EJcBdt29E
 7wU2SAkvJy/boWn4wWtiG1M0D3bCfVY=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v6 7/9] hw/misc/zynq_slcr: add clock generation
 for uarts
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the slcr to multi-phase reset and add some clocks:
+ the main input clock (ps_clk)
+ the reference clock outputs for each uart (uart0 & 1)

The clock frequencies are computed using the internal pll & uart configur=
ation
registers and the ps_clk frequency.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/misc/zynq_slcr.c | 145 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 3 deletions(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index b9a38272d9..fa2ac608eb 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/registerfields.h"
+#include "hw/qdev-clock.h"
=20
 #ifndef ZYNQ_SLCR_ERR_DEBUG
 #define ZYNQ_SLCR_ERR_DEBUG 0
@@ -45,6 +46,12 @@ REG32(LOCKSTA, 0x00c)
 REG32(ARM_PLL_CTRL, 0x100)
 REG32(DDR_PLL_CTRL, 0x104)
 REG32(IO_PLL_CTRL, 0x108)
+/* fields for [ARM|DDR|IO]_PLL_CTRL registers */
+    FIELD(xxx_PLL_CTRL, PLL_RESET, 0, 1)
+    FIELD(xxx_PLL_CTRL, PLL_PWRDWN, 1, 1)
+    FIELD(xxx_PLL_CTRL, PLL_BYPASS_QUAL, 3, 1)
+    FIELD(xxx_PLL_CTRL, PLL_BYPASS_FORCE, 4, 1)
+    FIELD(xxx_PLL_CTRL, PLL_FPDIV, 12, 7)
 REG32(PLL_STATUS, 0x10c)
 REG32(ARM_PLL_CFG, 0x110)
 REG32(DDR_PLL_CFG, 0x114)
@@ -64,6 +71,10 @@ REG32(SMC_CLK_CTRL, 0x148)
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
@@ -179,11 +190,106 @@ typedef struct ZynqSLCRState {
     MemoryRegion iomem;
=20
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
+
+    ClockIn *ps_clk;
+    ClockOut *uart0_ref_clk;
+    ClockOut *uart1_ref_clk;
 } ZynqSLCRState;
=20
-static void zynq_slcr_reset(DeviceState *d)
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
+ * + the frequencies in an array corresponding to mux's indexes
+ * + the register xxx_CLK_CTRL value
+ * + enable bit index in ctrl register
+ *
+ * This function make the assumption that ctrl_reg value is organized as=
 follow:
+ * + bits[13:8] clock divisor
+ * + bits[5:4]  clock mux selector (index in array)
+ * + bits[index] clock enable
+ */
+static uint64_t zynq_slcr_compute_clock(const uint64_t mux[],
+                                        uint32_t ctrl_reg,
+                                        unsigned index)
+{
+    uint32_t srcsel =3D extract32(ctrl_reg, 4, 2); /* bits [5:4] */
+    uint32_t divisor =3D extract32(ctrl_reg, 8, 6); /* bits [13:8] */
+
+    /* first, check if clock is enabled */
+    if (((ctrl_reg >> index) & 1u) =3D=3D 0) {
+        return 0;
+    }
+
+    /*
+     * according to the Zynq technical ref. manual UG585 v1.12.2 in
+     * "Clocks" chapter, section 25.10.1 page 705" the range of the divi=
sor
+     * is [1;63].
+     * So divide the source while avoiding division-by-zero.
+     */
+    return mux[srcsel] / (divisor ? divisor : 1u);
+}
+
+/*
+ * macro helper around zynq_slcr_compute_clock to avoid repeating
+ * the register name.
+ */
+#define ZYNQ_COMPUTE_CLOCK(_state, _plls, _reg, _enable_field) \
+    zynq_slcr_compute_clock((_plls), (_state)->regs[R_ ## _reg], \
+            R_ ## _reg ## _ ## _enable_field ## _SHIFT)
+
+static void zynq_slcr_compute_clocks(ZynqSLCRState *s)
+{
+    uint64_t ps_clk =3D clock_get_frequency(s->ps_clk);
+
+    /* consider all output clocks are disabled while in reset */
+    if (device_is_resetting(DEVICE(s))) {
+        ps_clk =3D 0;
+    }
+
+    uint64_t io_pll =3D zynq_slcr_compute_pll(ps_clk, s->regs[R_IO_PLL_C=
TRL]);
+    uint64_t arm_pll =3D zynq_slcr_compute_pll(ps_clk, s->regs[R_ARM_PLL=
_CTRL]);
+    uint64_t ddr_pll =3D zynq_slcr_compute_pll(ps_clk, s->regs[R_DDR_PLL=
_CTRL]);
+
+    uint64_t uart_mux[4] =3D {io_pll, io_pll, arm_pll, ddr_pll};
+
+    /* compute uartX reference clocks */
+    clock_set_frequency(s->uart0_ref_clk,
+            ZYNQ_COMPUTE_CLOCK(s, uart_mux, UART_CLK_CTRL, CLKACT0));
+    clock_set_frequency(s->uart1_ref_clk,
+            ZYNQ_COMPUTE_CLOCK(s, uart_mux, UART_CLK_CTRL, CLKACT1));
+}
+
+static void zynq_slcr_ps_clk_callback(void *opaque)
+{
+    ZynqSLCRState *s =3D (ZynqSLCRState *) opaque;
+    zynq_slcr_compute_clocks(s);
+}
+
+static void zynq_slcr_reset_init(Object *obj, ResetType type)
 {
-    ZynqSLCRState *s =3D ZYNQ_SLCR(d);
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
     int i;
=20
     DB_PRINT("RESET\n");
@@ -277,6 +383,21 @@ static void zynq_slcr_reset(DeviceState *d)
     s->regs[R_DDRIOB + 12] =3D 0x00000021;
 }
=20
+static void zynq_slcr_reset_hold(Object *obj)
+{
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
+
+    /* will disable all output clocks */
+    zynq_slcr_compute_clocks(s);
+}
+
+static void zynq_slcr_reset_exit(Object *obj)
+{
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
+
+    /* will compute output clocks according to ps_clk and registers */
+    zynq_slcr_compute_clocks(s);
+}
=20
 static bool zynq_slcr_check_offset(hwaddr offset, bool rnw)
 {
@@ -409,6 +530,12 @@ static void zynq_slcr_write(void *opaque, hwaddr off=
set,
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
+    case R_IO_PLL_CTRL:
+    case R_ARM_PLL_CTRL:
+    case R_DDR_PLL_CTRL:
+    case R_UART_CLK_CTRL:
+        zynq_slcr_compute_clocks(s);
+        break;
     }
 }
=20
@@ -418,6 +545,13 @@ static const MemoryRegionOps slcr_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
+static const ClockPortInitArray zynq_slcr_clocks =3D {
+    QDEV_CLOCK_IN(ZynqSLCRState, ps_clk, zynq_slcr_ps_clk_callback),
+    QDEV_CLOCK_OUT(ZynqSLCRState, uart0_ref_clk),
+    QDEV_CLOCK_OUT(ZynqSLCRState, uart1_ref_clk),
+    QDEV_CLOCK_END
+};
+
 static void zynq_slcr_init(Object *obj)
 {
     ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
@@ -425,6 +559,8 @@ static void zynq_slcr_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &slcr_ops, s, "slcr",
                           ZYNQ_SLCR_MMIO_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
+    qdev_init_clocks(DEVICE(obj), zynq_slcr_clocks);
 }
=20
 static const VMStateDescription vmstate_zynq_slcr =3D {
@@ -440,9 +576,12 @@ static const VMStateDescription vmstate_zynq_slcr =3D=
 {
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_zynq_slcr;
-    dc->reset =3D zynq_slcr_reset;
+    rc->phases.init =3D zynq_slcr_reset_init;
+    rc->phases.hold =3D zynq_slcr_reset_hold;
+    rc->phases.exit =3D zynq_slcr_reset_exit;
 }
=20
 static const TypeInfo zynq_slcr_info =3D {
--=20
2.22.0


