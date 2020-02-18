Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CFCC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABED22B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvVw6n0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABED22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46k5-0002Vw-Lg
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46hk-0007nv-QV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46hj-00007h-6n
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:30:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46hj-00006v-2g
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5SJemMKMVJSIgqV6wCQezkwidOZiZSC8/oSUJOrCrk=;
 b=YvVw6n0P5HXQGXWZHd36mEDynC0VfviJ6JoPZWvFL73G3DH2u4YZ082F7iw6+IlC+2sMrz
 33t1y7J4VZmuABOZaWOsyJ6yDCuzWOud2piiEIPQZkdnVrwY3PvvuDoygNRTEjgQ1JzkZk
 WPXrL6G0LT+FXzw/ScQezjdZWRohITE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-TjXlEDmVNP-XFnx7GKZ2vA-1; Tue, 18 Feb 2020 12:30:36 -0500
Received: by mail-wm1-f69.google.com with SMTP id b205so365932wmh.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G8e3733M+aXIX6rmZBhB+cRGXPRQsGgiibjDcdqhXUI=;
 b=BH7v2U7p5q5XrKxiyCpv06nIgcAibTgHNlhlr50J+HusaOgu9z4CRDKjO8QmDEimpP
 RPk76pn6q3ANjlm/DEDDwcdBvZsYZM1jXh7/uuB9gNupsNMPqw6Wf+jnR/B6Sn3AB1or
 FAKi4+GcRIyh7CG4Jo/yhmOUBMIH6qAzOGUWUCDI9oGYZglIL1dSwiDVIPMhXaCv7QQm
 lcQIu/INW0YuSlkWADh53MUB4x2RncqUWhCWUmmFGubhZp/QgrLu+IKfaiVS824iQqJp
 gbamoRhv2TUyp72oVZxaszK9OVsUtvkUykMPz4fPmlu4/59ApSdSBpgeVMyPd4hZj1vQ
 YKMQ==
X-Gm-Message-State: APjAAAU/nCUV64kyR2MRz8fhj2CPLs8dcxbnZdCAFB5Lp+yrU34HcWQF
 QTe2JDY0RTUClmxJ3mS39y5wz3juyqE69Cah2LdXSllMBgCjh4E8TYCff5KLXk7QVEAbprcPxwQ
 PpQrM2tJ81zLkW2o=
X-Received: by 2002:adf:ec84:: with SMTP id z4mr30345872wrn.61.1582047035136; 
 Tue, 18 Feb 2020 09:30:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzynjTXzZVSluggTBTEvNezHEis9Hl92S1bLfTMeva7ATQKaxPHEO9KEbY16PsAN8/Vj03E8Q==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr30345861wrn.61.1582047034968; 
 Tue, 18 Feb 2020 09:30:34 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id e18sm6786366wrw.70.2020.02.18.09.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:30:34 -0800 (PST)
Subject: Re: [PATCH v5 67/79] ppc/spapr: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-68-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bcdedada-0bd0-6cfa-e525-3b4c01452c93@redhat.com>
Date: Tue, 18 Feb 2020 18:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-68-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: TjXlEDmVNP-XFnx7GKZ2vA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/ppc/spapr.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c9b2e0a5e0..4d90f99195 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2634,7 +2634,6 @@ static void spapr_machine_init(MachineState *machin=
e)
>       PCIHostState *phb;
>       int i;
>       MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       hwaddr node0_size =3D spapr_node0_size(machine);
>       long load_limit, fw_size;
>       char *filename;
> @@ -2813,10 +2812,8 @@ static void spapr_machine_init(MachineState *machi=
ne)
>           kvmppc_enable_h_page_init();
>       }
>  =20
> -    /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_spapr.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    /* map RAM */
> +    memory_region_add_subregion(sysmem, 0, machine->ram);
>  =20
>       /* always allocate the device memory information */
>       machine->device_memory =3D g_malloc0(sizeof(*machine->device_memory=
));
> @@ -4400,6 +4397,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       mc->no_parallel =3D 1;
>       mc->default_boot_order =3D "";
>       mc->default_ram_size =3D 512 * MiB;
> +    mc->default_ram_id =3D "ppc_spapr.ram";
>       mc->default_display =3D "std";
>       mc->kvm_type =3D spapr_kvm_type;
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRID=
GE);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


