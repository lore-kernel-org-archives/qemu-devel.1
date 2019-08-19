Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD9CC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D202087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ma302CXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D202087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpOg-0004fy-8Y
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLp-0001ER-IO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLn-0005zP-Lq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:05 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLn-0005yq-EO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:03 -0400
Received: by mail-pf1-x441.google.com with SMTP id f17so1943579pfn.6
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QIkenGimVRi/Plae7Rw1++VDbOCShjtnkN1KcI6L2k4=;
 b=Ma302CXnDvBvFDlsJ1ASzvwZWQdepTRMZojxPkgr1azkyT9L3bKyX/epEb9VpPWNyY
 LK+X2aenBG8stSLs19kItzgkilHZ97LLZDgTuiWQr7hR2XtV+Pf4YxQkKD2XnthhXMXs
 hY14rW3s3OEf6rqt+eHI/9frbLXx5PQKCgsA6+5Si2+FLfwWg7GsNhZFJQXT/3Es8zYc
 ROyIC3F1pxm8IEtFSyX8Nd4GqDEfCc7Tn4RhHKxjG1M9W28UPQN+TdYp0/v/ufcDvCND
 rTso3NYWnJkdcNTip2TaIXVKs4EvQ3j4pETuATKtqTqZMBnz0iTZ1ocQzdEvZY+SQOAa
 Vn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QIkenGimVRi/Plae7Rw1++VDbOCShjtnkN1KcI6L2k4=;
 b=tEfug4rrV4f7pZo+tddlBdd2e1uJ5ouRIQM3Fx2NwiIADo3gz0WEYKKDO5m5beMVHC
 33TOxBuxJ0neo9eDF1giD5EO4mrvNRkWg8yr2qML3OkFOdqdsD4XbDL9qS7GM2W5ZwCN
 AvRyprSj633obpYGSQdPFhfnlqfnDPgVVKRcJfHAEIeK1gEXb6eRyDp1yWT4vrocJM0j
 QAsBvfh29WTV1zl7FRrI1mCBIiEz3vUUGX4xK1kOL22T0mVYrrs1be/g8K+NIs5k66O1
 0gV1xlUB5qt44RtYj/twe3Zc7N5+l/ry+3kkql9nZ5uB4XusnPgXFS65kLgzT6igOdw/
 dy2Q==
X-Gm-Message-State: APjAAAXoXhvOrGHZaD0y5wkcRfuHS8NTgRG+S4xPDMYUWDR8DeyUBYz4
 veINxT7qP0UKsspkbzKFMwyO5yq5Opc=
X-Google-Smtp-Source: APXvYqwhfciRGrOTo8ja89ByPITok85KXyCZfbxf6MwKdOXp/tBKOG3bsYVAccbdCSoFiapSS/hw5g==
X-Received: by 2002:a63:fe17:: with SMTP id p23mr21746489pgh.103.1566250681535; 
 Mon, 19 Aug 2019 14:38:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:50 -0700
Message-Id: <20190819213755.26175-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 03/68] target/arm: Convert Data Processing
 (register)
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

Convert the register shifted by immediate form of the data
processing insns.  For A32, we cannot yet remove any code
because the legacy decoder intertwines the reg-shifted-reg
and immediate forms.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 229 ++++++++++++++++++++++++++++++++++-------
 target/arm/a32.decode  |  28 +++++
 target/arm/t32.decode  |  43 ++++++++
 3 files changed, 264 insertions(+), 36 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c759fe0797..be8e7685e3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7669,6 +7669,197 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
 #include "decode-a32-uncond.inc.c"
 #include "decode-t32.inc.c"
 
