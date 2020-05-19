Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17CDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6307C2072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mw+ZNBWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6307C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9m7-0001Pg-IF
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9jU-0006cB-48
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:25:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9jQ-0005yX-0c
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:25:03 -0400
Received: by mail-pf1-x444.google.com with SMTP id n15so513550pfd.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RhGbNNl/BQMyjtUlDzXdTl/WP4OX7gSer22iwrANAWc=;
 b=Mw+ZNBWaXokO10anNAOdRkqknWh9/88wylVZM4+N5TBLxm1bckd3kEBWNyMsw37Ow7
 Khq9mVo/pE/MlIvSXRPZGtpsv7dZCX1UvvRhcCitU0PQ+qOiMnOjGYTbJz43Ei/ueOT1
 b6D/lbLW7GBDeq5ns3EgmcdmI7jBVHfuoXCM79vQ+pTqaXDzkoI8Gka+n1Qsn52lkXgQ
 P9xddrZaxxzsB+H63D/NKaaR/L2DpYCUY2PBp+MLPjZ8/0sbl2HAGzfS20F3XugyGNFf
 s3mr6nH81IXFRa77u2+UXeeJeN56BEmzwS2jCFcRSh7GBkPDCO5uktF1DAUwHC3w2Sm9
 vMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RhGbNNl/BQMyjtUlDzXdTl/WP4OX7gSer22iwrANAWc=;
 b=icnFmxV6nJeFk4vU3N98byyb/sQVq9Ytany5Y0YduDxwjVstXz9m9SFTetKg6+Fu4N
 9ElA/yt+XOyAY4KCHp1mgA6QbQGSUVHlMZq7oAkJu8bvyAW0lWHmxUsoV02br39aACHK
 D5A6G3xuylXmIaJtI1BU4lhLd1NLuJssWDHHIFJwgO745idkjTZQ2WFXf1bAPOWWYzjw
 6GKo1qFgKi+qxeqVnW15Zq7P0fzW0GRARxYxXrjfOh90ZNdZFgSrICweDYaL7dpYtnSL
 E6Vtx+SMi8olZSXHm2B62HDt5PaQu/L6KnLxJuigceJ2bwk8VnFwM3bsJP213nBzv/TR
 8poA==
X-Gm-Message-State: AOAM532F+1XB2dneoizwox51VkvlX2EdbOkGQee3QY6IJaccxD4UofzF
 8NGqDHmKsdpC7vEmJU8IuIi4MKixMxk=
X-Google-Smtp-Source: ABdhPJyIer26JHMwL2QanrnZBV8vACrahSkISCBc1TO2VhzMMuFescaWrf87gB3nzSpftBlDJJm54w==
X-Received: by 2002:a62:804c:: with SMTP id j73mr1041958pfd.214.1589923498249; 
 Tue, 19 May 2020 14:24:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id v5sm386134pjy.4.2020.05.19.14.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 14:24:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] target/arm: Use clear_vec_high more effectively
Date: Tue, 19 May 2020 14:24:53 -0700
Message-Id: <20200519212453.28494-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519212453.28494-1-richard.henderson@linaro.org>
References: <20200519212453.28494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not explicitly store zero to the NEON high part
when we can pass !is_q to clear_vec_high.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 53 +++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4f6edb2892..874f3eb4f9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -900,11 +900,10 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
 {
     /* This always zero-extends and writes to a full 128 bit wide vector */
     TCGv_i64 tmplo = tcg_temp_new_i64();
-    TCGv_i64 tmphi;
+    TCGv_i64 tmphi = NULL;
 
     if (size < 4) {
         MemOp memop = s->be_data + size;
-        tmphi = tcg_const_i64(0);
         tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), memop);
     } else {
         bool be = s->be_data == MO_BE;
@@ -922,12 +921,13 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
     }
 
     tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_64));
-    tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
-
     tcg_temp_free_i64(tmplo);
-    tcg_temp_free_i64(tmphi);
 
-    clear_vec_high(s, true, destidx);
+    if (tmphi) {
+        tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
+        tcg_temp_free_i64(tmphi);
+    }
+    clear_vec_high(s, tmphi != NULL, destidx);
 }
 
 /*
@@ -6934,7 +6934,6 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
             read_vec_element(s, tcg_resh, rm, 0, MO_64);
             do_ext64(s, tcg_resh, tcg_resl, pos);
         }
-        tcg_gen_movi_i64(tcg_resh, 0);
     } else {
         TCGv_i64 tcg_hh;
         typedef struct {
@@ -6964,9 +6963,11 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+    }
     tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+    clear_vec_high(s, is_q, rd);
 }
 
 /* TBL/TBX
@@ -7003,17 +7004,21 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
      * the input.
      */
     tcg_resl = tcg_temp_new_i64();
-    tcg_resh = tcg_temp_new_i64();
+    tcg_resh = NULL;
 
     if (is_tblx) {
         read_vec_element(s, tcg_resl, rd, 0, MO_64);
     } else {
         tcg_gen_movi_i64(tcg_resl, 0);
     }
-    if (is_tblx && is_q) {
-        read_vec_element(s, tcg_resh, rd, 1, MO_64);
-    } else {
-        tcg_gen_movi_i64(tcg_resh, 0);
+
+    if (is_q) {
+        tcg_resh = tcg_temp_new_i64();
+        if (is_tblx) {
+            read_vec_element(s, tcg_resh, rd, 1, MO_64);
+        } else {
+            tcg_gen_movi_i64(tcg_resh, 0);
+        }
     }
 
     tcg_idx = tcg_temp_new_i64();
@@ -7033,9 +7038,12 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+        tcg_temp_free_i64(tcg_resh);
+    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /* ZIP/UZP/TRN
@@ -7072,7 +7080,7 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
     }
 
     tcg_resl = tcg_const_i64(0);
-    tcg_resh = tcg_const_i64(0);
+    tcg_resh = is_q ? tcg_const_i64(0) : NULL;
     tcg_res = tcg_temp_new_i64();
 
     for (i = 0; i < elements; i++) {
@@ -7123,9 +7131,12 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+        tcg_temp_free_i64(tcg_resh);
+    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /*
-- 
2.20.1


