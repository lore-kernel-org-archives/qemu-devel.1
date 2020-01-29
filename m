Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A142BC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B19B20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC0OPnr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B19B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkCM-0008Gb-BA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwkBV-0007Rp-1b
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwkBR-0007p7-Uj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:02:56 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwkBR-0007nN-N6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:02:53 -0500
Received: by mail-oi1-x242.google.com with SMTP id i1so13405107oie.8
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v2AegUxciubVorL62+EPUb6Uxl6gPYk7SYgBrwy2mgg=;
 b=nC0OPnr/YQxXE3syBgzlYznWVDvh9PHLyS5ggRVJxMfxc6keXXNwNFlqa9F/0vMMku
 vv9d7H/kjB27N3DZtyanKSMCvLcGKQ4MmmRb2rKIkcHMTkiuVTu9ztV3Zg0GQV+H07dz
 GmjAva6nGv1nnGTjvMNOshLryewOPm7QO6Qg1O90BHIEYzSAYvZJxLK2ThArieTlSvxL
 T2CiQdiZDiTrslHPVH1aTDWMP2oZK2xBYgxX+sahmmfzTkDsJGKOornnfksfYNKv7iH3
 pCKUjFuHbA1TKOmFr7B/S1PL40xsucW5CyxQUqUNOySGO5thTGXcA/BRdUT3ncREsTSV
 7Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v2AegUxciubVorL62+EPUb6Uxl6gPYk7SYgBrwy2mgg=;
 b=RtWD+DgKcMeeMqvTZ0X5Oq1X/I9x0fXmO8pIFqNBGfWJhqBbSwoDWq4ChImSBNbKoQ
 XsYyobKsTOg3H+d7sTH2K0myio/jyD9kpK+d+ipJOFNeR2YRglLU4LBo41NUYPYkYNiN
 okL7zCZEmM6F8y3rTPUEGAlT/HE9esZ5t51Hx7/3XA6ifa1MuxupHNHlBFb6r1azCWwP
 upDDNuyDet3we0qmOFC8q4otXN1d9ybG1aKSH5YTe7eypS0t+I+p1wxhgyxCi3ROFinU
 Mu67qhYO9oYiAkUQkduBsTronJZXNVvIkhID1t5DowmY6SPPa9wp2/OV1bkAzeoaStLm
 wKUw==
X-Gm-Message-State: APjAAAXM9AqktdtFJiQFl18p7be8SW9hzY0/mMjqowKmipEWT2JF9jdM
 D3GeIlglKv1b52rk9e6eu1H7S67Ab2PqdZeRPC8=
X-Google-Smtp-Source: APXvYqz/hmMQoJiZWWy3Gfeg6wKhy0hclNElQhEbiFqBvOcKO/+WSTp5PEMy1ox/arBwys38/4fVsAkbUzyIjt3pJc0=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr5618686oih.79.1580292172185; 
 Wed, 29 Jan 2020 02:02:52 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hG=NoQWpxQ5xOkyLM7kYpsoZOohTWU1eYr-fLp=Ud_MA@mail.gmail.com>
 <alpine.BSF.2.22.395.2001281334310.9839@zero.eik.bme.hu>
 <CAL1e-=iNBvd0eBHig==3V6Hw6tjf-A3+-QRukXeqATyvJufz8A@mail.gmail.com>
 <CAL1e-=i_NPErr=9Bag_6Ps1+5=0xAC0NKxpTnyCJVpvZ_a5veQ@mail.gmail.com>
 <31a56bec-bc6c-7f05-5b96-27bde202c105@redhat.com>
In-Reply-To: <31a56bec-bc6c-7f05-5b96-27bde202c105@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 29 Jan 2020 11:02:33 +0100
Message-ID: <CAL1e-=jjwP6i3KQjVyw8UVuh_MmzOUBU8T3BMG9_5Vbp4u17zw@mail.gmail.com>
Subject: Re: [PATCH rc3 23/30] hw/core/loader: Let load_elf populate the
 processor-specific flags
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000090840f059d447189"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jia Liu <proljc@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 Michael Rolnik <mrolnik@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000090840f059d447189
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

