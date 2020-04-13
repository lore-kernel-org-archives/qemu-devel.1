Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5407C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1F620678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTVICie5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1F620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7R3-000541-NJ
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7Ps-0003ib-S2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7Pr-0005P5-Qw
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:18:56 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:33973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7Pr-0005P0-My; Mon, 13 Apr 2020 18:18:55 -0400
Received: by mail-ua1-x942.google.com with SMTP id d23so3732745uak.1;
 Mon, 13 Apr 2020 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ASvdBLcUCKQLyIh8bOZhHn+RseYcmfhTrHXZiAk3wxo=;
 b=tTVICie5uEs0IaXlLz5qq4wXKoclyXmdgLXM0iT6/F53LLaCX8nmvPbqOlabLx4k6T
 eAwCGaIz5Iqi6xLZpY1HHtVLhiqaqXgW8MDuHr6Co+AZKNUKzVX7WDcUngXPHPXI/Y+o
 FAzBvikO5qWcstP1yqQRyX28uJLJ1mDtT4IioVuqfpGQxMK4z0SYtGls8n6h/ZMBxpuA
 3BxHD0gNEoMMj270I2kLLApnChND9HYzBlKwHNskHfUJ2CkYyrAqfNd+AqipGwhOPq54
 VTYx6Cu7l35+MNDeC2nx1B5wKd0uEN0ipKjCfGB2hdD7JPZEV32wD2766oXGPSbmMoqO
 KaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ASvdBLcUCKQLyIh8bOZhHn+RseYcmfhTrHXZiAk3wxo=;
 b=leufw6y6dOzBv6ZSgwZCPDTUtK1Y/uNsEFxxUC2y4Wg85UfuyuywtOXT9EsTjE4Fr4
 OpPEU7vCLhtKtpczJAn07FJ1UYkGtiJOQDmtisPXxNi0Qi4Qsl7DSqim8OpwmXIKPukD
 Z+t7RpRdkKMfwPkF7hM1my4cKMaAFuLcXtmIlPXSxIbVWGqqaiMsIBMAHE2m7XxsRSPx
 5qRr/25Q4rTCkCt5ZSsw8i6ShSRWWYebRSmD7ScdI7fNcVr8ixD9HdGMYJS/TnzMIeaQ
 osrLNtgFOHQC5oeoYeA/IqteJKQ1R3AtWmh0t5KtrIcyRO2mvnosFQQIN+IlKW9aqRJ+
 plWA==
X-Gm-Message-State: AGi0PuZkqkrY0+rWbEfBuBiCT96x2CBNdZaJL1OlI+oQh0VN+wX5AQc8
 4wnuC1wcjP6efrhPuDwsYOhXpI9oNN4qYI4dFUE=
X-Google-Smtp-Source: APiQypJLpjEOQztDtwHfex7Yb89Yc5z920EJbwj90x3o77paEp/SDnSrLCxlS6qwG6sHWtoIgqgzaZsuWkDFJfbF1BA=
X-Received: by 2002:ab0:7444:: with SMTP id p4mr4226881uaq.133.1586816334965; 
 Mon, 13 Apr 2020 15:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200412224144.12205-1-f4bug@amsat.org>
 <20200412224144.12205-9-f4bug@amsat.org>
In-Reply-To: <20200412224144.12205-9-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:10:38 -0700
Message-ID: <CAKmqyKNGxMFoJVdpxqs18HkeXrzDkSYWUcpJ-p7mvpV=nRbE3w@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 08/23] hw/arm/armv7m: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 3:54 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Patch created mechanically by running:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/armv7m.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 7531b97ccd..249a7605f6 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -168,7 +168,11 @@ static void armv7m_realize(DeviceState *dev, Error *=
*errp)
>      }
>
>      object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "mem=
ory",
> -                             &error_abort);
> +                             &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
>          object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
>          if (err !=3D NULL) {
> @@ -256,7 +260,11 @@ static void armv7m_realize(DeviceState *dev, Error *=
*errp)
>                  return;
>              }
>              object_property_set_link(obj, OBJECT(s->board_memory),
> -                                     "source-memory", &error_abort);
> +                                     "source-memory", &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              object_property_set_bool(obj, true, "realized", &err);
>              if (err !=3D NULL) {
>                  error_propagate(errp, err);
> --
> 2.21.1
>
>

