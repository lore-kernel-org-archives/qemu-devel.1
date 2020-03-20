Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E9C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A8720739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dy/Scsal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A8720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKBd-0003rh-F6
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKAI-00020R-FI
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKAG-0001bo-Bp
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFKAG-0001aq-6E
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:28 -0400
Received: by mail-pl1-x642.google.com with SMTP id g18so2687535plq.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dbRF0UtzAGUl4dV/70qbuWKf9aMAX0BAQV5Mmox41wg=;
 b=Dy/ScsalsaWfoO9SP4pdSz0cSIWr/8VBuzldEkUglRbzatGtKgnF8B1ihUq+o/kGCy
 wwQwOEaEht2RkyyzASr/07f9VLqqqOmJmu7+PlCZ3g9Z/BJbQDEkwI/cPol+FSUEaZuC
 aJQEu2j6CzyDuaKonCPREPBEXQUJfqk9NKFRpbpcAfrIg7NlFBjhi7LvgMbzwJkNoYgd
 BuEURRl8l90EfGjkDuqCTbN2C4IhwwkCeFklhgc1sPFa5WqKbLbmTQWNISwcWgPR70EK
 trDKJQh1Uc2O0D8l7PeoXOO4xLArS4+Er3YvWEfhXbtON8T+aGs/qA6r+7XcAEWBTnXt
 7yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dbRF0UtzAGUl4dV/70qbuWKf9aMAX0BAQV5Mmox41wg=;
 b=haf79DYN8AL6IAJXDDTsFVIpT7yNQJb5u8Owk/bWrk5U5tpOTViWgIOdcxvk+drHXz
 FwhCBioXIVyU8DU+i2uMnh0oH1fDexS17/3o0ffJzLM66w3A0Fhv/Vs/mCJtXnHMAQD4
 XO6ec4H7KglTTjAnZ2IxEd2WNtXImt4IaPysxWEtGZ4X1WQyDCpfhpT7IKRGaObhP73n
 Bx0F9BNYiPMzXTBSQKPNPN5nB4dOLPF/qOzCuXEkLaa1yPn15ClRyyhGTpdARNg1VIBd
 TKcbIZfOUgfjUtuDEVSIzeRxSjSKOy9mpbiy8n6F88II4KufloJLo7LrtIFX3KbtdihF
 GguA==
X-Gm-Message-State: ANhLgQ31IpPFO2BAi6G3e3zakqxq8nMa5o20v+LMVuaimZIGFXJWBjSd
 NnKQLpWCqyE5INA7Oh6Je3Qzaz4DXrQ=
X-Google-Smtp-Source: ADFU+vt2do9sGB4m6axc52NsxtC0zeQHHnAJsa6fdDdQPfsXbKv8l/7cbURBl0+lCvKlzlNpQJK3Vw==
X-Received: by 2002:a17:90a:757:: with SMTP id
 s23mr10262632pje.166.1584720386867; 
 Fri, 20 Mar 2020 09:06:26 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id nu13sm5272745pjb.22.2020.03.20.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 09:06:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Assert immh != 0 in disas_simd_shift_imm
Date: Fri, 20 Mar 2020 09:06:21 -0700
Message-Id: <20200320160622.8040-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320160622.8040-1-richard.henderson@linaro.org>
References: <20200320160622.8040-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity raised a shed-load of errors cascading from inferring
that clz32(immh) might yield 32, from immh might be 0.

While immh cannot be 0 from encoding, it is not obvious even to
a human how we've checked that: via the filtering provided by
data_proc_simd[].

Reported-by: Coverity (CID 1421923, and more)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8fffb52203..032478614c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10405,6 +10405,9 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     bool is_u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
 
+    /* data_proc_simd[] has sent immh == 0 to disas_simd_mod_imm. */
+    assert(immh != 0);
+
     switch (opcode) {
     case 0x08: /* SRI */
         if (!is_u) {
-- 
2.20.1


