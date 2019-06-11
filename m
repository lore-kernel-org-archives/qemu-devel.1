Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF1C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4B42089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yMYbKOQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4B42089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haeyE-0004Vu-7d
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQ0-0007Jo-Ng
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePu-0007UU-W0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePu-0007QF-JU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so12521305wrn.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o1g1mlYqkXicG5tKMTS6P/rwrLfAalPOGhMe2aL61GY=;
 b=yMYbKOQWsut0TtFHRpRd1JuyEAa9J2shtRO/Yndu3Y/YBbTluc/0NFnO9x2tfYPptS
 EqNCApf51R1Cxbyu28A9lLmsH20YPdAJ8oEBDUVxIjA7wtpakx6wNNC3LwcRRSjE7iye
 /ZTRph8K1Osx1v7jQOgSkIDnS1UIes825S6sp7KVekxOyau0i4KNNlxYhKmSNBpXYs0Z
 7pBUilAGSkhipE3XisvrJVZoCtr7GKX7/4P9+Um/dXadcqmijYZo1DHoFRngRamGK3Bq
 2NDqBiPsW8FFeAhjnz0iKlacEbcU4ccayGhnae9yu81uT+MqFMklDXahQwq4v0hq/V75
 9Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o1g1mlYqkXicG5tKMTS6P/rwrLfAalPOGhMe2aL61GY=;
 b=rKC/kqJ6H8Rhwbux7wIAHMN6M6HBtcoM8pviAs9Wfi1OCf6XM1yk1JeXjh+CUdqQ1p
 jd1hkY/5oORZe1TQfdaygzs+4+2k30I5I1vn3HcN/XAuhP/BMMRmJ7xj2i1l35DgM1+2
 L3hAwM4yHs4wjYdRoMYIq+L+VqSB1kucZpV1lSrCFI9M8GcI6bP5piITpREYr400e2rg
 6KbMC9KY7vrM8pB0dwJxRHf5D1cTXoTDGlw5HNQk5YTdnQkdaodqjpmd4i+J1q2ZNOoX
 ckhAESb0xK0MR6+/h34CqG5flqO2m3fE7HJ9yD6TrN4rxVdSOUEDj5ZsTqHE7DATBteL
 Nopw==
X-Gm-Message-State: APjAAAVYI18cJKM4og6fZjc1u/+fbZsc2N3a4XYlm7jGkjXAhPHSARz8
 QqUQSOgFNqh+U9bwX01inlj6Ug==
X-Google-Smtp-Source: APXvYqxi8Ts80ERC/T+7Dfmb+IYlEqfmMHaKnrXVYlYp8DN0TXDf06wf34L2+Mjs1BCORqjz7l1Mbg==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr20781538wrt.96.1560250452059; 
 Tue, 11 Jun 2019 03:54:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:26 +0100
Message-Id: <20190611105351.9871-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 17/42] target/arm: Remove
 VLDR/VSTR/VLDM/VSTM use of cpu_F0s and cpu_F0d
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

