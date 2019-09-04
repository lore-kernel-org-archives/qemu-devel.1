Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3176321726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfgKSfr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3176321726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bJE-0007lt-VW
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0B-0004i8-7e
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b04-0002P5-Nq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b04-0002O8-BS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id h195so7359983pfe.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a8H4t27w6832KquvYvlu5uopeAI47LGitZ7EzlLFkOY=;
 b=NfgKSfr30UVlZsAsO7kQDHIybDb1eLk3tQD4LH3hVMSIExUj2PLVVooVOb439LbI23
 z9z2WRzW1awPFnkPC+hbRnHV+x8pgTT/ZSxlfj1Ju3MNBxoESMRFSf3FM0bXaELGxita
 /vHscm3GIauX00la+urW3iNFWlUP2l9zeMKB2HRgavPAVjJrhhgJWsFBDoD+hsGlUppY
 PI/q9oiD7qbqz0UvPBAxQ3VP2rul7Z1FkHGIMByUs/q3sZt9C1erTsAsFTDWezNx76G0
 /IrazxRH0l2CjsjgVEn2SXxbfvPy2PPDBS/CYsGaV8HyLoCk2RwDqxZIoU/gUC0zbh01
 C/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=a8H4t27w6832KquvYvlu5uopeAI47LGitZ7EzlLFkOY=;
 b=EF0H1CGxb0lGPdyPKLz2if2GGYeAObtdqhgdwZWFOjtFTpuW/43qSD1H6pvJCaag72
 X62PYwrncxsZfOYvwNaVFh/F2BOplrb83+M6gnYIrnb6uSLZtc2JL8yVJQYVkoCzsDbm
 7mEpbwJsXxIEdUcrxOxopyf7AaTEVXp3OxsPjpuUOf/JYUkKNwWkG0DOPx+1Xw2C2Xwk
 n0hjfjg25iS51DuL8s3OaBjBnaazuoBxFNlGXCS6krk1NqHIj3zzHZ2HQEiGNhIW7ZXa
 Os2UNfDI2+n95ehDwMwFUmD6bUibYZYfvt9nzdRqftukUNCGay16Qj/oa9yxM+wNL+Am
 3yJg==
X-Gm-Message-State: APjAAAWLGcmSEQxA+RrbGzcpHGcQVCQYfGxyEq0hYWJAfOOZdovq2OjL
 uiz388GrxqG0tlN4gG27xh+xhvjpPdU=
X-Google-Smtp-Source: APXvYqypjhhoC4cSeN2SpoNvsh+1vsCJlB9NNMe9naO5cDwIBKowdI+MQc18WHKRmwBaPzdyVuDO7g==
X-Received: by 2002:a63:b346:: with SMTP id x6mr36947032pgt.218.1567625486149; 
 Wed, 04 Sep 2019 12:31:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:10 -0700
Message-Id: <20190904193059.26202-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 20/69] target/arm: Convert load/store
 (register, immediate, literal)
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use unallocated_encoding for RT odd
---
 target/arm/translate.c | 805 ++++++++++++++++++-----------------------
 target/arm/a32.decode  | 120 ++++++
 target/arm/t32.decode  | 141 ++++++++
 3 files changed, 623 insertions(+), 443 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7d12be4025..d383a16f4b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1265,62 +1265,6 @@ static inline void gen_hlt(DisasContext *s, int imm)
     unallocated_encoding(s);
 }
 
-static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
-                                       TCGv_i32 var)
-{
-    int val, rm, shift, shiftop;
-    TCGv_i32 offset;
-
-    if (!(insn & (1 << 25))) {
-        /* immediate */
-        val = insn & 0xfff;
-        if (!(insn & (1 << 23)))
-            val = -val;
-        if (val != 0)
-            tcg_gen_addi_i32(var, var, val);
-    } else {
-        /* shift/register */
-        rm = (insn) & 0xf;
-        shift = (insn >> 7) & 0x1f;
-        shiftop = (insn >> 5) & 3;
-        offset = load_reg(s, rm);
-        gen_arm_shift_im(offset, shiftop, shift, 0);
-        if (!(insn & (1 << 23)))
-            tcg_gen_sub_i32(var, var, offset);
-        else
-            tcg_gen_add_i32(var, var, offset);
-        tcg_temp_free_i32(offset);
-    }
-}
-
-static inline void gen_add_datah_offset(DisasContext *s, unsigned int insn,
-                                        int extra, TCGv_i32 var)
-{
-    int val, rm;
-    TCGv_i32 offset;
-
-    if (insn & (1 << 22)) {
-        /* immediate */
-        val = (insn & 0xf) | ((insn >> 4) & 0xf0);
-        if (!(insn & (1 << 23)))
-            val = -val;
-        val += extra;
-        if (val != 0)
-            tcg_gen_addi_i32(var, var, val);
-    } else {
-        /* register */
-        if (extra)
-            tcg_gen_addi_i32(var, var, extra);
-        rm = (insn) & 0xf;
-        offset = load_reg(s, rm);
-        if (!(insn & (1 << 23)))
-            tcg_gen_sub_i32(var, var, offset);
-        else
-            tcg_gen_add_i32(var, var, offset);
-        tcg_temp_free_i32(offset);
-    }
-}
-
 static TCGv_ptr get_fpstatus_ptr(int neon)
 {
     TCGv_ptr statusptr = tcg_temp_new_ptr();
@@ -7658,6 +7602,11 @@ static int times_2(DisasContext *s, int x)
     return x * 2;
 }
 
+static int times_4(DisasContext *s, int x)
+{
+    return x * 4;
+}
+
 /* Return only the rotation part of T32ExpandImm.  */
 static int t32_expandimm_rot(DisasContext *s, int x)
 {
@@ -8576,6 +8525,353 @@ static bool trans_SMC(DisasContext *s, arg_SMC *a)
     return true;
 }
 
