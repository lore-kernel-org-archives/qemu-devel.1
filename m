Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36378CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D0A2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWSfDd1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D0A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxLd-0003ud-Vy
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMx76-0003EZ-BV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMx75-0004PS-5s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:34:28 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMx75-0004Oy-0U
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:34:27 -0400
Received: by mail-io1-xd41.google.com with SMTP id c11so12116993iom.10
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S7GLYTWYwKDPqMMyl5E+zvOg9SPh+U8P5YdjfmkwQj8=;
 b=mWSfDd1rr5Red/bw5zq3ut4i5XC3u+rCoQii8nz0HvyGNBf4TyWiSHqxBqUMMTXH8L
 9rRUBUHKlecIOD6Psm9Y+11k+Afxv0JZaMblfQSHSD249mBbjQpVkI56NMA35ieOPL+K
 yvNYbI4q92DqYJWGkp83B/+lAKD3sLuwc0gxuWffK2mzLjwYgRnL6oJml1lvl/HoOUji
 QGHGqjLwPcyB4UH23q+GkMMl+CDYGzsPTQRSW0S7yvLfefIXgUI3BbV7hsEkyg6E4mVz
 +ReBPcIOaJnPzW0bCaoOd83SFFrJ3JIwJG+N0Ny34ZZihaXIzNIkBiFz2Dnm/7Z6TdKG
 m5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S7GLYTWYwKDPqMMyl5E+zvOg9SPh+U8P5YdjfmkwQj8=;
 b=HxFgWQG5chqbiM4mirZ6aFC1PJIWktkIA4f4428QIBUOzezsDwUiDXsL4Vii2jn+NQ
 77ODNzCS8vfgF/1VSQiOn0SUM5L/zTQ+A9XfjBZpeDNAD4LWTerVVc/iAwawcpQ66TF1
 98JqeyoTaWFoW8oPBNAVWh/YcyNrgqlO2LqiPP/kbMEKyn0GCs4dvRbgJlps4hcCuOid
 0APPCkKPB7X4yw/OuoV288u29oENk8PQboPUI0KggOE4wWc1N/Z89zUGcVRYASqHRKKA
 VnDGDK0KgX6Q5RjbaX8Y5gi6v3+1cqI2TvGmzFJ0Tc/h/vUSb56Ke3Dmmo8SucLoUh35
 a0pA==
X-Gm-Message-State: APjAAAWmBJD/vYo53SfPGftJzL/NTS+cFrHfKX1DL62Vee5Zk2Wcf8ZE
 1V5a1FMEETRFdDgrCUAkCyLDPCuPvRfwzNA9uOjR5g==
X-Google-Smtp-Source: APXvYqwoXcBN9SxZ/mfYJqRMvWMYs3V8qGaQdTjHfQvnzpdCy6Mj8261eI/85rTRY2BU7i8XMlirH67CJC6On9ua/Sw=
X-Received: by 2002:a5e:8219:: with SMTP id l25mr4712782iom.292.1571762066131; 
 Tue, 22 Oct 2019 09:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
 <20191022162137.27161-14-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-14-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 17:34:14 +0100
Message-ID: <CAFEAcA8B9x0nWk38bOSH_7NmD8FU+pRd22OTN2NFdvNVhCAktg@mail.gmail.com>
Subject: Re: [PATCH v2 13/28] serial: factor out serial_mm_connect
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

On Tue, 22 Oct 2019 at 17:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Split IRQ and memory region initialization in a different function to
> be reused by callers that realize the serial device themself, and
> connect irq/mem after.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 20 +++++++++++++-------
>  include/hw/char/serial.h |  3 +++
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 72d48b5cd8..41548e159c 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1078,27 +1078,33 @@ static const MemoryRegionOps serial_mm_ops[3] =3D=
 {
>      },
>  };
>
> +void serial_mm_connect(SerialMMState *self, enum device_endian end,
> +                       MemoryRegion *address_space, qemu_irq irq)
> +{
> +    SerialState *s =3D SERIAL(self);
> +
> +    qdev_connect_gpio_out_named(DEVICE(self), "serial-irq", 0, irq);
> +    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], self,
> +                          "serial", 8 << self->regshift);
> +    memory_region_add_subregion(address_space, s->base, &s->io);
> +}

This function isn't needed if you make SerialMMState a sysbus
device which provides the MMIO region and the IRQ in the
usual way.

thanks
-- PMM

