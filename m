Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD89BC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1C920637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQB23GnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1C920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTup-0008Kt-Mi
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjM-0005r6-9k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjK-0002DL-S6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:34149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjK-0002D1-MI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:54 -0400
Received: by mail-pl1-x633.google.com with SMTP id a23so3080320plm.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VrNJWtbNYR04xVfCscKaMniKIGIvli/mwQv8Bqsi+6U=;
 b=bQB23GnC8RsFCyIQf8D57QMT8ZGW5WIeRbZz1WdFXBfsYgtLiGNPN2VqPukJzI9SQU
 LCYDOWbuQzfE3IKueuw97P1PeMPkrMk04ZwTKMEuBYgooazXPWVGwSY2jnTjTZWoReMO
 oJU+XVyXjf4Dz7XuKcbu7OKu9rub4j4YU3p+nWbENgxH0AQLKVCgmdXD1PhlFPHq1bzQ
 QhMk7m1I1ditlErnEHvRv0TdsJjIdcita1Ql07SYcOmWu2WXUAFxdPUzXCDxXjgJArk0
 c23vLb5KIDazAaR+jISPRn/iAzNmIZfJk/BLiXiEsxv/lbSU5KzM4/H1gYAIP5AatAOW
 o5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VrNJWtbNYR04xVfCscKaMniKIGIvli/mwQv8Bqsi+6U=;
 b=UPZYd+DZpGP7/7cNgkuprT+BbnK1v27L6xVw0yhZdl/G+eG04OHjQZ19BHQ2AKub9r
 KLaXS/oeKIRdqj1IZjURHnolb1yL0XptmNNI/G2kmVEQp8+XaE9VYseYSz9pVJRd6KEp
 FPN1Dx1FUdrMDaiCcnDX6EMaPWBpsKzsEn/ZhjLfdXfuMAQxmEzHKCuyWnSwAYK6prEx
 RUgF7lIuXDf+XNTYjOuPCO8VFNnLLUKWAr1IBVaBTiUfEqpYoCedt1RwFhpMfU6nXkYu
 PtoLGG0VLDciSnxggUBn12EJE1YZMGJGqBfaGN1q/zoB7Gm3nLyjjj76TjP+Sf8UAQ9E
 aoXA==
X-Gm-Message-State: ANhLgQ3ChzwskhDZ+CINcgM0m3tCNWKafVXaQVWK9+u92Na1kr8Z81AN
 UOQUBVk85BhoC4f4alW50W8QmUBSAcU=
X-Google-Smtp-Source: ADFU+vv/OEzPKfch7WsF2Rfjks3h2xOV/IB0ak/uuAgL6uoyL7zSQJm3CrHnh2dVO0I3pxGdyhRvNQ==
X-Received: by 2002:a17:902:778c:: with SMTP id
 o12mr9786734pll.324.1584042173317; 
 Thu, 12 Mar 2020 12:42:53 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 24/42] target/arm: Add gen_mte_checkN
Date: Thu, 12 Mar 2020 12:42:01 -0700
Message-Id: <20200312194219.24406-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
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

Replace existing uses of check_data_tbi in translate-a64.c that
perform multiple logical memory access.  Leave the helper blank
for now to reduce the patch size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |  1 +
 target/arm/translate-a64.h |  2 ++
 target/arm/mte_helper.c    |  8 +++++
 target/arm/translate-a64.c | 71 +++++++++++++++++++++++++++++---------
 4 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 2faa49d0a3..005af678c7 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -105,6 +105,7 @@ DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(mte_check1, TCG_CALL_NO_WG, i64, env, i32, i64)
+DEF_HELPER_FLAGS_3(mte_checkN, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
 DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index cc77e6ce8b..452b4764d0 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -42,6 +42,8 @@ bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
 bool sve_access_check(DisasContext *s);
 TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int log2_size);
+TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
+                        bool tag_checked, int count, int log2_esize);
 
 /* We should have at some point before trying to access an FP register
  * done the necessary access check, so assert that
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index ec12768dfc..907a12b366 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -366,3 +366,11 @@ uint64_t HELPER(mte_check1)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 {
     return ptr;
 }
+
+/*
+ * Perform an MTE checked access for multiple logical accesses.
+ */
+uint64_t HELPER(mte_checkN)(CPUARMState *env, uint32_t desc, uint64_t ptr)
+{
+    return ptr;
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 683a8a3dba..c6187ccd60 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -301,6 +301,34 @@ TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
                                  false, get_mem_index(s));
 }
 
