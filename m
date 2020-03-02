Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37513C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0766521D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhZvQJ5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0766521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pPK-00062C-86
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKu-0006b5-Kj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKt-0007YJ-IH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:36 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKt-0007Xv-DF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id 7so189880pgr.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nnZb8apL5HPwafrnPocDxPavn/5fOqQOkEGFTZ+nDV0=;
 b=VhZvQJ5+cEChkiR9dxCzGSXsj/jtGkqJTGx1BXvvtyqFUGAMI57XDLSJoLzR0/1vS8
 7v56MN29PvZvjR+d/fTNJRIlIvVUutbWdPLmlq7gzoIboMHF6LSCI3W7PUiZpVY9PGwj
 JMYJBBJrAiOoA2oRCAOGULv5+Z1I27T7XTeKf39B12c0Asr2A/9zSU23x4vtJN/l67iK
 lbyRkdqsGW3DZyI0xjVtI5krWchs/EgAOARB6FCCWvL3CMbE/OphCGVjYLFhjBT6FOSj
 oTBPvGS839DwAw2RAzxcDk/irP8MdkWwoNus9P1o78joaP/y10xj1oXziOIiV8xAj6GP
 ADLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nnZb8apL5HPwafrnPocDxPavn/5fOqQOkEGFTZ+nDV0=;
 b=uRhlumADpCHutZ2+xbvQSCfLSNcnVU7BBa6NXMcoJEG3PW0bpjsnXCA2eIzCSMIIEi
 MbWeDA0DWxVLRDIdx8qh/XU9ZjmeqH0SY9ZfAqBll3jaPK7dXMHviF+b2QW1owkmAw3y
 ilvBPoJmLP4J6emL8xQZ6h+swv8I9P4bvVcKGcy+oRjnegTgkXkddhyvrtREjpr9Ghiz
 D8H5zTnQAVu4HZjtGYcWVUJxmj/r+TMaLwSPZ1up9maBytd57+jOZFuw3YSufNNoxMaK
 /PHDMiVOb+CTwvBBED5tRm6I4bSDLDR6gVA18weq8dylhafWlWUZ7VVt5i58lNuuDCBU
 3YWA==
X-Gm-Message-State: ANhLgQ2fKAWTEtoRhQ6GXAiAYlC+FN1+bVTRbn51mt0mW4imDJjHdYxK
 C4gKmHZxxs8JDIzoh4/nPuVXv+jR/UY=
X-Google-Smtp-Source: ADFU+vvg6dJKI/XrHGdFfkH+p+bdEdoFrykbN7Qp43o9/OvYUe0zs8q497rq0h86U/qugrP2/Fh0Ag==
X-Received: by 2002:a62:1dd8:: with SMTP id d207mr234054pfd.78.1583171914087; 
 Mon, 02 Mar 2020 09:58:34 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] target/arm: Optimize cpu_mmu_index
Date: Mon,  2 Mar 2020 09:58:22 -0800
Message-Id: <20200302175829.2183-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

We now cache the core mmu_idx in env->hflags.  Rather than recompute
from scratch, extract the field.  All of the uses of cpu_mmu_index
within target/arm are within helpers, and env->hflags is always stable
within a translation block from whence helpers are called.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 23 +++++++++++++----------
 target/arm/helper.c |  5 -----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0b84742b66..8f1b949c88 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2936,16 +2936,6 @@ typedef enum ARMMMUIdxBit {
 
 #define MMU_USER_IDX 0
 
-/**
- * cpu_mmu_index:
- * @env: The cpu environment
- * @ifetch: True for code access, false for data access.
- *
- * Return the core mmu index for the current translation regime.
- * This function is used by generic TCG code paths.
- */
-int cpu_mmu_index(CPUARMState *env, bool ifetch);
-
 /* Indexes used when registering address spaces with cpu_address_space_init */
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
@@ -3225,6 +3215,19 @@ FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
 FIELD(TBFLAG_A64, UNPRIV, 14, 1)
 
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ */
+static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
+{
+    return FIELD_EX32(env->hflags, TBFLAG_ANY, MMUIDX);
+}
+
 static inline bool bswap_code(bool sctlr_b)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37ffe06c05..addbec91d8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12128,11 +12128,6 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
 
-int cpu_mmu_index(CPUARMState *env, bool ifetch)
-{
-    return arm_to_core_mmu_idx(arm_mmu_idx(env));
-}
-
 #ifndef CONFIG_USER_ONLY
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 {
-- 
2.20.1


