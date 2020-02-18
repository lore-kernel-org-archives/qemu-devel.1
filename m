Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF5BC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F6E207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkkFwrbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F6E207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wnW-00057N-FM
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wmw-0004aa-DB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wmu-0006Pq-5V
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:55:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wmu-0006Pk-1h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582008919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMzDyq3pQC9jSeA63uq8ciSOg/RcsZYhWeYRAs7WDL8=;
 b=XkkFwrbN+spDpzLPD+FqJGt/xGlFtgb+tm7ywOThAV7ysB2K2BopkIcG8VuC2O9RkMSBj1
 vRuRg9rk986a5RgKBrzjieu2bVJswtdjDsJjFeDoYjYmLyuTmDBvMe3GoXWxWrMC8P0WaX
 jiO2YDLzw0xbcxF3hciO6dYkwxhmlig=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-c5OaLeyzMSu28LFTjAGElw-1; Tue, 18 Feb 2020 01:55:17 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so10238318wrm.23
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jMzDyq3pQC9jSeA63uq8ciSOg/RcsZYhWeYRAs7WDL8=;
 b=j438ytpdbQO95pzHN6Cdf5iJJrfvxjx7b48OBul5kKexetIFsW85oCzOWzpenzBbB1
 LXy3G4ajDPkrA2ia1ZS66DFVB9f8ryIvi1NpDqyUvhMpwBU8d9Q7/5ZRyxKy5pqSwOO7
 gFQfl/UQODqbELEkQl8b+GIbIG/JDmYlBoOUkCA9GVjWWwYTz58Mh/TIQI/tZLhAz9QR
 jEF4mXc2Ctxhaoj88ZBolfFXCI41f/DV+vcpIwud6hS/OViitpWc9Agf6utMXboDizOU
 BFI848L4aD/fjKsI/aDvCsibsWofX7PydrF153MjbXoArG19dOChEiNG7JiyobUemRHk
 YxZA==
X-Gm-Message-State: APjAAAW8GAFdg2eD7tdigc6K3oAwek2k8btCTBbhXdCOYJVOYcmJCp56
 nboLSSMyc5f8INzNErU+7WDwdYsTYxXSwwtrs6CVMIFmbsbhjC2N0jbz8sLcjc5s+8Bz7z+dUdT
 rRocWR8CajUspQSs=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr25752986wro.279.1582008916213; 
 Mon, 17 Feb 2020 22:55:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzp+EF941VbaC9DiID+bQT9Cm5O7wiBCo0wZmW0Tq5h1wl1TiGV1Bh9Y2vTFIWALiG0Hs/zeA==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr25752955wro.279.1582008915930; 
 Mon, 17 Feb 2020 22:55:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id u62sm2419774wmu.17.2020.02.17.22.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:55:15 -0800 (PST)
Subject: Re: [PATCH v5 17/79] arm/integratorcp: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-18-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5e21adc1-a197-9d37-133c-ea510b9b9926@redhat.com>
Date: Tue, 18 Feb 2020 07:55:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-18-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: c5OaLeyzMSu28LFTjAGElw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peter.chubb@nicta.com.au
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
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> CC: peter.chubb@nicta.com.au
> ---
>   hw/arm/integratorcp.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 0cd94d9f09..cc845b8534 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -585,7 +585,6 @@ static void integratorcp_init(MachineState *machine)
>       Object *cpuobj;
>       ARMCPU *cpu;
>       MemoryRegion *address_space_mem = get_system_memory();
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>       MemoryRegion *ram_alias = g_new(MemoryRegion, 1);
>       qemu_irq pic[32];
>       DeviceState *dev, *sic, *icp;
> @@ -605,14 +604,13 @@ static void integratorcp_init(MachineState *machine)
>   
>       cpu = ARM_CPU(cpuobj);
>   
> -    memory_region_allocate_system_memory(ram, NULL, "integrator.ram",
> -                                         ram_size);
>       /* ??? On a real system the first 1Mb is mapped as SSRAM or boot flash.  */
>       /* ??? RAM should repeat to fill physical memory space.  */
>       /* SDRAM at address zero*/
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>       /* And again at address 0x80000000 */
> -    memory_region_init_alias(ram_alias, NULL, "ram.alias", ram, 0, ram_size);
> +    memory_region_init_alias(ram_alias, NULL, "ram.alias", machine->ram,
> +                             0, ram_size);
>       memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
>   
>       dev = qdev_create(NULL, TYPE_INTEGRATOR_CM);
> @@ -660,6 +658,7 @@ static void integratorcp_machine_init(MachineClass *mc)
>       mc->init = integratorcp_init;
>       mc->ignore_memory_transaction_failures = true;
>       mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
> +    mc->default_ram_id = "integrator.ram";
>   }
>   
>   DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
> 

Looking at integratorcm_realize() this machine seems to handle at most 
512MiB.


