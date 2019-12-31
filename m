Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A053FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B458205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+aUOb+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B458205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK8O-0005l5-Jw
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK7c-0005LK-1T
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK7a-0006FM-QS
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:11:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59545
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK7a-0006Cu-MI
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71RkQy8imLfUAbo+vbrwGLjoMIo/DXHu6WN3MOu0rH8=;
 b=i+aUOb+mUuPJPEtsBDJIiKpjjBAFfnlwxLR6N7vei5aK20QMsmB9WZ91pjFctm+EwsQmvZ
 A5pL0576q3qPL5ZFAKHap0/CQ5DPT9Gamx3WPo4P812IPwM42A0q5l7SuUtNSExcNBsRyr
 WrW6zQVVByie4L5f2DkDkrPS9pGaV3M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ZJUUfF_2MlydeGVp9XinyA-1; Tue, 31 Dec 2019 11:11:46 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so10958323wro.14
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CqtVprdIShq+l0n6lj+m14h0IxqgwUjTwFy9K+/x5A0=;
 b=BCYiCW/bzxh+mGNbVHMWpf9yKQh5uChjEWDulYiKEUCOx08LcnbDUBud3/Q55ktwub
 tPSUH1h79By3opjBzDPZ2Ni2+2RLQGM7wX1/8q1t0bAWbtXs4j6/vVCYD9iKbYV0w6UL
 Bj1alGuGbApgrg/CNOMrtYQcebyePuiz+1pFtz0u7SVEL8LRpB4uzSDdMZ/hzXNosEEJ
 JmUi06pN5+IZnpXy9/3zdWHFNVfykIVsDBmd6gd+9Z+AJ3JreH+FboCttb2VUznC1u01
 RScAkEre/Aka2zJBxl4J+5SSkpI2lcdJhwWRg0DaSDVmHtZjUC21x+IfKMDiBh48Ieaw
 nB7A==
X-Gm-Message-State: APjAAAUdCvxpguUrozcqJ+KJ5fJ+JG5fg8n3fSbmf2jNRvVIPlGHACxU
 GOqX/8hMdXbrTa02nTKdTLsVbrDK5Y3x0HkNPJ8q0SpsTTFjCLfvoIv7tP60UnrQha6eM+UiyZ1
 4BzAtIQvptXzxhrE=
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr44265477wra.231.1577808705439; 
 Tue, 31 Dec 2019 08:11:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNeUDh5+KutEgs6EEj7FHGXJw44XTl/qCbUl0ZiYZsNffobCJMRCqJ3ppPd8Pyni8aKwZAJw==
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr44265465wra.231.1577808705252; 
 Tue, 31 Dec 2019 08:11:45 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id b15sm2873227wmj.13.2019.12.31.08.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:11:44 -0800 (PST)
Subject: Re: [PATCH 08/86] alpha:dp264: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-9-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5ec72d69-32e6-3867-4320-65b3891a283b@redhat.com>
Date: Tue, 31 Dec 2019 17:11:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-9-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: ZJUUfF_2MlydeGVp9XinyA-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:02 PM, Igor Mammedov wrote:
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
>   hw/alpha/alpha_sys.h | 2 +-
>   hw/alpha/dp264.c     | 3 ++-
>   hw/alpha/typhoon.c   | 8 ++------
>   3 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
> index 95033d7..bc0a286 100644
> --- a/hw/alpha/alpha_sys.h
> +++ b/hw/alpha/alpha_sys.h
> @@ -11,7 +11,7 @@
>   #include "hw/intc/i8259.h"
>  =20
>  =20
> -PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
> +PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4=
],
>                        pci_map_irq_fn);
>  =20
>   /* alpha_pci.c.  */
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index f2026fd..29439c7 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -75,7 +75,7 @@ static void clipper_init(MachineState *machine)
>       cpus[0]->env.trap_arg2 =3D smp_cpus;
>  =20
>       /* Init the chipset.  */
> -    pci_bus =3D typhoon_init(ram_size, &isa_bus, &rtc_irq, cpus,
> +    pci_bus =3D typhoon_init(machine->ram, &isa_bus, &rtc_irq, cpus,
>                              clipper_pci_map_irq);
>  =20
>       /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
> @@ -183,6 +183,7 @@ static void clipper_machine_init(MachineClass *mc)
>       mc->max_cpus =3D 4;
>       mc->is_default =3D 1;
>       mc->default_cpu_type =3D ALPHA_CPU_TYPE_NAME("ev67");
> +    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("clipper", clipper_machine_init)
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index 179e1f7..1795e2f 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -58,7 +58,6 @@ typedef struct TyphoonState {
>       TyphoonCchip cchip;
>       TyphoonPchip pchip;
>       MemoryRegion dchip_region;
> -    MemoryRegion ram_region;
>   } TyphoonState;
>  =20
>   /* Called when one of DRIR or DIM changes.  */
> @@ -817,8 +816,7 @@ static void typhoon_alarm_timer(void *opaque)
>       cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
>   }
>  =20
> -PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
> -                     qemu_irq *p_rtc_irq,
> +PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rt=
c_irq,
>                        AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
>   {
>       MemoryRegion *addr_space =3D get_system_memory();
> @@ -851,9 +849,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **is=
a_bus,
>  =20
>       /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB=
,
>          but the address space hole reserved at this point is 8TB.  */
> -    memory_region_allocate_system_memory(&s->ram_region, OBJECT(s), "ram=
",
> -                                         ram_size);
> -    memory_region_add_subregion(addr_space, 0, &s->ram_region);
> +    memory_region_add_subregion(addr_space, 0, ram);
>  =20
>       /* TIGbus, 0x801.0000.0000, 1GB.  */
>       /* ??? The TIGbus is used for delivering interrupts, and access to
>=20


