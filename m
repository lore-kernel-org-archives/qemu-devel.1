Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27837C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D0021841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JprZnie5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D0021841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX57v-0001x0-0E
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pS-0004hb-O9
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:23 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:40802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pQ-0007Cf-TQ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:22 -0400
Received: by mail-pj1-x1035.google.com with SMTP id fu13so4389200pjb.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bxUsBWRJww8ejhrlDwXgOXgiUwWOHVNz3+zWU3i5HOQ=;
 b=JprZnie5KakcICF8sZYB9lLGBDvCv1jG8Rq/RHKxt/wJTpIOXPuDQcOk06wI7YKE6G
 WngPiKGG2u/gCMWxW+WBf6HAtLS4FuEyBlE+e+O94IofjS91Q33B0BFjsmxmGmUu6+PA
 3nQ8bq0d5MpgnGvp9o3XTGvMtAaoQNXn7NG/8YZvQk+B6Gg34s3o5YFofUblVz1ebIaO
 rDAiuFHDLDbQOZ+lhFbmg1sEJ89tev7FXljYLYn2z5o4JCpLOZdL2sAYEpy1FWh0UcIw
 rRs9Bc8hhheh53+zXA2Z09ZVTf1/BKoZF2iQRvKmAPWM1AfiIGxr4+0uey6a7QLz7OpE
 u4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bxUsBWRJww8ejhrlDwXgOXgiUwWOHVNz3+zWU3i5HOQ=;
 b=UT+3g0Z/V3d7lOVpLO4lbLTBch1xibInI1p+PEhIXzqDHuL1WHMpOnC6SuIWDQv2Rt
 Si7B8tbMpeYlCv7GcLej2zgaVf7wYGm/MIlXMGUr0W0AXXd5boPLOyBxSFMla7/Jk3Xq
 S0jIyQc1wyEsszoqvwu3pF0GthJrKkkdtqyhhrqTAUt8liBp3tjeMWh55k3D2cxh80uh
 5sHFpgFMwoKqJON8xJ+euF6o61a5aVJyEnRBFvNwhw7J0ZtTyV1qI+CeXm99UqgJ1f1A
 4ZbSe982KxKRstl/+djoUQYIoDt55GP+m4+ZkOWqJ8nWXsUJh8F/igD08+8/G4yYPikz
 7X0w==
X-Gm-Message-State: AGi0PuZ4GGYpSw5HyCkwjESR1swX/Jw7Yggy/K1PXojbCkAcWkr9Diaa
 lVIuNVEas2VIUDmm0kjU7PmA7HTCUH4=
X-Google-Smtp-Source: APiQypJhE5Z2rYw3CDhljb5lqvPBFIlFmZ5zTYBQYjhfrPq7LgnO7dDRhnI/L42fCeWfV5xBR3KYsw==
X-Received: by 2002:a17:90a:eacb:: with SMTP id
 ev11mr6497620pjb.80.1588951337417; 
 Fri, 08 May 2020 08:22:17 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/16] target/arm: Remove fp_status from helper_{recpe,
 rsqrte}_u32
Date: Fri,  8 May 2020 08:21:55 -0700
Message-Id: <20200508152200.6547-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These operations do not touch fp_status.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  4 ++--
 target/arm/translate-a64.c |  5 ++---
 target/arm/translate.c     | 12 ++----------
 target/arm/vfp_helper.c    |  4 ++--
 4 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 33c76192d2..aed3050965 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -211,8 +211,8 @@ DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_2(recpe_u32, i32, i32, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32, ptr)
+DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
+DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i32, i32, i32, ptr, i32)
 
 DEF_HELPER_3(shl_cc, i32, env, i32, i32)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ea5f6ceadc..367fa403ae 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9699,7 +9699,7 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
 
             switch (opcode) {
             case 0x3c: /* URECPE */
-                gen_helper_recpe_u32(tcg_res, tcg_op, fpst);
+                gen_helper_recpe_u32(tcg_res, tcg_op);
                 break;
             case 0x3d: /* FRECPE */
                 gen_helper_recpe_f32(tcg_res, tcg_op, fpst);
@@ -12244,7 +12244,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            need_fpstatus = true;
             break;
         case 0x1e: /* FRINT32Z */
         case 0x1f: /* FRINT64Z */
@@ -12412,7 +12411,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_rints_exact(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x7c: /* URSQRTE */
-                    gen_helper_rsqrte_u32(tcg_res, tcg_op, tcg_fpstatus);
+                    gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
                 case 0x1e: /* FRINT32Z */
                 case 0x5e: /* FRINT32X */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 72c3aab544..676701143b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6873,19 +6873,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             break;
                         }
                         case NEON_2RM_VRECPE:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_recpe_u32(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
+                            gen_helper_recpe_u32(tmp, tmp);
                             break;
-                        }
                         case NEON_2RM_VRSQRTE:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_rsqrte_u32(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
+                            gen_helper_rsqrte_u32(tmp, tmp);
                             break;
-                        }
                         case NEON_2RM_VRECPE_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 930d6e747f..a792661166 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1023,7 +1023,7 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
     return make_float64(val);
 }
 
-uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
+uint32_t HELPER(recpe_u32)(uint32_t a)
 {
     /* float_status *s = fpstp; */
     int input, estimate;
@@ -1038,7 +1038,7 @@ uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
     return deposit32(0, (32 - 9), 9, estimate);
 }
 
-uint32_t HELPER(rsqrte_u32)(uint32_t a, void *fpstp)
+uint32_t HELPER(rsqrte_u32)(uint32_t a)
 {
     int estimate;
 
-- 
2.20.1


