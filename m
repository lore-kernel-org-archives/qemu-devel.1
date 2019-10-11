Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F351C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3F62064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQ4zWAxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3F62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvKT-0006tJ-Lm
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvIj-0004zf-MT
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvIi-0003j2-9y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:49:49 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvIi-0003ip-6T
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:49:48 -0400
Received: by mail-yb1-xb41.google.com with SMTP id z2so79187ybn.6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xZH3oa+fEbaUjwm0ZjIFF1dWywajMdYu17rk2IR9ClE=;
 b=MQ4zWAxKtitI9+2b0FGNMzBNoenroObDuSLYzQPKbT3hAh8es22qjqTYBeNdS7gpff
 tyQbFYKC6DkYWdJzoRXbDsuXwmnHPhUjLPqx51TpGqcGCkP4NcmsD7XlAcEiyzZFwksL
 b1qAzpS96C6xumgoLAX9sWr3CCJlECkamxqTbisXW14NAMzpz1RFJ9pGcpaV650/kQcF
 wGgJCnRDMbiIXSoFga1ebN1ZJXfxwHuVqA7rJVpvC3qekIy61efkf+wHSo8sWA3RTUZu
 TqzXOa0AIeShcgnhMhrSkPNduSnAwoe4egKm+cJtfSE1EJc20BfsCwosdCc+6tDr94Qc
 HX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xZH3oa+fEbaUjwm0ZjIFF1dWywajMdYu17rk2IR9ClE=;
 b=VjB9Uq14qU3yvzp76T7+iavJsSYIQrBZj2I3/Ll4tY08LbLTmuIvIGSPaBKhp65/Tp
 Fj0PO0oItvo2WERZ99cUP2kyBQ1rVRX1pruZWgNMwQhGkiGuKWNAhoWayDW5vZuRVhiG
 +HypQBAityk7IN5KqLagNGJMbeIK4j+C3eH6V4F0eG2SSpZmGrNmwCPhm65JLMqI2M9L
 9yK0CONbDzo0M4X/4Lq2PouLS5UfdN/ioh73Onw7ZsXEAafXlW4UWBdrAZ+nIC9zNZS7
 2sYp3rPl/zMoONiiM37SNgPQaYSxYoLzyPuRf3i4WL39FMOWb2EyT+MJRASyaY4vu927
 skPw==
X-Gm-Message-State: APjAAAVB0roRY5BRRX4hdV3asaTLPVIYIr9K6wlL1O9+DgajwT86gf/w
 UOlc1aQ5cYE0r+Cfu8oMx1pqAsqqALs=
X-Google-Smtp-Source: APXvYqy7QAfamC2s4LUQqZI/Tyv0cxaQ9PN9OYqRR+/LU6cl66v057PVvTXxodl0SF8s86B2ZDMaAQ==
X-Received: by 2002:a25:5b09:: with SMTP id p9mr10890709ybb.236.1570801787211; 
 Fri, 11 Oct 2019 06:49:47 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:49:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/22] target/arm: Implement ADDG, SUBG instructions
