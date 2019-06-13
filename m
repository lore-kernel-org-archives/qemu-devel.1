Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FB9C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02621721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eC/hc0Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02621721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPg6-0005IX-07
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdu-0008TY-1Y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOda-0004nk-Eh
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdZ-0004eI-UX
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so20574875wru.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LtAQM8pEHu6SHKexNJlmMSxzxlY/d7BbtS01EMAQYdU=;
 b=eC/hc0Am/kkKjLoBtRlqMaknAf66Pa5B2OYxzFyU+XT8TYz5C/JqFF8a5RdXvKFCKw
 gQQe01IbIVyr4arQLz9c0vyapW6t343g4vc8xEB1j2fT8ixLUeWzbTEbm1v0l808dW/O
 g+bc8ekztzKoFMRem8Xi7Wd1eRynLxfrS0I71UzbzAmLKXw/z1MrMdEfCI4w8M0XTNW/
 8rI8Tt6SK+p3AIK2w6Uw+hHjTcwfY1tukLJsRimbkRhxKaBXlc6U4djby1PF8NqyD4vS
 DZWCoPfUrHeS6+KXtlQqz/J+ayuuhtlxrBCSlgv7Rbs/1KgZAkY8+iJtFJoXypvxcMDt
 OGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LtAQM8pEHu6SHKexNJlmMSxzxlY/d7BbtS01EMAQYdU=;
 b=gVQBI2Vl4KU6zLng8YhtV/lvlXL017uQ3V+6aJvZWZc5Wb3P34ldCNhaH5VtXlvFO/
 fH81mFsxGDWIwUxeSQT44gSy/DnB66lzTQzWWNTo4iA8jEez+f/7yMGZpJWIY50Yjgju
 kPyKCGS92fQ2TdYUsHqiwQohgvMXKpRT70Ro2sfJ36LiNCVXqHqSyZrJDQ2g4tX4coDC
 7yoHeozEjeO/gO2dX/J5IP1D+HYbg4J5qVyZNWc0qlLpcpHuywxVN39U5uBrO16/hP29
 WFFx5cjwBCBwDhlk0mA/7zfwDYAFX+oe7yr82bg902929VDK0QYBukQFlbwvS0DkLn4g
 b6WQ==
X-Gm-Message-State: APjAAAXvUN6VaDYHDwcXJWkJcWqdGb6EqtZ82x/cWkfIzsc8E4kuFnjA
 CU1WMk2bSjgk9O5Ob0dnQZ3gspFgKsxaWA==
X-Google-Smtp-Source: APXvYqzcyZs6pekSdhdqswjoRjehDC9VzSHYVWFS0BurIoFY218GqoqpQMGnaUV90249KYrIuLLEvA==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr14806003wrx.206.1560428121180; 
 Thu, 13 Jun 2019 05:15:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:28 +0100
Message-Id: <20190613121433.5246-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 43/48] target/arm: Convert double-single
 precision conversion insns to decodetree
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

Convert the VCVT double/single precision conversion insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 48 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 13 +--------
 target/arm/vfp.decode          |  6 +++++
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e94a8f2f0c5..c50093776b6 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2320,3 +2320,51 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     tcg_temp_free_i64(tmp);
     return true;
 }
+
+static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
+{
+    TCGv_i64 vd;
+    TCGv_i32 vm;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    vd = tcg_temp_new_i64();
+    neon_load_reg32(vm, a->vm);
+    gen_helper_vfp_fcvtds(vd, vm, cpu_env);
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i64(vd);
+    return true;
+}
+
+static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
+{
+    TCGv_i64 vm;
+    TCGv_i32 vd;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vd = tcg_temp_new_i32();
+    vm = tcg_temp_new_i64();
+    neon_load_reg64(vm, a->vm);
+    gen_helper_vfp_fcvtsd(vd, vm, cpu_env);
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i64(vm);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0c855069d85..40e52c3b700 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 14:
+                case 0 ... 15:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,10 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x0f: /* vcvt double<->single */
-                    rd_is_dp = !dp;
-                    break;
-
                 case 0x10: /* vcvt.fxx.u32 */
                 case 0x11: /* vcvt.fxx.s32 */
                     rm_is_dp = false;
@@ -3185,13 +3181,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 15: /* single<->double conversion */
-                        if (dp) {
-                            gen_helper_vfp_fcvtsd(cpu_F0s, cpu_F0d, cpu_env);
-                        } else {
-                            gen_helper_vfp_fcvtds(cpu_F0d, cpu_F0s, cpu_env);
-                        }
-                        break;
                     case 16: /* fuito */
                         gen_vfp_uito(dp, 0);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9942d2ae7ad..56b8b4e6046 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -208,3 +208,9 @@ VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 .... \
              vd=%vd_sp vm=%vm_sp
 VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+# VCVT between single and double: Vm precision depends on size; Vd is its reverse
+VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 .... \
+             vd=%vd_dp vm=%vm_sp
+VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1


