Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B57FC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 16:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C34920781
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzV4jrFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C34920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDA0G-00024I-HS
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jD9zZ-0001Zg-M3
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 12:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jD9zY-00079N-2D
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 12:50:29 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jD9zX-00074K-Td
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 12:50:28 -0400
Received: by mail-oi1-x243.google.com with SMTP id k18so13053552oib.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ektfUbo1SBT4U2kfnVdISmux4RrqxQnRFs9BuEs5sJg=;
 b=pzV4jrFI4wsCIz24TMfbIWEqFBPhldlKHmYhVbwu/d2MgOk29tesQryrLxwtkrVxjR
 BZjj7lJxrTO7T0bCmWaZldZUX4QCWxLD3NaAITojY5GBxv4j/WCValSDBJALVfzJAQeJ
 FV9+SsmUFsJBZowS0bag2wQo4mmjR71B3iJY4WlqlX1SOAJ4vArSfVq+USCz4TRqjIY5
 9yDixbGdAH2mjG1IuIGkt0HvrFuYVV8Pt7ccDSb/bj+AK2u9G0Q2NlC67GQeuAH+e2s2
 Uiipyt+Bk39kD2RwqhRLhU0izjqpYBogtE6Br/mE4Zq2fFxAzoFGJ1lNUtY9sYTKVcu7
 bbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ektfUbo1SBT4U2kfnVdISmux4RrqxQnRFs9BuEs5sJg=;
 b=ufqk9l/mB3gxvuljRMYWclu3zv5J3JXMjPfLivSFV5loOR6vCm7FmvT706Nnn2Z1cv
 YyPNsFSjN9wCuZvmsOMbTi3a/Tr31FMsNUbSoowqzA4b0Ywi/Y+0bX6MO6KtH7qL84YT
 jrxeSnsBVSNaIP3E3slTMcUKJqvHRzrikTcA2TRR+fgN0Jm7M8Ev8EoGqL976Z0ff11d
 992XiWjoBDO3xvYa9LuJx0MABrKLtabhnTDfy0G1q4Mw8abWrle9u1EiTa50PawJATZx
 6JAxDB8wMBDJVegiH1I7UuFlc+Jwn6041QXhzPEzpxTMqJz6gqvoRSEnknAinW0QsbVq
 GtwA==
X-Gm-Message-State: ANhLgQ1Y+GeFcg7n1c4rdA8nV1+jW4BCl+Rr0uQ8MwJzmwcisxvyZhG4
 uxYwIhtTdIL1fhvmnCpSX2vJZwZI1mk1leR5FKE=
X-Google-Smtp-Source: ADFU+vtIM9QK0TpJ+kR9QBhkN2sR4UWxWoxP6nQJoeMAseRaF5IcS06NGEds2BIfXLBFBmqI/sml5f3wOxYsxDZQqiw=
X-Received: by 2002:aca:3c45:: with SMTP id j66mr11722831oia.62.1584204625852; 
 Sat, 14 Mar 2020 09:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
 <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
 <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
 <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
 <170d9007c8b.13c0df0018230.8565583190152644951@flygoat.com>
In-Reply-To: <170d9007c8b.13c0df0018230.8565583190152644951@flygoat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 14 Mar 2020 17:50:14 +0100
Message-ID: <CAL1e-=hty0caX_odd_ere0E6rx3yXdhhSx=Dxm7Z+uN=SR84jg@mail.gmail.com>
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 Peter Maydell <peter.maydell@linaro.org>, Yunqiang Su <ysu@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <paul.burton@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 1:28 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote=
:
>
>
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=85=AD, 2020-03-14 17:09:08 Philippe=
 Mathieu-Daud=C3=A9 <philmd@redhat.com> =E6=92=B0=E5=86=99 ----
>  > Hi Aleksandar,
>  >
>
>  > >>
>  > >> This is annoying, because the CoreLV/CoreFPGA core cards only have =
4
>  > >> DIMM slots for PC-100 SDRAM, and the Memory Controller of the GT=E2=
=80=9364120A
>  > >> north bridge accept at most 256 MiB per SCS for address decoding, s=
o we
>  > >> have a maximum of 1 GiB on 32-bit boards.
>  > >>
>  > >> In 64-bit emulation we use the a 20Kc core, provided by the Core20K=
 core
