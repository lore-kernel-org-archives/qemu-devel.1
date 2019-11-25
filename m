Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36DFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD64A2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPPsIXpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD64A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDYW-0003OL-Rw
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZDNl-0000uD-02
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZDNj-0000oq-Rf
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:22:20 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZDNj-0000oN-KA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:22:19 -0500
Received: by mail-oi1-x241.google.com with SMTP id o12so12854211oic.9
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 04:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nrStpk29kDhtV6WW3bONM3AQJGpJlVdaZYTiHGWyao8=;
 b=nPPsIXpO65UNRZiambd3SXBYAywrKpTTJ+J0eV1Vm9iFq7GTBKZgB0wPsAlc6ZrScT
 gV2w5LXD1nv0F06zGWK9POWsncmEGoPql9nG6MDb/VUbU5bNcc8B6JGWocxFD3QqaWm8
 eJI2qvnzttub9cUCuAEtZD2O5LQIr3yfRvZBMVeT9zlwt6a2XWFrUoiyeVtxlyxQdkRp
 86pkuovNVRXNT877p8ldqQpj7ByOWAzaot5Tl0GVbzqqONDeqBskRTzHNJWzic3JLolo
 kcGTvj68FSheRtFQsMxoquMmOwC6aVvRuvBPY8oW5MgeZZdo0WqADpajeV4p208qw1fF
 gVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nrStpk29kDhtV6WW3bONM3AQJGpJlVdaZYTiHGWyao8=;
 b=qFf2LIO3Mq5NSJlVBO77lmSsjYpJHSs0JRHZ9te7hOtMmpKEBKbVO1XNR7rAEgU+GH
 uOb7+J4qsLMLvwqtyUq9Bi04+00kgQ2Gomx6JV1aGGBRT44O7JqMNWla0m1jQ0/qgEfX
 EYoNTB4xRq19pch+kjqy6lyiaOa1Dtsd1jUNFj8mKYBrg8T9gVNFZZ4X9+Weg6afQW6g
 2eofBY+y57qoNkD2oQEHtGhiZsWocGs72ByBne5zp9oL6+IoxlE0HbR3WdYznhNvcO97
 5cwAgCr1PTSnv7PThnO8VnyD81JZHxmdL2vDFJQqGxRMRQwdDnA6NVcbVI7Tw3vRi+q8
 UYHA==
X-Gm-Message-State: APjAAAU6MWiyxq2bxtJWg1kc1ogelmgfDvudqd2FF524S2gPrYTpXegi
 LjnD8GwyaeE/RDDg3fI4rflCcStYFoI8btqNCCo=
X-Google-Smtp-Source: APXvYqynq//zQur+eKagbWYwpxiOyztEo1jVO+JODe5qU40wlz/IoU67+k/mVxBDfpV1gr2MGXkiYnhvuFu+LC/jNpE=
X-Received: by 2002:aca:5786:: with SMTP id l128mr22925565oib.53.1574684537700; 
 Mon, 25 Nov 2019 04:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
 <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
 <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
 <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
In-Reply-To: <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 13:22:07 +0100
Message-ID: <CAL1e-=hTV=3YOmJwJkE+Zhmvw5P47WEAZm+CRcKCqPzBKXY+uw@mail.gmail.com>
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 12:26 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 11/25/19 11:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com> wrote:
> >>
> >>
> >>
> >> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lur=
eau@redhat.com> wrote:
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>   hw/mips/mips_mipssim.c | 1 -
> >>>   1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> >>> index bfafa4d7e9..3cd0e6eb33 100644
> >>> --- a/hw/mips/mips_mipssim.c
> >>> +++ b/hw/mips/mips_mipssim.c
> >>> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
> >>>       if (serial_hd(0)) {
> >>>           DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> >>>
> >>> -        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
> >>>           qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> >>>           qdev_set_legacy_instance_id(dev, 0x3f8, 2);
> >>>           qdev_init_nofail(dev);
> >>> --
> >>
> >>
> >> Please mention in your commit message where the default baudbase is se=
t.
> >
> > ok
> >
> >> Also, is there a guarantie that default value 115200 will never change=
 in future?
> >
> > The level of stability on properties in general is unclear to me.
> >
> > Given that 115200 is standard for serial, it is unlikely to change
> > though.. We can have an assert there instead?
> >
> > Peter, what do you think? thanks
>
> This property confused me by the past. It is _not_ the baudrate.

The name is "boudbase" (whatever that means), so not "boudrate".

Can we perhaps track the "inventor" of the property?

Google search for the word "boudbase" gives me an address of a person
in Maryland, whose last name is Boudbase, and also another address of
apparently the same person in Fresno, CA. No serial-device-related
results occurred (within the first page of Google results, at least).

Sincerely,
Aleksandar

> It is the input frequency clocking the UART ('XIN' pin, Xtal INput).
>
> Each board has its own frequency, and it can even be variable (the clock
> domain tree can reconfigure it at a different rate).
>
> I'm not sure it makes sense to have a default, and I don't know what is
> the frequency modeled by the SPIM simulator.
>

