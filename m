Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB82C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B485620702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLTs33e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B485620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzPr-0004DG-Uw
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ivzOw-0003Qv-J4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ivzOt-0001Bo-Mc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:05:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ivzOt-0001BL-JG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580112339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4TwyILvwCBucjlGCdV3QxNA8g/8gNeb9mDPlXA9bTw=;
 b=LLTs33e1sKqCyjW4JhLQp2FMhFh81PLZ2sVmEar7bZzDdN7n8PiSQR03SleMIgDo28ht3N
 0bJKoQXabwoOpEOpgryAZUsWEemxhh8+nd1jphnBVm+yi5q3dzjQf2K8/B0mUbUudl/rBb
 lP7dZynAtZFLQjCzeM3zQ4TvN4RGXVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-efDONdG5NSaiwF1M16tJUQ-1; Mon, 27 Jan 2020 03:05:37 -0500
Received: by mail-wm1-f69.google.com with SMTP id 7so1067811wmf.9
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=go/wY01rgID9owWN0mc6lu3QrVA18JBSLturnkaBcLs=;
 b=GDG4fzSIIRU/RDcFc6P15UR901HOeZ6gtZiXRJn8TdssyJ4uEciumZS1uYSFe5SQDF
 DYZNdal6lBQFfs8S5lujP/doZmFY6yQ7AS/x9M3nT7yOxNWESAVk9J5X5f2ugZYYk5Sj
 tJoAXo3i8MucZYw6k+kkCsBqMAD/96NBiMsMGSBt3W4NluVT4O3J92g96rBqFoGzaG06
 mwIMoINb13aL/+8+gxlFdwyhUA3IxcJp5k9ujjxzvzzxHW36iJJZ8MKPJ7KVlwldyCSj
 SJd/qjyjoTlXx28CkyHyRUHRnorSlrV/dxYYFiOcZxHPVOX8+T70EFXHzwaVOmTyr+Ga
 c8aw==
X-Gm-Message-State: APjAAAWzrRG53/ZMoqrpPT7r+SnfS16Q6ILG+Mk7+w/6eD4zPIxsXaFD
 QUHpHJEn8QMi/Utmjva6fGdgWxEzUETngFfp1b99QBhnapw7cTcN2kFosv8PnRI0gE9c3B60pPO
 T5yvIkPq5Ulzpu4Q=
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr12524454wmo.147.1580112336235; 
 Mon, 27 Jan 2020 00:05:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4kv9aVPsyKrDv8onaKMNh2hnIyHLv4HzDCvGXeN2mTNY6ahEq88G022GGd69tzQZBw4oT4Q==
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr12524413wmo.147.1580112335912; 
 Mon, 27 Jan 2020 00:05:35 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm18948562wrx.71.2020.01.27.00.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 00:05:35 -0800 (PST)
Subject: Re: [PATCH rc3 23/30] hw/core/loader: Let load_elf populate the
 processor-specific flags
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8205c991-73d3-b721-5e21-b29a4b12ebd9@redhat.com>
Date: Mon, 27 Jan 2020 09:05:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: efDONdG5NSaiwF1M16tJUQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Michael Rolnik <mrolnik@gmail.com>, Michael Walle <michael@walle.cc>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/26/20 11:55 PM, Aleksandar Markovic wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Some platforms (like AVR) need to determine cpu type by reading
> the ELF flags (field e_flags oin ELF header).
>=20
> This patch enables discovery of the content of that flag while
> using following functions:
>=20
>    - load_elf()
>    - load_elf_as()
>    - load_elf_ram()
>    - load_elf_ram_sym()
>=20
> The added argument of these functions is of type uint32_t*. It is
> allowed to pass NULL as that argument, and in such case no lookup
> to the field e_flags will happen, and of course, no information
> will be returned to the caller.
>=20
> CC: Richard Henderson <rth@twiddle.net>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> CC: Michael Walle <michael@walle.cc>
> CC: Thomas Huth <huth@tuxfamily.org>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Jia Liu <proljc@gmail.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: BALATON Zoltan <balaton@eik.bme.hu>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Fabien Chouteau <chouteau@adacore.com>
> CC: KONRAD Frederic <frederic.konrad@adacore.com>
> CC: Max Filippov <jcmvbkbc@gmail.com>
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> [PMD: Extracted from bigger patch,
>        Replaced 'uint32_t *pe_flags' by 'int proc_flags']
> [AM: Replaced 'int proc_flags' with 'uint32_t *pflags',
>       replaced one instance of 'elf_sword' to 'elf_word',

IIRC I used 'int' because load_elf() uses 'int' for all the other ELF=20
flags, regardless their type (except the addresses).

>       extended functionality to load_elf()]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
[...]
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 48a96cd..a9eeea3 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
>    * @pentry: Populated with program entry point. Ignored if NULL.
>    * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
>    * @highaddr: Populated with highest loaded address. Ignored if NULL.
> + * @pflags: Populated with ELF processor-specific flags. Ignore if NULL.
>    * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
>    * @elf_machine: Expected ELF machine type
>    * @clear_lsb: Set to mask off LSB of addresses (Some architectures use
> @@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
>                        uint64_t (*elf_note_fn)(void *, void *, bool),
>                        uint64_t (*translate_fn)(void *, uint64_t),
>                        void *translate_opaque, uint64_t *pentry,
> -                     uint64_t *lowaddr, uint64_t *highaddr, int big_endi=
an,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pf=
lags,
> +                     int big_endian, int elf_machine,
> +                     int clear_lsb, int data_swab,
>                        AddressSpace *as, bool load_rom, symbol_fn_t sym_c=
b);
>  =20
>   /** load_elf_ram:
> @@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,
>                    uint64_t (*elf_note_fn)(void *, void *, bool),
>                    uint64_t (*translate_fn)(void *, uint64_t),
>                    void *translate_opaque, uint64_t *pentry, uint64_t *lo=
waddr,
> -                 uint64_t *highaddr, int big_endian, int elf_machine,
> -                 int clear_lsb, int data_swab, AddressSpace *as,
> -                 bool load_rom);
> +                 uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +                 int elf_machine, int clear_lsb, int data_swab,
> +                 AddressSpace *as, bool load_rom);
>  =20
>   /** load_elf_as:
>    * Same as load_elf_ram(), but always loads the elf as ROM
> @@ -154,8 +156,9 @@ int load_elf_as(const char *filename,
>                   uint64_t (*elf_note_fn)(void *, void *, bool),
>                   uint64_t (*translate_fn)(void *, uint64_t),
>                   void *translate_opaque, uint64_t *pentry, uint64_t *low=
addr,
> -                uint64_t *highaddr, int big_endian, int elf_machine,
> -                int clear_lsb, int data_swab, AddressSpace *as);
> +                uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +                int elf_machine, int clear_lsb, int data_swab,
> +                AddressSpace *as);
>  =20
>   /** load_elf:
>    * Same as load_elf_as(), but doesn't allow the caller to specify an
> @@ -165,8 +168,8 @@ int load_elf(const char *filename,
>                uint64_t (*elf_note_fn)(void *, void *, bool),
>                uint64_t (*translate_fn)(void *, uint64_t),
>                void *translate_opaque, uint64_t *pentry, uint64_t *lowadd=
r,
> -             uint64_t *highaddr, int big_endian, int elf_machine,
> -             int clear_lsb, int data_swab);
> +             uint64_t *highaddr, uint32_t *pflags, int big_endian,
> +             int elf_machine, int clear_lsb, int data_swab);
>  =20
>   /** load_elf_hdr:
>    * @filename: Path of ELF file
>=20