>  > >> card which doesn't use the GT=E2=80=9364120A but the Bonito64. So t=
he model is
>  > >> incorrect... The Bonito64 indeed allow more memory.
>  > >>
>  > >> Maybe it is time to consider that for 64-bit targets, since we are =
not
>  > >> modelling a Malta core board, we can name it the official 'virt' ma=
chine...
>  > >>
>  > >
>  > > Philippe, I almost agree 100% with you wrt last three paragraphs.
>  > > (in any case, I know much less than you about details of GT-64120A
>  > > and Bonito64, but I trust you).
>  > >
>  > > The only area I have a slightly different opinion is that I believe =
we
>  > > should never declare Malta as a virtual board, and try to be within =
the
>  > > boundaries of physical capabilities of real boards, even if in softw=
are
>  > > (QEMU) we could "enhance" some features.
>  > >
>  > > If we want MIPS virtual board, than we should devise a full blown
>  > > virtual board, similar to what was already done for MIPS Android
>  > > emulator. I really don't want some real/virtual frankenstein in QEMU
>  > > upstream just because it is convenient for let's say a particular
>  > > test setup.
>
> So probably it's time to work on a "virt" machine. What style would you p=
refer?
> PC-like or SoC style?
>

It is time, agreed.

Let's explore multiple alternatives, analyze pros and cons, and not rush
into conclusions. There are several important factors to take into account:
presence of kernel and QEMU support for involved devices, target users,
other virtual machines in QEMU, relation to the general QEMU architecture,
available time resources, etc.

> In fact we've got two pseudo board (mips, mipssim) for MIPS,
> but non of them seems modern enough.
>

They are terribly outdated, true.

> I can launch a Loongson-3 style board after dealing with Kernel code clea=
n-up.
>

Absolutely! You would be welcomed.

Yours,
Aleksandar

>  >
>  > IIUC today all distributions supporting MIPS ports are building their
>  > MIPS packages on QEMU instances because it is faster than the native
>  > MIPS hardware they have.
>  >
>  > Since one (or two?) years, some binaries (Linux kernel? QEMU?) are
>  > failing to link because the amount of guest memory is restricted to 2G=
B
>  > (probably advance of linker techniques, now linkers use more memory).
>  >
>  > YunQiang, is this why you suggested this change?
>  >
>  > See:
>  > - https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.h=
tml
>  > -
>  > https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-Ja=
nuary/004844.html
>  >
>  > I believe most of the QEMU Malta board users don't care it is a Malta
>  > board, they only care it is a fast emulated MIPS machine.
>  > Unfortunately it is the default board.
>
> Yeah. That's the truth.
>
>  >
>  > However 32-bit MIPS port is being dropped on Debian:
>  > https://lists.debian.org/debian-mips/2019/07/msg00010.html
>
> mipsel (MIPS 32-bit Little Endian) is still alive. I believe Debian won't=
 give up it as long as i386
> still exist.
>
>  >
>  > Maybe we can sync with the Malta users, ask them to switch to the Bost=
on
>  > machines to build 64-bit packages, then later reduce the Malta board t=
o 1GB.
>  > (The Boston board is more recent, but was not available at the time
>  > users started to use QEMU to build 64-bit packages).
>  >
>  > Might it be easier starting introducing a malta-5.0 machine restricted
>  > to 1GB?
>  >
>  > >
>  > > Aleksandar
>  > >
>  > >>>            exit(1);
>  > >>>        }
>  > >>> +#endif
>  > >>>
>  > >>>        /* register RAM at high address where it is undisturbed by =
IO */
>  > >>>        memory_region_add_subregion(system_memory, 0x80000000, mach=
ine->ram);
>  > >>>
>  > >>
>  > >>
>  > >
>  >
>  >
>
>
> --
> Jiaxun Yang
>

