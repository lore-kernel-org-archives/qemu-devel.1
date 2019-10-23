Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A46CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3182084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pet1fu4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3182084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIfJ-0002E7-En
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8z-0008IR-A8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001Gr-PE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:49 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:46548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-00013m-Kx
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qt1-x841.google.com with SMTP id u22so32677817qtq.13
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O5qTDR4/yunqOnDsae4ZjoUIG4TsLVXzaOK/t5hnYkI=;
 b=Pet1fu4e7LakqP3u68K6uZ+/Iyt//Fgw/D84p3kOucDpKrfxCMc6K6Ei7qH/Rd3ndI
 IzFfX3iilQ1P34GmmOeaHEYgFTJSnpE3sZ9chPuAgzbp3DE/POVFkGni955VtV4VcsZc
 UnndodFZ9UZ6YNzsJ7fWr2bKHC6yi6RIHH6W+j68aQwzLHGYIN3pnPXQ1f9PQkNHgLJI
 760t9YTGtvDWeoCpeBJmTrMCz6cjslMIfiuVOBG7QqjIOd1ml8R/zjf56XDOMIQH/8fl
 7OFEu0heiQV+lDYbvg1Un4UzVooGs9sEFYUdKM814h8piOv7prGL2uopxkbQI8KzOPJO
 QlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O5qTDR4/yunqOnDsae4ZjoUIG4TsLVXzaOK/t5hnYkI=;
 b=H4cEDnsjbkJtsOIdHIUI9CNVA9+6fmZujgbICzKkjAjVF3aDFcA7xEPw9Csuec5ZWa
 aSoRk10nst+QrmD1sMxipwTj/ihScw9Tp+Q6e1khehroZ3nZcY2s3eXzzsKiASXRFTXD
 cIMF4xtjt7Z1eXSQieEbt7eUJlni8jVnv3YDq8KOIq3ahfAhsl0RwvZPIVOiFrALQ1zW
 K715wGxx6MhGoKhH5IZ+rWqjT9pvhGw9ETSjcfzNmJOSI63PjNbBlcMjFxATj+K0RMOG
 5q6qQaCsHeMRnaZY3EpG48IpfIWhvk1yh7tNFUM+O9Yf2XLqYRi2y0Ia/AKpkv2OErMB
 gfeA==
X-Gm-Message-State: APjAAAXZLHc7yP9mcE1GlirOdvdjMQ0zITA4Kn9x9MJN7U+qjKD3ZYwm
 REHKcjAZUItmjzw3dGqpI3ctBmcmQtY=
X-Google-Smtp-Source: APXvYqzHUgUZQfYwl9frKFcArMJajYdoXKPWvPQIv9htqXX0Mw8xMISFB2EJhUYtZm/pUT1XCxsnCQ==
X-Received: by 2002:ac8:6c9:: with SMTP id j9mr9311096qth.81.1571842870635;
 Wed, 23 Oct 2019 08:01:10 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/24] target/arm: Reduce tests vs M-profile in
 cpu_get_tb_cpu_state
Date: Wed, 23 Oct 2019 11:00:39 -0400
Message-Id: <20191023150057.25731-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 49 +++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4303420da..296a4b2232 100644
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
2.17.1


