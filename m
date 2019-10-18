Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8817CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57843222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5gHWOT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57843222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWgw-0007bU-C5
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIy-0006bk-IG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIx-0005UM-CI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:48 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWIx-0005Td-6g
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:47 -0400
Received: by mail-pg1-x542.google.com with SMTP id e10so3741485pgd.11
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HNW+DKXClNFoWE5mAVnYOdmYoSifNB4F8oskeNBuM9U=;
 b=X5gHWOT202VQRwzSmAviUtQdEEfz1DuVcXPtMUdkmFhvtmwVqWeZSSA6EuKgHx/ig7
 IJPgcibeDPYPIfNviQe+aAwrVhmFYPXtVClBAy6yke4pVKHCBywOAzqCKLyLsEpbrRLZ
 aZ1pnVwGs1fMSLkP9yxe3rAjbIFEKeaTZy2bHj/6czbhpHCj1Eiqkqg2uwypAuII58jA
 sCWh9rBZiZc7XWufeR3G0fq4cG77JJk9ycnKofn2OVs/RVUzS6uXZeT0jd8NRS3MuJx/
 kKki63c8PKpmdPc8fHfzVfpxdQh7LHh6MupU11Ba1Un3ltW5wkgFa3ZqZUldEH+SaQVi
 wC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HNW+DKXClNFoWE5mAVnYOdmYoSifNB4F8oskeNBuM9U=;
 b=uM+MNuz9uAuSigx135mI2x/ftGePpiMmC7YEeW3kqhjBZfEZGt9Xe1mQvicavfgHHt
 xgm7kLGOOLgqfx8cYcFzikAHIq2OysCZTtfi55I9HZ2m/0PE/onIukD5ghQRVOoTmRq6
 Yq78fmeRFsLvDWh6TmFQH1M8+xpieBq/P+Gl9qRKuq5QUf+BypQMrMrs2MjOKwr2a62v
 LhrX9+o5QPIknbN37dCHZ9wY2+AULPPclnr2G7Sv4+aw4nBySheuKyZjMubijgkO/bI6
 YOHZ3Si15YrYwoJAtHOnzt6k/Dp8iYYthkn+eN9IrMFaGHcIlPlnHTfW8IMZgiYqEUtI
 /PEg==
X-Gm-Message-State: APjAAAVs4he1nAA9jgjGSL4xRaqigDNDnkNalQF1FN26/a5/DHpk3ehN
 h180zqDBdhy6p8F4WMpWz3dTxGKz/54=
X-Google-Smtp-Source: APXvYqzrMztr0EtKpXatimDu0CSZtbBxsY2M0Nr4p4GLJrNlI+48Y1uI/6xyOqrIAdtSWpVjfuxFDw==
X-Received: by 2002:a62:ae0d:: with SMTP id q13mr8199450pff.53.1571420685722; 
 Fri, 18 Oct 2019 10:44:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 11/22] target/arm: Hoist computation of TBFLAG_A32.VFPEN
Date: Fri, 18 Oct 2019 10:44:20 -0700
Message-Id: <20191018174431.1784-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

There are 3 conditions that each enable this flag.  M-profile always
enables; A-profile with EL1 as AA64 always enables.  Both of these
conditions can easily be cached.  The final condition relies on the
FPEXC register which we are not prepared to cache.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d961474ce..9909ff89d4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3192,7 +3192,7 @@ FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
  * the same thing as the current security state of the processor!
  */
 FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Not cached. */
+FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
 /* For M profile only, set if FPCCR.LSPACT is set */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 398e5f5d6d..89aa6fd933 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11088,6 +11088,9 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
 {
     uint32_t flags = 0;
 
+    /* v8M always enables the fpu.  */
+    flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+
     if (arm_v7m_is_handler_mode(env)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
     }
@@ -11119,6 +11122,10 @@ static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
     uint32_t flags = rebuild_hflags_aprofile(env);
+
+    if (arm_el_is_aa64(env, 1)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+    }
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
@@ -11250,14 +11257,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
                                    env->vfp.vec_stride);
             }
+            if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+            }
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
-        }
         pstate_for_ss = env->uncached_cpsr;
     }
 
-- 
2.17.1


