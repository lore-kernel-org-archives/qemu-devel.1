Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC2C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900A9221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Ny5gMLcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900A9221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkyz-0006yf-Np
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknn-0001cp-Rb; Fri, 25 Sep 2020 06:18:07 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknd-0007SF-9O; Fri, 25 Sep 2020 06:18:07 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 97D56C60F21;
 Fri, 25 Sep 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/uiZF1SCdR1bRANIJzuR1+OmsRilHDQs3qMfJu0mlc=;
 b=Ny5gMLcIT5LVGwu96dSmeIQMW6zMOS44WIGOXbpT98YGM9Dk+ub9nLyQhN7DkCHNy5ovbi
 8NyOJxZVzcN4DecaVT2SSyzcM0hYnaUVrdqYN3qPnNodWv8PtQe6zRMRQCI4Eu8LgKnqMq
 brga4yk4ha3T7IV+8DjqUT53CphM2EEPwNadz9j09dJ5x855d5BqG/fHWbzIBtUuzdZAJl
 LMZGdqB7tK/BIoTvUO8lObrvr7/yf9Wf9fSFlPIAFB7BHRzKtRVbHofTmUHVyhvg74bef8
 9DtjHaRhKfKjxCgX1cc8AIIkmq0DorC3t+7OZ1ktPRuGjagq046DcTHpEhle5w==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/14] hw/misc/bcm2835_cprman: add a clock mux skeleton
 implementation
Date: Fri, 25 Sep 2020 12:17:26 +0200
Message-Id: <20200925101731.2159827-10-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/uiZF1SCdR1bRANIJzuR1+OmsRilHDQs3qMfJu0mlc=;
 b=UASWEYRVO/rnTq6Twa176OYt79KIeKLKLplcx3TlusE1GF4Pmc3jOl0t+Ga02IevyeutLD
 GEZuKzhB/c7/BqH7Sk5F/Wihbqd1j8kf6aztpx4xAR8bGSsCw/vmiJKrt5Y/gIc9vy+Vz4
 vC6cq1xdRBPvNLTVJA40DTSODVEd6Tr7VcoGHCIVdnpczqDJNrauS7J2pEaNoQwp8GoxJC
 ywOkZXIpnmlGsEk6oRrTYXrR5ZMUN9MAF8iT99NmymfwiD77CJGdlfNzoWjlpACXno1Gb7
 8hVOt8RE0bqMzqF/rpImbaIwX81mvq+M3q0w68JGaizJvg5gdjDxlhCuN67ojA==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=abkHKzLcVT2uNScMxu2uIs7QKz9pgBczqZVi8arvjlzjy26u5xC3i6JbfVPfuestCo9UJX/7j7KyMDHEJcc5XHqXgw4pU7mwdFqVG/7vy0AV6gWjdSLFcm+jwXjRnu/Df2KqpJWZHO5LmJMTvykMNwWoNrggx39bxP9B74krrJXzlJc/14253o2q/Qp7NHZcn+oLjOuCUizSfqzQJkR4jfka9sQMKdMh+LIOLjVTUycMc5wBzBKf4dmJMV+7bghLjRwonvLuEmequVD9IhXiyOMidR6JUqG4YU+9Z9WAXrl8XDCengxnM7KT9iM7QBpGYfxso4ZfRbQyBAd84uyFIw==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The clock multiplexers are the last clock stage in the cprman. Each mux
outputs one clock signal that goes out of the cprman to the SoC
peripherals.

Each mux has at most 10 sources. The sources 0 to 3 are common to all
muxes. They are:
   0. ground (no clock signal)
   1. the main oscillator (xosc)
   2. "test debug 0" clock
   3. "test debug 1" clock

Test debug 0 and 1 are actual clock muxes that can be used as sources to
other muxes (for debug purpose).

Sources 4 to 9 are mux specific and can be unpopulated (grounded). Those
sources are fed by the PLL channels outputs.