+/* Helpers to swap operands for reverse-subtract.  */
+static void gen_rsb(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_sub_i32(dst, b, a);
+}
+
+static void gen_rsb_CC(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_sub_CC(dst, b, a);
+}
+
+static void gen_rsc(TCGv_i32 dest, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_sub_carry(dest, b, a);
+}
+
+static void gen_rsc_CC(TCGv_i32 dest, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_sbc_CC(dest, b, a);
+}
+
+/*
+ * Helpers for the data processing routines.
+ *
+ * After the computation store the results back.
+ * This may be suppressed altogether (STREG_NONE), require a runtime
+ * check against the stack limits (STREG_SP_CHECK), or generate an
+ * exception return.  Oh, or store into a register.
+ *
+ * Always return true, indicating success for a trans_* function.
+ */
+typedef enum {
+   STREG_NONE,
+   STREG_NORMAL,
+   STREG_SP_CHECK,
+   STREG_EXC_RET,
+} StoreRegKind;
+
+static bool store_reg_kind(DisasContext *s, int rd,
+                            TCGv_i32 val, StoreRegKind kind)
+{
+    switch (kind) {
+    case STREG_NONE:
+        tcg_temp_free_i32(val);
+        return true;
+    case STREG_NORMAL:
+        /* See ALUWritePC: Interworking only from a32 mode. */
+        if (s->thumb) {
+            store_reg(s, rd, val);
+        } else {
+            store_reg_bx(s, rd, val);
+        }
+        return true;
+    case STREG_SP_CHECK:
+        store_sp_checked(s, val);
+        return true;
+    case STREG_EXC_RET:
+        gen_exception_return(s, val);
+        return true;
+    }
+    g_assert_not_reached();
+}
+
+/*
+ * Data Processing (register)
+ *
+ * Operate, with set flags, one register source,
+ * one immediate shifted register source, and a destination.
+ */
+static bool op_s_rrr_shi(DisasContext *s, arg_s_rrr_shi *a,
+                         void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32),
+                         int logic_cc, StoreRegKind kind)
+{
+    TCGv_i32 tmp1, tmp2;
+
+    tmp2 = load_reg(s, a->rm);
+    gen_arm_shift_im(tmp2, a->shty, a->shim, logic_cc);
+    tmp1 = load_reg(s, a->rn);
+
+    gen(tmp1, tmp1, tmp2);
+    tcg_temp_free_i32(tmp2);
+
+    if (logic_cc) {
+        gen_logic_CC(tmp1);
+    }
+    return store_reg_kind(s, a->rd, tmp1, kind);
+}
+
+static bool op_s_rxr_shi(DisasContext *s, arg_s_rrr_shi *a,
+                         void (*gen)(TCGv_i32, TCGv_i32),
+                         int logic_cc, StoreRegKind kind)
+{
+    TCGv_i32 tmp;
+
+    tmp = load_reg(s, a->rm);
+    gen_arm_shift_im(tmp, a->shty, a->shim, logic_cc);
+
+    gen(tmp, tmp);
+    if (logic_cc) {
+        gen_logic_CC(tmp);
+    }
+    return store_reg_kind(s, a->rd, tmp, kind);
+}
+
+#define DO_ANY3(NAME, OP, L, K)                                         \
+    static bool trans_##NAME##_rrri(DisasContext *s, arg_s_rrr_shi *a)  \
+    { StoreRegKind k = (K); return op_s_rrr_shi(s, a, OP, L, k); }
+
+#define DO_ANY2(NAME, OP, L, K)                                         \
+    static bool trans_##NAME##_rxri(DisasContext *s, arg_s_rrr_shi *a)  \
+    { StoreRegKind k = (K); return op_s_rxr_shi(s, a, OP, L, k); }
+
+#define DO_CMP2(NAME, OP, L)                                            \
+    static bool trans_##NAME##_xrri(DisasContext *s, arg_s_rrr_shi *a)  \
+    { return op_s_rrr_shi(s, a, OP, L, STREG_NONE); }
+
+DO_ANY3(AND, tcg_gen_and_i32, a->s, STREG_NORMAL)
+DO_ANY3(EOR, tcg_gen_xor_i32, a->s, STREG_NORMAL)
+DO_ANY3(ORR, tcg_gen_or_i32, a->s, STREG_NORMAL)
+DO_ANY3(BIC, tcg_gen_andc_i32, a->s, STREG_NORMAL)
+
+DO_ANY3(RSB, a->s ? gen_rsb_CC : gen_rsb, false, STREG_NORMAL)
+DO_ANY3(ADC, a->s ? gen_adc_CC : gen_add_carry, false, STREG_NORMAL)
+DO_ANY3(SBC, a->s ? gen_sbc_CC : gen_sub_carry, false, STREG_NORMAL)
+DO_ANY3(RSC, a->s ? gen_rsc_CC : gen_rsc, false, STREG_NORMAL)
+
+DO_CMP2(TST, tcg_gen_and_i32, true)
+DO_CMP2(TEQ, tcg_gen_xor_i32, true)
+DO_CMP2(CMN, gen_add_CC, false)
+DO_CMP2(CMP, gen_sub_CC, false)
+
+DO_ANY3(ADD, a->s ? gen_add_CC : tcg_gen_add_i32, false,
+        a->rd == 13 && a->rn == 13 ? STREG_SP_CHECK : STREG_NORMAL)
+
+DO_ANY3(SUB, a->s ? gen_sub_CC : tcg_gen_sub_i32, false,
+        ({
+            StoreRegKind ret = STREG_NORMAL;
+            if (a->rd == 15 && a->s) {
+                /*
+                 * See ALUExceptionReturn:
+                 * In User mode, UNPREDICTABLE; we choose UNDEF.
+                 * In Hyp mode, UNDEFINED.
+                 */
+                if (IS_USER(s) || s->current_el == 2) {
+                    return false;
+                }
+                /* There is no writeback of nzcv to PSTATE.  */
+                a->s = 0;
+                ret = STREG_EXC_RET;
+            } else if (a->rd == 13 && a->rn == 13) {
+                ret = STREG_SP_CHECK;
+            }
+            ret;
+        }))
+
+DO_ANY2(MOV, tcg_gen_mov_i32, a->s,
+        ({
+            StoreRegKind ret = STREG_NORMAL;
+            if (a->rd == 15 && a->s) {
+                /*
+                 * See ALUExceptionReturn:
+                 * In User mode, UNPREDICTABLE; we choose UNDEF.
+                 * In Hyp mode, UNDEFINED.
+                 */
+                if (IS_USER(s) || s->current_el == 2) {
+                    return false;
+                }
+                /* There is no writeback of nzcv to PSTATE.  */
+                a->s = 0;
+                ret = STREG_EXC_RET;
+            } else if (a->rd == 13) {
+                ret = STREG_SP_CHECK;
+            }
+            ret;
+        }))
+
+DO_ANY2(MVN, tcg_gen_not_i32, a->s, STREG_NORMAL)
+
+/*
+ * ORN is only available with T32, so there is no register-shifted-register
+ * form of the insn.  Using the DO_ANY3 macro would create an unused function.
+ */
+static bool trans_ORN_rrri(DisasContext *s, arg_s_rrr_shi *a)
+{
+    return op_s_rrr_shi(s, a, tcg_gen_orc_i32, a->s, STREG_NORMAL);
+}
+
+#undef DO_ANY3
+#undef DO_ANY2
+#undef DO_CMP2
+
 /*
  * Legacy decoder.
  */
