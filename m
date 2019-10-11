Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81692C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5189D20679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqewMvke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5189D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvYy-0007xv-AI
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJK-00061q-47
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJI-000477-PU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:25 -0400
Received: from mail-yw1-xc32.google.com ([2607:f8b0:4864:20::c32]:34918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJI-00046V-LT
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:24 -0400
Received: by mail-yw1-xc32.google.com with SMTP id r134so3502750ywg.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wjJWQXa8PHF/9CUSCdjQIeze++rnO7qWx/Jq9my6hS8=;
 b=KqewMvkeTcgDKXIXvRKl8YQq3gdtG8d0vAfGj0x5/UCx30nwHJ7a8c9CMILG9GPtbH
 aF/XP2UBATG0EuHzkyJn1FiqDEgA5LwxWJW7AvQl2gsX/pEEqFZuW4wAXCUP2O0SDB2X
 7W+sBhV4p9RHOsnoVmrRToj2UGru0jMI+9avcjCtkAjEirHlBtw6w1FamIV8I5B6Dm7S
 IzD8xsnjf9+x8F90I54Sr+9dXeauhaNyZgZgTIAVyHRhooYTGZt+25SLSWM4LppAGcaT
 ARHZUN+uk7Sy7txxtBpA+ORgW+kHOOF6+If6djnph4TycA/Gmg6q4LVGwTZu7InVj6fu
 cMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wjJWQXa8PHF/9CUSCdjQIeze++rnO7qWx/Jq9my6hS8=;
 b=j2z92qTVWentyNgborlUFZxtOYtblhmvppUCBNqwP7Kza5kCOA2YUAPNOHqBkTBaS9
 DEvzKgM9xnzhZuID7q417x2qwWunWE71wwyp4mo13OLsnsTl0ECf3R+6qkUk3s5uo6sM
 iyUckPby9I4+N8fcvv9tHzY9hG8stPvxh0xWKMi7d9UcGPBTMUBuLeH1NBCKqUTHvLLq
 Q/71R9aYhEe7wnTSLj9hYvRQCSa9xyX9hv1Ajqk/QwrM1HBSWBf2zaUcnagybDiYHFtd
 BO6swNb7dKnDGwDVHB+l5cAR4Mtyu5sy7uP1wQDu15klD1Qi6xQc68WtxBgdDHEe8lb3
 Z3gg==
X-Gm-Message-State: APjAAAWQTVRj9VQlx5XpZhe+Sk1brJxtEynTdH7u+9jBo1JNsV/ZZgf0
 1bmVBgrAMvZ4lW0It5p+Yy1F4cg8afc=
X-Google-Smtp-Source: APXvYqwBXm/ScfmZo1bhgEUIbqIMftBGv5NAVh4EUVw11EfmkwcYZJ6MRVMXQj5xw57PwERyZ8Hx4w==
X-Received: by 2002:a0d:c945:: with SMTP id l66mr2377982ywd.286.1570801823649; 
 Fri, 11 Oct 2019 06:50:23 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/22] target/arm: Implement data cache set allocation tags
Date: Fri, 11 Oct 2019 09:47:38 -0400
Message-Id: <20191011134744.2477-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c32
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

This is DC GVA and DC GZVA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use allocation_tag_mem + memset.
v3: Require pre-cleaned addresses.
---
 target/arm/cpu.h           |  4 +++-
 target/arm/helper-a64.h    |  1 +
 target/arm/helper.c        | 16 ++++++++++++++++
 target/arm/mte_helper.c    | 28 ++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  9 +++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d99bb5e956..93a362708b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2233,7 +2233,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
 #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
 #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
-#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
+#define ARM_CP_DC_GVA            (ARM_CP_SPECIAL | 0x0600)
+#define ARM_CP_DC_GZVA           (ARM_CP_SPECIAL | 0x0700)
+#define ARM_LAST_SPECIAL         ARM_CP_DC_GZVA
 #define ARM_CP_FPU               0x1000
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 405aa60016..c82605b51e 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -118,3 +118,4 @@ DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(dc_gva, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 33bc176e1c..eec9064d88 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6026,6 +6026,22 @@ static const ARMCPRegInfo mte_reginfo[] = {
     { .name = "CIGDVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
       .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "GVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 3,
+      .access = PL0_W, .type = ARM_CP_DC_GVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
+    { .name = "GZVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 4,
+      .access = PL0_W, .type = ARM_CP_DC_GZVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
     REGINFO_SENTINEL
 };
 
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index f1315bae37..e8d8a6bedb 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -510,3 +510,31 @@ void HELPER(stzgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
         }
     }
 }
+
+void HELPER(dc_gva)(CPUARMState *env, uint64_t ptr)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    size_t blocklen = 4 << cpu->dcz_blocksize;
+    int el;
+    uint64_t sctlr;
+    uint8_t *mem;
+    int rtag;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, blocklen);
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, ptr, true, GETPC());
+
+    /* No action if page does not support tags, or if access is disabled.  */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
+        return;
+    }
+
+    rtag = allocation_tag_from_addr(ptr);
+    rtag |= rtag << 4;
+
+    assert(QEMU_IS_ALIGNED(blocklen, 2 * TAG_GRANULE));
+    memset(mem, rtag, blocklen / (2 * TAG_GRANULE));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49817b96ae..31260f97f9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1769,6 +1769,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
+    case ARM_CP_DC_GVA:
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
+        gen_helper_dc_gva(cpu_env, tcg_rt);
+        return;
+    case ARM_CP_DC_GZVA:
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
+        gen_helper_dc_zva(cpu_env, tcg_rt);
+        gen_helper_dc_gva(cpu_env, tcg_rt);
+        return;
     default:
         break;
     }
-- 
2.17.1


