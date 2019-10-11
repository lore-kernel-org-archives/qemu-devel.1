Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65536C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDDB20673
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQe12jG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDDB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvSd-0000uG-KX
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJG-0005wE-Re
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJF-00043B-9v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:22 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:37192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJF-00042J-5Y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:21 -0400
Received: by mail-yb1-xb41.google.com with SMTP id z125so3119747ybc.4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FsDGTUNWhld8pKv/D95R5WX/niSk10RfgZKCNlYPPEU=;
 b=uQe12jG1RCJIbS4EA0C80B7C4smnmENpc+ZdK9Vpnmo+RtVfnTB5Suw7lzbPpN4x15
 VfbvKlgHiNHagpIphFFyumfE3OQqibLcWb/c85NxlODsQ0NkghJnAAAhDPI5/+cY+6yT
 NAL4POBBZLatnN2u1ZaQsEjlBFfhpElI3J7OZ1BRwnz6c6NPeZ3/97XEbWHt4AkJkUlk
 S6uUEck0K6ueteCTlKwPBtv2evnIWNN4x1TVDKG/rkaSPr4dUNO6Fng23p9z+POlfGa2
 J3JmoFgcgZiVMEowY18eSLEIpI5cYle2q2N4USD47H6ZcnqglOWUtxxbXWMtf/0uyBwe
 dvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FsDGTUNWhld8pKv/D95R5WX/niSk10RfgZKCNlYPPEU=;
 b=fY87nBbYH2hBoiWSzRjHHeLwPuQXJkJxSvJL7D1Zv5vAjn9CLsLPVQ1ZfCxen1I4eV
 aYimAq3G5mhHGYYg2A15P4bOHMdym8Q7P9XdENt5wU+73p5OeU/qZnUbn5lk+UApyy6N
 NO0lv6VJddJcmoLI1MPby0cK3rWe0MqR3ehA1Sf9myONImP9kPndsWrfspUZLVOKspPR
 mJzObq4cZlYsdTnW+CVGenR5ncOGQeID1mBnqKoYskuyhW3gc9apkNVe//5q98pmqdJa
 WlqvfukGI91Md8vUIi7tf5XeZom8vcHYvG60YkUNjbmrQxmQzoABZPNIZPisuMNvrw0u
 d20g==
X-Gm-Message-State: APjAAAVSeCMjpKlzH2lSuhvUw0wUTAGb6ACZFcoRMyhxuL/HhtOMXb9z
 Xf+rXwFMHIu+0Ok/lrQwJIKp+JBCujo=
X-Google-Smtp-Source: APXvYqwoX0PrNCRnmvyhd3qGlwanMrc0oKB59uM8rdmqmoYiGFPXmbIShjdnAmnMdb4hmjJcOO4rIA==
X-Received: by 2002:a25:d20f:: with SMTP id j15mr9913469ybg.174.1570801820185; 
 Fri, 11 Oct 2019 06:50:20 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/22] target/arm: Implement the LDGM and STGM instructions
Date: Fri, 11 Oct 2019 09:47:35 -0400
Message-Id: <20191011134744.2477-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Require pre-cleaned addresses.
---
 target/arm/helper-a64.h    |  3 ++
 target/arm/mte_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 42 +++++++++++++----
 3 files changed, 132 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 88a0241915..405aa60016 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -115,3 +115,6 @@ DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stzgm, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index f1dd1cc0dd..f1315bae37 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -414,3 +414,99 @@ void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 {
     do_st2g(env, ptr, xt, GETPC(), store_tag1_parallel);
 }
+
+uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
+{
+    const int size = 4 << GMID_EL1_BS;
+    int el;
+    uint64_t sctlr;
+    void *mem;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, size);
+
+    /* Trap if accessing an invalid page(s).  */
+    mem = allocation_tag_mem(env, ptr, false, GETPC());
+
+    /*
+     * The tag is squashed to zero if the page does not support tags,
+     * or if the OS is denying access to the tags.
+     */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
+        return 0;
+    }
+
+#if GMID_EL1_BS != 6
+# error "Fill in the blanks for other sizes"
+#endif
+    /*
+     * We are loading 64-bits worth of tags.  The ordering of elements
+     * within the word corresponds to a 64-bit little-endian operation.
+     */
+    return ldq_le_p(mem);
+}
+
+static uint64_t do_stgm(CPUARMState *env, uint64_t ptr,
+                        uint64_t val, uintptr_t ra)
+{
+    const int size = 4 << GMID_EL1_BS;
+    int el;
+    uint64_t sctlr;
+    void *mem;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, size);
+
+    /* Trap if accessing an invalid page(s).  */
+    mem = allocation_tag_mem(env, ptr, true, ra);
+
+    /*
+     * No action if the page does not support tags,
+     * or if the OS is denying access to the tags.
+     */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
+        return ptr;
+    }
+
+#if GMID_EL1_BS != 6
+# error "Fill in the blanks for other sizes"
+#endif
+    /*
+     * We are storing 64-bits worth of tags.  The ordering of elements
+     * within the word corresponds to a 64-bit little-endian operation.
+     */
+    stq_le_p(mem, val);
+
+    return ptr;
+}
+
+void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
+{
+    do_stgm(env, ptr, val, GETPC());
+}
+
+void HELPER(stzgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
+{
+    int i, mmu_idx, size = 4 << GMID_EL1_BS;
+    uintptr_t ra = GETPC();
+    void *mem;
+
+    ptr = do_stgm(env, ptr, val, ra);
+
+    /*
+     * We will have just probed this virtual address in do_stgm.
+     * If the tlb_vaddr_to_host fails, then the memory is not ram,
+     * or is monitored in some other way.  Fall back to stores.
+     */
+    mmu_idx = cpu_mmu_index(env, false);
+    mem = tlb_vaddr_to_host(env, ptr, MMU_DATA_STORE, mmu_idx);
+    if (mem) {
+        memset(mem, 0, size);
+    } else {
+        for (i = 0; i < size; i += 8) {
+            cpu_stq_data_ra(env, ptr + i, 0, ra);
+        }
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4ecb0a2fb7..4e049bb4aa 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3592,7 +3592,7 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
     int op2 = extract32(insn, 10, 3);
     int op1 = extract32(insn, 22, 2);
-    bool is_load = false, is_pair = false, is_zero = false;
+    bool is_load = false, is_pair = false, is_zero = false, is_mult = false;
     int index = 0;
     TCGv_i64 dirty_addr, clean_addr, tcg_rt;
 
@@ -3602,13 +3602,18 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     }
 
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
@@ -3624,17 +3629,27 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
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
@@ -3651,7 +3666,16 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     clean_addr = clean_data_tbi(s, dirty_addr, false);
     tcg_rt = cpu_reg(s, rt);
 
-    if (is_load) {
+    if (is_mult) {
+        if (is_load) {
+            gen_helper_ldgm(tcg_rt, cpu_env, clean_addr);
+        } else if (is_zero) {
+            gen_helper_stzgm(cpu_env, clean_addr, tcg_rt);
+        } else {
+            gen_helper_stgm(cpu_env, clean_addr, tcg_rt);
+        }
+        return;
+    } else if (is_load) {
         gen_helper_ldg(tcg_rt, cpu_env, clean_addr, tcg_rt);
     } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         if (is_pair) {
-- 
2.17.1


