Received: from eggs.gnu.org ([2001:4830:134:3::10]:44936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQeOd-0000sI-K1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQeOc-0004Q7-Me
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:42:31 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQeOc-0004PV-Fo
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:42:30 -0400
Received: by mail-wm0-x234.google.com with SMTP id b184so23925271wme.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 11:42:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57ad91ad-7cc4-913f-7f45-c5906779bedf@amsat.org>
References: <57ad91ad-7cc4-913f-7f45-c5906779bedf@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 19:42:08 +0100
Message-ID: <CAFEAcA9HLbnZnfBisNLPnKuf364kPtq8=0soFmovYRzRWrOtkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] disas: Disassembler disagrees with translator over
 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

On 29 June 2017 at 19:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> I got this "Disassembler disagrees with translator over instruction
> decoding" message asking to get reported here.
>
> What happens here is coreboot incorrectly emits a Pentium2 instruction wh=
ile
> I'm running qemu with a Pentium cpu. I didn't know what to expect but got
> this error message, then qemu keep looping using 100% cpu.

So the primary cause of this message is when the disassembler
(ie disas/) says "the insn at this PC is X bytes long", but
the size it got passed by the translator in target/whatever
is not X. Since the size passed to target_disas() is usually
"start PC of insn minus PC of insn after it's been advanced
by the decoder", this works OK for insns correctly understood
and also for insns which are fixed-length (or easily-identified
length like Thumb). But it doesn't work if insns are variable
length and the decoder bails out to "illegal instruction"
early, like the i386 decoder does.

(Specifically in this instance we check for CPUID_CMOV and
bail out before doing the cpu_ldub_code() of the modrm byte.)

I think we should either:
 (1) be a lot more careful in decoders for variable-length
insn sets that we really read all the bytes of an insn before
deciding it's an illegal encoding
 (2) decide that this warning message is more trouble than it's
worth and get rid of it entirely (has it ever genuinely
flagged up a bug for anybody?)
 (3) provide a mechanism for the decoder to say "I didn't
actually decode the whole insn so I have no idea how big it is"

There are probably some annoying corner cases involving
variable length instructions that cross page boundaries
where the 2nd page is not readable and the decoder bails
out early: does real hardware give an insn abort or an
illegal insn exception in that kind of case?

thanks
-- PMM
