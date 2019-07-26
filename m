Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FA0C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F96B21842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKWa8HfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F96B21842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Z8-0002pZ-Az
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NP-0005AH-Ps
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NN-0000hK-CP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NN-0000fy-5Y
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id k8so25034775plt.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=08mhmhwkN3rkpLTk3jFBP+0Hu2kGOWCoL5BouMwfU6w=;
 b=CKWa8HfR9M4ax+fBilew63DupBxNirusUrVU6GEhWank7AMnsG3Xuar5LKv6kNOdH+
 xI09ZqoB1Cx2kGMKjLHImp7O9yc6hZ6vJuTqwn7WN6WBMfHGMsQBjPLgjqOHy0QpjKVE
 1ClNKVRpnkeo8boNTDDIe6h+wUd/t/OQSjZBc3VP478Mf4SsKZ7xnsiSZQl3oBb+P+zR
 On7vlSVWwNjO/g/RA6v5uKwLxLbiI1pttIh7uPJ1Zjgm+v9poP8UUqiv5wFvNPbkWdMb
 B8upzMzojx19NB0/TxFOcsMVx+awy/PXDScybyuwIjk3PieWyv9CYZpKUWRegF6ZF+Ft
 EIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=08mhmhwkN3rkpLTk3jFBP+0Hu2kGOWCoL5BouMwfU6w=;
 b=kUU0HN6dmJNkzdxeM6gzhAN2eXDB6A3AEEj6XXiCTVvZt77ZIbBilAd+vKwmsrBJAY
 M8la+oN2N1KVyC6nXOHjcqMgdnE+6lvX85TZ0FLD+eOeZf6fJc4SoL/sn841uANuZagt
 nTlcH0fu2ad4wHzWKV/6cKCG4hRD1aerhR6O327h6WjP4b/HIKHLPMJQsNBpZKFoHjak
 eo5/H/BKShuUhcmyK5D3PerOReipybSSEI5wrqsnpnF9rgcPTlP8PQpsVKzXjXb6bDwU
 BkdrRz5W3sIeXLIUe3+NxlnQE1PLI1pmwetdH0XVz6JeVscySBTe82cdeDI7Qrd2FmXs
 rvKw==
X-Gm-Message-State: APjAAAVhJFHYB7Tj2wRa0reiOCoKeDzw8kZ12ix+DVhcIOh5fFHw591Z
 zSkTxS5YbijuH//4qzDmBnYOGoOVPYQ=
X-Google-Smtp-Source: APXvYqzr9gcRaCHdCZwcAo9Wkm/RN6GDOvBtF43z3iZv8VhRNB9n1IJcksSKK2SDBTaheUGbiPMe/w==
X-Received: by 2002:a17:902:934a:: with SMTP id
 g10mr99350967plp.18.1564163487973; 
 Fri, 26 Jul 2019 10:51:27 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:09 -0700
Message-Id: <20190726175032.6769-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 44/67] target/arm: Convert T16 data-processing
 (two low regs)
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
 target/arm/translate.c | 152 ++---------------------------------------
 target/arm/t16.decode  |  36 ++++++++++
 2 files changed, 43 insertions(+), 145 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index db93b12608..17a0eea425 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -486,13 +486,6 @@ static inline void gen_logic_CC(TCGv_i32 var)
     tcg_gen_mov_i32(cpu_ZF, var);
 }
 
