Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40355C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5222067B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQKPhHkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5222067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJ7Z-00025s-Bk
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc6-0004Z1-3f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:54 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:33872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc2-0001se-Qt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:53 -0400
Received: by mail-pg1-x52f.google.com with SMTP id t14so3770355pgg.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wKIZSGBqeL6eH4nJU/bsk+BdgEO2Ei2N/rDAGm2vo4g=;
 b=PQKPhHkQ1aukKFdMB105hsz9oRDXRBMUbERiS7WUVYPcYvWezCLxAC3eTG+88yNHET
 GxFX2MfpvIeNWKhRtHNVnHBrH97BCUCgytltYd1z5vaFndQbM9SwlGsw5gNGU8Hwvpt/
 QZ4gRqFHCz2vcCdppz3Ge/kUttrOqPCtDsN1Ixh2hGGmo6LE4nruaSDGgq7RStHEaOSK
 DqR7sMg0s1VUG9A6J87YsyFiAGekIVl5BYUFPvHNRKsI62vXZ81micZY0T2rT0sgbm9H
 EuPC8Ze6fFgO1ki56l+7MnqD1OaY0ZO9W7WvZeoWHtZAMU2/e4JoT9sBK+YMFweVeNVQ
 m22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wKIZSGBqeL6eH4nJU/bsk+BdgEO2Ei2N/rDAGm2vo4g=;
 b=OK1XuLhBgSNa4PJIdW/gEdmRc1khXpQ3pD68wRGz5voOQpb3FZ4IX+Nry3/+QKJury
 kwhV2ooUh093JrhflY/agKEjHoAdWljY+Z7sQGchGp8XKtaxL7UHgThWMR0/WbgpC9sO
 ykTztQEglySKbpFoBH0Judthb/Y7GJ96o5lfBqJ8SbysljDIYrl6E9QWg7rFI+xnYInd
 ApZLBgB7qPdl75L9lK72w7KD9LB3P+6XeyfT5DGbbdJiqMQE5gVtn1hr/KLSeJM4id7I
 yadOFv7G5NqsNNJyIINwvkJ6ZqKmAMagbZoofKofcHo+4aIdQJfHq3mWo+c2Fa1UKDiA
 ZDQA==
X-Gm-Message-State: AOAM5334Rr1R7/aNI6DDSHOs+F07b79+55/VKBQJ4bnOHsuAvq8su5aK
 eTGlmQkcsrFdqdrGkTwxBtnx+ZpGjWn4cQ==
X-Google-Smtp-Source: ABdhPJydHz/g3/CZfO4GIBHrQn3RS1Z8tv/cWB1Z7gCF5LlsHfHRWfC2WWW7mLphWOKF5sZTQjXw8Q==
X-Received: by 2002:a17:90a:d517:: with SMTP id
 t23mr1916834pju.141.1604018988896; 
 Thu, 29 Oct 2020 17:49:48 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/19] tcg/aarch64: Support split-rwx code generation
