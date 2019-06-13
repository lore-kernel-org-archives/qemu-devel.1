Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9364CC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667E120B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0Q3kV87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667E120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPFh-0001NZ-NK
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59078)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdN-000829-9B
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdL-0004O0-9N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:13 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdH-00041p-DC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id d18so20521232wrs.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=G9EplEWWeY2rBD/O9y6VR49Hh5Zd3BPbLcO7Af3KvXA=;
 b=s0Q3kV877QBrAfKHztkhpWg3t5LVgArMsU0D0QE4mzGHdRHd6f3e7+3w2Ix8Qy6HVf
 3yTuTh5xdBDn5fMfUvAY5GsjXKQEbrkhNx7kStY/pkUXsP1AOULjQoeXWOmOVlAeB+XV
 rS3b/pFZDmueCiHraaPUtD1KaqL/rZGknDQl7t7uxjNXz5t+PtQleJJhZI7dpih46B1r
 +Fb0vFNK4QxF6BHE4dW5ZXsKMS2DK/y3C4gfolXtovUe1vA9LFKL2GSJjSl9MZTCTmEk
 Pbk3r2560uoKZ9p5aLgS6rEURFqJKw/3BCQEh31Lwm2aGSZumnP0EV1onvrqKiroKlQX
 vgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G9EplEWWeY2rBD/O9y6VR49Hh5Zd3BPbLcO7Af3KvXA=;
 b=aXH1546kui1Mb9NpIdQ00DoSRLxlUoHQJzmuEDMXBpzTwrkJjYWoYFyhIGLWZ7s2s1
 +UopRTeSsjkNfM79kBH8rtTWUQut2O/KZueb2So57T7/H9JQWPifuVYpQZ7qhTLX+wcP
 7+h9w1HNw58JwGtnjZrkYd15TS+fcWhUADKGZvArGoqtFfknK+ks8FrWPooJlsZ5CINg
 yaSaX2O7ZZSYcdOcPiW8fxA6Ll3KlyX00N6TfsJYvyJeMwagkD8vHUFTbQX0YUNKF6/u
 lCF6NkL/Ng6Ku3Iqnc4H2xls10FNzmqcBUAIJUcGawZm49gGeYpUrlTH4Ia22A70wT8H
 3faw==
X-Gm-Message-State: APjAAAUODI7QafTlm/mRBbTSVUjLHIwTKkq8db+uMIqr3R6OliCJ4fcG
 1A7NDuyi+5v90X7504TmkVSxd39V2wL1qA==
X-Google-Smtp-Source: APXvYqwi2s1yHGE6oSwPVT2WoIwrTLdr/p+Hy5krWLT1MZayu+68xXsqq19AkeKYMxUjgbxAxOPZRw==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr46293015wru.301.1560428090323; 
 Thu, 13 Jun 2019 05:14:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:59 +0100
Message-Id: <20190613121433.5246-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 14/48] target/arm: Convert
 VRINTA/VRINTN/VRINTP/VRINTM to decodetree
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

Convert the VRINTA/VRINTN/VRINTP/VRINTM instructions to decodetree.
Again, trans_VRINT() is temporarily left in translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 60 +++++++++++++++++++++++-------------
 target/arm/vfp-uncond.decode |  5 +++
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6cbdf4307a4..1da683820ab 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3270,11 +3270,43 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
     return true;
 }
 
-static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
-                        int rounding)
+/*
+ * Table for converting the most common AArch32 encoding of
+ * rounding mode to arm_fprounding order (which matches the
+ * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
+ */
+static const uint8_t fp_decode_rm[] = {
+    FPROUNDING_TIEAWAY,
+    FPROUNDING_TIEEVEN,
+    FPROUNDING_POSINF,
+    FPROUNDING_NEGINF,
+};
+
+static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
 {
-    TCGv_ptr fpst = get_fpstatus_ptr(0);
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
     TCGv_i32 tcg_rmode;
+    int rounding = fp_decode_rm[a->rm];
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
@@ -3305,7 +3337,7 @@ static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     tcg_temp_free_i32(tcg_rmode);
 
     tcg_temp_free_ptr(fpst);
-    return 0;
+    return true;
 }
 
 static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
@@ -3366,17 +3398,6 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     return 0;
 }
 
-/* Table for converting the most common AArch32 encoding of
- * rounding mode to arm_fprounding order (which matches the
- * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
- */
-static const uint8_t fp_decode_rm[] = {
-    FPROUNDING_TIEAWAY,
-    FPROUNDING_TIEEVEN,
-    FPROUNDING_POSINF,
-    FPROUNDING_NEGINF,
-};
-
 static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t rd, rm, dp = extract32(insn, 8, 1);
@@ -3389,13 +3410,8 @@ static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
         rm = VFP_SREG_M(insn);
     }
 
-    if ((insn & 0x0fbc0ed0) == 0x0eb80a40 &&
-        dc_isar_feature(aa32_vrint, s)) {
-        /* VRINTA, VRINTN, VRINTP, VRINTM */
-        int rounding = fp_decode_rm[extract32(insn, 16, 2)];
-        return handle_vrint(insn, rd, rm, dp, rounding);
-    } else if ((insn & 0x0fbc0e50) == 0x0ebc0a40 &&
-               dc_isar_feature(aa32_vcvt_dr, s)) {
+    if ((insn & 0x0fbc0e50) == 0x0ebc0a40 &&
+        dc_isar_feature(aa32_vcvt_dr, s)) {
         /* VCVTA, VCVTN, VCVTP, VCVTM */
         int rounding = fp_decode_rm[extract32(insn, 16, 2)];
         return handle_vcvt(insn, rd, rm, dp, rounding);
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 8ab201fa058..0aa83285de2 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -50,3 +50,8 @@ VMINMAXNM   1111 1110 1.00 .... .... 1010 . op:1 .0 .... \
             vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
 VMINMAXNM   1111 1110 1.00 .... .... 1011 . op:1 .0 .... \
             vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
+
+VRINT       1111 1110 1.11 10 rm:2 .... 1010 01.0 .... \
+            vm=%vm_sp vd=%vd_sp dp=0
+VRINT       1111 1110 1.11 10 rm:2 .... 1011 01.0 .... \
+            vm=%vm_dp vd=%vd_dp dp=1
-- 
2.20.1


