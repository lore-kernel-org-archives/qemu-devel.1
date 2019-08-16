Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A0BC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41122133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4i1YYjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41122133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybqU-000819-37
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hybo2-0005z8-8y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hybo0-0000MO-Bn
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hybo0-0000Lk-5I
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id g17so1468723wrr.5
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=S06e1VfvOBe61kYvY2y9FUBi/HO5B2t1bBJm4qCLKnk=;
 b=C4i1YYjyQq2XVPVYy6fAnfLcjKQ1HAEdh/FCygAmi3FMwSfJeEWL/0Pe+iTK2xe+1g
 HLLxTVeY56Pmrzk3MOiwxhH9uWEsvNPRX30nM+xrwocUBoG3emO9pxMULHTxYAciTYnx
 id+nmuGrbSWSLYwO6xw6Iq9dQYGKvB9AOfFRswNApx0NtXV7P+SNdyc0pCo9V6SlGZ2w
 yVwyhzDuKue+TBkUb+EDp/90qINWSPHV2peJWEO1EsrwYjDRzrBFbj8XOMM2ai/wUuTH
 Q8P/pumQyoPhyiEpg1zVnf2lf7YBw1NkDIvRscQ3ZfC/l1Kd1RLr0hVXmzzdKCek1Pbs
 XWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S06e1VfvOBe61kYvY2y9FUBi/HO5B2t1bBJm4qCLKnk=;
 b=H4bUNxhVyG/j+2UiSrUp5PDqeylXqh/29YQu0Z0FfbRZCkuocZz4TPgWwmQiZrpRkE
 dHcNmqz4vFj1n3Tw2rXLQ2VnB48QxW2+LaERNq7acDg83svGBhNyAjgv7ttTDMd8z/LS
 DbJBvza3JXzNHYhuZFdEwEvI4idG6MmObOwxnoxoCjGzziZFNScDlSvasT61wnylnuHM
 wpIrSKBQX1vCwlgW8KgSLE8Y54MysX7ZzG2ncACqubFQ6vk9uWEOcfP2EV8hvimlMPMN
 Fq19zxZnQFdxy/B0XJSYFjDUr4bUhWL+RxgyNJJscZ6oSiTCUHZsdqCU0etaeiZOYfKB
 KFdQ==
X-Gm-Message-State: APjAAAW0mKrsok6kk0qvoNqmN+F4SFReI6ihOoGuHKcGv7hgSlo/FhRX
 vF+ezjyVWPuoJiERqWpQXeD0y1hlLt7mPA==
X-Google-Smtp-Source: APXvYqzIR8ex8C3ZHDT2TCaM09bEkvm23KjIYotmyAAJ1Mo3JGD8XDInW+OOr05yarJMv4SpdzZ0Nw==
X-Received: by 2002:adf:d1b4:: with SMTP id w20mr10958421wrc.301.1565960287126; 
 Fri, 16 Aug 2019 05:58:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a19sm17594348wra.2.2019.08.16.05.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 05:58:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 13:58:02 +0100
Message-Id: <20190816125802.25877-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816125802.25877-1-peter.maydell@linaro.org>
References: <20190816125802.25877-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Take exceptions on ATS
 instructions when needed
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

The translation table walk for an ATS instruction can result in
various faults.  In general these are just reported back via the
PAR_EL1 fault status fields, but in some cases the architecture
requires that the fault is turned into an exception:
 * synchronous stage 2 faults of any kind during AT S1E0* and
   AT S1E1* instructions executed from NS EL1 fault to EL2 or EL3
 * synchronous external aborts are taken as Data Abort exceptions

