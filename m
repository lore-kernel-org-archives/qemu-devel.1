Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452EFC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10793233FE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Ubvw8N/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10793233FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSLk-00058U-Sq
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 10:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1jLSBl-00041b-UE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1jLSBk-0002An-Ay
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:53:21 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1jLSBg-00024e-Kr; Mon, 06 Apr 2020 09:53:16 -0400
Received: from crumble.bar.greensocs.com (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPS id 2AC3E96F54;
 Mon,  6 Apr 2020 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1586181195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2tbUoohONT12BkgoX/7zs5Zt2Dh5babDEcWSQSxGdE=;
 b=Ubvw8N/o7Mt4kGY93RfcxKslQaIKxTRintMeR/jEGCtyLsVW8WCBqQVjBLhdEx3S3pv1F0
 L/OuJM1Vcb6aVd1vXYZc+++wuMWNhMhdfZJ6BJycU234amV7qK2tkBLjZ75JKDeRBApNdU
 HLySdIBVpeOky8haQFbN5xV7ZfREPao=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 6/9] hw/misc/zynq_slcr: add clock generation for uarts
Date: Mon,  6 Apr 2020 15:52:48 +0200
Message-Id: <20200406135251.157596-7-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406135251.157596-1-damien.hedde@greensocs.com>
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1586181195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2tbUoohONT12BkgoX/7zs5Zt2Dh5babDEcWSQSxGdE=;
 b=JFlLXO7QR/k9v4ie/Ub5k4pE7kwa9Dr6vCtbOs7NSeqKvjWs7OpyPU3DLXfn+RQqkDxScY
 /BZPEUF7/gi3y4WmobhYrT1lXF/KBFVX67TU1ySHO69YsVGb0sg9raC2QwDCroL28yGxsK
 CY4lLSWM3x9XIAKk1bd60WQJHT40ynM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1586181195; a=rsa-sha256; cv=none;
 b=3QUR/lmlL01rBEX0vY0mL8g7Xjt8m2ZNsj7kDBg5pf8x8HMrjQ/Q17ju6hxSXT3YtKS9c2
 HFcG1M//jdS8vungfq0ShzQv97GLJDZt/fwtO1h1nLKevn0P9A1KepT1edwqfe0ONV8Xyn
 claJDc7rdTG9cOfLlad+w5eoAkb6cWk=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, marcandre.lureau@redhat.com,
 edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some clocks to zynq_slcr
+ the main input clock (ps_clk)
+ the reference clock outputs for each uart (uart0 & 1)

This commit also transitional the slcr to multi-phase reset as it is
required to initialize the clocks correctly.

The clock frequencies are computed using the internal pll & uart configur=
ation
registers and the input ps_clk frequency.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---

v7:
  + handle migration of input clock
  + update ClockIn/ClockOut types
  + comments correction/precision (Peter)
