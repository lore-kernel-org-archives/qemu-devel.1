Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFFA2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6gDYDn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFFA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnp41-0002Wg-2g
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok8-0005PK-Br
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:04 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:32769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok3-0005wX-LY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id 35so9563237ple.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EytV8fA8967EnswtTLvmJxzReykydC3hrRXQ99z0dGM=;
 b=e6gDYDn0gmxtvtTgGpUYnVmDY5uJKHESXD0FgLsPzNcID1nk9Jbdxwu1P+nKW2vYu/
 9PLS1oj+7Ks94oYTWNd7ZUISfuBwyD+dWiCLSoUy7jTd0s9txkxdXXkfxKKMc+1yS11R
 nsVIGSiEj+xG35FOeAamccnUBWYrH8UKgPN+dILJgL8BtEwaqyuJ8C4j0521FF3Ttwyw
 6yRD+F2R6Ps4Fev6rcrrtmKmM8ItMS8zkoBvEaeTt77Ud3jUGtjRDbXUA8dW+rjDQUCZ
 BncDmq/yaMoyMBmpbXMNjC/O5w08XPKSQKY4pW5+Z3vX1bxWi8Tqg539cGHfA2ZVwZ4n
 a5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EytV8fA8967EnswtTLvmJxzReykydC3hrRXQ99z0dGM=;
 b=aI3R1e1LljR2yVB3bTE2Hr2rbSRM5FP/dboIgX0j4EntA7wd2+FNUCAuayWnPSUzdQ
 rkQNNm1lGnFV7xvluC8Di6g7vfLnH/1tTjJkqRZoAfwn4Fp0IIDRZHhhnovsrO2Wqm5W
 fpAokdtfoU5nNHxTAEijhJFD7DUNHB7YmEx/7kYBfgC7Xr2Y5muOBJ6HXfgXnMZfpG3u
 q7vmwFLMXQDhADTZq54mInPS+HEr25fxjMGqZF/YyCNx1saDcHKrp6NJuyoNF2hY+Fh9
 fF/GVXDuZqYKcU6ZyVqgISaEFZKm1LFBMj01sI5W6hZBYKEpNDhTL6pT/5A8fiCR9QxL
 jI+w==
X-Gm-Message-State: AOAM530hxJBTovNVUVvS6wZclgGmshRLmqV93cLZxHv0XIOY2mgJsaPs
 xqY8oQ/aSKgthE80tR+B9rQdK0OLVE4=
X-Google-Smtp-Source: ABdhPJwXHfatEWojjQDpJGK6AxfeypDKuuscB+hTk3N+DYTMIx+YP0rO5mI3e0u3oTYCwCJZHaGyJQ==
X-Received: by 2002:a17:90a:49c5:: with SMTP id
 l5mr25343641pjm.31.1592941077976; 
 Tue, 23 Jun 2020 12:37:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 42/45] target/arm: Cache the Tagged bit for a page in
 MemTxAttrs
Date: Tue, 23 Jun 2020 12:36:55 -0700
Message-Id: <20200623193658.623279-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This "bit" is a particular value of the page's MemAttr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Test HCR_EL2.{DC,DCT}; test Stage2 attributes.
v8: Fill in cacheattrs for S1 disabled; retain tagging when
    combining attributes; set mte_tagging in arm_cpu_tlb_fill.
---
 target/arm/helper.c     | 48 ++++++++++++++++++++++++++++++++++++++---
 target/arm/tlb_helper.c |  5 +++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2072db2f92..e614d7c4bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11834,9 +11834,19 @@ static uint8_t combine_cacheattr_nibble(uint8_t s1, uint8_t s2)
  */
 static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
 {
-    uint8_t s1lo = extract32(s1.attrs, 0, 4), s2lo = extract32(s2.attrs, 0, 4);
-    uint8_t s1hi = extract32(s1.attrs, 4, 4), s2hi = extract32(s2.attrs, 4, 4);
+    uint8_t s1lo, s2lo, s1hi, s2hi;
     ARMCacheAttrs ret;
+    bool tagged = false;
+
+    if (s1.attrs == 0xf0) {
+        tagged = true;
+        s1.attrs = 0xff;
+    }
+
+    s1lo = extract32(s1.attrs, 0, 4);
+    s2lo = extract32(s2.attrs, 0, 4);
+    s1hi = extract32(s1.attrs, 4, 4);
+    s2hi = extract32(s2.attrs, 4, 4);
 
     /* Combine shareability attributes (table D4-43) */
     if (s1.shareability == 2 || s2.shareability == 2) {
@@ -11884,6 +11894,11 @@ static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
         }
     }
 
+    /* TODO: CombineS1S2Desc does not consider transient, only WB, RWA. */
+    if (tagged && ret.attrs == 0xff) {
+        ret.attrs = 0xf0;
+    }
+
     return ret;
 }
 
@@ -11963,8 +11978,11 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                  *  Normal Non-Shareable,
                  *  Inner Write-Back Read-Allocate Write-Allocate,
                  *  Outer Write-Back Read-Allocate Write-Allocate.
+                 * Do not overwrite Tagged within attrs.
                  */
-                cacheattrs->attrs = 0xff;
+                if (cacheattrs->attrs != 0xf0) {
+                    cacheattrs->attrs = 0xff;
+                }
                 cacheattrs->shareability = 0;
             }
             *cacheattrs = combine_cacheattrs(*cacheattrs, cacheattrs2);
@@ -12029,6 +12047,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx)) {
+        uint64_t hcr;
+        uint8_t memattr;
+
         /*
          * MMU disabled.  S1 addresses within aa64 translation regimes are
          * still checked for bounds -- see AArch64.TranslateAddressS1Off.
@@ -12066,6 +12087,27 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
         *phys_ptr = address;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         *page_size = TARGET_PAGE_SIZE;
+
+        /* Fill in cacheattr a-la AArch64.TranslateAddressS1Off. */
+        hcr = arm_hcr_el2_eff(env);
+        cacheattrs->shareability = 0;
+        if (hcr & HCR_DC) {
+            if (hcr & HCR_DCT) {
+                memattr = 0xf0;  /* Tagged, Normal, WB, RWA */
+            } else {
+                memattr = 0xff;  /* Normal, WB, RWA */
+            }
+        } else if (access_type == MMU_INST_FETCH) {
+            if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
+                memattr = 0xee;  /* Normal, WT, RA, NT */
+            } else {
+                memattr = 0x44;  /* Normal, NC, No */
+            }
+            cacheattrs->shareability = 2; /* outersharable */
+        } else {
+            memattr = 0x00;      /* Device, nGnRnE */
+        }
+        cacheattrs->attrs = memattr;
         return 0;
     }
 
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 89d90465a3..b35dc8a011 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -188,6 +188,11 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             phys_addr &= TARGET_PAGE_MASK;
             address &= TARGET_PAGE_MASK;
         }
+        /* Notice and record tagged memory. */
+        if (cpu_isar_feature(aa64_mte, cpu) && cacheattrs.attrs == 0xf0) {
+            arm_tlb_mte_tagged(&attrs) = true;
+        }
+
         tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
                                 prot, mmu_idx, page_size);
         return true;
-- 
2.25.1


