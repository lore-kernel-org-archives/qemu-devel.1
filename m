Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C325CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B3C21835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahiAWQuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B3C21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idH7M-0007gI-AK
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFzf-0007XH-Q5
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFze-0002wR-Ky
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:58:11 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFzd-0002u9-CG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:58:09 -0500
Received: by mail-ot1-x343.google.com with SMTP id k14so6207819otn.4
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fb/zFbIBB0HUkSJRs7t+iOyi2FOwR7dQTvmrrrZeQFs=;
 b=ahiAWQuRz+jhCIt/nE2Mw0mVVbQ9U2+Bo4mKLcTvcpm57QmOBdNaERM9Uw93unfres
 7UWY6oAnotubNbLbcCTu1tW8yM8ZUejl4epKliPBucSm5/pF8OeJQ/67e+fYoGQH26VZ
 5e/BJ06ioOe3dBbjc3oFyuzkdP5nuSovv6ZvEGa2KoGzGLj25xT0u6jyzzdK7lx7keUH
 +OlrHCObW479F/OVs8tPSBQo00OhpaO83L8Ye8UH5ZIb3CUv4gCeJQnlJ+Zieo2TvcD4
 NLLOO231HhG1K8G8Rm14w3OfjGJxTbNR+h3NJkqsA3wkbuXPvxGFWpdSVKyG+ZrmW3JI
 6zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fb/zFbIBB0HUkSJRs7t+iOyi2FOwR7dQTvmrrrZeQFs=;
 b=roNHsEujybCJ71Vd35evjPN/DLCteQvArGA4n7YK1AfYyjauG3X8GYcrWQkEIBWbv8
 TDAiBAsYx8usFxhuk5hQhD8k3BH7PTrL0rJ58tlinvcJu6rE09NLsb4yUlJlNyNEz/tq
 /W9V5saRIuphf+rDCBsahaBbDqXVhSnU48rtQenjsXb1yJ5Jg9Q8DHQbrc0CSx8zxCm5
 h44+lPLFZeaSypQ8qGsL00HC9+0g1ohdotOf3D5mewsG235wrrTFzPZlb9XGImZp+35u
 ENjM8aGWDdq0eMbCLNqvxMarwJ5XTNOVN/XtFfH6uu3z5w4lyl6TtNx4Z67MfAeO9Hms
 wc0Q==
X-Gm-Message-State: APjAAAUw+HB/6B+5B9+HS2u4v4lTpsynaxB/MqcbVkpuh96oQkYTkcU/
 OH9b29dkr47C5lkcCkRl8zzMGWSL0uP6KirhhkO6RV3x
X-Google-Smtp-Source: APXvYqwvQkBnSF+JHxTyvNmCo9i42NhYflWStwMmkYGBLxx84Pcgonrmar5ElHK4Gt7wAUM5Yr4XIaSm2DSqof3C160=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr11665381otq.135.1575647888441; 
 Fri, 06 Dec 2019 07:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-37-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:57:57 +0000
Message-ID: <CAFEAcA8rt4GPumj-W3LOMrOGfVQWD9XnSKZWNcWVVxHnD8BAwA@mail.gmail.com>
Subject: Re: [PATCH v4 36/40] target/arm: Enable ARMv8.1-VHE in -cpu max
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index a39d6fcea3..009411813f 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -670,6 +670,7 @@ static void aarch64_max_initfn(Object *obj)
>          t = cpu->isar.id_aa64mmfr1;
>          t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
>          t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
> +        t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
>          cpu->isar.id_aa64mmfr1 = t;
>
>          /* Replicate the same data to the 32-bit id registers.  */
> --
> 2.17.1


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

