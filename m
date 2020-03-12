Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401B8C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E17F205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olQOyDIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E17F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU2l-0005Iq-5U
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjN-0005ve-OK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjM-0002EP-7Q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjM-0002Dp-1a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id u68so3775781pfb.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IBVWDMhA5xeJ1t7FkiUhAVEPTJaDqFXyx+BzGGFHx9I=;
 b=olQOyDIEpo8WpX+r6UIJkPkICFM81UI0Af/iwDADKEXhFQAB0qPQ8yQLLgpnrvd0SP
 p9F9UmICF/fH+5rjoTcMjMYf5W8kulrmCuUeB6fVsBMyWa6e/rCsHiMyxfisVaxxW6kO
 LhSrWqeVjCMtuPt4lnPZxHbIPbW2RPMP5KGatX2K8dM8g0LCmIL/varkKvUA38wI6flf
 DwSpHOtAg/uLeecTCFmN9bNdpTQ8HIMQRRVc7WY59SI1NzGfFPk5PiZSuMBxtuF2vfAd
 MaTDabYjJX1FOio0CfUoTIpWu0oVPxzDpo+ZB4fscjMKMgG/1QIqSPKZkBeExBuCZ1k1
 jOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IBVWDMhA5xeJ1t7FkiUhAVEPTJaDqFXyx+BzGGFHx9I=;
 b=Z7Wz6RZGJ0Vh3yU5ih+b5nUjeSEfc2h0Tyu0r4ter0U8ZwXuuxtmFbIDc8DC4UB/4s
 bIPskaHRiukrSj97dAgsF8OU49SrZMq7/twBuqlHTCSPWXiLpBVRh6e2dcrqdNH0Ku+F
 JjEQPai7JmyZqTBF+G5uy/TnjjPw5R7siZrNdJPfEDlfIg+4kocL4ed8wYprUV7KSNmf
 3z5KkhUdDMLGBHt3qA7W1+JTFFmlpb8OFCLwBC0uhIXqbVVV+BFNgn0R03yw5ihW9rFt
 tHkORT5ezVxf5R6TbJo90zeBsvQdroVrW7UGfXlsex8J1Vjq6SllThJ9BTmt5BeEiXBk
 axJg==
X-Gm-Message-State: ANhLgQ32brVchYYID/kJN2t91khCKqi4cZl0p02976mn4G6nvW88TIJi
 +1jdYH3NY0AiveEhPXuc073LCHoAhkc=
X-Google-Smtp-Source: ADFU+vsSW7bbPsLeiXqGzSw/FDnq6/ElQr5bLrccigvzc++Z332ucscmTP6Fn2jnKl20Ml/QMhCakw==
X-Received: by 2002:a65:6416:: with SMTP id a22mr9888215pgv.268.1584042174648; 
 Thu, 12 Mar 2020 12:42:54 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 25/42] target/arm: Implement helper_mte_check1
Date: Thu, 12 Mar 2020 12:42:02 -0700
Message-Id: <20200312194219.24406-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

Fill out the stub that was added earlier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h  |  47 +++++++++++++++
 target/arm/mte_helper.c | 126 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a993e8ca0a..8bbaf9b453 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1314,6 +1314,9 @@ FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ESIZE, 9, 5)
 FIELD(MTEDESC, TSIZE, 14, 10)  /* mte_checkN only */
 
+bool mte_probe1(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
+uint64_t mte_check1(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
+
 static inline int allocation_tag_from_addr(uint64_t ptr)
 {
     return extract64(ptr, 56, 4);
@@ -1324,4 +1327,48 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
     return deposit64(ptr, 56, 4, rtag);
 }
 
+/* Return true if tbi bits mean that the access is checked.  */
+static inline bool tbi_check(uint32_t desc, int bit55)
+{
+    return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
+}
+
+/* Return true if tcma bits mean that the access is unchecked.  */
+static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
+{
+    /*
+     * We had extracted bit55 and ptr_tag for other reasons, so fold
+     * (ptr<59:55> == 00000 || ptr<59:55> == 11111) into a single test.
+     */
+    bool match = ((ptr_tag + bit55) & 0xf) == 0;
+    bool tcma = (desc >> (R_MTEDESC_TCMA_SHIFT + bit55)) & 1;
+    return tcma && match;
+}
+
+/*
+ * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
+ * for the tag to be present in the FAR_ELx register.  But for user-only
+ * mode, we do not have a TLB with which to implement this, so we must
+ * remote the top byte.
+ */
+static inline uint64_t useronly_clean_ptr(uint64_t ptr)
+{
+    /* TBI is known to be enabled. */
+#ifdef CONFIG_USER_ONLY
+    ptr = sextract64(ptr, 0, 56);
+#endif
+    return ptr;
+}
+
+static inline uint64_t useronly_maybe_clean_ptr(uint32_t desc, uint64_t ptr)
+{
+#ifdef CONFIG_USER_ONLY
+    int64_t clean_ptr = sextract64(ptr, 0, 56);
+    if (tbi_check(desc, clean_ptr < 0)) {
+        ptr = clean_ptr;
+    }
+#endif
+    return ptr;
+}
+
 #endif
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 907a12b366..7a87574b35 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -359,12 +359,136 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
     }
 }
 
