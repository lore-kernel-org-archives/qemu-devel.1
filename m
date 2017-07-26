Received: from eggs.gnu.org ([2001:4830:134:3::10]:48585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daPGI-0008Ht-9g
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daPGH-0000Qn-8r
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:34:14 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1daPGH-0000QH-1G
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:34:13 -0400
Received: by mail-wm0-x22a.google.com with SMTP id t138so2654714wmt.1
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 09:34:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2017 17:33:51 +0100
Message-ID: <CAFEAcA-hBdr6SF2omuYrOwutmCuSA0LS+AtNUPM8UYtqctr9kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 July 2017 at 14:04, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Right now the RISC-V port for QEMU uses the classic decoding scheme of
> one function decoding the first opcode (and prefixes) and then branches
> to different functions for decoding the rest (as in target/arm or most
> of the other targets). This is all done using switch, case statements.
>
> This is a little bit tricky to extend, especially for third parties. I
> don't think it's too bad, but it can definitely be improved and I really
> like the way target/s390x does it, but I'm not sure about it's drawbacks.

(This is all purely generic QEMU design/coding viewpoint,
I know nothing about the RISC-V ISA.)

I would tend to favour writing the decoder with maintainability
in mind -- experience with the ARM QEMU decoder has been that
the "one function with a ginormous switch statement" that
the 32-bit decoder uses is really hard to maintain and
add new instruction support to. The 64-bit decoder is much
better largely because it splits the code into multiple
functions (in the same way the ISA documentation structures
the decode) and has good comments along the way about
what the current insn pattern is in terms of 0s, 1s and
don't-know-yet bits.

Data driven is nice when you can do it (the A64 decoder
does this a bit for SIMD) but the extent to which you
can do it will depend a lot on the details of the encoding
of the instruction set you're dealing with -- some are
simply not regular enough to make it pay off.

I doubt you're spending enough time in the decoder for it
to be a significant element in performance profiling
(and if you are then probably something else is wrong
like QEMU's TLB is getting flushed too often), but as
always better to measure than guess.

thanks
-- PMM