Date: Fri, 11 Oct 2019 09:47:29 -0400
Message-Id: <20191011134744.2477-8-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Shift offset in translate; use extract32.
---
 target/arm/helper-a64.h    |  2 ++
 target/arm/internals.h     |  4 +++
 target/arm/mte_helper.c    | 32 +++++++++++++++++
 target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++------------
 4 files changed, 86 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 6ff7f5b756..268c114b79 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -107,3 +107,5 @@ DEF_HELPER_FLAGS_2(mte_check1, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(mte_check2, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(mte_check3, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
+DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index bfa243be06..a434743b15 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1085,4 +1085,8 @@ void arm_log_exception(int idx);
  */
 #define GMID_EL1_BS  6
 
+/* We associate one allocation tag per 16 bytes, the minimum.  */
+#define LOG2_TAG_GRANULE 4
+#define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
+
 #endif
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 9848849a91..c3edc51bba 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -222,3 +222,35 @@ uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
 
     return address_with_allocation_tag(rn, rtag);
 }
+
+uint64_t HELPER(addg)(CPUARMState *env, uint64_t ptr,
+                      uint32_t offset, uint32_t tag_offset)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        int start_tag = allocation_tag_from_addr(ptr);
+        uint16_t exclude = extract32(env->cp15.gcr_el1, 0, 16);
+        rtag = choose_nonexcluded_tag(start_tag, tag_offset, exclude);
+    }
+
+    return address_with_allocation_tag(ptr + offset, rtag);
+}
+
+uint64_t HELPER(subg)(CPUARMState *env, uint64_t ptr,
+                      uint32_t offset, uint32_t tag_offset)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        int start_tag = allocation_tag_from_addr(ptr);
+        uint16_t exclude = extract32(env->cp15.gcr_el1, 0, 16);
+        rtag = choose_nonexcluded_tag(start_tag, tag_offset, exclude);
+    }
+
+    return address_with_allocation_tag(ptr - offset, rtag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 83d253d67f..26aee0c1c9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3628,7 +3628,9 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
  *    sf: 0 -> 32bit, 1 -> 64bit
  *    op: 0 -> add  , 1 -> sub
  *     S: 1 -> set flags
- * shift: 00 -> LSL imm by 0, 01 -> LSL imm by 12
+ * shift: 00 -> LSL imm by 0,
+ *        01 -> LSL imm by 12
+ *        10 -> ADDG, SUBG
  */
 static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
 {
@@ -3639,10 +3641,10 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
     bool setflags = extract32(insn, 29, 1);
     bool sub_op = extract32(insn, 30, 1);
     bool is_64bit = extract32(insn, 31, 1);
+    bool is_tag = false;
 
     TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
     TCGv_i64 tcg_rd = setflags ? cpu_reg(s, rd) : cpu_reg_sp(s, rd);
-    TCGv_i64 tcg_result;
 
     switch (shift) {
     case 0x0:
@@ -3650,35 +3652,58 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
     case 0x1:
         imm <<= 12;
         break;
+    case 0x2:
+        /* ADDG, SUBG */
+        if (!is_64bit || setflags || (imm & 0x30) ||
+            !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        is_tag = true;
+        break;
     default:
+    do_unallocated:
         unallocated_encoding(s);
         return;
     }
 
-    tcg_result = tcg_temp_new_i64();
-    if (!setflags) {
-        if (sub_op) {
-            tcg_gen_subi_i64(tcg_result, tcg_rn, imm);
-        } else {
-            tcg_gen_addi_i64(tcg_result, tcg_rn, imm);
-        }
-    } else {
-        TCGv_i64 tcg_imm = tcg_const_i64(imm);
-        if (sub_op) {
-            gen_sub_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
-        } else {
-            gen_add_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
-        }
-        tcg_temp_free_i64(tcg_imm);
-    }
+    if (is_tag) {
+        TCGv_i32 tag_offset = tcg_const_i32(imm & 15);
+        TCGv_i32 offset = tcg_const_i32((imm >> 6) << LOG2_TAG_GRANULE);
 
-    if (is_64bit) {
-        tcg_gen_mov_i64(tcg_rd, tcg_result);
+        if (sub_op) {
+            gen_helper_subg(tcg_rd, cpu_env, tcg_rn, offset, tag_offset);
+        } else {
+            gen_helper_addg(tcg_rd, cpu_env, tcg_rn, offset, tag_offset);
+        }
+        tcg_temp_free_i32(tag_offset);
+        tcg_temp_free_i32(offset);
     } else {
-        tcg_gen_ext32u_i64(tcg_rd, tcg_result);
-    }
+        TCGv_i64 tcg_result;
 
-    tcg_temp_free_i64(tcg_result);
+        if (!setflags) {
+            tcg_result = tcg_rd;
+            if (sub_op) {
+                tcg_gen_subi_i64(tcg_result, tcg_rn, imm);
+            } else {
+                tcg_gen_addi_i64(tcg_result, tcg_rn, imm);
+            }
+        } else {
+            TCGv_i64 tcg_imm = tcg_const_i64(imm);
+            tcg_result = new_tmp_a64(s);
+            if (sub_op) {
+                gen_sub_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
+            } else {
+                gen_add_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
+            }
+            tcg_temp_free_i64(tcg_imm);
+        }
+
+        if (is_64bit) {
+            tcg_gen_mov_i64(tcg_rd, tcg_result);
+        } else {
+            tcg_gen_ext32u_i64(tcg_rd, tcg_result);
+        }
+    }
 }
 
 /* The input should be a value in the bottom e bits (with higher
-- 
2.17.1


