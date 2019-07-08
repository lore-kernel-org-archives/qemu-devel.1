Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68C8C606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D86204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCbpLJMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D86204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTd3-0007JX-VZ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52256)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbO-00060v-FR
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbN-0003wz-HG
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkTbN-0003wM-AY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id v15so5418568wml.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4k6A6Sehnb0t0NBVSTvBu5NVlmPUHPOJZHFdQpfg10w=;
 b=eCbpLJMrhl395Gb/YUzE1PI7Gifv0RbFXq3AhcQsB2Sn8X7qFarnOrpmm66NB5Eixb
 BWUXqgM15W1qj22w4ffJOa5++uM10+oFJCDhDZEBqg9Eck6TwV5yKgtRcZD/w/pNm0me
 fVn4jAo/6csDRCHKTha159Ujj+1vGVH7tpyUFdprGZKoG1l13yydUE9CrCmuO4bzaBPV
 zaLa5cd/k25Hg79EobKZUS8FAdFIKzIP8fJMTGPokVrZKzGIunRJRT/ENrC4hBJPaGhF
 xTUccdOpIQ2p+w1tMkNW59bg5MohnPxzMgD6LrsNSM0xdi3A6lwxL6BdOw37zJNUlUBn
 MZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4k6A6Sehnb0t0NBVSTvBu5NVlmPUHPOJZHFdQpfg10w=;
 b=e6LFKrR3zv+/zOi1uCalY9Y4mjKcCgag572lUAaNYRnqJuOqVnPjResY3iz15OO0g8
 TfAFnPa1T3hIduYq8/7pwKJOgwydoeCNBE4pAOIJtW5iPBJF7fhygPw5iDYByEWE/aQW
 E0+yRRMfEs+TMdsBqtQivZ4Trs0ZLlnGhIV/5RuZ0qLnmVGNXhwwY99IwQIiua2cQezr
 S4sFEVxuJHpbBnvraFFw2Zzb1/tL7+j6+FmeIlsfEG+BIRrTGsLAAFOpC3fFMejejmVN
 xS4QBuZty0zFVouxxTHd34jT0YbrvA/TRNrPT9a8HVcsgrGIdq7kOC4CKPY+f+/oVMzt
 blgQ==
X-Gm-Message-State: APjAAAUl96G5NSj+Im30gApea4XDptPWAckiLhfQGGoLUHjk8b4XfIlI
 m19JMrAvbD2KW6gTeEh2NLF06HVsqynsQA==
X-Google-Smtp-Source: APXvYqw6APfdjJGbepJ8dI2feTB15mqQMvQw+CTJuWe4KiCeDtNHOLMF8KAHlVA73GokLxNazE+6tA==
X-Received: by 2002:a1c:6504:: with SMTP id z4mr16592151wmb.172.1562592160044; 
 Mon, 08 Jul 2019 06:22:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v15sm13773744wrt.25.2019.07.08.06.22.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 06:22:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 14:22:34 +0100
Message-Id: <20190708132237.7911-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708132237.7911-1-peter.maydell@linaro.org>
References: <20190708132237.7911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 1/4] target/arm: Fix sve_zcr_len_for_el
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Off by one error in the EL2 and EL3 tests.  Remove the test
against EL3 entirely, since it must always be true.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190702104732.31154-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2df7152a9cd..20f8728be11 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5283,10 +5283,10 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
     if (el <= 1) {
         zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
     }
-    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+    if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
     }
-    if (el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
         zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
     }
     return zcr_len;
-- 
2.20.1


