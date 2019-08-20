Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABCFC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6FC2332A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICbOrNaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6FC2332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Be2-0008DR-64
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM0-0000JO-LW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLz-00009V-2t
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:44 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLy-00004v-RR
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id go14so102361plb.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FHxf39f9EoVCKpDokykyrgpGnuR6CjljeSMS+5E9ias=;
 b=ICbOrNaDt2XVIh8mtctgSKfF1yPyYPsg9op+wUvUHXksN2R+lz7GQ1qj48sXakswp9
 64egc4h11YNPC1y7HBKBA131D9Glbfoqjkz/1NmIIRO2owoV1WdO4E7GjdkmJ239+TN/
 tyyZepO/zJe5+DHfMxsdWMnoeYdWcmgjUdF9kqZQijzh6F+mJGFOLKbFbm++sHn8S5HT
 jH571+WRQHEmn/coS+ODQMxBpBz1NiAiRGaVer9PCPIjW2T4PURBWlXbgqQm4fgc/kxf
 B7PkyrpTeMUa0IHgW35Bq5/cNCPSdlrT7ILSNY3T1Gqbennq7v/Khxc8NDIMmgcK6cP3
 RcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FHxf39f9EoVCKpDokykyrgpGnuR6CjljeSMS+5E9ias=;
 b=HRuTLB+tdBJ3aBoUsIEheCW3ueMv2qOy/kKZ+1dVV1sM2yQU42AIdi7EzlK6dSjlAD
 6V8AxE90cQsb7tEqSAvGg8ONY4+Q1yn3tLBEA0nmWdnushnijtJx81azehpldU6cEQqA
 jM89LAvaF1sEj6sU8eA13IJgPPi5ADRNVu/wUuc6fJxb0Jn6WtIlwjO1vUBg7sOxtWr3
 9MaFuHmeRrIxumtVLzrWlMOnnHcyCgdiHsNfUnzuMosRZRbxVOT50Y240IjP6fwlOibP
 DmxqCAJnKLVknH40XRBzxb2htTVau8o96fenA1n1u1w5nxAXogIFz5aGKjQEVaIyKDip
 xRtw==
X-Gm-Message-State: APjAAAXv7aeFSde6KJHfikcW6JG70uwmZF4cS2iOyHlbPv9LXM7T20KN
 0a1zn4On+syCZy0uTx5MEBIl2a/0WwE=
X-Google-Smtp-Source: APXvYqz7s/UffdrYO+uED1iJN5n8Thf8KrjwQMYLLxoe6rSW2PUjoEebj/2xEov1YjSaxHNGH6YW4A==
X-Received: by 2002:a17:902:ba81:: with SMTP id
 k1mr31554714pls.213.1566335257564; 
 Tue, 20 Aug 2019 14:07:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:14 -0700
Message-Id: <20190820210720.18976-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v5 11/17] target/arm: Hoist computation of
 TBFLAG_A32.VFPEN
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5dec4d3b3a..9606222942 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3188,7 +3188,7 @@ FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
  * the same thing as the current security state of the processor!
  */
 FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Not cached. */
+FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
 /* For M profile only, set if FPCCR.LSPACT is set */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c01b3027e0..b905d61898 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11050,6 +11050,9 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
 {
     uint32_t flags = 0;
 
+    /* v8M always enables the fpu.  */
+    flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+
     if (arm_v7m_is_handler_mode(env)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
     }
@@ -11081,6 +11084,10 @@ static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
     uint32_t flags = rebuild_hflags_aprofile(env);
+
+    if (arm_el_is_aa64(env, 1)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+    }
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
@@ -11212,14 +11219,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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


