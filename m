Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF069C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CBC207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znccHflW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CBC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ouL-0000z9-Ns
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4otm-0000U6-QG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4otl-0000f7-K7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:42:02 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4otl-0000ev-Dj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:42:01 -0500
Received: by mail-oi1-x242.google.com with SMTP id v19so28154492oic.12
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 08:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sp0i+Q/58FD/WCAJSSRFedLSRBLfu6A1IdzKb3Z//YA=;
 b=znccHflWXEohxB9plCok/LBOtztow2r4BVCrJZm2ZoTbbllLO1+w4Bdkc/HaZa4XLt
 cKvTlluX8RZ37rApSb09aAUoLqAEfvTYXxbozGtCJ68K8YWBqRIyVNd0HJjmbgN+/SgU
 zX4mTmujvegnIV7x9neGnvU/A07yeZlpifWJKX1FdiRYI2VS7xH8fB9R3oybjPaOH2V4
 Ed4okJ1/lGto5jLZ8DnvOAMuLEgK/GzDJjMjnTTaSMyaL137KHIrUDEx57IMr/RdrrLY
 h7RjyU3oDpVWXn8N6ri6jIt7Pr5Xpn4X+70aDW0Z2nlOcEY4wMVeRDJJFm3AKn5Ogjce
 Lryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sp0i+Q/58FD/WCAJSSRFedLSRBLfu6A1IdzKb3Z//YA=;
 b=YzepnpmRo4QxUe2HJ25vQv0jtgEdmYwSxNKhabafBK3y93l95N/z2B6LuIxxphy20b
 m8hdrWNTv3ptY4cpHql74swbVdA5Yq8XsWWXKR2LgAdOk0TVY528pSCW4mz+O6UZ9h9d
 +0cRj2dyvhBrlmKMyLrc5KTJH70IpSo5iNqjFANgmWso2lol06iLFtj7YfL9tFClvcgR
 nm+jUZPCqauF6BgxloXns9argSgPVKiph0fVdoUzL4J/yXbeu4/tEemLZTJxsz+cEIiG
 1CN+M9XKiTWZ4yGwwkucSFzqOqZGGq46WUNuDK+vNi9j2PGtiv8E2+x0guaI7E0ucEtw
 S/bg==
X-Gm-Message-State: APjAAAW/NUYrGbbLOkw/BgNsGnVgl3Kk+OJLxa4N0r0bYrpfG5UcciN0
 eHrE9eVYuAXI/le595wIfN00vq9ijgd16YImg4FCk4LR
X-Google-Smtp-Source: APXvYqxhmP6wilU49/DsIoj5+As4wyrUfsx78YVwOpUnXYD6AFKVjfp7uNaWOTrwVdrGLHw19xAJyltdef5RrUw0XDg=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2663242oic.48.1582216920203; 
 Thu, 20 Feb 2020 08:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-12-richard.henderson@linaro.org>
 <CAFEAcA-fDx8HAFcgx57FhnpHPY6GnC1PxRRW=sLRY=5dDysfiQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-fDx8HAFcgx57FhnpHPY6GnC1PxRRW=sLRY=5dDysfiQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 16:41:49 +0000
Message-ID: <CAFEAcA_Qy48f786knq+dgu9DE6xCqD2N1nqytd-PkhPdX5XtJw@mail.gmail.com>
Subject: Re: [PATCH 11/19] target/arm: Replace ARM_FEATURE_VFP4 with
 isar_feature_aa32_simdfmac
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Thu, 20 Feb 2020 at 16:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 14 Feb 2020 at 18:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > All remaining tests for VFP4 are for fused multiply-add insns.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/cpu.h               |  5 +++++
> >  target/arm/translate-vfp.inc.c | 12 ++++++++----
> >  target/arm/translate.c         |  2 +-
> >  3 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 4ff28418df..f27b8e35df 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -3468,6 +3468,11 @@ static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
> >      return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
> >  }
> >
> > +static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
> > +{
> > +    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
> > +}
>
> This is tricky, because the SIMDFMAC register
> field indicates "do we have fused-multiply-accumulate
> for either VFP or Neon", so in a VFP-no-Neon core or
> a Neon-no-VFP core it will be 1 but can't be used on its
> own as a gate on "should this insn be present".
>
> Currently in the part of arm_cpu_realize() which handles
> the user having selected vfp=off and/or neon=off we
> do allow (for AArch32 cores) both of those combinations.
>
> trans_VFM_dp already tests aa32_fpdp_v2, so I think the
> main thing we need to do is add a test on aa32_fpsp_v2 to
> trans_VFM_sp.
>
> We clear the SIMDFMAC field to 0 in the !has_neon condition,
> and I think that should actually be in the !neon && !vfp part.
>
> I propose to squash in the following and beef up the commit message:
>

> +        /* Despite the name, this field covers both VFP and Neon */
> +        u = cpu->isar.mvfr1;
> +        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
> +        cpu->isar.mvfr1;

 ... "cpu->isar.mvfr1 = u;", obviously.


> -    if (!dc_isar_feature(aa32_simdfmac, s)) {
> +    if (!dc_isar_feature(aa32_simdfmac, s) ||
> +        !dc_isar_feature(aa32_fpsp_v2, s)) {
> +        return false;
> +    }

and not that extra "}".

-- PMM