(This is documented in the v8A Arm ARM DDI0487A.e D5.2.11 and
G5.13.4.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 107 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b74c23a9bc0..7d82195c960 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2944,6 +2944,73 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     ret = get_phys_addr(env, value, access_type, mmu_idx, &phys_addr, &attrs,
                         &prot, &page_size, &fi, &cacheattrs);
 
+    if (ret) {
+        /*
+         * Some kinds of translation fault must cause exceptions rather
+         * than being reported in the PAR.
+         */
+        int current_el = arm_current_el(env);
+        int target_el;
+        uint32_t syn, fsr, fsc;
+        bool take_exc = false;
+
+        if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
+            && (mmu_idx == ARMMMUIdx_S1NSE1 || mmu_idx == ARMMMUIdx_S1NSE0)) {
+            /*
+             * Synchronous stage 2 fault on an access made as part of the
+             * translation table walk for AT S1E0* or AT S1E1* insn
+             * executed from NS EL1. If this is a synchronous external abort
+             * and SCR_EL3.EA == 1, then we take a synchronous external abort
+             * to EL3. Otherwise the fault is taken as an exception to EL2,
+             * and HPFAR_EL2 holds the faulting IPA.
+             */
+            if (fi.type == ARMFault_SyncExternalOnWalk &&
+                (env->cp15.scr_el3 & SCR_EA)) {
+                target_el = 3;
+            } else {
+                env->cp15.hpfar_el2 = extract64(fi.s2addr, 12, 47) << 4;
+                target_el = 2;
+            }
+            take_exc = true;
+        } else if (fi.type == ARMFault_SyncExternalOnWalk) {
+            /*
+             * Synchronous external aborts during a translation table walk
+             * are taken as Data Abort exceptions.
+             */
+            if (fi.stage2) {
+                if (current_el == 3) {
+                    target_el = 3;
+                } else {
+                    target_el = 2;
+                }
+            } else {
+                target_el = exception_target_el(env);
+            }
+            take_exc = true;
+        }
+
+        if (take_exc) {
+            /* Construct FSR and FSC using same logic as arm_deliver_fault() */
+            if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
+                arm_s1_regime_using_lpae_format(env, mmu_idx)) {
+                fsr = arm_fi_to_lfsc(&fi);
+                fsc = extract32(fsr, 0, 6);
+            } else {
+                fsr = arm_fi_to_sfsc(&fi);
+                fsc = 0x3f;
+            }
+            /*
+             * Report exception with ESR indicating a fault due to a
+             * translation table walk for a cache maintenance instruction.
+             */
+            syn = syn_data_abort_no_iss(current_el == target_el,
+                                        fi.ea, 1, fi.s1ptw, 1, fsc);
+            env->exception.vaddress = value;
+            env->exception.fsr = fsr;
+            raise_exception(env, EXCP_DATA_ABORT, syn, target_el);
+        }
+    }
+
     if (is_a64(env)) {
         format64 = true;
     } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
@@ -3148,7 +3215,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] = {
     /* This underdecoding is safe because the reginfo is NO_RAW. */
     { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
       .access = PL1_W, .accessfn = ats_access,
-      .writefn = ats_write, .type = ARM_CP_NO_RAW },
+      .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
 #endif
     REGINFO_SENTINEL
 };
@@ -4281,35 +4348,45 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     /* 64 bit address translation operations */
     { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S1E0R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S1E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 3,
-      .access = PL1_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S12E1R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S12E1W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S12E0R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S12E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 7,
-      .access = PL2_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     /* AT S1E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
     { .name = "AT_S1E3R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "AT_S1E3W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
     { .name = "PAR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 7, .crm = 4, .opc2 = 0,
@@ -4891,11 +4968,11 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "AT_S1E2R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 0,
       .access = PL2_W, .accessfn = at_s1e2_access,
-      .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC, .writefn = ats_write64 },
     { .name = "AT_S1E2W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 1,
       .access = PL2_W, .accessfn = at_s1e2_access,
-      .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
+      .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC, .writefn = ats_write64 },
     /* The AArch32 ATS1H* operations are CONSTRAINED UNPREDICTABLE
      * if EL2 is not implemented; we choose to UNDEF. Behaviour at EL3
      * with SCR.NS == 0 outside Monitor mode is UNPREDICTABLE; we choose
@@ -4903,10 +4980,10 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
      */
     { .name = "ATS1HR", .cp = 15, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 0,
       .access = PL2_W,
-      .writefn = ats1h_write, .type = ARM_CP_NO_RAW },
+      .writefn = ats1h_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
     { .name = "ATS1HW", .cp = 15, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 1,
       .access = PL2_W,
-      .writefn = ats1h_write, .type = ARM_CP_NO_RAW },
+      .writefn = ats1h_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
     { .name = "CNTHCTL_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 1, .opc2 = 0,
       /* ARMv7 requires bit 0 and 1 to reset to 1. ARMv8 defines the
-- 
2.20.1


