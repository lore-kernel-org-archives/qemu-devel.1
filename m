Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7FC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EF521927
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQKbjljP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EF521927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MFK-0001g3-T1
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7v-0004pp-Jh
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7u-0005za-7k
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:59 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7u-0005z3-1n
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:58 -0500
Received: by mail-pg1-x544.google.com with SMTP id u12so5829888pgb.10
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NtGab2HLNp8uF7NgRHRNjel2MNsIDKcBiKBTctaOBVU=;
 b=iQKbjljPuxbGNNgKNsXt6A8vQsPZeMQ6t0A/1omR+FMYdp6gH6ymirmemstaOOBQ2i
 mSvR53Eeo717IJ30DBt4YVBmg2w/S5gRZ0kWUImGOyPp2z14cXRjxIF0hELBUuFkFVae
 jdr0vLr2hLkwbkX9nqcahPOQbXLBCXwV472O1Ux7Ad71QDgfNUeCkkxBSTq/v1kkhskQ
 t/gAY366vjLW4cwxfY+tbPLekF15AG4h95KJtSL8cl6k3CXY+HDEkun6xIqYSVU6jMlz
 ohrvbBrYTOmpyU/a6BCvL0mPBKU7xat2KxWeDb2QEJlUdPNfz3ybK6NewtrreHlgjnzD
 M1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NtGab2HLNp8uF7NgRHRNjel2MNsIDKcBiKBTctaOBVU=;
 b=HYVtA3F7NbLwHnQIDkZJOn7OHCzoa707UiCj90W5P3fdRrkP+EYZWNfKJVVXqZIu5s
 79ERUpzYq305LeLGuxHX1XBF040YePbNgvfX2ucvZMtfigLim57fXAlre+DaA3wS4DES
 0MF6hhfVyEJH9wdbZyXgShxWZ7kvI+ZVhVLxnuRTSte2mk9CkNcuFoamqUm0QVyZ086Y
 O6n5dQxOcdfgeUvHH4efOiZOCYNklXXo2OtxugoMSRtPW4XIaKjVTHGxGdrYAW92VqH1
 96gReBTcmNTiijNt75938JlFGaDYl7e+DQ6lGJ3SzgWXigG0UHkA+Ctgajsa4Fnu/5QM
 cg9Q==
X-Gm-Message-State: APjAAAXR8LuzUV11dMJa8clTZwtXf47/w78kWSKr+EqYvCzjMxZwEEsE
 M7CMRkAN8JISHyXPO4xe6/YyjseoGc0=
X-Google-Smtp-Source: APXvYqxw8xSNAVXhhe7+++PHWyTKRhtODp2XznOM40aRaBleWX/iwjgsSmKH3tRyJZfU2lqTtBSdxQ==
X-Received: by 2002:a63:3085:: with SMTP id
 w127mr16713345pgw.176.1582582976686; 
 Mon, 24 Feb 2020 14:22:56 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/17] target/arm: Split VMINMAXNM decode
Date: Mon, 24 Feb 2020 14:22:32 -0800
Message-Id: <20200224222232.13807-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Passing the raw op field from the manual is less instructive
than it might be.  Do the full decode and use the existing
helpers to perform the expansion.

Since these are v8 insns, VECLEN+VECSTRIDE are already RES0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp-uncond.decode   |  12 ++--
 target/arm/translate-vfp.inc.c | 109 +++++++++++----------------------
 2 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 5af1f2ee66..34ca164266 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -41,15 +41,19 @@
 %vd_dp  22:1 12:4
 %vd_sp  12:4 22:1
 
+@vfp_dnm_s   ................................ vm=%vm_sp vn=%vn_sp vd=%vd_sp
+@vfp_dnm_d   ................................ vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
 VSEL        1111 1110 0. cc:2 .... .... 1010 .0.0 .... \
             vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
 VSEL        1111 1110 0. cc:2 .... .... 1011 .0.0 .... \
             vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
 
-VMINMAXNM   1111 1110 1.00 .... .... 1010 . op:1 .0 .... \
-            vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
-VMINMAXNM   1111 1110 1.00 .... .... 1011 . op:1 .0 .... \
-            vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
+VMAXNM_sp   1111 1110 1.00 .... .... 1010 .0.0 ....         @vfp_dnm_s
+VMINNM_sp   1111 1110 1.00 .... .... 1010 .1.0 ....         @vfp_dnm_s
+
+VMAXNM_dp   1111 1110 1.00 .... .... 1011 .0.0 ....         @vfp_dnm_d
+VMINNM_dp   1111 1110 1.00 .... .... 1011 .1.0 ....         @vfp_dnm_d
 
 VRINT       1111 1110 1.11 10 rm:2 .... 1010 01.0 .... \
             vm=%vm_sp vd=%vd_sp dp=0
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 41aa67c133..b087bbd812 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -322,79 +322,6 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
     return true;
 }
 
-static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
-{
-    uint32_t rd, rn, rm;
-    bool dp = a->dp;
-    bool vmin = a->op;
-    TCGv_ptr fpst;
-
-    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
-        return false;
-    }
-
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
-        return false;
-    }
-
-    rd = a->vd;
-    rn = a->vn;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    if (dp) {
-        TCGv_i64 frn, frm, dest;
-
-        frn = tcg_temp_new_i64();
-        frm = tcg_temp_new_i64();
-        dest = tcg_temp_new_i64();
-
-        neon_load_reg64(frn, rn);
-        neon_load_reg64(frm, rm);
-        if (vmin) {
-            gen_helper_vfp_minnumd(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
-        }
-        neon_store_reg64(dest, rd);
-        tcg_temp_free_i64(frn);
-        tcg_temp_free_i64(frm);
-        tcg_temp_free_i64(dest);
-    } else {
-        TCGv_i32 frn, frm, dest;
-
-        frn = tcg_temp_new_i32();
-        frm = tcg_temp_new_i32();
-        dest = tcg_temp_new_i32();
-
-        neon_load_reg32(frn, rn);
-        neon_load_reg32(frm, rm);
-        if (vmin) {
-            gen_helper_vfp_minnums(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnums(dest, frn, frm, fpst);
-        }
-        neon_store_reg32(dest, rd);
-        tcg_temp_free_i32(frn);
-        tcg_temp_free_i32(frm);
-        tcg_temp_free_i32(dest);
-    }
-
-    tcg_temp_free_ptr(fpst);
-    return true;
-}
-
 /*
  * Table for converting the most common AArch32 encoding of
  * rounding mode to arm_fprounding order (which matches the
@@ -1784,6 +1711,42 @@ static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
 
+static bool trans_VMINNM_sp(DisasContext *s, arg_VMINNM_sp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_sp(s, gen_helper_vfp_minnums,
+                         a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMAXNM_sp(DisasContext *s, arg_VMAXNM_sp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_sp(s, gen_helper_vfp_maxnums,
+                         a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMINNM_dp(DisasContext *s, arg_VMINNM_dp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_dp(s, gen_helper_vfp_minnumd,
+                         a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMAXNM_dp(DisasContext *s, arg_VMAXNM_dp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_dp(s, gen_helper_vfp_maxnumd,
+                         a->vd, a->vn, a->vm, false);
+}
+
 static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
 {
     /*
-- 
2.20.1


