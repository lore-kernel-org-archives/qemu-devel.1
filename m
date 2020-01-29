Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16BAC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEF920708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQapl5R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEF920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhqw-0003O1-Mm
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwhq2-0002fF-PQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwhq0-0007pt-ID
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:32:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwhq0-0007pg-Dl
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580283155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qera6Z8DrttSbpfd7w+PBdjkc8OdfCwOGlwBPtsg9Ws=;
 b=bQapl5R5ZK0fBkwniaE6cs1jOTD+Zo7emy75BrnlbVF6hADrGRoEobly1ZaJWwPqOAv9R1
 hDHt90zJuhMKGW4WDq6qdmvXvT0cEtRGB5igujcAML/M/r8vpbkCmEH9qh67MEWFdu8RG2
 J7F5fDpLD5oaa6aZViBAy37Dg5idCgE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-DoFA6HBgPp6unvtDLQzvuQ-1; Wed, 29 Jan 2020 02:32:30 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so2214561wmk.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 23:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h/peJPLOig09OEh35kcFARP8+AABNdodH6zkH5eB9ug=;
 b=SFquh7mcYVX/OeBdrNNrl4pufc9CHVb7b65YkEcH+MbYI/IaRqu6EQPu2NGoBAhpuN
 PP9rCvTcbCbcs7Phei2eU26U86MtalWHMtIHT+wm0IRAit+BIBcJqTo0iE/IANaKcwz9
 mEGF2Vy4okhm/YH9Vj+VQh+bEAkX1Fy4XPg1j2KurZ7ssb8T/ZVyu0g59JxIQ5t4NvEf
 KmP44GaerMITGCNzfXFnRRTANbn36mpQgoxiMx0y86LcJ+Rtp2c7xHJ0Disn6SfxZtYy
 X+DXAlpBqWE6qvT4WOxENNfk0JiY8M/cATjliuzFc3tGzTWYyw/FwPZwM6ypKw0+HpcE
 hXtA==
X-Gm-Message-State: APjAAAVoSrmer440aGXFglv/XcMCXVxiWrSfwAfiHiVepeqpg/QWt7aq
 UusekpK86x23iSCbl7PpF9JBv8nkJFe2e61kSqwD6qQ4tUjKhP6UYkuDymgMY1j2CCeihv6ense
 aT9xc8LOyfiBw//k=
X-Received: by 2002:a1c:e388:: with SMTP id a130mr9551050wmh.176.1580283149088; 
 Tue, 28 Jan 2020 23:32:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNgjGSBhAAzwnwaBa7vdC9ngwLc6NJ/Q4QyRFY7trSkxADlzHqEUfysolXnv0Nl89ZXA6AoA==
X-Received: by 2002:a1c:e388:: with SMTP id a130mr9550988wmh.176.1580283148649; 
 Tue, 28 Jan 2020 23:32:28 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c4sm1231745wml.7.2020.01.28.23.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 23:32:28 -0800 (PST)
Subject: Re: [PATCH rc3 23/30] hw/core/loader: Let load_elf populate the
 processor-specific flags
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hG=NoQWpxQ5xOkyLM7kYpsoZOohTWU1eYr-fLp=Ud_MA@mail.gmail.com>
 <alpine.BSF.2.22.395.2001281334310.9839@zero.eik.bme.hu>
 <CAL1e-=iNBvd0eBHig==3V6Hw6tjf-A3+-QRukXeqATyvJufz8A@mail.gmail.com>
 <CAL1e-=i_NPErr=9Bag_6Ps1+5=0xAC0NKxpTnyCJVpvZ_a5veQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31a56bec-bc6c-7f05-5b96-27bde202c105@redhat.com>
