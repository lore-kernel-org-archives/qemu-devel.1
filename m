Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71794C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D42A207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VypEdc3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D42A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wt7-0001CH-EQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 02:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wrs-0000io-ES
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wrq-0007qG-Se
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:00:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wrq-0007q8-PF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582009226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DzpUqk7+ksya3TGHUjYa7/BJl1OYW5fKzcYP8lJxSg=;
 b=VypEdc3lnAAYo2yj+L5xJrgst1TWD1a4r3TtxNRcHs3MtGUjUhQOPaS92xTluFn+z1pCHX
 dYqRzmsIhSzGx1gYIt6ClFcZt4Vq0GGp0/VUGQV3O8OwiJO0w2mzfJ4fmQ74Fne9rLIBto
 MwDigoK9M6HEYjqOE6XR1243nA975H8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-4A2g0PXHNh2jkwFjPV8MLQ-1; Tue, 18 Feb 2020 02:00:24 -0500
Received: by mail-wm1-f70.google.com with SMTP id f207so714214wme.6
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 23:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8KmT14syq+R4XMlV/oB+VSP2h3bC1JMnNPuy1NInxXA=;
 b=ZW0LoW5cBbhKLF8JE5dT39L2J1dlDM84dC7M2lSyB/B5nMWbPdljcM3uwkbocYT/zm
 BmTixQeZB8k0faE4ym1hhVVeJKI8yj7QNzzKV9SpU/TkC66hjCigmTWt0qZJQ6murjJL
 Mge2tIBY/g4AWQB34ycKUEW2G9ElMRGVg+hb+6RAcsGNAh5TkUbR4UOpXM/mqNXRgbbG
 jWvayx09/AiT6PcLMUOeD9BiVjwByQjllp7e2/dqYd0310X5xrp2k0eaZQJjXZoln/n/
 baDC10EN5vadztdQ+jE72SMM58oydcaMUnJ6Vxlt58APjwxObTRMlxC9hwocJnsHDSrc
 U20Q==
X-Gm-Message-State: APjAAAUbuG0MnIU26BaUpw/KLazqaK0ehK9rbkrvnwnTcS+zwoXXjymh
 4knAm3cruWQeyuXp75Exhq4jj0jfPPXGy1dGiqCUoKNjLqzEKXv5RTnAXf5oHBGcQVxpJEo83FZ
 +NFPgox74z2jQS+k=
X-Received: by 2002:a5d:5267:: with SMTP id l7mr26440485wrc.84.1582009223336; 
 Mon, 17 Feb 2020 23:00:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHYoJSyYLEpGQ1T0JVruw26DkeX38HM+wssPLNkIqp6kvXrYLVdIFPxRP+8JYGSvbstSk1mA==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr26440443wrc.84.1582009222983; 
 Mon, 17 Feb 2020 23:00:22 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i4sm2289774wmd.23.2020.02.17.23.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 23:00:22 -0800 (PST)
Subject: Re: [PATCH v5 41/79] hppa: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-42-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <165d8d50-9980-cdc6-c583-640569206745@redhat.com>
Date: Tue, 18 Feb 2020 08:00:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-42-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 4A2g0PXHNh2jkwFjPV8MLQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de, rth@twiddle.net
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
> ---
> CC: rth@twiddle.net
> CC: deller@gmx.de
> ---
>   hw/hppa/machine.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index d8755ec422..67181e75ba 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -71,14 +71,11 @@ static void machine_hppa_init(MachineState *machine)
>       uint64_t kernel_entry =3D 0, kernel_low, kernel_high;
>       MemoryRegion *addr_space =3D get_system_memory();
>       MemoryRegion *rom_region;
> -    MemoryRegion *ram_region;
>       MemoryRegion *cpu_region;
>       long i;
>       unsigned int smp_cpus =3D machine->smp.cpus;
>       SysBusDevice *s;
>  =20
> -    ram_size =3D machine->ram_size;
> -
>       /* Create CPUs.  */
>       for (i =3D 0; i < smp_cpus; i++) {
>           char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
> @@ -97,10 +94,8 @@ static void machine_hppa_init(MachineState *machine)
>           error_report("RAM size is currently restricted to 3GB");
>           exit(EXIT_FAILURE);
>       }
> -    ram_region =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
> -                                         "ram", ram_size);
> -    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
> +    memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1)=
;
> +
>  =20
>       /* Init Lasi chip */
>       lasi_init(addr_space);
> @@ -298,6 +293,7 @@ static void machine_hppa_machine_init(MachineClass *m=
c)
>       mc->is_default =3D 1;
>       mc->default_ram_size =3D 512 * MiB;
>       mc->default_boot_order =3D "cd";
> +    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("hppa", machine_hppa_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


