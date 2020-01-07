Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0972C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA44D2146E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ55ibNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA44D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolRY-0000tA-3i
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iokJu-0003Pw-S0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iokJt-0008B1-FL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:34:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iokJt-0008Ah-Bm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578386072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIdb3o7M8d7uXVlRgqblVImhFqDmpBulJb+/eXa1GOQ=;
 b=ZZ55ibNd8L0zcfQ5QKuybcgNwjM8misVHuppiqG2Kco/PQfkg7W0AABZulrsvfOJq56lxD
 UuCdPZiRDehgQdTnfZma4vMC+XkymchCKrpF5XNOBfy1I2UyN9wCZv3PGG9HdlgWStImA2
 opzT78W8EUjEgBSjLwbOaWxOS/KIk3o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-l07yU6xDMNq8i8UQyeP4PA-1; Tue, 07 Jan 2020 03:34:31 -0500
Received: by mail-wm1-f71.google.com with SMTP id n17so1699438wmk.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 00:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fSzZh6VKeTZqD3j37M5qpEArITXEuJSGLV2sPfwH+Ew=;
 b=So1xe43Xo+eW1YFWS3D09EusqBRPffHtGG5BvW+96L9WP43nIW5EcsXV/veU4fl4m/
 Ws4Oq2tLAAfqpnZP14YbfK+XRnpHd2gR+PhfFanvrspSFXIzHdUGMFP5zyMJJYt2edS1
 AjQAI96UbTmmyLfdwA0+TbRYipFiX1fdQ8IOdLhhK4T+hTcyPcsDqOIT5ExEJkupoXuY
 NdFyKLzFJ6RLHykT+Js6avFTilU3dLpfwRsxxek2wvev53/SuRqudgDj3NbmZV+IeUjw
 Hh7wa7pnJgxTK2Vagc+SMql2vLWHvOHPspEULJoyrzGdrdgcMPfrN3+YXs29czwfnOHA
 mZ2g==
X-Gm-Message-State: APjAAAV2CjpvKgK2POONH9mK3O/LsXpRpLwlWYmBJRvDBIp2pmPM82qv
 E4UQ0ok0OMe0POepqPOBQPHWBljkJB25VptMv1HwHzrRELFtM2cQihzlxqr71Ylr2j9pjIokoBr
 d59p5V3fvaeANQzs=
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr38647054wmi.35.1578386069714; 
 Tue, 07 Jan 2020 00:34:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyn3+Ism578TX4Ewfuzrymi0is9pzs/OZNCZoAoLBAFnmTt56Nn2yqJsNskaIhQuN8zLGsJOA==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr38647035wmi.35.1578386069493; 
 Tue, 07 Jan 2020 00:34:29 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id v83sm26150929wmg.16.2020.01.07.00.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 00:34:28 -0800 (PST)
Subject: Re: [PATCH 4/5] hw/arm/aspeed: add a 'execute-in-place' property to
 boot directly from CE0
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200107073423.30043-1-clg@kaod.org>
 <20200107073423.30043-5-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <949c0ad0-40b5-9c7d-4d5a-58e519166142@redhat.com>
Date: Tue, 7 Jan 2020 09:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107073423.30043-5-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: l07yU6xDMNq8i8UQyeP4PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 8:34 AM, C=C3=A9dric Le Goater wrote:
> The overhead for the OpenBMC firmware images using the a custom U-Boot
> is around 2 seconds, which is fine, but with a U-Boot from mainline,
> it takes an extra 50 seconds or so to reach Linux. A quick survey on
> the number of reads performed on the flash memory region gives the
> following figures :
>=20
>    OpenBMC U-Boot      922478 (~ 3.5 MBytes)
>    Mainline U-Boot   20569977 (~ 80  MBytes)
>=20
> QEMU must be trashing the TCG TBs and reloading text very often. Some
> addresses are read more than 250.000 times. Until we find a solution
> to improve boot time, execution from MMIO is not activated by default.
>=20
> Setting this option also breaks migration compatibility.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/aspeed.h |  2 ++
>   hw/arm/aspeed.c         | 44 ++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 41 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 4423cd0cda71..18521484b90e 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -19,6 +19,8 @@ typedef struct AspeedBoardState AspeedBoardState;
>  =20
>   typedef struct AspeedMachine {
>       MachineState parent_obj;
> +
> +    bool mmio_exec;
>   } AspeedMachine;
>  =20
>   #define ASPEED_MACHINE_CLASS(klass) \
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 0a7dfd29868b..bf23579fa53d 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -260,11 +260,18 @@ static void aspeed_machine_init(MachineState *machi=
ne)
>            * SoC and 128MB for the AST2500 SoC, which is twice as big as
>            * needed by the flash modules of the Aspeed machines.
>            */
> -        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
> -                               fl->size, &error_abort);
> -        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
> -                                    boot_rom);
> -        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
> +        if (ASPEED_MACHINE(machine)->mmio_exec) {
> +            memory_region_init_alias(boot_rom, OBJECT(bmc), "aspeed.boot=
_rom",
> +                                     &fl->mmio, 0, fl->size);
> +            memory_region_add_subregion(get_system_memory(), FIRMWARE_AD=
DR,
> +                                        boot_rom);
> +        } else {
> +            memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_r=
om",
> +                                   fl->size, &error_abort);
> +            memory_region_add_subregion(get_system_memory(), FIRMWARE_AD=
DR,
> +                                        boot_rom);
> +            write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort=
);
> +        }

Nitpick: I'd use rom_add_file_mr() in write_boot_rom(), and keep the=20
memory_region_add_subregion() call after the if/else statement.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       }
>  =20
>       aspeed_board_binfo.ram_size =3D ram_size;
> @@ -398,6 +405,30 @@ static void witherspoon_bmc_i2c_init(AspeedBoardStat=
e *bmc)
>       /* Bus 11: TODO ucd90160@64 */
>   }
>  =20
> +static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
> +{
> +    return ASPEED_MACHINE(obj)->mmio_exec;
> +}
> +
> +static void aspeed_set_mmio_exec(Object *obj, bool value, Error **errp)
> +{
> +    ASPEED_MACHINE(obj)->mmio_exec =3D value;
> +}
> +
> +static void aspeed_machine_instance_init(Object *obj)
> +{
> +    ASPEED_MACHINE(obj)->mmio_exec =3D false;
> +}
> +
> +static void aspeed_machine_class_props_init(ObjectClass *oc)
> +{
> +    object_class_property_add_bool(oc, "execute-in-place",
> +                                   aspeed_get_mmio_exec,
> +                                   aspeed_set_mmio_exec, &error_abort);
> +    object_class_property_set_description(oc, "execute-in-place",
> +                           "boot directly from CE0 flash device", &error=
_abort);
> +}
> +
>   static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -407,6 +438,8 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
>       mc->no_floppy =3D 1;
>       mc->no_cdrom =3D 1;
>       mc->no_parallel =3D 1;
> +
> +    aspeed_machine_class_props_init(oc);
>   }
>  =20
>   static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *d=
ata)
> @@ -549,6 +582,7 @@ static const TypeInfo aspeed_machine_types[] =3D {
>           .name          =3D TYPE_ASPEED_MACHINE,
>           .parent        =3D TYPE_MACHINE,
>           .instance_size =3D sizeof(AspeedMachine),
> +        .instance_init =3D aspeed_machine_instance_init,
>           .class_size    =3D sizeof(AspeedMachineClass),
>           .class_init    =3D aspeed_machine_class_init,
>           .abstract      =3D true,
>=20