08:32 Sre, 29.01.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Aleksandar,
>
> On 1/28/20 8:25 PM, Aleksandar Markovic wrote:
> > On Tue, Jan 28, 2020 at 2:27 PM Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
wrote:
> >
> >
> >
> >     On Tuesday, January 28, 2020, BALATON Zoltan <balaton@eik.bme.hu
> >     <mailto:balaton@eik.bme.hu>> wrote:
> >
> >         On Tue, 28 Jan 2020, Aleksandar Markovic wrote:
> >
> >             On Sunday, January 26, 2020, Aleksandar Markovic <
> >             aleksandar.markovic@rt-rk.com
> >             <mailto:aleksandar.markovic@rt-rk.com>> wrote:
> >
> >                 From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >                 <mailto:f4bug@amsat.org>>
> >
> >                 Some platforms (like AVR) need to determine cpu type by
> >                 reading
> >                 the ELF flags (field e_flags oin ELF header).
> >
> >                 This patch enables discovery of the content of that fla=
g
> >                 while
> >                 using following functions:
> >
> >                    - load_elf()
> >                    - load_elf_as()
> >                    - load_elf_ram()
> >                    - load_elf_ram_sym()
> >
> >                 The added argument of these functions is of type
> >                 uint32_t*. It is
> >                 allowed to pass NULL as that argument, and in such case
> >                 no lookup
> >                 to the field e_flags will happen, and of course, no
> >                 information
> >                 will be returned to the caller.
> >
> >
> > Applied to MIPS queue, with some commit message corrections and fixes.
>
> Sorry I didn't respond earlier, this was a very short delay (patch
> posted yesterday, pull request sent today).
>
> My original patch was much less intrusive:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg673762.html
> I don't find comfortable being listed as the author of the current
> patch. Do you mind changing the authorship?
>

No problem. I will then list myself as the author, as that can be said is
the case in reality.

Yours,
Aleksandar

