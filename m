Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA3CC2D0F0
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C16820714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0tqWz0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C16820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ1bI-0008CC-7d
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 17:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJ1Zo-0006Xz-6j
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJ1Zm-0002gI-N8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJ1Zm-0002fS-Gm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id e9so361490wme.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ace17zOZApynr6koxMRZ66roRKXXaZNKYw00Y2JeNxs=;
 b=y0tqWz0dKsYhvpxQP/MCKg5anmIE647vIIhg7IsytaQz4hJt+Yqypf4cRulW1B2ZOU
 5m2R5SbPFvlQzG2hZnDQV5neQYLCkTHrE8wWMG9i7Nn0B9JYGYYDLJUJEjdA5xCIRR0E
 lCWlhDmzkkloHACtx9ns/YVktrpcYMWJarhn+gzl/bpMV2Unyre9/8rugENAUh1FwcoJ
 bnkR6Ke8+rHB3AHtGzOsy1tojsjnQcxo0WgJ7kpBgxQxJpVufBT34XLKL1+bdXSWa0LK
 UDEg7Np2PmB8tZyTpIpzhYr/V7Vu2MYL0KVCoFoVKnFi1xbcBh6KpJl1OFSg0+Lg/DUM
 g8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ace17zOZApynr6koxMRZ66roRKXXaZNKYw00Y2JeNxs=;
 b=FBbsiS8xdgCR87wz7dL+NG08RJvYDoPbhO3JYlYZ96AJqUzIVyBtC7rM0jxcQqzE5x
 pnkF9O9EEkksFJh0vZnAYJ9gGrJKI/mn6HTLc+B2gJQTkNkfSgbbu3FnJ9dlHVGx3lr9
 R6mtEmNbO6refxIbTl5MZig5GJuKBsaPTUXBDtBL3JoY/zp60AWoLiDVboASSqAq5lqY
 nd2oCKyrl9PQOlcz0FrgswbfKe+iWp3RJ1XDAwS1YMjE7z5LEdtT3TnZpPah0HSmVzKd
 bTc1pj5ksL+ZOsXjITg5ZYS5x/my2Dg3eAyZXDUyV3i/5Df06hnGECx3i5lyJp5eakHI
 YfMA==
X-Gm-Message-State: ANhLgQ17cuzcSdSPdhfYcjYrQAiLrwvt2eZ3/S9ton5HzZIOTABgpvVq
 KKiF2mluXUkdePcxivz5egxe4w==
X-Google-Smtp-Source: ADFU+vtjxMBwO1ifJ1cxMX0xHxUQSvjeI9k2hl3jberFykSZrXGinrmoszj6aKDsGRznC96Q9qyZ2Q==
X-Received: by 2002:a1c:6505:: with SMTP id z5mr1227546wmb.137.1585602245494; 
 Mon, 30 Mar 2020 14:04:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p21sm1012700wma.0.2020.03.30.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 14:04:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/arm: Add new 's1_is_el0' argument to
 get_phys_addr_lpae()
Date: Mon, 30 Mar 2020 22:03:59 +0100
Message-Id: <20200330210400.11724-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330210400.11724-1-peter.maydell@linaro.org>
References: <20200330210400.11724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For ARMv8.2-TTS2UXN, the stage 2 page table walk wants to know
whether the stage 1 access is for EL0 or not, because whether
exec permission is given can depend on whether this is an EL0
or EL1 access. Add a new argument to get_phys_addr_lpae() so
the call sites can pass this information in.

Since get_phys_addr_lpae() doesn't already have a doc comment,
add one so we have a place to put the documentation of the
semantics of the new s1_is_el0 argument.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 25439bf6fd9..47a175b8e9d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -41,6 +41,7 @@
 
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                               bool s1_is_el0,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
@@ -10036,6 +10037,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         }
 
         ret = get_phys_addr_lpae(env, addr, MMU_DATA_LOAD, ARMMMUIdx_Stage2,
+                                 false,
                                  &s2pa, &txattrs, &s2prot, &s2size, fi,
                                  pcacheattrs);
         if (ret) {
@@ -10638,8 +10640,32 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
     };
 }
 
+/**
+ * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
+ *
+ * Returns false if the translation was successful. Otherwise, phys_ptr, attrs,
+ * prot and page_size may not be filled in, and the populated fsr value provides
+ * information on why the translation aborted, in the format of a long-format
+ * DFSR/IFSR fault register, with the following caveats:
+ *  * the WnR bit is never set (the caller must do this).
+ *
+ * @env: CPUARMState
+ * @address: virtual address to get physical address for
+ * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
+ * @mmu_idx: MMU index indicating required translation regime
+ * @s1_is_el0: if @mmu_idx is ARMMMUIdx_Stage2 (so this is a stage 2 page table
+ *             walk), must be true if this is stage 2 of a stage 1+2 walk for an
+ *             EL0 access). If @mmu_idx is anything else, @s1_is_el0 is ignored.
+ * @phys_ptr: set to the physical address corresponding to the virtual address
+ * @attrs: set to the memory transaction attributes to use
+ * @prot: set to the permissions for the page containing phys_ptr
+ * @page_size_ptr: set to the size of the page containing phys_ptr
+ * @fi: set to fault info if the translation fails
+ * @cacheattrs: (if non-NULL) set to the cacheability/shareability attributes
+ */
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                               bool s1_is_el0,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
@@ -11736,6 +11762,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
 
             /* S1 is done. Now do S2 translation.  */
             ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_Stage2,
+                                     mmu_idx == ARMMMUIdx_E10_0,
                                      phys_ptr, attrs, &s2_prot,
                                      page_size, fi,
                                      cacheattrs != NULL ? &cacheattrs2 : NULL);
@@ -11860,7 +11887,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, address, access_type, mmu_idx,
+        return get_phys_addr_lpae(env, address, access_type, mmu_idx, false,
                                   phys_ptr, attrs, prot, page_size,
                                   fi, cacheattrs);
     } else if (regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-- 
2.20.1


