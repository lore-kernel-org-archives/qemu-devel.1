Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E3C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3BF22B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dih5V7gG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3BF22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46iI-0008CU-RP
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46h2-0006dn-4d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46h0-0007tS-SX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27840
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46h0-0007sX-O6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMa/pkHbOO9IpA8uVoNb6qkVHNMC6w9Bsb5cDu27brQ=;
 b=dih5V7gGumCwVUW9f4D5SlKDrQEsGaG7iUSMSZDcwoLaX/UvryS9Rx4NE3hNTXSfotH0SK
 gg4XGwi5bQ4oN+KemhD69q2SPBhCmOYtKXtyppwU+zXViqLDizDBm6Ko77tnongGTlK3MB
 OIuvcKmDzR21NZ7ENV6bXvQpCrV4Ihc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-ldQ32A6YNd6Me2KmE3vjpA-1; Tue, 18 Feb 2020 12:29:51 -0500
Received: by mail-wm1-f72.google.com with SMTP id p2so341874wma.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9hbmWG/TXwiPw95UtEwEA5tU/nNTt6kxQGSUw/5U5ok=;
 b=h9shymJE8yGO4RIydxVZPWqS88fXzHryKCiZRsruZanSl6unb74rWpW5W4oE8h3YVA
 +qtyTD84Vc5DdOWTC9Ky79/3DNHM0FMaieAJaQkGJ03om5a7d9rkZNEtZpU/hyC6K0YI
 iQv37Pdzg7SdCvZN0NlzqzLuC9ILnYTaLepu7peMweGhNkkKfj6tvKbIjGV+zSE96PLC
 Vhegx5occ2eb1TWLu74dNj59ZOjzA2KEdPxLbAoe2GK9CHzemX9gN8vOKpzgUrg1WRrf
 IsNAZWRmJ7v6D69C0G0sg+oVRCUV/vUmu4AaKo4aWEjqgmPODeclM72IBjaarQukIfHA
 VqKQ==
X-Gm-Message-State: APjAAAXjFddqKq7K90aZkksFZJzNtFrL4UZQV5cAWmGhoUPyOUq5LX3W
 qe25WpWGU7RQ+ZpQTVrSvCsGg5coT4CkEnmnwogdBIy3PbVfQp1yzOoZuJ4E5rL9tXWKA2wt63i
 yQydD7eH2+3hFREY=
X-Received: by 2002:adf:e692:: with SMTP id r18mr30376579wrm.413.1582046989847; 
 Tue, 18 Feb 2020 09:29:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwOCICNL8FdXto6dYA7Hxr4THbwMpVMSnHSq9QBNJgkvbjJsAV9t4X2skaT4f0W0gmllxKbg==
X-Received: by 2002:adf:e692:: with SMTP id r18mr30376566wrm.413.1582046989679; 
 Tue, 18 Feb 2020 09:29:49 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c9sm6929295wrq.44.2020.02.18.09.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:29:49 -0800 (PST)
Subject: Re: [PATCH v5 51/79] mips/mips_fulong2e: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-52-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6965f7ee-d196-e0a6-5077-4bd70005f20b@redhat.com>
Date: Tue, 18 Feb 2020 18:29:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-52-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: ldQ32A6YNd6Me2KmE3vjpA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, aleksandar.rikalo@rt-rk.com,
 aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported.
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>=20
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * fix format string cousing build failure on 32-bit host
>     (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> v3:
>   * since size is ifxed, just hardcode 256Mb value as text
>     in error message
>     (BALATON Zoltan <balaton@eik.bme.hu>)
>=20
> CC: philmd@redhat.com
> CC: amarkovic@wavecomp.com
> CC: aurelien@aurel32.net
> CC: aleksandar.rikalo@rt-rk.com
> CC: balaton@eik.bme.hu
> ---
>   hw/mips/mips_fulong2e.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 2e043cbb98..cf00211bd2 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -296,7 +296,6 @@ static void mips_fulong2e_init(MachineState *machine)
>       MemoryRegion *address_space_mem =3D get_system_memory();
>       MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> -    ram_addr_t ram_size =3D machine->ram_size;
>       long bios_size;
>       uint8_t *spd_data;
>       Error *err =3D NULL;
> @@ -315,10 +314,14 @@ static void mips_fulong2e_init(MachineState *machin=
e)
>       qemu_register_reset(main_cpu_reset, cpu);
>  =20
>       /* TODO: support more than 256M RAM as highmem */
> -    ram_size =3D 256 * MiB;
> +    if (machine->ram_size !=3D 256 * MiB) {
> +        error_report("Invalid RAM size, should be 256MB");
> +        exit(EXIT_FAILURE);
> +    }

Thanks you didn't remove the TODO.

The patch keeps the same behavior, so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>       /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_=
size);
> +    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
> +                                         machine->ram_size);
>       memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
>                              &error_fatal);
>       memory_region_set_readonly(bios, true);
> @@ -332,7 +335,7 @@ static void mips_fulong2e_init(MachineState *machine)
>        */
>  =20
>       if (kernel_filename) {
> -        loaderparams.ram_size =3D ram_size;
> +        loaderparams.ram_size =3D machine->ram_size;
>           loaderparams.kernel_filename =3D kernel_filename;
>           loaderparams.kernel_cmdline =3D kernel_cmdline;
>           loaderparams.initrd_filename =3D initrd_filename;
> @@ -378,7 +381,7 @@ static void mips_fulong2e_init(MachineState *machine)
>       }
>  =20
>       /* Populate SPD eeprom data */
> -    spd_data =3D spd_data_generate(DDR, ram_size, &err);
> +    spd_data =3D spd_data_generate(DDR, machine->ram_size, &err);
>       if (err) {
>           warn_report_err(err);
>       }
>=20