+/*
+ * Load/store register index
+ */
+
+static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
+{
+    ISSInfo ret;
+
+    /* ISS not valid if writeback */
+    if (p && !w) {
+        ret = rd;
+    } else {
+        ret = ISSInvalid;
+    }
+    return ret;
+}
+
+static TCGv_i32 op_addr_rr_pre(DisasContext *s, arg_ldst_rr *a)
+{
+    TCGv_i32 addr = load_reg(s, a->rn);
+
+    if (s->v8m_stackcheck && a->rn == 13 && a->w) {
+        gen_helper_v8m_stackcheck(cpu_env, addr);
+    }
+
+    if (a->p) {
+        TCGv_i32 ofs = load_reg(s, a->rm);
+        gen_arm_shift_im(ofs, a->shtype, a->shimm, 0);
+        if (a->u) {
+            tcg_gen_add_i32(addr, addr, ofs);
+        } else {
+            tcg_gen_sub_i32(addr, addr, ofs);
+        }
+        tcg_temp_free_i32(ofs);
+    }
+    return addr;
+}
+
+static void op_addr_rr_post(DisasContext *s, arg_ldst_rr *a,
+                            TCGv_i32 addr, int address_offset)
+{
+    if (!a->p) {
+        TCGv_i32 ofs = load_reg(s, a->rm);
+        gen_arm_shift_im(ofs, a->shtype, a->shimm, 0);
+        if (a->u) {
+            tcg_gen_add_i32(addr, addr, ofs);
+        } else {
+            tcg_gen_sub_i32(addr, addr, ofs);
+        }
+        tcg_temp_free_i32(ofs);
+    } else if (!a->w) {
+        tcg_temp_free_i32(addr);
+        return;
+    }
+    tcg_gen_addi_i32(addr, addr, address_offset);
+    store_reg(s, a->rn, addr);
+}
+
+static bool op_load_rr(DisasContext *s, arg_ldst_rr *a,
+                       MemOp mop, int mem_idx)
+{
+    ISSInfo issinfo = make_issinfo(s, a->rt, a->p, a->w);
+    TCGv_i32 addr, tmp;
+
+    addr = op_addr_rr_pre(s, a);
+
+    tmp = tcg_temp_new_i32();
+    gen_aa32_ld_i32(s, tmp, addr, mem_idx, mop | s->be_data);
+    disas_set_da_iss(s, mop, issinfo);
+
+    /*
+     * Perform base writeback before the loaded value to
+     * ensure correct behavior with overlapping index registers.
+     */
+    op_addr_rr_post(s, a, addr, 0);
+    store_reg_from_load(s, a->rt, tmp);
+    return true;
+}
+
+static bool op_store_rr(DisasContext *s, arg_ldst_rr *a,
+                        MemOp mop, int mem_idx)
+{
+    ISSInfo issinfo = make_issinfo(s, a->rt, a->p, a->w) | ISSIsWrite;
+    TCGv_i32 addr, tmp;
+
+    addr = op_addr_rr_pre(s, a);
+
+    tmp = load_reg(s, a->rt);
+    gen_aa32_st_i32(s, tmp, addr, mem_idx, mop | s->be_data);
+    disas_set_da_iss(s, mop, issinfo);
+    tcg_temp_free_i32(tmp);
+
+    op_addr_rr_post(s, a, addr, 0);
+    return true;
+}
+
+static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
+{
+    int mem_idx = get_mem_index(s);
+    TCGv_i32 addr, tmp;
+
+    if (!ENABLE_ARCH_5TE) {
+        return false;
+    }
+    if (a->rt & 1) {
+        unallocated_encoding(s);
+        return true;
+    }
+    addr = op_addr_rr_pre(s, a);
+
+    tmp = tcg_temp_new_i32();
+    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    store_reg(s, a->rt, tmp);
+
+    tcg_gen_addi_i32(addr, addr, 4);
+
+    tmp = tcg_temp_new_i32();
+    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    store_reg(s, a->rt + 1, tmp);
+
+    /* LDRD w/ base writeback is undefined if the registers overlap.  */
+    op_addr_rr_post(s, a, addr, -4);
+    return true;
+}
+
+static bool trans_STRD_rr(DisasContext *s, arg_ldst_rr *a)
+{
+    int mem_idx = get_mem_index(s);
+    TCGv_i32 addr, tmp;
+
+    if (!ENABLE_ARCH_5TE) {
+        return false;
+    }
+    if (a->rt & 1) {
+        unallocated_encoding(s);
+        return true;
+    }
+    addr = op_addr_rr_pre(s, a);
+
+    tmp = load_reg(s, a->rt);
+    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    tcg_temp_free_i32(tmp);
+
+    tcg_gen_addi_i32(addr, addr, 4);
+
+    tmp = load_reg(s, a->rt + 1);
+    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    tcg_temp_free_i32(tmp);
+
+    op_addr_rr_post(s, a, addr, -4);
+    return true;
+}
+
+/*
+ * Load/store immediate index
+ */
+
+static TCGv_i32 op_addr_ri_pre(DisasContext *s, arg_ldst_ri *a)
+{
+    int ofs = a->imm;
+
+    if (!a->u) {
+        ofs = -ofs;
+    }
+
+    if (s->v8m_stackcheck && a->rn == 13 && a->w) {
+        /*
+         * Stackcheck. Here we know 'addr' is the current SP;
+         * U is set if we're moving SP up, else down. It is
+         * UNKNOWN whether the limit check triggers when SP starts
+         * below the limit and ends up above it; we chose to do so.
+         */
+        if (!a->u) {
+            TCGv_i32 newsp = tcg_temp_new_i32();
+            tcg_gen_addi_i32(newsp, cpu_R[13], ofs);
+            gen_helper_v8m_stackcheck(cpu_env, newsp);
+            tcg_temp_free_i32(newsp);
+        } else {
+            gen_helper_v8m_stackcheck(cpu_env, cpu_R[13]);
+        }
+    }
+
+    return add_reg_for_lit(s, a->rn, a->p ? ofs : 0);
+}
+
+static void op_addr_ri_post(DisasContext *s, arg_ldst_ri *a,
+                            TCGv_i32 addr, int address_offset)
+{
+    if (!a->p) {
+        if (a->u) {
+            address_offset += a->imm;
+        } else {
+            address_offset -= a->imm;
+        }
+    } else if (!a->w) {
+        tcg_temp_free_i32(addr);
+        return;
+    }
+    tcg_gen_addi_i32(addr, addr, address_offset);
+    store_reg(s, a->rn, addr);
+}
+
+static bool op_load_ri(DisasContext *s, arg_ldst_ri *a,
+                       MemOp mop, int mem_idx)
+{
+    ISSInfo issinfo = make_issinfo(s, a->rt, a->p, a->w);
+    TCGv_i32 addr, tmp;
+
+    addr = op_addr_ri_pre(s, a);
+
+    tmp = tcg_temp_new_i32();
+    gen_aa32_ld_i32(s, tmp, addr, mem_idx, mop | s->be_data);
+    disas_set_da_iss(s, mop, issinfo);
+
+    /*
+     * Perform base writeback before the loaded value to
+     * ensure correct behavior with overlapping index registers.
+     */
+    op_addr_ri_post(s, a, addr, 0);
+    store_reg_from_load(s, a->rt, tmp);
+    return true;
+}
+
+static bool op_store_ri(DisasContext *s, arg_ldst_ri *a,
+                        MemOp mop, int mem_idx)
+{
+    ISSInfo issinfo = make_issinfo(s, a->rt, a->p, a->w) | ISSIsWrite;
+    TCGv_i32 addr, tmp;
+
+    addr = op_addr_ri_pre(s, a);
+
+    tmp = load_reg(s, a->rt);
+    gen_aa32_st_i32(s, tmp, addr, mem_idx, mop | s->be_data);
+    disas_set_da_iss(s, mop, issinfo);
+    tcg_temp_free_i32(tmp);
+
+    op_addr_ri_post(s, a, addr, 0);
+    return true;
+}
+
+static bool op_ldrd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
+{
+    int mem_idx = get_mem_index(s);
+    TCGv_i32 addr, tmp;
+
+    addr = op_addr_ri_pre(s, a);
+
+    tmp = tcg_temp_new_i32();
+    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    store_reg(s, a->rt, tmp);
+
+    tcg_gen_addi_i32(addr, addr, 4);
+
+    tmp = tcg_temp_new_i32();
+    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    store_reg(s, rt2, tmp);
+
+    /* LDRD w/ base writeback is undefined if the registers overlap.  */
+    op_addr_ri_post(s, a, addr, -4);
+    return true;
+}
+
+static bool trans_LDRD_ri_a32(DisasContext *s, arg_ldst_ri *a)
+{
+    if (!ENABLE_ARCH_5TE || (a->rt & 1)) {
+        return false;
+    }
+    return op_ldrd_ri(s, a, a->rt + 1);
+}
+
+static bool trans_LDRD_ri_t32(DisasContext *s, arg_ldst_ri2 *a)
+{
+    arg_ldst_ri b = {
+        .u = a->u, .w = a->w, .p = a->p,
+        .rn = a->rn, .rt = a->rt, .imm = a->imm
+    };
+    return op_ldrd_ri(s, &b, a->rt2);
+}
+
+static bool op_strd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
+{
+    int mem_idx = get_mem_index(s);
+    TCGv_i32 addr, tmp;
+
+    addr = op_addr_ri_pre(s, a);
+
+    tmp = load_reg(s, a->rt);
+    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    tcg_temp_free_i32(tmp);
+
+    tcg_gen_addi_i32(addr, addr, 4);
+
+    tmp = load_reg(s, rt2);
+    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | s->be_data);
+    tcg_temp_free_i32(tmp);
+
+    op_addr_ri_post(s, a, addr, -4);
+    return true;
+}
+
+static bool trans_STRD_ri_a32(DisasContext *s, arg_ldst_ri *a)
+{
+    if (!ENABLE_ARCH_5TE || (a->rt & 1)) {
+        return false;
+    }
+    return op_strd_ri(s, a, a->rt + 1);
+}
+
+static bool trans_STRD_ri_t32(DisasContext *s, arg_ldst_ri2 *a)
+{
+    arg_ldst_ri b = {
+        .u = a->u, .w = a->w, .p = a->p,
+        .rn = a->rn, .rt = a->rt, .imm = a->imm
+    };
+    return op_strd_ri(s, &b, a->rt2);
+}
+
+#define DO_LDST(NAME, WHICH, MEMOP) \
+static bool trans_##NAME##_ri(DisasContext *s, arg_ldst_ri *a)        \
+{                                                                     \
+    return op_##WHICH##_ri(s, a, MEMOP, get_mem_index(s));            \
+}                                                                     \
+static bool trans_##NAME##T_ri(DisasContext *s, arg_ldst_ri *a)       \
+{                                                                     \
+    return op_##WHICH##_ri(s, a, MEMOP, get_a32_user_mem_index(s));   \
+}                                                                     \
+static bool trans_##NAME##_rr(DisasContext *s, arg_ldst_rr *a)        \
+{                                                                     \
+    return op_##WHICH##_rr(s, a, MEMOP, get_mem_index(s));            \
+}                                                                     \
+static bool trans_##NAME##T_rr(DisasContext *s, arg_ldst_rr *a)       \
+{                                                                     \
+    return op_##WHICH##_rr(s, a, MEMOP, get_a32_user_mem_index(s));   \
+}
+
+DO_LDST(LDR, load, MO_UL)
+DO_LDST(LDRB, load, MO_UB)
+DO_LDST(LDRH, load, MO_UW)
+DO_LDST(LDRSB, load, MO_SB)
+DO_LDST(LDRSH, load, MO_SW)
+
+DO_LDST(STR, store, MO_UL)
+DO_LDST(STRB, store, MO_UB)
+DO_LDST(STRH, store, MO_UW)
+
+#undef DO_LDST
+
 /*
  * Legacy decoder.
  */
