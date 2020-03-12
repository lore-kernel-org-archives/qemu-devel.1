Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB0CC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707DC20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtRudqkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707DC20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTtN-0003ob-KV
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjI-0005d6-GJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjF-00028q-Lj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjF-00027o-EE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:49 -0400
Received: by mail-pg1-x542.google.com with SMTP id s2so3568531pgv.6
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FUO/6qc4Htz4N9YorwroOFAZWSwiCJ/idNRsOjS2/d8=;
 b=UtRudqkVsfteSSXAgitf/56/vSopMj4lUOqAN6wAY4Ww7Mtwr8Sj45v30zYlxApM0m
 xoccCsSG9ho/CQs0Jb7zyjyFBfmiVIsG9OS88ghSXZB00IzERsPpjUn7KoOy3RPzXE/j
 gTagKpgBiu3TpqcosR5Bxvi36T2jK5SZVDogfT49SRxsXX4cwhV65S2ZMSwEX7X7B1yt
 ZOQcPDARQ580/DYUw9GmMFeLHHeUoLxthsog5KmFsOPiEXPH9RHMSEpnZBY7W6FQHuLd
 HdTxWNXZ92/FkatEhwpjZzadlSF950xDDKRUHeb4ATYRaj2sPsfAIqpgGy+NWWhWqIr7
 LSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FUO/6qc4Htz4N9YorwroOFAZWSwiCJ/idNRsOjS2/d8=;
 b=Kft6PTKSFyLmMp3ETmO3oFUGmH7lpoQyrvgWxEeM78nYlRKnKv4Usc3dFdhc7Pm57u
 ybz5Or6LUUMDpTOqlFENfu2UT1h1aAL2x/WDzMaVHB/IvJPjnS12B43OEy4FFn/To6D/
 +aj5OF8lokKO/xYTVVjRQ6DuSfOZbgQn77PXQ0bE2YsNr+jVz3sQcPzRSAO7v3P3RDWp
 ym2dlcFDlUzO8ecE9Yt7Wb94+Po2U/j7F4gBPMXbZXLk6KY1PCMBhDSmYbFlbOSsWkYX
 ZIoYbRxTceBfgthIpkfsPpv7167zxNvOlRuhU3mVHHOszWPgup64Oh5B6vbiwKMRfzRS
 2peQ==
X-Gm-Message-State: ANhLgQ2ueWWb29AadYKKCekubCUBqxblmnQ8jaok5mw/UCHNayvDdetS
 u4REWwIk/Usdz6PuIDESq1/oaCe45jE=
X-Google-Smtp-Source: ADFU+vtTCDyCkaP7u990Rh530Kcc0gATmhJn0YIv9+Su6HdtJHbti1zovZvq1aq/9h9CqiQnpxuiEw==
X-Received: by 2002:a63:3f81:: with SMTP id m123mr9558730pga.335.1584042166879; 
 Thu, 12 Mar 2020 12:42:46 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 19/42] target/arm: Implement the LDGM, STGM,
 STZGM instructions
Date: Thu, 12 Mar 2020 12:41:56 -0700
Message-Id: <20200312194219.24406-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Require pre-cleaned addresses.
v6: Check full mte enabled.  Reorg the helpers.
---
 target/arm/helper-a64.h    |  3 ++
 target/arm/translate.h     |  2 +
 target/arm/mte_helper.c    | 84 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 74 +++++++++++++++++++++++++++++----
 4 files changed, 154 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 2fa61b86fa..7b628d100e 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -113,3 +113,6 @@ DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index e0f5d0be63..5552ee5a94 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -91,6 +91,8 @@ typedef struct DisasContext {
      *  < 0, set by the current instruction.
      */
     int8_t btype;
+    /* A copy of cpu->dcz_blocksize. */
+    uint8_t dcz_blocksize;
     /* True if this page is guarded.  */
     bool guarded_page;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 7ec7930dfc..27d4b4536c 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -274,3 +274,87 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
         probe_write(env, ptr + TAG_GRANULE, TAG_GRANULE, mmu_idx, ra);
     }
 }
