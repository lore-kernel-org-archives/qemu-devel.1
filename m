Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45769C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111EE20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xmd5+R7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111EE20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46c1-0000Bh-9K
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46bB-000813-Ne
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46bA-0004da-JA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:23:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42116
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46bA-0004dB-Eb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmfQL7ryuq35saeJIBRZLsgDQ2FFz75YL61DJrNrSko=;
 b=Xmd5+R7N66gStIyiwT/OhXGUXkYda+8PpAo8UuDCFUOE3CmrLMR2NDifMvkZOxcJUvduR+
 EMXTafhYZgroiCJJ/NmsWwj4bTg7L6BoJUkooAiVrvUnKSNqES6BnSjwFRFEfIZ1aCfQbI
 HJmSSaFINJvwvChlrkbJtMHPUkU469E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-iRIN22lTPGugjElLKwc5SQ-1; Tue, 18 Feb 2020 12:23:49 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so11093500wru.7
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UmfQL7ryuq35saeJIBRZLsgDQ2FFz75YL61DJrNrSko=;
 b=L7VXMAuFaZJs1lZ3BLzcaFl5x6Ahr6RR69Cz5CmAtaJOYW8ItLwJHT8H1roodgmHV8
 ICXKxlbh56d+hsLwD2ETONKREBhxHxPy9kaOBKkUzJf8538Qxz5DUgNddTUJsCBcjrgx
 VqmuFY5WiGUxaaQyOhxTJ8BEhsw/GtDrql99y0YrsTCYFKhcYtgOkeguA/5yd+FVAQ9+
 NpeYBVKC9wcV4DcxoQByHpBnxj+pO2hHl7froSemT+JpaseLHlaQrjBuq+b5qUZv6X/Q
 YH1u5DAF84H/5H6GYDQTr8YEJ5epU8LZ6PTkD3Qdo5EV7nxWLKAr99ZBplX6nrDnjezI
 JSuw==
X-Gm-Message-State: APjAAAVJfyQgwLMLpMXd0ws3OidVKIEzNjP6mClEC4iRONV4lRKAesv1
 IhI3mzBo5CMIwBZ/5TvsBxy2V71uz+C0oOM/PRHPdooBL3J6G5i5SKcu8/DsJx4Q4oMuEks0p0K
 Q0jRqi2ewjKQrdTE=
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr4181514wmm.143.1582046628368; 
 Tue, 18 Feb 2020 09:23:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3NW1beQo3ZSjokQH1myHZ7AnrR0od1mMZRxBdgrt2KiatbAn8hVq34I3c8IsPSpR0wb3qlA==
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr4181495wmm.143.1582046628123; 
 Tue, 18 Feb 2020 09:23:48 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g25sm4621021wmh.3.2020.02.18.09.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:23:47 -0800 (PST)
Subject: Re: [PATCH v5 34/79] arm/xilinx_zynq: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-35-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bfc46ad0-fa98-0d1f-b452-be82c7dda85d@redhat.com>
Date: Tue, 18 Feb 2020 18:23:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-35-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: iRIN22lTPGugjElLKwc5SQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported.
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
> 
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/arm/xilinx_zynq.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 3a0fa5b23f..df950fc400 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -158,7 +158,6 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
>   
>   static void zynq_init(MachineState *machine)
>   {
> -    ram_addr_t ram_size = machine->ram_size;
>       ARMCPU *cpu;
>       MemoryRegion *address_space_mem = get_system_memory();
>       MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
> @@ -168,6 +167,12 @@ static void zynq_init(MachineState *machine)
>       qemu_irq pic[64];
>       int n;
>   
> +    /* max 2GB ram */
> +    if (machine->ram_size > 0x80000000) {
> +        error_report("RAM size more than %d is not supported", 0x80000000);

Eh? Maybe:

        if (machine->ram_size > 2 * GiB) {
            error_report("RAM size more than 2 GiB is not supported");

> +        exit(EXIT_FAILURE);
> +    }
> +
>       cpu = ARM_CPU(object_new(machine->cpu_type));
>   
>       /* By default A9 CPUs have EL3 enabled.  This board does not
> @@ -184,14 +189,9 @@ static void zynq_init(MachineState *machine)
>                               &error_fatal);
>       object_property_set_bool(OBJECT(cpu), true, "realized", &error_fatal);
>   
> -    /* max 2GB ram */
> -    if (ram_size > 0x80000000) {
> -        ram_size = 0x80000000;
> -    }
> -
>       /* DDR remapped to address zero.  */
>       memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram",
> -                                         ram_size);
> +                                         machine->ram_size);
>       memory_region_add_subregion(address_space_mem, 0, ext_ram);
>   
>       /* 256K of on-chip memory */
> @@ -300,7 +300,7 @@ static void zynq_init(MachineState *machine)
>       sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
>       sysbus_mmio_map(busdev, 0, 0xF8007000);
>   
> -    zynq_binfo.ram_size = ram_size;
> +    zynq_binfo.ram_size = machine->ram_size;
>       zynq_binfo.nb_cpus = 1;
>       zynq_binfo.board_id = 0xd32;
>       zynq_binfo.loader_start = 0;
> 


