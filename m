Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A334C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B84F20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3d0ipDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B84F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57054 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffeE-0008T1-LR
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hffa1-0004TF-DD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hffa0-0004Dl-2d
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:09:25 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hffZz-0004CS-0C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:09:23 -0400
Received: by mail-io1-xd44.google.com with SMTP id k8so1419065iot.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wTifO1FrajWUKKyqjlbCkW2gQGJeQ+SsRoIWJC3HoyQ=;
 b=b3d0ipDFYXDKEQYR0UqvyqZZyjxN3f2dUNmDspEtBkEgq/TgcyJ645JKaNS1qxR7Pv
 9vkH3PBLKo+68BzXlspk18G+o2/SCG/HZjqkTby3SSqdt3tS/cJ2JGR7i/39EsFIZX35
 Z0P94TuRVBn/ppVhKa5XgNcJCf/v7fIMz2Skz3v7HtO0QN0Ekx5Z2gko2/hTvbuQYCkD
 dLtov59p+2n7NdWyBMnVESwXauvER9KlwOffonR8vj5/V4XiPiU05LjASNOqT3c9d1fx
 YWNXsDXwh0VW1DwyyCZGkynQuFK3px+Lx3E1L61QPUbXEM9KEZs8CEzJlD4UAepuLwgj
 zbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wTifO1FrajWUKKyqjlbCkW2gQGJeQ+SsRoIWJC3HoyQ=;
 b=eXWS9Qi0aGrM5n3/oebiYLAWonO36uSsE0exAGzqQlw9NH9X3XVo4GjENx8otpPLzg
 5mNrNqKI34OtGSbCic+ZmwwUevq30W6nplFAMu6wmkf0G3eiVzwvsY2CV1nnGO0viXpz
 sfuE9PNNilajbgEyhVJXeDO6+a2A4TU0Raa60aNBW0pWkQ6ANGT0m6XDAxtueXIDoIQD
 yVpgquKdegDrAE+/gFMr7Vpt8YPzuYLCOOjYOc+L+WpnGh6rIoCf/iLgfGQYRfMqWUBR
 EZ39UH6r+02fKWt2/hr/CIVQv7nVQOuvhxruHvESqOFPozNq3ikf4tVZdxg8PpbtnxG6
 XXHg==
X-Gm-Message-State: APjAAAU6OkDFWowV0INMrPkmBBcnTNHcCFiznpCfc5kdLJJSBGNMWODD
 xTemd+d3MysNG7kX7pyQ57L4qogRuZd+JrQASr8=
X-Google-Smtp-Source: APXvYqyaEdoG1YQAnAvREUclCOhYsxbw54ymSuldj7s2NR+hFEiP/Ws1rGAYckJlbfZLMnUgiP80PoYpft+P3JMAIU4=
X-Received: by 2002:a5d:964d:: with SMTP id d13mr21999855ios.224.1561446562487; 
 Tue, 25 Jun 2019 00:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-5-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-5-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:09:11 +0200
Message-ID: <CACXAS8BJBd0fJOhEo9pTfpnTB36+OPg-=Z0tCcxUYwPWho6Zqw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH 4/9] hw/misc/empty_slot: Add a qdev
 property 'size'
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Add a qdev 'size' property, check the size is not zero in the
> realize() function, simplify the empty_slot_init() logic.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/misc/empty_slot.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
> index 53299cdbd1..ef0a7b99ba 100644
> --- a/hw/misc/empty_slot.c
> +++ b/hw/misc/empty_slot.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
> @@ -55,41 +56,45 @@ static const MemoryRegionOps empty_slot_ops =3D {
>
>  void empty_slot_init(hwaddr addr, uint64_t slot_size)
>  {
> -    if (slot_size > 0) {
> -        /* Only empty slots larger than 0 byte need handling. */
> -        DeviceState *dev;
> -        SysBusDevice *s;
> -        EmptySlot *e;
> -
> -        dev =3D qdev_create(NULL, TYPE_EMPTY_SLOT);
> -        s =3D SYS_BUS_DEVICE(dev);
> -        e =3D EMPTY_SLOT(dev);
> -        e->size =3D slot_size;
> -
> -        qdev_init_nofail(dev);
> -
> -        /*
> -         * We use a priority lower than the default UNIMPLEMENTED_DEVICE
> -         * to be able to plug a UnimplementedDevice on an EmptySlot.
> -         */
> -        sysbus_mmio_map_overlap(s, 0, addr, -10000);
> -    }
> +    DeviceState *dev;
> +
> +    dev =3D qdev_create(NULL, TYPE_EMPTY_SLOT);
> +
> +    qdev_prop_set_uint64(dev, "size", slot_size);
> +    qdev_init_nofail(dev);
> +
> +    /*
> +     * We use a priority lower than the default UNIMPLEMENTED_DEVICE
> +     * to be able to plug a UnimplementedDevice on an EmptySlot.
> +     */
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, addr, -10000);
>  }
>
>  static void empty_slot_realize(DeviceState *dev, Error **errp)
>  {
>      EmptySlot *s =3D EMPTY_SLOT(dev);
>
> +    if (s->size =3D=3D 0) {
> +        error_setg(errp, "property 'size' not specified or zero");
> +        return;
> +    }
> +
>      memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
>                            "empty-slot", s->size);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>  }
>
> +static Property empty_slot_properties[] =3D {
> +    DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void empty_slot_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D empty_slot_realize;
> +    dc->props =3D empty_slot_properties;
>  }
>
>  static const TypeInfo empty_slot_info =3D {
> --
> 2.19.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

