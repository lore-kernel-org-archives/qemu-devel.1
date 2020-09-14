Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C8C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3357F21D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXi7CPLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3357F21D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHbyU-0006bM-Ar
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 20:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwd-0002gR-Ic
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:07 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwb-0004CI-GK
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id x123so11045235pfc.7
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vOtHj+mVdsMkoT/WjxFe7ZI43yFPE5uJFgaFbrClmPo=;
 b=pXi7CPLTSfaRbijb3DyVLi0XCPaUG2ZAo6g3rjE6hIqv9sFcdfZfrKM8wl9Jq0i+28
 H/4dSkJFa54x7fBIUaXiSeqca2/Q0ZuyixblBiAPoKNwTIysBRWLl27jTTc1WQWeSeUA
 H7QTVql1vd3/v3sXrDrfTzukImuu1wmdPkzVkZSdrOzyXXtEJAVoe/suhuaInV2wQaAx
 n4FP5aY0VWbcjVsVFOzdLgpP4kpueCpSYAWGVdYTutnmfnh55wMoMIMxEiHfy5OM0FZc
 zVJOCKTsk7eLlm4CFBAdtFvfDASYA7uey5Ke558jfML7l6igRdHB2++tSTIJ1i+WIzfu
 FqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vOtHj+mVdsMkoT/WjxFe7ZI43yFPE5uJFgaFbrClmPo=;
 b=Ib51IW20Knmzyg0xw4c4o/VCAep8qcd5z+97QXGkC1LH4GSftNHLuO0ESkz1adB8UF
 7fghfgvVUa4mHMBoCYQ4XlfgZ2IfKLHPTQc1ByvVWulNK7QxlLHtSsKsHgEGdapobEHM
 MvBhge7eKSbKrQGsOdDCEjJmMXqhJin5wX9ePioTGFYl87tVXyc4ZQ1QgBiHjhsnt9hO
 BObVki2f5OK2MxebQXlhRFiYd6NncDw2+IXaBD3n5mKz7GVDfTJtuZ997sTkoN1cOIup
 iYoGI20o0tpF8jATLASjR1jKDGbYxsz4pBjAh7sV96puK2qoTnsxWH/108Qc4szgWgYM
 dN5w==
X-Gm-Message-State: AOAM53257hFcwSBaCDi85eX1Y79HeCAHWtJqv2X5R9/jBndOe1sbIWdt
 vL9t76mDZGzqAThPXz74E9grnxWvmeY/vg==
X-Google-Smtp-Source: ABdhPJzfFAVO4IfR/+R9NxUmrscBvQRzmtLWeenByaYMb3/a1eP5/GnqeJFTo/IOpKJRcFQYMdsNmA==
X-Received: by 2002:a17:902:7c84:: with SMTP id
 y4mr7571775pll.97.1600041723952; 
 Sun, 13 Sep 2020 17:02:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 31sm6538252pgs.59.2020.09.13.17.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 17:02:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] disas: Configure capstone for aarch64 host without
 libvixl
Date: Sun, 13 Sep 2020 17:01:49 -0700
Message-Id: <20200914000153.1725632-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914000153.1725632-1-richard.henderson@linaro.org>
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ifdef tangle failed to set cap_arch if libvixl itself
was not configured (e.g. due to lack of c++ compiler).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas.c b/disas.c
index ed9965c32f..5d81403125 100644
--- a/disas.c
+++ b/disas.c
@@ -435,9 +435,11 @@ static void initialize_debug_host(CPUDebug *s)
 #else
 #error unsupported RISC-V ABI
 #endif
-#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
-    s->info.print_insn = print_insn_arm_a64;
+#elif defined(__aarch64__)
     s->info.cap_arch = CS_ARCH_ARM64;
+# ifdef CONFIG_ARM_A64_DIS
+    s->info.print_insn = print_insn_arm_a64;
+# endif
 #elif defined(__alpha__)
     s->info.print_insn = print_insn_alpha;
 #elif defined(__sparc__)
-- 
2.25.1


