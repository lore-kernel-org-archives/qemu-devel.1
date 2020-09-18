Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77D2C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399D32072E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4AM5urn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399D32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBb2-0002hA-3p
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJBZt-0002Bz-9o
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJBZr-0004Ki-CB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600417025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BhG5anLghl16XC9OYGRYrHbYa9Br8taY182MdN2eTx8=;
 b=L4AM5urne4PtSvxlT5JSKSBGSKpl34ofgRuKXggIJTugJgARx71rYrHP9D6lVXHzNjrn2k
 Cs8wMaIKGwvWuSbVk2yGrWVaeekaNOxXs94OHOg+d2I0mAlLQ78L+kUT3wJoqmmzC9LLQp
 kWJsq8vqP/jC/nakObOljeaHrvYkCX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-a5PUJM_rP4CDQzVtiBJjAQ-1; Fri, 18 Sep 2020 04:17:04 -0400
X-MC-Unique: a5PUJM_rP4CDQzVtiBJjAQ-1
Received: by mail-wm1-f72.google.com with SMTP id r10so1616722wmh.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BhG5anLghl16XC9OYGRYrHbYa9Br8taY182MdN2eTx8=;
 b=SoF9r+WmnbJmL9QpqaUBJv0Lg+zdRRDEak20Ijd+4wTo7HmcxNiUv8h7sVLAl/Uop3
 bIL0xHCy5bcggiL7H7pxB8eWK/J2trg0WRQko0Xkt6xa80eFeFFk+CEF7hdbIGc5l6Gn
 /P5GeqlrOE6L7J15KKMxAOB/Ca8se/BxX8JuWw5KN1pzugdNapJvuw5Nc2wdJPZEedAr
 /UTN29lFwRrNrsXsQdqTmWxfJoknsO9EtOvjQdcdUGfiVKKgTR3Zv+JlZCq++wgpJAiT
 mAJBDERjr7It4PcdZRfWDSS4H8JhiztCzluDXQ3zudDVY5DO8xklYu/Yt9CBjafFTd6b
 qdEw==
X-Gm-Message-State: AOAM530wCR3o20lI0KATgncCoB9kMna3kkaB7oY+EgMWuTnRGEzuLvnQ
 QjqXR50tK4JGHeIgp2JK51a/BdoN8BHZtP8XI/58sEuthlfMw2WoZ9gbihpqQdDzdCqOW2ZbP4x
 bVhCjY9MV7c/FNlE=
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr12266074wrn.400.1600417022681; 
 Fri, 18 Sep 2020 01:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmzBGz6sLCWKiQD2AyRW6Ct3Updw6ynyPWOSFU+9dW4od4hmouaec9fkpW8LtmH9Npf5cADQ==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr12266044wrn.400.1600417022400; 
 Fri, 18 Sep 2020 01:17:02 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f14sm3869761wme.22.2020.09.18.01.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:17:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] add maximum combined fw size as machine configuration
 option
To: Erich Mcmillan <erich.mcmillan@hp.com>, lersek@redhat.com,
 dgilbert@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 imammedo@redhat.com
References: <20200918042339.3477-1-erich.mcmillan@hp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <c5961bff-811b-2895-a96e-867a4c160ddd@redhat.com>
Date: Fri, 18 Sep 2020 10:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918042339.3477-1-erich.mcmillan@hp.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Erich,

On 9/18/20 6:23 AM, Erich Mcmillan wrote:
> From: Erich McMillan <erich.mcmillan@hp.com>

Description/rationale?

