Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E9CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA49208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSkcOolD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA49208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46db-0002R0-Eq
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46cQ-0001FZ-9t
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46cP-0005Cj-2S
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:25:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58527
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46cO-0005CV-VA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHdsbHd/UplYOuK1MhtPKS+w05Y6jlBf0XZ7X3RTAD8=;
 b=PSkcOolDIM/Dn2Q/6a9jE/MqnaRdYOjFm8boiBYl8VxZbszwiyBn3mvJFDb08RL1bGkPBG
 bvkBZDNY48ONisRqXMk5Rbc0jtS9cJ3XmgLtUhKdeHagZN01cMdAwlOpgM3PcKy1988BQA
 Urf5A5iDk1QHNq11tux7geIqcvpfTss=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-Yt_d4yfEPbWSWA5QqN7rWQ-1; Tue, 18 Feb 2020 12:25:05 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so11102401wrm.23
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ch7/RwVoJyR7PCi5wg+xpK76Fo66LPZxHfqwUkdPvVI=;
 b=JUSZhsk6ppG058xq0issbAHA16wQ7b8P0Xoz6QTrVh8VyVhhAFaFqEM+JGBbF5dA2T
 mailTJppqIJvHUVJOIUnUxLqzLI7ciZ9/cuy6FKj4NUvqHT/VzrbpWfNNWt2uC1fOYHH
 6pLmkmYf0MTzI0CMREamE1Dqo4/d1/UpCNzO6qxTgOhXL1aWwBTooB/8L4wouXinFiW1
 xQQSea029LiV5TexTk1O+qdjF538lB9rj8KRlIzd7qC+29N0b+CkLJ1j9A1zzWPM7XkR
 M8nrhsRACVmvnEkDZJJpZyFFIkwqCvtym1/9N/FUHINgKpXOc1/EZ1yChdE3iL68dYVb
 Inzg==
X-Gm-Message-State: APjAAAV/XXnjvePdkBChRGu1vmjsD/K9I8C18u9FR6o6niJn94AQRl67
 1K0L2GlIW2L31EDw8x8hEV9UXu7ZOW6zrS+7+SQlLWjEapcC/BT+tMHies6fxFIgFhWuPnWz+CV
 kndc+t/IBxGYmvAA=
X-Received: by 2002:a05:600c:20f:: with SMTP id
 15mr4153569wmi.128.1582046704596; 
 Tue, 18 Feb 2020 09:25:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6ojCdvPQrIKpcPVa0PASKYO9rD0r53YzLIgc1HaCJovtd3GcglervOIVYUbRGcOwdWCMDAw==
X-Received: by 2002:a05:600c:20f:: with SMTP id
 15mr4153544wmi.128.1582046704406; 
 Tue, 18 Feb 2020 09:25:04 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm7098634wrt.30.2020.02.18.09.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:25:03 -0800 (PST)
Subject: Re: [PATCH v5 42/79] x86/microvm: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-43-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fbf7f7b0-9597-7366-5767-580f30a43ebe@redhat.com>
Date: Tue, 18 Feb 2020 18:25:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-43-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: Yt_d4yfEPbWSWA5QqN7rWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, ehabkost@redhat.com,
 slp@redhat.com, rth@twiddle.net
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
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> CC: slp@redhat.com
> CC: pbonzini@redhat.com
> CC: mst@redhat.com
> CC: rth@twiddle.net
> CC: ehabkost@redhat.com
> ---
>   hw/i386/microvm.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index d23485108d..38d8e51703 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -167,7 +167,7 @@ static void microvm_memory_init(MicrovmMachineState *=
mms)
>   {
>       MachineState *machine =3D MACHINE(mms);
>       X86MachineState *x86ms =3D X86_MACHINE(mms);
> -    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
> +    MemoryRegion *ram_below_4g, *ram_above_4g;
>       MemoryRegion *system_memory =3D get_system_memory();
>       FWCfgState *fw_cfg;
>       ram_addr_t lowmem;
> @@ -214,12 +214,8 @@ static void microvm_memory_init(MicrovmMachineState =
*mms)
>           x86ms->below_4g_mem_size =3D machine->ram_size;
>       }
>  =20
> -    ram =3D g_malloc(sizeof(*ram));
> -    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
> -                                         machine->ram_size);
> -
>       ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
> -    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
> +    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine=
->ram,
>                                0, x86ms->below_4g_mem_size);
>       memory_region_add_subregion(system_memory, 0, ram_below_4g);
>  =20
> @@ -227,7 +223,8 @@ static void microvm_memory_init(MicrovmMachineState *=
mms)
>  =20
>       if (x86ms->above_4g_mem_size > 0) {
>           ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
> -        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram=
,
> +        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
> +                                 machine->ram,
>                                    x86ms->below_4g_mem_size,
>                                    x86ms->above_4g_mem_size);
>           memory_region_add_subregion(system_memory, 0x100000000ULL,
> @@ -502,6 +499,7 @@ static void microvm_class_init(ObjectClass *oc, void =
*data)
>       mc->auto_enable_numa_with_memhp =3D false;
>       mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
>       mc->nvdimm_supported =3D false;
> +    mc->default_ram_id =3D "microvm.ram";
>  =20
>       /* Avoid relying too much on kernel components */
>       mc->default_kernel_irqchip_split =3D true;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


