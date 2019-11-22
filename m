Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A99C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006D120718
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNmR+xbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006D120718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7ep-0004bm-U4
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iY7dh-0004AW-Fk
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iY7dg-0004de-5L
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:02:17 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iY7df-0004aP-UP
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:02:16 -0500
Received: by mail-wm1-x341.google.com with SMTP id z19so7319065wmk.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 04:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OITAjyqq/uhNRY6a3jRAIS8MnGh/uTuCwfk7vjO7ZFc=;
 b=sNmR+xbtW2NPDKGtnfLZJRi7wIJ6mrn+jEp0Gq68Sa3L0aUc0HvMIwSZpFIwvUm1P0
 jvyzKtLf94+QfvpAvTM57J4oSAedYLX7YJTUiSoyG8zbXanfHwO7IHlsI45aIKj+xzJ5
 FVK6lOPmYqdqnmTSfslvlNXHvkZbdDXbYEKSpTbeht5mt4rZPE3CA3peVwAZknfwXdWu
 T/mY4q/aFgcd8vSs4eCIHFp213qgKB0CwUzBBQPL61fT2iAQxA+ezziLe32kzCcnV3/v
 Ujj+vKW5P00tZtKtOUGBFKbrSrak+4f9nSHH8zIwIQz4sKWKFNR8kEsk+DIFJgntpys0
 wkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OITAjyqq/uhNRY6a3jRAIS8MnGh/uTuCwfk7vjO7ZFc=;
 b=ZPGIUUIM6bOnXddYLNuOeDOiR/hFdwjjIXHorCdzbR0GGtUXGkuGzyM3z1FHpYNT57
 7fTqs1vvqXR8T8ZH3SphNcw9C1jfVsRY7Xh7eCciOsnnbaawLoP18oab06emODQwAVXt
 JQkXp+dy3FuxBz41aLqhSjqPr0NbnO1xsvXljJnJJMvt+SV1FUuRsw/FUbeOxcmZ/osD
 ZeFd8fN/OdocRHKD3wWphRYSkuD+AJnF513PpUyQtJUTTXNmjSUHrmYXaxOuTlC2Xu6W
 5Ttppc11FUGaawnKYfFxi2xI+C6KtNHx30IOYgaUKoUn51Ap0XlCX/izu/rQeMnBeUK1
 V6zQ==
X-Gm-Message-State: APjAAAV5vG6tjIqPC86FPTFwkVgoe2W7sGsZ3w1+Njo7YWWw0C59wfu3
 EZvNrz56laJFW38lToByPp1HgSIZ+akZCd8IrR0=
X-Google-Smtp-Source: APXvYqxlUt8QU9AtDIfGQ/nAmvm08jBCg+2ImUoN+LJgxFdpSqaPSIznYji4H79vuVj2Oc79KYEe7AGzi7oOZsHcR9o=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr2853037wmh.5.1574424134290;
 Fri, 22 Nov 2019 04:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-13-marcandre.lureau@redhat.com>
 <CAFEAcA8aj71ue1Y_o1PphD8+iAZeOgqo647hgXS0Z22T9Qa8yg@mail.gmail.com>
 <CAJ+F1CJhaQxrceCqPpPULN5RUUQ+jTVaRa912jX0Ct8MM0ucaw@mail.gmail.com>
 <CAFEAcA82swZ82__hee1818L0RtD-3dNEOAKT2hdwgMOcaiAjHw@mail.gmail.com>
 <CAJ+F1CLDai4rWcLQaqXo1GcVRuRj=OwX+50jV4Ch5X_-8HR=CA@mail.gmail.com>
 <CAFEAcA_mHmc_1BQPeaySCg7t2vd4VC2CUPbAneLYeSRprwZQQw@mail.gmail.com>
In-Reply-To: <CAFEAcA_mHmc_1BQPeaySCg7t2vd4VC2CUPbAneLYeSRprwZQQw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Nov 2019 16:02:00 +0400
Message-ID: <CAJ+F1CLNgS7KYjsDV_0i=-tQbLSupz3JCHbizTG9_yWPn_ofcA@mail.gmail.com>
Subject: Re: [PATCH v4 12/37] serial: start making SerialMM a sysbus device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 2:11 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Thu, 21 Nov 2019 at 18:51, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Thu, Nov 21, 2019 at 10:24 PM Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> > >
> > > On Thu, 21 Nov 2019 at 18:15, Marc-Andr=C3=A9 Lureau
> > > <marcandre.lureau@gmail.com> wrote:
> > > >
> > > > On Thu, Nov 21, 2019 at 5:47 PM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> > > > >
> > > > > On Wed, 20 Nov 2019 at 15:27, Marc-Andr=C3=A9 Lureau
> > > > > <marcandre.lureau@redhat.com> wrote:
> > > > > >
> > > > > > Memory mapped serial device is in fact a sysbus device. The fol=
lowing
> > > > > > patches will make use of sysbus facilities for resource and
> > > > > > registration. In particular, "serial-mm: use sysbus facilities"=
 will
> > > > > > move internal serial realization to serial_mm_realize callback =
to
> > > > > > follow qdev best practices.
> > > > >
> > > > > What goes wrong if you just put the realize of smm->serial in
> > > > > the right place to start with ?
> > > >
> > > > You mean squash the following patches?
> > >
> > > No, I meant just having this patch have
> > >
> > > static void serial_mm_realize(DeviceState *dev, Error **errp)
> > > {
> > >     SerialMM *smm =3D SERIAL_MM(dev);
> > >     SerialState *s =3D &smm->serial;
> > >
> > >     object_property_set_bool(OBJECT(dev), true, "realized", &err);
> > >     if (err) {
> > >         error_propagate(errp, err);
> > >         return;
> > >     }
> > > }
> > >
> > > and
> > >
> > > + dc->realize =3D serial_mm_realize;
> > >
> > > rather than manually doing the qdev_init_nofail()
> > > in serial_mm_init(). This seems to me like an integral
> > > part of the change to doing the init of the subdevice in the
> > > init method, so it would be better unless there's a reason
> > > why it breaks something. The rest of patch 15 (which is
> > > what currently makes the equivalent change to realize) is all
> > > about passing through the properties and exposing the
> > > sysbus MMIO/irq regions and should stay a separate patch.
> > >
> > > (setting the 'realized' property is better in a realize method
> > > than using qdev_init_nofail() because it means we can propagate
> > > any error outward rather than killing qemu.)
> >
> > Ok, but I implemented realize and moved serial init in "serial: make
> > SerialIO a sysbus device".
>
> That patch is for the TYPE_SERIAL_IO device, isn't it? It
> changes both serial_io_instance_init and serial_io_realize
> to do the instance init and realize of the TYPE_SERIAL device,
> so it doesn't have the same "only doing half a change" issue
> that this patch has for TYPE_SERIAL_MM.
>

Ok, I got it, thanks.




--=20
Marc-Andr=C3=A9 Lureau

