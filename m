Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A3C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4B5206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="It4BSh/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4B5206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imJjD-0003Ea-3E
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 10:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imJiB-0002Kc-Sy
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imJi9-0000JK-QO
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:45:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imJi9-0000Ff-LG
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577807133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCCsY3qlrCSUEOexk5DuVBdNhy+ZKjnjYNgrS+VrtbU=;
 b=It4BSh/67ZCcYNTgOEHDHSt0DU4cDVl7lXFzwCrLugB+2WcMMY0CjbdtqN0urVIYatbmwx
 9J6JK9UfpWBNRDmOZSVFFJNyCjFiN6WDzMPgQ2qV4aXgYkfWvUTWc0bR2FxzbsZuAg0dzf
 6/2m5xvZScLgPW3wvyBLrNYO9sjjgEo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-_tfDVch1MkuBg5JIm3QdmQ-1; Tue, 31 Dec 2019 10:45:29 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so13059866wrp.10
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 07:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=32u1dOZfGca168Lg8AW2oLJWVj0X9o+MCW28zHD5H+g=;
 b=ES9LrgL+HPjyRmyDOVVTJnx0znAf1stOIyLkFQsQKeH/mp3u7COQIjV5Lv1M8CITvW
 KgO4JXlWs+/3G2buKOutbjhxeSp+OHqIrrtoFyeUPkL9KGxfbwtrndUtkut0DQ/NH+hm
 x2gkXhtCsBO1jI396OuULdDCxJZLBhM1LaR0fFuzOQS2+2NElRMIIz4byhTbEkTVHdAY
 pKTclsRF47JEXNVNtYgu1O14ICnj5AOgWjhAkAm0GcjonLAusKVEWp6BjpQXpdH/srew
 c8uea0Umz64g+946jo9bdQFDg4dZJvd36WY2/BKWkD2hzSwZwNthvpsuKB/VthwtBsi5
 r/oA==
X-Gm-Message-State: APjAAAV/sI2DlJXwdbQqjm1b857o2dVXvY2jqvmBjkvGEZ8Asvn5qAYt
 ASe0vgCDoYcAlDajRPBbbWQW0QKNV/b/rxq1T9HxYPNsTFjLXbPATDt0O9OpYqv7/NkDl6KAx6j
 91q+aK+u834AfQXg=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr4799513wmb.73.1577807128508;
 Tue, 31 Dec 2019 07:45:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxB5W7DMMHsLow++qKw8MFxO/eQfa1gnP8AuE/MBBN3xhUZ//opAv3PFQEwCOeuJuwDgdX6JA==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr4799506wmb.73.1577807128327;
 Tue, 31 Dec 2019 07:45:28 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x17sm49494732wrt.74.2019.12.31.07.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 07:45:27 -0800 (PST)
Subject: Re: [PATCH 44/86] hppa: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-45-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16751216-671e-93eb-1c79-d09ecfdeaeed@redhat.com>
Date: Tue, 31 Dec 2019 16:45:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-45-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: _tfDVch1MkuBg5JIm3QdmQ-1
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
>   hw/hppa/machine.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 25f5afc..b2f7bc5 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -70,7 +70,6 @@ static void machine_hppa_init(MachineState *machine)
>       uint64_t kernel_entry =3D 0, kernel_low, kernel_high;
>       MemoryRegion *addr_space =3D get_system_memory();
>       MemoryRegion *rom_region;
> -    MemoryRegion *ram_region;
>       MemoryRegion *cpu_region;
>       long i;
>       unsigned int smp_cpus =3D machine->smp.cpus;
> @@ -96,11 +95,7 @@ static void machine_hppa_init(MachineState *machine)
>           exit(EXIT_FAILURE);
>       }
>  =20
> -    /* Main memory region. */
> -    ram_region =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
> -                                         "ram", ram_size);
> -    memory_region_add_subregion(addr_space, 0, ram_region);
> +    memory_region_add_subregion(addr_space, 0, machine->ram);
>  =20
>       /* Init Dino (PCI host bus chip).  */
>       pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
> @@ -284,6 +279,7 @@ static void machine_hppa_machine_init(MachineClass *m=
c)
>       mc->is_default =3D 1;
>       mc->default_ram_size =3D 512 * MiB;
>       mc->default_boot_order =3D "cd";
> +    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("hppa", machine_hppa_machine_init)
>=20


