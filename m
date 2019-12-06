Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A825C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D7B24670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJJg6Pnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D7B24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHvT-0007hG-OF
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idH3Q-0004Vm-5P
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idH3O-0007fy-SR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:06:07 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idH3K-0007as-V6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:06:04 -0500
Received: by mail-oi1-x241.google.com with SMTP id x14so364079oic.10
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ggQ1kQQIs7cX9AnmY3sr6TzDbLNAqmck3sWzxawrlWc=;
 b=mJJg6PnfIBXE/g/DJcQ+lWBEOt9fgbvuN66hCtXFDqVo3MXhNNTZn+Ll4SFt9fNtJ3
 9he74Hfpgtf5WR/07bWTsXeBowwCGU8fsMBMsz7zm0FCO9hLg3jXWlwAGEiO+xg22I97
 lr8zjHvIQ9XkFa9kLGYcKXd952hPOuR8cGiN7wmKSZMhiY4G0KPRSU6NPlzriHA9n4aZ
 6xuU/Y4/ccS9mO8yQqO2mOL65hlhgDKrVh+kF+diDICK2qT0HABYjXeT/h9oS9kEqLDO
 qiFYVnrQUDqFQ4RIIjDtk9LQuk2L2be02KqrcG7OqHk7pEYGTN7OdcA0Q8HdrgY4I3GL
 1msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ggQ1kQQIs7cX9AnmY3sr6TzDbLNAqmck3sWzxawrlWc=;
 b=p9WvCfKxSjc3YdnybGbkwv+RxL0RbHmyioYkjsHH9deky0daXh/TB40Ld556OmMYe3
 wBDehvz1iQv6GphvQ0ryWtVqJIfxwr7mPhNi/G0VIOGEMCpqUOpHMGkmgMlYccnlJT8f
 1lccTMDuOUu5Si8umENrZEGyHa6i4uCVh+7t/e3/6PWtyvAvSq1jsdMFksrYYKdEhrgZ
 FkobRM8V+OWPFQ5gBMVakJ4jannHRIFfaxKrg/QSm45iSJaVKKCeuGGLXPPcdb87FP1C
 4ScS82C/CvBlUvX2kkfVb173X3TrAc+6cdXctmOhXeAg58sOe1J5/394My63ajiHiqn4
 qqpg==
X-Gm-Message-State: APjAAAXcNXsVx9Lg+gpKNpJv9Wpx5JnGWDtf+xInRd7LzV3pzqnffjBF
 KgXdrdfWRC6GMls8q7sTpSPnWCMXtINDLTPlVyjP/r6Q
X-Google-Smtp-Source: APXvYqwCSpi8ZDHjpw0FW1pQ7dtjTZNh/Yuju5kvciP/PUFdKghWL07S0+anAatu9TsTdenmXTQ6HVA+02u85oHmWuE=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr12599527oic.146.1575651960592; 
 Fri, 06 Dec 2019 09:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-30-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 17:05:49 +0000
Message-ID: <CAFEAcA9=4MXFEnVbPpa1CmG8xHx-xuVt8MXwsNGyT+nB2+L1Mw@mail.gmail.com>
Subject: Re: [PATCH v4 29/40] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since we only support a single ASID, flush the tlb when it changes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9df55a8d6b..2a4d4c2c0d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3740,6 +3740,15 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                      uint64_t value)
>  {
> +    /*
> +     * If we are running with E2&0 regime, then the ASID is active.
> +     * Flush if that changes.
> +     */
> +    if ((arm_hcr_el2_eff(env) & HCR_E2H) &&
> +        extract64(raw_read(env, ri) ^ value, 48, 16)) {
> +        tlb_flush_by_mmuidx(env_cpu(env),
> +                            ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0);
> +    }
>      raw_write(env, ri, value);
>  }

For the existing EL1 setup we have separate write functions
for TTBR registers and for TCR_EL1 (vmsa_tcr_el1_write()
and vmsa_ttbr_write()), rather than a single one, and they
don't do the same thing. Why do we use a single writefn
here? It looks particularly odd because we're actually looking
at the value written here.

thanks
-- PMM

