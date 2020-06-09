Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D690C20760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wl7jLXba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690C20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigr6-00070z-Od
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighk-0003PN-Nb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighj-0003Ri-3S
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id l10so21906450wrr.10
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S5WzoDYbeVcdXuyj3sF0aRlTViUlM9wFEwqSYBzRTDk=;
 b=Wl7jLXbaFHltntG2sRu3d5abw6E3ZYazurZyGEwXA4nWRa8Ydfx2rVOZlbs1+8psv1
 kCWC5Xr8dZIOtp3SHr06ZA2tXHG3fO8+V3I8nYlqTM49rdsqHdkCIMlBeEqARv0q1ZB6
 O5qhdtcGSTmToz2JOz/IaM0e5/Q0ScxP7Fn5f6jp0Lf0LEjVLqb9FXDrGfq+Q9JLM/l9
 rX01RS9vs3kVrJpl236/PYg6nqEDGqjkVnAB3sTYiYVfH9gkbnY0Xt1Y2fjgFdOtYiMm
 wnKWjDLJLtYKN3N2zA0Y6OQRJhe97YIozZGIWY2j0wE7ho2nyXbJLFwNA5nm+19NX1qZ
 MO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S5WzoDYbeVcdXuyj3sF0aRlTViUlM9wFEwqSYBzRTDk=;
 b=YxoKS2FnvlTvTbstdlOl7R8lh7gxCoRhpK2msdXLhFdt3kai33yMY/guFxNsvCBXlY
 lduwyihsrk+kcCDsT1vv74YQ0PLFvxnhIQJ2hljqeCyrUciUgeoS5HwPv7vTvvYGHxuZ
 gQfvHgrBFwv0TqttfrLNrKTwNHsmplHf+vo1KcfMi7On6pQ2JTYbK+SiJa5UkCKRQkcA
 m4do9tmqfnq1BOKUcVkiScuqPY/UZU6BcGTY4KnGKIVaOXJDy9U8Bnmz3srs7oLYKL3/
 wsCyRZN/GnZ4H69su0Rmj0dabacKQLtwwzyK2pQ4aMJ7TqrK5ttdRQvbOTqzlHATxVs2
 VIkg==
X-Gm-Message-State: AOAM531W+qDursgy5TyVtifxXIvfEmiKUwgTng1MjO89rbGuNyig82mQ
 oMExsjrLkz1kXGpPEqCqdrFekQ==
X-Google-Smtp-Source: ABdhPJxRJ3lqhb+gKu71N1z//53msZj2pp3V46o+Ob1oeCuT01kwQ+fi/AMIHmskm/lTxH3fK/uV3w==
X-Received: by 2002:a5d:4948:: with SMTP id r8mr5111561wrs.290.1591718540792; 
 Tue, 09 Jun 2020 09:02:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b81sm3699867wmc.5.2020.06.09.09.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:02:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/arm: Convert Neon 3-reg-diff saturating doubling
 multiplies
Date: Tue,  9 Jun 2020 17:02:08 +0100
Message-Id: <20200609160209.29960-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
References: <20200609160209.29960-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon 3-reg-diff insns VQDMULL, VQDMLAL and VQDMLSL:
these are all saturating doubling long multiplies with a possible
accumulate step.

These are the last insns in the group which use the pass-over-each
elements loop, so we can delete that code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  6 +++
 target/arm/translate-neon.inc.c | 82 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 59 ++----------------------
 3 files changed, 92 insertions(+), 55 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 1da492df146..65ea30d3edf 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -454,10 +454,16 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VMLAL_S_3d   1111 001 0 1 . .. .... .... 1000 . 0 . 0 .... @3diff
     VMLAL_U_3d   1111 001 1 1 . .. .... .... 1000 . 0 . 0 .... @3diff
 
+    VQDMLAL_3d   1111 001 0 1 . .. .... .... 1001 . 0 . 0 .... @3diff
+
     VMLSL_S_3d   1111 001 0 1 . .. .... .... 1010 . 0 . 0 .... @3diff
     VMLSL_U_3d   1111 001 1 1 . .. .... .... 1010 . 0 . 0 .... @3diff
 
+    VQDMLSL_3d   1111 001 0 1 . .. .... .... 1011 . 0 . 0 .... @3diff
+
     VMULL_S_3d   1111 001 0 1 . .. .... .... 1100 . 0 . 0 .... @3diff
     VMULL_U_3d   1111 001 1 1 . .. .... .... 1100 . 0 . 0 .... @3diff
