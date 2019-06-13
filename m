Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661DDC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358AD20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUTagof+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358AD20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPMX-0007u5-Fn
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdc-0008Lm-4h
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdV-0004bu-4w
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdU-0004Pg-EP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id c6so9908394wml.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZxLqU47/zu103NNnSAFyZsvu3wGIQylPHAykvX/ZYgU=;
 b=mUTagof+QENGT9hFlrkDNZbdx72vXBsVhweZeN7NGbRMX2iIBtDuGmqBYYc2w88hBB
 w6I+mZ0U3h9mlwa8QqA52LsQIz9ALO1XD5k12zGKmypx2V/T9JZufHHQKeX4ToDngmRZ
 T4BmhSbHvmH6W+EPWxOkCLekedY5a1lyv9thwntsywv26bhCQ3rTm6+0QY+W7H1NyD/4
 mb9PNLG5hMEPJFOUEzleNtevyhV5/dBSnPpc+bjBS1exA++yZHokKQR9W1Y5Q0D+cElH
 5A2szSzecizLh9FNTOH0yOlGExmrBQjIwIxDNN5EMPOWewp4gCJFgsH5SaKhXWGLrSkT
 rPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZxLqU47/zu103NNnSAFyZsvu3wGIQylPHAykvX/ZYgU=;
 b=Aqj5eubLDIxSiMkWMMeUlKJkI9csvFD4h+74F4qUCqBdftE5AwjbeAa5ewHGgLqlD6
 BAdyRdObmbDfssZM5uZx09yZVLoupZ09zxIM/3HEnXVMUi+eYssBHGDf8x42BW8edrN/
 RHQFvCaUHlFBOm+0UzTv0Fdu0I519zQn4afgpOGwxlbSalN2WojBCZ6NoKNY6XCuozKs
 5mGtpR+DC8GjAegs1hW/9CXLj+QHpeAMIqadLEJe/ZQx7XT/ACTp9GokLC9rGWmbq9qx
 RCBR9X+gA3kdauT2JcWGL1KRXyIRZo1fc7PMxbQkQAT5OqDVEVS7OMimba/RsWpkY5G2
 hLWw==
X-Gm-Message-State: APjAAAVGh0c6FgmmAT7m7gXJJll2YpnzWOSKDRubkgy0V2POE+pjePrb
 fz84kuWFm1YDEOqma/9dec2vvvHiw2kJ9w==
X-Google-Smtp-Source: APXvYqwy/kVZXDz9LdN7ttuGXcfwEYqr0zUF4wWnTqAq7Y08E3LPsKUglLfL/O6IlbjDsRt6dnCr1w==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr3753140wmi.14.1560428112112;
 Thu, 13 Jun 2019 05:15:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:19 +0100
Message-Id: <20190613121433.5246-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 34/48] target/arm: Convert VMOV (imm) to
 decodetree
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

Convert the VFP VMOV (immediate) instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 129 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  27 +------
 target/arm/vfp.decode          |   5 ++
 3 files changed, 136 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ba6506a378c..a2eeb6cb511 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1602,3 +1602,132 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_sp *a)
 
     return true;
 }