One corner case exists for DSI0E and DSI0P muxes. They have their source
number 4 connected to an intermediate multiplexer that can select
between PLLA-DSI0 and PLLD-DSI0 channel. This multiplexer is called
DSI0HSCK and is not a clock mux as such. It is really a simple mux from
the hardware point of view (see https://elinux.org/The_Undocumented_Pi).
This mux is not implemented in this commit.

Note that there is some muxes for which sources are unknown (because of
a lack of documentation). For those cases all the sources are connected
to ground in this implementation.

Each clock mux output is exported by the cprman at the qdev level,
adding the suffix '-out' to the mux name to form the output clock name.
(E.g. the 'uart' mux sees its output exported as 'uart-out' at the
cprman level.)

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/misc/bcm2835_cprman.h           |  84 ++++
 include/hw/misc/bcm2835_cprman_internals.h | 421 +++++++++++++++++++++
 hw/misc/bcm2835_cprman.c                   | 151 ++++++++
 3 files changed, 656 insertions(+)

diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index aaf15fb20c..c2a89e8e90 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -52,12 +52,73 @@ typedef enum CprmanPLLChannel {
     CPRMAN_PLLH_CHANNEL_PIX,
 
     CPRMAN_PLLB_CHANNEL_ARM,
 
     CPRMAN_NUM_PLL_CHANNEL,
+
+    /* Special values used when connecting clock sources to clocks */
+    CPRMAN_CLOCK_SRC_NORMAL = -1,
+    CPRMAN_CLOCK_SRC_FORCE_GROUND = -2,
+    CPRMAN_CLOCK_SRC_DSI0HSCK = -3,
 } CprmanPLLChannel;
 
+typedef enum CprmanClockMux {
+    CPRMAN_CLOCK_GNRIC,
+    CPRMAN_CLOCK_VPU,
+    CPRMAN_CLOCK_SYS,
+    CPRMAN_CLOCK_PERIA,
+    CPRMAN_CLOCK_PERII,
+    CPRMAN_CLOCK_H264,
+    CPRMAN_CLOCK_ISP,
+    CPRMAN_CLOCK_V3D,
+    CPRMAN_CLOCK_CAM0,
+    CPRMAN_CLOCK_CAM1,
+    CPRMAN_CLOCK_CCP2,
+    CPRMAN_CLOCK_DSI0E,
+    CPRMAN_CLOCK_DSI0P,
+    CPRMAN_CLOCK_DPI,
+    CPRMAN_CLOCK_GP0,
+    CPRMAN_CLOCK_GP1,
+    CPRMAN_CLOCK_GP2,
+    CPRMAN_CLOCK_HSM,
+    CPRMAN_CLOCK_OTP,
+    CPRMAN_CLOCK_PCM,
+    CPRMAN_CLOCK_PWM,
+    CPRMAN_CLOCK_SLIM,
+    CPRMAN_CLOCK_SMI,
+    CPRMAN_CLOCK_TEC,
+    CPRMAN_CLOCK_TD0,
+    CPRMAN_CLOCK_TD1,
+    CPRMAN_CLOCK_TSENS,
+    CPRMAN_CLOCK_TIMER,
+    CPRMAN_CLOCK_UART,
+    CPRMAN_CLOCK_VEC,
+    CPRMAN_CLOCK_PULSE,
+    CPRMAN_CLOCK_SDC,
+    CPRMAN_CLOCK_ARM,
+    CPRMAN_CLOCK_AVEO,
+    CPRMAN_CLOCK_EMMC,
+    CPRMAN_CLOCK_EMMC2,
+
+    CPRMAN_NUM_CLOCK_MUX
+} CprmanClockMux;
+
+typedef enum CprmanClockMuxSource {
+    CPRMAN_CLOCK_SRC_GND = 0,
+    CPRMAN_CLOCK_SRC_XOSC,
+    CPRMAN_CLOCK_SRC_TD0,
+    CPRMAN_CLOCK_SRC_TD1,
+    CPRMAN_CLOCK_SRC_PLLA,
+    CPRMAN_CLOCK_SRC_PLLC,
+    CPRMAN_CLOCK_SRC_PLLD,
+    CPRMAN_CLOCK_SRC_PLLH,
+    CPRMAN_CLOCK_SRC_PLLC_CORE1,
+    CPRMAN_CLOCK_SRC_PLLC_CORE2,
+
+    CPRMAN_NUM_CLOCK_MUX_SRC
+} CprmanClockMuxSource;
+
 typedef struct CprmanPLLState {
     /*< private >*/
     DeviceState parent_obj;
 
     /*< public >*/
@@ -89,22 +150,45 @@ typedef struct CprmanPLLChannelState {
 
     Clock *pll_in;
     Clock *out;
 } CprmanPLLChannelState;
 
+typedef struct CprmanClockMuxState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    CprmanClockMux id;
+
+    uint32_t *reg_cm;
+    int int_bits;
+    int frac_bits;
+
+    Clock *srcs[CPRMAN_NUM_CLOCK_MUX_SRC];
+    Clock *out;
+
+    /*
+     * Used by clock srcs update callback to retrieve both the clock and the
+     * source number.
+     */
+    struct CprmanClockMuxState *backref[CPRMAN_NUM_CLOCK_MUX_SRC];
+} CprmanClockMuxState;
+
 struct BCM2835CprmanState {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
     MemoryRegion iomem;
 
     CprmanPLLState plls[CPRMAN_NUM_PLL];
     CprmanPLLChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
+    CprmanClockMuxState clock_muxes[CPRMAN_NUM_CLOCK_MUX];
 
     uint32_t regs[CPRMAN_NUM_REGS];
     uint32_t xosc_freq;
 
     Clock *xosc;
+    Clock *gnd;
 };
 
 #endif
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 8a5b9aae67..a2b5a1aa50 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -12,15 +12,18 @@
 #include "hw/registerfields.h"
 #include "hw/misc/bcm2835_cprman.h"
 
 #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
 #define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
+#define TYPE_CPRMAN_CLOCK_MUX "bcm2835-cprman-clock-mux"
 
 DECLARE_INSTANCE_CHECKER(CprmanPLLState, CPRMAN_PLL,
                          TYPE_CPRMAN_PLL)
 DECLARE_INSTANCE_CHECKER(CprmanPLLChannelState, CPRMAN_PLL_CHANNEL,
                          TYPE_CPRMAN_PLL_CHANNEL)
+DECLARE_INSTANCE_CHECKER(CprmanClockMuxState, CPRMAN_CLOCK_MUX,
+                         TYPE_CPRMAN_CLOCK_MUX)
 
 /* Register map */
 
 /* PLLs */
 REG32(CM_PLLA, 0x104)
@@ -126,10 +129,94 @@ REG32(A2W_PLLH_RCAL, 0x1460)
 REG32(A2W_PLLH_PIX, 0x1560)
 REG32(A2W_PLLH_STS, 0x1660)
 
 REG32(A2W_PLLB_ARM, 0x13e0)
 
+/* Clock muxes */
+REG32(CM_GNRICCTL, 0x000)
+    FIELD(CM_CLOCKx_CTL, SRC, 0, 4)
+    FIELD(CM_CLOCKx_CTL, ENABLE, 4, 1)
+    FIELD(CM_CLOCKx_CTL, KILL, 5, 1)
+    FIELD(CM_CLOCKx_CTL, GATE, 6, 1)
+    FIELD(CM_CLOCKx_CTL, BUSY, 7, 1)
+    FIELD(CM_CLOCKx_CTL, BUSYD, 8, 1)
+    FIELD(CM_CLOCKx_CTL, MASH, 9, 2)
+    FIELD(CM_CLOCKx_CTL, FLIP, 11, 1)
+REG32(CM_GNRICDIV, 0x004)
+    FIELD(CM_CLOCKx_DIV, FRAC, 0, 12)
+REG32(CM_VPUCTL, 0x008)
+REG32(CM_VPUDIV, 0x00c)
+REG32(CM_SYSCTL, 0x010)
+REG32(CM_SYSDIV, 0x014)
+REG32(CM_PERIACTL, 0x018)
+REG32(CM_PERIADIV, 0x01c)
+REG32(CM_PERIICTL, 0x020)
+REG32(CM_PERIIDIV, 0x024)
+REG32(CM_H264CTL, 0x028)
+REG32(CM_H264DIV, 0x02c)
+REG32(CM_ISPCTL, 0x030)
+REG32(CM_ISPDIV, 0x034)
+REG32(CM_V3DCTL, 0x038)
+REG32(CM_V3DDIV, 0x03c)
+REG32(CM_CAM0CTL, 0x040)
+REG32(CM_CAM0DIV, 0x044)
+REG32(CM_CAM1CTL, 0x048)
+REG32(CM_CAM1DIV, 0x04c)
+REG32(CM_CCP2CTL, 0x050)
+REG32(CM_CCP2DIV, 0x054)
+REG32(CM_DSI0ECTL, 0x058)
+REG32(CM_DSI0EDIV, 0x05c)
+REG32(CM_DSI0PCTL, 0x060)
+REG32(CM_DSI0PDIV, 0x064)
+REG32(CM_DPICTL, 0x068)
+REG32(CM_DPIDIV, 0x06c)
+REG32(CM_GP0CTL, 0x070)
+REG32(CM_GP0DIV, 0x074)
+REG32(CM_GP1CTL, 0x078)
+REG32(CM_GP1DIV, 0x07c)
+REG32(CM_GP2CTL, 0x080)
+REG32(CM_GP2DIV, 0x084)
+REG32(CM_HSMCTL, 0x088)
+REG32(CM_HSMDIV, 0x08c)
+REG32(CM_OTPCTL, 0x090)
+REG32(CM_OTPDIV, 0x094)
+REG32(CM_PCMCTL, 0x098)
+REG32(CM_PCMDIV, 0x09c)
+REG32(CM_PWMCTL, 0x0a0)
+REG32(CM_PWMDIV, 0x0a4)
+REG32(CM_SLIMCTL, 0x0a8)
+REG32(CM_SLIMDIV, 0x0ac)
+REG32(CM_SMICTL, 0x0b0)
+REG32(CM_SMIDIV, 0x0b4)
+REG32(CM_TCNTCTL, 0x0c0)
+REG32(CM_TCNTCNT, 0x0c4)
+REG32(CM_TECCTL, 0x0c8)
+REG32(CM_TECDIV, 0x0cc)
+REG32(CM_TD0CTL, 0x0d0)
+REG32(CM_TD0DIV, 0x0d4)
+REG32(CM_TD1CTL, 0x0d8)
+REG32(CM_TD1DIV, 0x0dc)
+REG32(CM_TSENSCTL, 0x0e0)
+REG32(CM_TSENSDIV, 0x0e4)
+REG32(CM_TIMERCTL, 0x0e8)
+REG32(CM_TIMERDIV, 0x0ec)
+REG32(CM_UARTCTL, 0x0f0)
+REG32(CM_UARTDIV, 0x0f4)
+REG32(CM_VECCTL, 0x0f8)
+REG32(CM_VECDIV, 0x0fc)
+REG32(CM_PULSECTL, 0x190)
+REG32(CM_PULSEDIV, 0x194)
+REG32(CM_SDCCTL, 0x1a8)
+REG32(CM_SDCDIV, 0x1ac)
+REG32(CM_ARMCTL, 0x1b0)
+REG32(CM_AVEOCTL, 0x1b8)
+REG32(CM_AVEODIV, 0x1bc)
+REG32(CM_EMMCCTL, 0x1c0)
+REG32(CM_EMMCDIV, 0x1c4)
+REG32(CM_EMMC2CTL, 0x1d0)
+REG32(CM_EMMC2DIV, 0x1d4)
+
 /* misc registers */
 REG32(CM_LOCK, 0x114)
     FIELD(CM_LOCK, FLOCKH, 12, 1)
     FIELD(CM_LOCK, FLOCKD, 11, 1)
     FIELD(CM_LOCK, FLOCKC, 10, 1)
@@ -317,6 +404,340 @@ static inline void set_pll_channel_init_info(BCM2835CprmanState *s,
     channel->load_mask = PLL_CHANNEL_INIT_INFO[id].cm_load_mask;
     channel->reg_a2w_ctrl = &s->regs[PLL_CHANNEL_INIT_INFO[id].a2w_ctrl_offset];
     channel->fixed_divider = PLL_CHANNEL_INIT_INFO[id].fixed_divider;
 }
 
+/* Clock mux init info */
+typedef struct ClockMuxInitInfo {
+    const char *name;
+    size_t cm_offset;
+    int int_bits;
+    int frac_bits;
+
+    CprmanPLLChannel src_mapping[CPRMAN_NUM_CLOCK_MUX_SRC];
+} ClockMuxInitInfo;
+
+/*
+ * Each clock mux can have up to 10 sources. Sources 0 to 3 are always the
+ * same (ground, xosc, td0, td1). Sources 4 to 9 are mux specific, and are not
+ * always populated. The following macros catch all those cases.
+ */
+
+/* Unknown mapping. Connect everything to ground */
+#define SRC_MAPPING_INFO_unknown                          \
+    .src_mapping = {                                      \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* gnd */          \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* xosc */         \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* test debug 0 */ \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* test debug 1 */ \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* pll a */        \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* pll c */        \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* pll d */        \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* pll h */        \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* pll c, core1 */ \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, /* pll c, core2 */ \
+    }
+
+/* Only the oscillator and the two test debug clocks */
+#define SRC_MAPPING_INFO_xosc          \
+    .src_mapping = {                   \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+    }
+
+/* All the PLL "core" channels */
+#define SRC_MAPPING_INFO_core      \
+    .src_mapping = {               \
+        CPRMAN_CLOCK_SRC_NORMAL,   \
+        CPRMAN_CLOCK_SRC_NORMAL,   \
+        CPRMAN_CLOCK_SRC_NORMAL,   \
+        CPRMAN_CLOCK_SRC_NORMAL,   \
+        CPRMAN_PLLA_CHANNEL_CORE,  \
+        CPRMAN_PLLC_CHANNEL_CORE0, \
+        CPRMAN_PLLD_CHANNEL_CORE,  \
+        CPRMAN_PLLH_CHANNEL_AUX,   \
+        CPRMAN_PLLC_CHANNEL_CORE1, \
+        CPRMAN_PLLC_CHANNEL_CORE2, \
+    }
+
+/* All the PLL "per" channels */
+#define SRC_MAPPING_INFO_periph        \
+    .src_mapping = {                   \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_PLLA_CHANNEL_PER,       \
+        CPRMAN_PLLC_CHANNEL_PER,       \
+        CPRMAN_PLLD_CHANNEL_PER,       \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+    }
+
+/*
+ * The DSI0 channels. This one got an intermediate mux between the PLL channels
+ * and the clock input.
+ */
+#define SRC_MAPPING_INFO_dsi0          \
+    .src_mapping = {                   \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_DSI0HSCK,     \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+    }
+
+/* The DSI1 channel */
+#define SRC_MAPPING_INFO_dsi1          \
+    .src_mapping = {                   \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_CLOCK_SRC_NORMAL,       \
+        CPRMAN_PLLD_CHANNEL_DSI1,      \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+        CPRMAN_CLOCK_SRC_FORCE_GROUND, \
+    }
+
+#define FILL_CLOCK_MUX_SRC_MAPPING_INIT_INFO(kind_) \
+    SRC_MAPPING_INFO_ ## kind_
+
+#define FILL_CLOCK_MUX_INIT_INFO(clock_, kind_) \
+    .cm_offset = R_CM_ ## clock_ ## CTL,        \
+    FILL_CLOCK_MUX_SRC_MAPPING_INIT_INFO(kind_)
+
+static ClockMuxInitInfo CLOCK_MUX_INIT_INFO[] = {
+    [CPRMAN_CLOCK_GNRIC] = {
+        .name = "gnric",
+        FILL_CLOCK_MUX_INIT_INFO(GNRIC, unknown),
+    },
+    [CPRMAN_CLOCK_VPU] = {
+        .name = "vpu",
+        .int_bits = 12,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(VPU, core),
+    },
+    [CPRMAN_CLOCK_SYS] = {
+        .name = "sys",
+        FILL_CLOCK_MUX_INIT_INFO(SYS, unknown),
+    },
+    [CPRMAN_CLOCK_PERIA] = {
+        .name = "peria",
+        FILL_CLOCK_MUX_INIT_INFO(PERIA, unknown),
+    },
+    [CPRMAN_CLOCK_PERII] = {
+        .name = "perii",
+        FILL_CLOCK_MUX_INIT_INFO(PERII, unknown),
+    },
+    [CPRMAN_CLOCK_H264] = {
+        .name = "h264",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(H264, core),
+    },
+    [CPRMAN_CLOCK_ISP] = {
+        .name = "isp",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(ISP, core),
+    },
+    [CPRMAN_CLOCK_V3D] = {
+        .name = "v3d",
+        FILL_CLOCK_MUX_INIT_INFO(V3D, core),
+    },
+    [CPRMAN_CLOCK_CAM0] = {
+        .name = "cam0",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(CAM0, periph),
+    },
+    [CPRMAN_CLOCK_CAM1] = {
+        .name = "cam1",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(CAM1, periph),
+    },
+    [CPRMAN_CLOCK_CCP2] = {
+        .name = "ccp2",
+        FILL_CLOCK_MUX_INIT_INFO(CCP2, unknown),
+    },
+    [CPRMAN_CLOCK_DSI0E] = {
+        .name = "dsi0e",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(DSI0E, dsi0),
+    },
+    [CPRMAN_CLOCK_DSI0P] = {
+        .name = "dsi0p",
+        .int_bits = 0,
+        .frac_bits = 0,
+        FILL_CLOCK_MUX_INIT_INFO(DSI0P, dsi0),
+    },
+    [CPRMAN_CLOCK_DPI] = {
+        .name = "dpi",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(DPI, periph),
+    },
+    [CPRMAN_CLOCK_GP0] = {
+        .name = "gp0",
+        .int_bits = 12,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(GP0, periph),
+    },
+    [CPRMAN_CLOCK_GP1] = {
+        .name = "gp1",
+        .int_bits = 12,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(GP1, periph),
+    },
+    [CPRMAN_CLOCK_GP2] = {
+        .name = "gp2",
+        .int_bits = 12,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(GP2, periph),
+    },
+    [CPRMAN_CLOCK_HSM] = {
+        .name = "hsm",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(HSM, periph),
+    },
+    [CPRMAN_CLOCK_OTP] = {
+        .name = "otp",
+        .int_bits = 4,
+        .frac_bits = 0,
+        FILL_CLOCK_MUX_INIT_INFO(OTP, xosc),
+    },
+    [CPRMAN_CLOCK_PCM] = {
+        .name = "pcm",
+        .int_bits = 12,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(PCM, periph),
+    },
+    [CPRMAN_CLOCK_PWM] = {
+        .name = "pwm",
+        .int_bits = 12,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(PWM, periph),
+    },
+    [CPRMAN_CLOCK_SLIM] = {
+        .name = "slim",
+        .int_bits = 12,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(SLIM, periph),
+    },
+    [CPRMAN_CLOCK_SMI] = {
+        .name = "smi",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(SMI, periph),
+    },
+    [CPRMAN_CLOCK_TEC] = {
+        .name = "tec",
+        .int_bits = 6,
+        .frac_bits = 0,
+        FILL_CLOCK_MUX_INIT_INFO(TEC, xosc),
+    },
+    [CPRMAN_CLOCK_TD0] = {
+        .name = "td0",
+        FILL_CLOCK_MUX_INIT_INFO(TD0, unknown),
+    },
+    [CPRMAN_CLOCK_TD1] = {
+        .name = "td1",
+        FILL_CLOCK_MUX_INIT_INFO(TD1, unknown),
+    },
+    [CPRMAN_CLOCK_TSENS] = {
+        .name = "tsens",
+        .int_bits = 5,
+        .frac_bits = 0,
+        FILL_CLOCK_MUX_INIT_INFO(TSENS, xosc),
+    },
+    [CPRMAN_CLOCK_TIMER] = {
+        .name = "timer",
+        .int_bits = 6,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(TIMER, xosc),
+    },
+    [CPRMAN_CLOCK_UART] = {
+        .name = "uart",
+        .int_bits = 10,
+        .frac_bits = 12,
+        FILL_CLOCK_MUX_INIT_INFO(UART, periph),
+    },
+    [CPRMAN_CLOCK_VEC] = {
+        .name = "vec",
+        .int_bits = 4,
+        .frac_bits = 0,
+        FILL_CLOCK_MUX_INIT_INFO(VEC, periph),
+    },
+    [CPRMAN_CLOCK_PULSE] = {
+        .name = "pulse",
+        FILL_CLOCK_MUX_INIT_INFO(PULSE, xosc),
+    },
+    [CPRMAN_CLOCK_SDC] = {
+        .name = "sdram",
+        .int_bits = 6,
+        .frac_bits = 0,
+        FILL_CLOCK_MUX_INIT_INFO(SDC, core),
+    },
+    [CPRMAN_CLOCK_ARM] = {
+        .name = "arm",
+        FILL_CLOCK_MUX_INIT_INFO(ARM, unknown),
+    },
+    [CPRMAN_CLOCK_AVEO] = {
+        .name = "aveo",
+        .int_bits = 4,
+        .frac_bits = 0,
+        FILL_CLOCK_MUX_INIT_INFO(AVEO, periph),
+    },
+    [CPRMAN_CLOCK_EMMC] = {
+        .name = "emmc",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(EMMC, periph),
+    },
+    [CPRMAN_CLOCK_EMMC2] = {
+        .name = "emmc2",
+        .int_bits = 4,
+        .frac_bits = 8,
+        FILL_CLOCK_MUX_INIT_INFO(EMMC2, unknown),
+    },
+};
+
+#undef FILL_CLOCK_MUX_INIT_INFO
+#undef FILL_CLOCK_MUX_SRC_MAPPING_INIT_INFO
+#undef SRC_MAPPING_INFO_dsi1
+#undef SRC_MAPPING_INFO_dsi0
+#undef SRC_MAPPING_INFO_periph
+#undef SRC_MAPPING_INFO_core
+#undef SRC_MAPPING_INFO_xosc
+#undef SRC_MAPPING_INFO_unknown
+
+static inline void set_clock_mux_init_info(BCM2835CprmanState *s,
+                                           CprmanClockMuxState *mux,
+                                           CprmanClockMux id)
+{
+    mux->id = id;
+    mux->reg_cm = &s->regs[CLOCK_MUX_INIT_INFO[id].cm_offset];
+    mux->int_bits = CLOCK_MUX_INIT_INFO[id].int_bits;
+    mux->frac_bits = CLOCK_MUX_INIT_INFO[id].frac_bits;
+}
+
 #endif
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index e644aeb2b5..8df2db0fd9 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -36,10 +36,13 @@
  *          |                                          [mux]
  *          \-->[PLL]--->[PLL channel]                 [mux]
  *
  * The page at https://elinux.org/The_Undocumented_Pi gives the actual clock
  * tree configuration.
+ *
+ * The CPRMAN exposes clock outputs with the name of the clock mux suffixed
+ * with "-out" (e.g. "uart-out", "h264-out", ...).
  */
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
@@ -224,10 +227,69 @@ static const TypeInfo cprman_pll_channel_info = {
     .class_init = pll_channel_class_init,
     .instance_init = pll_channel_init,
 };
 
 
+/* clock mux */
+
+static void clock_mux_update(CprmanClockMuxState *mux)
+{
+    clock_update(mux->out, 0);
+}
+
+static void clock_mux_src_update(void *opaque)
+{
+    CprmanClockMuxState **backref = opaque;
+    CprmanClockMuxState *s = *backref;
+
+    clock_mux_update(s);
+}
+
+static void clock_mux_init(Object *obj)
+{
+    CprmanClockMuxState *s = CPRMAN_CLOCK_MUX(obj);
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX_SRC; i++) {
+        char *name = g_strdup_printf("srcs[%zu]", i);
+        s->backref[i] = s;
+        s->srcs[i] = qdev_init_clock_in(DEVICE(s), name,
+                                        clock_mux_src_update,
+                                        &s->backref[i]);
+        g_free(name);
+    }
+
+    s->out = qdev_init_clock_out(DEVICE(s), "out");
+}
+
+static const VMStateDescription clock_mux_vmstate = {
+    .name = TYPE_CPRMAN_CLOCK_MUX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_ARRAY_CLOCK(srcs, CprmanClockMuxState,
+                            CPRMAN_NUM_CLOCK_MUX_SRC),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void clock_mux_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &clock_mux_vmstate;
+}
+
+static const TypeInfo cprman_clock_mux_info = {
+    .name = TYPE_CPRMAN_CLOCK_MUX,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CprmanClockMuxState),
+    .class_init = clock_mux_class_init,
+    .instance_init = clock_mux_init,
+};
+
+
 /* CPRMAN "top level" model */
 
 static uint32_t get_cm_lock(const BCM2835CprmanState *s)
 {
     static const int CM_LOCK_MAPPING[] = {
@@ -291,10 +353,23 @@ static inline void update_channel_from_a2w(BCM2835CprmanState *s, size_t idx)
             return;
         }
     }
 }
 
