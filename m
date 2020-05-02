Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC3AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96F7206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3nZdk4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96F7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV10K-0001Ow-0o
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0ss-0003GS-85
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0sr-0004k5-4w
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:43074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sq-0004jn-Dz
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id v63so3530532pfb.10
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VEa8/NpiWarpCAFc/pG+GmiGCs6Kk+JgIooeJUPrPpQ=;
 b=q3nZdk4jfh59jQCCFRlwN4SYs/oRjr5cSufqk8QzQhppB271N1pQ52/YgKuuqa4HP7
 aYBVPMQwIo9TdjHyRjEq39r3GkdIEJQdx3Rf9drAD/V9W08MdL0Eh8ddAeu8ZQX14AzA
 o/MDAzAOdHeOGtuR8mA+RGHK/dkysPlV4XZ8gek8JZed2DyTuVhiGZJh5LCC7Bk6RdBk
 uUAJDpdFZXiVO6zT5ATdER+DSOEKH2YTFGQBDhA5Z6D7qSZyT6ITrEycCWAr88Ln71bz
 z3qeaHoti5GQd0S3zGrxX0JJpmlkyoXU7rQwxtYxkMqG8NuJ5rCopcaVPc8b1Y/oJ9sv
 dHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VEa8/NpiWarpCAFc/pG+GmiGCs6Kk+JgIooeJUPrPpQ=;
 b=A74PT6yxJZf3SDQbOmIBHKCu6OrL+7YPjjT7vigitvAVuoBIodVrPZHGTyMc2nlufP
 F54PaMpgzS6McRb6Ep+UnTayfSiBehj+yN8wLs8qO3y8XgwK3RCslBC6FzV6nxoFswVK
 1DhfaqTpQAus8F7E1Vh6lbYvqlaRCDNkV+iNjtbk3CyiEkcRpov5My3ZzmyLpyd+2Ds1
 pT8imJDA0q97JoaoLd3adL36/v3jkJHK18b6MHhTbsj4h2oyaVNHG+tjfLdvoqy1jmD3
 84qROKkxbA8wkMjGxmZFfqrmFbuUn9qkfinkrdyo/8yLq4McC29rDcEhXff2q4B+B40k
 vqvA==
X-Gm-Message-State: AGi0PuZOTM4rYqOOvuM+tDA9ftbGn1+1cfiPq4cl40JfVYDd5H0j5312
 8KxxlzDdr9vMX7bYydzQLp1TKuiTmJc=
X-Google-Smtp-Source: APiQypIK+BHctgt4lX0Zfyi22wX72hjKEWCNZVkgAVynf+NYn0Ytl0RsZB+e85mqfJFiWcJD16S0rw==
X-Received: by 2002:aa7:8eca:: with SMTP id b10mr10573920pfr.4.1588459518699; 
 Sat, 02 May 2020 15:45:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/15] target/arm: Remove fp_status from helper_{recpe,
 rsqrte}_u32
Date: Sat,  2 May 2020 15:44:58 -0700
Message-Id: <20200502224503.2282-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::42a
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
index eeaa92b9f1..4d5cdcef2f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9716,7 +9716,7 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
 
             switch (opcode) {
             case 0x3c: /* URECPE */
-                gen_helper_recpe_u32(tcg_res, tcg_op, fpst);
+                gen_helper_recpe_u32(tcg_res, tcg_op);
                 break;
             case 0x3d: /* FRECPE */
                 gen_helper_recpe_f32(tcg_res, tcg_op, fpst);
@@ -12261,7 +12261,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            need_fpstatus = true;
             break;
         case 0x1e: /* FRINT32Z */
         case 0x1f: /* FRINT64Z */
@@ -12429,7 +12428,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_rints_exact(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x7c: /* URSQRTE */
-                    gen_helper_rsqrte_u32(tcg_res, tcg_op, tcg_fpstatus);
+                    gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
                 case 0x1e: /* FRINT32Z */
                 case 0x5e: /* FRINT32X */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8e6c6f7b00..a5bb4b0040 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7265,19 +7265,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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


