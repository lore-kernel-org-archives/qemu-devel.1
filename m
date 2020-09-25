Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC47D221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="AVXE/d/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47D221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkwH-0003CQ-Js
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknK-00018X-Jl; Fri, 25 Sep 2020 06:17:38 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknF-0007S0-2M; Fri, 25 Sep 2020 06:17:38 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 882DFC60F20;
 Fri, 25 Sep 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9F/66Vuw8urIeiKnlqbUW/o4qpDy+MtTRBF5H3Fg5c=;
 b=AVXE/d/XTTIiawt4nUJt41/1Hmz/YG0EH6zFbA1oFPjXxDxJuuHFsxQPgaIgJlZWHR/vW3
 sRbev50NEYQ+uPHTvI583mXhN/gYDtA30rPVnf2pFf7grBLT7zJvfI1/e//RhbzuyvoKk3
 SzLSjiQwE66t4DDMysmqFzLBQCfOqSayU+02qv8AgeDbIOyGOSTtlt5D1ZapleVyLMt2Uh
 JEy/iezn5AVdf5o2AxpmVAbr4w2M2R6WAdHi4Wy3ii4DIriwBpuiFAkRYAw6jwrGtebSpD
 A1BNOanOektZOc1NcC/uRauEduotRcp2LwO30phIPLYhNXCTqsOG6OlsjIHHFw==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/14] hw/misc/bcm2835_cprman: implement PLL channels behaviour
Date: Fri, 25 Sep 2020 12:17:25 +0200
Message-Id: <20200925101731.2159827-9-luc@lmichel.fr>
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
 bh=B9F/66Vuw8urIeiKnlqbUW/o4qpDy+MtTRBF5H3Fg5c=;
 b=cjG8tE9mjEqEETyVlvOrkQk58Ad0Oxr2DJV4YmsqU78TzJvh0BkuyoTUllvyGnjw/y0C/5
 g7t+s8FSYwgpJMS7heYsnkYnbCqLGwBS/XABLZT08EzWIStE49XP9xVdUlhtp2ZaQTIgpY
 gDxF1vcNtMOJxI4teUZkr3vcCJdKODdRJsPdM+iMWCz+ILlK++VLYZxYEpzw4hO+J/mi8V
 b1kp139A0TkO61wu8fp8wFZi36VtYSzLGS8ZV9DqoQ16DWoBwYBgZpSs7Qt3QqQiM4/Xil
 y/BOdZWrgnpQWr3UqOY4wMjjz6Vn6tR+7/DQld+EC5X4M2BIS2xrjZLULp8EOw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=VeYE3jpca0MJWf8Zlf4SpfqlJupuXimZz/NaA+DOUWPnY1wlEo3W35C/e5QeyLe+APuPTnv9mKn+uGOeVkhCEsZK+vUUk5a+zFn2V/gfTi97HKVLJ055GBtMk/QHglr4wJzI3yCu60egR5/v+t0h7SYhbR/cWA5pAyN5tMzsTzRAa80z8VNfT8p3l2ZZ3N4AkeNJyi4uf3AfdNhBz3bb2+hJLv+9GcWyxTUEP8FISaTouRrzzrNRui/fD32dB7ygMlaPMoilQxFCmz0/jKWEIdXfpzT+tY8+y3r/CiaVDAxhxuDoZ7KBaMyIXJ4Jygh3iR3IrNBsRzlz7exnOegWvw==
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

A PLL channel is able to further divide the generated PLL frequency. The
divider is given in the ctrl_a2w register. Some channels have a
additional fixed divider which is always applied to the signal.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/misc/bcm2835_cprman.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 2c70a3f317..e644aeb2b5 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -132,13 +132,44 @@ static const TypeInfo cprman_pll_info = {
 };
 
 
 /* PLL channel */
 
+static bool pll_channel_is_enabled(CprmanPLLChannelState *channel)
+{
+    /*
+     * XXX I'm not sure of the purpose of the LOAD field. The Linux driver does
+     * not set it when enabling the channel, but does clear it when disabling
+     * it.
+     */
+    return !FIELD_EX32(*channel->reg_a2w_ctrl, A2W_PLLx_CHANNELy, DISABLE)
+        && !(*channel->reg_cm & channel->hold_mask);
+}
+
 static void pll_channel_update(CprmanPLLChannelState *channel)
 {
-    clock_update(channel->out, 0);
+    uint64_t freq, div;
+
+    if (!pll_channel_is_enabled(channel)) {
+        clock_update(channel->out, 0);
+        return;
+    }
+
+    div = FIELD_EX32(*channel->reg_a2w_ctrl, A2W_PLLx_CHANNELy, DIV);
+
+    if (!div) {
+        /*
+         * It seems that when the divider value is 0, it is considered as
+         * being maximum by the hardware (see the Linux driver).
+         */
+        div = R_A2W_PLLx_CHANNELy_DIV_MASK;
+    }
+
+    /* Some channels have an additional fixed divider */
+    freq = clock_get_hz(channel->pll_in) / (div * channel->fixed_divider);
+
+    clock_update_hz(channel->out, freq);
 }
 
 /* Update a PLL and all its channels */
 static void pll_update_all_channels(BCM2835CprmanState *s,
                                     CprmanPLLState *pll)
-- 
2.28.0