@@ -9277,13 +9468,6 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
     return true;
 }
 
-/* Return true if this is a Thumb-2 logical op.  */
-static int
-thumb2_logic_op(int op)
-{
-    return (op < 8);
-}
-
 /* Generate code for a Thumb-2 data processing operation.  If CONDS is nonzero
    then set condition code flags based on the result of the operation.
    If SHIFTER_OUT is nonzero then set the carry flag for logical operations
@@ -9371,8 +9555,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 addr;
     TCGv_i64 tmp64;
     int op;
-    int shiftop;
-    int conds;
     int logic_cc;
 
     /*
@@ -9802,33 +9984,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
         } else {
             /* Data processing register constant shift.  */
-            if (rn == 15) {
-                tmp = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp, 0);
-            } else {
-                tmp = load_reg(s, rn);
-            }
-            tmp2 = load_reg(s, rm);
-
-            shiftop = (insn >> 4) & 3;
-            shift = ((insn >> 6) & 3) | ((insn >> 10) & 0x1c);
-            conds = (insn & (1 << 20)) != 0;
-            logic_cc = (conds && thumb2_logic_op(op));
-            gen_arm_shift_im(tmp2, shiftop, shift, logic_cc);
-            if (gen_thumb2_data_op(s, op, conds, 0, tmp, tmp2))
-                goto illegal_op;
-            tcg_temp_free_i32(tmp2);
-            if (rd == 13 &&
-                ((op == 2 && rn == 15) ||
-                 (op == 8 && rn == 13) ||
-                 (op == 13 && rn == 13))) {
-                /* MOV SP, ... or ADD SP, SP, ... or SUB SP, SP, ... */
-                store_sp_checked(s, tmp);
-            } else if (rd != 15) {
-                store_reg(s, rd, tmp);
-            } else {
-                tcg_temp_free_i32(tmp);
-            }
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         }
         break;
     case 13: /* Misc data processing.  */
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index a3e6e8c1c2..b23e83f17c 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -21,3 +21,31 @@
 # All of the insn that have a COND field in insn[31:28] are here.
 # All insns that have 0xf in insn[31:28] are in a32-uncond.decode.
 #
