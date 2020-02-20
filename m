Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA66C11D20
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BF3208CD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auj4Et6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BF3208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4tGY-0006bR-9c
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 16:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4tFt-0005kN-2D
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4tFr-0002J9-MU
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:21:08 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4tFr-0002It-HE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:21:07 -0500
Received: by mail-oi1-x242.google.com with SMTP id q84so29085481oic.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 13:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YnFfOr1DIkvANCIdmIygvtIPcgNJtHgZY1pV50qrnYA=;
 b=auj4Et6Tlciab+LGElZTFsjgvl+7Tp5wVj0gxombpiXDbUKQWfDD14pfhUUn+X+Msk
 Bu0nCaGg0omAmKFreWQLLAP7L1T7d0/LB/l/dWuVCNfC1yROalZn+uapY6AvCYv4rPht
 tCyc0Lemk965i2UYwsrd3hz1J82OKNWtsGWTg22y0uAJWfIQmsT5YLM7eugsu0Hs19yN
 +L770TAoWYA3hO8wWFhy2xliGPYiIzwebGjVUjtSACw93blrO6p5lK9VXtnlJLrUXz3h
 nXgE0oVuMHJSb/tobgiOn/eZ35nK8GT2YQxQCVAyCjb277ME7hjiMSgTm6yngx6QXDxi
 pDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YnFfOr1DIkvANCIdmIygvtIPcgNJtHgZY1pV50qrnYA=;
 b=VyXkIx6FcbAc9VmThnNtxtgk9G2IGVgYABFm+mM9TSBbIAPpQDVw+3qt/ggyR8Zmea
 lrDXlHaRyhe7JS43PYAlr9MmyKquOOt9P5FtEjMZ4ZFpgDH0tZImMHYwjRvmb6MFzyCc
 JTEexAcf0Xxrdy1wYHq4hrgChnVgYZABiyGWtQTff56zhoeWuaTRAOaB7jHmtu41PQCx
 v6svL8yLFb79XYGxrMedx7LF8r+gsAYoWI0a8zKMS3VXkqEVJhUfVEEpkHx/ha8GJHdR
 /nIJPuo0NamGkB6VqexTWEV70BqEQormTzM3AvJjO87M2QzxRTxV9unrDSKi03zn+P25
 KuBA==
X-Gm-Message-State: APjAAAXVf7KKLYVRN+3RIMEA/nOkwGQ5+G2FetAY4i/BAHq4hZl3RErE
 JT6rzEHpUvUIkBLFyZYdBQL3/sCXQSOBUmgqb089qQ==
X-Google-Smtp-Source: APXvYqyAWkDygDzhAcQ8nyQ/oH+J+ckMAQXNsF0P9nfHdr1pYvsB8W9ZhwPSx6GpRVKCC1bPvGrU3YyBGjyqlGjGuYc=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3695887oiy.170.1582233666323; 
 Thu, 20 Feb 2020 13:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20200217032127.46508-1-pannengyuan@huawei.com>
 <20200217032127.46508-3-pannengyuan@huawei.com>
 <CAFEAcA_AxCVaAgho3g2q=kCifSdhz9Qi72eoVAM9gRjb3-_Sog@mail.gmail.com>
 <747a3358-09af-d4fa-9150-57ad3e349f24@redhat.com>
In-Reply-To: <747a3358-09af-d4fa-9150-57ad3e349f24@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 21:20:55 +0000
Message-ID: <CAFEAcA8ovMyTGNB_NA8ybPLdnneKjvNFY=qyP0DEFS9cmUJo-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw: move timer_new from init() into realize() to
 avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pan Nengyuan <pannengyuan@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 mav2-rk.cave-ayland@ilande.co.uk, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 18:52, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/20/20 6:56 PM, Peter Maydell wrote:
> > On Mon, 17 Feb 2020 at 03:22, <pannengyuan@huawei.com> wrote:
> >>
> >> From: Pan Nengyuan <pannengyuan@huawei.com>
> >>
> >> There are some memleaks when we call 'device_list_properties'. This pa=
tch move timer_new from init into realize to fix it.
> >> Meanwhile, do the null check in mos6522_reset() to avoid null deref if=
 we move timer_new into realize().
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> >
> >> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> >> index 19e154b870..980eda7599 100644
> >> --- a/hw/misc/mos6522.c
> >> +++ b/hw/misc/mos6522.c
> >> @@ -465,11 +465,15 @@ static void mos6522_reset(DeviceState *dev)
> >>       s->timers[0].frequency =3D s->frequency;
> >>       s->timers[0].latch =3D 0xffff;
> >>       set_counter(s, &s->timers[0], 0xffff);
> >> -    timer_del(s->timers[0].timer);
> >> +    if (s->timers[0].timer) {
> >> +        timer_del(s->timers[0].timer);
> >> +    }
> >>
> >>       s->timers[1].frequency =3D s->frequency;
> >>       s->timers[1].latch =3D 0xffff;
> >> -    timer_del(s->timers[1].timer);
> >> +    if (s->timers[1].timer) {
> >> +        timer_del(s->timers[1].timer);
> >> +    }
> >>   }
> >
> > What code path calls a device 'reset' method on a device
> > that has not yet been realized ? I wasn't expecting that
> > to be valid...
>
> This is not valid. What I understood while reviewing this patch is on
> reset the timer is removed from the timers list. But this patch miss
> setting timer =3D NULL in case the device is reset multiple times, here
> can happen a NULL deref.

I should have checked the APIs here.

timer_new() allocates memory and initialises a timer.
timer_del() removes a timer from any list it is on, but
does not deallocate memory. It's the function you call
to stop a timer (and arguably timer_stop() would be a
better name for it).
If you created the timer with timer_init(), then the
code to clean it up is:
 (1) call timer_del() to make sure it's not on any
list of active timers
 (2) call timer_free()

So:
 * the mos6522_reset code is fine as it is
 * if we wanted cleanup code that undoes the timer_new
   then that would be a timer_del() + timer_free().
   This would go in unrealize if the timer_new is put
   in realize, but...
 * ...like the other devices touched in this patch,
   mos6522 isn't user-creatable, so if realize succeeds
   it won't ever be destroyed; so we don't need to
   do that. (This is a little harder to check than
   with most of these devices, since mos6522 is an
   abstract base class for some other devices, but
   I think it's correct.)

Side notes:
 * for new code, rather than using timer_new() or one
   of its sibling functions, prefer timer_init(),
   timer_init_ns(), etc. These take a pointer to a
   pre-existing QEMUTimer, typically one you have
   directly embedded in the device state struct. So
   they don't need to be freed on unrealize (though
   you do still want to make sure the timer is not
   on an active list with timer_del() before the memory
   in the device state struct goes away).
 * maybe timer_free() should call timer_del(),
   rather than obliging the caller to?

thanks
-- PMM

