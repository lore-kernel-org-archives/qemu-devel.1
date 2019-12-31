Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C8EC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6256205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP8GeBuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6256205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK6z-0004Fl-Ua
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK4p-0001Py-6B
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK4n-0001q0-UD
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:08:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK4n-0001nl-O8
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab/zDWczV7PTGyTHS4SI34wxEtTkZh/az5E3AccaCN4=;
 b=LP8GeBuPNjLZbj1g4/ItM5Qpm74d2nWdZoNWXc8JDWX3NygWZMVTLwVLhuIG+QYHcuU3zN
 bQEHNMwaGmnwF19ST70tbUrDg9KXvXmjklxrp9pe/fxP/xkliTRAmUSmgD4QJAwC/Pd/hn
 7p0ACQoxR0cs+4jNNMzLRhKGoztDUdM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-ny7LuOggPu6wScbMMwf4sQ-1; Tue, 31 Dec 2019 11:08:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so13084446wrp.10
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t+pcCnqHqLR73q+Kg1hMlZpTGwtuo/ZR5Mu4w7lQR+0=;
 b=e8NTbtImfSeyt7jGXD9957negxx8chUlmG8glaP62f4cMLixVKh8N+0b9YdJZ6cVZu
 keI5LAT1DksSbtgUNXUTFS1+cN52iEYVW9NsNOBVc6r0/PQfZeD5lcpDbpMTa4zW5b9x
 w9jEsEd7bHk5gerNYCatbKfhVP5qlTFqN9VXUaVYoKCc+vhGcdxOpUgpghBI3ZG27qkN
 Fb5SXsUIlVoOQtMJ4KnWQwPLsVeXNlYMZwPn0UpCDzer2R2JJBQxEUfFIRfQsx/9MEgS
 bWZeEF54/GL39BHYneNQxbwp6uyLOkkIBZRDurPoG+6eEnKSSyzuqTojqyt4YIwgOf+f
 noGA==
X-Gm-Message-State: APjAAAXpuSCzGEAh/IU3H1zTUNKTZ2FOIZUenToKJa/5BDfkA2nqLBf9
 20f/RZUlctCFBcKybsaHFiymdQ+76Orz9aMznX1ee++XZhcv96QXvYjBpiT6zVCHjEXyBh57EpY
 yncFL0bpNihn6qZ0=
X-Received: by 2002:adf:cf12:: with SMTP id o18mr74317785wrj.361.1577808532276; 
 Tue, 31 Dec 2019 08:08:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzERXtpK4BBRHjqicEQP1kbDkJgOkCEHUK07BmOToNKZF+CS/ObPZ1VwI79jT8x9XT6MhGG/A==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr74317766wrj.361.1577808532096; 
 Tue, 31 Dec 2019 08:08:52 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id u1sm2878226wmc.5.2019.12.31.08.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:08:51 -0800 (PST)
Subject: Re: [PATCH 52/86] mips:boston-cube: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-53-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <624839ee-dfa2-8791-b457-80caf253da26@redhat.com>
Date: Tue, 31 Dec 2019 17:08:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-53-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: ny7LuOggPu6wScbMMwf4sQ-1
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
>   hw/mips/boston.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index ca7d813..466054e 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -427,7 +427,7 @@ static void boston_mach_init(MachineState *machine)
>       DeviceState *dev;
>       BostonState *s;
>       Error *err =3D NULL;
> -    MemoryRegion *flash, *ddr, *ddr_low_alias, *lcd, *platreg;
> +    MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
>       MemoryRegion *sys_mem =3D get_system_memory();
>       XilinxPCIEHost *pcie2;
>       PCIDevice *ahci;
> @@ -473,14 +473,12 @@ static void boston_mach_init(MachineState *machine)
>       memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err=
);
>       memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
>  =20
> -    ddr =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(ddr, NULL, "boston.ddr",
> -                                         machine->ram_size);
> -    memory_region_add_subregion_overlap(sys_mem, 0x80000000, ddr, 0);
> +    memory_region_add_subregion_overlap(sys_mem, 0x80000000, machine->ra=
m, 0);
>  =20
>       ddr_low_alias =3D g_new(MemoryRegion, 1);
>       memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
> -                             ddr, 0, MIN(machine->ram_size, (256 * MiB))=
);
> +                             machine->ram, 0,
> +                             MIN(machine->ram_size, (256 * MiB)));
>       memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
>  =20
>       xilinx_pcie_init(sys_mem, 0,
> @@ -552,6 +550,7 @@ static void boston_mach_class_init(MachineClass *mc)
>       mc->init =3D boston_mach_init;
>       mc->block_default_type =3D IF_IDE;
>       mc->default_ram_size =3D 1 * GiB;
> +    mc->default_ram_id =3D "boston.ddr";
>       mc->max_cpus =3D 16;
>       mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("I6400");
>   }
>=20


