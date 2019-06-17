Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87204C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F272084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypAYlGCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F272084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hct63-0001T2-Kf
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46826)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiU-0003nj-Gp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiR-0008CS-Kf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:38 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiR-0008Bo-EM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id p13so10199729wru.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QH/DDBGbAAKw5E22C6nxXcLX4pRMuc/olgVu3SfYiz4=;
 b=ypAYlGCUkGPn/rh81QbNCvQBjaiT4Sh/tsBPY9x5GEjPSynb04D8jP9+JPQdowCLmu
 hHUYyRxiE59IFEcgB3QgvBRj2tPbmuZv6rFGaJjXCmNNIRGEwjBCQEFeEKyXotkomytF
 FkO/BMebSuNgRTXgrl3qzICl29sq+t7CYBSgrYCUWvJ1xRKqA1fQ0rhV1yO8F5DBhgWS
 vfJ7QUgKveWFzuie449TVgjMxs4iF/Q+5VSWmnfp6hLqYtXFZI4z2RZRb+RI9SuMAidm
 cXWdbJrOXrKpaWbTECqMmlwrZEJPvR9Sq+gXh+zqyc+mOXvokjmtNRLpgRdVQrYa9QSp
 hfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QH/DDBGbAAKw5E22C6nxXcLX4pRMuc/olgVu3SfYiz4=;
 b=qzBuyCKtf05w7HQkXmnnnVHrU2ZskTLyiGBNANDIlymI2FlAEZexkYmgyByILxn1to
 VxqDfIEla56hzGIWRTK414NpvGY+yKjjcye9inkqo8gPAKu9NLvCCbQ1z9wNpYBozBl1
 5LRMMWyX/TkFCPLgX1ocOrlqVNnQK8Vju6jAm7n6+b6W6rdToCspx0ylRDKD0mevfWNh
 AiZpp+sk6R8kYFTMHvtCISxJFc6ZTAa92IlZX4rF8vhrAHMg9ePihWIKLx1WXLJiq2f1
 uEF6x1jTYOVb6HInvn+V2ZYrz2cbX72UmEr5UBAn/7HGV2sLPu6n648wNjyFGg+ABbqS
 kGNA==
X-Gm-Message-State: APjAAAWnW8FI08NEWzTJSHCGPDtrH5++o658L/W3TKj89+898xGMfmly
 Rhbr2agQdfylqzZiWcbhkru0XA+fjJOmag==
X-Google-Smtp-Source: APXvYqyAGF+z5O4ron2iSQUIFW4K28hnkt6cQ21Lb6+17J5+dypQGi/g5jdjy/wOcx4MgkAOhvK4xg==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr75161195wrn.244.1560782074327; 
 Mon, 17 Jun 2019 07:34:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:06 +0100
Message-Id: <20190617143412.5734-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 18/24] target/arm: Stop using cpu_F0s for Neon
 f32/s32 VCVT
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

Stop using cpu_F0s for the Neon f32/s32 VCVT operations.
Since this is the last user of cpu_F0s in the Neon 2rm-op
loop, we can remove the handling code for it too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-9-peter.maydell@linaro.org
---
 target/arm/translate.c | 82 ++++++++++++------------------------------
 1 file changed, 22 insertions(+), 60 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 75ed7cc7cb0..0fb94b777bf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1374,38 +1374,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-#define VFP_GEN_ITOF(name) \