> Thank you,
>
> Phil.
>
> >
> >             We plan to use this new functionality for MIPS Malta board,
> >             for detection
> >             of incompatible cpu/kernel combinations, and graceful exit
> >             (right now these
> >             combinations result in hang or crash). I would say other
> >             boards could make
> >             use of it too.
> >
> >             For that reason, if there is no objection, I plan to select
> >             this patch for
> >             next MIPS queue.
> >
> >
> >         No objection but kind of d=C3=A9j=C3=A0 vu:
> >
> >
https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg03427.html
> >
> >         I still think the interface of load_elf may need to be rethinke=
d
> >         but I don't know a good way.
> >
> >
> >
> >     Perhaps having only two, "in" and "out", arguments that are pointer=
s
> >     to structures?
> >
> >     Another thing that I noticed is "endian argument" that it seems
> >     everyone uses in a different way: 0, 1, true, false, bigendian, etc=
.
> >     Would c enumeration help? This looks to me like a time ticking bomb=
.
> >
> >     Just to add that some platforms like MIPS and SPARC must load elfs
> >     of more than one value of EM_MACHINE (in MIPS case, EM_MIPS and
> >     EM_NANOMIPS) and current load_elf() interface offers only clumsy
> >     solutions/workarounds in these cases.
> >
> >     Let's think about everything later on.
> >
> >
> >           This could be fixed in a later patch causing more code churn
> >         again though, so if there's a way to fix this it might be a goo=
d
> >         opportunity now. But I don't want to hold your patch series bac=
k
> >         so unless someone has a good idea to avoid this situation then
> >         we have to live with it.
> >
> >
> >     Thank you. I will do some minor corrections for obvious unclarities
> >     and typos in the commit message while applying to my qieue.
> >
> >         Regards,
> >         BALATON Zoltan
> >
> >
> >             Regards,
> >             Aleksandar
> >
> >
> >
> >
> >                 CC: Richard Henderson <rth@twiddle.net
> >                 <mailto:rth@twiddle.net>>
> >                 CC: Peter Maydell <peter.maydell@linaro.org
> >                 <mailto:peter.maydell@linaro.org>>
> >                 CC: Edgar E. Iglesias <edgar.iglesias@gmail.com
> >                 <mailto:edgar.iglesias@gmail.com>>
> >                 CC: Michael Walle <michael@walle.cc>
> >                 CC: Thomas Huth <huth@tuxfamily.org
> >                 <mailto:huth@tuxfamily.org>>
> >                 CC: Laurent Vivier <laurent@vivier.eu
> >                 <mailto:laurent@vivier.eu>>
> >                 CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >                 <mailto:f4bug@amsat.org>>
> >                 CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com
> >                 <mailto:aleksandar.rikalo@rt-rk.com>>
> >                 CC: Aurelien Jarno <aurelien@aurel32.net
> >                 <mailto:aurelien@aurel32.net>>
> >                 CC: Jia Liu <proljc@gmail.com <mailto:proljc@gmail.com>=
>
> >                 CC: David Gibson <david@gibson.dropbear.id.au
> >                 <mailto:david@gibson.dropbear.id.au>>
> >                 CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk
> >                 <mailto:mark.cave-ayland@ilande.co.uk>>
> >                 CC: BALATON Zoltan <balaton@eik.bme.hu
> >                 <mailto:balaton@eik.bme.hu>>
> >                 CC: Christian Borntraeger <borntraeger@de.ibm.com
> >                 <mailto:borntraeger@de.ibm.com>>
> >                 CC: Thomas Huth <thuth@redhat.com <mailto:
thuth@redhat.com>>
> >                 CC: Artyom Tarasenko <atar4qemu@gmail.com
> >                 <mailto:atar4qemu@gmail.com>>
> >                 CC: Fabien Chouteau <chouteau@adacore.com
> >                 <mailto:chouteau@adacore.com>>
> >                 CC: KONRAD Frederic <frederic.konrad@adacore.com
> >                 <mailto:frederic.konrad@adacore.com>>
> >                 CC: Max Filippov <jcmvbkbc@gmail.com
> >                 <mailto:jcmvbkbc@gmail.com>>
> >
> >                 Signed-off-by: Michael Rolnik <mrolnik@gmail.com
> >                 <mailto:mrolnik@gmail.com>>
> >                 Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.co=
m
> >                 <mailto:amarkovic@wavecomp.com>>
> >                 [PMD: Extracted from bigger patch,
> >                        Replaced 'uint32_t *pe_flags' by 'int
proc_flags']
> >                 [AM: Replaced 'int proc_flags' with 'uint32_t *pflags',
> >                       replaced one instance of 'elf_sword' to
'elf_word',
> >                       extended functionality to load_elf()]
> >                 Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org
> >                 <mailto:f4bug@amsat.org>>
> >                 Signed-off-by: Aleksandar Markovic
> >                 <aleksandar.m.mail@gmail.com
> >                 <mailto:aleksandar.m.mail@gmail.com>>
> >                 ---
> >                   hw/alpha/dp264.c               |  4 ++--
> >                   hw/arm/armv7m.c                |  2 +-
> >                   hw/arm/boot.c                  |  2 +-
> >                   hw/core/generic-loader.c       |  2 +-
> >                   hw/core/loader.c               | 37
> >                 +++++++++++++++++++------------------
> >                   hw/cris/boot.c                 |  2 +-
> >                   hw/hppa/machine.c              |  4 ++--
> >                   hw/i386/multiboot.c            |  2 +-
> >                   hw/i386/x86.c                  |  2 +-
> >                   hw/lm32/lm32_boards.c          |  4 ++--
> >                   hw/lm32/milkymist.c            |  2 +-
> >                   hw/m68k/an5206.c               |  2 +-
> >                   hw/m68k/mcf5208.c              |  2 +-
> >                   hw/m68k/q800.c                 |  2 +-
> >                   hw/microblaze/boot.c           |  4 ++--
> >                   hw/mips/mips_fulong2e.c        |  2 +-
> >                   hw/mips/mips_malta.c           |  3 ++-
> >                   hw/mips/mips_mipssim.c         |  2 +-
> >                   hw/mips/mips_r4k.c             |  2 +-
> >                   hw/moxie/moxiesim.c            |  2 +-
> >                   hw/nios2/boot.c                |  4 ++--
> >                   hw/openrisc/openrisc_sim.c     |  2 +-
> >                   hw/pci-host/prep.c             |  3 ++-
> >                   hw/ppc/e500.c                  |  2 +-
> >                   hw/ppc/mac_newworld.c          |  4 ++--
> >                   hw/ppc/mac_oldworld.c          |  4 ++--
> >                   hw/ppc/ppc440_bamboo.c         |  2 +-
> >                   hw/ppc/sam460ex.c              |  3 ++-
> >                   hw/ppc/spapr.c                 |  6 +++---
> >                   hw/ppc/virtex_ml507.c          |  2 +-
> >                   hw/riscv/boot.c                |  4 ++--
> >                   hw/s390x/ipl.c                 |  7 ++++---
> >                   hw/sparc/leon3.c               |  2 +-
> >                   hw/sparc/sun4m.c               |  4 ++--
> >                   hw/sparc64/sun4u.c             |  5 +++--
> >                   hw/tricore/tricore_testboard.c |  2 +-
> >                   hw/xtensa/sim.c                |  2 +-
> >                   hw/xtensa/xtfpga.c             |  2 +-
> >                   include/hw/elf_ops.h           |  6 +++++-
> >                   include/hw/loader.h            | 21
++++++++++++---------
> >                   40 files changed, 92 insertions(+), 79 deletions(-)
>

--00000000000090840f059d447189
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHAgZGlyPSJsdHIiPjwvcD4NCjxwIGRpcj0ibHRyIj4wODozMiBTcmUsIDI5LjAxLjIwMjAuIFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5j
b20iPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDsg0ZjQtSDQvdCw0L/QuNGB0LDQvi/Qu9CwOjxi
cj4NCiZndDs8YnI+DQomZ3Q7IEhpIEFsZWtzYW5kYXIsPGJyPg0KJmd0Ozxicj4NCiZndDsgT24g
MS8yOC8yMCA4OjI1IFBNLCBBbGVrc2FuZGFyIE1hcmtvdmljIHdyb3RlOjxicj4NCiZndDsgJmd0
OyBPbiBUdWUsIEphbiAyOCwgMjAyMCBhdCAyOjI3IFBNIEFsZWtzYW5kYXIgTWFya292aWMgPGJy
Pg0KJmd0OyAmZ3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86YWxla3NhbmRhci5tLm1haWxAZ21haWwu
Y29tIj5hbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOmFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbSI+YWxla3NhbmRhci5tLm1haWxAZ21h
aWwuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDsg
PGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgT24gVHVlc2RheSwgSmFudWFy
eSAyOCwgMjAyMCwgQkFMQVRPTiBab2x0YW4gJmx0OzxhIGhyZWY9Im1haWx0bzpiYWxhdG9uQGVp
ay5ibWUuaHUiPmJhbGF0b25AZWlrLmJtZS5odTwvYT48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCZs
dDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmJhbGF0b25AZWlrLmJtZS5odSI+YmFsYXRvbkBlaWsu
Ym1lLmh1PC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoE9uIFR1ZSwgMjggSmFuIDIwMjAsIEFsZWtzYW5kYXIgTWFya292aWMgd3Jv
dGU6PGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgT24g
U3VuZGF5LCBKYW51YXJ5IDI2LCAyMDIwLCBBbGVrc2FuZGFyIE1hcmtvdmljICZsdDs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDxhIGhyZWY9Im1haWx0bzphbGVrc2FuZGFyLm1h
cmtvdmljQHJ0LXJrLmNvbSI+YWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb208L2E+PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzph
bGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbSI+YWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5j
b208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgJmx0Ozxh
IGhyZWY9Im1haWx0bzpmNGJ1Z0BhbXNhdC5vcmciPmY0YnVnQGFtc2F0Lm9yZzwvYT48YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOmY0YnVnQGFtc2F0Lm9yZyI+ZjRidWdAYW1zYXQub3JnPC9hPiZndDsmZ3Q7PGJyPg0KJmd0
OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU29tZSBwbGF0
Zm9ybXMgKGxpa2UgQVZSKSBuZWVkIHRvIGRldGVybWluZSBjcHUgdHlwZSBieTxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVhZGluZzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdGhlIEVMRiBmbGFncyAoZmllbGQgZV9mbGFncyBvaW4gRUxG
IGhlYWRlcikuPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgVGhpcyBwYXRjaCBlbmFibGVzIGRpc2NvdmVyeSBvZiB0aGUgY29udGVudCBvZiB0
aGF0IGZsYWc8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdoaWxlPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1c2luZyBmb2xsb3dpbmcgZnVu
Y3Rpb25zOjxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAtIGxvYWRfZWxmKCk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAtIGxvYWRfZWxmX2FzKCk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAtIGxvYWRfZWxmX3JhbSgpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgLSBsb2FkX2VsZl9yYW1fc3ltKCk8YnI+DQomZ3Q7ICZndDsgPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBUaGUgYWRkZWQgYXJndW1lbnQg
b2YgdGhlc2UgZnVuY3Rpb25zIGlzIG9mIHR5cGU8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHVpbnQzMl90Ki4gSXQgaXM8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGFsbG93ZWQgdG8gcGFzcyBOVUxMIGFzIHRoYXQgYXJndW1lbnQsIGFuZCBp
biBzdWNoIGNhc2U8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5vIGxv
b2t1cDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdG8gdGhlIGZpZWxk
IGVfZmxhZ3Mgd2lsbCBoYXBwZW4sIGFuZCBvZiBjb3Vyc2UsIG5vPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbmZvcm1hdGlvbjxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgd2lsbCBiZSByZXR1cm5lZCB0byB0aGUgY2FsbGVyLjxicj4NCiZn
dDsgJmd0OyA8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7IEFwcGxpZWQgdG8gTUlQUyBx
dWV1ZSwgd2l0aCBzb21lIGNvbW1pdCBtZXNzYWdlIGNvcnJlY3Rpb25zIGFuZCBmaXhlcy48YnI+
DQomZ3Q7PGJyPg0KJmd0OyBTb3JyeSBJIGRpZG4mIzM5O3QgcmVzcG9uZCBlYXJsaWVyLCB0aGlz
IHdhcyBhIHZlcnkgc2hvcnQgZGVsYXkgKHBhdGNoIDxicj4NCiZndDsgcG9zdGVkIHllc3RlcmRh
eSwgcHVsbCByZXF1ZXN0IHNlbnQgdG9kYXkpLjxicj4NCiZndDs8YnI+DQomZ3Q7IE15IG9yaWdp
bmFsIHBhdGNoIHdhcyBtdWNoIGxlc3MgaW50cnVzaXZlOjxicj4NCiZndDsgPGEgaHJlZj0iaHR0
cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9xZW11LWRldmVsQG5vbmdudS5vcmcvbXNnNjczNzYy
Lmh0bWwiPmh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vcWVtdS1kZXZlbEBub25nbnUub3Jn
L21zZzY3Mzc2Mi5odG1sPC9hPjxicj4NCiZndDsgSSBkb24mIzM5O3QgZmluZCBjb21mb3J0YWJs
ZSBiZWluZyBsaXN0ZWQgYXMgdGhlIGF1dGhvciBvZiB0aGUgY3VycmVudDxicj4NCiZndDsgcGF0
Y2guIERvIHlvdSBtaW5kIGNoYW5naW5nIHRoZSBhdXRob3JzaGlwPzxicj4NCiZndDs8L3A+DQo8
cCBkaXI9Imx0ciI+Tm8gcHJvYmxlbS4gSSB3aWxsIHRoZW4gbGlzdCBteXNlbGYgYXMgdGhlIGF1
dGhvciwgYXMgdGhhdCBjYW4gYmUgc2FpZCBpcyB0aGUgY2FzZSBpbiByZWFsaXR5LjwvcD4NCjxw
IGRpcj0ibHRyIj5Zb3Vycyw8YnI+DQpBbGVrc2FuZGFyPC9wPg0KPHAgZGlyPSJsdHIiPiZndDsg
VGhhbmsgeW91LDxicj4NCiZndDs8YnI+DQomZ3Q7IFBoaWwuPGJyPg0KJmd0Ozxicj4NCiZndDsg
Jmd0OyA8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFdlIHBsYW4gdG8gdXNlIHRo
aXMgbmV3IGZ1bmN0aW9uYWxpdHkgZm9yIE1JUFMgTWFsdGEgYm9hcmQsPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgZGV0ZWN0aW9uPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqBvZiBpbmNvbXBhdGlibGUgY3B1L2tlcm5lbCBjb21iaW5hdGlvbnMsIGFuZCBn
cmFjZWZ1bCBleGl0PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAocmlnaHQgbm93
IHRoZXNlPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBjb21iaW5hdGlvbnMgcmVz
dWx0IGluIGhhbmcgb3IgY3Jhc2gpLiBJIHdvdWxkIHNheSBvdGhlcjxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgYm9hcmRzIGNvdWxkIG1ha2U8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoHVzZSBvZiBpdCB0b28uPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgRm9yIHRoYXQgcmVhc29uLCBpZiB0aGVyZSBpcyBubyBvYmpl
Y3Rpb24sIEkgcGxhbiB0byBzZWxlY3Q8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oHRoaXMgcGF0Y2ggZm9yPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBuZXh0IE1J
UFMgcXVldWUuPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoE5vIG9iamVjdGlvbiBidXQga2luZCBvZiBkw6lqw6AgdnU6PGJyPg0KJmd0
OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgPGEgaHJlZj0iaHR0cHM6Ly9saXN0
cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDEvbXNnMDM0MjcuaHRt
bCI+aHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTkt
MDEvbXNnMDM0MjcuaHRtbDwvYT48YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqBJIHN0aWxsIHRoaW5rIHRoZSBpbnRlcmZhY2Ugb2YgbG9hZF9lbGYgbWF5IG5lZWQg
dG8gYmUgcmV0aGlua2VkPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBidXQgSSBkb24mIzM5
O3Qga25vdyBhIGdvb2Qgd2F5Ljxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDsgPGJyPg0K
Jmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgUGVyaGFwcyBoYXZpbmcgb25seSB0d28s
ICZxdW90O2luJnF1b3Q7IGFuZCAmcXVvdDtvdXQmcXVvdDssIGFyZ3VtZW50cyB0aGF0IGFyZSBw
b2ludGVyczxicj4NCiZndDsgJmd0O8KgIMKgIMKgdG8gc3RydWN0dXJlcz88YnI+DQomZ3Q7ICZn
dDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBBbm90aGVyIHRoaW5nIHRoYXQgSSBub3RpY2VkIGlz
ICZxdW90O2VuZGlhbiBhcmd1bWVudCZxdW90OyB0aGF0IGl0IHNlZW1zPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqBldmVyeW9uZSB1c2VzIGluIGEgZGlmZmVyZW50IHdheTogMCwgMSwgdHJ1ZSwgZmFs
c2UsIGJpZ2VuZGlhbiwgZXRjLjxicj4NCiZndDsgJmd0O8KgIMKgIMKgV291bGQgYyBlbnVtZXJh
dGlvbiBoZWxwPyBUaGlzIGxvb2tzIHRvIG1lIGxpa2UgYSB0aW1lIHRpY2tpbmcgYm9tYi48YnI+
DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBKdXN0IHRvIGFkZCB0aGF0IHNvbWUg
cGxhdGZvcm1zIGxpa2UgTUlQUyBhbmQgU1BBUkMgbXVzdCBsb2FkIGVsZnM8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoG9mIG1vcmUgdGhhbiBvbmUgdmFsdWUgb2YgRU1fTUFDSElORSAoaW4gTUlQUyBj
YXNlLCBFTV9NSVBTIGFuZDxicj4NCiZndDsgJmd0O8KgIMKgIMKgRU1fTkFOT01JUFMpIGFuZCBj
dXJyZW50IGxvYWRfZWxmKCkgaW50ZXJmYWNlIG9mZmVycyBvbmx5IGNsdW1zeTxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgc29sdXRpb25zL3dvcmthcm91bmRzIGluIHRoZXNlIGNhc2VzLjxicj4NCiZn
dDsgJmd0OyA8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoExldCYjMzk7cyB0aGluayBhYm91dCBldmVy
eXRoaW5nIGxhdGVyIG9uLjxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqBUaGlzIGNvdWxkIGJlIGZpeGVkIGluIGEgbGF0ZXIgcGF0
Y2ggY2F1c2luZyBtb3JlIGNvZGUgY2h1cm48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoGFn
YWluIHRob3VnaCwgc28gaWYgdGhlcmUmIzM5O3MgYSB3YXkgdG8gZml4IHRoaXMgaXQgbWlnaHQg
YmUgYSBnb29kPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBvcHBvcnR1bml0eSBub3cuIEJ1
dCBJIGRvbiYjMzk7dCB3YW50IHRvIGhvbGQgeW91ciBwYXRjaCBzZXJpZXMgYmFjazxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgc28gdW5sZXNzIHNvbWVvbmUgaGFzIGEgZ29vZCBpZGVhIHRv
IGF2b2lkIHRoaXMgc2l0dWF0aW9uIHRoZW48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoHdl
IGhhdmUgdG8gbGl2ZSB3aXRoIGl0Ljxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDsgPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqBUaGFuayB5b3UuIEkgd2lsbCBkbyBzb21lIG1pbm9yIGNvcnJl
Y3Rpb25zIGZvciBvYnZpb3VzIHVuY2xhcml0aWVzPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBhbmQg
dHlwb3MgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHdoaWxlIGFwcGx5aW5nIHRvIG15IHFpZXVlLjxi
cj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoFJlZ2FyZHMsPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBCQUxBVE9OIFpvbHRhbjxicj4NCiZndDsgJmd0OyA8YnI+
DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBSZWdhcmRzLDxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgQWxla3NhbmRhcjxicj4NCiZndDsgJmd0
OyA8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0OyA8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENDOiBSaWNoYXJkIEhlbmRlcnNvbiAm
bHQ7PGEgaHJlZj0ibWFpbHRvOnJ0aEB0d2lkZGxlLm5ldCI+cnRoQHR3aWRkbGUubmV0PC9hPjxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVm
PSJtYWlsdG86cnRoQHR3aWRkbGUubmV0Ij5ydGhAdHdpZGRsZS5uZXQ8L2E+Jmd0OyZndDs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENDOiBQZXRlciBNYXlkZWxsICZs
dDs8YSBocmVmPSJtYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIj5wZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc8L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAm
bHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmciPnBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgQ0M6IEVkZ2FyIEUuIElnbGVzaWFzICZsdDs8YSBocmVmPSJtYWlsdG86
ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tIj5lZGdhci5pZ2xlc2lhc0BnbWFpbC5jb208L2E+PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9
Im1haWx0bzplZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20iPmVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNv
bTwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQ0M6
IE1pY2hhZWwgV2FsbGUgJmx0O21pY2hhZWxAd2FsbGUuY2MmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBDQzogVGhvbWFzIEh1dGggJmx0OzxhIGhyZWY9Im1haWx0
bzpodXRoQHR1eGZhbWlseS5vcmciPmh1dGhAdHV4ZmFtaWx5Lm9yZzwvYT48YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmh1
dGhAdHV4ZmFtaWx5Lm9yZyI+aHV0aEB0dXhmYW1pbHkub3JnPC9hPiZndDsmZ3Q7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBDQzogTGF1cmVudCBWaXZpZXIgJmx0Ozxh
IGhyZWY9Im1haWx0bzpsYXVyZW50QHZpdmllci5ldSI+bGF1cmVudEB2aXZpZXIuZXU8L2E+PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9
Im1haWx0bzpsYXVyZW50QHZpdmllci5ldSI+bGF1cmVudEB2aXZpZXIuZXU8L2E+Jmd0OyZndDs8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENDOiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmY0YnVnQGFtc2F0Lm9yZyI+ZjRidWdAYW1z
YXQub3JnPC9hPjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21h
aWx0bzo8YSBocmVmPSJtYWlsdG86ZjRidWdAYW1zYXQub3JnIj5mNGJ1Z0BhbXNhdC5vcmc8L2E+
Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENDOiBBbGVr
c2FuZGFyIFJpa2FsbyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsZWtzYW5kYXIucmlrYWxvQHJ0LXJr
LmNvbSI+YWxla3NhbmRhci5yaWthbG9AcnQtcmsuY29tPC9hPjxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86YWxla3NhbmRh
ci5yaWthbG9AcnQtcmsuY29tIj5hbGVrc2FuZGFyLnJpa2Fsb0BydC1yay5jb208L2E+Jmd0OyZn
dDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENDOiBBdXJlbGllbiBK
YXJubyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmF1cmVsaWVuQGF1cmVsMzIubmV0Ij5hdXJlbGllbkBh
dXJlbDMyLm5ldDwvYT48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZs
dDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmF1cmVsaWVuQGF1cmVsMzIubmV0Ij5hdXJlbGllbkBh
dXJlbDMyLm5ldDwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgQ0M6IEppYSBMaXUgJmx0OzxhIGhyZWY9Im1haWx0bzpwcm9samNAZ21haWwuY29tIj5w
cm9samNAZ21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpwcm9samNAZ21h
aWwuY29tIj5wcm9samNAZ21haWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBDQzogRGF2aWQgR2lic29uICZsdDs8YSBocmVmPSJtYWlsdG86
ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1Ij5kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU8
L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxh
IGhyZWY9Im1haWx0bzpkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUiPmRhdmlkQGdpYnNvbi5k
cm9wYmVhci5pZC5hdTwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgQ0M6IE1hcmsgQ2F2ZS1BeWxhbmQgJmx0OzxhIGhyZWY9Im1haWx0bzptYXJrLmNh
dmUtYXlsYW5kQGlsYW5kZS5jby51ayI+bWFyay5jYXZlLWF5bGFuZEBpbGFuZGUuY28udWs8L2E+
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhy
ZWY9Im1haWx0bzptYXJrLmNhdmUtYXlsYW5kQGlsYW5kZS5jby51ayI+bWFyay5jYXZlLWF5bGFu
ZEBpbGFuZGUuY28udWs8L2E+Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoENDOiBCQUxBVE9OIFpvbHRhbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmJhbGF0b25A
ZWlrLmJtZS5odSI+YmFsYXRvbkBlaWsuYm1lLmh1PC9hPjxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86YmFsYXRvbkBlaWsu
Ym1lLmh1Ij5iYWxhdG9uQGVpay5ibWUuaHU8L2E+Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoENDOiBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgJmx0OzxhIGhy
ZWY9Im1haWx0bzpib3JudHJhZWdlckBkZS5pYm0uY29tIj5ib3JudHJhZWdlckBkZS5pYm0uY29t
PC9hPjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8
YSBocmVmPSJtYWlsdG86Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbSI+Ym9ybnRyYWVnZXJAZGUuaWJt
LmNvbTwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Q0M6IFRob21hcyBIdXRoICZsdDs8YSBocmVmPSJtYWlsdG86dGh1dGhAcmVkaGF0LmNvbSI+dGh1
dGhAcmVkaGF0LmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86dGh1dGhAcmVkaGF0
LmNvbSI+dGh1dGhAcmVkaGF0LmNvbTwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgQ0M6IEFydHlvbSBUYXJhc2Vua28gJmx0OzxhIGhyZWY9Im1haWx0
bzphdGFyNHFlbXVAZ21haWwuY29tIj5hdGFyNHFlbXVAZ21haWwuY29tPC9hPjxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86
YXRhcjRxZW11QGdtYWlsLmNvbSI+YXRhcjRxZW11QGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0Ozxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQ0M6IEZhYmllbiBDaG91dGVhdSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmNob3V0ZWF1QGFkYWNvcmUuY29tIj5jaG91dGVhdUBhZGFjb3Jl
LmNvbTwvYT48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDttYWls
dG86PGEgaHJlZj0ibWFpbHRvOmNob3V0ZWF1QGFkYWNvcmUuY29tIj5jaG91dGVhdUBhZGFjb3Jl
LmNvbTwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Q0M6IEtPTlJBRCBGcmVkZXJpYyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZyZWRlcmljLmtvbnJhZEBh
ZGFjb3JlLmNvbSI+ZnJlZGVyaWMua29ucmFkQGFkYWNvcmUuY29tPC9hPjxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86ZnJl
ZGVyaWMua29ucmFkQGFkYWNvcmUuY29tIj5mcmVkZXJpYy5rb25yYWRAYWRhY29yZS5jb208L2E+
Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENDOiBNYXgg
RmlsaXBwb3YgJmx0OzxhIGhyZWY9Im1haWx0bzpqY212YmtiY0BnbWFpbC5jb20iPmpjbXZia2Jj
QGdtYWlsLmNvbTwvYT48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZs
dDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmpjbXZia2JjQGdtYWlsLmNvbSI+amNtdmJrYmNAZ21h
aWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgU2lnbmVkLW9mZi1ieTogTWljaGFlbCBSb2xuaWsgJmx0OzxhIGhy
ZWY9Im1haWx0bzptcm9sbmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1h
aWx0bzptcm9sbmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+Jmd0OyZndDs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJldmlld2VkLWJ5OiBBbGVrc2Fu
ZGFyIE1hcmtvdmljICZsdDs8YSBocmVmPSJtYWlsdG86YW1hcmtvdmljQHdhdmVjb21wLmNvbSI+
YW1hcmtvdmljQHdhdmVjb21wLmNvbTwvYT48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmFtYXJrb3ZpY0B3YXZlY29tcC5j
b20iPmFtYXJrb3ZpY0B3YXZlY29tcC5jb208L2E+Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFtQTUQ6IEV4dHJhY3RlZCBmcm9tIGJpZ2dlciBwYXRjaCw8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSZXBsYWNl
ZCAmIzM5O3VpbnQzMl90ICpwZV9mbGFncyYjMzk7IGJ5ICYjMzk7aW50IHByb2NfZmxhZ3MmIzM5
O108YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFtBTTogUmVwbGFjZWQg
JiMzOTtpbnQgcHJvY19mbGFncyYjMzk7IHdpdGggJiMzOTt1aW50MzJfdCAqcGZsYWdzJiMzOTss
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXBsYWNl
ZCBvbmUgaW5zdGFuY2Ugb2YgJiMzOTtlbGZfc3dvcmQmIzM5OyB0byAmIzM5O2VsZl93b3JkJiMz
OTssPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleHRl
bmRlZCBmdW5jdGlvbmFsaXR5IHRvIGxvYWRfZWxmKCldPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmY0YnVnQGFtc2F0Lm9yZyI+ZjRidWdAYW1zYXQub3JnPC9hPjxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVm
PSJtYWlsdG86ZjRidWdAYW1zYXQub3JnIj5mNGJ1Z0BhbXNhdC5vcmc8L2E+Jmd0OyZndDs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFNpZ25lZC1vZmYtYnk6IEFsZWtz
YW5kYXIgTWFya292aWM8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZs
dDs8YSBocmVmPSJtYWlsdG86YWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tIj5hbGVrc2FuZGFy
Lm0ubWFpbEBnbWFpbC5jb208L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzphbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5j
b20iPmFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLS0tPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBody9hbHBoYS9kcDI2NC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgNCArKy0tPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody9h
cm0vYXJtdjdtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaHcvYXJtL2Jvb3QuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBody9jb3JlL2dlbmVyaWMtbG9hZGVyLmPCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody9jb3JlL2xvYWRlci5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB8IDM3PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody9jcmlzL2Jvb3QuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGh3L2hwcGEvbWFjaGluZS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQgKyst
LTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaHcvaTM4Ni9tdWx0
aWJvb3QuY8KgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBody9pMzg2L3g4Ni5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIDIgKy08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3
L2xtMzIvbG0zMl9ib2FyZHMuY8KgIMKgIMKgIMKgIMKgIHzCoCA0ICsrLS08YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3L2xtMzIvbWlsa3ltaXN0LmPCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaHcvbTY4ay9hbjUyMDYuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3L202OGsvbWNmNTIwOC5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGh3L202OGsvcTgwMC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgMiArLTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaHcvbWlj
cm9ibGF6ZS9ib290LmPCoCDCoCDCoCDCoCDCoCDCoHzCoCA0ICsrLS08YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3L21pcHMvbWlwc19mdWxvbmcyZS5jwqAgwqAg
wqAgwqAgfMKgIDIgKy08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGh3L21pcHMvbWlwc19tYWx0YS5jwqAgwqAgwqAgwqAgwqAgwqB8wqAgMyArKy08YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3L21pcHMvbWlwc19taXBzc2ltLmPC
oCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBody9taXBzL21pcHNfcjRrLmPCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody9tb3hpZS9tb3hpZXNp
bS5jwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGh3L25pb3MyL2Jvb3QuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzC
oCA0ICsrLS08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3L29w
ZW5yaXNjL29wZW5yaXNjX3NpbS5jwqAgwqAgwqB8wqAgMiArLTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaHcvcGNpLWhvc3QvcHJlcC5jwqAgwqAgwqAgwqAgwqAg
wqAgwqB8wqAgMyArKy08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGh3L3BwYy9lNTAwLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaHcvcHBjL21hY19uZXd3b3JsZC5j
wqAgwqAgwqAgwqAgwqAgfMKgIDQgKystLTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaHcvcHBjL21hY19vbGR3b3JsZC5jwqAgwqAgwqAgwqAgwqAgfMKgIDQgKyst
LTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaHcvcHBjL3BwYzQ0
MF9iYW1ib28uY8KgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGh3L3BwYy9zYW00NjBleC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIDMgKystPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody9w
cGMvc3BhcHIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDYgKysrLS0tPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody9wcGMvdmlydGV4X21sNTA3LmPC
oCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaHcvcmlzY3YvYm9vdC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQgKyst
LTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaHcvczM5MHgvaXBs
LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA3ICsrKystLS08YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3L3NwYXJjL2xlb24zLmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCAyICstPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBody9zcGFyYy9zdW40bS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNCArKy0tPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody9zcGFyYzY0L3N1bjR1
LmPCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA1ICsrKy0tPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBody90cmljb3JlL3RyaWNvcmVfdGVzdGJvYXJkLmMgfMKgIDIg
Ky08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3L3h0ZW5zYS9z
aW0uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBody94dGVuc2EveHRmcGdhLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoHzCoCAyICstPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
bmNsdWRlL2h3L2VsZl9vcHMuaMKgIMKgIMKgIMKgIMKgIMKgfMKgIDYgKysrKystPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbmNsdWRlL2h3L2xvYWRlci5owqAg
wqAgwqAgwqAgwqAgwqAgfCAyMSArKysrKysrKysrKystLS0tLS0tLS08YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDQwIGZpbGVzIGNoYW5nZWQsIDkyIGluc2VydGlv
bnMoKyksIDc5IGRlbGV0aW9ucygtKTxicj4NCiZndDs8YnI+DQo8L3A+DQo=
--00000000000090840f059d447189--

