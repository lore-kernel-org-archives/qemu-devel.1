Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1FAC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB282464E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deW1MhxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB282464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46w6-0007VX-RV
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46vL-0006cB-KV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46vK-0001YU-H5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:44:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46vK-0001YI-DM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6m13PNqlnUt9L4IILdhJy33yggtCYrpLaPvJTbgZ+c=;
 b=deW1MhxCvp00fgJIRtHidTScEp6y0vhfnvcUReenahxwUiiPb4HnuGpGVTyOUwE2WiOy1m
 0iv6ZPjYMY4AydqWETr4U0A04gaR7CMYH4MpUMiMXM7gPIBEDi7VhoCqqSUdKOwB49d9aL
 2sRYUKRjBYZ2j8IenbAHLrW5BHj3k1Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ZVxGa00YNFOjEWrNbAa-RA-1; Tue, 18 Feb 2020 12:44:39 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so11133379wrq.12
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NLQsWrD3zJIA2RK8Rp75PKEzx9n0dFCZO6ivUORJdOg=;
 b=oVsE0IvYvyb1sj4YvRf/sjoZpJmvxVobxdcgbJG+dXmINpIb26ynwgibmGr8eHrZ97
 jkpt63UOliMZ3aux/4xQcsWh5+PXkdpHjU9fMu5ZlVkL0S5W+VjWqgRR4+XQMg4/YLV3
 /4xbDuolBKNka0t74Ngc+Hq13YuJfj3FS/WZq4SBnjKM2vNgaN1EzAa7qP8An6AvBWso
 7iCikc9U0X+TEjhT/VKTXb/xYd4OFQXU3sksSLrReDwy9Y9RIdwmXeKT1S+UBMj8pacl
 JxZAS6x6ABF/dWpMV9VRJz56c8CrXQ6cTu2nB3otsBjHXAcRME/gs7EnRWhiTX0PwTi1
 UeSQ==
X-Gm-Message-State: APjAAAWRh3FDGA9s/av/qAO1l6GV/gCeNcBro8tBikfGH/qmxaN5U98O
 lMrBX/E5rWGOHF9Z53V4ZYzuzPHDRbJagZM5IDVN1FaW3zX9EfPKMZnQ6yVOb5jUDLkDqYBA/2O
 Lt36qyP8sr2rU2VI=
X-Received: by 2002:a5d:4750:: with SMTP id o16mr29913375wrs.91.1582047878798; 
 Tue, 18 Feb 2020 09:44:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGuRU93oSAT83E3ZFACpAs9Mj/xk/p5tUcZ/sBYsPnVLomds8AqhC5mx6z8+DE6kIgDgaWlQ==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr29913361wrs.91.1582047878640; 
 Tue, 18 Feb 2020 09:44:38 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id 133sm4662099wmd.5.2020.02.18.09.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:44:38 -0800 (PST)
Subject: Re: [PATCH v5 48/79] m68k/mcf5208: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-49-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c7477c15-916d-5993-f040-0dc33b2edec5@redhat.com>
Date: Tue, 18 Feb 2020 18:44:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-49-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: ZVxGa00YNFOjEWrNbAa-RA-1
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
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/m68k/mcf5208.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index a999c21982..31622c71cb 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -234,7 +234,6 @@ static void mcf5208evb_init(MachineState *machine)
>       qemu_irq *pic;
>       MemoryRegion *address_space_mem =3D get_system_memory();
>       MemoryRegion *rom =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *sram =3D g_new(MemoryRegion, 1);
>  =20
>       cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
> @@ -249,8 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
>       memory_region_add_subregion(address_space_mem, 0x00000000, rom);
>  =20
>       /* DRAM at 0x40000000 */
> -    memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram_s=
ize);
> -    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
> +    memory_region_add_subregion(address_space_mem, 0x40000000, machine->=
ram);
>  =20
>       /* Internal SRAM.  */
>       memory_region_init_ram(sram, NULL, "mcf5208.sram", 16 * KiB, &error=
_fatal);
> @@ -354,6 +352,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
>       mc->init =3D mcf5208evb_init;
>       mc->is_default =3D 1;
>       mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m5208");
> +    mc->default_ram_id =3D "mcf5208.ram";
>   }
>  =20
>   DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


