Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5772EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281A12081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiMsuU/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281A12081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroLK-0005S4-6A
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iroBC-0007sa-M6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iroB8-0007o3-Ig
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:18:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iroB8-0007mP-FP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579115890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHzYjqVTnAwixztFu7z1kbWDzci633cZIYmwB/CDKAI=;
 b=BiMsuU/DWmxx88HZgZjtnIuibdcPUEUOis0OazZspaQYuxTnwC8T9oRQ6L4aUruoEI7r83
 YywSIpAT6N+acooZjET8FDnMr3EQJPbA0bAuCHozVShN7WsQp/F3jNOr2EJQZ25LAB52xi
 Uf5tO5hkcFYQUA+/6EFz5wbjttBy8W4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-tUFBbwhXMnauiIP7twHr7Q-1; Wed, 15 Jan 2020 14:18:06 -0500
Received: by mail-wr1-f70.google.com with SMTP id u12so8342196wrt.15
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i4YATXztQZOZ/x4C/L2US+OKK9XL0+Zvc8nEnaJFZKY=;
 b=d2WAdPbxc7Tp0rB2lqG4rig3usCRLnwIDS2u0e/Ywp592sdaV3atk9JWtBg3tS39gz
 tEO8hTmuX9cqOYwx/CHDpCktY1e7W+f08QBTOld2Xv7eIMFDqMBihSqmAmm+WUqGM7fY
 EFaVwTIVR+DCMnrmVRljq+bSWTG4ksBRtwDU3BKiQhGMal9BCksPkPtM0Zb/Bhs5UqiP
 5zYPuqklTGoZLnQixT3zbnA/bKJwpqJNEwWSUmmAHmCEvMff6UWqeLGgHZLT6+OOBJKw
 sY5ovMUowiF0/1sS+NEOSV+f2Ejr9LMg9BTC+Eep7LJHgXQ6kc7MSF5rHSABlbUtxEO8
 i1gA==
X-Gm-Message-State: APjAAAVvSGVkarrRQANZtDKfnWXa6HVRA7v2IX6zshyJHcPqAwpzcFdD
 3BkBQkQkw5w8zWK8jRa4teshKNPZP3KUL783xpuycvRtnDyj/wH6jRceLSshKEUngeqTZRq2kFP
 7qdC1X7erHFlmJ14=
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr1527508wmd.167.1579115885563; 
 Wed, 15 Jan 2020 11:18:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoA8RzwP+cWjERN3BVnv1BIww9HaSvF/gEGTi7vuW6ObBr/O9a808intlQjhlxM3ZGDuJHUw==
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr1527477wmd.167.1579115885384; 
 Wed, 15 Jan 2020 11:18:05 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id h2sm27064873wrt.45.2020.01.15.11.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:18:04 -0800 (PST)
Subject: Re: [PATCH v2 16/86] arm:imx25_pdk: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-17-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d636889a-2400-8bf6-c236-3ea1433cf354@redhat.com>
Date: Wed, 15 Jan 2020 20:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-17-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: tUFBbwhXMnauiIP7twHr7Q-1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, jcd@tribudubois.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:06 PM, Igor Mammedov wrote:
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
> CC: jcd@tribudubois.net
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/imx25_pdk.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index a2b7b35..9087fcb 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -58,7 +58,6 @@
>  =20
>   typedef struct IMX25PDK {
>       FslIMX25State soc;
> -    MemoryRegion ram;
>       MemoryRegion ram_alias;
>   } IMX25PDK;
>  =20
> @@ -84,10 +83,8 @@ static void imx25_pdk_init(MachineState *machine)
>           exit(EXIT_FAILURE);
>       }
>  =20
> -    memory_region_allocate_system_memory(&s->ram, NULL, "imx25.ram",
> -                                         machine->ram_size);
>       memory_region_add_subregion(get_system_memory(), FSL_IMX25_SDRAM0_A=
DDR,
> -                                &s->ram);
> +                                machine->ram);
>  =20
>       /* initialize the alias memory if any */
>       for (i =3D 0, ram_size =3D machine->ram_size, alias_offset =3D 0;
> @@ -107,7 +104,8 @@ static void imx25_pdk_init(MachineState *machine)
>  =20
>           if (size < ram[i].size) {
>               memory_region_init_alias(&s->ram_alias, NULL, "ram.alias",
> -                                     &s->ram, alias_offset, ram[i].size =
- size);
> +                                     machine->ram,
> +                                     alias_offset, ram[i].size - size);
>               memory_region_add_subregion(get_system_memory(),
>                                           ram[i].addr + size, &s->ram_ali=
as);
>           }
> @@ -135,6 +133,7 @@ static void imx25_pdk_machine_init(MachineClass *mc)
>       mc->desc =3D "ARM i.MX25 PDK board (ARM926)";
>       mc->init =3D imx25_pdk_init;
>       mc->ignore_memory_transaction_failures =3D true;
> +    mc->default_ram_id =3D "imx25.ram";
>   }
>  =20
>   DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


