Received: from eggs.gnu.org ([2001:4830:134:3::10]:52650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiPWT-00009Y-Jw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiPWP-00043g-SJ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:32:32 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fiPWP-00041k-Cd
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:32:29 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so15936958oib.9
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 12:32:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <17945e3f-9caf-b153-4c45-56d005f27a72@linaro.org>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-19-git-send-email-stefan.markovic@rt-rk.com>
	<17945e3f-9caf-b153-4c45-56d005f27a72@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jul 2018 20:32:08 +0100
Message-ID: <CAFEAcA_9XeY=Xkb7SA5HX0wxWgpHD_-g=nb0FtN8W+tNobtZwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 18/40] target/mips: Add emulation of
 nanoMIPS 32-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Markovic <stefan.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe.mathieu.daude@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 20 July 2018 at 05:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 07/19/2018 05:54 AM, Stefan Markovic wrote:
>> +                /* SYNCI */
>> +                /* Break the TB to be able to sync copied instructions
>> +                   immediately */
>> +                ctx->base.is_jmp = DISAS_STOP;
>
> I'll note for future cleanup that while this matches all of the other instances
> of SYNCI in target/mips/, this is not actually required.
>
> QEMU supports self-modifying code without any barriers or breaks whatsoever.
> (Becuase, of course, i386 as a guest requires this.)

This is true, but only if the target/ code defines
TARGET_HAS_PRECISE_SMC (which at the moment only target/i386
does), which enables some complicated code that spots
when the current TB is being modified. Most of our
other targets only support self-modifying code which
has some kind of barrier insn, and break the TB at
the barrier. (Compare Arm's handling of "isb", though
there there is also an architectural requirement to take
any pending interrupts at the barrier; I don't know if
MIPS has any similar interrupt related semantics for
their SYNCI.)

thanks
-- PMM