-static inline void gen_vfp_##name(int dp, int neon) \
-{ \
-    TCGv_ptr statusptr = get_fpstatus_ptr(neon); \
-    if (dp) { \
-        gen_helper_vfp_##name##d(cpu_F0d, cpu_F0s, statusptr); \
-    } else { \
-        gen_helper_vfp_##name##s(cpu_F0s, cpu_F0s, statusptr); \
-    } \
-    tcg_temp_free_ptr(statusptr); \
-}
-
-VFP_GEN_ITOF(uito)
-VFP_GEN_ITOF(sito)
-#undef VFP_GEN_ITOF
-
-#define VFP_GEN_FTOI(name) \
-static inline void gen_vfp_##name(int dp, int neon) \
-{ \
-    TCGv_ptr statusptr = get_fpstatus_ptr(neon); \
-    if (dp) { \
-        gen_helper_vfp_##name##d(cpu_F0s, cpu_F0d, statusptr); \
-    } else { \
-        gen_helper_vfp_##name##s(cpu_F0s, cpu_F0s, statusptr); \
-    } \
-    tcg_temp_free_ptr(statusptr); \
-}
-
-VFP_GEN_FTOI(touiz)
-VFP_GEN_FTOI(tosiz)
-#undef VFP_GEN_FTOI
-
 #define VFP_GEN_FIX(name, round) \
 static inline void gen_vfp_##name(int dp, int shift, int neon) \
 { \
@@ -4173,17 +4141,6 @@ static const uint8_t neon_3r_sizes[] = {
 #define NEON_2RM_VCVT_SF 62
 #define NEON_2RM_VCVT_UF 63
 
-static int neon_2rm_is_float_op(int op)
-{
-    /*
-     * Return true if this neon 2reg-misc op is float-to-float.
-     * This is not a property of the operation but of our code --
-     * what we are asking here is "does the code for this case in
-     * the Neon for-each-pass loop use cpu_F0s?".
-     */
-    return op >= NEON_2RM_VCVT_FS;
-}
-
 static bool neon_2rm_is_v8_op(int op)
 {
     /* Return true if this neon 2reg-misc op is ARMv8 and up */
@@ -6599,13 +6556,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 default:
                 elementwise:
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                        if (neon_2rm_is_float_op(op)) {
-                            tcg_gen_ld_f32(cpu_F0s, cpu_env,
-                                           neon_reg_offset(rm, pass));
-                            tmp = NULL;
-                        } else {
-                            tmp = neon_load_reg(rm, pass);
-                        }
+                        tmp = neon_load_reg(rm, pass);
                         switch (op) {
                         case NEON_2RM_VREV32:
                             switch (size) {
@@ -6860,29 +6811,40 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             break;
                         }
                         case NEON_2RM_VCVT_FS: /* VCVT.F32.S32 */
-                            gen_vfp_sito(0, 1);
+                        {
+                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
+                            gen_helper_vfp_sitos(tmp, tmp, fpstatus);
+                            tcg_temp_free_ptr(fpstatus);
                             break;
+                        }
                         case NEON_2RM_VCVT_FU: /* VCVT.F32.U32 */
-                            gen_vfp_uito(0, 1);
+                        {
+                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
+                            gen_helper_vfp_uitos(tmp, tmp, fpstatus);
+                            tcg_temp_free_ptr(fpstatus);
                             break;
+                        }
                         case NEON_2RM_VCVT_SF: /* VCVT.S32.F32 */
-                            gen_vfp_tosiz(0, 1);
+                        {
+                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
+                            gen_helper_vfp_tosizs(tmp, tmp, fpstatus);
+                            tcg_temp_free_ptr(fpstatus);
                             break;
+                        }
                         case NEON_2RM_VCVT_UF: /* VCVT.U32.F32 */
-                            gen_vfp_touiz(0, 1);
+                        {
+                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
+                            gen_helper_vfp_touizs(tmp, tmp, fpstatus);
+                            tcg_temp_free_ptr(fpstatus);
                             break;
+                        }
                         default:
                             /* Reserved op values were caught by the
                              * neon_2rm_sizes[] check earlier.
                              */
                             abort();
                         }
-                        if (neon_2rm_is_float_op(op)) {
-                            tcg_gen_st_f32(cpu_F0s, cpu_env,
-                                           neon_reg_offset(rd, pass));
-                        } else {
-                            neon_store_reg(rd, pass, tmp);
-                        }
+                        neon_store_reg(rd, pass, tmp);
                     }
                     break;
                 }
-- 
2.20.1