+
+static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
+{
+    uint32_t delta_d = 0;
+    uint32_t bank_mask = 0;
+    int veclen = s->vec_len;
+    TCGv_i32 fd;
+    uint32_t n, i, vd;
+
+    vd = a->vd;
+
+    if (!dc_isar_feature(aa32_fpshvec, s) &&
+        (veclen != 0 || s->vec_stride != 0)) {
+        return false;
+    }
+
+    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (veclen > 0) {
+        bank_mask = 0x18;
+        /* Figure out what type of vector operation this is.  */
+        if ((vd & bank_mask) == 0) {
+            /* scalar */
+            veclen = 0;
+        } else {
+            delta_d = s->vec_stride + 1;
+        }
+    }
+
+    n = (a->imm4h << 28) & 0x80000000;
+    i = ((a->imm4h << 4) & 0x70) | a->imm4l;
+    if (i & 0x40) {
+        i |= 0x780;
+    } else {
+        i |= 0x800;
+    }
+    n |= i << 19;
+
+    fd = tcg_temp_new_i32();
+    tcg_gen_movi_i32(fd, n);
+
+    for (;;) {
+        neon_store_reg32(fd, vd);
+
+        if (veclen == 0) {
+            break;
+        }
+
+        /* Set up the operands for the next iteration */
+        veclen--;
+        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+    }
+
+    tcg_temp_free_i32(fd);
+    return true;
+}
+
+static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
+{
+    uint32_t delta_d = 0;
+    uint32_t bank_mask = 0;
+    int veclen = s->vec_len;
+    TCGv_i64 fd;
+    uint32_t n, i, vd;
+
+    vd = a->vd;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (vd & 0x10)) {
+        return false;
+    }
+
+    if (!dc_isar_feature(aa32_fpshvec, s) &&
+        (veclen != 0 || s->vec_stride != 0)) {
+        return false;
+    }
+
+    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (veclen > 0) {
+        bank_mask = 0xc;
+        /* Figure out what type of vector operation this is.  */
+        if ((vd & bank_mask) == 0) {
+            /* scalar */
+            veclen = 0;
+        } else {
+            delta_d = (s->vec_stride >> 1) + 1;
+        }
+    }
+
+    n = (a->imm4h << 28) & 0x80000000;
+    i = ((a->imm4h << 4) & 0x70) | a->imm4l;
+    if (i & 0x40) {
+        i |= 0x3f80;
+    } else {
+        i |= 0x4000;
+    }
+    n |= i << 16;
+
+    fd = tcg_temp_new_i64();
+    tcg_gen_movi_i64(fd, ((uint64_t)n) << 32);
+
+    for (;;) {
+        neon_store_reg64(fd, vd);
+
+        if (veclen == 0) {
+            break;
+        }
+
+        /* Set up the operands for the next iteration */
+        veclen--;
+        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+    }
+
+    tcg_temp_free_i64(fd);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 75280e0e524..30d96fbf5a6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3033,7 +3033,7 @@ static void gen_neon_dup_high16(TCGv_i32 var)
  */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, op, i, n, delta_d, delta_m, bank_mask;
+    uint32_t rd, rn, rm, op, delta_d, delta_m, bank_mask;
     int dp, veclen;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -3093,7 +3093,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 13:
+            case 0 ... 14:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3279,29 +3279,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 14: /* fconst */
-                    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                        return 1;
-                    }
-
-                    n = (insn << 12) & 0x80000000;
-                    i = ((insn >> 12) & 0x70) | (insn & 0xf);
-                    if (dp) {
-                        if (i & 0x40)
-                            i |= 0x3f80;
-                        else
-                            i |= 0x4000;
-                        n |= i << 16;
-                        tcg_gen_movi_i64(cpu_F0d, ((uint64_t)n) << 32);
-                    } else {
-                        if (i & 0x40)
-                            i |= 0x780;
-                        else
-                            i |= 0x800;
-                        n |= i << 19;
-                        tcg_gen_movi_i32(cpu_F0s, n);
-                    }
-                    break;
                 case 15: /* extension space */
                     switch (rn) {
                     case 0: /* cpy */
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 37eec0e1310..1818d4f71e1 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -151,3 +151,8 @@ VFM_sp       ---- 1110 1.10 .... .... 1010 . o2:1 . 0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=2
 VFM_dp       ---- 1110 1.10 .... .... 1011 . o2:1 . 0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=2
+
+VMOV_imm_sp  ---- 1110 1.11 imm4h:4 .... 1010 0000 imm4l:4 \
+             vd=%vd_sp
+VMOV_imm_dp  ---- 1110 1.11 imm4h:4 .... 1011 0000 imm4l:4 \
+             vd=%vd_dp
-- 
2.20.1


