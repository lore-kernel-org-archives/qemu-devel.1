Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2D3C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3937022B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJHWsFEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3937022B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46aK-0007LX-Fj
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46ZZ-0006Ra-Fp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46ZY-0003lJ-9b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:22:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46ZY-0003l0-5T
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cHs+t/5OUX+6ZJM4S80AItKPXiJumtkl1zVM7BP74E=;
 b=gJHWsFEGpdrNCfA70i1wBu4U/UJuqFnwLXlW6PXBI76bHN64Ll3E2RyfPdbmY98+JtA/gs
 LFt+/YWa0Ze24CLANCPce/lqdAXXmySFNJYpeuPdlIiD3KCswZM3s1iC32Rd9O1nMRgNey
 QpgB5eSTvUjF36Qqv+Im6oR8Sfs8z8I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-ib66xwrAN4a1TKDBUIKgdg-1; Tue, 18 Feb 2020 12:22:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id n23so11145421wra.20
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A63wpvarHxihmZnojSG1fA1y2nNo+gPZNNytlSQV5pc=;
 b=K0QPFgKf9emxGfpylGmwczehqh6TNnafpMcyXBCl4E6D40VlQ/ODb63u2H/Moa7NQT
 EE/zt5JzXkK6Z06jcUVx3rloss+jSjcKskLqtFihQjaVUdF0D/1VbJwnug7V1X9/6iXw
 bL104PjzcPHPVUvTASlM0Ks3ubGqnjqccsmQdBJuw5Eg0OLTjDqYve2ejcOQFAvdR1lJ
 dki3yCEGNbdD30Mj0tFMkJOjjKS2LO/i5pD7j032tnGjlOhWjjhqZTztD7GSeoEnDtrm
 hg6PcPLKPMQLBU354BElAewVlw1M2s6jMwEtFaPBMcWU2a407eQzn2JeUTJyITxE/239
 ARSg==
X-Gm-Message-State: APjAAAVc1pH3z2ndrzjUMZoHcFPeywr/Uh9jSpuTPkSmFBpGEmQv3loE
 wzq47ogm3Rx90rfxPWiOKGmRbrR/gbJy8sT7qw9iLvnhUa6Nmgk2fLPpn5mnxl26aUHAegIab+C
 UoVQOPeMWhk5mAZU=
X-Received: by 2002:a05:6000:108b:: with SMTP id
 y11mr30838921wrw.187.1582046527848; 
 Tue, 18 Feb 2020 09:22:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1gGJFAjAEjALMEjwCtACVxnrCBDOSadyr/xJMc+D8HmR5MKSm3zi9W7O9nB9oyQGMoeCl2g==
X-Received: by 2002:a05:6000:108b:: with SMTP id
 y11mr30838903wrw.187.1582046527655; 
 Tue, 18 Feb 2020 09:22:07 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id e17sm6620874wrn.62.2020.02.18.09.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:22:07 -0800 (PST)
Subject: Re: [PATCH v5 27/79] arm/palm: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-28-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e9302ce2-2d10-f3c5-25b6-6b9eee291192@redhat.com>
Date: Tue, 18 Feb 2020 18:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-28-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: ib66xwrAN4a1TKDBUIKgdg-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
> PS:
>   while at it add check for user supplied RAM size and error
>   out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> v2:
>    * fix format string causing build failure on 32-bit host
>      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
>=20
> CC: balrogg@gmail.com
> ---
>   hw/arm/palm.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 72eca8cc55..388b2629a5 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -31,6 +31,7 @@
>   #include "hw/loader.h"
>   #include "exec/address-spaces.h"
>   #include "cpu.h"
> +#include "qemu/cutils.h"
>  =20
>   static uint64_t static_read(void *opaque, hwaddr offset, unsigned size)
>   {
> @@ -181,7 +182,6 @@ static void palmte_gpio_setup(struct omap_mpu_state_s=
 *cpu)
>  =20
>   static struct arm_boot_info palmte_binfo =3D {
>       .loader_start =3D OMAP_EMIFF_BASE,
> -    .ram_size =3D 0x02000000,

Again, this is incorrect. Used by hw/arm/boot::do_cpu_reset().

>       .board_id =3D 0x331,
>   };
>  =20
> @@ -195,15 +195,21 @@ static void palmte_init(MachineState *machine)
>       static uint32_t cs2val =3D 0x0000e1a0;
>       static uint32_t cs3val =3D 0xe1a0e1a0;
>       int rom_size, rom_loaded =3D 0;
> -    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>       MemoryRegion *flash =3D g_new(MemoryRegion, 1);
>       MemoryRegion *cs =3D g_new(MemoryRegion, 4);
>  =20
> -    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
> -                                         palmte_binfo.ram_size);
> -    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dram=
);
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE,
> +                                machine->ram);
>  =20
> -    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
> +    mpu =3D omap310_mpu_init(machine->ram, machine->cpu_type);
>  =20
>       /* External Flash (EMIFS) */
>       memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
> @@ -265,6 +271,8 @@ static void palmte_machine_init(MachineClass *mc)
>       mc->init =3D palmte_init;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
> +    mc->default_ram_size =3D 0x02000000;
> +    mc->default_ram_id =3D "omap1.dram";
>   }
>  =20
>   DEFINE_MACHINE("cheetah", palmte_machine_init)
>=20