+
+#define LDGM_STGM_SIZE  (4 << GMID_EL1_BS)
+
+uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    uintptr_t ra = GETPC();
+    void *tag_mem;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, LDGM_STGM_SIZE);
+
+    /* Trap if accessing an invalid page.  */
+    tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD,
+                                 LDGM_STGM_SIZE, MMU_DATA_LOAD,
+                                 LDGM_STGM_SIZE / (2 * TAG_GRANULE), ra);
+
+    /* The tag is squashed to zero if the page does not support tags.  */
+    if (!tag_mem) {
+        return 0;
+    }
+
+    QEMU_BUILD_BUG_ON(GMID_EL1_BS != 6);
+    /*
+     * We are loading 64-bits worth of tags.  The ordering of elements
+     * within the word corresponds to a 64-bit little-endian operation.
+     */
+    return ldq_le_p(tag_mem);
+}
+
+void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    uintptr_t ra = GETPC();
+    void *tag_mem;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, LDGM_STGM_SIZE);
+
+    /* Trap if accessing an invalid page.  */
+    tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                 LDGM_STGM_SIZE, MMU_DATA_LOAD,
+                                 LDGM_STGM_SIZE / (2 * TAG_GRANULE), ra);
+
+    /*
+     * Tag store only happens if the page support tags,
+     * and if the OS has enabled access to the tags.
+     */
+    if (!tag_mem) {
+        return;
+    }
+
+    QEMU_BUILD_BUG_ON(GMID_EL1_BS != 6);
+    /*
+     * We are storing 64-bits worth of tags.  The ordering of elements
+     * within the word corresponds to a 64-bit little-endian operation.
+     */
+    stq_le_p(tag_mem, val);
+}
+
+void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
+{
+    uintptr_t ra = GETPC();
+    int mmu_idx = cpu_mmu_index(env, false);
+    int log2_dcz_bytes, log2_tag_bytes;
+    intptr_t dcz_bytes, tag_bytes;
+    uint8_t *mem;
+
+    /*
+     * In arm_cpu_realizefn, we assert that dcz > LOG2_TAG_GRANULE+1,
+     * i.e. 32 bytes, which is an unreasonably small dcz anyway,
+     * to make sure that we can access one complete tag byte here.
+     */
+    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
+    log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
+    dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
+    tag_bytes = (intptr_t)1 << log2_tag_bytes;
+    ptr &= -dcz_bytes;
+
+    mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE, dcz_bytes,
+                             MMU_DATA_STORE, tag_bytes, ra);
+    if (mem) {
+        int tag_pair = (val & 0xf) * 0x11;
+        memset(mem, tag_pair, tag_bytes);
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 048140ddc0..f010aa2b58 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3781,7 +3781,7 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
     int op2 = extract32(insn, 10, 2);
     int op1 = extract32(insn, 22, 2);
-    bool is_load = false, is_pair = false, is_zero = false;
+    bool is_load = false, is_pair = false, is_zero = false, is_mult = false;
     int index = 0;
     TCGv_i64 addr, clean_addr, tcg_rt;
 
@@ -3797,13 +3797,18 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
      * > 0 : pre-index, writeback
      */
     switch (op1) {
-    case 0: /* STG */
+    case 0:
         if (op2 != 0) {
             /* STG */
             index = op2 - 2;
-            break;
+        } else {
+            /* STZGM */
+            if (s->current_el == 0 || offset != 0) {
+                goto do_unallocated;
+            }
+            is_mult = is_zero = true;
         }
-        goto do_unallocated;
+        break;
     case 1:
         if (op2 != 0) {
             /* STZG */
@@ -3819,17 +3824,27 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
             /* ST2G */
             is_pair = true;
             index = op2 - 2;
-            break;
+        } else {
+            /* STGM */
+            if (s->current_el == 0 || offset != 0) {
+                goto do_unallocated;
+            }
+            is_mult = true;
         }
-        goto do_unallocated;
+        break;
     case 3:
         if (op2 != 0) {
             /* STZ2G */
             is_pair = is_zero = true;
             index = op2 - 2;
-            break;
+        } else {
+            /* LDGM */
+            if (s->current_el == 0 || offset != 0) {
+                goto do_unallocated;
+            }
+            is_mult = is_load = true;
         }
-        goto do_unallocated;
+        break;
 
     default:
     do_unallocated:
@@ -3837,7 +3852,9 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
         return;
     }
 
-    if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
+    if (is_mult
+        ? !dc_isar_feature(aa64_mte, s)
+        : !dc_isar_feature(aa64_mte_insn_reg, s)) {
         goto do_unallocated;
     }
 
@@ -3851,6 +3868,44 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
         tcg_gen_addi_i64(addr, addr, offset);
     }
 
+    if (is_mult) {
+        tcg_rt = cpu_reg(s, rt);
+
+        if (is_zero) {
+            int size = 4 << s->dcz_blocksize;
+
+            if (s->ata) {
+                gen_helper_stzgm_tags(cpu_env, addr, tcg_rt);
+            }
+            /*
+             * The non-tags portion of STZGM is mostly like DC_ZVA,
+             * except the alignment happens before the access.
+             */
+            clean_addr = clean_data_tbi(s, addr);
+            tcg_gen_andi_i64(clean_addr, clean_addr, -size);
+            gen_helper_dc_zva(cpu_env, clean_addr);
+        } else if (s->ata) {
+            if (is_load) {
+                gen_helper_ldgm(tcg_rt, cpu_env, addr);
+            } else {
+                gen_helper_stgm(cpu_env, addr, tcg_rt);
+            }
+        } else {
+            MMUAccessType acc = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
+            int size = 4 << GMID_EL1_BS;
+
+            clean_addr = clean_data_tbi(s, addr);
+            tcg_gen_andi_i64(clean_addr, clean_addr, -size);
+            gen_probe_access(s, clean_addr, acc, size);
+
+            if (is_load) {
+                /* The result tags are zeros.  */
+                tcg_gen_movi_i64(tcg_rt, 0);
+            }
+        }
+        return;
+    }
+
     if (is_load) {
         tcg_rt = cpu_reg(s, rt);
         if (s->ata) {
@@ -14623,6 +14678,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
     dc->features = env->features;
+    dc->dcz_blocksize = arm_cpu->dcz_blocksize;
 
     /* Single step state. The code-generation logic here is:
      *  SS_ACTIVE == 0:
-- 
2.20.1