+
+    VQDMULL_3d   1111 001 0 1 . .. .... .... 1101 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 00a779c65a0..5965b5ed845 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2222,3 +2222,85 @@ DO_VMLAL(VMLAL_S,mull_s,add)
 DO_VMLAL(VMLAL_U,mull_u,add)
 DO_VMLAL(VMLSL_S,mull_s,sub)
 DO_VMLAL(VMLSL_U,mull_u,sub)
+
+static void gen_VQDMULL_16(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_helper_neon_mull_s16(rd, rn, rm);
+    gen_helper_neon_addl_saturate_s32(rd, cpu_env, rd, rd);
+}
+
+static void gen_VQDMULL_32(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_mull_s32(rd, rn, rm);
+    gen_helper_neon_addl_saturate_s64(rd, cpu_env, rd, rd);
+}
+
+static bool trans_VQDMULL_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static void gen_VQDMLAL_acc_16(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    gen_helper_neon_addl_saturate_s32(rd, cpu_env, rn, rm);
+}
+
+static void gen_VQDMLAL_acc_32(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    gen_helper_neon_addl_saturate_s64(rd, cpu_env, rn, rm);
+}
+
+static bool trans_VQDMLAL_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+    NeonGenTwo64OpFn *accfn[] = {
+        NULL,
+        gen_VQDMLAL_acc_16,
+        gen_VQDMLAL_acc_32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], accfn[a->size]);
+}
+
+static void gen_VQDMLSL_acc_16(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    gen_helper_neon_negl_u32(rm, rm);
+    gen_helper_neon_addl_saturate_s32(rd, cpu_env, rn, rm);
+}
+
+static void gen_VQDMLSL_acc_32(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_neg_i64(rm, rm);
+    gen_helper_neon_addl_saturate_s64(rd, cpu_env, rn, rm);
+}
+
+static bool trans_VQDMLSL_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+    NeonGenTwo64OpFn *accfn[] = {
+        NULL,
+        gen_VQDMLSL_acc_16,
+        gen_VQDMLSL_acc_32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], accfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a2c47d19f21..88e91845c02 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5247,11 +5247,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
                     {0, 0, 0, 7}, /* VABDL */
                     {0, 0, 0, 7}, /* VMLAL */
-                    {0, 0, 0, 9}, /* VQDMLAL */
+                    {0, 0, 0, 7}, /* VQDMLAL */
                     {0, 0, 0, 7}, /* VMLSL */
-                    {0, 0, 0, 9}, /* VQDMLSL */
+                    {0, 0, 0, 7}, /* VQDMLSL */
                     {0, 0, 0, 7}, /* Integer VMULL */
-                    {0, 0, 0, 9}, /* VQDMULL */
+                    {0, 0, 0, 7}, /* VQDMULL */
                     {0, 0, 0, 0xa}, /* Polynomial VMULL */
                     {0, 0, 0, 7}, /* Reserved: always UNDEF */
                 };
@@ -5282,58 +5282,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     return 0;
                 }
-
-                /* Avoid overlapping operands.  Wide source operands are
-                   always aligned so will never overlap with wide
-                   destinations in problematic ways.  */
-                if (rd == rm) {
-                    tmp = neon_load_reg(rm, 1);
-                    neon_store_scratch(2, tmp);
-                } else if (rd == rn) {
-                    tmp = neon_load_reg(rn, 1);
-                    neon_store_scratch(2, tmp);
-                }
-                tmp3 = NULL;
-                for (pass = 0; pass < 2; pass++) {
-                    if (pass == 1 && rd == rn) {
-                        tmp = neon_load_scratch(2);
-                    } else {
-                        tmp = neon_load_reg(rn, pass);
-                    }
-                    if (pass == 1 && rd == rm) {
-                        tmp2 = neon_load_scratch(2);
-                    } else {
-                        tmp2 = neon_load_reg(rm, pass);
-                    }
-                    switch (op) {
-                    case 9: case 11: case 13:
-                        /* VQDMLAL, VQDMLSL, VQDMULL */
-                        gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
-                        break;
-                    default: /* 15 is RESERVED: caught earlier  */
-                        abort();
-                    }
-                    if (op == 13) {
-                        /* VQDMULL */
-                        gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    } else {
-                        /* Accumulate.  */
-                        neon_load_reg64(cpu_V1, rd + pass);
-                        switch (op) {
-                        case 9: case 11: /* VQDMLAL, VQDMLSL */
-                            gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
-                            if (op == 11) {
-                                gen_neon_negl(cpu_V0, size);
-                            }
-                            gen_neon_addl_saturate(cpu_V0, cpu_V1, size);
-                            break;
-                        default:
-                            abort();
-                        }
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    }
-                }
+                abort(); /* all others handled by decodetree */
             } else {
                 /* Two registers and a scalar. NB that for ops of this form
                  * the ARM ARM labels bit 24 as Q, but it is in our variable
-- 
2.20.1


