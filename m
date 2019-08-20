Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AECC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6BD22DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwMvL065"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6BD22DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BOk-00030n-E7
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLu-0000HN-Dz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLo-0008RG-FN
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLo-0008QK-7y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id x15so7966pgg.8
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r/bKo1YTStbBd/rtX39D2f5QjfmcgbSrKEypch2w1iU=;
 b=MwMvL065tlfvdjjDqKyLBVU/P9AS4Vc7lmZ+qu6HxLO2CeKSY8rm5cCO17YmZkixD6
 BQCbO43t+PKdg98tLYha0d5U1QLfO9SCplClFqsUuELFeKwQFhM1exYdRKYJyPlMMp5D
 wVuu2QEHgygK+CznZ7Jog/xUx2nDC6y/1pwHP0WkwKPVlNQaMxs2aDENQ+Vtk5ju0sVE
 hxlu2gRRsYG038M7hbMnU/G3jicQ22Cc9Su80kDuaMGmAl7DrRikVs1QDd02VpUijiPa
 2nNmGRMS+AH9PrpD688Hz8MsZcdSW/Hv42PoSQRGOJBo3KBIajWW6lIqNipwgoPQ24EY
 ojiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=r/bKo1YTStbBd/rtX39D2f5QjfmcgbSrKEypch2w1iU=;
 b=nHD7NeciYteFD9Yn+T0BWpbpTnBmmY9rlTmsaTXOHPT9DS0mYc4gc29wceDCJd6jo9
 uX13HzMLEQKoDaYGcUT24XIRMrLOpR/QA6VKlYs3gI7NtM5EnLTuFK8YgWqVh4GXTDpZ
 /L5RPr6FUnvkR8RdOVsHJg6nz1E4NlJ1JYY39nFRTI5PVq/LPiAJQ3yBopcQXe9p5pvt
 ehmR6P6jGWzfRZ7pRD46byFyFRgym6t40GyAbKIKHc+zKotvKcTW9BBiFUfvissMsZn5
 eR3ba/ZpwlRTS3X3vm2aNyCwih6gXJQNZpwi33G8vtjFIk1iXIcLFxR5Bt9LsV8AbyiM
 pI/Q==
X-Gm-Message-State: APjAAAXAqmMlcxcqqMSsXN53ihsH9/JRuCQXLU0VlK48GBxd8fbnuw+U
 jhJDisOi1txqN+GN9GyU33BV35jvzPA=
X-Google-Smtp-Source: APXvYqysswCkm3van1eUCBdaYwp7CqntCzqubVV9mcEX3UjGhNJlZGgBdNgrnBI2SJQ8ciE3YpGRQQ==
X-Received: by 2002:a65:6713:: with SMTP id u19mr24824761pgf.403.1566335250867; 
 Tue, 20 Aug 2019 14:07:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:09 -0700
Message-Id: <20190820210720.18976-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v5 06/17] target/arm: Reduce tests vs M-profile
 in cpu_get_tb_cpu_state
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

Hoist the computation of some TBFLAG_A32 bits that only apply to
M-profile under a single test for ARM_FEATURE_M.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 49 +++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c36ec6c530..570f2dcc98 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11156,6 +11156,29 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
         if (arm_feature(env, ARM_FEATURE_M)) {
             flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+
+            if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+                FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
+                != env->v7m.secure) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+            }
+
+            if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
+                (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
+                 (env->v7m.secure &&
+                  !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
+                /*
+                 * ASPEN is set, but FPCA/SFPA indicate that there is no
+                 * active FP context; we must create a new FP context before
+                 * executing any FP insn.
+                 */
+                flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+            }
+
+            bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+            if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
+            }
         } else {
             flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
         }
@@ -11195,32 +11218,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
-        FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M) &&
-        (env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
-        (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
-         (env->v7m.secure &&
-          !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
-        /*
-         * ASPEN is set, but FPCA/SFPA indicate that there is no active
-         * FP context; we must create a new FP context before executing
-         * any FP insn.
-         */
-        flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
-
-        if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
-        }
-    }
-
     if (!arm_feature(env, ARM_FEATURE_M)) {
         int target_el = arm_debug_target_el(env);
 
-- 
2.17.1