Date: Wed, 29 Jan 2020 08:32:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i_NPErr=9Bag_6Ps1+5=0xAC0NKxpTnyCJVpvZ_a5veQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: DoFA6HBgPp6unvtDLQzvuQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Michael Rolnik <mrolnik@gmail.com>, Michael Walle <michael@walle.cc>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 1/28/20 8:25 PM, Aleksandar Markovic wrote:
> On Tue, Jan 28, 2020 at 2:27 PM Aleksandar Markovic=20
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
>=20
>=20
>=20
>     On Tuesday, January 28, 2020, BALATON Zoltan <balaton@eik.bme.hu
>     <mailto:balaton@eik.bme.hu>> wrote:
>=20
>         On Tue, 28 Jan 2020, Aleksandar Markovic wrote:
>=20
>             On Sunday, January 26, 2020, Aleksandar Markovic <
>             aleksandar.markovic@rt-rk.com
>             <mailto:aleksandar.markovic@rt-rk.com>> wrote:
>=20
>                 From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>                 <mailto:f4bug@amsat.org>>
>=20
>                 Some platforms (like AVR) need to determine cpu type by
>                 reading
>                 the ELF flags (field e_flags oin ELF header).
>=20
>                 This patch enables discovery of the content of that flag
>                 while
>                 using following functions:
>=20
>                  =C2=A0 - load_elf()
>                  =C2=A0 - load_elf_as()
>                  =C2=A0 - load_elf_ram()
>                  =C2=A0 - load_elf_ram_sym()
>=20
>                 The added argument of these functions is of type
>                 uint32_t*. It is
>                 allowed to pass NULL as that argument, and in such case
>                 no lookup
>                 to the field e_flags will happen, and of course, no
>                 information
>                 will be returned to the caller.
>=20
>=20
> Applied to MIPS queue, with some commit message corrections and fixes.

Sorry I didn't respond earlier, this was a very short delay (patch=20
posted yesterday, pull request sent today).

My original patch was much less intrusive:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg673762.html
I don't find comfortable being listed as the author of the current
patch. Do you mind changing the authorship?

Thank you,

Phil.

