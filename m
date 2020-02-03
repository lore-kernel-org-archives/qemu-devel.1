Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68852C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EFE2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMfm66/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EFE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXiA-0005jt-D9
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyXhS-0005Hr-OU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyXhR-0005g7-LE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:07:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyXhR-0005fh-Ga
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580720841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SFZ1U9p+hsmLArZ051uB8UvyFgwah7c78ZaL0LL9GE=;
 b=EMfm66/arMV0kuv6SPjbOnQ7xxw5gl5C3AuA0d6uQQW9/8dDjo+E/7XEzH4m8GoQvxKVmz
 KG4cFEYHd/wPRJEl79jirjDtlglmmbEWIrAZLP3nTOBccySHhPovrXqFIlGXLVu84tpfNd
 vTdBvBR5q8v8+6DcYMHTxFu0KYf5eM0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-OISC1u0jNGOgVoBg4LI_xw-1; Mon, 03 Feb 2020 04:07:17 -0500
Received: by mail-qv1-f70.google.com with SMTP id e10so9051858qvq.18
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XgSoVOBb7T4uOh6oYhrMMDEjfdaynsWMAZqImMYH6qM=;
 b=eBA8uLj1SG+zAZHC7B/8iR/LAAPokfn1F1c3Ee/Vs/9Vp91q4xtOB6JqqMw4rzOeCU
 N2ZFANqeS4rF39IMi8ugkWF4HZNSRCYrELR65mcY9DshM6QksBJojw1v7eI0FHYgxDYk
 mcUX4vPrTW6J+z6G4mTpAbLE4hNSwzzw+SEVw9Fm6S4H2X3TGtaWS5Nt4DBfSVGGPuh9
 j8/X3inSIxp9zqqeMNLspeFU+boizZzwmL+5ipn8SflOxHf6Jfo48/5wxZ0HWj1ZSHge
 BUHB+413FjsbF3+JyUknk/ZdVVtjzPLPKqON8/GR4mBCtjqPq23BLP2zIl5rO2+IfBma
 QTTw==
X-Gm-Message-State: APjAAAUyVn77ZLHTrFvx949DhxMAMOMimGHGvHe6w6GbjAyLD+OCHmZg
 0QALbrYJLsALID/cWrAwQmVgjgw3gY53ZpjMKblUHB9tCUb3rqL7zzarWejRzSf2uqPP/0tzsTf
 VnMV9MQ/M+xlUvF4=
X-Received: by 2002:aed:3344:: with SMTP id u62mr22196333qtd.73.1580720837113; 
 Mon, 03 Feb 2020 01:07:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwAR42PzV+v2ry8S7HwP3d1dPgKtGe4mbo29h3GME1MJtkaXT1TITXjFdac9p8kylij+Xow1Q==
X-Received: by 2002:aed:3344:: with SMTP id u62mr22196314qtd.73.1580720836830; 
 Mon, 03 Feb 2020 01:07:16 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id u21sm3104182qke.102.2020.02.03.01.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:07:16 -0800 (PST)
Date: Mon, 3 Feb 2020 04:07:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 43/80] x86/pc: use memdev for RAM
Message-ID: <20200203040441-mutt-send-email-mst@kernel.org>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-44-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1580483390-131164-44-git-send-email-imammedo@redhat.com>
X-MC-Unique: OISC1u0jNGOgVoBg4LI_xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 04:09:13PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

But see by other comment - I think a bool flag to opt in,
that can then be dropped for non-versioned boards would be nicer.

E.g. use_memdev_for_ram.



> ---
> CC: mst@redhat.com
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> CC: ehabkost@redhat.com
> ---
>  hw/i386/pc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2ddce42..6ab4acb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -937,7 +937,7 @@ void pc_memory_init(PCMachineState *pcms,
>                      MemoryRegion **ram_memory)
>  {
>      int linux_boot, i;
> -    MemoryRegion *ram, *option_rom_mr;
> +    MemoryRegion *option_rom_mr;
>      MemoryRegion *ram_below_4g, *ram_above_4g;
>      FWCfgState *fw_cfg;
>      MachineState *machine =3D MACHINE(pcms);
> @@ -950,22 +950,20 @@ void pc_memory_init(PCMachineState *pcms,
> =20
>      linux_boot =3D (machine->kernel_filename !=3D NULL);
> =20
> -    /* Allocate RAM.  We allocate it as a single memory region and use
> -     * aliases to address portions of it, mostly for backwards compatibi=
lity
> -     * with older qemus that used qemu_ram_alloc().
> +    /*
> +     * Split single memory region and use aliases to address portions of=
 it,
> +     * done for backwards compatibility with older qemus.
>       */
> -    ram =3D g_malloc(sizeof(*ram));
> -    memory_region_allocate_system_memory(ram, NULL, "pc.ram",
> -                                         machine->ram_size);
> -    *ram_memory =3D ram;
> +    *ram_memory =3D machine->ram;
>      ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
> -    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
> +    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine=
->ram,
>                               0, x86ms->below_4g_mem_size);
>      memory_region_add_subregion(system_memory, 0, ram_below_4g);
>      e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
>      if (x86ms->above_4g_mem_size > 0) {
>          ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
> -        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram=
,
> +        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
> +                                 machine->ram,
>                                   x86ms->below_4g_mem_size,
>                                   x86ms->above_4g_mem_size);
>          memory_region_add_subregion(system_memory, 0x100000000ULL,
> @@ -1952,6 +1950,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported =3D true;
>      mc->numa_mem_supported =3D true;
> +    mc->default_ram_id =3D "pc.ram";
> =20
>      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
>          pc_machine_get_device_memory_region_size, NULL,
> --=20
> 2.7.4
>=20
>=20


