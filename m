Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF86C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131892064C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyiVEyYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131892064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isAA4-0005IG-Tc
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isA90-0004CG-1k
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isA8y-0003ii-GJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:45:25 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isA8y-0003iA-92
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:45:24 -0500
Received: by mail-ot1-x344.google.com with SMTP id p8so20288357oth.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TR9f1ok6iW3VkN7SoUvSSrDpC6U7lDL9AuOXaWKii4w=;
 b=oyiVEyYUbvEHYxDkO37+T9kqj/t4aq5GYH5nF49NCaYwwPlgCEXiirOMQhE/F3n2tf
 Rg1wNsEVwy1Hv+By18nv/cv7h5Htd8KX6s6mQ8OZayt3NDpbplms0RePcMDJEmFSoi1s
 /Ouolg9gCvJaFJJDEwKDyh4q2fCQhRgnbjktdw314wdP7F/a2c3BsMWpbtdAho1zgTBv
 6uns2fJjV5LNjBLFiIiXsUe0xsgnFGGp0hKqNVNU2D+K8lbS8mmQBs9mRGZfeDn5mxVU
 wP9Kw0GGbZBnX/sb4p0vgMonXGDzNzrVbnKXzBhnYJ3nuZbE9hHXuAZjXM+5iAYRR/2N
 r4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TR9f1ok6iW3VkN7SoUvSSrDpC6U7lDL9AuOXaWKii4w=;
 b=PcFYhICUrYy5WtzlT1c32UAWwBb8CvNqPBTNxK9BIRTeD3f3biYHemfMjqLd9aXGAo
 KwIhv1VUbr97MBjxAWizehe+2ltkinTa/WkHIJbqtlExrzh7J6BDO32QDhrXnLVqvBvG
 ghdJKILhX5T62ihqaM6zRPSguu/1kGWDU4wZKhLBtBgy2cTpyByXpgGTPKSE3uDnYTOz
 LzmL9pkjK2LZl9Ey7KdGtWFxXnsvPZfhd+PlQHE1iFrEDdqQ2WBMeAEOomG4vK7OmwPk
 o4poR4ZUNtAi47doNH7GpMkVwd8LA4hEilBwLg6M+YwwBCxJ75u7oJE+209IvZy8NYMh
 miVg==
X-Gm-Message-State: APjAAAXQoYs62DLbJditfmky3fojGVm3hc1Jh2p8fQf+7sFIaPjsPGdY
 jM/GL8ddQ8UxuGiBGgSxwkb2ePqkzYWNwvEVsmLXZw==
X-Google-Smtp-Source: APXvYqwa4EPzfP9xdOFoZbiT+5NEaYYybMg4bsvicufUkGr/0nbm2k3Cy6iTqLNnJLVRrXWFnes8pYxRzwnnq9cUoFg=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr3017295otq.97.1579200323297; 
 Thu, 16 Jan 2020 10:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20200110161626.31943-1-alex.bennee@linaro.org>
 <20200110161626.31943-2-alex.bennee@linaro.org>
In-Reply-To: <20200110161626.31943-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 18:45:12 +0000
Message-ID: <CAFEAcA9nNH9pu+8E_YYkiNtzePjZdrEBjK_9zJv+XJaSvcnhmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] target/arm: detect 64 bit overflow caused by high
 cval + voff
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
Cc: 1859021@bugs.launchpad.net, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 16:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> If we don't detect this we will be stuck in a busy loop as we schedule
> a timer for before now which will continually trigger gt_recalc_timer
> even though we haven't reached the state required to trigger the IRQ.
>
> Bug: https://bugs.launchpad.net/bugs/1859021
> Cc: 1859021@bugs.launchpad.net
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 19a57a17da5..eb17106f7bd 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2481,6 +2481,9 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeri=
dx)
>          } else {
>              /* Next transition is when we hit cval */
>              nexttick =3D gt->cval + offset;
> +            if (nexttick < gt->cval) {
> +                nexttick =3D UINT64_MAX;
> +            }
>          }

There's something odd going on with this code. Adding a bit of context:

        uint64_t offset =3D timeridx =3D=3D GTIMER_VIRT ?
                                      cpu->env.cp15.cntvoff_el2 : 0;
        uint64_t count =3D gt_get_countervalue(&cpu->env);
        /* Note that this must be unsigned 64 bit arithmetic: */
        int istatus =3D count - offset >=3D gt->cval;
        [...]
        if (istatus) {
            /* Next transition is when count rolls back over to zero */
            nexttick =3D UINT64_MAX;
        } else {
            /* Next transition is when we hit cval */
            nexttick =3D gt->cval + offset;
        }

I think this patch is correct, in that the 'nexttick' values
are all absolute and this cval/offset combination implies
that the next timer interrupt is going to be in a future
so distant we can't even fit the duration in a uint64_t.

But the other half of the 'if' also looks wrong: that's
for the case of "timer has fired, how long until the
wraparound causes the interrupt line to go low again?".
UINT64_MAX is right for the EL1 case where offset is 0,
but the offset might actually be set such that the wrap
around happens fairly soon. We want to calculate the
tick when (count - offset) hits 0, saturated to
UINT64_MAX. It's getting late here and I couldn't figure
out what that expression should be with 15 minutes of
fiddling around with pen and paper diagrams. I'll have another
go tomorrow if nobody else gets there first...

thanks
-- PMM

