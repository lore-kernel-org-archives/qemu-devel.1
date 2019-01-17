Received: from eggs.gnu.org ([209.51.188.92]:57980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkDKT-0007tc-5G
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkDKS-0001q1-Er
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:27:53 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkDKR-0001nI-W4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:27:52 -0500
Received: by mail-oi1-x243.google.com with SMTP id x23so7096810oix.3
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 11:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
	<797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
	<20190117101309.GA27840@stefanha-x1.localdomain>
	<960bbd92-a160-a65c-22c7-9e899dc3fa78@mail.ru>
In-Reply-To: <960bbd92-a160-a65c-22c7-9e899dc3fa78@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 19:27:39 +0000
Message-ID: <CAFEAcA8vWOiXS7iM8heAG5wV1u8Dh_295NbWiqcXCmar9ePuPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Alistair Francis <alistair23@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 17 Jan 2019 at 10:58, Julia Suvorova <jusual@mail.ru> wrote:
>
> On 17.01.2019 13:13, Stefan Hajnoczi wrote:
> > generic_loader_reset() calls cpu_reset(s->cpu) followed by
> > CPUClass->set_pc(s->cpu, s->addr).
> >
> > ARM's arm_cpu_set_pc() doesn't special-case the Thumb bit (that's only
> > done in arm_cpu_reset()) so we end up with an invalid PC for Thumb mode
> > addresses.
> >
> > Maybe the following arm_cpu_reset() code should be moved to
> > arm_cpu_set_pc():
> >
> >    env->regs[15] = initial_pc & ~1;
> >    env->thumb = initial_pc & 1;
> >
> > Then arm_cpu_reset() can call arm_cpu_set_pc() instead of duplicating
> > this code.
>
> No, set_pc() is called in cpu_tb_exec() to restore the PC value and
> therefore should not be changed.

The set_pc hook is also called for the gdbstub 'c' and 's' packets
if they supply an address. I am not sure what the correct behaviour
there is (it might be tricky to find out or test, because the
'c' and 's' packets are deprecated in favour of vCont which doesn't
allow the address argument at all, and recent gdb neither emits
'c addr' nor supports it in its gdbserver implementation).

I notice that the MIPS set_pc() hook implementation does
set the M16 bit based on the low bit of the PC value;
they avoid the problem in cpu_tb_exec() by providing
the alternative synchronize_from_tb hook instead.

I think that probably what we ought to do is define that:
 * set_pc has the logic that does whatever is expected
   when the user sets the PC either by hand or when a
   ELF file is loaded
 * if that is not what is wanted in cpu_tb_exec() then
   the target must implement the synchronize_from_tb hook
   as well

The trick here is figuring out whether we have a coherent
cross-architecture definition of what we want set_pc's
behaviour to be (or at least, if we are just baking in
"act like an ELF file" we should document that...)

thanks
-- PMM