> 
> Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> ---
>  hw/i386/pc.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_sysfw.c   | 13 ++-----------
>  include/hw/i386/pc.h | 22 ++++++++++++----------
>  3 files changed, 54 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d11daac..b304988 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1869,6 +1869,39 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
>      pcms->max_ram_below_4g = value;
>  }
>  
> +static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +    uint64_t value = pcms->max_fw_size;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +    Error *error = NULL;
> +    uint64_t value;
> +
> +    visit_type_size(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    if (value > 16 * MiB) {
> +        warn_report("User specifed max allowed firmware size %" PRIu64 " is greater than 16MiB,"
> +                    "if combined firwmare size exceeds 16MiB system may not boot,"

Typos "specified", "firmware".

> +                    "or experience intermittent stability issues.", value);
> +    }
> +
> +    pcms->max_fw_size = value;
> +}
> +
>  static void pc_machine_initfn(Object *obj)
>  {
>      PCMachineState *pcms = PC_MACHINE(obj);
> @@ -1884,6 +1917,7 @@ static void pc_machine_initfn(Object *obj)
>      pcms->smbus_enabled = true;
>      pcms->sata_enabled = true;
>      pcms->pit_enabled = true;
> +    pcms->max_fw_size = 8 * MiB;

I'm very confused by pc_system_flash_map()... Why not check
that no pflash exceeds 8MiB? Then 2 combined would be always
<16MiB.

>  
>      pc_system_flash_create(pcms);
>      pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
> @@ -2004,6 +2038,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>  
>      object_class_property_add_bool(oc, PC_MACHINE_PIT,
>          pc_machine_get_pit, pc_machine_set_pit);
> +
> +    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
> +        pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
> +        NULL, NULL);
> +    object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
> +        "Maximum combined firmware size");
>  }
>  
>  static const TypeInfo pc_machine_info = {
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index b6c0822..22450ba 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -39,15 +39,6 @@
>  #include "hw/block/flash.h"
>  #include "sysemu/kvm.h"
>  
> -/*
> - * We don't have a theoretically justifiable exact lower bound on the base
> - * address of any flash mapping. In practice, the IO-APIC MMIO range is
> - * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
> - * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> - * size.
> - */
> -#define FLASH_SIZE_LIMIT (8 * MiB)
> -
>  #define FLASH_SECTOR_SIZE 4096
>  
>  static void pc_isa_bios_init(MemoryRegion *rom_memory,
> @@ -182,10 +173,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
>          }
>          if ((hwaddr)size != size
>              || total_size > HWADDR_MAX - size
> -            || total_size + size > FLASH_SIZE_LIMIT) {
> +            || total_size + size > pcms->max_fw_size) {
>              error_report("combined size of system firmware exceeds "
>                           "%" PRIu64 " bytes",
> -                         FLASH_SIZE_LIMIT);
> +                         pcms->max_fw_size);
>              exit(1);
>          }
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fe52e16..cae213d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -39,10 +39,11 @@ struct PCMachineState {
>      uint64_t max_ram_below_4g;
>      OnOffAuto vmport;
>  
> -    bool acpi_build_enabled;
> -    bool smbus_enabled;
> -    bool sata_enabled;
> -    bool pit_enabled;
> +    bool     acpi_build_enabled;
> +    bool     smbus_enabled;
> +    bool     sata_enabled;
> +    bool     pit_enabled;
> +    uint64_t max_fw_size;
>  
>      /* NUMA information: */
>      uint64_t numa_nodes;
> @@ -52,13 +53,14 @@ struct PCMachineState {
>      hwaddr memhp_io_base;
>  };
>  
> -#define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
> -#define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
> +#define PC_MACHINE_ACPI_DEVICE_PROP   "acpi-device"
> +#define PC_MACHINE_MAX_RAM_BELOW_4G   "max-ram-below-4g"
>  #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
> -#define PC_MACHINE_VMPORT           "vmport"
> -#define PC_MACHINE_SMBUS            "smbus"
> -#define PC_MACHINE_SATA             "sata"
> -#define PC_MACHINE_PIT              "pit"
> +#define PC_MACHINE_VMPORT             "vmport"
> +#define PC_MACHINE_SMBUS              "smbus"
> +#define PC_MACHINE_SATA               "sata"
> +#define PC_MACHINE_PIT                "pit"
> +#define PC_MACHINE_MAX_FW_SIZE        "max-fw-size"

Having the space alignment changes in a previous "sanitize"
patch would ease the review of this one.

>  
>  /**
>   * PCMachineClass:
> 