+static inline void update_mux_from_cm(BCM2835CprmanState *s, size_t idx)
+{
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
+        if ((CLOCK_MUX_INIT_INFO[i].cm_offset == idx)
+           || (CLOCK_MUX_INIT_INFO[i].cm_offset == idx + 4)) {
+            clock_mux_update(&s->clock_muxes[i]);
+            return;
+        }
+    }
+}
+
 #define CASE_PLL_A2W_REGS(pll_) \
     case R_A2W_ ## pll_ ## _CTRL: \
     case R_A2W_ ## pll_ ## _ANA0: \
     case R_A2W_ ## pll_ ## _ANA1: \
     case R_A2W_ ## pll_ ## _ANA2: \
@@ -363,10 +438,19 @@ static void cprman_write(void *opaque, hwaddr offset,
     case R_A2W_PLLH_RCAL:
     case R_A2W_PLLH_PIX:
     case R_A2W_PLLB_ARM:
         update_channel_from_a2w(s, idx);
         break;
+
+    case R_CM_GNRICCTL ... R_CM_SMIDIV:
+    case R_CM_TCNTCNT ... R_CM_VECDIV:
+    case R_CM_PULSECTL ... R_CM_PULSEDIV:
+    case R_CM_SDCCTL ... R_CM_ARMCTL:
+    case R_CM_AVEOCTL ... R_CM_EMMCDIV:
+    case R_CM_EMMC2CTL ... R_CM_EMMC2DIV:
+        update_mux_from_cm(s, idx);
+        break;
     }
 }
 
 #undef CASE_PLL_A2W_REGS
 
