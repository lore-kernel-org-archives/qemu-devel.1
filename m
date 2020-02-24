Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D64C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599B621744
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBKc1TFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599B621744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MC7-000457-Jq
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7l-0004Q9-Lw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7k-0005sz-MD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:49 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7k-0005sg-HJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:48 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so6073421pfc.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aSn4NAeocUzSgV/L7ik2kDrtmTdvw88vbNjqxC4Yo9c=;
 b=TBKc1TFH1MMrxxLoVXabVlAV3gqrsgo51CyXapcsrKPErDkzNFao8O+HimXPIXMkg6
 mz460C2vxEDWs9gdokRZxbg+5mwHXlh8tGuh8ohO1U/AHeSH1K5Qa3iNTv6FVXtr9ulb
 ExI0aQ9IQj7nx9KiV6NUvd1+fNDPffQCj9XHkqQGO/On7bQ7BUnKf2TqqTqjWju8ygEo
 kUV9+XNmz3AyRxW+ZgZrU1qa8Yh/p9ldWDH+rS11GGfCwYGJT9ZI9X/QlrK/Gmaw05aN
 DRifucgRRgm473OC7VXWhcPBKSWWCcZDqqNd7hZYxBdPatYud8GxbeK56sy6EESVZ5bi
 sbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aSn4NAeocUzSgV/L7ik2kDrtmTdvw88vbNjqxC4Yo9c=;
 b=Cw4Gsr1xlkn+8f3bBOK0qqzb6s7pNWLpwGEs13tJbNkz7CkacenyIJigwye9Ag6eNU
 27gxPx+CCjMsk5uvNChQrCEJetnDtS/0ZYXqeeM/iL4VC1b9qxR3NeoFRi+HcxLjS5L0
 eXMlgFymN73ylV9U5BROfPNY4dqnMewz5oh7InNVVM6G3Hc3yCBeveuuCGBCSuqW8CfV
 jn68mRL9CTQvOqlhxIeXOMfu6ej7Zw+/YgP1MMgZITahnghGXXwiP3/KuaKWR8enY6Te
 v1Hk1JtytKyPYnNJQBIDpBYJP+sfd7RsxHeHqjUcAFEiIv3puZyqBLPh6YLZQGzOu393
 MjIQ==
X-Gm-Message-State: APjAAAWSh/YxXlTDdbquS1k05xQ4VYcDG5Gr/5PVsMbjZd3E7XdL2FCc
 XL0EjRNBdO2vmgk/sef6w0sevQw44SY=
X-Google-Smtp-Source: APXvYqzswr/NezFIN+VwxT9I1xoc99qaGijQEVD33SRi5OhHggPXoSPGGYAD9w/Qa7lZ3hyx+tcwqw==
X-Received: by 2002:a62:1594:: with SMTP id 142mr53296303pfv.18.1582582967322; 
 Mon, 24 Feb 2020 14:22:47 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/17] target/arm: Remove ARM_FEATURE_VFP check from
 disas_vfp_insn
Date: Mon, 24 Feb 2020 14:22:25 -0800
Message-Id: <20200224222232.13807-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

We now have proper ISA checks within each trans_* function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0489e0cdaa..893911fca7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2652,10 +2652,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
  */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP)) {
-        return 1;
-    }
-
     /*
      * If the decodetree decoder handles this insn it will always
      * emit code to either execute the insn or generate an appropriate
-- 
2.20.1


