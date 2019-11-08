Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D768EC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A25215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="me70BZMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A25215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6gJ-0002NG-QG
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT6ez-00019O-8L
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT6ex-0000Wf-Un
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:58:52 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT6ex-0000WI-OP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:58:51 -0500
Received: by mail-oi1-x242.google.com with SMTP id j7so5659683oib.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LQ3GbzhAlWakkp9NcFJ+/X9NGKDGeaOkAkmOLvHt9y8=;
 b=me70BZMeByRR5nOfJOfXrhTXOLix/75IkVNyJwLh3MG2Vs4aWNyArN38fX455vnoiy
 7xQhnCorGK6EaaJWvFaBzv1o2ALA7IWTvKj86zUDvZn0cVb1cMyqNUhZJVZkMK6/3X00
 0iGArVQbqZAjRD2cZn5a3b8dfEmFjFoBeQ4+5FfnosuwQQqPe/An1X6s7gjk6MfT9m8A
 EWLf5uhTYtSpz/6oaefKht6SWGDuFlFtC5lcbFEO/7hVX575Bb5sD5oU83jX4Bo5Hxzy
 Lu1AwrTL0g7pnH8VIyr1qlavg8O0kqvCkcgfsth/N3c09i7Yu218RbrTkuCgc/04wCZg
 NNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LQ3GbzhAlWakkp9NcFJ+/X9NGKDGeaOkAkmOLvHt9y8=;
 b=I+cFFAx9GXs8apPavZKnFj2PSnaz9G25h0cRo2CIMDbS9gBmNZSVVSMe+C7a8lteLf
 /qyhXzssC/2CoQCTqe0Sd4fia8VgaYW38DUfR0XQx/XciXNv7EwqV4qsgzux0NpaYdkH
 ZCOZ2ZfT2xzGU1or6priLTE0/ZAYFN6fMA3aItTHqK8tWV4DYg0SGybxHYbOAtzpt0D2
 HLcl5VHBsXgLKGdkfVMRGpE6tgDdDz8GqGD3/g6L+wzAKKVsfTZyIbB1Q7pDOqeGHytL
 YsbNCNmQpSZA1doCDG7sGlcQfXHT6+RpCzBn5C/KiUzXuPqA1dJrb9eHHCJ2SDY2g0RR
 o0Zg==
X-Gm-Message-State: APjAAAVhsY8MTmHP6+Rfoq6YGlKA0XSx7RSLRQ3gU3vuE1MHtBLuSZ1X
 srDFcZT63V8sFPkNi+Mm/1xY1X3GajpIzrUhP7fHlQ==
X-Google-Smtp-Source: APXvYqzFXH+9WFfpqv3yYUfaBZFAmE/GIL0oVY3rX9uVSdZK284SwP8KgIKsmc754r4MdcrhxIy1eTKYvtJ1dIycOYc=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr9887523oia.146.1573228730711; 
 Fri, 08 Nov 2019 07:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20191104115228.30745-1-graf@amazon.com>
In-Reply-To: <20191104115228.30745-1-graf@amazon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 15:58:39 +0000
Message-ID: <CAFEAcA8zkR_MZ-28Nc=x4j05U9MsFYfzQtkHxTf65ZwacK020w@mail.gmail.com>
Subject: Re: [PATCH] pl031: Expose RTCICR as proper WC register
To: Alexander Graf <graf@amazon.com>
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
Cc: Hendrik Borghorst <hborghor@amazon.de>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 Nov 2019 at 11:52, Alexander Graf <graf@amazon.com> wrote:
>
> The current pl031 RTCICR register implementation always clears the IRQ
> pending status on a register write, regardless of the value it writes.
>
> To justify that behavior, it references the arm926e documentation
> (DDI0287B) and indicates that said document states that any write clears
> the internal IRQ state. I could however not find any text in that document
> backing the statement. In fact, it explicitly says:
>
>   "Writing 1 to bit 0 of RTCICR clears the RTCINTR flag."
>
> which describes it as much as a write-to-clear register as the PL031 spec
> (DDI0224) does:
>
>   "Writing 1 to bit position 0 clears the corresponding interrupt.
>    Writing 0 has no effect."

DDI0287B page 11-2 section 11.1 says
"The interrupt is cleared by writing any data value to the
interrupt clear register RTCICR". As you note, this contradicts
what it says later on in section 11.2.2.

(Interestingly, the PL030 does have a "write any value to
clear the interrupt" register, RTCEOI.)

I'm fairly sure this patch is right and the DDI0287B document
has an error, since it isn't internally consistent and doesn't
match the proper PL031 TRM.

Did you find this because you had a guest that assumed the
other behaviour? This bug has been in QEMU for a very long time,
and it seems odd for a guest to deliberately perform an action
(writing 0) which is documented to have no effect on the device...

> Let's remove the bogus comment and instead follow both specs to what they
> say.
>
> Reported-by: Hendrik Borghorst <hborghor@amazon.de>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  hw/rtc/pl031.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
> index 3a982752a2..c57cf83165 100644
> --- a/hw/rtc/pl031.c
> +++ b/hw/rtc/pl031.c
> @@ -149,11 +149,7 @@ static void pl031_write(void * opaque, hwaddr offset,
>          pl031_update(s);
>          break;
>      case RTC_ICR:
> -        /* The PL031 documentation (DDI0224B) states that the interrupt is
> -           cleared when bit 0 of the written value is set.  However the
> -           arm926e documentation (DDI0287B) states that the interrupt is
> -           cleared when any value is written.  */
> -        s->is = 0;
> +        s->is &= ~value;
>          pl031_update(s);
>          break;
>      case RTC_CR:
> --
> 2.17.1

thanks
-- PMM

