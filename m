Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E6C2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SV3Hczyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E6C2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY5wM-0003lt-6l
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iY5u4-0002P6-Br
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iY5u2-0002v6-Ue
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:11:04 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iY5u2-0002uZ-Ov
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:11:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id m193so6064436oig.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UZu8CCw+Rx79hRd6CZDSCZzbVjcbqJUU1tNgkaY3B2E=;
 b=SV3HczytNFnn8f3xax+eqLDY/l4FSjwOHlD0dKFXyc0fxuhnKc01hUbx2PnnDff6z4
 X/0cBx7eLpcyDl9Fl3UodRr8hJD5pYTGSib+y3wM1FEAiYANbG7A3hgnCbHV/1lG/d1A
 bEh8oHN+VuZhOYdP5HcPe1CdrDGUmJstHr8ObRHyASgPnEJW+GfTR6jb9G+H77kQOmSR
 WN4Qmu6BVsR4OqnnZlSZ5FVuD0rQ+K4IMjUhxBdBnww9g72EUhWQvu/Y7NFs9BEKIxWZ
 JCsf6jRlyWQ5JrI/WI8YYTFSK6Y5GNuWPjGraStwy23HTteXKPXWM6TpGe7SAW/XuZKB
 6SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UZu8CCw+Rx79hRd6CZDSCZzbVjcbqJUU1tNgkaY3B2E=;
 b=ivX8i8NA8ktdr25zG1FDLult2NGbma52fcbEILKjLIVKnJJTlm4PN1ugafaZblKDin
 nErxmYgaGEJaiisLu99afNemH3JgsQ8yvRsfW8bdutva7P/MJWhwhSi2Wm944CYqmwTl
 IAQlxuSHxE5oiiprP0SwwWtSezdzYzIRSQmKkJxZ6kYaf/7/btoUcmIQEj3EGIYQ7OaX
 vHkNGYjIKwkrrnZr1Nh2iNUokcU20wcArng6W/yqdYv/tF/ydXn4mMATnJP7fKnuoWSi
 vyG1vUQEsEantJon0BNCKiI6jUG7uSdPBY2dT3E+7ekwjIIwQy7w26ouHvXcvu9jrRd2
 nKJw==
X-Gm-Message-State: APjAAAVrJ2ATXlM7MTQb12j9KfJJK1XuHSXCbR5Xxko8eDVuVRxs3Y3z
 cTt84IfYIa4VVWnu47ALw49tM1i9nMkk0qZkGfh5GA==
X-Google-Smtp-Source: APXvYqzckX9iL1t6dRu47BtF2+/5BjeVX9u1t160ucAgMwjB1MMScgcJSAvUDvZqDosOcnxxvHvFZdCWXbXyOT4Ml6Q=
X-Received: by 2002:aca:4945:: with SMTP id w66mr11920730oia.98.1574417461437; 
 Fri, 22 Nov 2019 02:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-13-marcandre.lureau@redhat.com>
 <CAFEAcA8aj71ue1Y_o1PphD8+iAZeOgqo647hgXS0Z22T9Qa8yg@mail.gmail.com>
 <CAJ+F1CJhaQxrceCqPpPULN5RUUQ+jTVaRa912jX0Ct8MM0ucaw@mail.gmail.com>
 <CAFEAcA82swZ82__hee1818L0RtD-3dNEOAKT2hdwgMOcaiAjHw@mail.gmail.com>
 <CAJ+F1CLDai4rWcLQaqXo1GcVRuRj=OwX+50jV4Ch5X_-8HR=CA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLDai4rWcLQaqXo1GcVRuRj=OwX+50jV4Ch5X_-8HR=CA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Nov 2019 10:10:50 +0000
Message-ID: <CAFEAcA_mHmc_1BQPeaySCg7t2vd4VC2CUPbAneLYeSRprwZQQw@mail.gmail.com>
Subject: Re: [PATCH v4 12/37] serial: start making SerialMM a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Thu, 21 Nov 2019 at 18:51, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Nov 21, 2019 at 10:24 PM Peter Maydell <peter.maydell@linaro.org>=
 wrote:
> >
> > On Thu, 21 Nov 2019 at 18:15, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 5:47 PM Peter Maydell <peter.maydell@linaro.o=
rg> wrote:
> > > >
> > > > On Wed, 20 Nov 2019 at 15:27, Marc-Andr=C3=A9 Lureau
> > > > <marcandre.lureau@redhat.com> wrote:
> > > > >
> > > > > Memory mapped serial device is in fact a sysbus device. The follo=
wing
> > > > > patches will make use of sysbus facilities for resource and
> > > > > registration. In particular, "serial-mm: use sysbus facilities" w=
ill
> > > > > move internal serial realization to serial_mm_realize callback to
> > > > > follow qdev best practices.
> > > >
> > > > What goes wrong if you just put the realize of smm->serial in
> > > > the right place to start with ?
> > >
> > > You mean squash the following patches?
> >
> > No, I meant just having this patch have
> >
> > static void serial_mm_realize(DeviceState *dev, Error **errp)
> > {
> >     SerialMM *smm =3D SERIAL_MM(dev);
> >     SerialState *s =3D &smm->serial;
> >
> >     object_property_set_bool(OBJECT(dev), true, "realized", &err);
> >     if (err) {
> >         error_propagate(errp, err);
> >         return;
> >     }
> > }
> >
> > and
> >
> > + dc->realize =3D serial_mm_realize;
> >
> > rather than manually doing the qdev_init_nofail()
> > in serial_mm_init(). This seems to me like an integral
> > part of the change to doing the init of the subdevice in the
> > init method, so it would be better unless there's a reason
> > why it breaks something. The rest of patch 15 (which is
> > what currently makes the equivalent change to realize) is all
> > about passing through the properties and exposing the
> > sysbus MMIO/irq regions and should stay a separate patch.
> >
> > (setting the 'realized' property is better in a realize method
> > than using qdev_init_nofail() because it means we can propagate
> > any error outward rather than killing qemu.)
>
> Ok, but I implemented realize and moved serial init in "serial: make
> SerialIO a sysbus device".

That patch is for the TYPE_SERIAL_IO device, isn't it? It
changes both serial_io_instance_init and serial_io_realize
to do the instance init and realize of the TYPE_SERIAL device,
so it doesn't have the same "only doing half a change" issue
that this patch has for TYPE_SERIAL_MM.

thanks
-- PMM

