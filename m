Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B874C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C85220801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITwo7KuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C85220801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46go-0005wx-MQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46fT-0004r0-IU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46fR-0006lr-LQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:28:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46fR-0006lU-Hg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyDLXpy8pqtvFYuQQ1BROWhXQ4xlg+6nEi9cO4XCf1M=;
 b=ITwo7KuZepmJc07m9/IYjGzBz/R2Q2QAIamWWyirYrVlhm1qoDq4YZnSCFraTUWzkc1X8q
 tv84XGKKWETxNuqGpxAHMccYWfJAHohovQ57JlJ/77BKzpm6Q2rRdY6oit5gG8fGRjZWMs
 RwS8KhnDNFE79c3Sdf2nVeMVXev0m64=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-0xNbeRD5NEaKKi6SRQajUQ-1; Tue, 18 Feb 2020 12:28:09 -0500
Received: by mail-wr1-f72.google.com with SMTP id 50so11217410wrc.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZvskHUmc9TtyS2+RpGXcv7ir+CLI5SQQhVbf1uSiz0Y=;
 b=gkJ9gqaAroAMze47t4iO/cZ3bXBKvJE2GDSrRw7NcJzbH3YwDQQrDxIuWPBkJsXABQ
 dxv2VOFpknrOYTwUlOQZ++aL8ocdvd0LMR8B+0gJnsjd6+NbRdWbIJmXj6bGRoOlilgV
 b4dY0yW9/yUe4XuE3xce/EQSvand75ovk/jbhxjqQ6GDZSaYy7aLPgjfnoxCRLm4Xe37
 l1hE8uXnyc6CuXai8LrbxNIKRYj8cYfP1T2zMjxhUsgSQNxD+c+smlzCKn38rjpWzozr
 TlFHsq0f6JAJF7PeYgMy9RewFjHpmKuFGkU+yW7Fo1ZM2bEnnPey8S2oq22O/ra+0Kf+
 m6CQ==
X-Gm-Message-State: APjAAAVyIPMGsfVmvLiR7Hof/s8/pQxbAxD6BKlIkPq+6vI/azqk84I6
 tIFzkySq8uvN/TzSgBb3Qb8h5mEsr/9Nz8SdM95OhKi+gwI32VK7Vndy15aLT6M8J1LEk4Lq5+q
 a5ct2q+97SoLMO/A=
X-Received: by 2002:adf:e8c9:: with SMTP id k9mr30589682wrn.168.1582046888011; 
 Tue, 18 Feb 2020 09:28:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZzK1ewWOFIh/FescWSdkENNuWlD5N1UuLz8Lpn7GSWiwNWdnr06Tg4GlhfrVde+l/zmz+aQ==
X-Received: by 2002:adf:e8c9:: with SMTP id k9mr30589656wrn.168.1582046887774; 
 Tue, 18 Feb 2020 09:28:07 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h128sm4564173wmh.33.2020.02.18.09.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:28:07 -0800 (PST)
Subject: Re: [PATCH v5 52/79] mips/mips_fulong2e: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-53-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a05a2406-9541-fce0-4c13-81abcbe54c09@redhat.com>
Date: Tue, 18 Feb 2020 18:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-53-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 0xNbeRD5NEaKKi6SRQajUQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, aleksandar.rikalo@rt-rk.com,
 aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: philmd@redhat.com
> CC: amarkovic@wavecomp.com
> CC: aurelien@aurel32.net
> CC: aleksandar.rikalo@rt-rk.com
> ---
>   hw/mips/mips_fulong2e.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index cf00211bd2..c373ab066b 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -294,7 +294,6 @@ static void mips_fulong2e_init(MachineState *machine)
>       const char *initrd_filename =3D machine->initrd_filename;
>       char *filename;
>       MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>       long bios_size;
>       uint8_t *spd_data;
> @@ -320,13 +319,11 @@ static void mips_fulong2e_init(MachineState *machin=
e)
>       }
>  =20
>       /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
> -                                         machine->ram_size);
>       memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
>                              &error_fatal);
>       memory_region_set_readonly(bios, true);
>  =20
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>       memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
>  =20
>       /*
> @@ -402,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass *=
mc)
>       mc->block_default_type =3D IF_IDE;
>       mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
>       mc->default_ram_size =3D 256 * MiB;
> +    mc->default_ram_id =3D "fulong2e.ram";
>   }
>  =20
>   DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


