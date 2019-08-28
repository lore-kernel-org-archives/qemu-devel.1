Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E358FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD802053B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3kWkSXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD802053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33Z2-0005nI-Sy
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GH-0003hG-AL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GF-0000GP-LK
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GF-0000FX-5M
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id i30so379119pfk.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IYp58wrZObrPG3dx71Rbw+Ikj8Xd6H3z4vbXYSZpilA=;
 b=E3kWkSXHIQ/XjfMSnhIfEhiX4W8kQE5YpFMq/uOWP5nU8c6ytbUscbra9APHSn2nMM
 5oLCsWXFYFCW4l+wsq1vzNOqA7VdoSvev7pCz7sjlDM0vqAszelyKafxbxmvRp9/4x30
 N0xr7O87SsQLYH1NQNfahHKSjtpSWzk2uoTEo8eBorChnLSKB6j35IajaqDa2xe9apqi
 bjzBihao9dWc8DmqFZVTMMXciUoXkloy71ydfg/06kldWxXt3d2WW+S5WsrFZhUWkVil
 cpPVZ3RVKSsxzRfJJKT7nUdvAQVjwHpEih+ruIZm+cKcBM+NKCYY1d0XetpG0xN+bpYf
 qeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IYp58wrZObrPG3dx71Rbw+Ikj8Xd6H3z4vbXYSZpilA=;
 b=i9ahbz6zwV4Bc0VEWSa5ks5r/1copIW6UCdQ51iTi15eEEPwKTDKS6IaUTyu0DCbKb
 Y45CSiImon4YH/9lTJlWV5BSbO0wkXokMrgSbhTFjFZKhJLWhy8vHptujaZRoeQA9tNE
 wbDGFSK6X6vW+R98vLSbAEXYmgF1kG3OloOQnJjpVm1Jc+rLtMdr5qfKdeQecOS89WVh
 GaUZEoq6f/850tf+EkJhDXK+g3XO6DXjXBp/UQvjuZlfzM/mVlFBeG8fUuPtmG4Uf6c8
 E/FFsFxSsDVJ2W6IM4LbB1bOO9MbWgAsQD5skBkMUU/DzMGVzc8ilHsQPukWBckUrN8D
 aRsw==
X-Gm-Message-State: APjAAAXo+FL9iTIe1AaRglGwG7NoTzMQwyum4ZU1afaWS4XAK9oIhhOn
 Z60SMffYkqnDVqaoY4Yqua76M5QX1tU=
X-Google-Smtp-Source: APXvYqySJulRVKOmkfU43WXCFcpTIYOIodzpogeXN4TgPYf4jxcwq0FlxH64LXGDZGrl10rlVJmefQ==
X-Received: by 2002:a17:90a:9dca:: with SMTP id
 x10mr5887840pjv.100.1567019137672; 
 Wed, 28 Aug 2019 12:05:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:16 -0700
Message-Id: <20190828190456.30315-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 29/69] target/arm: Diagnose writeback
 register in list for LDM for v7
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

Prior to v7, for the A32 encoding, this operation wrote an UNKNOWN
value back to the base register.  Starting in v7 this is UNPREDICTABLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3a96866531..529660eb35 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9964,6 +9964,15 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a)
 
 static bool trans_LDM_a32(DisasContext *s, arg_ldst_block *a)
 {
+    /*
+     * Writeback register in register list is UNPREDICTABLE
+     * for ArchVersion() >= 7.  Prior to v7, A32 would write
+     * an UNKNOWN value to the base register.
+     */
+    if (ENABLE_ARCH_7 && a->w && (a->list & (1 << a->rn))) {
+        unallocated_encoding(s);
+        return true;
+    }
     return do_ldm(s, a);
 }
 
-- 
2.17.1


