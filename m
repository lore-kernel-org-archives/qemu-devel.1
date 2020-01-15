Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC130C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8223214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Utv0sA1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8223214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnTx-0000E7-P9
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irnSy-0007sW-Tk
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irnSu-00044o-JN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:32:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irnSu-00044O-D1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579113147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zk2tpiHxs7vkP1cq5FnDgSiS8dZZC7lPopxsgD0DNdk=;
 b=Utv0sA1jcu9vtLh7VwnhGiHoRbYU3CxjgP786eNsbC6rlE434b7P4VYdi2RLY+No2EHamJ
 iDaVkbC02R1sZWkNJ0hJfptyFO2/5sPU2UplQSWOX1m8g4Da3pyfTOMz+/+xHvW2jOod7E
 FlBiQmbIhmA1gwa7j9v8UOF583DDMnU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-rv0hf5LPN76N8RsmQ5iiuw-1; Wed, 15 Jan 2020 13:32:25 -0500
Received: by mail-wm1-f70.google.com with SMTP id t4so258272wmf.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 10:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qMnrRJbXJ6T1PwaEYvlyg3ewvRhs61nzLfkthkkaKHI=;
 b=C18Z16le3MZJy1dg8n89E5nCuWn3VapUl7UnpKmnICTU02VaS5bO8FqfCVDTtbHq68
 ryEJAhC/qCQ3qCanO3Ogk0PsGHWzgiDMkKzcSUW7ZgC107pA2GDQKmrRdEyXgi2/QK83
 0rc4wTt03rd+4mfKHDIfptlVyUvHs7KMXIY33X7ZTL6Z3BwD9smc8goMYuqqIE+UOmD/
 URxX8g1wWK2eMiGOTUycOLqpbPGr0L+nhVY4N+VRwI3Eihoo2NtEvSYIos7yVxAPJa6K
 6D0f1ekuYBkvaxpBIUoV1XSNTOb3QtpPw2BOfNNMfwDU+pF3oRDXUvtR7qyg0qqnHPPr
 Ir1w==
X-Gm-Message-State: APjAAAWIcir7Aq/sM0nSYnbRsWZuqOtjr7midEB53cEdm4snlnKIMfCM
 8mkLfzFuWNeAPXNQBbK5wC92lXdgkDh7rTxeZSGSawljhZeCTA9JWHTwfDzaq387TjJ85utZ7xl
 hfQqV1cNUXiUIfZY=
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr1386799wmc.162.1579113144476; 
 Wed, 15 Jan 2020 10:32:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcPImJg+60pbCDuQysqn+zCDhJRMk29C7XdIX8Z/+ps54uYBKulyO/KLegXV3Wem1byG/qpw==
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr1386779wmc.162.1579113144258; 
 Wed, 15 Jan 2020 10:32:24 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id g18sm775145wmh.48.2020.01.15.10.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 10:32:23 -0800 (PST)
Subject: Re: [PATCH v2 48/86] lm32:milkymist: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-49-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <131b0631-7afd-8b1b-641c-2806248f704c@redhat.com>
Date: Wed, 15 Jan 2020 19:32:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-49-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: rv0hf5LPN76N8RsmQ5iiuw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: michael@walle.cc
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:07 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>   while at it add check for user supplied RAM size and error
>   out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>    * fix format string causing build failure on 32-bit host
>      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
>=20
> CC: michael@walle.cc
> ---
>   hw/lm32/milkymist.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 460d322..73c28f4 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -82,6 +82,7 @@ static void main_cpu_reset(void *opaque)
>   static void
>   milkymist_init(MachineState *machine)
>   {
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *kernel_cmdline =3D machine->kernel_cmdline;
>       const char *initrd_filename =3D machine->initrd_filename;
> @@ -90,22 +91,26 @@ milkymist_init(MachineState *machine)
>       int kernel_size;
>       DriveInfo *dinfo;
>       MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *phys_sdram =3D g_new(MemoryRegion, 1);
>       qemu_irq irq[32];
>       int i;
>       char *bios_filename;
>       ResetInfo *reset_info;
>  =20
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " Byte=
s",
> +                     mc->default_ram_size);

I'd be displayed nicer using size_to_str(). Can be improved later.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        exit(EXIT_FAILURE);
> +    }
> +
>       /* memory map */
>       hwaddr flash_base   =3D 0x00000000;
>       size_t flash_sector_size        =3D 128 * KiB;
>       size_t flash_size               =3D 32 * MiB;
>       hwaddr sdram_base   =3D 0x40000000;
> -    size_t sdram_size               =3D 128 * MiB;
>  =20
>       hwaddr initrd_base  =3D sdram_base + 0x1002000;
>       hwaddr cmdline_base =3D sdram_base + 0x1000000;
> -    size_t initrd_max =3D sdram_size - 0x1002000;
> +    size_t initrd_max =3D machine->ram_size - 0x1002000;
>  =20
>       reset_info =3D g_malloc0(sizeof(ResetInfo));
>  =20
> @@ -116,9 +121,7 @@ milkymist_init(MachineState *machine)
>  =20
>       cpu_lm32_set_phys_msb_ignore(env, 1);
>  =20
> -    memory_region_allocate_system_memory(phys_sdram, NULL, "milkymist.sd=
ram",
> -                                         sdram_size);
> -    memory_region_add_subregion(address_space_mem, sdram_base, phys_sdra=
m);
> +    memory_region_add_subregion(address_space_mem, sdram_base, machine->=
ram);
>  =20
>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>       /* Numonyx JS28F256J3F105 */
> @@ -183,7 +186,7 @@ milkymist_init(MachineState *machine)
>  =20
>           if (kernel_size < 0) {
>               kernel_size =3D load_image_targphys(kernel_filename, sdram_=
base,
> -                                              sdram_size);
> +                                              machine->ram_size);
>               reset_info->bootstrap_pc =3D sdram_base;
>           }
>  =20
> @@ -216,6 +219,8 @@ static void milkymist_machine_init(MachineClass *mc)
>       mc->init =3D milkymist_init;
>       mc->is_default =3D 0;
>       mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
> +    mc->default_ram_size =3D 128 * MiB;
> +    mc->default_ram_id =3D "milkymist.sdram";
>   }
>  =20
>   DEFINE_MACHINE("milkymist", milkymist_machine_init)
>=20


