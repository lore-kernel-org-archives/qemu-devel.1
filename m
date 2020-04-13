Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC530C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B64620644
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHANxu50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B64620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7LR-0000c8-M5
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7Kc-0008Us-Pn
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7Kb-0004ZQ-Ax
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:13:30 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:37320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7Kb-0004ZM-7G; Mon, 13 Apr 2020 18:13:29 -0400
Received: by mail-vk1-xa43.google.com with SMTP id f195so2685126vka.4;
 Mon, 13 Apr 2020 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QVGiwzDVXsng6V7wzwCWbfgWJVNp0GqNxsTzRI+mWVU=;
 b=SHANxu50qfI6lch7kjJUabRpcqqwvSlbFIdbI7gWU6b21Ty5/POPVjvhlVzVZikm0C
 aK50aut118wRB2mxwpE8x6OWjbYhsMYgp2TjBUT9buHtBXx448izUympsR+q+hKkbCka
 IG0Bc68ysiltoIVpcZaLouMGXBfYam9h8Rm4uTjR+09ZXDFnNRTaZl+giAGXQt0TE627
 uhsE8ZMoUmCe523HaKA7nYGYHN39R7nv2RHl99qbYDmZF5GgKpqzrKf6MvPSqKJkuLEC
 v2A5gM/I5u46515fzK1dWa+dZREb0APZvkDZhEGalz0CBcBDbh2sI7ElTL3H8XjR/OQ3
 2sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QVGiwzDVXsng6V7wzwCWbfgWJVNp0GqNxsTzRI+mWVU=;
 b=tXpV8wps4BYDEA6AoDPF9jdnA01MiOxMda3aFvQ5aZ+pza/Pz9T/2UO5SDmtT2H77L
 O6Ef8fxrFAwKKOE2mBWW/PxiPO9aqQgTtls16DCjU7bQWNkhlurUGFcsQBnAxRHzKuhd
 u4iwYMszZdZjpdgrmtyUNTRDToSmoHXcB8F+WC4XcauHJnpVmClmvDt0sUUpjV2iqZIj
 hNL/BIctnXYyjvEV6gS5tq9Ysci7mr8uuRzPnnpqmYEzI06LFtXOlmi8eFLLgg3ZYFrk
 Oa+/+F1WKYdFYWqPwdUj6Rd/6q7Q9gCuYDgYmFXKyhsLinf1yoM3LS4w+6dvkDlabq3N
 bjOA==
X-Gm-Message-State: AGi0PuaCsTjXT9fMJ/2Ev7Xn4ZdKRJwXql/T1ip/May/8PxGB7tUJbSo
 DXQ5x7IpdpzR5ds2obDXXLA8aos7NZVZ7+j/hgE=
X-Google-Smtp-Source: APiQypKj/ZAMAGLolI6z0AJsXW6yYjY3nZ+TbE0DNauCof7bVNNXcuoK715Bki2y3zMSMJ2GjII/w5q1w8zO2agepqU=
X-Received: by 2002:a1f:2e8c:: with SMTP id u134mr13001976vku.16.1586816008350; 
 Mon, 13 Apr 2020 15:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-15-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-15-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:05:12 -0700
Message-ID: <CAKmqyKOUZPaERF3VYRDEn1+0g86ULEJP5w-iuE_eOyA3_KXScw@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 14/24] hw/arm/xlnx-zynqmp: Use single
 propagate_error() call
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 3:45 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Coccinelle failed at processing this file:
>
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/arm/xlnx-zynqmp.c
>   EXN: Coccinelle_modules.Common.Timeout
>
> We are going to manually add the missing propagate_error() calls.
> As there are many Error* calls used, simplify by using an unique
> call to propagate_error().

I'm not a huge fan of goto's so I'm not sure this is simpler.

Alistair

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/xlnx-zynqmp.c | 61 +++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 38 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index b84d153d56..43d57fa7de 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -385,15 +385,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>          object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized=
",
>                                   &err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>      }
>
>      object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>
>      assert(ARRAY_SIZE(xlnx_zynqmp_gic_regions) =3D=3D XLNX_ZYNQMP_GIC_RE=
GIONS);
> @@ -462,8 +460,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>
>      xlnx_zynqmp_create_rpu(ms, s, boot_cpu, &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>
>      if (!s->boot_cpu_ptr) {
> @@ -488,8 +485,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>                                  &error_abort);
>          object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &=
err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
> @@ -500,8 +496,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>          qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
>          object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", =
&err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_addr[i]);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> @@ -512,8 +507,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>                              &error_abort);
>      object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, SATA_ADDR);
> @@ -531,23 +525,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>           */
>          object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>          object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &=
err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>          object_property_set_uint(sdhci, UHS_I, "uhs", &err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>          object_property_set_bool(sdhci, true, "realized", &err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>          sysbus_mmio_map(sbd, 0, sdhci_addr[i]);
>          sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
> @@ -564,8 +554,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>
>          object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &=
err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_addr[i]);
> @@ -582,8 +571,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>
>      object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1, LQSPI_ADDR);
> @@ -605,16 +593,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>
>      object_property_set_bool(OBJECT(&s->dp), true, "realized", &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->dp), 0, DP_ADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->dp), 0, gic_spi[DP_IRQ]);
>
>      object_property_set_bool(OBJECT(&s->dpdma), true, "realized", &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>      object_property_set_link(OBJECT(&s->dp), OBJECT(&s->dpdma), "dpdma",
>                               &error_abort);
> @@ -623,16 +609,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>
>      object_property_set_bool(OBJECT(&s->ipi), true, "realized", &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
>
>      object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        return;
> +        goto out_propagate_error;
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
> @@ -640,13 +624,11 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
>          object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", =
&err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>          object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", =
&err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->gdma[i]), 0, gdma_ch_addr[i])=
;
> @@ -657,14 +639,17 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
>          object_property_set_bool(OBJECT(&s->adma[i]), true, "realized", =
&err);
>          if (err) {
> -            error_propagate(errp, err);
> -            return;
> +            goto out_propagate_error;
>          }
>
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->adma[i]), 0, adma_ch_addr[i])=
;
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->adma[i]), 0,
>                             gic_spi[adma_ch_intr[i]]);
>      }
> +    return;
> +
> +out_propagate_error:
> +    error_propagate(errp, err);
>  }
>
>  static Property xlnx_zynqmp_props[] =3D {
> --
> 2.21.1
>
>

