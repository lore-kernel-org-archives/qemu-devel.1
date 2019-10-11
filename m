Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D7ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB07C206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yu/oJVtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB07C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvJ3-0004x8-E5
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHZ-0003KI-AU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHY-00036v-4R
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:37 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:44044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvHY-00036l-1A
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:36 -0400
Received: by mail-yw1-xc41.google.com with SMTP id m13so3479895ywa.11
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kRVYi/cd4sJBmkOfsvOkC48A2821IfvOweyDTIJZmas=;
 b=Yu/oJVtWKrqV6rqzPN9bt3luBufZ2oDC3OERGl0GNEiR0Ec/IrLQ/RY8dEN4N7Txsr
 JN7wwXOKpZucUAlDQxFNxdTevpFefm/oE3lkc2HLb/8rQkgrIbgBVaEKfbiF1Ma28UoU
 9/aqem6igw2tSOnup1QKzToC/hxXzIXNIXXyG0jFh0d1sTKNkziMRqokOFmkEYRw7rkk
 ySgqA4aCmp1UYa3iC2a9j499kcfAU20V/8uLhAfp2NHkanHPZuXI1V74hVT7T9be5sc/
 nHZuxco4xVpsrXtL1UQV6gEP5snEQMcngc/mSbi3gxklON07IBhzkRFAZrXV9iE7iC05
 sJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kRVYi/cd4sJBmkOfsvOkC48A2821IfvOweyDTIJZmas=;
 b=KJyKcOHp/+S4BWyQt5KTj6n46GXBennljJIDPJhdqvVeMMEAF3LnaE2Ro654Zo8UoY
 50zfl4wkyhP0JtlWVP/fTWIhNQfZ3mu4AfsEI5F81uCWxxu8oB+U6TUOrvcnqp4PZEwS
 ERBPxn4ySIoZOMLyIPjD1bb5WyETvUitb8DBl9RSnVNgfDfQFzdOWet1YBBGUJqiS3lz
 B2pXdP0ouiuEnTDygB8G/Od4FEI+kLBvC795SNM6Kjdq3zXLDNS3iv0tXgy9TJQSJ4vL
 anexdT3V8YSvxL3vFJa50wluRMG1ugmU9WzHa4NA4Icf/wP12OBtDID71GLSnqccLTZp
 5mrA==
X-Gm-Message-State: APjAAAW+O+33+NYVvpT/iVDOTKM3aD6WWVl1d8Zs2Tc3RSVg8HhWH1My
 8G3c66AT/Gr32fOr0AxYBYG/ugpvi10=
X-Google-Smtp-Source: APXvYqwZj7AiLkyG7n3C1GzNCajb6H9EX6mfde1YMAaI9sB/z0K8of4u8RcL+qq7SSKgBdF9h33l6Q==
X-Received: by 2002:a81:2b09:: with SMTP id r9mr2411212ywr.346.1570801715120; 
 Fri, 11 Oct 2019 06:48:35 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:48:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/22] target/arm: Add regime_has_2_ranges
Date: Fri, 11 Oct 2019 09:47:24 -0400
Message-Id: <20191011134744.2477-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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

A translation with 2 ranges has both positive and negative addresses.
This is true for the EL1&0 and the as-yet unimplemented EL2&0 regimes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 14 ++++++++++++++
 target/arm/helper.c        | 22 +++++-----------------
 target/arm/translate-a64.c |  3 +--
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dcc5d6cca3..9486680b87 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -804,6 +804,20 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
+/* Return true if this address translation regime has two ranges.  */
+static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_S12NSE0:
+    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_S1NSE1:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /* Return true if this address translation regime is secure */
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b690eda136..f9dee51ede 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8774,15 +8774,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     }
 
     if (is_aa64) {
-        switch (regime_el(env, mmu_idx)) {
-        case 1:
-            if (!is_user) {
-                xn = pxn || (user_rw & PAGE_WRITE);
-            }
-            break;
-        case 2:
-        case 3:
-            break;
+        if (regime_has_2_ranges(mmu_idx) && !is_user) {
+            xn = pxn || (user_rw & PAGE_WRITE);
         }
     } else if (arm_feature(env, ARM_FEATURE_V7)) {
         switch (regime_el(env, mmu_idx)) {
@@ -9316,7 +9309,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    uint32_t el = regime_el(env, mmu_idx);
     bool tbi, tbid, epd, hpd, tcma, using16k, using64k;
     int select, tsz;
 
@@ -9326,7 +9318,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
      */
     select = extract64(va, 55, 1);
 
-    if (el > 1) {
+    if (!regime_has_2_ranges(mmu_idx)) {
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
@@ -9486,10 +9478,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         param = aa64_va_parameters(env, address, mmu_idx,
                                    access_type != MMU_INST_FETCH);
         level = 0;
-        /* If we are in 64-bit EL2 or EL3 then there is no TTBR1, so mark it
-         * invalid.
-         */
-        ttbr1_valid = (el < 2);
+        ttbr1_valid = regime_has_2_ranges(mmu_idx);
         addrsize = 64 - 8 * param.tbi;
         inputsize = 64 - param.tsz;
     } else {
@@ -11095,8 +11084,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
             int tbii;
 
-            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-            if (regime_el(env, stage1) < 2) {
+            if (regime_has_2_ranges(mmu_idx)) {
                 ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
                 tbid = (p1.tbi << 1) | p0.tbi;
                 tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 51f3af9cd9..c85db69db4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -175,8 +175,7 @@ static void gen_top_byte_ignore(DisasContext *s, TCGv_i64 dst,
     if (tbi == 0) {
         /* Load unmodified address */
         tcg_gen_mov_i64(dst, src);
-    } else if (s->current_el >= 2) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+    } else if (!regime_has_2_ranges(s->mmu_idx)) {
         /* Force tag byte to all zero */
         tcg_gen_extract_i64(dst, src, 0, 56);
     } else {
-- 
2.17.1