@@ -394,10 +478,14 @@ static void cprman_reset(DeviceState *dev)
 
     for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
         device_cold_reset(DEVICE(&s->channels[i]));
     }
 
+    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
+        device_cold_reset(DEVICE(&s->clock_muxes[i]));
+    }
+
     clock_update_hz(s->xosc, s->xosc_freq);
 }
 
 static Clock *init_internal_clock(BCM2835CprmanState *s,
                                   const char *name)
@@ -431,17 +519,69 @@ static void cprman_init(Object *obj)
                                 &s->channels[i],
                                 TYPE_CPRMAN_PLL_CHANNEL);
         set_pll_channel_init_info(s, &s->channels[i], i);
     }
 
+    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
+        char *alias;
+
+        object_initialize_child(obj, CLOCK_MUX_INIT_INFO[i].name,
+                                &s->clock_muxes[i],
+                                TYPE_CPRMAN_CLOCK_MUX);
+        set_clock_mux_init_info(s, &s->clock_muxes[i], i);
+
+        /* Expose muxes output as CPRMAN outputs */
+        alias = g_strdup_printf("%s-out", CLOCK_MUX_INIT_INFO[i].name);
+        qdev_alias_clock(DEVICE(&s->clock_muxes[i]), "out", DEVICE(obj), alias);
+        g_free(alias);
+
+    }
+
     s->xosc = init_internal_clock(s, "xosc");
