Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBABC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4733E22283
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="FCXcW2HP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4733E22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFW2-0005hj-6m
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNM-0001uG-IG; Sat, 10 Oct 2020 09:57:32 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNK-0004K6-Lk; Sat, 10 Oct 2020 09:57:32 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 85E50C603DB;
 Sat, 10 Oct 2020 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338224;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOTPkXjvC2zXyPDpTmjJaf2TrTkZXbIsOjedNDmg/rk=;
 b=FCXcW2HPG1yj2RzwiuY/fAD8oswAAAspJiOBgCOK1E3Y1WiSgMTtYN+XCAA46Ds8WgujGY
 3/g2DX2v4GCfLE2HYYFsxoGOD7Rv0kCiuPGWLH8aGX65LX40waKiUBWd20fiDgZuPJLNTJ
 Cz8+fAIjrAf0hdltxnHXzTKmxCuKNgurbPJg+2SxQ/ZZ2Nu0AxFmZZxh4g/dK/fHraG/xS
 +9y03q4IXxxgOnORfBDl4kDyI3NwLJHiLUMAf5ZyzAu+hPdWtt1dRRU3Zt4Mk39wf8f+cE
 E2JgoRKp3ZMVfgB3w0MvCEXQQLoqu97A5RjnswQawUnv/8+l5d6oVEifKqZZ5w==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/15] hw/misc/bcm2835_cprman: implement PLL channels
 behaviour
Date: Sat, 10 Oct 2020 15:57:53 +0200
Message-Id: <20201010135759.437903-10-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338224;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOTPkXjvC2zXyPDpTmjJaf2TrTkZXbIsOjedNDmg/rk=;
 b=LW3r/xN7jAeMaUNNC/Y0ElFKO8hOxRxlTNmQFQyWOBqdsAKZ4ap+7H7/4l5gcKkKMPU9Fj
 5DW5D1d8et4m7cgQCC7wp69jkcunw2POwQfDhnT65jxLboR1uSaT6iFu7D36gjJ2Qe3OOL
 ZCiLKtmASEFBA73wvkqssAbHbk2oZ9hP9ENP71GhsCaQf0WDqfqLs8yrxSrECI8XbsBGXU
 Zx4DyrdkIZKFtrwbHKLM1LVW4Th/FsAy3xGcL46TFGIt/JJxPiEaNjeSmVDqEyyWpFaThg
 ALZcDujbNC1x5IfvT3k0FSL3T3duPcv5JgKkyttQcgV9H5bQJW0DeheQm3uB1g==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338224; a=rsa-sha256; cv=none;
 b=g4DYgU3Ygp4aBc7m86oIDi4xMJ1WjM+Zcm87tdOs5YNpJ7Q1ywjeZTgrhQhGhI02LUZ/3Ew9Q06uzpDuq4Wov/+vfCoGJhc7IvW+lX+N3076/8p7F2TdGrV0YbFByl3isj/oHVqw6BQnuhEBK4ARKj4jLgxso3xy/eydpqUWgTKtT4bhmBnLiRRcZ78QBn2Hs5VyL6FsZcKTXz0i/A9KSPBlzjv23lRniBWQfWzdpQUt/pztQ412fAs3uzPKSnvbaWPCESFLoiLWMc0TYvaafyHhN3/fx0oCcLydjUAoZqBRdanDg/JsRiBWSqvOAhIwV3V7JJHicM2/pSz7knHNTQ==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


