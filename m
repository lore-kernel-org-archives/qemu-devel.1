Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF2CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1252089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Ow13Q3JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1252089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMS8i-0000Yu-NA
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 03:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@posteo.de>) id 1iMS75-0007wH-Iy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@posteo.de>) id 1iMS73-0000aB-Ee
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:28:22 -0400
Received: from mout02.posteo.de ([185.67.36.66]:42913)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1iMS73-0000Zv-4x
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:28:21 -0400
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 7140E240112
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1571642899; bh=5yVpQvIyiHTnN1VO9do0v9PUCUM+2Iy9l7cE6Mrk9b0=;
 h=Subject:To:Cc:From:Date:From;
 b=Ow13Q3JWjwUpiuJdQ/ISRp4HI3S7+nBNTJGWMZJJ7oHKDWFT5izk5RJ7uMIE/e5wU
 Q3xdkz8vF+EH59Pjk3hkhQwmKRe6MKQpiA1ElgDbQAsN9wbtyp0ua5aQZRnb+RFPcX
 N76ADFMB1S8x3jKwE1aCUhjEINy1Z0iPVzjIC317MK5Pc3l0CISxzI4hoh78rLdWnq
 7JZl+B/v4wNBEIKvPV3dBPQ3JUSnNBCZoUFuSkTYMK+LLoaqx8xXKCHo8sHMfcnMYG
 f6ic0qb72HGAqnGlKd/HQfoepMp0djtTQ6HlvBz8mApbTiMJMf4MeaeXKz34GgJPgB
 6HAbM3YZDBESg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 46xSsj5GJdz9rxD;
 Mon, 21 Oct 2019 09:28:09 +0200 (CEST)
Subject: Re: [PATCH 17/21] hw/m68k: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-18-philmd@redhat.com>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <55d66ac3-106a-0be1-626b-b8f9457bb96d@posteo.de>
Date: Mon, 21 Oct 2019 09:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-18-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.67.36.66
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2019 00.56, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/m68k/an5206.c    | 2 +-
>  hw/m68k/mcf5208.c   | 2 +-
>  hw/m68k/next-cube.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 54ccbe1a82..fb045c2436 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -46,7 +46,7 @@ static void an5206_init(MachineState *machine)
>      env->rambar0 =3D AN5206_RAMBAR_ADDR | 1;
> =20
>      /* DRAM at address zero */
> -    memory_region_allocate_system_memory(ram, NULL, "an5206.ram", ram_=
size);
> +    memory_region_allocate_system_memory(ram, machine, "an5206.ram", r=
am_size);
>      memory_region_add_subregion(address_space_mem, 0, ram);
> =20
>      /* Internal SRAM.  */
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 34d34eba17..8e8c8ef349 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -248,7 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
>      memory_region_add_subregion(address_space_mem, 0x00000000, rom);
> =20
>      /* DRAM at 0x40000000 */
> -    memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram=
_size);
> +    memory_region_allocate_system_memory(ram, machine, "mcf5208.ram", =
ram_size);
>      memory_region_add_subregion(address_space_mem, 0x40000000, ram);
> =20
>      /* Internal SRAM.  */
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index e5343348d0..6aed9376f3 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -893,7 +893,7 @@ static void next_cube_init(MachineState *machine)
>      memcpy(ns->rtc.ram, rtc_ram2, 32);
> =20
>      /* 64MB RAM starting at 0x04000000  */
> -    memory_region_allocate_system_memory(ram, NULL, "next.ram", ram_si=
ze);
> +    memory_region_allocate_system_memory(ram, machine, "next.ram", ram=
_size);
>      memory_region_add_subregion(sysmem, 0x04000000, ram);
> =20
>      /* Framebuffer */
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>

