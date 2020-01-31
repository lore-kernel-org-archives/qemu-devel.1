Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C254C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D507F2067C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyHNHoRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D507F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJwm-0000fm-1q
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixJvN-00073e-M6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixJvL-0001kQ-T4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:12:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixJvL-0001ek-Ll
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:12:39 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so4896725otp.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WO+/rxSuvLS9jRhP3Q6B1kM76Uh95qSAdjN054WH6EM=;
 b=WyHNHoRLrTqmuJCafB80fnfhNXuilQtSKrJhSKg24RpHrJ5KsoR5biwOYDh9PTIxMQ
 2h5nvNhat+wiBL6inLbLBD78Wg+fTFTeq5ZAOoxrqm+sI9t78QJokrwDIG9RnRb2ZFth
 UW+pNa/fd4Kxou6rFWEDUQ8yBl6+6QFJYPUfEHCBTA2XkO+Kc6kBGzwNakWLFcOxy2M+
 a100AcAPrET/MLqSbMKG78WJTeusOJAzk8BM0WrQaI3Lw5qpNhyVoScJbes7IlFpqVLz
 3Z4ZqyqWaQbALTXuBUEKz8akKSYItZiV007bftK6aJzk/uOzTRBCCQ846Dsh+dkuhoHi
 Tysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WO+/rxSuvLS9jRhP3Q6B1kM76Uh95qSAdjN054WH6EM=;
 b=XPdZnAv+2Rg7PW5PdLXw+MIYWC6PxCgMLrxpX+Ynwuq571NeDL6Hw+jeyy4kE472LU
 GyrDBSGUSAQYybHOPs5NiWZ1kVyAZ/uGMbIe1cRDRv9qC4x1Yl1BEiD73kHr/pu/D3ei
 XulM5Ab5llOMHoleOtEk2nTY6Fne3MhKReiV6Ftmm26q8f3aF5NIyZztEQAeqRzdBCLj
 yW9sWfYzPL4AW8zuud4ypo8YPYmFT/L3iW0Lg1qkUIOMz9dpPrj4vPpzuUmfbzOglDZa
 U4tvFDVhGwypX0LFglVNAop4o26aKX0EUOvByhJB31lkiYfuzR2+96puADVtYBGruqrW
 EBEg==
X-Gm-Message-State: APjAAAUO7sviijl8+6q8wYLNzn0j6bvc4Hy8zRYqd66pAuXTMsFR7M2T
 Y5xGMoq+Blx1eUVUc7ubOE6pCTpOzXkyeOnlePQ=
X-Google-Smtp-Source: APXvYqyrGpQvSoROlY1eXat5/Bo+8d9kFQKaYf2M1bItoUdnG9FS5vwg9hjqUKdXKZnlbWv7L2jUhh2hBs+4e8irz50=
X-Received: by 2002:a05:6830:12c3:: with SMTP id
 a3mr5757363otq.341.1580429544339; 
 Thu, 30 Jan 2020 16:12:24 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 01:12:13 +0100
Message-ID: <CAL1e-=jVVSad52xEe0Fich+iWywmPtmtR2P9KLjeMtYNC1JqwQ@mail.gmail.com>
Subject: Re: [PATCH rc4 00/29] target/avr merger
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael, Philippe,

Can you guys do a quick checkup of this rc4? rc4, rc3,and rc2 should
be functionally 100% equivalent.

Thank you,
Aleksandar

