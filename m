Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A77C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910822084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcmL0DVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910822084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hct5P-0000KC-SC
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46844)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiX-0003ns-LY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiU-0008Ec-H0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiS-0008Ci-Im
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so10199791wru.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=58okBtFY53UueZQheoG6tvyEr1auSHKr4SvkRALekYU=;
 b=HcmL0DVHuXRXq12RcoLQ8NhVo/OR6BXQMEPznOAcg4k5oONNz6PvMXlAotHAQdgtxx
 v7x/l2AOgmNW/vRTkOmAhVB/Wz+MAAXgGQVR0uP+NJp9oamgLoQubOetryLf7xJ8FqJv
 J322645qllC3My49ty71Up0h8Ch0KCtde4gJ9ocMxt6AytapqKd9FdEVKkRLgdobawmf
 3AUPdqjxWyUPFt7rOq9bPunW1hCEzIjbb6Fc/aE2adwuDMLlrb5yAdZ8vbjeQayLc9qu
 q5VCZU2akiLLvqFhCch3s7w8lRGjNfJFFleIkn9B+afYXRCYlNa7DzZdsDB0T1D/NY4r
 8NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=58okBtFY53UueZQheoG6tvyEr1auSHKr4SvkRALekYU=;
 b=TFuZq/dBHKiPlnt9aT0cwx9w3c2uBPv1EyU/8BiZ7uzFz2M1nFcj64qZpUUf8kFf+R
 dx3IsBv4OZX9ZjE3mfB5QSo4vvK77MoMl+jVKOB6MTJ0yeoEbGbGtY3Wvd/2XgJ6OiI/
 PZmEejCVy6lZHtV6qt3AL7emPKwEWgdHDeIcwMmRH9XfmjQg/1JFdcOAby23II7u64TQ
 4ZdrzqFae+rtCiq8meJih3/PBkB3G3E0+Jj7frcmneIGygowVe3pnv6ed3vpPLEGrtU6
 4BLhJ7VgQTfiE1NLVAF3e6oDRJ0V7LkzRFEVv7TC/RnYjAAj0zQiO6WYfMYzN+juxnIh
 hd8Q==
X-Gm-Message-State: APjAAAXuk6NoqNp9591ra50Wv2c3S+tvUsmweEBugc0IAajptXWevmQ8
 cli1/5NcrTNzY3EtIDXD4uCvk0AZJIOimg==
X-Google-Smtp-Source: APXvYqzvoUT4blT++IFUnIGN5nQQeBqCLEQYd96RJZtOI/U3tXP1yUDhMEFBdPedvPPCAf3Gj9ZDPA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr14635195wrm.191.1560782075325; 
 Mon, 17 Jun 2019 07:34:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:07 +0100
Message-Id: <20190617143412.5734-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 19/24] target/arm: Stop using cpu_F0s in Neon
 VCVT fixed-point ops
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

Stop using cpu_F0s in the Neon VCVT fixed-point operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-10-peter.maydell@linaro.org
---
 target/arm/translate.c | 62 +++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0fb94b777bf..d8b46130d42 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -80,6 +80,8 @@ static const char * const regnames[] =
 /* Function prototypes for gen_ functions calling Neon helpers.  */
 typedef void NeonGenThreeOpEnvFn(TCGv_i32, TCGv_env, TCGv_i32,
                                  TCGv_i32, TCGv_i32);
+/* Function prototypes for gen_ functions for fix point conversions */
+typedef void VFPGenFixPointFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 
 /* initialize TCG globals.  */
 void arm_translate_init(void)
@@ -1374,27 +1376,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-#define VFP_GEN_FIX(name, round) \
-static inline void gen_vfp_##name(int dp, int shift, int neon) \
-{ \
-    TCGv_i32 tmp_shift = tcg_const_i32(shift); \
-    TCGv_ptr statusptr = get_fpstatus_ptr(neon); \
-    if (dp) { \
-        gen_helper_vfp_##name##d##round(cpu_F0d, cpu_F0d, tmp_shift, \
-                                        statusptr); \
-    } else { \
-        gen_helper_vfp_##name##s##round(cpu_F0s, cpu_F0s, tmp_shift, \
-                                        statusptr); \
-    } \
-    tcg_temp_free_i32(tmp_shift); \
-    tcg_temp_free_ptr(statusptr); \
-}
-VFP_GEN_FIX(tosl, _round_to_zero)
-VFP_GEN_FIX(toul, _round_to_zero)
-VFP_GEN_FIX(slto, )
-VFP_GEN_FIX(ulto, )
-#undef VFP_GEN_FIX
-
 static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
@@ -5721,28 +5702,41 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             } else if (op >= 14) {
                 /* VCVT fixed-point.  */
+                TCGv_ptr fpst;
+                TCGv_i32 shiftv;
+                VFPGenFixPointFn *fn;
+
                 if (!(insn & (1 << 21)) || (q && ((rd | rm) & 1))) {
                     return 1;
                 }
+
+                if (!(op & 1)) {
+                    if (u) {
+                        fn = gen_helper_vfp_ultos;
+                    } else {
+                        fn = gen_helper_vfp_sltos;
+                    }
+                } else {
+                    if (u) {
+                        fn = gen_helper_vfp_touls_round_to_zero;
+                    } else {
+                        fn = gen_helper_vfp_tosls_round_to_zero;
+                    }
+                }
+
                 /* We have already masked out the must-be-1 top bit of imm6,
                  * hence this 32-shift where the ARM ARM has 64-imm6.
                  */
                 shift = 32 - shift;
+                fpst = get_fpstatus_ptr(1);
+                shiftv = tcg_const_i32(shift);
                 for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, pass));
-                    if (!(op & 1)) {
-                        if (u)
-                            gen_vfp_ulto(0, shift, 1);
-                        else
-                            gen_vfp_slto(0, shift, 1);
-                    } else {
-                        if (u)
-                            gen_vfp_toul(0, shift, 1);
-                        else
-                            gen_vfp_tosl(0, shift, 1);
-                    }
-                    tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, pass));
+                    TCGv_i32 tmpf = neon_load_reg(rm, pass);
+                    fn(tmpf, tmpf, shiftv, fpst);
+                    neon_store_reg(rd, pass, tmpf);
                 }
+                tcg_temp_free_ptr(fpst);
+                tcg_temp_free_i32(shiftv);
             } else {
                 return 1;
             }
-- 
2.20.1