@@ -9033,100 +9329,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                 }
             } else {
-                int address_offset;
-                bool load = insn & (1 << 20);
-                bool wbit = insn & (1 << 21);
-                bool pbit = insn & (1 << 24);
-                bool doubleword = false;
-                ISSInfo issinfo;
-
-                /* Misc load/store */
-                rn = (insn >> 16) & 0xf;
-                rd = (insn >> 12) & 0xf;
-
-                /* ISS not valid if writeback */
-                issinfo = (pbit & !wbit) ? rd : ISSInvalid;
-
-                if (!load && (sh & 2)) {
-                    /* doubleword */
-                    ARCH(5TE);
-                    if (rd & 1) {
-                        /* UNPREDICTABLE; we choose to UNDEF */
-                        goto illegal_op;
-                    }
-                    load = (sh & 1) == 0;
-                    doubleword = true;
-                }
-
-                addr = load_reg(s, rn);
-                if (pbit) {
-                    gen_add_datah_offset(s, insn, 0, addr);
-                }
-                address_offset = 0;
-
-                if (doubleword) {
-                    if (!load) {
-                        /* store */
-                        tmp = load_reg(s, rd);
-                        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                        tcg_temp_free_i32(tmp);
-                        tcg_gen_addi_i32(addr, addr, 4);
-                        tmp = load_reg(s, rd + 1);
-                        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                        tcg_temp_free_i32(tmp);
-                    } else {
-                        /* load */
-                        tmp = tcg_temp_new_i32();
-                        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        store_reg(s, rd, tmp);
-                        tcg_gen_addi_i32(addr, addr, 4);
-                        tmp = tcg_temp_new_i32();
-                        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        rd++;
-                    }
-                    address_offset = -4;
-                } else if (load) {
-                    /* load */
-                    tmp = tcg_temp_new_i32();
-                    switch (sh) {
-                    case 1:
-                        gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s),
-                                           issinfo);
-                        break;
-                    case 2:
-                        gen_aa32_ld8s_iss(s, tmp, addr, get_mem_index(s),
-                                          issinfo);
-                        break;
-                    default:
-                    case 3:
-                        gen_aa32_ld16s_iss(s, tmp, addr, get_mem_index(s),
-                                           issinfo);
-                        break;
-                    }
-                } else {
-                    /* store */
-                    tmp = load_reg(s, rd);
-                    gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s), issinfo);
-                    tcg_temp_free_i32(tmp);
-                }
-                /* Perform base writeback before the loaded value to
-                   ensure correct behavior with overlapping index registers.
-                   ldrd with base writeback is undefined if the
-                   destination and index registers overlap.  */
-                if (!pbit) {
-                    gen_add_datah_offset(s, insn, address_offset, addr);
-                    store_reg(s, rn, addr);
-                } else if (wbit) {
-                    if (address_offset)
-                        tcg_gen_addi_i32(addr, addr, address_offset);
-                    store_reg(s, rn, addr);
-                } else {
-                    tcg_temp_free_i32(addr);
-                }
-                if (load) {
-                    /* Complete the load.  */
-                    store_reg(s, rd, tmp);
-                }
+                /* Extra load/store (register) instructions */
+                /* All done in decodetree.  Reach here for illegal ops.  */
+                goto illegal_op;
             }
             break;
         case 0x4:
