Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D31C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2F4218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJAB5pZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2F4218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EIm-0001za-EJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2EI6-0001QJ-A1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2EI4-0005Mz-Qg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:12:26 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2EI4-0005Me-1r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:12:24 -0500
Received: by mail-ot1-x343.google.com with SMTP id d3so5508691otp.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6r/QsSZ7B17NgXpFGYy/3rRpEkFTsOo1M2q8iAP/Z14=;
 b=oJAB5pZZZFWy3Em9IxgDa88v8lHqEN2QD5H+GwD7TmZYTlfx/IA7Dj6ECtf1SV/eGX
 bkH5xvY6QnJK48PmW9NTnA1BsIlgaF0r/F5jLtAjWPa8tz11UAubasLwoU0wk5kRSX0B
 TmjWGpwDGEt/R3iiZsFTjIyBnKXGCN+hsJpb94foBT513SDU6wMfAJ4xqWy3ajPB0qO8
 kmD23+awy0brNUJB2mRhpk0MBnSzCk0emqBkJW18NuDJotq+poHAgHh4ud1uEzigLzpJ
 FiUDccgbtjHB3D+F+vSuRE4rT/qEOsbFh+bCw5ZYg1PaCTPQ7YiY2dQKqf07RXR2HzCH
 SM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6r/QsSZ7B17NgXpFGYy/3rRpEkFTsOo1M2q8iAP/Z14=;
 b=GJLyk9Ig1tgWifrrufVJwYC/9RDqH+o7gn0khFaEbZ3VVBoXNO7cBg20Xsyrn6FumM
 L451pLl4lYu0vzH/c3ZODafFl2v3yljZbe59kjkUdA9Cv2dCyRz2cxo5vDMA9xa+/8S5
 cEEY8ZnglB9nvg12OmmT+7Q052g9oXOsOH5NC1mYKU/2pw23ULztjgFlF6uNqRAsicg3
 fRoN3Ax8qHEIUdgot60+8PWorWDv3lldo+wD8g2Nmz14VrNh5dgzKticBGpW2FxpbKN8
 znKq31V+N2q6rjtQZrakQdEyEVa5SZL3nti98nc99lfZ9SDlDHGrkHi6WpKjg/pS6Fmg
 Y6Hw==
X-Gm-Message-State: APjAAAU7OZIKwphRQaBTR1bVNNHuQx5oVQi2RCBpakGfMPPfWQagkAqZ
 d48LcG24F0DkyhMYbN0MUfo1RFbrrac7WpyeVJerNw==
X-Google-Smtp-Source: APXvYqyj/7EEVOVYKaTzNCfb472OqvewKVqUs+BWvBJvQjAMa3S1oK9z+vHrHeXSNns7H6eHZGDsHOnERc5j3YaoEKo=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr12503639otq.97.1581599542519; 
 Thu, 13 Feb 2020 05:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20200211194228.16907-1-richard.henderson@linaro.org>
 <20200211194228.16907-2-richard.henderson@linaro.org>
In-Reply-To: <20200211194228.16907-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 13:12:11 +0000
Message-ID: <CAFEAcA9Lq2tbsGqpSYWU=g1OYfu_TeXv5nuyBayJwapdLLKP9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/arm: Fix select for aa64_va_parameters_both
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Tue, 11 Feb 2020 at 19:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Select should always be 0 for a regime with one range.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This change makes sense, and matches what aa32_va_parameters() does,
but I think we need to update some of the callsites.

(1) In get_phys_addr_lpae() we have the check:

        if (-top_bits != param.select || (param.select && !ttbr1_valid)) {

where ttbr1_valid is the return value of (effectively)
 aarch64 ? regime_has_2_ranges() : (el != 2);
but I think it's no longer possible to get here with param.select == 1
and !ttbr1_valid, so this becomes a dead check.
(Side note, could we pull "ttbr1_valid = regime_has_2_ranges(mmu_idx);"
out of the "if (aarch64) {...} else {...}"  ? -- I think it works for
aarch32 too, right?)

(2) in pauth_original_ptr() we do
    uint64_t extfield = -param.select;
but in the pseudocode Auth() function the extfield is unconditionally
calculated based on bit 55 of the address, regardless of whether
the regime has 1 range or 2. So I think this code can't use
param.select any more but should simply pull out and replicate
bit 55 of its 'ptr' argument, now that param.select is not simply
the value of bit 55.


Change 1 would need to be done after this patch and change 2 before it.

thanks
-- PMM

