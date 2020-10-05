Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC42CC47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BA421527
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="E74i/uY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BA421527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXC7-0004Ee-7n
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaJ-00051W-DG; Mon, 05 Oct 2020 15:55:47 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaG-0007ZQ-2d; Mon, 05 Oct 2020 15:55:46 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id C2F91C60F21;
 Mon,  5 Oct 2020 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927715;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOp5kHB5MhJ1e27uGPyXvC1k4exjc5ZLMa8tE4n45oo=;
 b=E74i/uY9kqr/zcBvSkb6HVbp9IfDez2cpkwv1gvv2Bhq+Kdge5obAzRruMirmZ2PBFEPwf
 ewTq31M6RMMdXapKE5Mp4/CLeDpwui5Gmv268JBStHcoz3CzBtVO3adsb3U5ieCmTTYS6W
 +8nr09oM9zEr8kKSmPLynXEGuWdW/L6l4Z2JpmLc8OQnKmIiRzwQunBMMhWig80ky1A9Ud
 ajwjYP4trqcMKPh1syjtdHIFkzdRZqFX73QrlKzDn0eKtjlgvwS4vDG1qoByTHko+hgWe1
 3GEEnoCKD4jH9E5dJc3GeE7oYNYd+WcVSlNyf2QyQlVITCblwLOF0aoTkSRA/Q==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/15] hw/misc/bcm2835_cprman: implement PLL channels
 behaviour
Date: Mon,  5 Oct 2020 21:56:06 +0200
Message-Id: <20201005195612.1999165-10-luc@lmichel.fr>
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
 bh=xOp5kHB5MhJ1e27uGPyXvC1k4exjc5ZLMa8tE4n45oo=;
 b=LAhhZ5FjWuskuvjmMkK3DgQqOwDgr6qPpbkkKAbkRt2BTFSaibrtE9h6x6rV0SWVlP4lAs
 +xxQvhhdg2qXFQff92Tj0Vxlmfe1vD1Im7xd77K2OKDJr38fwpmTxPju+HVN8AF/lqyV/7
 zJvcQ5t0MJ/WQm49Gik3lCIPbTFIJ6l2EHC2f4dEuxbsSAlVvPGEHbAyx3Zb0EhobWfwvd
 XF03lDGHT2jMQiLAt6ffnlQbw7OaNfJBh0Dowgd94mMkk+WVff4D+Q7Tqh3PtHoCQJ5Nmz
 aY/O4srPEHwFYN+sNGY68J69hrelwrRa9qQ7jD6dJSJvGRkDSwpdbEonapcMUg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927715; a=rsa-sha256; cv=none;
 b=C1Z6lNxf73YYKBGOwiHG+58yoiPPUKq+wcGL29NLFobblYEE7UXLlpqESqMO5Iw8HWa48IOqduvowy83+ahkCwg5tMGk8EB/H6w7jU+DDRQ1zxWX5/t/eowwyVD0H44Ofnq4eQDk4OQPI8JbCEO6h19vFSxvI9NZM+2kIY/tIk+ChCmO2didFdf6YKwKlYvT1HsLe9/iQCJiDdfsDYQtpkLIGUAp3GkZTgooDAvqQ2B4L68WHf4lRrymjdr7fSiwI3WMzRMzCpjMnoKUucxHmRxvlme6PDEQ285LCoGRmwmR2tMr6IWs1JGiRH0vQV9fgnJ+7QD37dsMyQHHdSPhLw==
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

A PLL channel is able to further divide the generated PLL frequency.
The divider is given in the CTRL_A2W register. Some channels have an
additional fixed divider which is always applied to the signal.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/misc/bcm2835_cprman.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 12fa78181b..71c1d7b9e7 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -132,13 +132,44 @@ static const TypeInfo cprman_pll_info = {
 };
 
 
 /* PLL channel */
 
+static bool pll_channel_is_enabled(CprmanPllChannelState *channel)
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
 static void pll_channel_update(CprmanPllChannelState *channel)
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
                                     CprmanPllState *pll)
-- 
2.28.0


