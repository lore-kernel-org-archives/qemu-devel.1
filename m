Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A8C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A19F20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csgh5idp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A19F20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46ZR-0005mD-Cz
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46WR-0000kW-45
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46WP-00025j-Uz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55423
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46WP-00025Z-RB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwImvubxP4VG2et81LGNOCVYVNfKlnuAuLVAKKZc3Pw=;
 b=csgh5idp+ciwGcFNMTnxrYIc2inasWTeVB9vv1BA7IneQ9zNpcfUNsaHqZsp4UHQ8OX3Kk
 7ew/KYijdyIbBnzCdRvjfRWGR02hj6DkyMehhNw78S2qN8lIbgcgkGdkrA213nv68iBzcN
 y0yGDF/hiPaZw3ImNbs4pWf4U2ahYRw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-73-dC2J9Nz2szYc-_-OZBQ-1; Tue, 18 Feb 2020 12:18:55 -0500
Received: by mail-wr1-f69.google.com with SMTP id u8so11157482wrp.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rtw5rQRV/Sod9oRHjuOl4iG7FVf8cYyOjeiCMWl/Cmo=;
 b=dp4uoEFeAXasHXNcfUPuXoVRBEtOuPI2qoZbo4RV6SDRHqHa6/k5/9BG0jKp+OMiSA
 h+PdJUMmJJ0cvrbFBWeAtlIfNFRnz7gvHB8D2fwqT7E7TmsGok/iiSqOqw5CqQYi8Rb2
 0djZAw+kCBlf4j++2ZM/TZ5kAVjolncpjl3lYxRo75pEaOcmSiycFBhb0OO6HpeiH4S/
 aglj9WY6rLNhb40UlzWIIfILSOS13Lvj+X1kopyA9ngLXKG/Wachkhi6+4rA7XJ2Xi+7
 Mgb+dbJYevXqvenJ9Gv75YH64PNm+vsziP5vfqcSuhz07J4fD9LF3Q8C9MihkoeLbvO9
 qCmA==
X-Gm-Message-State: APjAAAX4irjSuEpam/ja4cHpRjkASWRA12DykQWA5Z85ElzU901KYhdF
 WNU+fC3FUMoFfIKpbFbunvWUd62SXU5iD3MsZlhzXYbS2MmegTA9D1ilOBg71v+UFtij6oD8f/e
 Kud3cxjiTaB+FKLk=
X-Received: by 2002:a1c:44d:: with SMTP id 74mr4337245wme.53.1582046334545;
 Tue, 18 Feb 2020 09:18:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwx7BFZL8tf+yt8iva13WOQ577PALIt19OlAzqH+f7+DXiu3vlCVdHAla8z2xFB4DeRzIzT9w==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr4337229wme.53.1582046334313;
 Tue, 18 Feb 2020 09:18:54 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id k7sm4027905wmi.19.2020.02.18.09.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:18:53 -0800 (PST)
Subject: Re: [PATCH v5 20/79] arm/mcimx6ul-evk: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-21-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <86972af4-948e-babe-7bc6-45f65889f381@redhat.com>
Date: Tue, 18 Feb 2020 18:18:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-21-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 73-dC2J9Nz2szYc-_-OZBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jcd@tribudubois.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:33 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>    remove no longer needed MCIMX6ULEVK
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> CC: jcd@tribudubois.net
> ---
>   hw/arm/mcimx6ul-evk.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
> index e90b393a44..23a71ed378 100644
> --- a/hw/arm/mcimx6ul-evk.c
> +++ b/hw/arm/mcimx6ul-evk.c
> @@ -19,15 +19,10 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/qtest.h"
>  =20
> -typedef struct {
> -    FslIMX6ULState soc;
> -    MemoryRegion ram;
> -} MCIMX6ULEVK;
> -
>   static void mcimx6ul_evk_init(MachineState *machine)
>   {
>       static struct arm_boot_info boot_info;
> -    MCIMX6ULEVK *s =3D g_new0(MCIMX6ULEVK, 1);
> +    FslIMX6ULState *s;
>       int i;
>  =20
>       if (machine->ram_size > FSL_IMX6UL_MMDC_SIZE) {
> @@ -43,15 +38,12 @@ static void mcimx6ul_evk_init(MachineState *machine)
>           .nb_cpus =3D machine->smp.cpus,
>       };
>  =20
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc,  sizeof(s->=
soc),
> -                            TYPE_FSL_IMX6UL, &error_fatal, NULL);
> -
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_f=
atal);
> +    s =3D FSL_IMX6UL(object_new(TYPE_FSL_IMX6UL));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_=
fatal);
> +    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
>  =20
> -    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx6ul-evk.ra=
m",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(get_system_memory(),
> -                                FSL_IMX6UL_MMDC_ADDR, &s->ram);
> +    memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADD=
R,
> +                                machine->ram);
>  =20
>       for (i =3D 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
>           BusState *bus;
> @@ -61,7 +53,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
>  =20
>           di =3D drive_get_next(IF_SD);
>           blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
> -        bus =3D qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
> +        bus =3D qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
>           carddev =3D qdev_create(bus, TYPE_SD_CARD);
>           qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
>           object_property_set_bool(OBJECT(carddev), true,
> @@ -69,7 +61,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
>       }
>  =20
>       if (!qtest_enabled()) {
> -        arm_load_kernel(&s->soc.cpu, machine, &boot_info);
> +        arm_load_kernel(&s->cpu, machine, &boot_info);
>       }
>   }
>  =20
> @@ -78,5 +70,6 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
>       mc->desc =3D "Freescale i.MX6UL Evaluation Kit (Cortex A7)";
>       mc->init =3D mcimx6ul_evk_init;
>       mc->max_cpus =3D FSL_IMX6UL_NUM_CPUS;
> +    mc->default_ram_id =3D "mcimx6ul-evk.ram";
>   }
>   DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


