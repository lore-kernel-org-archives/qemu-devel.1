Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7543221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="DHi72S62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7543221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkzS-0007iE-PN
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknj-0001XP-Ia; Fri, 25 Sep 2020 06:18:04 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknd-0007SN-9R; Fri, 25 Sep 2020 06:18:02 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id D7558C60F24;
 Fri, 25 Sep 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYmTD4UkWAFnlkcU34EMX40lMfSmz6vUyQ7STKLwesk=;
 b=DHi72S62IkVE1v4kGD8A1tHQY8kC7rYG6BbaYGUK6rtKRvXH4iBap0uNnKVJsl1uyGzsqj
 Ji8eZXalGWg+gjsxDlRSlI3BWz9qZdVw6+1X/C3nxSKa7UwF/bbOpN88fZg8ZiLisJljku
 hpmwb68xQn6jFSSWbuiDPb0GR88AH00DHAXBgwi8OQo2DNgfD8FsKmhIil0FHRkxkogKm1
 vLF0wcr5FzIFOp2dc8ehRXTWbfkbtcokSbwkDDDhXWLEoqGY9hSQK2TRoBSDRH6OGTV9Ue
 nqVdPVeLjWxZPm8ae9aU1r0Qv642srci7tzhZeZbUEuijqdhm7KHzGgOgOYVzg==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/14] hw/misc/bcm2835_cprman: add sane reset values to the
 registers
Date: Fri, 25 Sep 2020 12:17:29 +0200
Message-Id: <20200925101731.2159827-13-luc@lmichel.fr>
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
 bh=XYmTD4UkWAFnlkcU34EMX40lMfSmz6vUyQ7STKLwesk=;
 b=ZFNBK2dF7KwM8aqyZZL3phW8mwtRk6JuKM7rzuab5DBEqYC/Fdy3U4BOuYIgjyB9obFCzi
 /zRv3q6VyPdDPjJJDk2HiOEiGOGLn1ecF6LgzvTiQ9vAfgKXyWFCc3GpD8YMcipef41LEs
 PQnasQwRSa4VlCLzB5f2ENr83TJc/BlqBYf9cDRp1qOLtw04a7AU3/zHPTIknf1xHRYvF7
 Xjh5XXKxFcxwkXDV/kl25XUiiHyc6X2LYAZJoxholPkpOh6CsSu/hs8kV1wHizfEWQgIiZ
 zrtuhlXtpW6ieBkQLoD+q9tVven7hWBDMGa4TGnS/mIb79f+ZOWVmlhL82nGhw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=jOzjd6FCZeN40HNRxAGmjxQHWaC87Pn6Sumkyke9Pfv+oVNLn/DnvYtqUZcReq27qiKR6+bdWgE4DFiZBzop4KsSTzo3C/Cb0DhiCq+1FBAWYomNMKftNs00k4XJPuUgjLydsN8ExhiPhuA9ePkMvT7Q8yocikot/pT/hkrlLAjwQHVMDy6YNKV4XjV+AYJ9YkVVcxuXSg5rCZPcHL+JVgr2fR3fOiA8w/Q4SrmS8BNPvijrCXq8t/YPff5WUHSV1zCcvkpEA40+7NkNL4IekEmVLNsC44kSUMNXT6wZXP38vPsbSo8+vgLjdB95B++qn1Uwuovztbuh+ifwOyAGvA==
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

Those reset values have been extracted from a Raspberry Pi 3 model B
v1.2, using the 2020-08-20 version of raspios. The dump was done using
the debugfs interface of the cprman driver in Linux (under
'/sys/kernel/debug/clk'). Each exposed clock tree stage (PLLs, channels
and muxes) can be observed by reading the 'regdump' file (e.g.
'plla/regdump').

Those values are set by the Raspberry Pi firmware at boot time (Linux
expects them to be set when it boots up).

Some stages are not exposed by the Linux driver (e.g. the PLL B). For
those, the reset values are unknown and left to 0 which implies a
disabled output.

Once booted in QEMU, the final clock tree is very similar to the one
visible on real hardware. The differences come from some unimplemented
devices for which the driver simply disable the corresponding clock.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/misc/bcm2835_cprman_internals.h | 269 +++++++++++++++++++++
 hw/misc/bcm2835_cprman.c                   |  31 +++
 2 files changed, 300 insertions(+)

diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index ad07cf5276..f5e168ccf9 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -744,6 +744,275 @@ static inline void set_clock_mux_init_info(BCM2835CprmanState *s,
     mux->reg_cm = &s->regs[CLOCK_MUX_INIT_INFO[id].cm_offset];
     mux->int_bits = CLOCK_MUX_INIT_INFO[id].int_bits;
     mux->frac_bits = CLOCK_MUX_INIT_INFO[id].frac_bits;
 }
 