Date: Thu, 29 Oct 2020 17:49:21 -0700
Message-Id: <20201030004921.721096-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.c.inc | 57 ++++++++++++++++++++----------------
 tcg/tcg-pool.c.inc           |  6 +++-
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index e62d38ba55..abb94f9458 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -155,6 +155,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 5e8f3faad2..c082a06152 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -78,38 +78,42 @@ static const int tcg_target_call_oarg_regs[1] = {
 #define TCG_REG_GUEST_BASE TCG_REG_X28
 #endif
 
-static inline bool reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static bool reloc_pc26(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    ptrdiff_t offset = target - code_ptr;
+    const tcg_insn_unit *src_rx = tcg_mirror_rw_to_rx(src_rw);
+    ptrdiff_t offset = target - src_rx;
+
     if (offset == sextract64(offset, 0, 26)) {
         /* read instruction, mask away previous PC_REL26 parameter contents,
            set the proper offset, then write back the instruction. */
-        *code_ptr = deposit32(*code_ptr, 0, 26, offset);
+        *src_rw = deposit32(*src_rw, 0, 26, offset);
         return true;
     }
     return false;
 }
 
-static inline bool reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static bool reloc_pc19(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    ptrdiff_t offset = target - code_ptr;
+    const tcg_insn_unit *src_rx = tcg_mirror_rw_to_rx(src_rw);
+    ptrdiff_t offset = target - src_rx;
+
     if (offset == sextract64(offset, 0, 19)) {
-        *code_ptr = deposit32(*code_ptr, 5, 19, offset);
+        *src_rw = deposit32(*src_rw, 5, 19, offset);
         return true;
     }
     return false;
 }
 
-static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
-                               intptr_t value, intptr_t addend)
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
 {
     tcg_debug_assert(addend == 0);
     switch (type) {
     case R_AARCH64_JUMP26:
     case R_AARCH64_CALL26:
-        return reloc_pc26(code_ptr, (tcg_insn_unit *)value);
+        return reloc_pc26(code_ptr, (const tcg_insn_unit *)value);
     case R_AARCH64_CONDBR19:
-        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
+        return reloc_pc19(code_ptr, (const tcg_insn_unit *)value);
     default:
         g_assert_not_reached();
     }
@@ -1050,12 +1054,13 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     /* Look for host pointer values within 4G of the PC.  This happens
        often when loading pointers to QEMU's own data structures.  */
     if (type == TCG_TYPE_I64) {
-        tcg_target_long disp = value - (intptr_t)s->code_ptr;
+        intptr_t src_rx = (intptr_t)tcg_mirror_rw_to_rx(s->code_ptr);
+        tcg_target_long disp = value - src_rx;
         if (disp == sextract64(disp, 0, 21)) {
             tcg_out_insn(s, 3406, ADR, rd, disp);
             return;
         }
-        disp = (value >> 12) - ((intptr_t)s->code_ptr >> 12);
+        disp = (value >> 12) - (src_rx >> 12);
         if (disp == sextract64(disp, 0, 21)) {
             tcg_out_insn(s, 3406, ADRP, rd, disp);
             if (value & 0xfff) {
@@ -1308,14 +1313,14 @@ static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGReg a,
 
 static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
-    ptrdiff_t offset = target - s->code_ptr;
+    ptrdiff_t offset = tcg_pcrel_diff(s, target) >> 2;
     tcg_debug_assert(offset == sextract64(offset, 0, 26));
     tcg_out_insn(s, 3206, B, offset);
 }
 
-static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
+static void tcg_out_goto_long(TCGContext *s, const tcg_insn_unit *target)
 {
-    ptrdiff_t offset = target - s->code_ptr;
+    ptrdiff_t offset = tcg_pcrel_diff(s, target) >> 2;
     if (offset == sextract64(offset, 0, 26)) {
         tcg_out_insn(s, 3206, B, offset);
     } else {
@@ -1329,9 +1334,9 @@ static inline void tcg_out_callr(TCGContext *s, TCGReg reg)
     tcg_out_insn(s, 3207, BLR, reg);
 }
 
-static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
 {
-    ptrdiff_t offset = target - s->code_ptr;
+    ptrdiff_t offset = tcg_pcrel_diff(s, target) >> 2;
     if (offset == sextract64(offset, 0, 26)) {
         tcg_out_insn(s, 3206, BL, offset);
     } else {
@@ -1393,7 +1398,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
         offset = tcg_in32(s) >> 5;
     } else {
-        offset = l->u.value_ptr - s->code_ptr;
+        offset = tcg_pcrel_diff(s, l->u.value_ptr) >> 2;
         tcg_debug_assert(offset == sextract64(offset, 0, 19));
     }
 
@@ -1568,7 +1573,7 @@ static void * const qemu_st_helpers[16] = {
     [MO_BEQ]  = helper_be_stq_mmu,
 };
 
-static inline void tcg_out_adr(TCGContext *s, TCGReg rd, void *target)
+static inline void tcg_out_adr(TCGContext *s, TCGReg rd, const void *target)
 {
     ptrdiff_t offset = tcg_pcrel_diff(s, target);
     tcg_debug_assert(offset == sextract64(offset, 0, 21));
@@ -1581,7 +1586,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     MemOp opc = get_memop(oi);
     MemOp size = opc & MO_SIZE;
 
-    if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
+    if (!reloc_pc19(lb->label_ptr[0], tcg_mirror_rw_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1606,7 +1611,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     MemOp opc = get_memop(oi);
     MemOp size = opc & MO_SIZE;
 
-    if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
+    if (!reloc_pc19(lb->label_ptr[0], tcg_mirror_rw_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1631,7 +1636,8 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->type = ext;
     label->datalo_reg = data_reg;
     label->addrlo_reg = addr_reg;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_mirror_rw_to_rx(raddr);
     label->label_ptr[0] = label_ptr;
 }
 
@@ -1849,7 +1855,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
 #endif /* CONFIG_SOFTMMU */
 }
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2894,11 +2900,12 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_mirror_rw_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_X0, 0);
 
     /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+    tb_ret_addr = tcg_mirror_rw_to_rx(s->code_ptr);
 
     /* Remove TCG locals stack space.  */
     tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_SP, TCG_REG_SP,
diff --git a/tcg/tcg-pool.c.inc b/tcg/tcg-pool.c.inc
index 82cbcc89bd..8d92833d7e 100644
--- a/tcg/tcg-pool.c.inc
+++ b/tcg/tcg-pool.c.inc
@@ -140,6 +140,8 @@ static int tcg_out_pool_finalize(TCGContext *s)
 
     for (; p != NULL; p = p->next) {
         size_t size = sizeof(tcg_target_ulong) * p->nlong;
+        uintptr_t value;
+
         if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
             if (unlikely(a > s->code_gen_highwater)) {
                 return -1;
@@ -148,7 +150,9 @@ static int tcg_out_pool_finalize(TCGContext *s)
             a += size;
             l = p;
         }
-        if (!patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend)) {
+
+        value = (uintptr_t)tcg_mirror_rw_to_rx(a) - size;
+        if (!patch_reloc(p->label, p->rtype, value, p->addend)) {
             return -2;
         }
     }
-- 
2.25.1


