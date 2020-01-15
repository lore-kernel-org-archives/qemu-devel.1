Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465922084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdPoAVJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465922084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnra-0005SJ-6X
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irnqk-0004e5-T3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irnqj-0002EQ-S6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:57:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irnqj-0002EC-Ou
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579114625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUlKyIyXq9KCkniuMiskK6GLbO+vYx518J5KKmTPi1U=;
 b=KdPoAVJsH4pHDC5ru5U+iNHV1+daEpcFvD9IqzpmJgZ0UXELoivfp/ww3/aQ8B0cMvHbhY
 xpsu94msiHeOKM4i81kpY7tAM2DozadNTNVWPTcjZrlH5t88vYzNOlIizv6b4B3YKM5zaT
 B/wZatNoddAm+j3qNGrSBkT0I5tOjCs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-DHAH3k1MNa-aXZI1kYp_8A-1; Wed, 15 Jan 2020 13:57:04 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so272481wmt.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 10:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LyCGHEIQITM/+ovhheawX+GZAUy/lP6kMgd4i75SAiM=;
 b=tQP9UzKMXA0rJi6t3QO4t3PMFNmHbJUhdshSTyz0/oypnLJ6YqTjy50j+z3IG7iHe4
 95cJZyGW7GcOZAfrLG/Kh7nXrg2xsDkMk3hTcL1mxIWoN8JJ4ITrt6W9JdnIBP4X0HvK
 +BdXXXXQrGJHXxwZlhp1BNgu4nXAAai2vetvCizy4tcqvNI+oItS+qv9ho6zFJ5sfLpr
 c0B4YFB/4H9JeKAY2TSsJ5rGQDhueEJp61dlIo6dw1yu9R62sxx3Hw6UW9SHFQ7HSAn+
 x5JmSP2rTuX3k6TEzeOV7cg+3vrJxlHq44m0vBejVKrImPIkaIus5euR5Nufy1xtxQU/
 WXDg==
X-Gm-Message-State: APjAAAWwWnjp+xoGpP3t4B89gpk01JrwE29FAyQXXB3qCjaXAkDpEjyk
 MY7e/ojjc+G6J/ASTeJ25eQM4SIJ6V0brQJeARAJwQ7PDarD9udD1c5HlF+XTBwG87eGpTrEf+o
 TYx5gavJO7uo950w=
X-Received: by 2002:a05:6000:50:: with SMTP id
 k16mr32520239wrx.145.1579114623024; 
 Wed, 15 Jan 2020 10:57:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3w4lkQTNr6BvQ8DPimWXrjID4HTnEElu+Etg7Dsow9yl+PQWg0XGzJst4l36qQNODsI10yg==
X-Received: by 2002:a05:6000:50:: with SMTP id
 k16mr32520208wrx.145.1579114622736; 
 Wed, 15 Jan 2020 10:57:02 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id p7sm926943wmp.31.2020.01.15.10.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 10:57:02 -0800 (PST)
Subject: Re: [PATCH v2 33/86] arm:virt: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-34-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be80961b-0b2e-2a38-8dc8-a7b06b6064f4@redhat.com>
Date: Wed, 15 Jan 2020 19:57:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-34-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: DHAH3k1MNa-aXZI1kYp_8A-1
X-Mimecast-Spam-Score: 0
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:06 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away,
> so replace it with memdev allocated MemoryRegion.
> The later is initialized by generic code, so board only
> needs to opt in to memdev scheme by providing
>    MachineClass::default_ram_id
> and then map memory region provided by
>    MachineState::ram_memdev
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> CC: drjones@redhat.com
> ---
>   hw/arm/virt.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 39ab5f4..e2fbca3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1512,7 +1512,6 @@ static void machvirt_init(MachineState *machine)
>       MemoryRegion *sysmem =3D get_system_memory();
>       MemoryRegion *secure_sysmem =3D NULL;
>       int n, virt_max_cpus;
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       bool firmware_loaded;
>       bool aarch64 =3D true;
>       bool has_ged =3D !vmc->no_ged;
> @@ -1701,9 +1700,8 @@ static void machvirt_init(MachineState *machine)
>           }
>       }
>  =20
> -    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram)=
;
> +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
> +                                machine->ram);
>       if (machine->device_memory) {
>           memory_region_add_subregion(sysmem, machine->device_memory->bas=
e,
>                                       &machine->device_memory->mr);
> @@ -2053,6 +2051,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>       hc->unplug_request =3D virt_machine_device_unplug_request_cb;
>       mc->numa_mem_supported =3D true;
>       mc->auto_enable_numa_with_memhp =3D true;
> +    mc->default_ram_id =3D "mach-virt.ram";
>   }
>  =20
>   static void virt_instance_init(Object *obj)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


