Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93002C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCA921736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqCKpxF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCA921736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialfO-00029j-Tq
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialag-0000YD-Sk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialaZ-0006gz-HL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:06:02 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialaZ-0006Y7-Bk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:05:59 -0500
Received: by mail-oi1-x242.google.com with SMTP id x21so19784228oic.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 11:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HCgtPr845B2uezEWIf0YsHqUlkKctP/29CRYu6CMd48=;
 b=RqCKpxF0ubH7YuN6IHRysAOic/R7j+8y7KB0bVFxAHLVKXJ34ssu6VLoZRlEScWNHW
 vRLC4zvfgCrKsZBwaGoMnOp0aWaz7h0LHu/Qg3TySxKFeXAC19pTgtWyWgVqy43zglpJ
 /+2jxMgUsJHYDzQR0PLmT64EHjBhOxS1ZCPNCNw1i3wKB4+T6UbJZoGKcPCI0K5Zezs7
 WclMYC0B9M1pGhwx/NKPZGfbhBwweBH7ge3ClsafMXqzr9/mTjSlNb0a1TlXxMK3Xx7A
 qwcED8kr6niSScuud36zVqb7Bw/dbVlZpH49kUiGzrsvQHKboIIHC1f1OP/t8D47mVxq
 BW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HCgtPr845B2uezEWIf0YsHqUlkKctP/29CRYu6CMd48=;
 b=WUJ+qjzpxjSIbMAtwTt+WzB0LhRreddLvsgCwMAj4ddxmidTRZFPFxL7lUfVz143Gc
 1Hco9Xf02u1Ciqw+kyM0+nDxN6XgHc6d+SPjnRrjO0U5ssWGDGZW8wQnzRXNs5hDYnMS
 EJ88AtyKC+xkJLAzfW7r+Epr5UXOFm2SfAnsEENzjtidWp/7QxVtGqViXNUc1zZ+NWJG
 mbyrrQJnrvI1O84Am9N14elysbNf76mdW3mn97pxzwCk+g10hPORp9C8L8WMJ9HoOwTd
 CZntCxL0W47a9RrtBZyE/59f07epH+pXkHNnUhRzjpXCZ+1oa0WzawAFRPGq7falsN1k
 JqiA==
X-Gm-Message-State: APjAAAWR1jFRNLQNkPzfAHC8xlK+6EDlr7utDvnra56HQ6tGQrh4q03y
 yb5y2z5l4URtCNtKcPbCB10V6xKikX35fSAPlJV/tw==
X-Google-Smtp-Source: APXvYqykYrmsPIKMnSqZt9OzSU9BOhuCY752oPqw8Jmx7TI6IL4vqxR2W076O8rXTNFDkqZc+t6o1ojqIjEZ3lxKtN8=
X-Received: by 2002:aca:f484:: with SMTP id s126mr10843226oih.48.1575054357126; 
 Fri, 29 Nov 2019 11:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-13-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-13-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 19:05:46 +0000
Message-ID: <CAFEAcA-YiD6B1wMTrOvj5=QbYY3uuqdbJbSP57zg3S86nU=k-Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
To: Damien Hedde <damien.hedde@greensocs.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wro=
te:
>
> Split gpfsel_set() in 2 so that the sdbus reparenting is done
> in a dedicated function.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/gpio/bcm2835_gpio.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
> index 91ce3d10cc..81fe07132f 100644
> --- a/hw/gpio/bcm2835_gpio.c
> +++ b/hw/gpio/bcm2835_gpio.c
> @@ -75,7 +75,10 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t re=
g, uint32_t value)
>              s->fsel[index] =3D fsel;
>          }
>      }
> +}
>
> +static void gpfsel_update_sdbus(BCM2835GpioState *s)
> +{
>      /* SD controller selection (48-53) */
>      if (s->sd_fsel !=3D 0
>              && (s->fsel[48] =3D=3D 0) /* SD_CLK_R */
> @@ -86,6 +89,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t reg=
, uint32_t value)
>              && (s->fsel[53] =3D=3D 0) /* SD_DATA3_R */
>              ) {
>          /* SDHCI controller selected */
> +        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
>          sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
>          s->sd_fsel =3D 0;>      } else if (s->sd_fsel !=3D 4
> @@ -97,6 +101,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t re=
g, uint32_t value)
>              && (s->fsel[53] =3D=3D 4) /* SD_DATA3_R */
>              ) {
>          /* SDHost controller selected */
> +        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhost);
>          sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);

The commit message says it's just splitting the function in two,
but these two hunks are adding extra calls to sdbus_reparent_card().
Why do we need to call it twice ?

>          s->sd_fsel =3D 4;
>      }

thanks
-- PMM

