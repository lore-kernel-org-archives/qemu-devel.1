Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C8C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D7020658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/edcjH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D7020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbg6-0007yZ-5E
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcG-0001uE-3J
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcE-0001Hj-SA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:46788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcE-0001Gx-N2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:46 -0400
Received: by mail-pl1-x629.google.com with SMTP id s23so2720978plq.13
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HkqstrAP2B7IxXW64bwy+CKbvFuSsclyXxBa82r0Wh4=;
 b=u/edcjH8d9Y7t/gbupmzjmDrvCYtvDAHHPG9LbB/qWyLc/VUn0n/9SK6TVTqezET1g
 Z9aPfYv14+ZrYHuWh2UkRfrtewc0X+z45eY86y7772g9W65A3Mx+IfMg4H8ggbPE+btq
 LUt6CiuDsRpUANEkoS8AmTUC99DH1ZXH0G1v8/hV6ghpuk3ZLZaVLctQNLTENnGmf/UA
 Euy0wbCbm8VbRdse5etjgTmi5wmOePIfSMhxxzaodZldDn0gfmrshMViMUTcwL7JZRCh
 nAHAT8PF3M0ZR4K/dRDex2X/a0ZZH1awmCYcYlBPOylBnVxl5s6jTAuUgdprVhfHFaVq
 1v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HkqstrAP2B7IxXW64bwy+CKbvFuSsclyXxBa82r0Wh4=;
 b=hSrlz0PwLfwFEKaPZgKlFZ2KSnSR2K41XnmjO8k2kWLUjjNkyZbpi1QhCNBkxZKO4+
 +PqrbtJzq2rITnyttfLdbL1aDfB7XJbiQoc8/LXs8Cy9nc7rGmHHetsSwYjl/d4BiDN7
 f7nthJuf1qgTSO5r1PPNYVz6U/C8pN66JX5fiCl2tbNzgL6sGX1KeNs8RnBvVoBzagjq
 UvRZbcaEFuQMSXmhIl//vH2D2SYk6OHc0YF4rB6+n24wzShdRingqyALzLNQtjElOyej
 t++4lGsqPtI0PViF0IQud+6popD6avvO41Otcv2FbWOT6931s2zW7RJzq5JlHO9891k+
 PbPA==
X-Gm-Message-State: ANhLgQ2aukKn49Pu+cslILLwti0XZjDXAONHL7xdOofstAOzbXWeXmvc
 8Jgkp2mbsyXzGpWVlw3EU6+rUIoNVtA=
X-Google-Smtp-Source: ADFU+vthDshpht7UzEYS7uRBokWn1T8HtqNrEMCM3+K4NdsBfIrYjGlCurUM7Rygqwyz1unpHWOw4A==
X-Received: by 2002:a17:902:82c5:: with SMTP id
 u5mr10729656plz.254.1585264125357; 
 Thu, 26 Mar 2020 16:08:45 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/31] target/arm: Remove fp_status from helper_{recpe,
 rsqrte}_u32
Date: Thu, 26 Mar 2020 16:08:11 -0700
Message-Id: <20200326230838.31112-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
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
index 80bc129763..938fdbc362 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -213,8 +213,8 @@ DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
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
index db41e3d72a..2bcf643069 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10220,7 +10220,7 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
 
             switch (opcode) {
             case 0x3c: /* URECPE */
-                gen_helper_recpe_u32(tcg_res, tcg_op, fpst);
+                gen_helper_recpe_u32(tcg_res, tcg_op);
                 break;
             case 0x3d: /* FRECPE */
                 gen_helper_recpe_f32(tcg_res, tcg_op, fpst);
@@ -12802,7 +12802,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            need_fpstatus = true;
             break;
         case 0x1e: /* FRINT32Z */
         case 0x1f: /* FRINT64Z */
@@ -12970,7 +12969,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_rints_exact(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x7c: /* URSQRTE */
-                    gen_helper_rsqrte_u32(tcg_res, tcg_op, tcg_fpstatus);
+                    gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
                 case 0x1e: /* FRINT32Z */
                 case 0x5e: /* FRINT32X */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b38af6149a..cba84987db 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6711,19 +6711,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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


