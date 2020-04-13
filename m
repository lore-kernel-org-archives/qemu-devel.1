Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7FDC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDC220678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBxFEfmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDC220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7TP-0008M8-I1
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7SN-0007AF-Gy
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7SM-0005rc-6B
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:21:31 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:40620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7SM-0005rX-2R; Mon, 13 Apr 2020 18:21:30 -0400
Received: by mail-vs1-xe42.google.com with SMTP id w14so6455921vsf.7;
 Mon, 13 Apr 2020 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SbNBfhARuQLgKSpV0J3PH1BPOWfqYuX7NtoF2hBsegU=;
 b=oBxFEfmDmBc9+LiwubThK+mMJBX//hrWF/vZBxE1UeYQ/urze8rq71T62fReoKAy1O
 4NiWN4LdMmQ1z2bSSyjjM+76ovSSdaVUDThpn8C9CALzWGhFv9HAF1jusP4yPUVG4gn7
 NlUbpCLsuVU34ERoM9SdEBO5QLuaC8orLD6A2BgvtyQ0HvcC6CNiNculuXHh75rMO1jq
 aJS0xnLTZrKCuwzp4OVnBNe9GudLZEP9NlKQQA47Jf/KG8Prx0iYxMigvaCDFcAmun8W
 T57hvp7lyZMi2HDodlieGqckPQ0aDOx+Hqwy7tywni4QL07GmZPjYq7L9cDJSLsRgBEB
 /NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SbNBfhARuQLgKSpV0J3PH1BPOWfqYuX7NtoF2hBsegU=;
 b=HDHIOcCL5M6f5M5LJFkxVsi3t5tSAOanf9KlsiMeOZlhK+P2OvklpCKLkG/mmasnFG
 Iq3gUTM+vZRvV2H/ZfOdznOH8bUcAHSIgA2Eoew/nwNEK8iig1VSA/uppgSCe6ZMQG8h
 5y3G2Nd3J7dAHynWuVwnMf/vr85N9HDQBWsLU7KmJhi96KbHgP2IkwU5X3ZyoB0xR4Tc
 MnmT7gmRDRJKtcMEeybx0lZlZHu+RY5stZMjyBqkJ4KkKPkT6i6DmVk7VTRVEKk7kv4l
 OvkgjXhACl9Xh9rv6nWcU8Rlovu2PcK1Yh3IXW4RIxCF9uoOUe1hIa8/G97C/x9tmfae
 uStg==
X-Gm-Message-State: AGi0PuZeBbJOnSys2DrRSOovTHXj3q1GncXRClkZRz8NThYnpavO7G8l
 anHkSJkny61Pp52MCX082GiqSck89PCde0euYCs=
X-Google-Smtp-Source: APiQypL2cecwXlN0h5Kl5qTI+prGN1DJy4d20hu/qS0PYTURIt73fhkq6Zr418FjgKeuf3Q8EeI9BFzJFwypXmIpUxo=
X-Received: by 2002:a67:902:: with SMTP id 2mr14873582vsj.133.1586816489539;
 Mon, 13 Apr 2020 15:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200412212943.4117-1-f4bug@amsat.org>
 <20200412212943.4117-2-f4bug@amsat.org>
In-Reply-To: <20200412212943.4117-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:13:13 -0700
Message-ID: <CAKmqyKNP73-h02ubQaFvMC4UyhCjbLmRVPmC8OQ7NRJgyL4zBQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 1/3] hw/ide/ahci: Use qdev gpio rather than
 qemu_allocate_irqs()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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
 Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 2:29 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Switch to using the qdev gpio API which is preferred over
> qemu_allocate_irqs(). One step to eventually deprecate and
> remove qemu_allocate_irqs() one day.
>
> Patch created mechanically using spatch with this script
> inspired from commit d6ef883d9d7:
>
>   @@
>   typedef qemu_irq;
>   identifier irqs, handler;
>   expression opaque, count, i;
>   @@
>   -   qemu_irq *irqs;
>       ...
>   -   irqs =3D qemu_allocate_irqs(handler, opaque, count);
>   +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
>       <+...
>   -   irqs[i]
>   +   qdev_get_gpio_in(DEVICE(opaque), i)
>       ...+>
>   ?-  g_free(irqs);
>
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ide/ahci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 13d91e109a..ef0a0a22ee 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1534,19 +1534,18 @@ void ahci_init(AHCIState *s, DeviceState *qdev)
>
>  void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int=
 ports)
>  {
> -    qemu_irq *irqs;
>      int i;
>
>      s->as =3D as;
>      s->ports =3D ports;
>      s->dev =3D g_new0(AHCIDevice, ports);
>      ahci_reg_init(s);
> -    irqs =3D qemu_allocate_irqs(ahci_irq_set, s, s->ports);
> +    qdev_init_gpio_in(DEVICE(s), ahci_irq_set, s->ports);
>      for (i =3D 0; i < s->ports; i++) {
>          AHCIDevice *ad =3D &s->dev[i];
>
>          ide_bus_new(&ad->port, sizeof(ad->port), qdev, i, 1);
> -        ide_init2(&ad->port, irqs[i]);
> +        ide_init2(&ad->port, qdev_get_gpio_in(DEVICE(s), i));
>
>          ad->hba =3D s;
>          ad->port_no =3D i;
> @@ -1554,7 +1553,6 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, =
AddressSpace *as, int ports)
>          ad->port.dma->ops =3D &ahci_dma_ops;
>          ide_register_restart_cb(&ad->port);
>      }
> -    g_free(irqs);
>  }
>
>  void ahci_uninit(AHCIState *s)
> --
> 2.21.1
>
>