@@ -9443,58 +9648,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 break;
             }
         do_ldst:
-            /* Check for undefined extension instructions
-             * per the ARM Bible IE:
-             * xxxx 0111 1111 xxxx  xxxx xxxx 1111 xxxx
-             */
-            sh = (0xf << 20) | (0xf << 4);
-            if (op1 == 0x7 && ((insn & sh) == sh))
-            {
-                goto illegal_op;
-            }
-            /* load/store byte/word */
-            rn = (insn >> 16) & 0xf;
-            rd = (insn >> 12) & 0xf;
-            tmp2 = load_reg(s, rn);
-            if ((insn & 0x01200000) == 0x00200000) {
-                /* ldrt/strt */
-                i = get_a32_user_mem_index(s);
-            } else {
-                i = get_mem_index(s);
-            }
-            if (insn & (1 << 24))
-                gen_add_data_offset(s, insn, tmp2);
-            if (insn & (1 << 20)) {
-                /* load */
-                tmp = tcg_temp_new_i32();
-                if (insn & (1 << 22)) {
-                    gen_aa32_ld8u_iss(s, tmp, tmp2, i, rd);
-                } else {
-                    gen_aa32_ld32u_iss(s, tmp, tmp2, i, rd);
-                }
-            } else {
-                /* store */
-                tmp = load_reg(s, rd);
-                if (insn & (1 << 22)) {
-                    gen_aa32_st8_iss(s, tmp, tmp2, i, rd);
-                } else {
-                    gen_aa32_st32_iss(s, tmp, tmp2, i, rd);
-                }
-                tcg_temp_free_i32(tmp);
-            }
-            if (!(insn & (1 << 24))) {
-                gen_add_data_offset(s, insn, tmp2);
-                store_reg(s, rn, tmp2);
-            } else if (insn & (1 << 21)) {
-                store_reg(s, rn, tmp2);
-            } else {
-                tcg_temp_free_i32(tmp2);
-            }
-            if (insn & (1 << 20)) {
-                /* Complete the load.  */
-                store_reg_from_load(s, rd, tmp);
-            }
-            break;
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         case 0x08:
         case 0x09:
             {
@@ -9795,75 +9950,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     s->condexec_mask = 0;
                 }
             } else if (insn & 0x01200000) {
-                /* 0b1110_1000_x11x_xxxx_xxxx_xxxx_xxxx_xxxx
-                 *  - load/store dual (post-indexed)
-                 * 0b1111_1001_x10x_xxxx_xxxx_xxxx_xxxx_xxxx
-                 *  - load/store dual (literal and immediate)
-                 * 0b1111_1001_x11x_xxxx_xxxx_xxxx_xxxx_xxxx
-                 *  - load/store dual (pre-indexed)
-                 */
-                bool wback = extract32(insn, 21, 1);
-
-                if (rn == 15 && (insn & (1 << 21))) {
-                    /* UNPREDICTABLE */
-                    goto illegal_op;
-                }
-
-                addr = add_reg_for_lit(s, rn, 0);
-                offset = (insn & 0xff) * 4;
-                if ((insn & (1 << 23)) == 0) {
-                    offset = -offset;
-                }
-
-                if (s->v8m_stackcheck && rn == 13 && wback) {
-                    /*
-                     * Here 'addr' is the current SP; if offset is +ve we're
-                     * moving SP up, else down. It is UNKNOWN whether the limit
-                     * check triggers when SP starts below the limit and ends
-                     * up above it; check whichever of the current and final
-                     * SP is lower, so QEMU will trigger in that situation.
-                     */
-                    if ((int32_t)offset < 0) {
-                        TCGv_i32 newsp = tcg_temp_new_i32();
-
-                        tcg_gen_addi_i32(newsp, addr, offset);
-                        gen_helper_v8m_stackcheck(cpu_env, newsp);
-                        tcg_temp_free_i32(newsp);
-                    } else {
-                        gen_helper_v8m_stackcheck(cpu_env, addr);
-                    }
-                }
-
-                if (insn & (1 << 24)) {
-                    tcg_gen_addi_i32(addr, addr, offset);
-                    offset = 0;
-                }
-                if (insn & (1 << 20)) {
-                    /* ldrd */
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    store_reg(s, rs, tmp);
-                    tcg_gen_addi_i32(addr, addr, 4);
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    store_reg(s, rd, tmp);
-                } else {
-                    /* strd */
-                    tmp = load_reg(s, rs);
-                    gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    tcg_temp_free_i32(tmp);
-                    tcg_gen_addi_i32(addr, addr, 4);
-                    tmp = load_reg(s, rd);
-                    gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    tcg_temp_free_i32(tmp);
-                }
-                if (wback) {
-                    /* Base writeback.  */
-                    tcg_gen_addi_i32(addr, addr, offset - 4);
-                    store_reg(s, rn, addr);
-                } else {
-                    tcg_temp_free_i32(addr);
-                }
+                /* load/store dual, in decodetree */
+                goto illegal_op;
             } else if ((insn & (1 << 23)) == 0) {
                 /* 0b1110_1000_010x_xxxx_xxxx_xxxx_xxxx_xxxx
                  * - load/store exclusive word
@@ -10746,184 +10834,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
         }
         break;
-    case 12: /* Load/store single data item.  */
-        {
-        int postinc = 0;
-        int writeback = 0;
-        int memidx;
-        ISSInfo issinfo;
-
+    case 12:
         if ((insn & 0x01100000) == 0x01000000) {
             if (disas_neon_ls_insn(s, insn)) {
                 goto illegal_op;
             }
             break;
         }
-        op = ((insn >> 21) & 3) | ((insn >> 22) & 4);
-        if (rs == 15) {
-            if (!(insn & (1 << 20))) {
-                goto illegal_op;
-            }
-            if (op != 2) {
-                /* Byte or halfword load space with dest == r15 : memory hints.
-                 * Catch them early so we don't emit pointless addressing code.
-                 * This space is a mix of:
-                 *  PLD/PLDW/PLI,  which we implement as NOPs (note that unlike
-                 *     the ARM encodings, PLDW space doesn't UNDEF for non-v7MP
-                 *     cores)
-                 *  unallocated hints, which must be treated as NOPs
-                 *  UNPREDICTABLE space, which we NOP or UNDEF depending on
-                 *     which is easiest for the decoding logic
-                 *  Some space which must UNDEF
-                 */
-                int op1 = (insn >> 23) & 3;
-                int op2 = (insn >> 6) & 0x3f;
-                if (op & 2) {
-                    goto illegal_op;
-                }
-                if (rn == 15) {
-                    /* UNPREDICTABLE, unallocated hint or
-                     * PLD/PLDW/PLI (literal)
-                     */
-                    return;
-                }
-                if (op1 & 1) {
-                    return; /* PLD/PLDW/PLI or unallocated hint */
-                }
-                if ((op2 == 0) || ((op2 & 0x3c) == 0x30)) {
-                    return; /* PLD/PLDW/PLI or unallocated hint */
-                }
-                /* UNDEF space, or an UNPREDICTABLE */
-                goto illegal_op;
-            }
-        }
-        memidx = get_mem_index(s);
-        imm = insn & 0xfff;
-        if (insn & (1 << 23)) {
-            /* PC relative or Positive offset.  */
-            addr = add_reg_for_lit(s, rn, imm);
-        } else if (rn == 15) {
-            /* PC relative with negative offset.  */
-            addr = add_reg_for_lit(s, rn, -imm);
-        } else {
-            addr = load_reg(s, rn);
-            imm = insn & 0xff;
-            switch ((insn >> 8) & 0xf) {
-            case 0x0: /* Shifted Register.  */
-                shift = (insn >> 4) & 0xf;
-                if (shift > 3) {
-                    tcg_temp_free_i32(addr);
-                    goto illegal_op;
-                }
-                tmp = load_reg(s, rm);
-                tcg_gen_shli_i32(tmp, tmp, shift);
-                tcg_gen_add_i32(addr, addr, tmp);
-                tcg_temp_free_i32(tmp);
-                break;
-            case 0xc: /* Negative offset.  */
-                tcg_gen_addi_i32(addr, addr, -imm);
-                break;
-            case 0xe: /* User privilege.  */
-                tcg_gen_addi_i32(addr, addr, imm);
-                memidx = get_a32_user_mem_index(s);
-                break;
-            case 0x9: /* Post-decrement.  */
-                imm = -imm;
-                /* Fall through.  */
-            case 0xb: /* Post-increment.  */
-                postinc = 1;
-                writeback = 1;
-                break;
-            case 0xd: /* Pre-decrement.  */
-                imm = -imm;
-                /* Fall through.  */
-            case 0xf: /* Pre-increment.  */
-                writeback = 1;
-                break;
-            default:
-                tcg_temp_free_i32(addr);
-                goto illegal_op;
-            }
-        }
-
-        issinfo = writeback ? ISSInvalid : rs;
-
-        if (s->v8m_stackcheck && rn == 13 && writeback) {
-            /*
-             * Stackcheck. Here we know 'addr' is the current SP;
-             * if imm is +ve we're moving SP up, else down. It is
-             * UNKNOWN whether the limit check triggers when SP starts
-             * below the limit and ends up above it; we chose to do so.
-             */
-            if ((int32_t)imm < 0) {
-                TCGv_i32 newsp = tcg_temp_new_i32();
-
-                tcg_gen_addi_i32(newsp, addr, imm);
-                gen_helper_v8m_stackcheck(cpu_env, newsp);
-                tcg_temp_free_i32(newsp);
-            } else {
-                gen_helper_v8m_stackcheck(cpu_env, addr);
-            }
-        }
-
-        if (writeback && !postinc) {
-            tcg_gen_addi_i32(addr, addr, imm);
-        }
-
-        if (insn & (1 << 20)) {
-            /* Load.  */
-            tmp = tcg_temp_new_i32();
-            switch (op) {
-            case 0:
-                gen_aa32_ld8u_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            case 4:
-                gen_aa32_ld8s_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            case 1:
-                gen_aa32_ld16u_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            case 5:
-                gen_aa32_ld16s_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            case 2:
-                gen_aa32_ld32u_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            default:
-                tcg_temp_free_i32(tmp);
-                tcg_temp_free_i32(addr);
-                goto illegal_op;
-            }
-            store_reg_from_load(s, rs, tmp);
-        } else {
-            /* Store.  */
-            tmp = load_reg(s, rs);
-            switch (op) {
-            case 0:
-                gen_aa32_st8_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            case 1:
-                gen_aa32_st16_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            case 2:
-                gen_aa32_st32_iss(s, tmp, addr, memidx, issinfo);
-                break;
-            default:
-                tcg_temp_free_i32(tmp);
-                tcg_temp_free_i32(addr);
-                goto illegal_op;
-            }
-            tcg_temp_free_i32(tmp);
-        }
-        if (postinc)
-            tcg_gen_addi_i32(addr, addr, imm);
-        if (writeback) {
-            store_reg(s, rn, addr);
-        } else {
-            tcg_temp_free_i32(addr);
-        }
-        }
-        break;
+        /* Load/store single data item, in decodetree */
+        goto illegal_op;
     default:
         goto illegal_op;
     }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index aac991664d..f7742deaee 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -37,6 +37,8 @@
 &mrs_reg         rd r
 &msr_bank        rn r sysm
 &mrs_bank        rd r sysm
