Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DF32464E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQSgyMdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DF32464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46wd-0008Dt-EK
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46vf-0006zd-Fx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46ve-0001m4-FQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:45:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46ve-0001lb-BW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ajW1Fyk2Ov8U4uTT8lz1hEuzDYyQ6izmcqc12NXpMoI=;
 b=gQSgyMdFeCkGkns6YzJFQNjs9fC7I26NXIPymOLdECeBxIeZouMdWlGfyBd1MGPB7TPVAs
 aiT/vA/lHHZNXAxWSlSseefi5nb0sekc3kdV7riCvueipjEADYshrTeWUXnXx3M47I77H3
 PkvEtckk+B/XhaXNNWs0F8MgH1FjXco=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-07sW1Du6P_-EspvRhNbC6Q-1; Tue, 18 Feb 2020 12:44:58 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so11191241wrb.21
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fToSNVNPoZDWV871jo8/roDXr7RXxL/91bwO2IWCLB4=;
 b=BZrg3LD4+bFcyO2k8x6aWavStcYyhhLt+1zrsS9HG2nxpaWfUF/YCgr52/Sa5yoZ/6
 4HWPG9gKhIuxky+qSrq4RLLPJs8lW/2o7FS7D7kPEv0uyDQgOJRSn7QTeoNCXbm/pGTp
 UQOBbNhsRZRDmysQw7A+z/jjKKVKxvrqzGjoSwpvgsrxTfldzcO5T0ESrdX5+BcUQabe
 OXUvNDD7y/7NnMgqe2uc7QI9y8hYDasOiQSMrD4GLxmrBTB/xRkNRFMpUwbb1RgynvEI
 4HboWmnKLvlT67Djwo5/nymTRGRSBF8N/luRwgafucv6uVXUfEt+j1zEmqGLl+T7gBgr
 ryXQ==
X-Gm-Message-State: APjAAAVyL5TWZzucCh5EHqbIaVKs4vsizL5GOcCJI3dg+pkQ5Yhlrswx
 DPfiGuWyPMTN17FNgU3jjcTdZc2VzRbuMbCyE+4MAmEqGKcl/oBWdQZWqrnEqtA1RpFFwIw+IrM
 2h0YoMiqF/twTkow=
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr4441047wmd.48.1582047897107; 
 Tue, 18 Feb 2020 09:44:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJ0pC1jKethqoEK4xvAni8mzM13xuZMSu11yCu1KkV8gyPoxF7UXuT2ENV/h/asU4DhHnA3A==
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr4441034wmd.48.1582047896861; 
 Tue, 18 Feb 2020 09:44:56 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id k10sm7121977wrd.68.2020.02.18.09.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:44:56 -0800 (PST)
Subject: Re: [PATCH v5 46/79] m68k/an5206: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-47-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bfa9fb49-8330-f6fb-9f5f-8d0ab2f7a6d9@redhat.com>
Date: Tue, 18 Feb 2020 18:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-47-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 07sW1Du6P_-EspvRhNbC6Q-1
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
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/m68k/an5206.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index bed43a936d..846f4e40c6 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -33,7 +33,6 @@ static void an5206_init(MachineState *machine)
>       uint64_t elf_entry;
>       hwaddr entry;
>       MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *sram =3D g_new(MemoryRegion, 1);
>  =20
>       cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
> @@ -46,8 +45,7 @@ static void an5206_init(MachineState *machine)
>       env->rambar0 =3D AN5206_RAMBAR_ADDR | 1;
>  =20
>       /* DRAM at address zero */
> -    memory_region_allocate_system_memory(ram, NULL, "an5206.ram", ram_si=
ze);
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>  =20
>       /* Internal SRAM.  */
>       memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal=
);
> @@ -89,6 +87,7 @@ static void an5206_machine_init(MachineClass *mc)
>       mc->desc =3D "Arnewsh 5206";
>       mc->init =3D an5206_init;
>       mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m5206");
> +    mc->default_ram_id =3D "an5206.ram";
>   }
>  =20
>   DEFINE_MACHINE("an5206", an5206_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


