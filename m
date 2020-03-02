Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC9C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A7421D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siSkGF2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A7421D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pQP-0006y0-Pz
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKv-0006cR-RM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKu-0007Yx-Je
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:37 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKu-0007Yd-EL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:36 -0500
Received: by mail-pf1-x443.google.com with SMTP id i13so90508pfe.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d7ojpguKqQxB+IoLGq/8Ijh0sitkQS0XaFUwvCJstUc=;
 b=siSkGF2uEuBihZ1McnyRVQqCM+ra63Wqu9PN0OsX+zuOrgtAsEvCCl3KKRSbabbRwi
 tpAqZEnbTXYh9548Qo/ibE0l/asAGCtiD1LiDAasZzVDccpLAnxU5QHIYvYVO/g1J8Cc
 3zAkVWuuDbrspDtXsjfPwOlQ32VcAcTRPe0Sqexe+80gTBIYgJ4SAXWMHZGgQKKf8Py1
 N0x4A1BL6x+N9tHw7N+ru+TsTiijZ9UJ9Jvo9DFOGuWAPTNMcNPAa2EhhyBR7Ctfv2wH
 yaeyz8vf9YXOv2lvdzSe2TTVE0Yw+hZ+2Oh5CZ9fDIUuC6nfIKq/RDlGubKT9S7WkDLV
 Q7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d7ojpguKqQxB+IoLGq/8Ijh0sitkQS0XaFUwvCJstUc=;
 b=seCC2vH/jAgRsSQnBVI74eFLnKs25lyaH14kW/L/HErKI3Pf2ukTp1iHSuGKxuEM94
 cmTFyU1f3jlUfJ7kT97j10lfEh4iDmSxwVBZiR17VjM8emrRdDsy9OGansIC8pV0TZZj
 JzUugTTUa4gbnIKW8KZufGapWqHI12Pban2faFbDcgzTxiWIA4d2Ozg8k0WqvuyBF6FC
 ZAzQWG1avY8H2oZ/hjeOQD8qN7DAfa9fgKJboCBjZT2dzU1tr9Pgoz1RMjX0UH9ZSX68
 n45Ernhb73lIhWKn7THGakI5pHplgHiMoJbimpfmhKlK0udovWmQ73e5Qbs8tWKzgz+j
 SZbQ==
X-Gm-Message-State: ANhLgQ25yCGcW8aDKBDTxpe/POkXikF8kJrsClLGi8t8JnTovIqJytUw
 YTWkAYwIFawlUf4jQ/Qper8sBESe3Uo=
X-Google-Smtp-Source: ADFU+vs/oAgsL+y2hoLWJjQuD4FFMs8NXqvMey5qhLcP7U29GH/M26LcH1PYsbUdSS2VorgwMUoPkw==
X-Received: by 2002:a63:ad0c:: with SMTP id g12mr111245pgf.228.1583171915183; 
 Mon, 02 Mar 2020 09:58:35 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] target/arm: Introduce core_to_aa64_mmu_idx
Date: Mon,  2 Mar 2020 09:58:23 -0800
Message-Id: <20200302175829.2183-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

If by context we know that we're in AArch64 mode, we need not
test for M-profile when reconstructing the full ARMMMUIdx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 6 ++++++
 target/arm/translate-a64.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9f96a2359f..e633aff36e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -783,6 +783,12 @@ static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
     }
 }
 
+static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
+{
+    /* AArch64 is always a-profile. */
+    return mmu_idx | ARM_MMU_IDX_A;
+}
+
 int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
 
 /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 579180af0a..c910a49b4e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14300,7 +14300,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->condexec_mask = 0;
     dc->condexec_cond = 0;
     core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
-    dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
+    dc->mmu_idx = core_to_aa64_mmu_idx(core_mmu_idx);
     dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
     dc->tbid = FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
-- 
2.20.1