---
 hw/misc/zynq_slcr.c | 172 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 168 insertions(+), 4 deletions(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index b9a38272d9..f7472d1f3c 100644
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
@@ -179,11 +190,127 @@ typedef struct ZynqSLCRState {
     MemoryRegion iomem;
=20
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
+
+    Clock *ps_clk;
+    Clock *uart0_ref_clk;
+    Clock *uart1_ref_clk;
 } ZynqSLCRState;
=20
-static void zynq_slcr_reset(DeviceState *d)
+/*
+ * return the output frequency of ARM/DDR/IO pll
+ * using input frequency and PLL_CTRL register
+ */
+static uint64_t zynq_slcr_compute_pll(uint64_t input, uint32_t ctrl_reg)
 {
-    ZynqSLCRState *s =3D ZYNQ_SLCR(d);
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
+    /* frequency multiplier -> period division */
+    return input / mult;
+}
+
+/*
+ * return the output period of a clock given:
+ * + the periods in an array corresponding to input mux selector
+ * + the register xxx_CLK_CTRL value
+ * + enable bit index in ctrl register
+ *
+ * This function makes the assumption that the ctrl_reg value is organiz=
ed as
+ * follows:
+ * + bits[13:8]  clock frequency divisor
+ * + bits[5:4]   clock mux selector (index in array)
+ * + bits[index] clock enable
+ */
+static uint64_t zynq_slcr_compute_clock(const uint64_t periods[],
+                                        uint32_t ctrl_reg,
+                                        unsigned index)
+{
+    uint32_t srcsel =3D extract32(ctrl_reg, 4, 2); /* bits [5:4] */
+    uint32_t divisor =3D extract32(ctrl_reg, 8, 6); /* bits [13:8] */
+
+    /* first, check if clock is disabled */
+    if (((ctrl_reg >> index) & 1u) =3D=3D 0) {
+        return 0;
+    }
+
+    /*
+     * according to the Zynq technical ref. manual UG585 v1.12.2 in
+     * Clocks chapter, section 25.10.1 page 705:
+     * "The 6-bit divider provides a divide range of 1 to 63"
+     * We follow here what is implemented in linux kernel and consider
+     * the 0 value as a bypass (no division).
+     */
+    /* frequency divisor -> period multiplication */
+    return periods[srcsel] * (divisor ? divisor : 1u);
+}
+
+/*
+ * macro helper around zynq_slcr_compute_clock to avoid repeating
+ * the register name.
+ */
+#define ZYNQ_COMPUTE_CLK(state, plls, reg, enable_field) \
+    zynq_slcr_compute_clock((plls), (state)->regs[reg], \
+                            reg ## _ ## enable_field ## _SHIFT)
+
+/**
+ * Compute and set the ouputs clocks periods.
+ * But do not propagate them further. Connected clocks
+ * will not receive any updates (See zynq_slcr_compute_clocks())
+ */
+static void zynq_slcr_compute_clocks(ZynqSLCRState *s)
+{
+    uint64_t ps_clk =3D clock_get(s->ps_clk);
+
+    /* consider outputs clocks are disabled while in reset */
+    if (device_is_in_reset(DEVICE(s))) {
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
+    clock_set(s->uart0_ref_clk,
+              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT0));
+    clock_set(s->uart1_ref_clk,
+              ZYNQ_COMPUTE_CLK(s, uart_mux, R_UART_CLK_CTRL, CLKACT1));
+}
+
+/**
+ * Propagate the outputs clocks.
+ * zynq_slcr_compute_clocks() should have been called before
+ * to configure them.
+ */
+static void zynq_slcr_propagate_clocks(ZynqSLCRState *s)
+{
+    clock_propagate(s->uart0_ref_clk);
+    clock_propagate(s->uart1_ref_clk);
+}
+
+static void zynq_slcr_ps_clk_callback(void *opaque)
+{
+    ZynqSLCRState *s =3D (ZynqSLCRState *) opaque;
+    zynq_slcr_compute_clocks(s);
+    zynq_slcr_propagate_clocks(s);
+}
+
+static void zynq_slcr_reset_init(Object *obj, ResetType type)
+{
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
     int i;
=20
     DB_PRINT("RESET\n");
@@ -277,6 +404,23 @@ static void zynq_slcr_reset(DeviceState *d)
     s->regs[R_DDRIOB + 12] =3D 0x00000021;
 }
=20
+static void zynq_slcr_reset_hold(Object *obj)
+{
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
+
+    /* will disable all output clocks */
+    zynq_slcr_compute_clocks(s);
+    zynq_slcr_propagate_clocks(s);
+}
+
+static void zynq_slcr_reset_exit(Object *obj)
+{
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
+
+    /* will compute output clocks according to ps_clk and registers */
+    zynq_slcr_compute_clocks(s);
+    zynq_slcr_propagate_clocks(s);
+}
=20
 static bool zynq_slcr_check_offset(hwaddr offset, bool rnw)
 {
@@ -409,6 +553,13 @@ static void zynq_slcr_write(void *opaque, hwaddr off=
set,
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
+    case R_IO_PLL_CTRL:
+    case R_ARM_PLL_CTRL:
+    case R_DDR_PLL_CTRL:
+    case R_UART_CLK_CTRL:
+        zynq_slcr_compute_clocks(s);
+        zynq_slcr_propagate_clocks(s);
+        break;
     }
 }
=20
@@ -418,6 +569,13 @@ static const MemoryRegionOps slcr_ops =3D {
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
@@ -425,14 +583,17 @@ static void zynq_slcr_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &slcr_ops, s, "slcr",
                           ZYNQ_SLCR_MMIO_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
+    qdev_init_clocks(DEVICE(obj), zynq_slcr_clocks);
 }
=20
 static const VMStateDescription vmstate_zynq_slcr =3D {
     .name =3D "zynq_slcr",
-    .version_id =3D 2,
+    .version_id =3D 3,
     .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, ZynqSLCRState, ZYNQ_SLCR_NUM_REGS),
+        VMSTATE_CLOCK_V(ps_clk, ZynqSLCRState, 3),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -440,9 +601,12 @@ static const VMStateDescription vmstate_zynq_slcr =3D=
 {
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_zynq_slcr;
-    dc->reset =3D zynq_slcr_reset;
+    rc->phases.enter =3D zynq_slcr_reset_init;
+    rc->phases.hold  =3D zynq_slcr_reset_hold;
+    rc->phases.exit  =3D zynq_slcr_reset_exit;
 }
=20
 static const TypeInfo zynq_slcr_info =3D {
--=20
2.26.0