+/*
+ * For MTE, check multiple logical sequential accesses.  
+ */
+TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
+                        bool tag_checked, int log2_esize, int total_size)
+{
+    if (tag_checked && s->mte_active[0] && total_size != (1 << log2_esize)) {
+        TCGv_i32 tcg_desc;
+        TCGv_i64 ret;
+        int desc = 0;
+
+        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
+        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << log2_esize);
+        desc = FIELD_DP32(desc, MTEDESC, TSIZE, total_size);
+        tcg_desc = tcg_const_i32(desc);
+
+        ret = new_tmp_a64(s);
+        gen_helper_mte_checkN(ret, cpu_env, tcg_desc, addr);
+        tcg_temp_free_i32(tcg_desc);
+
+        return ret;
+    }
+    return gen_mte_check1(s, addr, is_write, tag_checked, log2_esize);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2889,7 +2917,10 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         }
     }
 
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = gen_mte_checkN(s, dirty_addr, !is_load,
+                                (wback || rn != 31) && !set_tag,
+                                size, 2 << size);
+
     if (is_vector) {
         if (is_load) {
             do_fp_ld(s, rt, clean_addr, size);
@@ -3555,7 +3586,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
     MemOp endian = s->be_data;
 
-    int ebytes;   /* bytes per element */
+    int total;    /* total bytes */
     int elements; /* elements per vector */
     int rpt;    /* num iterations */
     int selem;  /* structure elements */
@@ -3625,19 +3656,26 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
         endian = MO_LE;
     }
 
-    /* Consecutive little-endian elements from a single register
+    total = rpt * selem * (is_q ? 16 : 8);
+    tcg_rn = cpu_reg_sp(s, rn);
+
+    /*
+     * Issue the MTE check vs the logical repeat count, before we
+     * promote consecutive little-endian elements below.
+     */
+    clean_addr = gen_mte_checkN(s, tcg_rn, is_store, is_postidx || rn != 31,
+                                size, total);
+
+    /*
+     * Consecutive little-endian elements from a single register
      * can be promoted to a larger little-endian operation.
      */
     if (selem == 1 && endian == MO_LE) {
         size = 3;
     }
-    ebytes = 1 << size;
-    elements = (is_q ? 16 : 8) / ebytes;
-
-    tcg_rn = cpu_reg_sp(s, rn);
-    clean_addr = clean_data_tbi(s, tcg_rn);
-    tcg_ebytes = tcg_const_i64(ebytes);
+    elements = (is_q ? 16 : 8) >> size;
 
+    tcg_ebytes = tcg_const_i64(1 << size);
     for (r = 0; r < rpt; r++) {
         int e;
         for (e = 0; e < elements; e++) {
@@ -3671,7 +3709,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
 
     if (is_postidx) {
         if (rm == 31) {
-            tcg_gen_addi_i64(tcg_rn, tcg_rn, rpt * elements * selem * ebytes);
+            tcg_gen_addi_i64(tcg_rn, tcg_rn, total);
         } else {
             tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, rm));
         }
@@ -3717,7 +3755,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     int selem = (extract32(opc, 0, 1) << 1 | R) + 1;
     bool replicate = false;
     int index = is_q << 3 | S << 2 | size;
-    int ebytes, xs;
+    int xs, total;
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
 
     if (extract32(insn, 31, 1)) {
@@ -3771,16 +3809,17 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
         return;
     }
 
-    ebytes = 1 << scale;
-
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
 
+    total = selem << scale;
     tcg_rn = cpu_reg_sp(s, rn);
-    clean_addr = clean_data_tbi(s, tcg_rn);
-    tcg_ebytes = tcg_const_i64(ebytes);
 
+    clean_addr = gen_mte_checkN(s, tcg_rn, !is_load, is_postidx || rn != 31,
+                                scale, total);
+
+    tcg_ebytes = tcg_const_i64(1 << scale);
     for (xs = 0; xs < selem; xs++) {
         if (replicate) {
             /* Load and replicate to all elements */
@@ -3807,7 +3846,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
 
     if (is_postidx) {
         if (rm == 31) {
-            tcg_gen_addi_i64(tcg_rn, tcg_rn, selem * ebytes);
+            tcg_gen_addi_i64(tcg_rn, tcg_rn, total);
         } else {
             tcg_gen_add_i64(tcg_rn, tcg_rn, cpu_reg(s, rm));
         }
-- 
2.20.1


