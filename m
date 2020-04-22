Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65EC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C2B2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2ZsCRmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C2B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Ez-0000PG-8N
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41U-0001sj-2L
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41T-0002Ma-DI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:55 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41S-0002ID-U0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:55 -0400
Received: by mail-pl1-x642.google.com with SMTP id v2so236651plp.9
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GuLBXp+DHzvjBbWtLt3J1mN+KRme5ZQDBMNQ1V2Bki4=;
 b=C2ZsCRmt/TWBZfNwnyA0zUmTHLZcf4dL+qjFn10y9qwIqhllrOVgOXtTXIloGrHqBR
 y2jM+Ckm16KvQLzCfml51OtTJUwDDHSoFo+NnK7ebv1s6HLiLHwf2HNAx9sY8FBq/IEx
 CLXFPpH414UQgWTbQ0HQSC1JrY0X6TPH6JPOL7o9Hrk9ykm5QT5O0IiDZTMQ14KJhCBj
 4zoHQvRYtW5L8RDHmPwt1Jl9cFuQDvFEQNx9JT7x90BX0Uh81UOiAHS/oFTz3fLjJtCh
 1JWLIsRK74utAWE4omuzK1ttD2wgnj67cqGxtctWj9TslF+o2tYdMEJUFmszy6yaxdNJ
 VeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GuLBXp+DHzvjBbWtLt3J1mN+KRme5ZQDBMNQ1V2Bki4=;
 b=W4sri6O4VqK0vwJQ1zBBHOYv1ygtGwI2FxuYtv4vjajktBFPABhhPM6y5R8VwvRBJG
 DfETlVcl+eejY6/0BJ7V/BDdBy9g+IyJgdITCtDcOALQ2lOGaUEchSlFD7pQUt7+99WZ
 FQkxMza5mEoDuJjtsaPfvKCZ4JeiTBn7ZRkJDXxAnA7t58zyDwEbeByCAnaYXLoQeP93
 83I7sYDwr/Ldaa3vqqprkPYMqEj89JjkFvBuNaAHsqvQUzrtH/oTTfNjmC3flRKSgIWt
 UidErCBRod0eZb3fXTD6NVvJKvBRyWYGrKDu3DknAix0zlCc0ewxbi6RJ1D2nyqhCwx6
 sUeg==
X-Gm-Message-State: AGi0Puai43OjyY1yqsRe3xt4FDjkRIn9FqKsUROUHSdJmfHzchje2nI0
 U+EshK35vTiIYLe17Q4fhC1C0ScCzos=
X-Google-Smtp-Source: APiQypIlbQ+1hwUBI3YxaaXvJyTYv8tdvvnd0HnyeIUEq7g14MZ/z4nBdwLkIUxfz68NFFXJhfAWYQ==
X-Received: by 2002:a17:90a:5d96:: with SMTP id
 t22mr9032428pji.132.1587518273082; 
 Tue, 21 Apr 2020 18:17:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/36] tcg: Add tcg_reg_alloc_dup2
Date: Tue, 21 Apr 2020 18:17:09 -0700
Message-Id: <20200422011722.13287-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several ways we can expand a vector dup of a 64-bit
element on a 32-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index fc1c97d586..d712d19842 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3870,6 +3870,91 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     }
 }
 
+static void tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
+{
+    const TCGLifeData arg_life = op->life;
+    TCGTemp *ots, *itsl, *itsh;
+    TCGType vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+
+    /* This opcode is only valid for 32-bit hosts, for 64-bit elements. */
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+    tcg_debug_assert(TCGOP_VECE(op) == MO_64);
+
+    ots = arg_temp(op->args[0]);
+    itsl = arg_temp(op->args[1]);
+    itsh = arg_temp(op->args[2]);
+
+    /* ENV should not be modified.  */
+    tcg_debug_assert(!temp_readonly(ots));
+
+    /* Allocate the output register now.  */
+    if (ots->val_type != TEMP_VAL_REG) {
+        TCGRegSet allocated_regs = s->reserved_regs;
+        TCGRegSet dup_out_regs =
+            tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
+
+        /* Make sure to not spill the input registers. */
+        if (!IS_DEAD_ARG(1) && itsl->val_type == TEMP_VAL_REG) {
+            tcg_regset_set_reg(allocated_regs, itsl->reg);
+        }
+        if (!IS_DEAD_ARG(2) && itsh->val_type == TEMP_VAL_REG) {
+            tcg_regset_set_reg(allocated_regs, itsh->reg);
+        }
+
+        ots->reg = tcg_reg_alloc(s, dup_out_regs, allocated_regs,
+                                 op->output_pref[0], ots->indirect_base);
+        ots->val_type = TEMP_VAL_REG;
+        ots->mem_coherent = 0;
+        s->reg_to_temp[ots->reg] = ots;
+    }
+
+    /* Promote dup2 of immediates to dupi_vec. */
+    if (itsl->val_type == TEMP_VAL_CONST &&
+        itsh->val_type == TEMP_VAL_CONST) {
+        tcg_out_dupi_vec(s, vtype, ots->reg,
+                         (uint32_t)itsl->val | ((uint64_t)itsh->val << 32));
+        goto done;
+    }
+
+    /* If the two inputs form one 64-bit value, try dupm_vec. */
+    if (itsl + 1 == itsh &&
+        itsl->base_type == TCG_TYPE_I64 &&
+        itsh->base_type == TCG_TYPE_I64) {
+        if (!itsl->mem_coherent) {
+            temp_sync(s, itsl, s->reserved_regs, 0, 0);
+        }
+        if (!itsl->mem_coherent) {
+            temp_sync(s, itsl, s->reserved_regs, 0, 0);
+        }
+#ifdef HOST_WORDS_BIGENDIAN
+        TCGTemp *its = itsh;
+#else
+        TCGTemp *its = itsl;
+#endif
+        if (tcg_out_dupm_vec(s, vtype, MO_64, ots->reg,
+                             its->mem_base->reg, its->mem_offset)) {
+            goto done;
+        }
+    }
+
+    /* Fall back to generic expansion. */
+    tcg_reg_alloc_op(s, op);
+    return;
+
+ done:
+    if (IS_DEAD_ARG(1)) {
+        temp_dead(s, itsl);
+    }
+    if (IS_DEAD_ARG(2)) {
+        temp_dead(s, itsh);
+    }
+    if (NEED_SYNC_ARG(0)) {
+        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
+    } else if (IS_DEAD_ARG(0)) {
+        temp_dead(s, ots);
+    }
+}
+
 #ifdef TCG_TARGET_STACK_GROWSUP
 #define STACK_DIR(x) (-(x))
 #else
@@ -4261,6 +4346,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         case INDEX_op_dup_vec:
             tcg_reg_alloc_dup(s, op);
             break;
+        case INDEX_op_dup2_vec:
+            tcg_reg_alloc_dup2(s, op);
+            break;
         case INDEX_op_insn_start:
             if (num_insns >= 0) {
                 size_t off = tcg_current_code_size(s);
-- 
2.20.1


