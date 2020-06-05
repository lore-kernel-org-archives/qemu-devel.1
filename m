Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06267C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AC7206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmdMO5TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AC7206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3ui-0001fa-3b
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nj-0004fi-64
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:51 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3ni-0000lO-Da
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:50 -0400
Received: by mail-pj1-x1043.google.com with SMTP id fs4so2053924pjb.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p6D0SimXYVXC4E7m3TGAGtyiw9jb/y2AGrQNgRl17pM=;
 b=WmdMO5TGkw0TnA4jGXKKBq8eFbnXqVpmqipAkp2psIxZU2FVAlXYOpKCeWGu3u14h5
 rqwhBMb01muYtUfwrASzv28qgOClQh9AEmb84yEjxzawxX6Idj8ecE4WGi/PXRVOil1y
 A2D+oCWfXLnGq8C6ip3DbknI9L1w05tugi7hWQ0CmKAjNYq2Ptg9kwEB85JouCSHtyIL
 lV7qkPK4RA5407gvDD1W/TluVUQp7940TTYE7iyg1xUkSrGEnRkQpR8oRnLBRPf+rF+0
 WQEGfG4jcIa02qbA2Lfn5hS+VHHjrLHmKce7Ll32LMd5uGy1Kzku7iJ/py4vTeri3QOB
 Pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p6D0SimXYVXC4E7m3TGAGtyiw9jb/y2AGrQNgRl17pM=;
 b=ZarHSLhPrRI+T/bOI2QPXrDZsjWkhyYjtavh0A0CJZwYKGw5LZ3pC0OknTP+vRvjPP
 cZknj5s+iEaUq9sPMXLgO2d3jaXcfj1mTq/XvOQh+LIhhMNRvBTgJeZJq5nj2CHAb1pO
 dP77L7A3VauLs+KZXwUkOf9uxkdzWztFbI7bcF3tlU3jhTnKwOscLbp8+7Z5FSRNIVyx
 pjuF42hZLmE+z1c8hlfo1DQHprVW6tLpCJLbuF4xcXTFY9eXOaIcnByVaIExpBi2jXqt
 PhNiSkoYb+isiRDAciyZ7dao23Bnv8K42BXvctKLI0Zmck2xfVVWGpyboAKrQYVJ9hPw
 W4tg==
X-Gm-Message-State: AOAM531PVTBhe9b3GTZ+U0zTqqHCwTGYsYGKg7Jda0F2WC5g+QLuLJia
 /lHq1ms9BHuKjDDqhKfvBtn41VCK39s=
X-Google-Smtp-Source: ABdhPJz01C6w+euwWDAv7jpYJ9mjxR+Hda09HLWgpWaMBZseBwOTbQiHXZ/3f2bYB7cvnNsCoXRdBw==
X-Received: by 2002:a17:902:564:: with SMTP id
 91mr8130642plf.212.1591330668657; 
 Thu, 04 Jun 2020 21:17:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/17] linux-user/aarch64: Implement PROT_MTE
Date: Thu,  4 Jun 2020 21:17:27 -0700
Message-Id: <20200605041733.415188-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remember the PROT_MTE bit as PAGE_TARGET_2.
Otherwise this does not yet have effect.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    |  1 +
 linux-user/syscall_defs.h |  1 +
 linux-user/mmap.c         | 20 ++++++++++++--------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 3cac7750e4..7ff10a8b08 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -286,6 +286,7 @@ extern intptr_t qemu_host_page_mask;
 #endif
 /* Target-specific bits that will be used via page_get_flags().  */
 #define PAGE_TARGET_1  0x0080
+#define PAGE_TARGET_2  0x0100
 
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 36bdafb3f1..f2bfa3b17f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1196,6 +1196,7 @@ struct target_winsize {
 
 #ifdef TARGET_AARCH64
 #define TARGET_PROT_BTI         0x10
+#define TARGET_PROT_MTE         0x20
 #endif
 
 /* Common */
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index fdd55986a1..b5618c40bd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -84,18 +84,22 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
                | (prot & PROT_EXEC ? PROT_READ : 0);
 
 #ifdef TARGET_AARCH64
-    /*
-     * The PROT_BTI bit is only accepted if the cpu supports the feature.
-     * Since this is the unusual case, don't bother checking unless
-     * the bit has been requested.  If set and valid, record the bit
-     * within QEMU's page_flags as PAGE_TARGET_1.
-     */
-    if (prot & TARGET_PROT_BTI) {
+    {
         ARMCPU *cpu = ARM_CPU(thread_cpu);
-        if (cpu_isar_feature(aa64_bti, cpu)) {
+        /*
+         * The PROT_BTI bit is only accepted if the cpu supports the feature.
+         * If set and valid, record the bit within QEMU's page_flags
+         * as PAGE_TARGET_1.
+         */
+        if ((prot & TARGET_PROT_BTI) && cpu_isar_feature(aa64_bti, cpu)) {
             valid |= TARGET_PROT_BTI;
             page_flags |= PAGE_TARGET_1;
         }
+        /* Similarly for the PROT_MTE bit; set PAGE_TARGET_2. */
+        if ((prot & TARGET_PROT_MTE) && cpu_isar_feature(aa64_mte, cpu)) {
+            valid |= TARGET_PROT_MTE;
+            page_flags |= PAGE_TARGET_2;
+        }
     }
 #endif
 
-- 
2.25.1


