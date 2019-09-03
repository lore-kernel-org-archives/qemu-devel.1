Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F030C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9B12077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJs6LA08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9B12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Awo-0008Lk-Ii
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArM-0002jV-Ez
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArK-0005tB-Oo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArK-0005sc-I9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id t9so18798834wmi.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JQypItX8vVnzNLFYqeVXMmrdJt6+8bMgnIYYXwlAvtw=;
 b=bJs6LA08bqP5ftuPRxpDtb0slhHLgwpBH2VVAGhrLOJvuZpXxIGwk/daq2fUPolO5g
 0DwM5DLd+SJywhzrercwbI93wp1tzNiTHCL7w90VnkrObll1LeI9yxHp6B6mdRpwI/FR
 kn4kGyKquxXtajnL1g3vYP0vv3wZnVBSl5lAc99goJ9xnDCvmnafxO/V7MhaIGNVa8Ka
 DVdnL0uTQeknD570j1LSj6i0PT6IbcUUl+5C+vU9cTDI4njawdks3Oyl7/dM96yTo/98
 Ve3gkZq1fAFSbo6h3uAbyPSfBipCZQqhGRU+/c1k8iRhOpWRHcnlhliaLLOY3pDlT3vM
 yr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JQypItX8vVnzNLFYqeVXMmrdJt6+8bMgnIYYXwlAvtw=;
 b=GGZdGf3g5l7otKKWjIHmbusuBxubHW2Nps0/lHM3M5d9cu8JEzSS5IfIuDaQp7G2WA
 EfDdxlTlGLYwW3D2d2vCoYzKHh7G6fsN0/sQ75DEj0h7cZ18f8ztcBbvGNLyrGF6cJFu
 w8Kbsuc+t3Bi6CUTp+l0ngXPT63tUVa245nCn+cT6+pOTO+NIZQppBriop00I1cIn+iP
 hYVU3mYcWHLeyL+edk8XRCEHRcZYtIusmWbZa0rqUoJPCm/F6nAWbJvs20r60uNHmSbK
 +iquNpZhGujqr5o2yQloShKuiwszThlQPXs42kW8UlY/Q4Evqf0Dx31ASzQChE7MQFWv
 /XPw==
X-Gm-Message-State: APjAAAUhpTFg5z74broaKKMeFS65+kmK1hiLEge2pdYDrrphjgrF/5eZ
 nNWG+gmDx7GmmrXE+SkE0ihFoDyFHPjzHg==
X-Google-Smtp-Source: APXvYqzh7r8lQXijCe8tAtNgjhiyNguSkYI3wvkX8dHcJCM4vCq+Z0r4HDlDn8feCC2Vw/c2SNbkHQ==
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr789696wmh.125.1567525001136; 
 Tue, 03 Sep 2019 08:36:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:16 +0100
Message-Id: <20190903153633.6651-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 04/21] target/arm: Take exceptions on ATS
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20190816125802.25877-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 107 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e0d5398ab8..507026c9154 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2946,6 +2946,73 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
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
@@ -3150,7 +3217,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] = {
     /* This underdecoding is safe because the reginfo is NO_RAW. */
     { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
       .access = PL1_W, .accessfn = ats_access,
-      .writefn = ats_write, .type = ARM_CP_NO_RAW },
+      .writefn = ats_write, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC },
 #endif
     REGINFO_SENTINEL
 };
@@ -4283,35 +4350,45 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
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
@@ -4893,11 +4970,11 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
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
@@ -4905,10 +4982,10 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
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


