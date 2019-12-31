Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E96C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA50205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjpSU5/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA50205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK4m-0000ty-TE
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK3p-0008Kf-Oq
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK3o-0005Yb-HZ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:07:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK3o-0005WR-Cr
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUzvKXspv0LC33wvnoRpdXodcfLCsOHP76zLKSfurWw=;
 b=GjpSU5/BY2G/DlKg0gKIEl+sevscWvPMN8nCcAeq59brIBEbJtuecfc4jhClq9QdLKmvQm
 H3YudBrEF9/K+v3aBQ/81G84M0Pge7uMfZO6vJMWHOTtyZXnpuFsX9zgmzBh5+WVVir4Fa
 Damq7GzktUFPnOjjo39z02YvPLrZ3EI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-3gO--EGjP5SZqtxzWzmsQw-1; Tue, 31 Dec 2019 11:07:54 -0500
Received: by mail-wr1-f71.google.com with SMTP id f10so10954433wro.14
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jHUkrwTqcSv/kiMD97qPtX1Sk/VPIkWVms4DRmNNTzg=;
 b=qSCD7z+zqYLNFBzYJj9pw8IXnWKpsQci1t9AWWaytdmcV/YXtTpoi+hGV/rNurNuJV
 801gzGE4+rZnKqF0/0l4e6eLhGrKXR7RXc7AdnBxgDiUR7GlpYPpHxauFOXThWYSNCKc
 PqjbFZ1vdK0tOQfpcXEi2hSIhcfrGtGVsZEv5wK6U+bxZ7W62q5p4lFTW4MpzjsodB1E
 NnLoJxsi82DrFOp9QLsS8vjNKzZ54RATzAAXEenboEWS12FXKJdZtr1zxC4rStSn8StG
 u4iB6QXRQ2lukjLCqcqkA+fW8Skq9ukgVHuzNG4J8nuh0o5+A23V9cWmL92XITUalXwH
 xaQQ==
X-Gm-Message-State: APjAAAWwcs6O4IYb5E4DGVxJ6jdt4SCkRoLXTgovYoHa7uVqI1ylENeO
 iM/5CqXPJUzF87oIWq8SoSj1k1iY5Z7IDMKZo8gFQzQ349ZMASddmL084/Q3UMJH+i1Nh+eNJ4J
 YmBQfLsBnsV4LM0s=
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr5351129wmi.15.1577808472709; 
 Tue, 31 Dec 2019 08:07:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqym1zwPNp1ryPGMMVIZnzstox8LiD7lzw/FQukBmjzCoDgZbv2OXmIqK/ckuyPc1egW6mdEwg==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr5351114wmi.15.1577808472517; 
 Tue, 31 Dec 2019 08:07:52 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id y6sm48706523wrl.17.2019.12.31.08.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:07:52 -0800 (PST)
Subject: Re: [PATCH 57/86] mips:mips_mipssim: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-58-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5a3a05a7-1668-8976-0146-941974ddf236@redhat.com>
Date: Tue, 31 Dec 2019 17:07:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-58-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 3gO--EGjP5SZqtxzWzmsQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:03 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/mips/mips_mipssim.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 282bbec..be3972f 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -142,14 +142,12 @@ static void mipsnet_init(int base, qemu_irq irq, NI=
CInfo *nd)
>   static void
>   mips_mipssim_init(MachineState *machine)
>   {
> -    ram_addr_t ram_size =3D machine->ram_size;
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *kernel_cmdline =3D machine->kernel_cmdline;
>       const char *initrd_filename =3D machine->initrd_filename;
>       char *filename;
>       MemoryRegion *address_space_mem =3D get_system_memory();
>       MemoryRegion *isa =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>       MIPSCPU *cpu;
>       CPUMIPSState *env;
> @@ -166,13 +164,11 @@ mips_mipssim_init(MachineState *machine)
>       qemu_register_reset(main_cpu_reset, reset_info);
>  =20
>       /* Allocate RAM. */
> -    memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
> -                                         ram_size);
>       memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
>                              &error_fatal);
>       memory_region_set_readonly(bios, true);
>  =20
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>  =20
>       /* Map the BIOS / boot exception handler. */
>       memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
> @@ -199,7 +195,7 @@ mips_mipssim_init(MachineState *machine)
>       }
>  =20
>       if (kernel_filename) {
> -        loaderparams.ram_size =3D ram_size;
> +        loaderparams.ram_size =3D machine->ram_size;
>           loaderparams.kernel_filename =3D kernel_filename;
>           loaderparams.kernel_cmdline =3D kernel_cmdline;
>           loaderparams.initrd_filename =3D initrd_filename;
> @@ -237,6 +233,7 @@ static void mips_mipssim_machine_init(MachineClass *m=
c)
>   #else
>       mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
>   #endif
> +    mc->default_ram_id =3D "mips_mipssim.ram";
>   }
>  =20
>   DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
>=20


