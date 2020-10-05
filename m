Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15252100A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="A63q+Fbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15252100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPX9I-0001Ja-S4
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZx-0004BL-SG; Mon, 05 Oct 2020 15:55:25 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZu-0007Wp-EX; Mon, 05 Oct 2020 15:55:25 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 8C7FAC60F1F;
 Mon,  5 Oct 2020 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927715;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Tw5rebm56xIRl4Y6xn4/weNTQ41I+JOywwnSzbgJS4=;
 b=A63q+FbjgyieSDp3DP2cQmcssArUT1Y6etovDwKzGQ5bqAh2uEiM9ro68NfAhpjoGg7aop
 gUyXsBGZCkLIyHp9Kh8JRjyCZIBylyCl3viNpNiNTvb5Ahba7DIPqfd25bw4ANULQZkSp1
 DteNSHLOBG4LV2j2Mgp7MPI19z2ursSMayHo8P76S+2yFKvwhcaXtMV7bPPnckXNh4jGGo
 pHteeK62gYv+akVFfMHWkJMtBkw5n8T3riCWYWnJQluCVmgG/6pRMSdbje95abuF1Q2VCp
 BNq9XNS5H/7nmVUZfpaJF5zotErhe5z5pPUcB8lvGu4lxWYZk6fzP71do++/uw==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/15] hw/misc/bcm2835_cprman: implement PLLs behaviour
Date: Mon,  5 Oct 2020 21:56:04 +0200
Message-Id: <20201005195612.1999165-8-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005195612.1999165-1-luc@lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601927715;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Tw5rebm56xIRl4Y6xn4/weNTQ41I+JOywwnSzbgJS4=;
 b=MQ9FaDIt8OGNycObUAoJzOhXYNPyO69hj7Dqn61V0WGiDnUQ+FHKtlmNxjfyYuyD5badAc
 I5K83MkG5K85c/DyB77S5nuxVBjVqoK7vveGPeDZwrF163s9dQNAAkbqJ1THNsbJGQbNIc
 Q/RweSTswfzyxp4eLcWBQljdf3uB9usiODgTuSMo8lvQoC9MGwCqdo7aTOqH7W7SURFssK
 hytMpRZtxV8nZn86nbgwR3PWG1Y/vLuhs0a3lnn7TsIdUUbv+W/wUx8w3qbz7I+J/DH5b5
 WxGPX6NE1Jpq5Xh8I2kdKRyf73Cwddltadoj+d14T9d2KjGpcFRZx1JL60gJLw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927715; a=rsa-sha256; cv=none;
 b=QGERrztZVBxC3zADrjJYx4BdwgSPpImbmOCwbzP+jGHfnC0n292SKk4zBqSuN0v7aJ2MURnDUWkn60W4cL/Zy6uDbvnbt2PWHYUSAoD5jrCzeNbmwTR4+N4Qtp9v0l2YUCnxxHsADK3wosXPxhAjIFVg3QyK5KrwRwuRbRBBnuFPk7wFZb4EyouBCzSKeHEQJkDxZpgyVODK6xoB/4JSwhlAsOWQd897Si823mppM5FwrO1K40E0wpAO12zCr8d9SNWS/zVIvIfSXFS5pL122ut8vz0KO7q4CxF9cFvfAGpxq6+5kwPOgzy8dUz5eW7kKXIN+AKEld36mB44QO3AOw==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:49:50
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPRMAN PLLs generate a clock based on a prescaler, a multiplier and
a divider. The prescaler doubles the parent (xosc) frequency, then the
multiplier/divider are applied. The multiplier has an integer and a
fractional part.

This commit also implements the CPRMAN CM_LOCK register. This register
reports which PLL is currently locked. We consider a PLL has being
locked as soon as it is enabled (on real hardware, there is a delay
after turning a PLL on, for it to stabilize).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/misc/bcm2835_cprman_internals.h |  8 +++
 hw/misc/bcm2835_cprman.c                   | 64 +++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 340ad623bb..7aa46c6e18 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -98,10 +98,18 @@ REG32(A2W_PLLA_FRAC, 0x1200)
 REG32(A2W_PLLC_FRAC, 0x1220)
 REG32(A2W_PLLD_FRAC, 0x1240)
 REG32(A2W_PLLH_FRAC, 0x1260)
 REG32(A2W_PLLB_FRAC, 0x12e0)
 
