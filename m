Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57195C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2817F20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmd/724/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2817F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPzL-0004Go-5r
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOeR-0000E4-L1
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOeI-0005SW-1J
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOeG-0004j5-1R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id x17so5235774wrl.9
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cM/krYcMONIsOnkfHxTnbrqFSYhnAz5GTPgsBXD7Q3Y=;
 b=gmd/724/HKFju8tHx+3ur+SFcX7iq5hEkYFuFLo7YxhY8PNqWm4QUTn5j4GrHerpyb
 47Qds0+iD7RA7L6WDxSmK0ddAfVNj+fUFO7bu+di9FjpL8C0KY11XTIcmHky4nEJAy3U
 iV94550mYqeU+/uy3VyS0osdnDqKV6IS9qi+78ydn6OeOrYcrArgPBv3c7WtYDx5X5D8
 alSUvoNEARlMW4cDD7P49pF3uc+/4WjcKRgHcAkbEnI2FH5UALmoL7XbuL83J30ZhatF
 fA96MCD/BvIMo6jqzRF7B1odM75bPLw2tWWCkkvpj1gCgj5RDM3PSTKUFQ9kaFv9yDYF
 oYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cM/krYcMONIsOnkfHxTnbrqFSYhnAz5GTPgsBXD7Q3Y=;
 b=XYqPz8sx9hfzzIuZ4Fo9o8C45xFznZLeN/9p5gRKSmtdxK5eF77AZQ2lMZNplUA16x
 +sziCP+6abOp6SKs8LkGrYFBBsqIXcL9VuwULajRg4EHJBKvCJlJ8tGb0wFrUiWK1m2+
 yX3Udfc8tgHnHTrN7GumNAdUBOvQCtl60SjcEeit24aAc+ReaUfPJI2bvVmsayvNGUxP
 eFqVHh+1fQ4XGdw+LhMWMUFC+FJdxQyC4SxIJ6MFLizstFD07tGWqPjspTwe8EG2bsk6
 sLwQPTVdF4ahBMNsel668CSyFwt3V97KhEXyqDx1aXhvR1NrSYjBE5tvPHJT0Hy1fB96
 LwTw==
X-Gm-Message-State: APjAAAUll2U8TekbDri2PWiXheMY7TyFisW07V16jf3m7Z/mYw3w4oWz
 30fd0lq2QkZ887h5r0BC/ohcUBlYnUC8nQ==
X-Google-Smtp-Source: APXvYqwOKMl7b5tU8jYu1rguI9oO0RlVVWqwK5C8QIWfvtPtftYDYpQRdZIjUVtP/N+JayYa7Td8Sg==
X-Received: by 2002:adf:f181:: with SMTP id h1mr1583765wro.86.1560428122050;
 Thu, 13 Jun 2019 05:15:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:29 +0100
Message-Id: <20190613121433.5246-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 44/48] target/arm: Convert integer-to-float
 insns to decodetree
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

Convert the VCVT integer-to-float instructions to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 58 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 12 +------
 target/arm/vfp.decode          |  6 ++++
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index c50093776b6..cc3f61d9c41 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2368,3 +2368,61 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     tcg_temp_free_i64(vm);
     return true;
 }
+
+static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    if (a->s) {
+        /* i32 -> f32 */
+        gen_helper_vfp_sitos(vm, vm, fpst);
+    } else {
+        /* u32 -> f32 */
+        gen_helper_vfp_uitos(vm, vm, fpst);
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
+{
+    TCGv_i32 vm;
+    TCGv_i64 vd;
+    TCGv_ptr fpst;
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
+    fpst = get_fpstatus_ptr(false);
+    if (a->s) {
+        /* i32 -> f64 */
+        gen_helper_vfp_sitod(vd, vm, fpst);
+    } else {
+        /* u32 -> f64 */
+        gen_helper_vfp_uitod(vd, vm, fpst);
+    }
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i64(vd);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 40e52c3b700..da4d4e9d012 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 15:
+                case 0 ... 17:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,10 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x10: /* vcvt.fxx.u32 */
-                case 0x11: /* vcvt.fxx.s32 */
-                    rm_is_dp = false;
-                    break;
                 case 0x18: /* vcvtr.u32.fxx */
                 case 0x19: /* vcvtz.u32.fxx */
                 case 0x1a: /* vcvtr.s32.fxx */
@@ -3181,12 +3177,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 16: /* fuito */
-                        gen_vfp_uito(dp, 0);
-                        break;
-                    case 17: /* fsito */
-                        gen_vfp_sito(dp, 0);
-                        break;
                     case 19: /* vjcvt */
                         gen_helper_vjcvt(cpu_F0s, cpu_F0d, cpu_env);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 56b8b4e6046..6da9a7913da 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -214,3 +214,9 @@ VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 .... \
              vd=%vd_dp vm=%vm_sp
 VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+# VCVT from integer to floating point: Vm always single; Vd depends on size
+VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
+             vd=%vd_dp vm=%vm_sp
-- 
2.20.1


