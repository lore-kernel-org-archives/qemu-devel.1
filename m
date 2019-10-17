Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD548ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944D72089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnvWLCl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944D72089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLAxE-0007br-FS
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 14:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArp-00016T-9Y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAro-0000rK-4O
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLArn-0000qx-VT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:20 -0400
Received: by mail-pf1-x444.google.com with SMTP id q12so2205179pff.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mDaUYtXyoxKyQ6YIW+CzLKUl72EI9Ve9jhEUulKMydM=;
 b=AnvWLCl3ZF6YBrLYwzU3eazsAnF0iZroHXHYGljySzg09AOc2rCU+zxWhlzDzeOlMl
 zPnvx6Ms3nce099hTspWXMeyj00zFlclnePjJ1RIKUkOyDGwgSESY3nRlAWKq/qGzaAs
 O8uQVlilF8wkR4sduVV80a1aDhclqpqVztiM74m/AbjqmJUcwpCdWU0rE9SiHiC1ihmE
 EAL7pgd0NxiDzJdHR56kwXpxB/CU3dF5fhIJ4F9rsN+fUQf5w+F2yl01AvNBzFeT0A3C
 9hLI4DFsmDh6sNEza7y6c3o4fO3d3tXI6ADqGHBxD5sSfLiaL22OcZxK6QWj98ngy+F5
 l0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mDaUYtXyoxKyQ6YIW+CzLKUl72EI9Ve9jhEUulKMydM=;
 b=TrjWvG5l9wGf8pGSU3ODI5EtLie+RpcjCH/tqS1zQ+QwQhhQjHdbl0DUL4sjePFRQn
 uPWPAHnDC4GUouICZCdk9pO00boCfiaJMEDUJXi6poA3aacPIQiu+d2w7tDdJJBtL4aU
 bYcFo0nQKlRMjSSs6LUQBtTpl15aKeFwKqgl9unDBiYLJrobSND+ImDLnbezzGFWHEpH
 EVvZDJ8GFPInA5FOm0IYYPIFSpWTICfKIUHYys4R2n7QggZavenUYtwokcVpq8pRoTFr
 +Hg82FbYpRAprvFaLv0Teb0POR5t7NW7TmmX7/BF7mhngUt4FNDO887OprQ/kwfX6oYm
 HG8Q==
X-Gm-Message-State: APjAAAW0RnYnvYN5CGnOA8bn98BeNsMuHskJHuFtknJVuz23WEqkh/A8
 ArI3vkUSeV9DnUOWAVhuq+j38zvbXsM=
X-Google-Smtp-Source: APXvYqzL4XOgr5hEGWYVIdCOVsKmaFBV8Mllr4DLQamDX6rXnIwmwkFbRFMgJzjY24MgsDi3ur7NSg==
X-Received: by 2002:a17:90a:c383:: with SMTP id
 h3mr6080604pjt.122.1571338278719; 
 Thu, 17 Oct 2019 11:51:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/20] target/arm: Split out rebuild_hflags_m32
Date: Thu, 17 Oct 2019 11:50:55 -0700
Message-Id: <20191017185110.539-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Create a function to compute the values of the TBFLAG_A32 bits
that will be cached, and are used by M-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4c65476d93..d4303420da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11083,6 +11083,29 @@ static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    uint32_t flags = 0;
+
+    if (arm_v7m_is_handler_mode(env)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
+    }
+
+    /*
+     * v8M always applies stack limit checks unless CCR.STKOFHFNMIGN
+     * is suppressing them because the requested execution priority
+     * is less than 0.
+     */
+    if (arm_feature(env, ARM_FEATURE_V8) &&
+        !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
+          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
+    }
+
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11168,7 +11191,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
-        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+        } else {
+            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+        }
+
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
@@ -11204,20 +11233,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (arm_v7m_is_handler_mode(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
-    }
-
-    /* v8M always applies stack limit checks unless CCR.STKOFHFNMIGN is
-     * suppressing them because the requested execution priority is less than 0.
-     */
-    if (arm_feature(env, ARM_FEATURE_V8) &&
-        arm_feature(env, ARM_FEATURE_M) &&
-        !((mmu_idx  & ARM_MMU_IDX_M_NEGPRI) &&
-          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
-    }
-
     if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
         flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
-- 
2.17.1


