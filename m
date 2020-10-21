Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6809EC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97DF207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfX61ijq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97DF207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6Aj-0005Xf-Qy
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66R-0000JT-Sv
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:59 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66Q-0005fk-BF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id b23so745458pgb.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JakqPeHuy5Gs3UHXcz+Lct5dLMIcgU9/NqFcGA7PmDc=;
 b=BfX61ijqLWv4A133fpiWlmS8jxC1DoXKJ8SEK8bOBsShVAADLZkbpZWXbo7iI2LbJr
 TzXXKc7mpJOZM6cLxqsCUBBgTYeiBYTIMNWmgtqgJ0rjfNa0DCQy/eUcg+773hbqQ92Q
 TPjDKX3RYF0k5OKKx2W6NPyGTVgQeFlNU+3S1BkQ3bx6H+g0+ns4SX8LlCauG/kPt3PE
 DRXHv9pUz1vuJ52x+6pSg7DikRhQK61m7yDBz9r6YpRuLi/2o+o+LelUoSkoeej80ohQ
 eozK93PPJX4GIDn+yTczN1JtmW3EcnlCObRK9b/QHD6M/gKKa3m0F+HTQN+H6cT5N9WF
 WqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JakqPeHuy5Gs3UHXcz+Lct5dLMIcgU9/NqFcGA7PmDc=;
 b=isoHcObN2TOxjxKU50bu7cnLhZ4UxiPB+MT/F0YlaoXh2ViM+QUMSx79Htptf3TMvG
 92eh1eIH8cExlgS3cqcDDQohqx07BY1RnOECnqXaFwGofSxjZNsWuofCZyC5A4K+c2i4
 xM4sJd5z1jZNdPPIwEAsE3R52cOWH8JZPDIj9QHUgm+PDjsaGNtvFnZoB22EIP+ONOuG
 5jWPFhNwk3Xp3P3xnwqSK8v5WtCKbZUl2/B2QFW4yQfK5Uyih8cKHbUnrfKk5fTEjYov
 A8MJpRiJFAJ4nPcM8tMaMjS1ymJ/aD+5AjqNufw0ewd8qWZSqT6PYsA2ho22TW/ydIMS
 pXSg==
X-Gm-Message-State: AOAM5312WOgYJlvJIF1d4FfBj38QEzinUjFwMPbHDCSojng5duiPLtPE
 SBVC3a/L5K/nUGvW04QGkMm/KAF7SgYEQA==
X-Google-Smtp-Source: ABdhPJzYAU3SKTrJne1IKGlKirWmcvSnLZArsue8ZznmhTrHxMX0sApQCAfsUpcoRKporxt/SoNPzg==
X-Received: by 2002:a63:6647:: with SMTP id a68mr1559348pgc.7.1603255916785;
 Tue, 20 Oct 2020 21:51:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:51:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 04/15] qemu/int128: Add int128_shr
Date: Tue, 20 Oct 2020 21:51:38 -0700
Message-Id: <20201021045149.1582203-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add unsigned right shift as an operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/int128.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 167f13ae10..c53002039a 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -68,6 +68,11 @@ static inline Int128 int128_sar(Int128 a, int n)
     return a >> n;
 }
 
+static inline Int128 int128_shr(Int128 a, int n)
+{
+    return (__uint128_t)a >> n;
+}
+
 static inline Int128 int128_shl(Int128 a, int n)
 {
     return a << n;
@@ -232,6 +237,17 @@ static inline Int128 int128_sar(Int128 a, int n)
     }
 }
 
+static inline Int128 int128_shr(Int128 a, int n)
+{
+    uint64_t h = (uint64_t)a.hi >> (n & 63);
+    if (n >= 64) {
+        return int128_make64(h);
+    } else if (n > 0) {
+        return int128_make128((a.lo >> n) | ((uint64_t)a.hi << (64 - n)), h);
+    }
+    return a;
+}
+
 static inline Int128 int128_shl(Int128 a, int n)
 {
     uint64_t l = a.lo << (n & 63);
-- 
2.25.1


