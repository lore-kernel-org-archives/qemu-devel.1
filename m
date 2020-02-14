Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F85C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE354206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8i92GpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE354206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Z9o-0005QD-Tq
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Z9G-0004cS-GD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Z9F-0001qY-Ee
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:28:42 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Z9F-0001na-8W
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:28:41 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so8795389otp.12
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 03:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=T3WQQCj6yucsdin23UHrYAywy+JHA12EPhx97GpWFTA=;
 b=q8i92GpO6NEHiLzGKOVNAt/PZWJ1rlJxCRNGc2XJAlJDxsRPD3dsVAxf8zxzv+ibts
 SNzjmPCaqHH79zfIYsToSFqsRgSr+ijG3/j+eriurb9PATX994ZIfKfbIM79LU3gMzzU
 pNC3qNPpRF+ILyr7cZQUQdhr2Ritmm0T9CaVjOPgWeS84Ub7LE5c3bLNQSMyUq2PlCDB
 qCe3jLOprlZQONPLYStGkFTk0OGM7A9qoTA5Igc6ivj1TMEZtbsvtD/kZ41lVfN1M3/E
 2TtJ4H+PdrbDvVgV1dILIokrQbpU3fWUfjTDiOSo+sLoLp49NLDd0S4k9UNRiSuTTfHQ
 VO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T3WQQCj6yucsdin23UHrYAywy+JHA12EPhx97GpWFTA=;
 b=cCOJAAwnePpfqDWdhSBnUIVnDguHcryL+PRD0rvxxdxZuvXC5HtJW18YOKs2dmw/7Z
 EnZ340IaiXyxFU57gPmaWwhng/6rAbDZCJ19IhLckiR3tpkI57nUQF/FCPM9z32R71gr
 rymOg9GMzJWHxdkciEaticuWoCOiIUIQOPQ7vHMN7HgnIIW3hO12m1LTBZqFp9Q9Lp8z
 q4oVMr4bG0xa+KuM0/auMev6jWOrHqksaFknmxUohzO6KXYxOzRmQYwULVDIvNHVmWqb
 NJTe84AZnBWYy69n5GqHVwn0F7ikJN5orV/kEsoCgpygFlS8oQkxeid/YijM1TX+dG8Y
 vOBA==
X-Gm-Message-State: APjAAAXF/Xh2NNxJyKtKAf6yndCo6SFXDnMbeSKbN5jEvq5rcMu31f+4
 wd5XNyIcR+J7whx0K5xqI7mmkCIjv2VzkGznwlqOYA==
X-Google-Smtp-Source: APXvYqxUd8Zjx+Ikeubo/gjWlu03J9squRIEMqoDBhfOUJ6HojuhOhaCaa4EIWlm1/HA7CjKz9hPJGLNW1aN9yn9e1c=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr1874055otq.135.1581679720055; 
 Fri, 14 Feb 2020 03:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20200208125816.14954-1-richard.henderson@linaro.org>
 <20200208125816.14954-4-richard.henderson@linaro.org>
In-Reply-To: <20200208125816.14954-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 11:28:29 +0000
Message-ID: <CAFEAcA-ffaK7e2ACZvqXs3fcx22O3cyWHdKqoddmYu8z2ezJ1Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] target/arm: Add isar_feature tests for PAN +
 ATS1E1
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 12:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Include definitions for all of the bits in ID_MMFR3.
> We already have a definition for ID_AA64MMFR1.PAN.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -3443,6 +3452,16 @@ static inline bool isar_feature_aa32_vminmaxnm(con=
st ARMISARegisters *id)
>      return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >=3D 4;
>  }
>
> +static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) !=3D 0;
> +}
> +
> +static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >=3D 2;
> +}

Didn't spot this before it hit master, but these feature
test functions are looking at id->mvfr0, which is MVFR0, not
MMFR3 !

Also they're using FIELD_EX64 on a 32-bit register: is there
a reason for that?

thanks
-- PMM

