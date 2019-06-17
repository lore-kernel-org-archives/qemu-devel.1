Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BDC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4291B2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n31Y7vMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4291B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctD6-0006ho-GV
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46871)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsia-0003pS-4w
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiX-0008Gi-LQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiU-0008De-Hh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so9538091wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=I+75XYVbaOE0Z2VDKw9wMsw3L7xan4AZtISiVXygjxo=;
 b=n31Y7vMmVr1cGe6vd8hgYl30AfkxpqCBcyApRfUuqXhFXT7iBYSOTwhHGP4cJlkzzU
 fKs4yIdvd5TrBQdSeQphc84faXvDYm85vLe3gmsKuCGjCnI+1ENRZWXbuZars6FfanF9
 wjfNBUgFaYNoejoCZ1FY1JiAMPiZTrOslfLQSdb6PW4PZJi9cGIbjCPiPs77KwIVUySF
 B5iEBwgu0otypk7DfERD4iDm/aAnB6buX/OcmFASSW12sQ00ksFrd86ucP4RIBdDN45w
 rpD1httqB4xf2fLgixK0rUnRgfJsxS3C1hErae5GUL0SDRLsBI6NLXL5ZhOFAphqR7w1
 FRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I+75XYVbaOE0Z2VDKw9wMsw3L7xan4AZtISiVXygjxo=;
 b=tAUyuss71YEO95N9ztIWVxf7uz6JmeEN0QIHt2pjOpg15hmELpPKwULKicXRVKtODC
 zSopUnn6tr/ArfszIR3p4UDt2z2/aKieHUEg440VVTIMEVDEmY32OGyzD9il6vy4FUpA
 WZd3MOk+7bPIaJhuhgooNtfVZ31LFp8/4fPhh2H5zirss+MrK7oWsGDrLs14qYbcSpUG
 x3HlE2uscXb+P1vzG3XcvipxpuY0yO8pz7MWpFly/rzLJg00Ajpql3RGVdvhB4Cpy3lC
 WERzM+02cDQmk8uo+0sYAuXOYKOVnmgHFHTDk4NkRKPd6Cdag7CqXU6ZWPYy4fWNJfhs
 lzcw==
X-Gm-Message-State: APjAAAVXRyDNutdDwU2SHiUwbfT2Cg3JFfFZh0S1MlKoFPEwkwokwixJ
 4htsv7din84nVUqHRRRc0HIkMpNxUlbERA==
X-Google-Smtp-Source: APXvYqx1ByhstLCr56OPa7CI5Xu2qeDqvH8w72X8I5/Pvsr3OoqJS/4wpIfHF+6c6ZoGEGMy9JMyUg==
X-Received: by 2002:a1c:9d86:: with SMTP id g128mr20845691wme.51.1560782076266; 
 Mon, 17 Jun 2019 07:34:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:08 +0100
Message-Id: <20190617143412.5734-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 20/24] target/arm: stop using deprecated
 functions in NEON_2RM_VCVT_F16_F32
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

Remove some old constructs from NEON_2RM_VCVT_F16_F32 code:
 * don't use cpu_F0s
 * don't use tcg_gen_ld_f32

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-11-peter.maydell@linaro.org
---
 target/arm/translate.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d8b46130d42..2ba620ac1e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1542,7 +1542,6 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
     return ret;
 }
 
-#define tcg_gen_ld_f32 tcg_gen_ld_i32
 #define tcg_gen_st_f32 tcg_gen_st_i32
 
 #define ARM_CP_RW_BIT   (1 << 20)
@@ -6425,25 +6424,23 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         q || (rm & 1)) {
                         return 1;
                     }
-                    tmp = tcg_temp_new_i32();
-                    tmp2 = tcg_temp_new_i32();
                     fpst = get_fpstatus_ptr(true);
                     ahp = get_ahp_flag();
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 0));
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 1));
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
+                    tmp = neon_load_reg(rm, 0);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+                    tmp2 = neon_load_reg(rm, 1);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, tmp2, fpst, ahp);
                     tcg_gen_shli_i32(tmp2, tmp2, 16);
                     tcg_gen_or_i32(tmp2, tmp2, tmp);
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 2));
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 3));
+                    tcg_temp_free_i32(tmp);
+                    tmp = neon_load_reg(rm, 2);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+                    tmp3 = neon_load_reg(rm, 3);
                     neon_store_reg(rd, 0, tmp2);
-                    tmp2 = tcg_temp_new_i32();
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
-                    tcg_gen_shli_i32(tmp2, tmp2, 16);
-                    tcg_gen_or_i32(tmp2, tmp2, tmp);
-                    neon_store_reg(rd, 1, tmp2);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp3, tmp3, fpst, ahp);
+                    tcg_gen_shli_i32(tmp3, tmp3, 16);
+                    tcg_gen_or_i32(tmp3, tmp3, tmp);
+                    neon_store_reg(rd, 1, tmp3);
                     tcg_temp_free_i32(tmp);
                     tcg_temp_free_i32(ahp);
                     tcg_temp_free_ptr(fpst);
-- 
2.20.1