+/* misc registers */
+REG32(CM_LOCK, 0x114)
+    FIELD(CM_LOCK, FLOCKH, 12, 1)
+    FIELD(CM_LOCK, FLOCKD, 11, 1)
+    FIELD(CM_LOCK, FLOCKC, 10, 1)
+    FIELD(CM_LOCK, FLOCKB, 9, 1)
+    FIELD(CM_LOCK, FLOCKA, 8, 1)
+
 /*
  * This field is common to all registers. Each register write value must match
  * the CPRMAN_PASSWORD magic value in its 8 MSB.
  */
 FIELD(CPRMAN, PASSWORD, 24, 8)
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index b86f5901b8..144bcc289d 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -48,13 +48,51 @@
 #include "hw/misc/bcm2835_cprman_internals.h"
 #include "trace.h"
 
 /* PLL */
 
+static bool pll_is_locked(const CprmanPllState *pll)
+{
+    return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
+        && !FIELD_EX32(*pll->reg_cm, CM_PLLx, ANARST);
+}
+
 static void pll_update(CprmanPllState *pll)
 {
-    clock_update(pll->out, 0);
+    uint64_t freq, ndiv, fdiv, pdiv;
+
+    if (!pll_is_locked(pll)) {
+        clock_update(pll->out, 0);
+        return;
+    }
+
+    pdiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PDIV);
+
+    if (!pdiv) {
+        clock_update(pll->out, 0);
+        return;
+    }
+
+    ndiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, NDIV);
+    fdiv = FIELD_EX32(*pll->reg_a2w_frac, A2W_PLLx_FRAC, FRAC);
+
+    if (pll->reg_a2w_ana[1] & pll->prediv_mask) {
+        /* The prescaler doubles the parent frequency */
+        ndiv *= 2;
+        fdiv *= 2;
+    }
+
+    /*
+     * We have a multiplier with an integer part (ndiv) and a fractional part
+     * (fdiv), and a divider (pdiv).
+     */
+    freq = clock_get_hz(pll->xosc_in) *
+        ((ndiv << R_A2W_PLLx_FRAC_FRAC_LENGTH) + fdiv);
+    freq /= pdiv;
+    freq >>= R_A2W_PLLx_FRAC_FRAC_LENGTH;
+
+    clock_update_hz(pll->out, freq);
 }
 
 static void pll_xosc_update(void *opaque)
 {
     pll_update(CPRMAN_PLL(opaque));
@@ -94,18 +132,42 @@ static const TypeInfo cprman_pll_info = {
 };
 
 
 /* CPRMAN "top level" model */
 
+static uint32_t get_cm_lock(const BCM2835CprmanState *s)
+{
+    static const int CM_LOCK_MAPPING[CPRMAN_NUM_PLL] = {
+        [CPRMAN_PLLA] = R_CM_LOCK_FLOCKA_SHIFT,
+        [CPRMAN_PLLC] = R_CM_LOCK_FLOCKC_SHIFT,
+        [CPRMAN_PLLD] = R_CM_LOCK_FLOCKD_SHIFT,
+        [CPRMAN_PLLH] = R_CM_LOCK_FLOCKH_SHIFT,
+        [CPRMAN_PLLB] = R_CM_LOCK_FLOCKB_SHIFT,
+    };
+
+    uint32_t r = 0;
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
+        r |= pll_is_locked(&s->plls[i]) << CM_LOCK_MAPPING[i];
+    }
+
+    return r;
+}
+
 static uint64_t cprman_read(void *opaque, hwaddr offset,
                             unsigned size)
 {
     BCM2835CprmanState *s = CPRMAN(opaque);
     uint64_t r = 0;
     size_t idx = offset / sizeof(uint32_t);
 
     switch (idx) {
+    case R_CM_LOCK:
+        r = get_cm_lock(s);
+        break;
+
     default:
         r = s->regs[idx];
     }
 
     trace_bcm2835_cprman_read(offset, r);
-- 
2.28.0


