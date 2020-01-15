Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD53C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF8D207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxXsI7qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF8D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iro26-0004Jw-8k
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iro12-0003TP-MZ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iro0y-00007b-NU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:07:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iro0y-000066-JN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579115259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTf/X9JRU1S5mb/cQiyKrPQrCvNfEz5GOFJu6fVFXwU=;
 b=LxXsI7qZfZqoH6UulbyjmyQae7jJGHgSKR48VF4eVA7IeJUPLdGToBHNqzDt9fCd3uDBVO
 KWSAymeip5x73tkSxWyB8CwAmtMI6+hIBFSeyuoZD/H2dJ7OwBw9K0pBy1ciSAys8SBHwq
 qO487xGkpQaQlgeCV6nMJ7ugdzxrqzU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-sSkI_7zKNb6eRwTm9MCcmA-1; Wed, 15 Jan 2020 14:07:37 -0500
Received: by mail-wr1-f70.google.com with SMTP id h30so8325566wrh.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZPXg09kSF/iW30BhuqrDyViJr5YAO5qJXilf3ProNx4=;
 b=JaCczz8bvq7PwybJzARBMjcFjs7SBHcgCN7+AeRU2T7wvkiUUAth3YY+o6mhw9V33w
 miOkMJ733+wNeSqoF/EsfEQVp80hTn2B/0FT5UDXhRJUJhvpD+ZYX7O3mwhih7desxM6
 Cbf3KuWtt806lcEaia+Sqq17cqYDNvFDaPmBcaAE2qiVtMT9yX0ymB7FdEAlUSDXBj+s
 5NXAI4NiBEPpJqJLRH1iswWqtZd1SKE2AGE0XKtsz5aKhEgwKkq9kc45pqJfco58rp2J
 BRHbdlqlgMCz0Q3rAo3+0VWxbzFKbKqyZTQiC8hPf58W7wi5JcyjDw8jQUxjIKeL2Ts+
 7v5A==
X-Gm-Message-State: APjAAAVuvwAJF7Zy4Js5NPmyS41T2Y2M2NiLRHcO/PUw9mmzUZibmZDs
 Uh22RUKjA5gbg6HY+z0j9yur7FnKDBHZsVJ/XE+rinMI07YM/BMSGl3juarCJFXWD6yYI1CViIB
 0YyipOHGH84NhiAA=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr32720256wrp.1.1579115256438; 
 Wed, 15 Jan 2020 11:07:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/K/ojuc5XG32+R26oxU202yEfxHZKIXbzKB1WG+wuzx1nD7Pi+Vs+jHVPzWohWRVE8DlcuQ==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr32720229wrp.1.1579115256112; 
 Wed, 15 Jan 2020 11:07:36 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id p7sm964604wmp.31.2020.01.15.11.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:07:35 -0800 (PST)
Subject: Re: [PATCH v2 28/86] arm:raspi: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-29-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b2162130-041f-e709-a33d-56c0beb880b9@redhat.com>
Date: Wed, 15 Jan 2020 20:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-29-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: sSkI_7zKNb6eRwTm9MCcmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Andrew.Baumann@microsoft.com
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
> PS:
>   remove no longer needed RasPiState
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Andrew.Baumann@microsoft.com
> CC: philmd@redhat.com
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/raspi.c | 34 +++++++++++++---------------------
>   1 file changed, 13 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 6a510aa..33ace66 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -32,11 +32,6 @@
>   /* Table of Linux board IDs for different Pi versions */
>   static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3]=
 =3D 0xc44};
>  =20
> -typedef struct RasPiState {
> -    BCM283XState soc;
> -    MemoryRegion ram;
> -} RasPiState;
> -
>   static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info=
)
>   {
>       static const uint32_t smpboot[] =3D {
> @@ -166,7 +161,7 @@ static void setup_boot(MachineState *machine, int ver=
sion, size_t ram_size)
>  =20
>   static void raspi_init(MachineState *machine, int version)
>   {
> -    RasPiState *s =3D g_new0(RasPiState, 1);
> +    Object *soc;
>       uint32_t vcram_size;
>       DriveInfo *di;
>       BlockBackend *blk;
> @@ -179,30 +174,26 @@ static void raspi_init(MachineState *machine, int v=
ersion)
>           exit(1);
>       }
>  =20
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> -                            version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM28=
36,
> -                            &error_abort, NULL);
> +    soc =3D object_new(version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM2836);
> +    object_property_add_child(OBJECT(machine), "soc", soc, &error_fatal)=
;
>  =20
> -    /* Allocate and map RAM */
> -    memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram"=
,
> -                                         machine->ram_size);
>       /* FIXME: Remove when we have custom CPU address space support */
> -    memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram,=
 0);
> +    memory_region_add_subregion_overlap(get_system_memory(), 0,
> +                                        machine->ram, 0);
>  =20
>       /* Setup the SOC */
> -    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ra=
m),
> +    object_property_add_const_link(soc, "ram", OBJECT(machine->ram),
>                                      &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled=
-cpus",
> +    object_property_set_int(soc, machine->smp.cpus, "enabled-cpus",
>                               &error_abort);
>       int board_rev =3D version =3D=3D 3 ? 0xa02082 : 0xa21041;
> -    object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
> -                            &error_abort);
> -    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_a=
bort);
> +    object_property_set_int(soc, board_rev, "board-rev", &error_abort);
> +    object_property_set_bool(soc, true, "realized", &error_abort);
>  =20
>       /* Create and plug in the SD cards */
>       di =3D drive_get_next(IF_SD);
>       blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
> -    bus =3D qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
> +    bus =3D qdev_get_child_bus(DEVICE(soc), "sd-bus");
>       if (bus =3D=3D NULL) {
>           error_report("No SD bus found in SOC object");
>           exit(1);
> @@ -211,8 +202,7 @@ static void raspi_init(MachineState *machine, int ver=
sion)
>       qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
>       object_property_set_bool(OBJECT(carddev), true, "realized", &error_=
fatal);
>  =20
> -    vcram_size =3D object_property_get_uint(OBJECT(&s->soc), "vcram-size=
",
> -                                          &error_abort);
> +    vcram_size =3D object_property_get_uint(soc, "vcram-size", &error_ab=
ort);
>       setup_boot(machine, version, machine->ram_size - vcram_size);
>   }
>  =20
> @@ -233,6 +223,7 @@ static void raspi2_machine_init(MachineClass *mc)
>       mc->min_cpus =3D BCM283X_NCPUS;
>       mc->default_cpus =3D BCM283X_NCPUS;
>       mc->default_ram_size =3D 1 * GiB;
> +    mc->default_ram_id =3D "ram";
>       mc->ignore_memory_transaction_failures =3D true;
>   };
>   DEFINE_MACHINE("raspi2", raspi2_machine_init)
> @@ -255,6 +246,7 @@ static void raspi3_machine_init(MachineClass *mc)
>       mc->min_cpus =3D BCM283X_NCPUS;
>       mc->default_cpus =3D BCM283X_NCPUS;
>       mc->default_ram_size =3D 1 * GiB;
> +    mc->default_ram_id =3D "ram";
>   }
>   DEFINE_MACHINE("raspi3", raspi3_machine_init)
>   #endif
>=20

This patch diverges a lot from my current work:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg653818.html
So I'm not very happy about it. Maybe my bad I should ping more=20
aggressively my patches. I can respin mine preparing for your series on top=
.

Meanwhile if you are in a hurry I tested yours, so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


