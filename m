Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D1C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662AF207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGGTGFt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662AF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4opy-0006bx-F2
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4opL-00069S-9i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4opJ-00085v-Rg
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:37:26 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4opJ-00085Z-Ka
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:37:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id g64so4208131otb.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dCArdLtWX1HyX8S/uv2fGlGGt5ZXtKygvFHr8JPOMi0=;
 b=RGGTGFt4YzW3wqca6M9EB9qOZmPrRGIGqnC26S3JvhChSDct93+W/BjaNHfSmLNreC
 d96gnMuKQdtaQxa0JBJB3iwkUBd5/nsRFu8Os4J2a3fXm51WhIXBdZGWK2hy2PjA5qCD
 b5gOycDCk3gnuCYTEvTNkVS+DnsJ27/vboqWUHzJL1bfIBC2UG17s+xxqMMxdwg0cTA8
 3ENJMoJlxghypcaLSgYCIvwFq+3aCuyFz4m4/aG9N1GycBiDIt408gXYRfjtVxPFioVp
 wTDbs8zCJMDdfG3cU4Z4RwAlopEO4rQFu9Rygx4FPzggK88KO/Lzh2opr55FzcJEvmlx
 0rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCArdLtWX1HyX8S/uv2fGlGGt5ZXtKygvFHr8JPOMi0=;
 b=OCUKprp00bq9zLQu6Jf+PORYgBHPY8El9CVZHfvIgvHTsJpX9b5Kl1t0vyiguw0Zsx
 Ou/0H2rPkMGL5fGMAaa8dw1ML8RZp2APhcMSv2XGe+C2wq0hrLzFBobnwsMUQCHx+NhJ
 6ojOBiyuSqVMTInC5NtEcevuOmah9kylR1XPGp9TtbZAZ0tWe7210SpaUO3oeux5yTIN
 kL3p1yX1BCsiHu1DOiNCGKSxg3CRURHYCY3my37BWCwn3ZN6wdsUz3kpCToFJF2XIjwn
 CAj5QFPH2nZrDBwIUjZpiuUMnqBIq6XrQIWOQqMrWdk+wldTfkcLMoa/+Hm5IffVyRHV
 cFDQ==
X-Gm-Message-State: APjAAAW3YAQSuBR9QIvB9lw4aTQxoD21e1kTVTX5zE3pMTrD5pUbzFNt
 3C/ZTuu7MNElRIcmP6uasOe4e8uyKlas59qmE3sz4Q==
X-Google-Smtp-Source: APXvYqwOmEvoixR3STZfsP8wNTr0J+Ks8oj00DDuArHFoLoaXIgymTSLscZBSpu0ql/LttGQpugH7sObhGRZITCzYtI=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr24538903otd.91.1582216644555; 
 Thu, 20 Feb 2020 08:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-12-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 16:37:13 +0000
Message-ID: <CAFEAcA-fDx8HAFcgx57FhnpHPY6GnC1PxRRW=sLRY=5dDysfiQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] target/arm: Replace ARM_FEATURE_VFP4 with
 isar_feature_aa32_simdfmac
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All remaining tests for VFP4 are for fused multiply-add insns.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h               |  5 +++++
>  target/arm/translate-vfp.inc.c | 12 ++++++++----
>  target/arm/translate.c         |  2 +-
>  3 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4ff28418df..f27b8e35df 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3468,6 +3468,11 @@ static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
>      return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
>  }
>
> +static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
> +{
> +    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
> +}

This is tricky, because the SIMDFMAC register
field indicates "do we have fused-multiply-accumulate
for either VFP or Neon", so in a VFP-no-Neon core or
a Neon-no-VFP core it will be 1 but can't be used on its
own as a gate on "should this insn be present".

Currently in the part of arm_cpu_realize() which handles
the user having selected vfp=off and/or neon=off we
do allow (for AArch32 cores) both of those combinations.

trans_VFM_dp already tests aa32_fpdp_v2, so I think the
main thing we need to do is add a test on aa32_fpsp_v2 to
trans_VFM_sp.

We clear the SIMDFMAC field to 0 in the !has_neon condition,
and I think that should actually be in the !neon && !vfp part.

I propose to squash in the following and beef up the commit message:

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f641478fc80..d4c73a20b6a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3506,6 +3506,13 @@ static inline bool
isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
 }

+/*
+ * Note that this ID register field covers both VFP and Neon FMAC,
+ * so should usually be tested in combination with some other
+ * check that confirms the presence of whichever of VFP or Neon is
+ * relevant, to avoid accidentally enabling a Neon feature on
+ * a VFP-no-Neon core or vice-versa.
+ */
 static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d5a75c265ac..95ada81ebae 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1510,7 +1510,6 @@ static void arm_cpu_realizefn(DeviceState *dev,
Error **errp)
         u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
         u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
         u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
         cpu->isar.mvfr1 = u;

         u = cpu->isar.mvfr2;
@@ -1533,6 +1532,11 @@ static void arm_cpu_realizefn(DeviceState *dev,
Error **errp)
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
         cpu->isar.mvfr0 = u;
+
+        /* Despite the name, this field covers both VFP and Neon */
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
+        cpu->isar.mvfr1;
     }

     if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index f6f7601fe2a..69052d840a4 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1805,8 +1805,13 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
      * Present in VFPv4 only.
      * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
      * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
+     * Note that we can't rely on the SIMDFMAC check alone, because
+     * in a Neon-no-VFP core that ID register field will be non-zero.
      */
-    if (!dc_isar_feature(aa32_simdfmac, s)) {
+    if (!dc_isar_feature(aa32_simdfmac, s) ||
+        !dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
         return false;
     }
     if (s->vec_len != 0 || s->vec_stride != 0) {


thanks
-- PMM