-/* T0 += T1 + CF.  */
-static void gen_adc(TCGv_i32 t0, TCGv_i32 t1)
-{
-    tcg_gen_add_i32(t0, t0, t1);
-    tcg_gen_add_i32(t0, t0, cpu_CF);
-}
-
 /* dest = T0 + T1 + CF. */
 static void gen_add_carry(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 {
@@ -7590,6 +7583,11 @@ static int t32_branch24(DisasContext *s, int x)
     return x << 1;
 }
 
+static int t16_setflags(DisasContext *s, int x)
+{
+    return s->condexec_mask == 0;
+}
+
 /*
  * Include the generated decoders.
  * Note that the T32 decoder reuses some of the trans_* functions
@@ -10751,145 +10749,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
         /*
          * 0b0100_00xx_xxxx_xxxx
-         *  - Data-processing (two low registers)
+         *  - Data-processing (two low registers), in decodetree
          */
-        rd = insn & 7;
-        rm = (insn >> 3) & 7;
-        op = (insn >> 6) & 0xf;
-        if (op == 2 || op == 3 || op == 4 || op == 7) {
-            /* the shift/rotate ops want the operands backwards */
-            val = rm;
-            rm = rd;
-            rd = val;
-            val = 1;
-        } else {
-            val = 0;
-        }
-
-        if (op == 9) { /* neg */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, 0);
-        } else if (op != 0xf) { /* mvn doesn't read its first operand */
-            tmp = load_reg(s, rd);
-        } else {
-            tmp = NULL;
-        }
-
-        tmp2 = load_reg(s, rm);
-        switch (op) {
-        case 0x0: /* and */
-            tcg_gen_and_i32(tmp, tmp, tmp2);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            break;
-        case 0x1: /* eor */
-            tcg_gen_xor_i32(tmp, tmp, tmp2);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            break;
-        case 0x2: /* lsl */
-            if (s->condexec_mask) {
-                gen_shl(tmp2, tmp2, tmp);
-            } else {
-                gen_helper_shl_cc(tmp2, cpu_env, tmp2, tmp);
-                gen_logic_CC(tmp2);
-            }
-            break;
-        case 0x3: /* lsr */
-            if (s->condexec_mask) {
-                gen_shr(tmp2, tmp2, tmp);
-            } else {
-                gen_helper_shr_cc(tmp2, cpu_env, tmp2, tmp);
-                gen_logic_CC(tmp2);
-            }
-            break;
-        case 0x4: /* asr */
-            if (s->condexec_mask) {
-                gen_sar(tmp2, tmp2, tmp);
-            } else {
-                gen_helper_sar_cc(tmp2, cpu_env, tmp2, tmp);
-                gen_logic_CC(tmp2);
-            }
-            break;
-        case 0x5: /* adc */
-            if (s->condexec_mask) {
-                gen_adc(tmp, tmp2);
-            } else {
-                gen_adc_CC(tmp, tmp, tmp2);
-            }
-            break;
-        case 0x6: /* sbc */
-            if (s->condexec_mask) {
-                gen_sub_carry(tmp, tmp, tmp2);
-            } else {
-                gen_sbc_CC(tmp, tmp, tmp2);
-            }
-            break;
-        case 0x7: /* ror */
-            if (s->condexec_mask) {
-                tcg_gen_andi_i32(tmp, tmp, 0x1f);
-                tcg_gen_rotr_i32(tmp2, tmp2, tmp);
-            } else {
-                gen_helper_ror_cc(tmp2, cpu_env, tmp2, tmp);
-                gen_logic_CC(tmp2);
-            }
-            break;
-        case 0x8: /* tst */
-            tcg_gen_and_i32(tmp, tmp, tmp2);
-            gen_logic_CC(tmp);
-            rd = 16;
-            break;
-        case 0x9: /* neg */
-            if (s->condexec_mask)
-                tcg_gen_neg_i32(tmp, tmp2);
-            else
-                gen_sub_CC(tmp, tmp, tmp2);
-            break;
-        case 0xa: /* cmp */
-            gen_sub_CC(tmp, tmp, tmp2);
-            rd = 16;
-            break;
-        case 0xb: /* cmn */
-            gen_add_CC(tmp, tmp, tmp2);
-            rd = 16;
-            break;
-        case 0xc: /* orr */
-            tcg_gen_or_i32(tmp, tmp, tmp2);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            break;
-        case 0xd: /* mul */
-            tcg_gen_mul_i32(tmp, tmp, tmp2);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            break;
-        case 0xe: /* bic */
-            tcg_gen_andc_i32(tmp, tmp, tmp2);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            break;
-        case 0xf: /* mvn */
-            tcg_gen_not_i32(tmp2, tmp2);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp2);
-            val = 1;
-            rm = rd;
-            break;
-        }
-        if (rd != 16) {
-            if (val) {
-                store_reg(s, rm, tmp2);
-                if (op != 0xf)
-                    tcg_temp_free_i32(tmp);
-            } else {
-                store_reg(s, rd, tmp);
-                tcg_temp_free_i32(tmp2);
-            }
-        } else {
-            tcg_temp_free_i32(tmp);
-            tcg_temp_free_i32(tmp2);
-        }
-        break;
+        goto illegal_op;
 
     case 5:
         /* load/store register offset.  */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index e954f61fe4..9833fc97e7 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -18,3 +18,39 @@
 #
 # This file is processed by scripts/decodetree.py
 #
+
+&s_rrr_shi       !extern s rd rn rm shim shty
+&s_rrr_shr       !extern s rn rd rm rs shty
+&s_rri_rot       !extern s rn rd imm rot
+&s_rrrr          !extern s rd rn rm ra
+
+# Set S if the instruction is outside of an IT block.
+%s               !function=t16_setflags
+
+# Data-processing (two low registers)
+
+%reg_0           0:3
+
+@lll_noshr       ...... .... rm:3 rd:3 \
+                 &s_rrr_shi %s rn=%reg_0 shim=0 shty=0
+@xll_noshr       ...... .... rm:3 rn:3 \
+                 &s_rrr_shi s=1 rd=0 shim=0 shty=0
+@lxl_shr         ...... .... rs:3 rd:3 \
+                 &s_rrr_shr %s rm=%reg_0 rn=0
+
+AND_rrri         010000 0000 ... ...            @lll_noshr
+EOR_rrri         010000 0001 ... ...            @lll_noshr
+MOV_rrrr         010000 0010 ... ...            @lxl_shr shty=0  # LSL
+MOV_rrrr         010000 0011 ... ...            @lxl_shr shty=1  # LSR
+MOV_rrrr         010000 0100 ... ...            @lxl_shr shty=2  # ASR
+ADC_rrri         010000 0101 ... ...            @lll_noshr
+SBC_rrri         010000 0110 ... ...            @lll_noshr
+MOV_rrrr         010000 0111 ... ...            @lxl_shr shty=3  # ROR
+TST_rrri         010000 1000 ... ...            @xll_noshr
+RSB_rri          010000 1001 rn:3 rd:3          &s_rri_rot %s imm=0 rot=0
+CMP_rrri         010000 1010 ... ...            @xll_noshr
+CMN_rrri         010000 1011 ... ...            @xll_noshr
+ORR_rrri         010000 1100 ... ...            @lll_noshr
+MUL              010000 1101 rn:3 rd:3          &s_rrrr %s rm=%reg_0 ra=0
+BIC_rrri         010000 1110 ... ...            @lll_noshr
+MVN_rrri         010000 1111 ... ...            @lll_noshr
-- 
2.17.1