+&ldst_rr         p w u rn rt rm shimm shtype
+&ldst_ri         p w u rn rt imm
 
 # Data-processing (register)
 
@@ -222,3 +224,121 @@ HLT              .... 0001 0000 .... .... .... 0111 ....      @i16
 BKPT             .... 0001 0010 .... .... .... 0111 ....      @i16
 HVC              .... 0001 0100 .... .... .... 0111 ....      @i16
 SMC              ---- 0001 0110 0000 0000 0000 0111 imm:4     &i
+
+# Load/Store Dual, Half, Signed Byte (register)
+
+@ldst_rr_p1w     ---- ...1 u:1 . w:1 . rn:4 rt:4 .... .... rm:4 \
+                 &ldst_rr p=1 shimm=0 shtype=0
+@ldst_rr_pw0     ---- ...0 u:1 . 0   . rn:4 rt:4 .... .... rm:4 \
+                 &ldst_rr p=0 w=0 shimm=0 shtype=0
+
+STRH_rr          .... 000. .0.0 .... .... 0000 1011 ....      @ldst_rr_pw0
+STRH_rr          .... 000. .0.0 .... .... 0000 1011 ....      @ldst_rr_p1w
+
+LDRD_rr          .... 000. .0.0 .... .... 0000 1101 ....      @ldst_rr_pw0
+LDRD_rr          .... 000. .0.0 .... .... 0000 1101 ....      @ldst_rr_p1w
+
+STRD_rr          .... 000. .0.0 .... .... 0000 1111 ....      @ldst_rr_pw0
+STRD_rr          .... 000. .0.0 .... .... 0000 1111 ....      @ldst_rr_p1w
+
+LDRH_rr          .... 000. .0.1 .... .... 0000 1011 ....      @ldst_rr_pw0
+LDRH_rr          .... 000. .0.1 .... .... 0000 1011 ....      @ldst_rr_p1w
+
+LDRSB_rr         .... 000. .0.1 .... .... 0000 1101 ....      @ldst_rr_pw0
+LDRSB_rr         .... 000. .0.1 .... .... 0000 1101 ....      @ldst_rr_p1w
+
+LDRSH_rr         .... 000. .0.1 .... .... 0000 1111 ....      @ldst_rr_pw0
+LDRSH_rr         .... 000. .0.1 .... .... 0000 1111 ....      @ldst_rr_p1w
+
+# Note the unpriv load/stores use the previously invalid P=0, W=1 encoding,
+# and act as normal post-indexed (P=0, W=0).
+@ldst_rr_p0w1    ---- ...0 u:1 . 1   . rn:4 rt:4 .... .... rm:4 \
+                 &ldst_rr p=0 w=0 shimm=0 shtype=0
+
+STRHT_rr         .... 000. .0.0 .... .... 0000 1011 ....      @ldst_rr_p0w1
+LDRHT_rr         .... 000. .0.1 .... .... 0000 1011 ....      @ldst_rr_p0w1
+LDRSBT_rr        .... 000. .0.1 .... .... 0000 1101 ....      @ldst_rr_p0w1
+LDRSHT_rr        .... 000. .0.1 .... .... 0000 1111 ....      @ldst_rr_p0w1
+
+# Load/Store word and unsigned byte (register)
+
+@ldst_rs_p1w     ---- ...1 u:1 . w:1 . rn:4 rt:4 shimm:5 shtype:2 . rm:4 \
+                 &ldst_rr p=1
+@ldst_rs_pw0     ---- ...0 u:1 . 0   . rn:4 rt:4 shimm:5 shtype:2 . rm:4 \
+                 &ldst_rr p=0 w=0
+
+STR_rr           .... 011. .0.0 .... .... .... ...0 ....      @ldst_rs_pw0
+STR_rr           .... 011. .0.0 .... .... .... ...0 ....      @ldst_rs_p1w
+STRB_rr          .... 011. .1.0 .... .... .... ...0 ....      @ldst_rs_pw0
+STRB_rr          .... 011. .1.0 .... .... .... ...0 ....      @ldst_rs_p1w
+
+LDR_rr           .... 011. .0.1 .... .... .... ...0 ....      @ldst_rs_pw0
+LDR_rr           .... 011. .0.1 .... .... .... ...0 ....      @ldst_rs_p1w
+LDRB_rr          .... 011. .1.1 .... .... .... ...0 ....      @ldst_rs_pw0
+LDRB_rr          .... 011. .1.1 .... .... .... ...0 ....      @ldst_rs_p1w
+
+@ldst_rs_p0w1    ---- ...0 u:1 . 1   . rn:4 rt:4 shimm:5 shtype:2 . rm:4 \
+                 &ldst_rr p=0 w=0
+
+STRT_rr          .... 011. .0.0 .... .... .... ...0 ....      @ldst_rs_p0w1
+STRBT_rr         .... 011. .1.0 .... .... .... ...0 ....      @ldst_rs_p0w1
+LDRT_rr          .... 011. .0.1 .... .... .... ...0 ....      @ldst_rs_p0w1
+LDRBT_rr         .... 011. .1.1 .... .... .... ...0 ....      @ldst_rs_p0w1
+
+# Load/Store Dual, Half, Signed Byte (immediate)
+
+%imm8s_8_0       8:4 0:4
+@ldst_ri8_p1w    ---- ...1 u:1 . w:1 . rn:4 rt:4 .... .... .... \
+                 &ldst_ri imm=%imm8s_8_0 p=1
+@ldst_ri8_pw0    ---- ...0 u:1 . 0   . rn:4 rt:4 .... .... .... \
+                 &ldst_ri imm=%imm8s_8_0 p=0 w=0
+
+STRH_ri          .... 000. .1.0 .... .... .... 1011 ....      @ldst_ri8_pw0
+STRH_ri          .... 000. .1.0 .... .... .... 1011 ....      @ldst_ri8_p1w
+
+LDRD_ri_a32      .... 000. .1.0 .... .... .... 1101 ....      @ldst_ri8_pw0
+LDRD_ri_a32      .... 000. .1.0 .... .... .... 1101 ....      @ldst_ri8_p1w
+
+STRD_ri_a32      .... 000. .1.0 .... .... .... 1111 ....      @ldst_ri8_pw0
+STRD_ri_a32      .... 000. .1.0 .... .... .... 1111 ....      @ldst_ri8_p1w
+
+LDRH_ri          .... 000. .1.1 .... .... .... 1011 ....      @ldst_ri8_pw0
+LDRH_ri          .... 000. .1.1 .... .... .... 1011 ....      @ldst_ri8_p1w
+
+LDRSB_ri         .... 000. .1.1 .... .... .... 1101 ....      @ldst_ri8_pw0
+LDRSB_ri         .... 000. .1.1 .... .... .... 1101 ....      @ldst_ri8_p1w
+
+LDRSH_ri         .... 000. .1.1 .... .... .... 1111 ....      @ldst_ri8_pw0
+LDRSH_ri         .... 000. .1.1 .... .... .... 1111 ....      @ldst_ri8_p1w
+
+# Note the unpriv load/stores use the previously invalid P=0, W=1 encoding,
+# and act as normal post-indexed (P=0, W=0).
+@ldst_ri8_p0w1   ---- ...0 u:1 . 1   . rn:4 rt:4 .... .... .... \
+                 &ldst_ri imm=%imm8s_8_0 p=0 w=0
+
+STRHT_ri         .... 000. .1.0 .... .... .... 1011 ....      @ldst_ri8_p0w1
+LDRHT_ri         .... 000. .1.1 .... .... .... 1011 ....      @ldst_ri8_p0w1
+LDRSBT_ri        .... 000. .1.1 .... .... .... 1101 ....      @ldst_ri8_p0w1
+LDRSHT_ri        .... 000. .1.1 .... .... .... 1111 ....      @ldst_ri8_p0w1
+
+# Load/Store word and unsigned byte (immediate)
+
+@ldst_ri12_p1w   ---- ...1 u:1 . w:1 . rn:4 rt:4 imm:12       &ldst_ri p=1
+@ldst_ri12_pw0   ---- ...0 u:1 . 0   . rn:4 rt:4 imm:12       &ldst_ri p=0 w=0
+
+STR_ri           .... 010. .0.0 .... .... ............        @ldst_ri12_p1w
+STR_ri           .... 010. .0.0 .... .... ............        @ldst_ri12_pw0
+STRB_ri          .... 010. .1.0 .... .... ............        @ldst_ri12_p1w
+STRB_ri          .... 010. .1.0 .... .... ............        @ldst_ri12_pw0
+
+LDR_ri           .... 010. .0.1 .... .... ............        @ldst_ri12_p1w
+LDR_ri           .... 010. .0.1 .... .... ............        @ldst_ri12_pw0
+LDRB_ri          .... 010. .1.1 .... .... ............        @ldst_ri12_p1w
+LDRB_ri          .... 010. .1.1 .... .... ............        @ldst_ri12_pw0
+
+@ldst_ri12_p0w1  ---- ...0 u:1 . 1 . rn:4 rt:4 imm:12         &ldst_ri p=0 w=0
+
+STRT_ri          .... 010. .0.0 .... .... ............        @ldst_ri12_p0w1
+STRBT_ri         .... 010. .1.0 .... .... ............        @ldst_ri12_p0w1
+LDRT_ri          .... 010. .0.1 .... .... ............        @ldst_ri12_p0w1
+LDRBT_ri         .... 010. .1.1 .... .... ............        @ldst_ri12_p0w1
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index be4e5f087c..a86597562b 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -34,6 +34,8 @@
 &mrs_reg         !extern rd r
 &msr_bank        !extern rn r sysm
 &mrs_bank        !extern rd r sysm
