Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759FBC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCD0206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwp8+Qu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCD0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvPd-0005UC-Sv
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJE-0005rz-T0
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJC-00040l-VG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:20 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:33851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJC-00040B-PW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:18 -0400
Received: by mail-yw1-xc44.google.com with SMTP id d192so3502414ywa.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gkEtlZocr6O/mWH7/aygI9iXL6Dz4HHREZjJWg4Qrng=;
 b=wwp8+Qu6RGOlIFhs6T/cduZ9+7xx7QHuofeIZykJOyjRtvAulxMJS6WRUBoHax4XQI
 n8ULfE+TwkRXbgtJJ0mgtDbEz0nNOSDGAEY3ncYQgB7fpglyxpC9vsS9j8skLu5PcDMU
 opobpojpG7J9aGtRcVBjn/vDpUQcQSzzqlodm5U0PEqs8c/V9B1ay7FB3QA+2syhA5KJ
 JAqssTbx5Kc1shhhCms50O+l0w2wYpmVMnblf0Vq88lMpbi/OZKXPC8bxq6rJlyjO30x
 NKNHtoAgoi0Pn1d6fFBqsRIX+pMJ/G9Z/7iPcndCGlnhSHT4hK9pnnZfgBEDhs0hWm1D
 5AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gkEtlZocr6O/mWH7/aygI9iXL6Dz4HHREZjJWg4Qrng=;
 b=Wy0x9pBm48RB0aoNkGYm57v3XcZSVIRLrI0VpCJFGNi8WbrFG3VKOyHqB4lgYDICjM
 X90lNgDglBkyXcVKuqgFcLqNrtlDQmCsiWph4F04XFk3P/ilmAH0FJes8MGGrkfAjAm1
 rrWBcj9UTF+NM7PUpRyTrmgqApGdWuPB6smbzb8ABTPqdrx69Qy0WhMrSlL03UuNFcul
 dyemoBzZ55qiaes3KnFc/rqkebHglsuY9lWnPVHTXP+bu8MMapU/53VX+v1wBDSuBKwH
 aaSLbJ+ALpdh7EeyWuAPpaBOcE9NSCbAJMMnCKzfUhBl+l/1se9NcPm9h3kjnPXu+3Hm
 NdGA==
X-Gm-Message-State: APjAAAWMzfoPJmfEjubh6ZX2rtdk0yP6oWwUD14IHGE+y1t4xsEYeohB
 vmr8bnXgr/4iPqUZYybFM4+0RZcBHfw=
X-Google-Smtp-Source: APXvYqxgVb2EzfAdw1GLbaCMBKbtUppFiMwhWjS6LeFIdIIaKmJce+8RIIwAOj+Gs3ku1d3LuWatPA==
X-Received: by 2002:a81:6ac6:: with SMTP id f189mr2154219ywc.469.1570801817716; 
 Fri, 11 Oct 2019 06:50:17 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/22] target/arm: Implement LDG, STG, ST2G instructions
Date: Fri, 11 Oct 2019 09:47:33 -0400
Message-Id: <20191011134744.2477-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
v2: Split out allocation_tag_mem.  Handle atomicity of stores.
v3: Add X[t] input to these insns; require pre-cleaned addresses.
v5: Fix !32-byte aligned operation of st2g.
---
 target/arm/helper-a64.h    |   5 ++
 target/arm/mte_helper.c    | 154 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 115 +++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 31f848ca03..88a0241915 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -110,3 +110,8 @@ DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_2(gmi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 251dfff1e1..f1dd1cc0dd 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -25,8 +25,21 @@
 #include "exec/helper-proto.h"
 
 
+static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
+                                   bool write, uintptr_t ra)
+{
+    /* Tag storage not implemented.  */
+    return NULL;
+}
+
 static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
 {
+    uint8_t *mem = allocation_tag_mem(env, ptr, false, ra);
+
+    if (mem) {
+        int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+        return extract32(atomic_read(mem), ofs, 4);
+    }
     /* Tag storage not implemented.  */
     return -1;
 }