+
+/*
+ * Object reset info
+ * Those values have been dumped from a Raspberry Pi 3 Model B v1.2 using the
+ * clk debugfs interface in Linux.
+ */
+typedef struct PLLResetInfo {
+    uint32_t cm;
+    uint32_t a2w_ctrl;
+    uint32_t a2w_ana[4];
+    uint32_t a2w_frac;
+} PLLResetInfo;
+
+static const PLLResetInfo PLL_RESET_INFO[] = {
+    [CPRMAN_PLLA] = {
+        .cm = 0x0000008a,
+        .a2w_ctrl = 0x0002103a,
+        .a2w_frac = 0x00098000,
+        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
+    },
+
+    [CPRMAN_PLLC] = {
+        .cm = 0x00000228,
+        .a2w_ctrl = 0x0002103e,
+        .a2w_frac = 0x00080000,
+        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
+    },
+
+    [CPRMAN_PLLD] = {
+        .cm = 0x0000020a,
+        .a2w_ctrl = 0x00021034,
+        .a2w_frac = 0x00015556,
+        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
+    },
+
+    [CPRMAN_PLLH] = {
+        .cm = 0x00000000,
+        .a2w_ctrl = 0x0002102d,
+        .a2w_frac = 0x00000000,
+        .a2w_ana = { 0x00900000, 0x0000000c, 0x00000000, 0x00000000 }
+    },
+
+    [CPRMAN_PLLB] = {
+        /* unknown */
+        .cm = 0x00000000,
+        .a2w_ctrl = 0x00000000,
+        .a2w_frac = 0x00000000,
+        .a2w_ana = { 0x00000000, 0x00000000, 0x00000000, 0x00000000 }
+    }
+};
+
+typedef struct PLLChannelResetInfo {
+    /*
+     * Even though a PLL channel has a CM register, it shares it with its
+     * parent PLL. The parent already takes care of the reset value.
+     */
+    uint32_t a2w_ctrl;
+} PLLChannelResetInfo;
+
+static const PLLChannelResetInfo PLL_CHANNEL_RESET_INFO[] = {
+    [CPRMAN_PLLA_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLA_CHANNEL_CORE] = { .a2w_ctrl = 0x00000003 },
+    [CPRMAN_PLLA_CHANNEL_PER] = { .a2w_ctrl = 0x00000000 }, /* unknown */
+    [CPRMAN_PLLA_CHANNEL_CCP2] = { .a2w_ctrl = 0x00000100 },
+
+    [CPRMAN_PLLC_CHANNEL_CORE2] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLC_CHANNEL_CORE1] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLC_CHANNEL_PER] = { .a2w_ctrl = 0x00000002 },
+    [CPRMAN_PLLC_CHANNEL_CORE0] = { .a2w_ctrl = 0x00000002 },
+
+    [CPRMAN_PLLD_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLD_CHANNEL_CORE] = { .a2w_ctrl = 0x00000004 },
+    [CPRMAN_PLLD_CHANNEL_PER] = { .a2w_ctrl = 0x00000004 },
+    [CPRMAN_PLLD_CHANNEL_DSI1] = { .a2w_ctrl = 0x00000100 },
+
+    [CPRMAN_PLLH_CHANNEL_AUX] = { .a2w_ctrl = 0x00000004 },
+    [CPRMAN_PLLH_CHANNEL_RCAL] = { .a2w_ctrl = 0x00000000 },
+    [CPRMAN_PLLH_CHANNEL_PIX] = { .a2w_ctrl = 0x00000000 },
+
+    [CPRMAN_PLLB_CHANNEL_ARM] = { .a2w_ctrl = 0x00000000 }, /* unknown */
+};
+
+typedef struct ClockMuxResetInfo {
+    uint32_t cm_ctrl;
+    uint32_t cm_div;
+} ClockMuxResetInfo;
+
+static const ClockMuxResetInfo CLOCK_MUX_RESET_INFO[] = {
+    [CPRMAN_CLOCK_GNRIC] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_VPU] = {
+        .cm_ctrl = 0x00000245,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_SYS] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_PERIA] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_PERII] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_H264] = {
+        .cm_ctrl = 0x00000244,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_ISP] = {
+        .cm_ctrl = 0x00000244,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_V3D] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_CAM0] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_CAM1] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_CCP2] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_DSI0E] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_DSI0P] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_DPI] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_GP0] = {
+        .cm_ctrl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_GP1] = {
+        .cm_ctrl = 0x00000096,
+        .cm_div = 0x00014000,
+    },
+
+    [CPRMAN_CLOCK_GP2] = {
+        .cm_ctrl = 0x00000291,
+        .cm_div = 0x00249f00,
+    },
+
+    [CPRMAN_CLOCK_HSM] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_OTP] = {
+        .cm_ctrl = 0x00000091,
+        .cm_div = 0x00004000,
+    },
+
+    [CPRMAN_CLOCK_PCM] = {
+        .cm_ctrl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_PWM] = {
+        .cm_ctrl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_SLIM] = {
+        .cm_ctrl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_SMI] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_TEC] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_TD0] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_TD1] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_TSENS] = {
+        .cm_ctrl = 0x00000091,
+        .cm_div = 0x0000a000,
+    },
+
+    [CPRMAN_CLOCK_TIMER] = {
+        .cm_ctrl = 0x00000291,
+        .cm_div = 0x00013333,
+    },
+
+    [CPRMAN_CLOCK_UART] = {
+        .cm_ctrl = 0x00000296,
+        .cm_div = 0x0000a6ab,
+    },
+
+    [CPRMAN_CLOCK_VEC] = {
+        .cm_ctrl = 0x00000097,
+        .cm_div = 0x00002000,
+    },
+
+    [CPRMAN_CLOCK_PULSE] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_SDC] = {
+        .cm_ctrl = 0x00004006,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_ARM] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_AVEO] = {
+        .cm_ctrl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_EMMC] = {
+        .cm_ctrl = 0x00000295,
+        .cm_div = 0x00006000,
+    },
+
+    [CPRMAN_CLOCK_EMMC2] = {
+        .cm_ctrl = 0, /* unknown */
+        .cm_div = 0
+    },
+};
+
 #endif
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index e576ab2642..a8b54cccdb 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -51,10 +51,21 @@
 #include "hw/misc/bcm2835_cprman_internals.h"
 #include "trace.h"
 
 /* PLL */
 