>=20
>             We plan to use this new functionality for MIPS Malta board,
>             for detection
>             of incompatible cpu/kernel combinations, and graceful exit
>             (right now these
>             combinations result in hang or crash). I would say other
>             boards could make
>             use of it too.
>=20
>             For that reason, if there is no objection, I plan to select
>             this patch for
>             next MIPS queue.
>=20
>=20
>         No objection but kind of d=C3=A9j=C3=A0 vu:
>=20
>         https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg03427=
.html
>=20
>         I still think the interface of load_elf may need to be rethinked
>         but I don't know a good way.
>=20
>=20
>=20
>     Perhaps having only two, "in" and "out", arguments that are pointers
>     to structures?
>=20
>     Another thing that I noticed is "endian argument" that it seems
>     everyone uses in a different way: 0, 1, true, false, bigendian, etc.
>     Would c enumeration help? This looks to me like a time ticking bomb.
>=20
>     Just to add that some platforms like MIPS and SPARC must load elfs
>     of more than one value of EM_MACHINE (in MIPS case, EM_MIPS and
>     EM_NANOMIPS) and current load_elf() interface offers only clumsy
>     solutions/workarounds in these cases.
>=20
>     Let's think about everything later on.
>=20
>=20
>          =C2=A0This could be fixed in a later patch causing more code chu=
rn
>         again though, so if there's a way to fix this it might be a good
>         opportunity now. But I don't want to hold your patch series back
>         so unless someone has a good idea to avoid this situation then
>         we have to live with it.
>=20
>=20
>     Thank you. I will do some minor corrections for obvious unclarities
>     and typos in the commit message while applying to my qieue.
>=20
>         Regards,
>         BALATON Zoltan
>=20
>=20
>             Regards,
>             Aleksandar
>=20
>=20
>=20
>=20
>                 CC: Richard Henderson <rth@twiddle.net
>                 <mailto:rth@twiddle.net>>
>                 CC: Peter Maydell <peter.maydell@linaro.org
>                 <mailto:peter.maydell@linaro.org>>
>                 CC: Edgar E. Iglesias <edgar.iglesias@gmail.com
>                 <mailto:edgar.iglesias@gmail.com>>
>                 CC: Michael Walle <michael@walle.cc>
>                 CC: Thomas Huth <huth@tuxfamily.org
>                 <mailto:huth@tuxfamily.org>>
>                 CC: Laurent Vivier <laurent@vivier.eu
>                 <mailto:laurent@vivier.eu>>
>                 CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>                 <mailto:f4bug@amsat.org>>
>                 CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com
>                 <mailto:aleksandar.rikalo@rt-rk.com>>
>                 CC: Aurelien Jarno <aurelien@aurel32.net
>                 <mailto:aurelien@aurel32.net>>
>                 CC: Jia Liu <proljc@gmail.com <mailto:proljc@gmail.com>>
>                 CC: David Gibson <david@gibson.dropbear.id.au
>                 <mailto:david@gibson.dropbear.id.au>>
>                 CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk
>                 <mailto:mark.cave-ayland@ilande.co.uk>>
>                 CC: BALATON Zoltan <balaton@eik.bme.hu
>                 <mailto:balaton@eik.bme.hu>>
>                 CC: Christian Borntraeger <borntraeger@de.ibm.com
>                 <mailto:borntraeger@de.ibm.com>>
>                 CC: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.co=
m>>
>                 CC: Artyom Tarasenko <atar4qemu@gmail.com
>                 <mailto:atar4qemu@gmail.com>>
>                 CC: Fabien Chouteau <chouteau@adacore.com
>                 <mailto:chouteau@adacore.com>>
>                 CC: KONRAD Frederic <frederic.konrad@adacore.com
>                 <mailto:frederic.konrad@adacore.com>>
>                 CC: Max Filippov <jcmvbkbc@gmail.com
>                 <mailto:jcmvbkbc@gmail.com>>
>=20
>                 Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>                 <mailto:mrolnik@gmail.com>>
>                 Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
>                 <mailto:amarkovic@wavecomp.com>>
>                 [PMD: Extracted from bigger patch,
>                  =C2=A0 =C2=A0 =C2=A0 Replaced 'uint32_t *pe_flags' by 'i=
nt proc_flags']
>                 [AM: Replaced 'int proc_flags' with 'uint32_t *pflags',
>                  =C2=A0 =C2=A0 =C2=A0replaced one instance of 'elf_sword'=
 to 'elf_word',
>                  =C2=A0 =C2=A0 =C2=A0extended functionality to load_elf()=
]
>                 Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg
>                 <mailto:f4bug@amsat.org>>
>                 Signed-off-by: Aleksandar Markovic
>                 <aleksandar.m.mail@gmail.com
>                 <mailto:aleksandar.m.mail@gmail.com>>
>                 ---
>                  =C2=A0hw/alpha/dp264.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--
>                  =C2=A0hw/arm/armv7m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/arm/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/core/generic-loader.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-
>                  =C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 37
>                 +++++++++++++++++++------------------
>                  =C2=A0hw/cris/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>                  =C2=A0hw/hppa/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--
>                  =C2=A0hw/i386/multiboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/i386/x86.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/lm32/lm32_boards.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++--
>                  =C2=A0hw/lm32/milkymist.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/m68k/an5206.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>                  =C2=A0hw/m68k/mcf5208.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/m68k/q800.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>                  =C2=A0hw/microblaze/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 4 ++--
>                  =C2=A0hw/mips/mips_fulong2e.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 2 +-
>                  =C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 3 ++-
>                  =C2=A0hw/mips/mips_mipssim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 +-
>                  =C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>                  =C2=A0hw/moxie/moxiesim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/nios2/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--
>                  =C2=A0hw/openrisc/openrisc_sim.c=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-
>                  =C2=A0hw/pci-host/prep.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-
>                  =C2=A0hw/ppc/e500.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/ppc/mac_newworld.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++--
>                  =C2=A0hw/ppc/mac_oldworld.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++--
>                  =C2=A0hw/ppc/ppc440_bamboo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 +-
>                  =C2=A0hw/ppc/sam460ex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-
>                  =C2=A0hw/ppc/spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++---
>                  =C2=A0hw/ppc/virtex_ml507.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--
>                  =C2=A0hw/s390x/ipl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++++---
>                  =C2=A0hw/sparc/leon3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>                  =C2=A0hw/sparc/sun4m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--
>                  =C2=A0hw/sparc64/sun4u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 5 +++--
>                  =C2=A0hw/tricore/tricore_testboard.c |=C2=A0 2 +-
>                  =C2=A0hw/xtensa/sim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>                  =C2=A0hw/xtensa/xtfpga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>                  =C2=A0include/hw/elf_ops.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 6 +++++-
>                  =C2=A0include/hw/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 21 ++++++++++++---------
>                  =C2=A040 files changed, 92 insertions(+), 79 deletions(-=
)


