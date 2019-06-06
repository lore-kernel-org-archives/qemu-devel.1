Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB4C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4FE20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpuHRXLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4FE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwhf-0000Fg-6G
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:01:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTt-0004D5-5m
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTq-0003jA-VM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTo-00031f-8u
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so808360wma.4
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xuR5O75XRjEcreJpXtoncdyc1wUFktWsTBFaHEVLLS4=;
	b=MpuHRXLiK1N8Ag2Jyzt6vPT55fWy72zJv9vVem14NGWlcztB2V6kou0WLKXfOGuWw7
	FiuFVyb321lzS3nnQWV8sBDrTZgdyfRpipIg4Z0MZhy3r1Ik04m6raSLbO4x8uHlBmcu
	74fvIxQrdcFQxJ7ybwI+qN8SDCZKz8wrklvSOvXt/H2cNaUVf7Oyc67QFq0a0K1XUlI8
	4CdZF/aXWIytaKM6skEGjig1if3sKuDHt9kQql86/3en0nQXewhYByVn/C0fYJA/9wTt
	ucQtNhHAsEJ/gl+uSpd9EcPwABcQX5iGLFEEz9jkQqLZ6Fv+Xo9g1BBOhBrAtQogrev5
	abDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xuR5O75XRjEcreJpXtoncdyc1wUFktWsTBFaHEVLLS4=;
	b=itVkNAC+6iJBc+vsOJeseJlpHu2snzM9xgKJXrJf3lRlFAmK76JyrKpdDSSOBTAmfU
	sdVJuqnzR2Ri81x1ZyLERAlPtgyQVU7/9OQpo/U4eOVHwSqllgW98M/pwsugTiAPlwE6
	ug1GDWTWGmUpmiDBlAVpkCOH6+V6f+qSWH5nhKCbpiVrOzy3utZd0jm/miPY6Q1LZ+tC
	BONAf+zJRSXnMBb1Ji5jAiXyBBxPE2y8mvHgjE0Z6Rt4WeyEPYEZvSAQ3cYX895i4f4j
	Ggj3RhcPl1XGYn9Q4oGRXwRTMWbPnvsV9hjXEPMwV9sLiYGcO9GlbA+V7V8xv+84aUYm
	Azbw==
X-Gm-Message-State: APjAAAUC0D5NHYfXOPv+wQ/sQAWwvCogYX5wiEbWKmm5oVOo5LGon5Cs
	CjAeboWC6oaAHN/pRIACSUKJquyP4Uus8A==
X-Google-Smtp-Source: APXvYqyJtVcurFHJGzSm0ECKTwoXC0o0uwytX0IJb8F7K0yjihv92ZkPOWNLCwpWnbNWRp2/oqgoow==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr912640wmh.0.1559843190483;
	Thu, 06 Jun 2019 10:46:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:44 +0100
Message-Id: <20190606174609.20487-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 17/42] target/arm: Remove VLDR/VSTR/VLDM/VSTM
 use of cpu_F0s and cpu_F0d
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
index a109f058795..cc4cb81a46e 100644
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


