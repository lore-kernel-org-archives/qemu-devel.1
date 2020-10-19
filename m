Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A3C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E1822363
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUHlOKo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E1822363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWtP-0001Td-IN
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqa-0006ti-HO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqW-0002kW-5A
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id j7so106510wrt.9
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EUu3TowM3/XiihIE5qZiOjj814pdfxEcCr/jEGGcaVo=;
 b=bUHlOKo1wbgmVu62s6KmEqmbmxR7Q+RGw2pR1H4mA7sJmZi/G3t3eLEnhKUPJAefKO
 LoNWcJziUeD+og/S1RzxSPhIYL9jxk2lySOpLfc5IYpR0XKlziBCXVa0yFYC83Tuodum
 0Mm0LSS+9J51KviSrW/G2D4QfHUYmyHQFofCj++8cDRxAds4YEOh+E89JDZ7S81KaORR
 bKAiWH+jPHkK5y40KDY+Rt7oySjndSfxmYjoCONjJmLZlKn33sxsVCAXk4GH1WTPSBQn
 oXRwT6T9aDUrF7KEkEmqRB2xMa0JteYDyFdcBXJUl3nmFI1kIWeKQFoUSOgFsTDZJxi+
 acxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EUu3TowM3/XiihIE5qZiOjj814pdfxEcCr/jEGGcaVo=;
 b=ZF9SxQkpGkHdd8MORs0PM7+JxzPT5DxhOEPAFzQokhNyD/uK5EoriYbtUjXQZI54uJ
 dRP5Yfs6fx1g4bKJyaOn5+tGWPOcApZ8JKeA7CUPOzJsgz6oZWjLxc4CsvG3nrMsXWQc
 OKLNBvDPskpAFxppxKQxPoGO7OVcmfBeCyYtasc1hG+5vNjG5fM6n3s69QmV/2B0fUw1
 Ntd/S7E8hhjqfc9G3gZ8h6pqw7Y5lOaH51xd6gNzxG8sgykelKP1+yXfFsAHq/deZIao
 VoxGk24KysDppV6jlClVCtj9/o8RkNk9b4ohPARgpqIg2rjv5fBAxkQGcUgt76R6iia8
 SgNg==
X-Gm-Message-State: AOAM5316Tzga9x2l3TpGFGZmcp52DECRa0baeMtfaWnat0pC1F0YLzui
 l3KDAc3fAYxxkFucOxsi/1vOzw==
X-Google-Smtp-Source: ABdhPJxb6KHri7P5pcwCwjK+OsRpBfJgRhE+oIUChm9EBPTLrDj6cO5aScpOPnARepoONd7BYoDTjA==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr20325285wrn.91.1603120389675; 
 Mon, 19 Oct 2020 08:13:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y14sm309918wma.48.2020.10.19.08.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:13:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] target/arm: Don't allow BLX imm for M-profile
Date: Mon, 19 Oct 2020 16:12:56 +0100
Message-Id: <20201019151301.2046-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019151301.2046-1-peter.maydell@linaro.org>
References: <20201019151301.2046-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BLX immediate insn in the Thumb encoding always performs
a switch from Thumb to Arm state. This would be totally useless
in M-profile which has no Arm decoder, and so the instruction
does not exist at all there. Make the encoding UNDEF for M-profile.

(This part of the encoding space is used for the branch-future
and low-overhead-loop insns in v8.1M.)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c145775438e..613bc0b9f1e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7880,6 +7880,14 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
 {
     TCGv_i32 tmp;
 
+    /*
+     * BLX <imm> would be useless on M-profile; the encoding space
+     * is used for other insns from v8.1M onward, and UNDEFs before that.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+
     /* For A32, ARM_FEATURE_V5 is checked near the start of the uncond block. */
     if (s->thumb && (a->imm & 2)) {
         return false;
-- 
2.20.1


