Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B7C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4D720776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XT2xetT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4D720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqM8-0002xk-T1
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqKz-0001Y4-BB
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqKx-0006L1-VW
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:29:01 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:42956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqKx-0006HR-LP
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:28:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id r20so2687346pfh.9
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NursXVv/HRRUgUycsc5QQiTW037ba/6j60CDRbihF7Q=;
 b=XT2xetT/y+v6QI8mKKRFQiQ7k1Vjojb/Fbp1dCu4CPqRv1PTAZ71ihJyLwKxyaAitO
 42xV6uyOSA9IcamrCn4ftPkmshoksp9xVcEAiHD3iMFBW5160N5XjfcLVA3A4gMg21eq
 c91zS9g4nSocJ/8uIvoP4Q0oNntDAjEhf5opPRSzbPPKMKsMM5yCYk8K+SnE87+s50Jd
 CkauYoJGbEkeD45HklZoOAFQp5qd/q/B2JYzIt567vESSNU0XXhMxjg0HIjUM7OIf3eM
 1ulPQsQ+p/fbnBR5ZVil2q/MXG3yzTz/Facz6WgU/E3f82Y74D+xRsd8E5xQDuGRyY7x
 kaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NursXVv/HRRUgUycsc5QQiTW037ba/6j60CDRbihF7Q=;
 b=qMIL8htKQQsSEkS/1T+MLBADXe+9QuYfz2WfHaI1jth+8nUfT5ZNCL8z96RBWBIclB
 wYhRlsxT66u5ZQuH8qpnn8AFwF+uNDlWQYhdT1QeAToG0i2jlMhFaCfuKhoeHNMkEzJs
 qtfhsBR0Yieep8YzP+Jk7vVeiY9FNgen7xUP8kBXyDRtnTSuVAC1/I2ILR3JvImkDtIg
 XtmQA6SuXTKhfDls4j8DH886aljXoubgUqkQTOUJSOhRb8FSeXmt7CzbLPtpt+bJ+aqB
 o3vPcXQARX3ribhSim1NPTJczlvOEc4W9V+RhUa5LWgW54aj1Q2u8oF5a5S2RRhkAvRO
 xyVg==
X-Gm-Message-State: AGi0PubxQiSLnSWV/teP46gZ4VUl9uiV4mpr2UNdlfuTkn8pViPrJhZM
 m2yWjLJ0OtMu9GM0+ZaeR5cHdivVLag=
X-Google-Smtp-Source: APiQypIWXZOwArNjmvAoB0wVsXRP53mQSam9Bc8EHQr9XUmwiFzp3ARWIAW2lgEIboR7yeNpexzePg==
X-Received: by 2002:aa7:9e10:: with SMTP id y16mr7057253pfq.236.1587227335550; 
 Sat, 18 Apr 2020 09:28:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id f99sm5636467pjg.22.2020.04.18.09.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:28:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: Add load_dest parameter to GVecGen2
Date: Sat, 18 Apr 2020 09:28:53 -0700
Message-Id: <20200418162853.4779-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have this same parameter for GVecGen2i, GVecGen3,
and GVecGen3i.  This will make some SVE2 insns easier
to parameterize.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  2 ++
 tcg/tcg-op-gvec.c         | 45 ++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index d89f91f40e..cea6497341 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -109,6 +109,8 @@ typedef struct {
     uint8_t vece;
     /* Prefer i64 to v64.  */
     bool prefer_i64;
+    /* Load dest as a 2nd source operand.  */
+    bool load_dest;
 } GVecGen2;
 
 typedef struct {
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 43cac1a0bf..049a55e700 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -663,17 +663,22 @@ static void expand_clr(uint32_t dofs, uint32_t maxsz)
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
 static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         void (*fni)(TCGv_i32, TCGv_i32))
+                         bool load_dest, void (*fni)(TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 4) {
         tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        fni(t0, t0);
-        tcg_gen_st_i32(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i32(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0);
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
 }
 
 static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
@@ -793,17 +798,22 @@ static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 
 /* Expand OPSZ bytes worth of two-operand operations using i64 elements.  */
 static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         void (*fni)(TCGv_i64, TCGv_i64))
+                         bool load_dest, void (*fni)(TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 8) {
         tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        fni(t0, t0);
-        tcg_gen_st_i64(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i64(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0);
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
 }
 
 static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
@@ -924,17 +934,23 @@ static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 /* Expand OPSZ bytes worth of two-operand operations using host vectors.  */
 static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t oprsz, uint32_t tysz, TCGType type,
+                         bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec))
 {
     TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
     uint32_t i;
 
     for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        fni(vece, t0, t0);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_vec(t1, cpu_env, dofs + i);
+        }
+        fni(vece, t1, t0);
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
 }
 
 /* Expand OPSZ bytes worth of two-vector operands and an immediate operand
@@ -1088,7 +1104,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
+                     g->load_dest, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1098,17 +1115,19 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
         maxsz -= some;
         /* fallthru */
     case TCG_TYPE_V128:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
+                     g->load_dest, g->fniv);
         break;
     case TCG_TYPE_V64:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
+                     g->load_dest, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_2_i64(dofs, aofs, oprsz, g->fni8);
+            expand_2_i64(dofs, aofs, oprsz, g->load_dest, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_2_i32(dofs, aofs, oprsz, g->fni4);
+            expand_2_i32(dofs, aofs, oprsz, g->load_dest, g->fni4);
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
-- 
2.20.1