@@ -260,3 +273,144 @@ uint64_t HELPER(gmi)(uint64_t ptr, uint64_t mask)
     int tag = allocation_tag_from_addr(ptr);
     return mask | (1ULL << tag);
 }
+
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    int el;
+    uint64_t sctlr;
+    int rtag;
+
+    /* Trap if accessing an invalid page.  */
+    rtag = get_allocation_tag(env, ptr, GETPC());
+
+    /*
+     * The tag is squashed to zero if the page does not support tags,
+     * or if the OS is denying access to the tags.
+     */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (rtag < 0 || !allocation_tag_access_enabled(env, el, sctlr)) {
+        rtag = 0;
+    }
+
+    return address_with_allocation_tag(xt, rtag);
+}
+
+static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
+{
+    if (unlikely(!QEMU_IS_ALIGNED(ptr, TAG_GRANULE))) {
+        arm_cpu_do_unaligned_access(env_cpu(env), ptr, MMU_DATA_STORE,
+                                    cpu_mmu_index(env, false), ra);
+        g_assert_not_reached();
+    }
+}
+
+/* For use in a non-parallel context, store to the given nibble.  */
+static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    uint8_t old = atomic_read(mem);
+    uint8_t new = deposit32(old, ofs, 4, tag);
+
+    atomic_set(mem, new);
+}
+
+/* For use in a parallel context, atomically store to the given nibble.  */
+static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    uint8_t old = atomic_read(mem);
+
+    while (1) {
+        uint8_t new = deposit32(old, ofs, 4, tag);
+        uint8_t cmp = atomic_cmpxchg(mem, old, new);
+        if (likely(cmp == old)) {
+            return;
+        }
+        old = cmp;
+    }
+}
+
+typedef void stg_store1(uint64_t, uint8_t *, int);
+
+static void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
+                   uintptr_t ra, stg_store1 store1)
+{
+    int el;
+    uint64_t sctlr;
+    uint8_t *mem;
+
+    check_tag_aligned(env, ptr, ra);
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, ptr, true, ra);
+
+    /* Store if page supports tags and access is enabled.  */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (mem && allocation_tag_access_enabled(env, el, sctlr)) {
+        store1(ptr, mem, allocation_tag_from_addr(xt));
+    }
+}
+
+void HELPER(stg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_stg(env, ptr, xt, GETPC(), store_tag1);
+}
+
+void HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_stg(env, ptr, xt, GETPC(), store_tag1_parallel);
+}
+
+static void do_st2g(CPUARMState *env, uint64_t ptr1, uint64_t xt,
+                    uintptr_t ra, stg_store1 store1)
+{
+    int el, tag;
+    uint64_t ptr2, sctlr;
+    uint8_t *mem1, *mem2;
+
+    check_tag_aligned(env, ptr1, ra);
+
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    tag = allocation_tag_from_addr(xt);
+
+    /*
+     * Trap if accessing an invalid page(s).
+     * This takes priority over !allocation_tag_access_enabled.
+     */
+    mem1 = allocation_tag_mem(env, ptr1, true, ra);
+
+    if (ptr1 & TAG_GRANULE) {
+        /* The two stores are unaligned and modify two bytes.  */
+        ptr2 = ptr1 + TAG_GRANULE;
+        mem2 = allocation_tag_mem(env, ptr2, true, ra);
+
+        /* Store if page supports tags and access is enabled.  */
+        if ((mem1 || mem2) && allocation_tag_access_enabled(env, el, sctlr)) {
+            if (mem1) {
+                store1(ptr1, mem1, tag);
+            }
+            if (mem2) {
+                store1(ptr2, mem2, tag);
+            }
+        }
+    } else {
+        /* The two stores are aligned 32, and modify one byte.  */
+        if (mem1 && allocation_tag_access_enabled(env, el, sctlr)) {
+            tag |= tag << 4;
+            atomic_set(mem1, tag);
+        }
+    }
+}
+
+void HELPER(st2g)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_st2g(env, ptr, xt, GETPC(), store_tag1);
+}
+
+void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_st2g(env, ptr, xt, GETPC(), store_tag1_parallel);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index cf341c98d3..c17b36ebb2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3559,6 +3559,118 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     }
 }
 
