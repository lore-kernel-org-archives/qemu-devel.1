Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA9C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013272083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ek0asgyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013272083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYx0Z-0003r8-70
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:21:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUF-0004f8-Gu
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU8-0004Gw-OW
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU8-0003Cj-EA
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so3305626wre.12
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NQ8T/GOkVDAd68jEmVhy7qJ1i07QRbWGhEaUw7D8jjQ=;
	b=Ek0asgyYBkmZOcrh2J2MHcZPuNQUWh5or+5sfjPhN/67nwsyI3jLeOTEz+vc6U820y
	3sp/UKuInPlOhbik4X5ywBIs4HQ291X0pzV99lfXUvBVv/moEBljZAQXtbS6wdop+kyw
	W5L0LfxIMpZzYsyqW2PLRu9LpIN5BdhlTnoyu/bZZMLwgpsC0GGg8flPagGwnQuwcuIf
	70h0wO+JjnHaLP8mqaz8lx4Knd5yhuYEn6DKYjxHW8Fx5pNaNFAz9HvQG3QtvBg57vzo
	UOFOzxbq6wduAAdKZjME/p3w8+NRWrWlPImgoY/Vk3JK6rPoGqP9qpgoZJHeH8/C47sw
	IqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NQ8T/GOkVDAd68jEmVhy7qJ1i07QRbWGhEaUw7D8jjQ=;
	b=JFGfcbq3iITrf25I0QF5XavwbJFjFA8SbZJXo7NAZaRb4NgAAdPZopYlUiankUi0pt
	vfUz/uobGNetRwX2fOk9WtOzVL8WQ5/jJl5HKmTVJp79uPsc7zJCMVR6jfr3yzkw6Cgg
	3NJ4ZctRjdKbW6U34SFlnHDRrQ9RH3rIbB2iLPB02Y9hPPyJkO93vs2yxi/WzLXAfVEQ
	45OeqMV3SWYl0KApBF3dLDO2ltJ/RWNq3iW8CLnE1uijejZKKkoKwASqFZu6L70j+b1N
	tWI4Emj5PeJ4lwJiwLPMwDt9kEJbSIESkX1qf/+6smf3S/B87SNrcyfeqzNLKnslqrFG
	aCIA==
X-Gm-Message-State: APjAAAUSGW6BNgrPf3QH206GGYSx+dTpDTwUMH2mZzfSjartNvX7tJ0z
	lefGdr1svckNgWQUPmy53nFInowBGICaCA==
X-Google-Smtp-Source: APXvYqwW4jXBznsL5YMPutFK+nWo+hl/wNtfP0kL1p0Py01qVntVVhAB/5hr42DrzGkkdfAtz07v8A==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr17204790wre.294.1559843202395; 
	Thu, 06 Jun 2019 10:46:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:55 +0100
Message-Id: <20190606174609.20487-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 28/42] target/arm: Convert VMOV (imm) to
 decodetree
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

Convert the VFP VMOV (immediate) instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index e8785fd26e6..38ec026d865 100644
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


