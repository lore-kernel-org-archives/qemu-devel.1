Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643C4C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7C8206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuQlPjz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7C8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BdH-0006yL-Rx
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLl-0000GH-QJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLk-0008Ni-MK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLk-0008Mr-F4
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id k3so2472pgb.10
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ukkPGAVjpyiRXhgCeNuw1onp0A6uGMb4+O/vZ/cyj7c=;
 b=yuQlPjz/D/iLzbeS7LqBhzuxH/9up4FNXsZo2ec1o5fwM9roaHw/umNMOJ4DFxl+tJ
 OR+TzqhIZQ6rO7+qt0nsk/YePEoFe5HVsmg+EIgaJvbUUcAg6+5RQCdsZtzB7KV2B4p7
 tAaJzzX2AISMUzau2vNSAlFlIAlibstjoq73MljAjUfBSTAr6mltZhvUnGu+mEgBbGzg
 6IxHGqtpAO5WrzSse/UOfUxQRIY6KQsCvTwnifsuJTOH6Zo6gRXnf0aMzsdiB9ig2Y36
 T9o/tUVCFq29I8/8p1hy+2ECG0wY4ff7WR+ItYvQYv8j236RCimt4sLbwHkfZbQNADui
 cL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ukkPGAVjpyiRXhgCeNuw1onp0A6uGMb4+O/vZ/cyj7c=;
 b=eA/+taZnResoMtHyWT/iOC5s+TAGD6wrmZBsU9C19fbgFddnTPHCLRuIqff9CCHtnS
 uvHTrLld0IjgxcZxDUdRdzGwA98n1nxbJYWpLHnpj0NDMvViW9J3SkRdQn4ShBnYibLa
 917jvQkKZTEgu29jcYojdX5mbg4wuUxT2TEeuuVtwZ9HN8QVxKn2RjaGsb7uChTO7Mk2
 mwakfBHapsGHg2sV0I7uLNw7FB+fPXOUDAs5rOKhTfwXwMvFNVkkaLllvioJAnPGywaY
 B2OD6NmydWk6PPYPDH3IHFSB0z89xVRuaqae2LL1K5YparhioerKI10L1DXRGuUXk8c8
 1skQ==
X-Gm-Message-State: APjAAAWnNDDNnEtLTRMORtBRpm8OqP5m0MIDv/y9hcojony/zczliMM0
 3UZlLwG3NmiRKpRDIF8MTUIWz2tBqfA=
X-Google-Smtp-Source: APXvYqxgpR6O05FpV24EsS6K5/pBi3DTBfFSLfvPSmvRQW57A2x//d5T/DMs0k6GrSDK/HBszBGhuQ==
X-Received: by 2002:a65:6284:: with SMTP id f4mr27188420pgv.416.1566335247021; 
 Tue, 20 Aug 2019 14:07:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:06 -0700
Message-Id: <20190820210720.18976-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 03/17] target/arm: Split out
 rebuild_hflags_common_32
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
that will be cached, and are used by all profiles.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 02cb43cf58..1844c13a19 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11032,6 +11032,15 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
+static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
+                                         ARMMMUIdx mmu_idx, uint32_t flags)
+{
+    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
+
+    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11103,7 +11112,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags = 0;
+    uint32_t flags;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11113,12 +11122,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
+        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
-        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
@@ -11128,8 +11136,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A32,
                                XSCALE_CPAR, env->cp15.c15_cpar);
         }
-
-        flags = rebuild_hflags_common(env, fp_el, mmu_idx, flags);
     }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-- 
2.17.1