+&ldst_rr         !extern p w u rn rt rm shimm shtype
+&ldst_ri         !extern p w u rn rt imm
 
 # Data-processing (register)
 
@@ -251,3 +253,142 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
   HVC            1111 0111 1110 ....  1000 .... .... ....     \
                  &i imm=%imm16_16_0
 }
+
+# Load/store (register, immediate, literal)
+
+@ldst_rr         .... .... .... rn:4 rt:4 ...... shimm:2 rm:4 \
+                 &ldst_rr p=1 w=0 u=1 shtype=0
+@ldst_ri_idx     .... .... .... rn:4 rt:4 . p:1 u:1 . imm:8 \
+                 &ldst_ri w=1
+@ldst_ri_neg     .... .... .... rn:4 rt:4 .... imm:8 \
+                 &ldst_ri p=1 w=0 u=0
+@ldst_ri_unp     .... .... .... rn:4 rt:4 .... imm:8 \
+                 &ldst_ri p=1 w=0 u=1
+@ldst_ri_pos     .... .... .... rn:4 rt:4 imm:12 \
+                 &ldst_ri p=1 w=0 u=1
+@ldst_ri_lit     .... .... u:1 ... .... rt:4 imm:12 \
+                 &ldst_ri p=1 w=0 rn=15
+
+STRB_rr          1111 1000 0000 .... .... 000000 .. ....      @ldst_rr
+STRB_ri          1111 1000 0000 .... .... 1..1 ........       @ldst_ri_idx
+STRB_ri          1111 1000 0000 .... .... 1100 ........       @ldst_ri_neg
+STRBT_ri         1111 1000 0000 .... .... 1110 ........       @ldst_ri_unp
+STRB_ri          1111 1000 1000 .... .... ............        @ldst_ri_pos
+
+STRH_rr          1111 1000 0010 .... .... 000000 .. ....      @ldst_rr
+STRH_ri          1111 1000 0010 .... .... 1..1 ........       @ldst_ri_idx
+STRH_ri          1111 1000 0010 .... .... 1100 ........       @ldst_ri_neg
+STRHT_ri         1111 1000 0010 .... .... 1110 ........       @ldst_ri_unp
+STRH_ri          1111 1000 1010 .... .... ............        @ldst_ri_pos
+
+STR_rr           1111 1000 0100 .... .... 000000 .. ....      @ldst_rr
+STR_ri           1111 1000 0100 .... .... 1..1 ........       @ldst_ri_idx
+STR_ri           1111 1000 0100 .... .... 1100 ........       @ldst_ri_neg
+STRT_ri          1111 1000 0100 .... .... 1110 ........       @ldst_ri_unp
+STR_ri           1111 1000 1100 .... .... ............        @ldst_ri_pos
+
+# Note that Load, unsigned (literal) overlaps all other load encodings.
+{
+  {
+    NOP          1111 1000 -001 1111 1111 ------------        # PLD
+    LDRB_ri      1111 1000 .001 1111 .... ............        @ldst_ri_lit
+  }
+  {
+    NOP          1111 1000 1001 ---- 1111 ------------        # PLD
+    LDRB_ri      1111 1000 1001 .... .... ............        @ldst_ri_pos
+  }
+  LDRB_ri        1111 1000 0001 .... .... 1..1 ........       @ldst_ri_idx
+  {
+    NOP          1111 1000 0001 ---- 1111 1100 --------       # PLD
+    LDRB_ri      1111 1000 0001 .... .... 1100 ........       @ldst_ri_neg
+  }
+  LDRBT_ri       1111 1000 0001 .... .... 1110 ........       @ldst_ri_unp
+  {
+    NOP          1111 1000 0001 ---- 1111 000000 -- ----      # PLD
+    LDRB_rr      1111 1000 0001 .... .... 000000 .. ....      @ldst_rr
+  }
+}
+{
+  {
+    NOP          1111 1000 -011 1111 1111 ------------        # PLD
+    LDRH_ri      1111 1000 .011 1111 .... ............        @ldst_ri_lit
+  }
+  {
+    NOP          1111 1000 1011 ---- 1111 ------------        # PLDW
+    LDRH_ri      1111 1000 1011 .... .... ............        @ldst_ri_pos
+  }
+  LDRH_ri        1111 1000 0011 .... .... 1..1 ........       @ldst_ri_idx
+  {
+    NOP          1111 1000 0011 ---- 1111 1100 --------       # PLDW
+    LDRH_ri      1111 1000 0011 .... .... 1100 ........       @ldst_ri_neg
+  }
+  LDRHT_ri       1111 1000 0011 .... .... 1110 ........       @ldst_ri_unp
+  {
+    NOP          1111 1000 0011 ---- 1111 000000 -- ----      # PLDW
+    LDRH_rr      1111 1000 0011 .... .... 000000 .. ....      @ldst_rr
+  }
+}
+{
+  LDR_ri         1111 1000 .101 1111 .... ............        @ldst_ri_lit
+  LDR_ri         1111 1000 1101 .... .... ............        @ldst_ri_pos
+  LDR_ri         1111 1000 0101 .... .... 1..1 ........       @ldst_ri_idx
+  LDR_ri         1111 1000 0101 .... .... 1100 ........       @ldst_ri_neg
+  LDRT_ri        1111 1000 0101 .... .... 1110 ........       @ldst_ri_unp
+  LDR_rr         1111 1000 0101 .... .... 000000 .. ....      @ldst_rr
+}
+# NOPs here are PLI.
+{
+  {
+    NOP          1111 1001 -001 1111 1111 ------------
+    LDRSB_ri     1111 1001 .001 1111 .... ............        @ldst_ri_lit
+  }
+  {
+    NOP          1111 1001 1001 ---- 1111 ------------
+    LDRSB_ri     1111 1001 1001 .... .... ............        @ldst_ri_pos
+  }
+  LDRSB_ri       1111 1001 0001 .... .... 1..1 ........       @ldst_ri_idx
+  {
+    NOP          1111 1001 0001 ---- 1111 1100 --------
+    LDRSB_ri     1111 1001 0001 .... .... 1100 ........       @ldst_ri_neg
+  }
+  LDRSBT_ri      1111 1001 0001 .... .... 1110 ........       @ldst_ri_unp
+  {
+    NOP          1111 1001 0001 ---- 1111 000000 -- ----
+    LDRSB_rr     1111 1001 0001 .... .... 000000 .. ....      @ldst_rr
+  }
+}
+# NOPs here are unallocated memory hints, treated as NOP.
+{
+  {
+    NOP          1111 1001 -011 1111 1111 ------------
+    LDRSH_ri     1111 1001 .011 1111 .... ............        @ldst_ri_lit
+  }
+  {
+    NOP          1111 1001 1011 ---- 1111 ------------
+    LDRSH_ri     1111 1001 1011 .... .... ............        @ldst_ri_pos
+  }
+  LDRSH_ri       1111 1001 0011 .... .... 1..1 ........       @ldst_ri_idx
+  {
+    NOP          1111 1001 0011 ---- 1111 1100 --------
+    LDRSH_ri     1111 1001 0011 .... .... 1100 ........       @ldst_ri_neg
+  }
+  LDRSHT_ri      1111 1001 0011 .... .... 1110 ........       @ldst_ri_unp
+  {
+    NOP          1111 1001 0011 ---- 1111 000000 -- ----
+    LDRSH_rr     1111 1001 0011 .... .... 000000 .. ....      @ldst_rr
+  }
+}
+
+%imm8x4          0:8 !function=times_4
+&ldst_ri2        p w u rn rt rt2 imm
+@ldstd_ri8       .... .... u:1 ... rn:4 rt:4 rt2:4 ........   \
+                 &ldst_ri2 imm=%imm8x4
+
+STRD_ri_t32      1110 1000 .110 .... .... .... ........    @ldstd_ri8 w=1 p=0
+LDRD_ri_t32      1110 1000 .111 .... .... .... ........    @ldstd_ri8 w=1 p=0
+
+STRD_ri_t32      1110 1001 .100 .... .... .... ........    @ldstd_ri8 w=0 p=1
+LDRD_ri_t32      1110 1001 .101 .... .... .... ........    @ldstd_ri8 w=0 p=1
+
+STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
+LDRD_ri_t32      1110 1001 .111 .... .... .... ........    @ldstd_ri8 w=1 p=1
-- 
2.17.1