On Fri, Jan 31, 2020 at 1:06 AM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This is the AVR port from Michael, release (merge) candidate 4.
>
> The series can be found also in this repository:
>
> https://github.com/AMarkovic/qemu-avr-merger-rc4
>
> History:
>
> Since v3:
>
> - Removed a patch on load_elf() modification, since it has been merged
> - Removed references to CONFIG_USER_ONLY and provided a guard against
>   building lunux user mode for AVR
> - Removed all references to 'Atmel' (including file renames)
> - Rebased the code (there was common interface change regarding 'props')
> - Various corrections of commit messages
> - A bit field for AVRFeatures is nor 64 bit long
> - Other minor fixes
>
> Since v2:
>
> - First patch is split into six smaller logical units (net result
>   remains the same)
> - Patch "hw/core/loader: Let load_elf populate the processor-specific
>   flags" was redone to reflect the original intent that was lost in
>   transalation between multiple autors
> - Patch "hw/avr: Add helper to load raw/ELF firmware binaries" was
>   corrected only in one line to rectify type of "e_flags"
> - Patch "target/avr: Add section about AVR into QEMU documentation"
> - Spurious <message-Id:> elements were removed
> - The series was rebased to the latest code
>
> Since v1:
>
> - Addressed Thomas comments
> - Fixed a non-critical bug in ATmega (incorrect SRAM base address)
> - Added ELF parsing requested by Aleksandar
> - Dropped default machine (as with the ARM port)
>
> Michael Rolnik (25):
>   target/avr: Add basic parameters for new AVR platform
>   target/avr: Introduce AVR CPU class object
>   target/avr: Add migration support
>   target/avr: Add GDB support
>   target/avr: Introduce enumeration AVRFeature
>   target/avr: Add defintions of AVR core types
>   target/avr: Add instruction helpers
>   target/avr: Add instruction translation - Register definitions
>   target/avr: Add instruction translation - Arithmetic and Logic
>     Instructions
>   target/avr: Add instruction translation - Branch Instructions
>   target/avr: Add instruction translation - Data Transfer Instructions
>   target/avr: Add instruction translation - Bit and Bit-test
>     Instructions
>   target/avr: Add instruction translation - MCU Control Instructions
>   target/avr: Add instruction translation - CPU main translation
>     function
>   target/avr: Add instruction disassembly function
>   hw/char: Add limited support for AVR USART peripheral
>   hw/timer: Add limited support for AVR 16-bit timer peripheral
>   hw/misc: Add limited support for AVR power device
>   target/avr: Add section about AVR into QEMU documentation
>   target/avr: Register AVR support with the rest of QEMU
>   target/avr: Add machine none test
>   target/avr: Update MAINTAINERS file
>   target/avr: Update build system
>   tests/boot-serial-test: Test some Arduino boards (AVR based)
>   tests/acceptance: Test the Arduino MEGA2560 board
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/avr: Add helper to load raw/ELF firmware binaries
>   hw/avr: Add some ATmega microcontrollers
>   hw/avr: Add some Arduino boards
>   .travis.yml: Run the AVR acceptance tests
>
>  .travis.yml                      |    2 +-
>  MAINTAINERS                      |   31 +
>  arch_init.c                      |    2 +
>  configure                        |    7 +
>  default-configs/avr-softmmu.mak  |    5 +
>  gdb-xml/avr-cpu.xml              |   49 +
>  hw/avr/Kconfig                   |    9 +
>  hw/avr/Makefile.objs             |    3 +
>  hw/avr/arduino.c                 |  151 ++
>  hw/avr/atmega.c                  |  470 ++++++
>  hw/avr/atmega.h                  |   48 +
>  hw/avr/boot.c                    |   74 +
>  hw/avr/boot.h                    |   33 +
>  hw/char/Kconfig                  |    3 +
>  hw/char/Makefile.objs            |    1 +
>  hw/char/avr_usart.c              |  320 ++++
>  hw/misc/Kconfig                  |    3 +
>  hw/misc/Makefile.objs            |    2 +
>  hw/misc/avr_power.c              |  112 ++
>  hw/timer/Kconfig                 |    3 +
>  hw/timer/Makefile.objs           |    2 +
>  hw/timer/avr_timer16.c           |  604 ++++++++
>  include/disas/dis-asm.h          |   19 +
>  include/elf.h                    |    2 +
>  include/hw/char/avr_usart.h      |   93 ++
>  include/hw/misc/avr_power.h      |   46 +
>  include/hw/timer/avr_timer16.h   |   94 ++
>  include/sysemu/arch_init.h       |    1 +
>  qapi/machine.json                |    3 +-
>  qemu-doc.texi                    |   51 +
>  target/avr/Makefile.objs         |   34 +
>  target/avr/cpu-param.h           |   37 +
>  target/avr/cpu-qom.h             |   54 +
>  target/avr/cpu.c                 |  818 +++++++++++
>  target/avr/cpu.h                 |  259 ++++
>  target/avr/disas.c               |  246 ++++
>  target/avr/gdbstub.c             |   84 ++
>  target/avr/helper.c              |  342 +++++
>  target/avr/helper.h              |   29 +
>  target/avr/insn.decode           |  182 +++
>  target/avr/machine.c             |  121 ++
>  target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++++=
++++++
>  tests/acceptance/machine_avr6.py |   50 +
>  tests/qtest/Makefile.include     |    2 +
>  tests/qtest/boot-serial-test.c   |   11 +
>  tests/qtest/machine-none-test.c  |    1 +
>  46 files changed, 7508 insertions(+), 2 deletions(-)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 gdb-xml/avr-cpu.xml
>  create mode 100644 hw/avr/Kconfig
>  create mode 100644 hw/avr/Makefile.objs
>  create mode 100644 hw/avr/arduino.c
>  create mode 100644 hw/avr/atmega.c
>  create mode 100644 hw/avr/atmega.h
>  create mode 100644 hw/avr/boot.c
>  create mode 100644 hw/avr/boot.h
>  create mode 100644 hw/char/avr_usart.c
>  create mode 100644 hw/misc/avr_power.c
>  create mode 100644 hw/timer/avr_timer16.c
>  create mode 100644 include/hw/char/avr_usart.h
>  create mode 100644 include/hw/misc/avr_power.h
>  create mode 100644 include/hw/timer/avr_timer16.h
>  create mode 100644 target/avr/Makefile.objs
>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu-qom.h
>  create mode 100644 target/avr/cpu.c
>  create mode 100644 target/avr/cpu.h
>  create mode 100644 target/avr/disas.c
>  create mode 100644 target/avr/gdbstub.c
>  create mode 100644 target/avr/helper.c
>  create mode 100644 target/avr/helper.h
>  create mode 100644 target/avr/insn.decode
>  create mode 100644 target/avr/machine.c
>  create mode 100644 target/avr/translate.c
>  create mode 100644 tests/acceptance/machine_avr6.py
>
> --
> 2.7.4
>
>

