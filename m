Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B113C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64D82067C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjF+Ireu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64D82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXXp-00004u-To
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ixXX9-00087U-Dz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ixXX6-0006zr-7S
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:44:35 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b]:35362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ixXX5-0006yv-VP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:44:32 -0500
Received: by mail-qk1-x72b.google.com with SMTP id q15so6765833qki.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T5d641Qai+MferBTd466srJVyaPsXncHdvVm0UuPkOo=;
 b=XjF+Ireuohahq2ca8+SWWFaSZhhhM2zXWmwTjrrEWlZEHl6m+Bl0uCUg51vRPPZq0f
 Rr0DY3TegBxECSYDJz2nNnu/pqiRqkSPoq8vQmRzfFa9Wfh8DFZx2B6iOyZ9+G0YZRHb
 6wNmAwJwGAzB2yhFOolebcgMSo364ay9pxYMRWOCjPJyYXuyaUo5I9QckUq45RLZDaml
 kKFIxHkHjIISfS5ISl8HPQFFqSHQ9KY3quTVuCqqB2t5w/+KXvwfVDK7wuXBhfbb9xT4
 KlnU1eGaFFCQB3DpW2m9Bp6nP+4aXSWPklCGVIKyOPrLVL1+pLwudH8gQM+sS1kqtADO
 M/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T5d641Qai+MferBTd466srJVyaPsXncHdvVm0UuPkOo=;
 b=M1uq/Bau+r53XAyVntHMP3DjOgK4pBRSQrHYDq8VSBXDt8MZovO5kwC4D+1zdLEZtL
 Jqhs364pkgHxhxRZkSAlgF3F847D2spBLJnpSemDjN92dg6cQzFCira/+0AODByqS12l
 cdzTycJ9Y2gDwR4VpJn0LYOHUlVO+SWUk7mN/yFlLeMFE+RTrVe9lzFVn0SIoabIL3xe
 2QzkCkExyoAl3fTwQWrp1b5U5nz4AuoJDIPdlldOndPTF+FikJcQuTwJrpDebqk/ZIDR
 XcaUHwcF8xckvbRrRU8DAZ+OpkYpHbc5wG12QQpfENxsnyy3XXhcs3RPJJNkyO2XrJj+
 5daw==
X-Gm-Message-State: APjAAAWtFbWbOAbw/q5IoN/c8GDdb+u3DlWrFtYkvU3ENvxdzhXQ53m5
 M+jgF6/eatyvJq0146lNd52er1+sYLS+n1eORZk=
X-Google-Smtp-Source: APXvYqywh7SvuP7i9SL0AOCS6DYr/cjzWCaZZImOb780O4grOEVJ1oZzRITjwoDfmokAggKSMrmjT618x32kgVY31f0=
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr10139564qkg.489.1580481870770; 
 Fri, 31 Jan 2020 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=jVVSad52xEe0Fich+iWywmPtmtR2P9KLjeMtYNC1JqwQ@mail.gmail.com>
 <afe50719-04f8-bec4-ab37-61c7a327f14b@redhat.com>
In-Reply-To: <afe50719-04f8-bec4-ab37-61c7a327f14b@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 31 Jan 2020 16:43:43 +0200
Message-ID: <CAK4993jd6_k=UQFeBzyMve_Yba+p0HwDpkrqHeR1uJw5ckNo0Q@mail.gmail.com>
Subject: Re: [PATCH rc4 00/29] target/avr merger
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007b356a059d709cc7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72b
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007b356a059d709cc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good. Thanks

