Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89787C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593202077B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSFeEtj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593202077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iro3w-0005jR-Hh
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iro2i-0004uH-28
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iro2e-00014p-Hg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:09:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iro2e-00014D-EA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579115363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3WGN4h8twIwKSxPpWaiTigZEDCjxkpd0VlpwKYxcBE=;
 b=TSFeEtj1q+ZJ2sfyIbqQNpX4QQojPcBlafWqy0R8V4gks6JfRqcZcxHHJsbz2VrxlBEY9A
 8aaFTqvztVtC4cUrvimAqNwTCeKYEdmmxua2/VY+ofUUHhgPdK2q4HTkhd4GN215oMwplR
 5F+wsZLrIlgCbbAdVREzmOaSJKaZ7eg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-DVzSy87EM7yffOi7aByeeQ-1; Wed, 15 Jan 2020 14:09:22 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so8302311wrm.17
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IOIIOP4rckx4/aEwrE2xI1uhnc1Zmv7Ec+8ItoMmb9w=;
 b=iviP/ETVOxICQ1U7iJtdRGfXXc4DQDhILI3i31RWbc9toxkpX+zLhzjeZEFnLIvcXX
 dBgU/70JuIxDxID4Cb2iTRTFUN96ulkyGUOe438UZDKnIDrInc6x6J+eDBykAcMCBmJ+
 N+2ibZOHAwYzgH4YzsdjUF+uEGn+2DZCR4S1Vvss702VyQJvmBzo0/dOQ9OqZMiVI1A0
 eaQrK9KtsoW7k9T/MEWsJbq6TsYH4vkb1WWbIB3FqdnAd8hq5tACFKD7MbB1zeviy3OY
 ONEGKncgmhNJYnI33q5iZDqaS+kpSn4e4oqLqgEpmZxcd/ZagBdH+Rs55iQY6VOUWCJr
 UvhA==
X-Gm-Message-State: APjAAAVPCoRBzrKWdBobqv6etx/o0d4qMdYopdlBBcGlnOW/DbaoIwTR
 2D21IHEA4I9xp3/raRI+7pCGiPpsnEdcm2IvM0sVjA1N3f7iiCfZA94qV5PoW+EqzPVdr91d1qJ
 kMwgtX9DTlbJflgc=
X-Received: by 2002:a5d:4752:: with SMTP id o18mr32072563wrs.330.1579115361662; 
 Wed, 15 Jan 2020 11:09:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUs2V9DCICi8sx2HG4hyI22je96j8k5kQ2g6r1n+F0MMSG2brRhMfilsbBhPmbTn8fdLgrsg==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr32072546wrs.330.1579115361431; 
 Wed, 15 Jan 2020 11:09:21 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id l19sm992600wmj.12.2020.01.15.11.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:09:20 -0800 (PST)
Subject: Re: [PATCH v2 30/86] arm:sbsa-ref: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-31-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <604df138-113a-1067-628a-9ea6506e60bf@redhat.com>
Date: Wed, 15 Jan 2020 20:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-31-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: DVzSy87EM7yffOi7aByeeQ-1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 radoslaw.biernacki@linaro.org, leif.lindholm@linaro.org
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
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> CC: radoslaw.biernacki@linaro.org
> CC: leif.lindholm@linaro.org
> ---
>   hw/arm/sbsa-ref.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9b5bcb5..1cba9fc 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -593,7 +593,6 @@ static void sbsa_ref_init(MachineState *machine)
>       MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>       MemoryRegion *sysmem =3D get_system_memory();
>       MemoryRegion *secure_sysmem =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       bool firmware_loaded;
>       const CPUArchIdList *possible_cpus;
>       int n, sbsa_max_cpus;
> @@ -685,9 +684,8 @@ static void sbsa_ref_init(MachineState *machine)
>           object_unref(cpuobj);
>       }
>  =20
> -    memory_region_allocate_system_memory(ram, NULL, "sbsa-ref.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base, =
ram);
> +    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base,
> +                                machine->ram);
>  =20
>       create_fdt(sms);
>  =20
> @@ -785,6 +783,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void=
 *data)
>       mc->block_default_type =3D IF_IDE;
>       mc->no_cdrom =3D 1;
>       mc->default_ram_size =3D 1 * GiB;
> +    mc->default_ram_id =3D "sbsa-ref.ram";
>       mc->default_cpus =3D 4;
>       mc->possible_cpu_arch_ids =3D sbsa_ref_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props =3D sbsa_ref_cpu_index_to_props;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