Expand out the sequences in the new decoder VLDR/VSTR/VLDM/VSTM trans
functions which perform the memory accesses by going via the TCG
globals cpu_F0s and cpu_F0d, to use local TCG temps instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 46 +++++++++++++++++++++-------------
 target/arm/translate.c         | 18 -------------
 2 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 32a1805e582..9729946d734 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -857,7 +857,7 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_sp *a)
 static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 {
     uint32_t offset;
-    TCGv_i32 addr;
+    TCGv_i32 addr, tmp;
 
     if (!vfp_access_check(s)) {
         return true;
@@ -876,13 +876,15 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
         addr = load_reg(s, a->rn);
     }
     tcg_gen_addi_i32(addr, addr, offset);
+    tmp = tcg_temp_new_i32();
     if (a->l) {
-        gen_vfp_ld(s, false, addr);
-        gen_mov_vreg_F0(false, a->vd);
+        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+        neon_store_reg32(tmp, a->vd);
     } else {
-        gen_mov_F0_vreg(false, a->vd);
-        gen_vfp_st(s, false, addr);
+        neon_load_reg32(tmp, a->vd);
+        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
     }
+    tcg_temp_free_i32(tmp);
     tcg_temp_free_i32(addr);
 
     return true;
@@ -892,6 +894,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 {
     uint32_t offset;
     TCGv_i32 addr;
+    TCGv_i64 tmp;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
@@ -915,13 +918,15 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
         addr = load_reg(s, a->rn);
     }
     tcg_gen_addi_i32(addr, addr, offset);
+    tmp = tcg_temp_new_i64();
     if (a->l) {
-        gen_vfp_ld(s, true, addr);
-        gen_mov_vreg_F0(true, a->vd);
+        gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
+        neon_store_reg64(tmp, a->vd);
     } else {
-        gen_mov_F0_vreg(true, a->vd);
-        gen_vfp_st(s, true, addr);
+        neon_load_reg64(tmp, a->vd);
+        gen_aa32_st64(s, tmp, addr, get_mem_index(s));
     }
+    tcg_temp_free_i64(tmp);
     tcg_temp_free_i32(addr);
 
     return true;
@@ -930,7 +935,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
 {
     uint32_t offset;
-    TCGv_i32 addr;
+    TCGv_i32 addr, tmp;
     int i, n;
 
     n = a->imm;
@@ -976,18 +981,20 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
     }
 
     offset = 4;
+    tmp = tcg_temp_new_i32();
     for (i = 0; i < n; i++) {
         if (a->l) {
             /* load */
-            gen_vfp_ld(s, false, addr);
-            gen_mov_vreg_F0(false, a->vd + i);
+            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+            neon_store_reg32(tmp, a->vd + i);
         } else {
             /* store */
-            gen_mov_F0_vreg(false, a->vd + i);
-            gen_vfp_st(s, false, addr);
+            neon_load_reg32(tmp, a->vd + i);
+            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
         }
         tcg_gen_addi_i32(addr, addr, offset);
     }
+    tcg_temp_free_i32(tmp);
     if (a->w) {
         /* writeback */
         if (a->p) {
@@ -1006,6 +1013,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
 {
     uint32_t offset;
     TCGv_i32 addr;
+    TCGv_i64 tmp;
     int i, n;
 
     n = a->imm >> 1;
@@ -1056,18 +1064,20 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     }
 
     offset = 8;
+    tmp = tcg_temp_new_i64();
     for (i = 0; i < n; i++) {
         if (a->l) {
             /* load */
-            gen_vfp_ld(s, true, addr);
-            gen_mov_vreg_F0(true, a->vd + i);
+            gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
+            neon_store_reg64(tmp, a->vd + i);
         } else {
             /* store */
-            gen_mov_F0_vreg(true, a->vd + i);
-            gen_vfp_st(s, true, addr);
+            neon_load_reg64(tmp, a->vd + i);
+            gen_aa32_st64(s, tmp, addr, get_mem_index(s));
         }
         tcg_gen_addi_i32(addr, addr, offset);
     }
+    tcg_temp_free_i64(tmp);
     if (a->w) {
         /* writeback */
         if (a->p) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5a9d0c30d3d..c197084e925 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1522,24 +1522,6 @@ VFP_GEN_FIX(uhto, )
 VFP_GEN_FIX(ulto, )
 #undef VFP_GEN_FIX
 
-static inline void gen_vfp_ld(DisasContext *s, int dp, TCGv_i32 addr)
-{
-    if (dp) {
-        gen_aa32_ld64(s, cpu_F0d, addr, get_mem_index(s));
-    } else {
-        gen_aa32_ld32u(s, cpu_F0s, addr, get_mem_index(s));
-    }
-}
-
-static inline void gen_vfp_st(DisasContext *s, int dp, TCGv_i32 addr)
-{
-    if (dp) {
-        gen_aa32_st64(s, cpu_F0d, addr, get_mem_index(s));
-    } else {
-        gen_aa32_st32(s, cpu_F0s, addr, get_mem_index(s));
-    }
-}
-
 static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
-- 
2.20.1