+/*
+ * Load/Store memory tags
+ *
+ *  31 30 29         24     22  21     12    10      5      0
+ * +-----+-------------+-----+---+------+-----+------+------+
+ * | 1 1 | 0 1 1 0 0 1 | op1 | 1 | imm9 | op2 |  Rn  |  Rt  |
+ * +-----+-------------+-----+---+------+-----+------+------+
+ */
+static void disas_ldst_tag(DisasContext *s, uint32_t insn)
+{
+    int rt = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
+    int op2 = extract32(insn, 10, 3);
+    int op1 = extract32(insn, 22, 2);
+    bool is_load = false, is_pair = false, is_zero = false;
+    int index = 0;
+    TCGv_i64 dirty_addr, clean_addr, tcg_rt;
+
+    if ((insn & 0xff200000) != 0xd9200000
+        || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+        goto do_unallocated;
+    }
+
+    switch (op1) {
+    case 0: /* STG */
+        if (op2 != 0) {
+            /* STG */
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+    case 1:
+        if (op2 != 0) {
+            /* STZG */
+            is_zero = true;
+            index = op2 - 2;
+        } else {
+            /* LDG */
+            is_load = true;
+        }
+        break;
+    case 2:
+        if (op2 != 0) {
+            /* ST2G */
+            is_pair = true;
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+    case 3:
+        if (op2 != 0) {
+            /* STZ2G */
+            is_pair = is_zero = true;
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+
+    default:
+    do_unallocated:
+        unallocated_encoding(s);
+        return;
+    }
+
+    dirty_addr = read_cpu_reg_sp(s, rn, true);
+    if (index <= 0) {
+        /* pre-index or signed offset */
+        tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+    }
+
+    clean_addr = clean_data_tbi(s, dirty_addr, false);
+    tcg_rt = cpu_reg(s, rt);
+
+    if (is_load) {
+        gen_helper_ldg(tcg_rt, cpu_env, clean_addr, tcg_rt);
+    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        if (is_pair) {
+            gen_helper_st2g_parallel(cpu_env, clean_addr, tcg_rt);
+        } else {
+            gen_helper_stg_parallel(cpu_env, clean_addr, tcg_rt);
+        }
+    } else {
+        if (is_pair) {
+            gen_helper_st2g(cpu_env, clean_addr, tcg_rt);
+        } else {
+            gen_helper_stg(cpu_env, clean_addr, tcg_rt);
+        }
+    }
+
+    if (is_zero) {
+        TCGv_i64 tcg_zero = tcg_const_i64(0);
+        int mem_index = get_mem_index(s);
+        int i, n = (1 + is_pair) << LOG2_TAG_GRANULE;
+
+        for (i = 0; i < n; i += 8) {
+            tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index, MO_Q);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+        }
+        tcg_temp_free_i64(tcg_zero);
+    }
+
+    if (index != 0) {
+        /* pre-index or post-index */
+        if (index > 0) {
+            /* post-index */
+            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+        }
+        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
+    }
+}
+
 /* Loads and stores */
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
@@ -3583,6 +3695,9 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     case 0x0d: /* AdvSIMD load/store single structure */
         disas_ldst_single_struct(s, insn);
         break;
+    case 0x19: /* Load/store tag */
+        disas_ldst_tag(s, insn);
+        break;
     default:
         unallocated_encoding(s);
         break;
-- 
2.17.1


