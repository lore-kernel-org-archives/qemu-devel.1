Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F62206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqJqzBzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F62206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imJzY-0003m0-CE
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imJyb-0002mS-VL
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imJya-0008IZ-Bh
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:02:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imJya-0008CU-3u
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRd8++Y6YR3NLb7R1c6KQFMFIBbNJh9aBz0+RTN1ojk=;
 b=GqJqzBzNrqcErhMj2tr3m6VmmLQaJlkU+bFLC+lcWtNB6yJ3pKm6mxIKXogLVw5kxsF+5x
 kKPZub3wqXJvUk4P8HAivH8AR+IFnDLmFuY4DoqjT/PpdhtRJ7ol0iZihxynTT7ABj9Te+
 2wwm3kHe1q4Zyz9lwj8vw7DEolggaWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-NvPvY1irNv-VDlmPU6LAcw-1; Tue, 31 Dec 2019 11:02:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so19382363wrs.4
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A5kCfPHbBerGyo6LiukVekJu0OGdiIanjYStsNHd288=;
 b=VVyDR0O5U29X3aHGFmDYC3KDP+a69/Dm8gCwJmW88zQMzAEcQw1Z6kuKWORmWDYz6b
 ESjCIA5t1Iq2u6ddCY+GjGJGBIotIqk5jlXkv1yIeIhM/0P6XV3qZEDJbEhqAFWsX1M+
 v6HZ8lnM067USUME/z7Bmw2C54IKfGFuizij1pDB50j/O/a8XjEoqiMIgFjogbSE917L
 XytEPDpwShlJEc1G+9mNeVZt5BL/biaxf0TF0S/eeDSw906Anh/NDiQ6dnWpq8t1Q7Yo
 FjW5ec//yMiKKbZjajl8E1bFpYwvPlRJ8R+JpMVimVKE40pO+4Kgq1t4gQyIO1vXCCMx
 Qdjw==
X-Gm-Message-State: APjAAAVgR3uWe8Z6AV/TROY5vQod9MMgksx0JYv/9j11vZGcn4I+gnZB
 chajY+Ul20ED21EH1cmYKgZKo5jBV/p25EWELS5ff0HXPUU1KU4a+A4l5zxLrY220iLWt5TxIGS
 7YYsiGHy2ElbA0Pg=
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr69050212wrm.338.1577808147737; 
 Tue, 31 Dec 2019 08:02:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaonArj4YVOcXtYJUoXGEJRNq8qlloGp9s5+eLbI8Z+6iAhviLzUgf7/xQhg8Q6XGz6j7dgg==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr69050191wrm.338.1577808147571; 
 Tue, 31 Dec 2019 08:02:27 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id u18sm49185392wrt.26.2019.12.31.08.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:02:26 -0800 (PST)
Subject: Re: [PATCH 72/86] sparc:leon3: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-73-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb52ec44-a45c-7ae8-2eb0-5cffd3db5ee6@redhat.com>
Date: Tue, 31 Dec 2019 17:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-73-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: NvPvY1irNv-VDlmPU6LAcw-1
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
>   hw/sparc/leon3.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index c5f1b1e..19927d1 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -184,7 +184,6 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>       SPARCCPU *cpu;
>       CPUSPARCState   *env;
>       MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *prom =3D g_new(MemoryRegion, 1);
>       int         ret;
>       char       *filename;
> @@ -244,8 +243,8 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>           exit(1);
>       }
>  =20
> -    memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram_siz=
e);
> -    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, ram=
);
> +    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET,
> +                                machine->ram);
>  =20
>       /* Allocate BIOS */
>       prom_size =3D 8 * MiB;
> @@ -351,6 +350,7 @@ static void leon3_generic_machine_init(MachineClass *=
mc)
>       mc->desc =3D "Leon-3 generic";
>       mc->init =3D leon3_generic_hw_init;
>       mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("LEON3");
> +    mc->default_ram_id =3D "leon3.ram";
>   }
>  =20
>   DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
>=20


