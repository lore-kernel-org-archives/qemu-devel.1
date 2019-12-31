Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970A6205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivQsWWJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970A6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK3Y-0007tU-QE
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK2S-0006hi-1L
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK2Q-0007H2-Ul
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:06:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK2Q-0007EG-Oo
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHuCRDK8vlPbAhW9UywM135wmsiIa6GjvQJc9iqeqK8=;
 b=ivQsWWJFy52jQyK9sX6qMJx5AU3OSwMv4ZD7IDGJ1osaN2ngpHqijlZuUmMvoUDBeLIDYg
 XV5Eqrjv1rctZQjCL5tlnNES64jr8J7Qx63KdfYWNgxonYwqQzVj3+e8megfk4C2sE5u/l
 JzTY6GaUfW05ZiI3KTrrhTFpBUL4nsY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-cHOlsSX0P0iClm4F6l2CLA-1; Tue, 31 Dec 2019 11:06:27 -0500
Received: by mail-wr1-f70.google.com with SMTP id f10so10952871wro.14
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K5R/21eo+OUUZ0xEDsEiDlZcwkJSCMpay3FvOGsZkek=;
 b=TPQICqUGDSlO6m1lSKjvhFAhtqCQr9pYyjCKX2u3Cxt+jKuXnfOG1QDSx5nnR5+SNm
 uv1puVKwbkYc1t2Wp5MklF8UWzxTtHRIvjZy0UqGcus5BE7fyuVeCHw3y+x/UIBmPiCB
 ZzjGr7NwqoFYrcLeZL2Uc0D5cfcnCG+fB71r51gY1UmdUduHkJk5iUVnUepOqoDni2rJ
 3bD95LFgnfFAklvVz1codTJNkd+nayUJ4hMCXzkSjlM1TvoV5/ZrQSC6O3SENlsOd0IU
 eprlYxLm4QWj4lSirWlXEq/WyRS4ngnkcA+z4grnhENriOamImNpBIQo9h+SG/1oLTV+
 6dCw==
X-Gm-Message-State: APjAAAWuCqZudGNhRQsHPir9dWki4JpW7PvyBXd9/sOgjr6jmoBmUU63
 HXeKdeY5WUUb2sW4WWp9/5wtZmgGqxif15iWEFKeIOSaYCnSqBsXJS0RznI9VZ1i1v9DQfsJAkI
 Nj5u5GaRHZTn5mXc=
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr73220415wrr.104.1577808386755; 
 Tue, 31 Dec 2019 08:06:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFRw72cKImCy9ScqoFEIfAUKxDBvDaxkP7KIICvnQb5d0fOmQl/ayCvUK4Va4aa/Hh3RlSWA==
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr73220394wrr.104.1577808386520; 
 Tue, 31 Dec 2019 08:06:26 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id u16sm2881258wmj.41.2019.12.31.08.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:06:26 -0800 (PST)
Subject: Re: [PATCH 55/86] mips:mips_jazz: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-56-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b3d8fe67-0980-71cb-e5f4-99f65dd6342c@redhat.com>
Date: Tue, 31 Dec 2019 17:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-56-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: cHOlsSX0P0iClm4F6l2CLA-1
X-Mimecast-Spam-Score: 0
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

> ---
>   hw/mips/mips_jazz.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 291fd6c..5136388 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -159,7 +159,6 @@ static void mips_jazz_init(MachineState *machine,
>       ISABus *isa_bus;
>       ISADevice *pit;
>       DriveInfo *fds[MAX_FD];
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>       MemoryRegion *bios2 =3D g_new(MemoryRegion, 1);
>       SysBusESPState *sysbus_esp;
> @@ -191,9 +190,7 @@ static void mips_jazz_init(MachineState *machine,
>       cc->do_transaction_failed =3D mips_jazz_do_transaction_failed;
>  =20
>       /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(address_space, 0, ram);
> +    memory_region_add_subregion(address_space, 0, machine->ram);
>  =20
>       memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SI=
ZE,
>                              &error_fatal);
> @@ -392,6 +389,7 @@ static void mips_magnum_class_init(ObjectClass *oc, v=
oid *data)
>       mc->init =3D mips_magnum_init;
>       mc->block_default_type =3D IF_SCSI;
>       mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
> +    mc->default_ram_id =3D "mips_jazz.ram";
>   }
>  =20
>   static const TypeInfo mips_magnum_type =3D {
> @@ -408,6 +406,7 @@ static void mips_pica61_class_init(ObjectClass *oc, v=
oid *data)
>       mc->init =3D mips_pica61_init;
>       mc->block_default_type =3D IF_SCSI;
>       mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
> +    mc->default_ram_id =3D "mips_jazz.ram";
>   }
>  =20
>   static const TypeInfo mips_pica61_type =3D {
>=20


