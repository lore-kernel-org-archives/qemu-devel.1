Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45967CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFE92064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sG1Tj2K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFE92064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuNp-0003d7-L1
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGp-0002i2-Pg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGo-0001IS-NO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGo-0001II-HB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id r141so6598583wme.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uSJ06sfOg2LD5tGvl0x+KI5+jg4UPMjf+ZwawjasdT0=;
 b=sG1Tj2K3Z0U0smDrPql2aVvvhimWKskYnLlNYMzizlizCtY5URkLZCrGdKGN0vMdDw
 a9riujeJmnuMGmYvKDZTvtIUqvia7QBe0ji9HC6hB2ursIaihMaju8vMmM6Ntiq6IJnu
 wLPB6fq5Aw8gEGFRuyV4KvhbSqYmvaEN9zI8CSm2OOS3HoYFy1rV5vQK64PyaFG5EoNm
 VlIqZZGG/+DxBEJQu+AMTXvwhbm/js6zeK2k+d3DKiND675ctlUrUMbFdKoBbnnXfddm
 +oR21mwjMjYVWYrfvKe3HuNPWepqMuuEL3ZIPAh4qJPqnyrjQo9IEvJ2Q1WSYuxluQkH
 4l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uSJ06sfOg2LD5tGvl0x+KI5+jg4UPMjf+ZwawjasdT0=;
 b=YwLW+hxXWKdCTUG8tOOXF3sYJzApRQ/jOWKKBzrYB2kvCZVSC5taI3fonM1z2BgWyQ
 mhKf+5maqMCpVs58G7slwzFJpeiT7sydh59vZpFQGzhDeXnJuCFFynOjRGXhaxWw6Cv1
 AoLecCZongSjiEeD0HyIUFJ+dt3/6KDrvDlO/Q3pW1qriQhil5lqQVDBb0r8lrjJY6ri
 ZNATU2oz1f47u8Q/1CDPsV5HvHPp6psyoCzT42Hd9azPf6PQw0gBLOy77O7FGg2gNHwO
 bVNjj8ATpQNQICaDSwix9yHvNo14wH03E91tOf1y6xmgefyxAk/W+8Lc73G/6XYlaTpJ
 8oLQ==
X-Gm-Message-State: APjAAAVXzNbuiDhsttNfEg8MicKQcoJ3zUAh1mUedSaBnrLDNgxCoduJ
 +I9lNlBaTntOkb+wFNMmZDB6A61T72I=
X-Google-Smtp-Source: APXvYqwhvHWp9MlmezxCf2sFLQe0i2qVzVoREBp0A1oJJY+HdIZWkDCHuH+jLilu3wV7Xc39cyBS3A==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr3308396wme.92.1571751137017; 
 Tue, 22 Oct 2019 06:32:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] target/arm: Reduce tests vs M-profile in
 cpu_get_tb_cpu_state
Date: Tue, 22 Oct 2019 14:31:09 +0100
Message-Id: <20191022133134.14487-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Hoist the computation of some TBFLAG_A32 bits that only apply to
M-profile under a single test for ARM_FEATURE_M.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 49 +++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4303420daf..296a4b2232c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11194,6 +11194,29 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
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
@@ -11233,32 +11256,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
2.20.1