+    s->gnd = init_internal_clock(s, "gnd");
+
+    clock_set(s->gnd, 0);
 
     memory_region_init_io(&s->iomem, obj, &cprman_ops,
                           s, "bcm2835-cprman", 0x2000);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
+static void connect_mux_sources(BCM2835CprmanState *s,
+                                CprmanClockMuxState *mux,
+                                const CprmanPLLChannel *clk_mapping)
+{
+    size_t i;
+    Clock *td0 = s->clock_muxes[CPRMAN_CLOCK_TD0].out;
+    Clock *td1 = s->clock_muxes[CPRMAN_CLOCK_TD1].out;
+
+    /* For sources from 0 to 3. Source 4 to 9 are mux specific */
+    Clock * const CLK_SRC_MAPPING[] = {
+        [CPRMAN_CLOCK_SRC_GND] = s->gnd,
+        [CPRMAN_CLOCK_SRC_XOSC] = s->xosc,
+        [CPRMAN_CLOCK_SRC_TD0] = td0,
+        [CPRMAN_CLOCK_SRC_TD1] = td1,
+    };
+
+    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX_SRC; i++) {
+        CprmanPLLChannel mapping = clk_mapping[i];
+        Clock *src;
+
+        if (mapping == CPRMAN_CLOCK_SRC_FORCE_GROUND) {
+            src = s->gnd;
+        } else if (mapping == CPRMAN_CLOCK_SRC_DSI0HSCK) {
+            src = s->gnd; /* TODO */
+        } else if (i < CPRMAN_CLOCK_SRC_PLLA) {
+            src = CLK_SRC_MAPPING[i];
+        } else {
+            src = s->channels[mapping].out;
+        }
+
+        clock_set_source(mux->srcs[i], src);
+    }
+}
+
 static void cprman_realize(DeviceState *dev, Error **errp)
 {
     BCM2835CprmanState *s = CPRMAN(dev);
     size_t i;
 
@@ -464,10 +604,20 @@ static void cprman_realize(DeviceState *dev, Error **errp)
 
         if (!qdev_realize(DEVICE(channel), NULL, errp)) {
             return;
         }
     }
+
+    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
+        CprmanClockMuxState *clock_mux = &s->clock_muxes[i];
+
+        connect_mux_sources(s, clock_mux, CLOCK_MUX_INIT_INFO[i].src_mapping);
+
+        if (!qdev_realize(DEVICE(clock_mux), NULL, errp)) {
+            return;
+        }
+    }
 }
 
 static const VMStateDescription cprman_vmstate = {
     .name = TYPE_BCM2835_CPRMAN,
     .version_id = 1,
@@ -504,8 +654,9 @@ static const TypeInfo cprman_info = {
 static void cprman_register_types(void)
 {
     type_register_static(&cprman_info);
     type_register_static(&cprman_pll_info);
     type_register_static(&cprman_pll_channel_info);
+    type_register_static(&cprman_clock_mux_info);
 }
 
 type_init(cprman_register_types);
-- 
2.28.0