On Fri, Jan 31, 2020 at 3:24 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/31/20 1:12 AM, Aleksandar Markovic wrote:
> > Michael, Philippe,
> >
> > Can you guys do a quick checkup of this rc4? rc4, rc3,and rc2 should
> > be functionally 100% equivalent.
>
> Tested OK.
>
> git-backport-diff with rc2:
>
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences,
> respectively
>
> 001/31:[down] 'target/avr: Add basic parameters for new AVR platform'
> 002/31:[down] 'target/avr: Introduce AVR CPU class object'
> 003/31:[down] 'target/avr: Add migration support'
> 004/31:[down] 'target/avr: Add GDB support'
> 005/31:[down] 'target/avr: Introduce enumeration AVRFeature'
> 006/31:[down] 'target/avr: Add defintions of AVR core types'
> 007/31:[0148] [FC] 'target/avr: Add instruction helpers'
> 008/31:[down] 'target/avr: Add instruction translation - Register
> definitions'
> 009/31:[----] [--] 'target/avr: Add instruction translation - Arithmetic
> and Logic Instructions'
> 010/31:[----] [--] 'target/avr: Add instruction translation - Branch
> Instructions'
> 011/31:[----] [--] 'target/avr: Add instruction translation - Data
> Transfer Instructions'
> 012/31:[----] [--] 'target/avr: Add instruction translation - Bit and
> Bit-test Instructions'
> 013/31:[----] [--] 'target/avr: Add instruction translation - MCU
> Control Instructions'
> 014/31:[----] [--] 'target/avr: Add instruction translation - CPU main
> translation function'
> 015/31:[----] [--] 'target/avr: Add instruction disassembly function'
> 016/31:[down] 'hw/char: Add limited support for AVR USART peripheral'
> 017/31:[down] 'hw/timer: Add limited support for AVR 16-bit timer
> peripheral'
> 018/31:[down] 'hw/misc: Add limited support for AVR power device'
> 019/31:[0012] [FC] 'target/avr: Add section about AVR into QEMU
> documentation'
> 020/31:[0002] [FC] 'target/avr: Register AVR support with the rest of QEM=
U'
> 021/31:[----] [--] 'target/avr: Add machine none test'
> 022/31:[0014] [FC] 'target/avr: Update MAINTAINERS file'
> 023/31:[0002] [FC] 'hw/avr: Add helper to load raw/ELF firmware binaries'
> 024/31:[0026] [FC] 'hw/avr: Add some ATmega microcontrollers'
> 025/31:[0009] [FC] 'hw/avr: Add some Arduino boards'
> 026/31:[----] [--] 'target/avr: Update build system'
> 027/31:[----] [--] 'tests/boot-serial-test: Test some Arduino boards
> (AVR based)'
> 028/31:[----] [--] 'tests/acceptance: Test the Arduino MEGA2560 board'
> 029/31:[----] [--] '.travis.yml: Run the AVR acceptance tests'
> 030/31:[down] '!fixup "hw/misc: Add limited support for AVR power device"=
'
> 031/31:[down] '!fixup "hw/timer: Add limited support for AVR 16-bit
> timer peripheral"'
>
> One thing that annoys me is we ignored the review comments from Joaquin,
> but I think it might now be easier to address them as new patches, once
> this series is merged.
>
> I made 2 comments (definitions in incorrect patch, and definition
> misplaced in elf.h), and sent 2 patches converting the PRINTF() to
> trace-events. Thanks for preparing the rc4, hopefully we are done!
>
> >
> > Thank you,
> > Aleksandar
> >
> > On Fri, Jan 31, 2020 at 1:06 AM Aleksandar Markovic
> > <aleksandar.markovic@rt-rk.com> wrote:
> >>
> >> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >>
> >> This is the AVR port from Michael, release (merge) candidate 4.
> >>
> >> The series can be found also in this repository:
> >>
> >> https://github.com/AMarkovic/qemu-avr-merger-rc4
> >>
> >> History:
> >>
> >> Since v3:
> >>
> >> - Removed a patch on load_elf() modification, since it has been merged
> >> - Removed references to CONFIG_USER_ONLY and provided a guard against
> >>    building lunux user mode for AVR
> >> - Removed all references to 'Atmel' (including file renames)
> >> - Rebased the code (there was common interface change regarding 'props=
')
> >> - Various corrections of commit messages
> >> - A bit field for AVRFeatures is nor 64 bit long
> >> - Other minor fixes
> >>
> >> Since v2:
> >>
> >> - First patch is split into six smaller logical units (net result
> >>    remains the same)
> >> - Patch "hw/core/loader: Let load_elf populate the processor-specific
> >>    flags" was redone to reflect the original intent that was lost in
> >>    transalation between multiple autors
> >> - Patch "hw/avr: Add helper to load raw/ELF firmware binaries" was
> >>    corrected only in one line to rectify type of "e_flags"
> >> - Patch "target/avr: Add section about AVR into QEMU documentation"
> >> - Spurious <message-Id:> elements were removed
> >> - The series was rebased to the latest code
> >>
> >> Since v1:
> >>
> >> - Addressed Thomas comments
> >> - Fixed a non-critical bug in ATmega (incorrect SRAM base address)
> >> - Added ELF parsing requested by Aleksandar
> >> - Dropped default machine (as with the ARM port)
> >>
> >> Michael Rolnik (25):
> >>    target/avr: Add basic parameters for new AVR platform
> >>    target/avr: Introduce AVR CPU class object
> >>    target/avr: Add migration support
> >>    target/avr: Add GDB support
> >>    target/avr: Introduce enumeration AVRFeature
> >>    target/avr: Add defintions of AVR core types
> >>    target/avr: Add instruction helpers
> >>    target/avr: Add instruction translation - Register definitions
> >>    target/avr: Add instruction translation - Arithmetic and Logic
> >>      Instructions
> >>    target/avr: Add instruction translation - Branch Instructions
> >>    target/avr: Add instruction translation - Data Transfer Instruction=
s
> >>    target/avr: Add instruction translation - Bit and Bit-test
> >>      Instructions
> >>    target/avr: Add instruction translation - MCU Control Instructions
> >>    target/avr: Add instruction translation - CPU main translation
> >>      function
> >>    target/avr: Add instruction disassembly function
> >>    hw/char: Add limited support for AVR USART peripheral
> >>    hw/timer: Add limited support for AVR 16-bit timer peripheral
> >>    hw/misc: Add limited support for AVR power device
> >>    target/avr: Add section about AVR into QEMU documentation
> >>    target/avr: Register AVR support with the rest of QEMU
> >>    target/avr: Add machine none test
> >>    target/avr: Update MAINTAINERS file
> >>    target/avr: Update build system
> >>    tests/boot-serial-test: Test some Arduino boards (AVR based)
> >>    tests/acceptance: Test the Arduino MEGA2560 board
> >>
> >> Philippe Mathieu-Daud=C3=A9 (4):
> >>    hw/avr: Add helper to load raw/ELF firmware binaries
> >>    hw/avr: Add some ATmega microcontrollers
> >>    hw/avr: Add some Arduino boards
> >>    .travis.yml: Run the AVR acceptance tests
> >>
> >>   .travis.yml                      |    2 +-
> >>   MAINTAINERS                      |   31 +
> >>   arch_init.c                      |    2 +
> >>   configure                        |    7 +
> >>   default-configs/avr-softmmu.mak  |    5 +
> >>   gdb-xml/avr-cpu.xml              |   49 +
> >>   hw/avr/Kconfig                   |    9 +
> >>   hw/avr/Makefile.objs             |    3 +
> >>   hw/avr/arduino.c                 |  151 ++
> >>   hw/avr/atmega.c                  |  470 ++++++
> >>   hw/avr/atmega.h                  |   48 +
> >>   hw/avr/boot.c                    |   74 +
> >>   hw/avr/boot.h                    |   33 +
> >>   hw/char/Kconfig                  |    3 +
> >>   hw/char/Makefile.objs            |    1 +
> >>   hw/char/avr_usart.c              |  320 ++++
> >>   hw/misc/Kconfig                  |    3 +
> >>   hw/misc/Makefile.objs            |    2 +
> >>   hw/misc/avr_power.c              |  112 ++
> >>   hw/timer/Kconfig                 |    3 +
> >>   hw/timer/Makefile.objs           |    2 +
> >>   hw/timer/avr_timer16.c           |  604 ++++++++
> >>   include/disas/dis-asm.h          |   19 +
> >>   include/elf.h                    |    2 +
> >>   include/hw/char/avr_usart.h      |   93 ++
> >>   include/hw/misc/avr_power.h      |   46 +
> >>   include/hw/timer/avr_timer16.h   |   94 ++
> >>   include/sysemu/arch_init.h       |    1 +
> >>   qapi/machine.json                |    3 +-
> >>   qemu-doc.texi                    |   51 +
> >>   target/avr/Makefile.objs         |   34 +
> >>   target/avr/cpu-param.h           |   37 +
> >>   target/avr/cpu-qom.h             |   54 +
> >>   target/avr/cpu.c                 |  818 +++++++++++
> >>   target/avr/cpu.h                 |  259 ++++
> >>   target/avr/disas.c               |  246 ++++
> >>   target/avr/gdbstub.c             |   84 ++
> >>   target/avr/helper.c              |  342 +++++
> >>   target/avr/helper.h              |   29 +
> >>   target/avr/insn.decode           |  182 +++
> >>   target/avr/machine.c             |  121 ++
> >>   target/avr/translate.c           | 2997
> ++++++++++++++++++++++++++++++++++++++
> >>   tests/acceptance/machine_avr6.py |   50 +
> >>   tests/qtest/Makefile.include     |    2 +
> >>   tests/qtest/boot-serial-test.c   |   11 +
> >>   tests/qtest/machine-none-test.c  |    1 +
> >>   46 files changed, 7508 insertions(+), 2 deletions(-)
> >>   create mode 100644 default-configs/avr-softmmu.mak
> >>   create mode 100644 gdb-xml/avr-cpu.xml
> >>   create mode 100644 hw/avr/Kconfig
> >>   create mode 100644 hw/avr/Makefile.objs
> >>   create mode 100644 hw/avr/arduino.c
> >>   create mode 100644 hw/avr/atmega.c
> >>   create mode 100644 hw/avr/atmega.h
> >>   create mode 100644 hw/avr/boot.c
> >>   create mode 100644 hw/avr/boot.h
> >>   create mode 100644 hw/char/avr_usart.c
> >>   create mode 100644 hw/misc/avr_power.c
> >>   create mode 100644 hw/timer/avr_timer16.c
> >>   create mode 100644 include/hw/char/avr_usart.h
> >>   create mode 100644 include/hw/misc/avr_power.h
> >>   create mode 100644 include/hw/timer/avr_timer16.h
> >>   create mode 100644 target/avr/Makefile.objs
> >>   create mode 100644 target/avr/cpu-param.h
> >>   create mode 100644 target/avr/cpu-qom.h
> >>   create mode 100644 target/avr/cpu.c
> >>   create mode 100644 target/avr/cpu.h
> >>   create mode 100644 target/avr/disas.c
> >>   create mode 100644 target/avr/gdbstub.c
> >>   create mode 100644 target/avr/helper.c
> >>   create mode 100644 target/avr/helper.h
> >>   create mode 100644 target/avr/insn.decode
> >>   create mode 100644 target/avr/machine.c
> >>   create mode 100644 target/avr/translate.c
> >>   create mode 100644 tests/acceptance/machine_avr6.py
> >>
> >> --
> >> 2.7.4
> >>
> >>
> >
>
>

--=20
Best Regards,
Michael Rolnik

--0000000000007b356a059d709cc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks=C2=A0good. Thanks</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 31, 2020 at 3:24 AM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On 1/31/20 1:12 AM, Aleksandar Markovic wrote:<br>
&gt; Michael, Philippe,<br>
&gt; <br>
&gt; Can you guys do a quick checkup of this rc4? rc4, rc3,and rc2 should<b=
r>
&gt; be functionally 100% equivalent.<br>
<br>
Tested OK.<br>
<br>
git-backport-diff with rc2:<br>
<br>
Key:<br>
[----] : patches are identical<br>
[####] : number of functional differences between upstream/downstream patch=
<br>
[down] : patch is downstream-only<br>
The flags [FC] indicate (F)unctional and (C)ontextual differences, <br>
respectively<br>
<br>
001/31:[down] &#39;target/avr: Add basic parameters for new AVR platform&#3=
9;<br>
002/31:[down] &#39;target/avr: Introduce AVR CPU class object&#39;<br>
003/31:[down] &#39;target/avr: Add migration support&#39;<br>
004/31:[down] &#39;target/avr: Add GDB support&#39;<br>
005/31:[down] &#39;target/avr: Introduce enumeration AVRFeature&#39;<br>
006/31:[down] &#39;target/avr: Add defintions of AVR core types&#39;<br>
007/31:[0148] [FC] &#39;target/avr: Add instruction helpers&#39;<br>
008/31:[down] &#39;target/avr: Add instruction translation - Register <br>
definitions&#39;<br>
009/31:[----] [--] &#39;target/avr: Add instruction translation - Arithmeti=
c <br>
and Logic Instructions&#39;<br>
010/31:[----] [--] &#39;target/avr: Add instruction translation - Branch <b=
r>
Instructions&#39;<br>
011/31:[----] [--] &#39;target/avr: Add instruction translation - Data <br>
Transfer Instructions&#39;<br>
012/31:[----] [--] &#39;target/avr: Add instruction translation - Bit and <=
br>
Bit-test Instructions&#39;<br>
013/31:[----] [--] &#39;target/avr: Add instruction translation - MCU <br>
Control Instructions&#39;<br>
014/31:[----] [--] &#39;target/avr: Add instruction translation - CPU main =
<br>
translation function&#39;<br>
015/31:[----] [--] &#39;target/avr: Add instruction disassembly function&#3=
9;<br>
016/31:[down] &#39;hw/char: Add limited support for AVR USART peripheral&#3=
9;<br>
017/31:[down] &#39;hw/timer: Add limited support for AVR 16-bit timer <br>
peripheral&#39;<br>
018/31:[down] &#39;hw/misc: Add limited support for AVR power device&#39;<b=
r>
019/31:[0012] [FC] &#39;target/avr: Add section about AVR into QEMU <br>
documentation&#39;<br>
020/31:[0002] [FC] &#39;target/avr: Register AVR support with the rest of Q=
EMU&#39;<br>
021/31:[----] [--] &#39;target/avr: Add machine none test&#39;<br>
022/31:[0014] [FC] &#39;target/avr: Update MAINTAINERS file&#39;<br>
023/31:[0002] [FC] &#39;hw/avr: Add helper to load raw/ELF firmware binarie=
s&#39;<br>
024/31:[0026] [FC] &#39;hw/avr: Add some ATmega microcontrollers&#39;<br>
025/31:[0009] [FC] &#39;hw/avr: Add some Arduino boards&#39;<br>
026/31:[----] [--] &#39;target/avr: Update build system&#39;<br>
027/31:[----] [--] &#39;tests/boot-serial-test: Test some Arduino boards <b=
r>
(AVR based)&#39;<br>
028/31:[----] [--] &#39;tests/acceptance: Test the Arduino MEGA2560 board&#=
39;<br>
029/31:[----] [--] &#39;.travis.yml: Run the AVR acceptance tests&#39;<br>
030/31:[down] &#39;!fixup &quot;hw/misc: Add limited support for AVR power =
device&quot;&#39;<br>
031/31:[down] &#39;!fixup &quot;hw/timer: Add limited support for AVR 16-bi=
t <br>
timer peripheral&quot;&#39;<br>
<br>
One thing that annoys me is we ignored the review comments from Joaquin, <b=
r>
but I think it might now be easier to address them as new patches, once <br=
>
this series is merged.<br>
<br>
I made 2 comments (definitions in incorrect patch, and definition <br>
misplaced in elf.h), and sent 2 patches converting the PRINTF() to <br>
trace-events. Thanks for preparing the rc4, hopefully we are done!<br>
<br>
&gt; <br>
&gt; Thank you,<br>
&gt; Aleksandar<br>
&gt; <br>
&gt; On Fri, Jan 31, 2020 at 1:06 AM Aleksandar Markovic<br>
&gt; &lt;<a href=3D"mailto:aleksandar.markovic@rt-rk.com" target=3D"_blank"=
>aleksandar.markovic@rt-rk.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp=
.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; This is the AVR port from Michael, release (merge) candidate 4.<br=
>
&gt;&gt;<br>
&gt;&gt; The series can be found also in this repository:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://github.com/AMarkovic/qemu-avr-merger-rc4" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/AMarkovic/qemu-avr-mer=
ger-rc4</a><br>
&gt;&gt;<br>
&gt;&gt; History:<br>
&gt;&gt;<br>
&gt;&gt; Since v3:<br>
&gt;&gt;<br>
&gt;&gt; - Removed a patch on load_elf() modification, since it has been me=
rged<br>
&gt;&gt; - Removed references to CONFIG_USER_ONLY and provided a guard agai=
nst<br>
&gt;&gt;=C2=A0 =C2=A0 building lunux user mode for AVR<br>
&gt;&gt; - Removed all references to &#39;Atmel&#39; (including file rename=
s)<br>
&gt;&gt; - Rebased the code (there was common interface change regarding &#=
39;props&#39;)<br>
&gt;&gt; - Various corrections of commit messages<br>
&gt;&gt; - A bit field for AVRFeatures is nor 64 bit long<br>
&gt;&gt; - Other minor fixes<br>
&gt;&gt;<br>
&gt;&gt; Since v2:<br>
&gt;&gt;<br>
&gt;&gt; - First patch is split into six smaller logical units (net result<=
br>
&gt;&gt;=C2=A0 =C2=A0 remains the same)<br>
&gt;&gt; - Patch &quot;hw/core/loader: Let load_elf populate the processor-=
specific<br>
&gt;&gt;=C2=A0 =C2=A0 flags&quot; was redone to reflect the original intent=
 that was lost in<br>
&gt;&gt;=C2=A0 =C2=A0 transalation between multiple autors<br>
&gt;&gt; - Patch &quot;hw/avr: Add helper to load raw/ELF firmware binaries=
&quot; was<br>
&gt;&gt;=C2=A0 =C2=A0 corrected only in one line to rectify type of &quot;e=
_flags&quot;<br>
&gt;&gt; - Patch &quot;target/avr: Add section about AVR into QEMU document=
ation&quot;<br>
&gt;&gt; - Spurious &lt;message-Id:&gt; elements were removed<br>
&gt;&gt; - The series was rebased to the latest code<br>
&gt;&gt;<br>
&gt;&gt; Since v1:<br>
&gt;&gt;<br>
&gt;&gt; - Addressed Thomas comments<br>
&gt;&gt; - Fixed a non-critical bug in ATmega (incorrect SRAM base address)=
<br>
&gt;&gt; - Added ELF parsing requested by Aleksandar<br>
&gt;&gt; - Dropped default machine (as with the ARM port)<br>
&gt;&gt;<br>
&gt;&gt; Michael Rolnik (25):<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add basic parameters for new AVR platform=
<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Introduce AVR CPU class object<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add migration support<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add GDB support<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Introduce enumeration AVRFeature<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add defintions of AVR core types<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction helpers<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation - Register de=
finitions<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation - Arithmetic =
and Logic<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Instructions<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation - Branch Inst=
ructions<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation - Data Transf=
er Instructions<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation - Bit and Bit=
-test<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Instructions<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation - MCU Control=
 Instructions<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction translation - CPU main tr=
anslation<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 function<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add instruction disassembly function<br>
&gt;&gt;=C2=A0 =C2=A0 hw/char: Add limited support for AVR USART peripheral=
<br>
&gt;&gt;=C2=A0 =C2=A0 hw/timer: Add limited support for AVR 16-bit timer pe=
ripheral<br>
&gt;&gt;=C2=A0 =C2=A0 hw/misc: Add limited support for AVR power device<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add section about AVR into QEMU documenta=
tion<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Register AVR support with the rest of QEM=
U<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Add machine none test<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Update MAINTAINERS file<br>
&gt;&gt;=C2=A0 =C2=A0 target/avr: Update build system<br>
&gt;&gt;=C2=A0 =C2=A0 tests/boot-serial-test: Test some Arduino boards (AVR=
 based)<br>
&gt;&gt;=C2=A0 =C2=A0 tests/acceptance: Test the Arduino MEGA2560 board<br>
&gt;&gt;<br>
&gt;&gt; Philippe Mathieu-Daud=C3=A9 (4):<br>
&gt;&gt;=C2=A0 =C2=A0 hw/avr: Add helper to load raw/ELF firmware binaries<=
br>
&gt;&gt;=C2=A0 =C2=A0 hw/avr: Add some ATmega microcontrollers<br>
&gt;&gt;=C2=A0 =C2=A0 hw/avr: Add some Arduino boards<br>
&gt;&gt;=C2=A0 =C2=A0 .travis.yml: Run the AVR acceptance tests<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
&gt;&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A031 +<br>
&gt;&gt;=C2=A0 =C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;&gt;=C2=A0 =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
&gt;&gt;=C2=A0 =C2=A0default-configs/avr-softmmu.mak=C2=A0 |=C2=A0 =C2=A0 5=
 +<br>
&gt;&gt;=C2=A0 =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A049 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/avr/arduino.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 151 ++<br>
&gt;&gt;=C2=A0 =C2=A0hw/avr/atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 470 ++++++<br>
&gt;&gt;=C2=A0 =C2=A0hw/avr/atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A048 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/avr/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A074 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/avr/boot.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A033 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 320 ++++<br>
&gt;&gt;=C2=A0 =C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/misc/avr_power.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 112 ++<br>
&gt;&gt;=C2=A0 =C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
&gt;&gt;=C2=A0 =C2=A0hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 604 ++++++++<br>
&gt;&gt;=C2=A0 =C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A019 +<br>
&gt;&gt;=C2=A0 =C2=A0include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;&gt;=C2=A0 =C2=A0include/hw/char/avr_usart.h=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A093 ++<br>
&gt;&gt;=C2=A0 =C2=A0include/hw/misc/avr_power.h=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A046 +<br>
&gt;&gt;=C2=A0 =C2=A0include/hw/timer/avr_timer16.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A094 ++<br>
&gt;&gt;=C2=A0 =C2=A0include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 1 +<br>
&gt;&gt;=C2=A0 =C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
&gt;&gt;=C2=A0 =C2=A0qemu-doc.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A051 +<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A034 +<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A037 +<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A054 +<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 818 +++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 259 ++++<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/disas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 246 ++++<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A084 ++<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 342 +++++<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A029 +<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 182 +++<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 121 ++<br>
&gt;&gt;=C2=A0 =C2=A0target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 2997 ++++++++++++++++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0tests/acceptance/machine_avr6.py |=C2=A0 =C2=A050 +<br=
>
&gt;&gt;=C2=A0 =C2=A0tests/qtest/Makefile.include=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 2 +<br>
&gt;&gt;=C2=A0 =C2=A0tests/qtest/boot-serial-test.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A011 +<br>
&gt;&gt;=C2=A0 =C2=A0tests/qtest/machine-none-test.c=C2=A0 |=C2=A0 =C2=A0 1=
 +<br>
&gt;&gt;=C2=A0 =C2=A046 files changed, 7508 insertions(+), 2 deletions(-)<b=
r>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 default-configs/avr-softmmu.mak<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/avr/Kconfig<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/avr/Makefile.objs<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/avr/arduino.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/avr/atmega.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/avr/atmega.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/avr/boot.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/avr/boot.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/char/avr_usart.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/avr_power.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 hw/timer/avr_timer16.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 include/hw/char/avr_usart.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/avr_power.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 include/hw/timer/avr_timer16.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/Makefile.objs<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu-param.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu-qom.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/cpu.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/disas.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/gdbstub.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/helper.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/helper.h<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/insn.decode<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/machine.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 target/avr/translate.c<br>
&gt;&gt;=C2=A0 =C2=A0create mode 100644 tests/acceptance/machine_avr6.py<br=
>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000007b356a059d709cc7--

