Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDECCA9EB0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC412067B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW/YIsSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC412067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37437 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMV9X-0007oz-IA
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMV8X-0006fy-Kn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMV8W-0004wH-Cr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:42:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMV8W-0004tz-4v
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:42:04 -0400
Received: by mail-ot1-x343.google.com with SMTP id o44so10543175ota.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cDT6q2a0t8Xgwc0bORZyO/VOCMrdP0NenOQLNjg7QCg=;
 b=DW/YIsSoxXGkphEFRQfiCpppZB3hJ8LXGKGuF0p1XFhZ/cXrtDMxCesIfDPEUG+F8x
 ue1HzDhN0+mZvzHL53IpRpgFQQQTHHP5cA3SIa82yTfxAWx3GqmylNr2XWSvdZE2Z8nW
 Kepdj7DwGQuzKqeQM8CIvFhCjaqZlPJGEub1ycmKui4GlQTylKwCj6v45UhOqyDiHoSh
 4WdeQmZQNu4DGDlbkXXRtCQnVvv9cnu4/9BJVoA5X3dDxhvNjk54X1HGoLX38hSHI01M
 tR3wc9z8wTB4lGkPgH2NHjIyfR3Zff8+spxnED4mT39rldxvb85cS/CxcXADeEzunrAh
 wdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cDT6q2a0t8Xgwc0bORZyO/VOCMrdP0NenOQLNjg7QCg=;
 b=OuoK6eZnbdNK6KMirTN09eoEOPh56TfXwvNlwnFEKPAMnYP46XASrqK4eFeny9KA7O
 k+hQqImQiKnEXGGXHyn9Gvpca5gAPrWZtYEKKdXcT2jf2lEMxlmXXhiW26jysKSRLNkZ
 yHrJjBUQV5VZP34iPgyt4cgrsTSnYPYLRUmTllMey+edMHYUodfXC9rOrmu6R5riKFD+
 dAfp8vLZsD46y4mIFye4k63owHPerGyVZvyIR9yuA7SBM/UFqCA4H188WieU0B//lMPZ
 3A7Z/FzeNPwjvWpz5UY8LQR9GlCmQwdB/hZc96zfimTBeHPgP35TVFKe60gAZmgwzh8q
 Vq0A==
X-Gm-Message-State: APjAAAUo1lyT73V7MMWiWLNPEYh+gROgb4PBQugfmjeuLfxMI7Atciud
 8iugpiy8DWzeQnCFn7kvwajXp2l9yH5NG3rym3UOvQ==
X-Google-Smtp-Source: APXvYqxNZ3GkHKENkHiBQ2Znk+Tz5mDWQAGM8gR8yBOObfGmr/3dHBP0Pfn7pz6ssG0vCTKrsIihtI+L3lU5gf/XB/I=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr17222497otb.97.1571654522551; 
 Mon, 21 Oct 2019 03:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-5-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-5-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 11:41:50 +0100
Message-ID: <CAFEAcA9mTOR1JNgMYHBSxWmU2PofPLfqKEe8TTVEOtBnRfWe3w@mail.gmail.com>
Subject: Re: [PATCH 04/14] etraxfs: remove PROP_PTR usage
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> etraxfs_dma_client are not Object, so can't be exposed to user with
> QOM path. Let's remove property usage and move the constructor to the
> .c unit, simplifying some code on the way.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +/* Instantiate an ETRAXFS Ethernet MAC.  */
> +DeviceState *
> +etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
> +                 struct etraxfs_dma_client *dma_out,
> +                 struct etraxfs_dma_client *dma_in)
> +{
> +    DeviceState *dev;
> +    qemu_check_nic_model(nd, "fseth");
> +
> +    dev =3D qdev_create(NULL, "etraxfs-eth");
> +    qdev_set_nic_properties(dev, nd);
> +    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
> +    ETRAX_FS_ETH(dev)->dma_out =3D dma_out;
> +    ETRAX_FS_ETH(dev)->dma_in =3D dma_in;
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +
> +    return dev;
> +}

I think the right way to do this in a QOM design would be
to define a QOM interface for "I am an etraxfs DMA client"
(which replaces the current 'struct etraxfs_dma_client'
ad-hoc interface), implement it on the ethernet device,
and then have QOM link properties on the DMA controller
device so that you can pass the interface implementations
to it.

If that seems like too much hassle right now, I guess we
can add a TODO comment here explaining what we ought to
be doing instead.

thanks
-- PMM