+
+&s_rrr_shi       s rd rn rm shim shty
+
+# Data-processing (register)
+
+@s_rrr_shi       ---- ... .... s:1 rn:4 rd:4 shim:5 shty:2 . rm:4 \
+                 &s_rrr_shi
+@s_rxr_shi       ---- ... .... s:1 .... rd:4 shim:5 shty:2 . rm:4 \
+                 &s_rrr_shi rn=0
+@S_xrr_shi       ---- ... .... .   rn:4 .... shim:5 shty:2 . rm:4 \
+                 &s_rrr_shi s=1 rd=0
+
+AND_rrri         .... 000 0000 . .... .... ..... .. 0 ....    @s_rrr_shi
+EOR_rrri         .... 000 0001 . .... .... ..... .. 0 ....    @s_rrr_shi
+SUB_rrri         .... 000 0010 . .... .... ..... .. 0 ....    @s_rrr_shi
+RSB_rrri         .... 000 0011 . .... .... ..... .. 0 ....    @s_rrr_shi
+ADD_rrri         .... 000 0100 . .... .... ..... .. 0 ....    @s_rrr_shi
+ADC_rrri         .... 000 0101 . .... .... ..... .. 0 ....    @s_rrr_shi
+SBC_rrri         .... 000 0110 . .... .... ..... .. 0 ....    @s_rrr_shi
+RSC_rrri         .... 000 0111 . .... .... ..... .. 0 ....    @s_rrr_shi
+TST_xrri         .... 000 1000 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+TEQ_xrri         .... 000 1001 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+CMP_xrri         .... 000 1010 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+CMN_xrri         .... 000 1011 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+ORR_rrri         .... 000 1100 . .... .... ..... .. 0 ....    @s_rrr_shi
+MOV_rxri         .... 000 1101 . 0000 .... ..... .. 0 ....    @s_rxr_shi
+BIC_rrri         .... 000 1110 . .... .... ..... .. 0 ....    @s_rrr_shi
+MVN_rxri         .... 000 1111 . 0000 .... ..... .. 0 ....    @s_rxr_shi
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index ac01fb6958..7068596b99 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -18,3 +18,46 @@
 #
 # This file is processed by scripts/decodetree.py
 #
+
+&s_rrr_shi       !extern s rd rn rm shim shty
+
+# Data-processing (register)
+
+%imm5_12_6       12:3 6:2
+
+@s_rrr_shi       ....... .... s:1 rn:4 .... rd:4 .. shty:2 rm:4 \
+                 &s_rrr_shi shim=%imm5_12_6
+@s_rxr_shi       ....... .... s:1 .... .... rd:4 .. shty:2 rm:4 \
+                 &s_rrr_shi shim=%imm5_12_6 rn=0
+@S_xrr_shi       ....... .... .   rn:4 .... .... .. shty:2 rm:4 \
+                 &s_rrr_shi shim=%imm5_12_6 s=1 rd=0
+
+{
+  TST_xrri       1110101 0000 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  AND_rrri       1110101 0000 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+BIC_rrri         1110101 0001 . .... 0 ... .... .... ....     @s_rrr_shi
+{
+  MOV_rxri       1110101 0010 . 1111 0 ... .... .... ....     @s_rxr_shi
+  ORR_rrri       1110101 0010 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+{
+  MVN_rxri       1110101 0011 . 1111 0 ... .... .... ....     @s_rxr_shi
+  ORN_rrri       1110101 0011 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+{
+  TEQ_xrri       1110101 0100 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  EOR_rrri       1110101 0100 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+# PKHBT, PKHTB at opc1 = 0110
+{
+  CMN_xrri       1110101 1000 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  ADD_rrri       1110101 1000 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+ADC_rrri         1110101 1010 . .... 0 ... .... .... ....     @s_rrr_shi
+SBC_rrri         1110101 1011 . .... 0 ... .... .... ....     @s_rrr_shi
+{
+  CMP_xrri       1110101 1101 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  SUB_rrri       1110101 1101 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+RSB_rrri         1110101 1110 . .... 0 ... .... .... ....     @s_rrr_shi
-- 
2.17.1


