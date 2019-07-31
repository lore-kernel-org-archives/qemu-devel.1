Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B602C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B6A2171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEfOWxba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B6A2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvUc-0005no-Fi
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMo-0004gb-Fx
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMn-0003Um-68
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMm-0003UL-VV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id r1so32508286pfq.12
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h3dhwpfe86udFJHT5d1QRrLfJzUV39xxz0iIkIlTtJQ=;
 b=fEfOWxba8dUcw1YB9PkYIF7f0IZt3Jot9DSidbxSvrttwik89jhDybvAmE8VjvntkR
 mDhvbPtx9iN+Z9x0RjobWti4c2cp2cY8mDuDtAqKQ4WtW3WwgeUXoJYyL95HToYcRHrM
 Xsq6CJqvcgL+jwB0/QbDoMWfP85NCylb65BUO2s8jFH0TwOMeL0uv0ehHKDdjmjmkL9p
 ze0FDx8VuCQYQR0/twXL9eSoBsBgOWaRBgek75lmMDXYGekadt8wj0iKMPHEkJOnq5uq
 ecKpamJKT5bbCXFt1APD3TF4suID1yEE2tlK8d/YvA2ZNBLEFaYkifOJviGN09SzEvV6
 IA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h3dhwpfe86udFJHT5d1QRrLfJzUV39xxz0iIkIlTtJQ=;
 b=IQqTGImmvvSsf360KnRltbdOiGWtGIXWqUdMALYWmI6bHc8R/dzxzT9rVWqqOKn2jR
 kpTt7sFWSTVv+HxT31xbbMBuKHCsAEBzS0e9vZrlqcaLlcklMHr3HJqLcJfXo5YnpxJn
 btUgWczDTy0yledKUWRmoQ2XoZKKkZfgdkZFQTY+VlhpRvaClaO3Yz35lXiSsbEQhPQR
 IrL/7ItVnTeG12APj9NkS0oLADYYxAI2VFFJCwJB5/jhBrFSyNLuwsb0Oyh1W91zM59k
 7DkB+R4+jC4CvStejHjQXqXa2mKlJgvyELtcpqxVXbiUPhSWfi5ffl5PACy1p6CblwDX
 UUtg==
X-Gm-Message-State: APjAAAWVY7OdSJtxye7fFbbKanW3n+w5iqpWyVYxfqxHTrtUhSRTBsQj
 feV6gXWahK3ibNuqly+eaeBdHgTwic4=
X-Google-Smtp-Source: APXvYqzxWA7PoiKIGMQfA5MX/czSvkN8aHlzxQZ51Aq22HOdgfpUq2gXlCELt+djs6Adnmv1yOCUJw==
X-Received: by 2002:a63:550d:: with SMTP id j13mr52857180pgb.173.1564605511637; 
 Wed, 31 Jul 2019 13:38:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:54 -0700
Message-Id: <20190731203813.30765-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 13/32] target/arm: Split out vae1_tlbmask,
 vmalle1_tlbmask
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but unify code sequences.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 118 ++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 81 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e9f4cae5e8..7ecaacb276 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3898,70 +3898,61 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
  * Page D4-1736 (DDI0487A.b)
  */
 
+static int vae1_tlbmask(CPUARMState *env)
+{
+    if (arm_is_secure_below_el3(env)) {
+        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+    } else {
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+    }
+}
+
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
     CPUState *cs = env_cpu(env);
-    bool sec = arm_is_secure_below_el3(env);
+    int mask = vae1_tlbmask(env);
 
-    if (sec) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S1SE1 |
-                                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S12NSE1 |
-                                            ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
 
     if (tlb_force_broadcast(env)) {
         tlbi_aa64_vmalle1is_write(env, NULL, value);
         return;
     }
 
+    tlb_flush_by_mmuidx(cs, mask);
+}
+
+static int vmalle1_tlbmask(CPUARMState *env)
+{
+    /*
+     * Note that the 'ALL' scope must invalidate both stage 1 and
+     * stage 2 translations, whereas most other scopes only invalidate
+     * stage 1 translations.
+     */
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S1SE1 |
-                            ARMMMUIdxBit_S1SE0);
+        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+    } else if (arm_feature(env, ARM_FEATURE_EL2)) {
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBit_S2NS;
     } else {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0);
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
     }
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    /* Note that the 'ALL' scope must invalidate both stage 1 and
-     * stage 2 translations, whereas most other scopes only invalidate
-     * stage 1 translations.
-     */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = vmalle1_tlbmask(env);
 
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S1SE1 |
-                            ARMMMUIdxBit_S1SE0);
-    } else {
-        if (arm_feature(env, ARM_FEATURE_EL2)) {
-            tlb_flush_by_mmuidx(cs,
-                                ARMMMUIdxBit_S12NSE1 |
-                                ARMMMUIdxBit_S12NSE0 |
-                                ARMMMUIdxBit_S2NS);
-        } else {
-            tlb_flush_by_mmuidx(cs,
-                                ARMMMUIdxBit_S12NSE1 |
-                                ARMMMUIdxBit_S12NSE0);
-        }
-    }
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3985,28 +3976,10 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    /* Note that the 'ALL' scope must invalidate both stage 1 and
-     * stage 2 translations, whereas most other scopes only invalidate
-     * stage 1 translations.
-     */
     CPUState *cs = env_cpu(env);
-    bool sec = arm_is_secure_below_el3(env);
-    bool has_el2 = arm_feature(env, ARM_FEATURE_EL2);
+    int mask = vmalle1_tlbmask(env);
 
-    if (sec) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S1SE1 |
-                                            ARMMMUIdxBit_S1SE0);
-    } else if (has_el2) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S12NSE1 |
-                                            ARMMMUIdxBit_S12NSE0 |
-                                            ARMMMUIdxBit_S2NS);
-    } else {
-          tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                              ARMMMUIdxBit_S12NSE1 |
-                                              ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4056,20 +4029,11 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
-    bool sec = arm_is_secure_below_el3(env);
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    if (sec) {
-        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                 ARMMMUIdxBit_S1SE1 |
-                                                 ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                 ARMMMUIdxBit_S12NSE1 |
-                                                 ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4080,8 +4044,8 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * since we don't support flush-for-specific-ASID-only or
      * flush-last-level-only.
      */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     if (tlb_force_broadcast(env)) {
@@ -4089,15 +4053,7 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_page_by_mmuidx(cs, pageaddr,
-                                 ARMMMUIdxBit_S1SE1 |
-                                 ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_page_by_mmuidx(cs, pageaddr,
-                                 ARMMMUIdxBit_S12NSE1 |
-                                 ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.17.1