+static void pll_reset(DeviceState *dev)
+{
+    CprmanPLLState *s = CPRMAN_PLL(dev);
+    const PLLResetInfo *info = &PLL_RESET_INFO[s->id];
+
+    *s->reg_cm = info->cm;
+    *s->reg_a2w_ctrl = info->a2w_ctrl;
+    memcpy(s->reg_a2w_ana, info->a2w_ana, sizeof(info->a2w_ana));
+    *s->reg_a2w_frac = info->a2w_frac;
+}
+
 static bool pll_is_locked(const CprmanPLLState *pll)
 {
     return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
         && !FIELD_EX32(*pll->reg_cm, CM_PLLx, ANARST);
 }
@@ -121,10 +132,11 @@ static const VMStateDescription pll_vmstate = {
 
 static void pll_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = pll_reset;
     dc->vmsd = &pll_vmstate;
 }
 
 static const TypeInfo cprman_pll_info = {
     .name = TYPE_CPRMAN_PLL,
@@ -135,10 +147,18 @@ static const TypeInfo cprman_pll_info = {
 };
 
 
 /* PLL channel */
 
+static void pll_channel_reset(DeviceState *dev)
+{
+    CprmanPLLChannelState *s = CPRMAN_PLL_CHANNEL(dev);
+    const PLLChannelResetInfo *info = &PLL_CHANNEL_RESET_INFO[s->id];
+
+    *s->reg_a2w_ctrl = info->a2w_ctrl;
+}
+
 static bool pll_channel_is_enabled(CprmanPLLChannelState *channel)
 {
     /*
      * XXX I'm not sure of the purpose of the LOAD field. The Linux driver does
      * not set it when enabling the channel, but does clear it when disabling
@@ -215,10 +235,11 @@ static const VMStateDescription pll_channel_vmstate = {
 
 static void pll_channel_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = pll_channel_reset;
     dc->vmsd = &pll_channel_vmstate;
 }
 
 static const TypeInfo cprman_pll_channel_info = {
     .name = TYPE_CPRMAN_PLL_CHANNEL,
@@ -283,10 +304,19 @@ static void clock_mux_src_update(void *opaque)
     }
 
     clock_mux_update(s);
 }
 
+static void clock_mux_reset(DeviceState *dev)
+{
+    CprmanClockMuxState *clock = CPRMAN_CLOCK_MUX(dev);
+    const ClockMuxResetInfo *info = &CLOCK_MUX_RESET_INFO[clock->id];
+
+    clock->reg_cm[0] = info->cm_ctrl;
+    clock->reg_cm[1] = info->cm_div;
+}
+
 static void clock_mux_init(Object *obj)
 {
     CprmanClockMuxState *s = CPRMAN_CLOCK_MUX(obj);
     size_t i;
 
@@ -315,10 +345,11 @@ static const VMStateDescription clock_mux_vmstate = {
 
 static void clock_mux_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = clock_mux_reset;
     dc->vmsd = &clock_mux_vmstate;
 }
 
 static const TypeInfo cprman_clock_mux_info = {
     .name = TYPE_CPRMAN_CLOCK_MUX,
-- 
2.28.0


