Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BF2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974F720868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iy1tV+8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974F720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36157 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwkH-0004Hs-Os
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:04:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTz-0004Ks-OS
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTx-0003uM-PO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTx-00033K-HP
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id g135so786976wme.4
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=opQeVxGqpTZMg9p8Wo8mcy6JegGui05JYySUye4cu/w=;
	b=Iy1tV+8pJS2S1CuC1lkt0zIejGzPmkO94iqXJebAN6lPIoKUd8SDpiFK/0M5mwH7IS
	SR5mou97+cdy0rJgcemD8aw6Bc8zY/UG1osMHM6stSyaTcb5fbRzVETVhw07mShKCTbf
	AOkJnjDNWLcDswoCs7vXuN2ukjnbhZjxO0IqhbisHnGOrDx00bvSipjd47Ww1kx9r44V
	T8biaSiG/x494hRP6vZvEBAxhiqF7bzm9ViJZ8IJ8G/kNQs1q3Fh4A7g1XY9mJjhGY7T
	kjz7z9PdznLBaZmKPtTfTPAzmiil3v8SlZPuZ06bgDYYES1pnZiVs29jlCOj035r4XZE
	ku+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=opQeVxGqpTZMg9p8Wo8mcy6JegGui05JYySUye4cu/w=;
	b=L2kO/MWvrAJyRhmwrPHgQyE4UFr0n3hNUHBaX0XbaIdxgTQm+OsqwA0+Z61wqGxyMV
	v6+LQvvKwx+p+8WoTD/C/PA0mUQZlSlyYzRmKDybFmGiudX349RGDwjkeLbGdce4b+wm
	cPerDNta/iUVSupZC/ialEsXYcKrL3XjP1DeuHK7DjFDU2pN+FnQEgqqXHJg8ejO3Llu
	VD+QjdIIwO0QhR7gpGmVy4rn/WTZQ9/CpWNPFTBXWFgPHCeli0SYTvHnbgD8DUnXMIBw
	KJIvlhomlYwPrf6XkOsDGv9jfvNmM7LZqI5mMTDrn4FSnDDCFt+se92FWvMjwosfxlQI
	j1Dg==
X-Gm-Message-State: APjAAAX0XrhN6khzim9fTh19jx3Z6NUE4IMtvYSwQj9hMah68GdUCLHd
	EXFuOgmaXl5U5glGP/G1onxKN5EIo8Qrfg==
X-Google-Smtp-Source: APXvYqxJR5Bc7ogmHPZDoCUza6mBXC30E687o7F9CAntDC8Od3e7loZS2QHVpE0KEKC/KjjylUhL/A==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr906210wmf.34.1559843192628; 
	Thu, 06 Jun 2019 10:46:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:46 +0100
Message-Id: <20190606174609.20487-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 19/42] target/arm: Convert VFP VMLS to
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

Convert the VFP VMLS instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 38 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  8 +------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 4f922dc8405..00f64401dda 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1303,3 +1303,41 @@ static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLA_dp, a->vd, a->vn, a->vm, true);
 }
+
+static void gen_VMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /*
+     * VMLS: vd = vd + -(vn * vm)
+     * Note that order of inputs to the add matters for NaNs.
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_muls(tmp, vn, vm, fpst);
+    gen_helper_vfp_negs(tmp, tmp);
+    gen_helper_vfp_adds(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VMLS_sp(DisasContext *s, arg_VMLS_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_VMLS_sp, a->vd, a->vn, a->vm, true);
+}
+
+static void gen_VMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
+{
+    /*
+     * VMLS: vd = vd + -(vn * vm)
+     * Note that order of inputs to the add matters for NaNs.
+     */
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_helper_vfp_muld(tmp, vn, vm, fpst);
+    gen_helper_vfp_negd(tmp, tmp);
+    gen_helper_vfp_addd(vd, vd, tmp, fpst);
+    tcg_temp_free_i64(tmp);
+}
+
+static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2fa516364f3..dc19d8fcab1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3134,7 +3134,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0:
+            case 0 ... 1:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3320,12 +3320,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 1: /* VMLS: fd + -(fn * fm) */
-                    gen_vfp_mul(dp);
-                    gen_vfp_F1_neg(dp);
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_add(dp);
-                    break;
                 case 2: /* VNMLS: -fd + (fn * fm) */
                     /* Note that it isn't valid to replace (-A + B) with (B - A)
                      * or similar plausible looking simplifications
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9530e17ae02..7bcf2260eec 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -102,3 +102,8 @@ VMLA_sp      ---- 1110 0.00 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VMLA_dp      ---- 1110 0.00 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VMLS_sp      ---- 1110 0.00 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VMLS_dp      ---- 1110 0.00 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


