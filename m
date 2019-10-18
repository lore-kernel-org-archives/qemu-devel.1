Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1A8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E97A21835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dglCRhRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E97A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44435 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWUS-0002sV-TQ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ1-0006iI-RC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIz-0005WZ-U6
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:51 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWIz-0005W6-Ov
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:49 -0400
Received: by mail-pf1-x441.google.com with SMTP id v4so4319412pff.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xWBixVJrplgoFEDYWsC1KvhyFbMO/zEb6ezvCN+GZN0=;
 b=dglCRhRmDlAuRYTGEnSfh2itP+od7kl+pn1w7imqqkyyp60rDuE+rhaxKvmhN8IdQQ
 MgTCl5n8s+BRdC/VmrXsz6G5l9UCzBwFECtEiIBiMibpFLUreQgN83UiYv0EqZCHAwwm
 jbR/pEMeuJOoIaUkFucA90yAcTMq7fuZRtZGv8v+zw2EPQVeItt0l2WeyF3RzXTLlYSO
 sar+2KQyzoXqe+QTFmd4Cl1thsy+/4Ny1VUoM5xxXCmcz3UkL/Xwo3wW9Nn84Lsmul1c
 rVjsccj+3IDTvK1gXzqhyuS096/Fyi/eFG+as9ljQ++tgcN6ha+Ia6Cms+MW1Bn20eWn
 zQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xWBixVJrplgoFEDYWsC1KvhyFbMO/zEb6ezvCN+GZN0=;
 b=h0vNKMw6h1CyekfrxOgKUuiklTZY6fQQ9nZ6zS7zmRHVnDcyuu/+ubRj6X85SoqPL7
 xQQOdXLmtwtln5iUQDr79ZnHjfIcTEhLTpCF/ruaqTxo1bztNzXwNTjdJ78A4lIKVzc+
 Y/BCVuW4zJNatKmbfAkfXeRwFla58gjdaFyqFYRQAYLBvc8IWh2oI9JB0+WiAfuKDEgT
 hOpOPVioWjbdW7/um7yC+NY1EkCNcQe4zrxmyd1OR609/A41nrFl3r7vhOI4eDdMvTry
 XEtQjZzHCLQim/ThvDMrW4n/LB0grvPU8YdF/PA/WkXK28oqkJ2JKZpLBxV//LLfFHQ2
 SiSw==
X-Gm-Message-State: APjAAAVNNWpsJ+E8oqKDr46aiIiBvXQVe+cwLguse49atYErZ09cGDSz
 U7X4YaTUNTz3seaGXMdWPpZCeg513RI=
X-Google-Smtp-Source: APXvYqw3IMb9CnCv45F+wNL1inKJ2k1pmNwybDQG3CIAoojmORHIEBiL47sG6ue9qu/nL/6gqzv0SQ==
X-Received: by 2002:a17:90a:a407:: with SMTP id
 y7mr12510200pjp.124.1571420688434; 
 Fri, 18 Oct 2019 10:44:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 13/22] target/arm: Split out arm_mmu_idx_el
Date: Fri, 18 Oct 2019 10:44:22 -0700
Message-Id: <20191018174431.1784-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

Avoid calling arm_current_el() twice.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  9 +++++++++
 target/arm/helper.c    | 12 +++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d963875..f5313dd3d4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -949,6 +949,15 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
 
+/**
+ * arm_mmu_idx_el:
+ * @env: The cpu environment
+ * @el: The EL to use.
+ *
+ * Return the full ARMMMUIdx for the translation regime for EL.
+ */
+ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
+
 /**
  * arm_mmu_idx:
  * @env: The cpu environment
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 85de96d071..3f7d3f257d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11026,15 +11026,12 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 }
 #endif
 
-ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
 {
-    int el;
-
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
-    el = arm_current_el(env);
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return ARMMMUIdx_S1SE0 + el;
     } else {
@@ -11042,6 +11039,11 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     }
 }
 
+ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+{
+    return arm_mmu_idx_el(env, arm_current_el(env));
+}
+
 int cpu_mmu_index(CPUARMState *env, bool ifetch)
 {
     return arm_to_core_mmu_idx(arm_mmu_idx(env));
@@ -11202,7 +11204,7 @@ static uint32_t rebuild_hflags_internal(CPUARMState *env)
 {
     int el = arm_current_el(env);
     int fp_el = fp_exception_el(env, el);
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
 
     if (is_a64(env)) {
         return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
-- 
2.17.1


