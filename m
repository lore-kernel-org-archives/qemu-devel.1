Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954BC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0624922429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="piXVvh64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0624922429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNTt-0003AZ-65
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNSk-0001tG-TX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNSj-0003Zu-Oa
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:43:54 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNSj-0003Y7-IA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:43:53 -0500
Received: by mail-oi1-x242.google.com with SMTP id 14so22028580oir.12
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MpVCv9Ixf6/DfcBFJ+SNRHUVUUgICqu7sWMbrPHm8Ag=;
 b=piXVvh64DuFi5ZFJf2NwQAE/AqhwJbRnyoZsgW+bditlhziDCl2dnXxZSnUzMVE367
 NAzn32Ak58HTs+udYOOShW0uuIIu1qJO3WVVgFL7IwbmrvHC7rL1I1ruqLP4USxHN3KR
 so7IiP7MRaSH9e0WKYmAccSf/bApxr9uAwgcjv9JMaa+tsWlNG/jzm2IwuadQoMqM+8y
 ndjrS/kpOIiaRmlyk1agDBb0n3TvLhBHzC9+UGgg9gkeL4WFRPbJVp1f2t6mfaA0ez9i
 gXx8r8p51Cql9+RBlqoiqllgBywQHVfDhIDGZybkJncuoxxE9kVc3FYRuvgSjNbFj4cw
 frxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MpVCv9Ixf6/DfcBFJ+SNRHUVUUgICqu7sWMbrPHm8Ag=;
 b=E/FP4TN8+mAPAr5wMngCfqj8X8tgxIbvT08fSELQ/7Z47H2Dz59stK2W0Myv2Ocrkj
 uxyOnSVjguYiAc8jVU74n/fq7RzBjg8YnhWm3T3JuYoXLuetndNmn6OYoNeMO/+RVUbW
 hLARNzHYXDQ7cE8RfmjcJ757ZLoEOCq7D2N6LQHV8wp3uWj8DXDIvZ0Pt5L9XN4veLVv
 8/DGXRX0Gv+cbT/4t8hPcaiypRhcv/c6Eq+UeFrXN69jYNui8pUqTRFpGzL8xMWtmd1Y
 1MDYtMwHFx3sdG+4LXD7A/K6oEC/ftscqRICrvBpTweQTOJFqoCu+EWAJOgjnTAfBc0s
 Ydiw==
X-Gm-Message-State: APjAAAWNi5vIvLHO69m9Ux8QoKJJAA8QPGzD1ESUWs3aEG07uKYcK8Yb
 GCFNqwO4yh7Xcj6NKXxe5DC9BH0ztJdsQkpZXOQBlQ==
X-Google-Smtp-Source: APXvYqzuSDc0HHtWY3DF3dcIbP2LdOYOhWkQqYgURc+NGwFliWi9ucvWfJv8qyuyU7MJze+j0jPtZn305uGerkFhPZ0=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr2126160oie.146.1574246632670; 
 Wed, 20 Nov 2019 02:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-15-marcandre.lureau@redhat.com>
 <CAFEAcA_2ct-fOfBGgNExjCrjg7WKb-Xp44GghHWXiW2+3HjWbg@mail.gmail.com>
 <CAMxuvayTGh6d5H_JXnKRoG7E1MeY-dsw5XqSeR59fdM7njPVeQ@mail.gmail.com>
In-Reply-To: <CAMxuvayTGh6d5H_JXnKRoG7E1MeY-dsw5XqSeR59fdM7njPVeQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 10:43:41 +0000
Message-ID: <CAFEAcA90uuQnWXjq=1RjiU5949vxaSuuy7EPFGjMJjpqmY7wMg@mail.gmail.com>
Subject: Re: [PATCH v3 14/33] serial-mm: add "regshift" property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 07:54, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Mon, Nov 18, 2019 at 6:54 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > > +static Property serial_mm_properties[] =3D {
> > > +    DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
> >
> > This could use a comment describing what the property does.
>
> "Set the register shift value"? Half-kidding, do you have better
> comment to make? Otherwise, it's probably not worth.
>
> From what I understand, it's just applying a shift on the IO addr,
> probably for alignment/access arch-specific reasons. You probably know
> better than me ;)

What this is doing is defining the spacing between adjacent
registers. Some MMIO-based 16550 implementations have the registers
at byte offsets from each other (that's regshift 0). Some have
them at halfword offsets (regshift 1); and some use 4-byte
offsets (regshift 2). Something like this will do:

 /*
  * Set the spacing between adjacent memory-mapped UART registers.
  * Each register will be at (1 << regshift) bytes after the previous one.
  */

(basically the comment bridges the gap between what I know as
somebody trying to use the 16550 model, ie the behaviour of
the hardware I'm trying to model, and what I need to do to configure
the QEMU code to give that behaviour.)

thanks
-- PMM