+/* Record a tag check failure.  */
+static void mte_check_fail(CPUARMState *env, int mmu_idx,
+                           uint64_t dirty_ptr, uintptr_t ra)
+{
+    ARMMMUIdx arm_mmu_idx = core_to_aa64_mmu_idx(mmu_idx);
+    int el, reg_el, tcf, select;
+    uint64_t sctlr;
+
+    reg_el = regime_el(env, arm_mmu_idx);
+    sctlr = env->cp15.sctlr_el[reg_el];
+
+    switch (arm_mmu_idx) {
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E20_0:
+        el = 0;
+        tcf = extract64(sctlr, 38, 2);
+        break;
+    default:
+        el = reg_el;
+        tcf = extract64(sctlr, 40, 2);
+    }
+
+    switch (tcf) {
+    case 1:
+        /*
+         * Tag check fail causes a synchronous exception.
+         *
+         * In restore_state_to_opc, we set the exception syndrome
+         * for the load or store operation.  Unwind first so we
+         * may overwrite that with the syndrome for the tag check.
+         */
+        cpu_restore_state(env_cpu(env), ra, true);
+        env->exception.vaddress = dirty_ptr;
+        raise_exception(env, EXCP_DATA_ABORT,
+                        syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, 0x11),
+                        exception_target_el(env));
+        /* noreturn, but fall through to the assert anyway */
+
+    case 0:
+        /*
+         * Tag check fail does not affect the PE.
+         * We eliminate this case by not setting MTE_ACTIVE
+         * in tb_flags, so that we never make this runtime call.
+         */
+        g_assert_not_reached();
+
+    case 2:
+        /* Tag check fail causes asynchronous flag set.  */
+        mmu_idx = arm_mmu_idx_el(env, el);
+        if (regime_has_2_ranges(mmu_idx)) {
+            select = extract64(dirty_ptr, 55, 1);
+        } else {
+            select = 0;
+        }
+        env->cp15.tfsr_el[el] |= 1 << select;
+        break;
+
+    default:
+        /* Case 3: Reserved. */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Tag check failure with SCTLR_EL%d.TCF%s "
+                      "set to reserved value %d\n",
+                      reg_el, el ? "" : "0", tcf);
+        break;
+    }
+}
+
 /*
  * Perform an MTE checked access for a single logical or atomic access.
  */
+static bool mte_probe1_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
+                           uintptr_t ra, int bit55)
+{
+    int mem_tag, mmu_idx, ptr_tag, size;
+    MMUAccessType type;
+    uint8_t *mem;
+
+    ptr_tag = allocation_tag_from_addr(ptr);
+
+    if (tcma_check(desc, bit55, ptr_tag)) {
+        return true;
+    }
+
+    mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+    type = FIELD_EX32(desc, MTEDESC, WRITE) ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    size = FIELD_EX32(desc, MTEDESC, ESIZE);
+
+    mem = allocation_tag_mem(env, mmu_idx, ptr, type, size,
+                             MMU_DATA_LOAD, 1, ra);
+    if (!mem) {
+        return true;
+    }
+
+    mem_tag = load_tag1(ptr, mem);
+    return ptr_tag == mem_tag;
+}
+
+/* No-fault version of mte_check1, to be used by SVE for MemSingleNF. */
+bool mte_probe1(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra)
+{
+    int bit55 = extract64(ptr, 55, 1);
+
+    /* If TBI is disabled, the access is unchecked. */
+    if (unlikely(!tbi_check(desc, bit55))) {
+        return true;
+    }
+
+    return mte_probe1_int(env, desc, ptr, ra, bit55);
+}
+
+uint64_t mte_check1(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra)
+{
+    int bit55 = extract64(ptr, 55, 1);
+
+    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
+    if (unlikely(!tbi_check(desc, bit55))) {
+        return ptr;
+    }
+
+    if (unlikely(!mte_probe1_int(env, desc, ptr, ra, bit55))) {
+        int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+        mte_check_fail(env, mmu_idx, ptr, ra);
+    }
+
+    return useronly_clean_ptr(ptr);
+}
+
 uint64_t HELPER(mte_check1)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 {
-    return ptr;
+    return mte_check1(env, desc, ptr, GETPC());
 }
 
 /*
-- 
2.20.1


