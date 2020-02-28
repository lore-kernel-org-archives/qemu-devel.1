Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EACEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEC4246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKVKHBX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEC4246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7inU-00075B-VP
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifP-0007yr-8o
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifN-00020V-Up
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifN-000203-Nv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p9so3856293wmc.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=J50rehePz6YH1BM0Ziq+fv9dQfKqd43AZMRslmyChUs=;
 b=sKVKHBX29W6HKTR9ECigPAWgf6QXS/JoqiTP/4CjXpY2l63b1JyIXvm0e/MngSsBjJ
 9tPH3+JnrIREtjbRg5B7etHyaXel9wIdsVRC5+dbe/LXU25pTLcQUjEeELeHjxTRYcB2
 2+zWjs3KPEH54kGm65YIExBBNVAXOBEcHVP6R3jiAlhbqxbxOne7fgUbzm02JTUuB2Ke
 RJpjM1HD+EBHjcR6+V/09OT89fjEHgLkit+8MeiWsgpBPHjFYCsMFLaT9uJnXRL2hIxv
 G3Q+I1Z8GmwHu2VkzolauuVc6kK97MG3601JMbWWzBH6rbA/sz+9pOAI10hwW5bzhwFR
 Mp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J50rehePz6YH1BM0Ziq+fv9dQfKqd43AZMRslmyChUs=;
 b=kZHZ98rsC6IVfd6KY9m6jfmfyFvYhp3ODitaJ9jFvQWAowWoaCkznOqLi0RCCfoBAf
 Xh7IQEvC2ZEQ7oWF4FGfQyJfR+gj2b4rzyVn6goFY6+WKzzWm1KWN7yZ3LtNxSy49zCg
 /5EUYA7NBEFBuQ8RCV2SGU21GhhQe64yoQD/TbvSEXqEv4rl9Y7fKFUZYV9z+OyoSCUu
 1zrYq7BXzSMrumYKZoI43Vd2fJtezh4vYz6cyScOup7YYAATDkNafBxzGuQALq9DTiZc
 P97MLZnfqVuJtfK6u2K6fjJBZe/awTw4YQgVsjS9icZEJW6Ax8hW7Q0aICYP6q7t9Wtj
 WByw==
X-Gm-Message-State: APjAAAXbRs7cVJ5ojCdjdSKB2qa2rGl7QVNKK9wwqdrBZOPoONLCwjK7
 OylIhpZuokvMvlN3wBAXfUkcXY0eji6DmA==
X-Google-Smtp-Source: APXvYqzmLiesEvje1rvde5G2CjAU0H5LAurgPSkdtDaSrB/dKmKFQjJYVJ7OY8jtjgR5hlgMSXTbzw==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr5646544wmb.186.1582907948312; 
 Fri, 28 Feb 2020 08:39:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/33] target/arm: Split VMINMAXNM decode
Date: Fri, 28 Feb 2020 16:38:29 +0000
Message-Id: <20200228163840.23585-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

From: Richard Henderson <richard.henderson@linaro.org>

Passing the raw op field from the manual is less instructive
than it might be.  Do the full decode and use the existing
helpers to perform the expansion.

Since these are v8 insns, VECLEN+VECSTRIDE are already RES0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 109 +++++++++++----------------------
 target/arm/vfp-uncond.decode   |  12 ++--
 2 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 41aa67c133a..b087bbd812e 100644
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
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 5af1f2ee664..34ca164266f 100644
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
-- 
2.20.1


