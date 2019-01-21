Received: from eggs.gnu.org ([209.51.188.92]:42615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gldJB-0003Vo-2M
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gldJ9-0007iF-Ga
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:24:24 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gldJ9-0007hZ-BH
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:24:23 -0500
Received: by mail-oi1-x244.google.com with SMTP id t204so15123557oie.7
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
	<797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
	<20190117101309.GA27840@stefanha-x1.localdomain>
	<960bbd92-a160-a65c-22c7-9e899dc3fa78@mail.ru>
	<CAFEAcA8vWOiXS7iM8heAG5wV1u8Dh_295NbWiqcXCmar9ePuPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8vWOiXS7iM8heAG5wV1u8Dh_295NbWiqcXCmar9ePuPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 17:24:10 +0000
Message-ID: <CAFEAcA8=LMzbjFZh0tc5mRT8O2Kr3xKhk3xPgGZ_b53qp8qUvw@mail.gmail.com>
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

On Thu, 17 Jan 2019 at 19:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 17 Jan 2019 at 10:58, Julia Suvorova <jusual@mail.ru> wrote:
> >
> > On 17.01.2019 13:13, Stefan Hajnoczi wrote:
> > > generic_loader_reset() calls cpu_reset(s->cpu) followed by
> > > CPUClass->set_pc(s->cpu, s->addr).
> > >
> > > ARM's arm_cpu_set_pc() doesn't special-case the Thumb bit (that's only
> > > done in arm_cpu_reset()) so we end up with an invalid PC for Thumb mode
> > > addresses.
> > >
> > > Maybe the following arm_cpu_reset() code should be moved to
> > > arm_cpu_set_pc():
> > >
> > >    env->regs[15] = initial_pc & ~1;
> > >    env->thumb = initial_pc & 1;
> > >
> > > Then arm_cpu_reset() can call arm_cpu_set_pc() instead of duplicating
> > > this code.
> >
> > No, set_pc() is called in cpu_tb_exec() to restore the PC value and
> > therefore should not be changed.
>
> The set_pc hook is also called for the gdbstub 'c' and 's' packets
> if they supply an address. I am not sure what the correct behaviour
> there is (it might be tricky to find out or test, because the
> 'c' and 's' packets are deprecated in favour of vCont which doesn't
> allow the address argument at all, and recent gdb neither emits
> 'c addr' nor supports it in its gdbserver implementation).

I asked Linaro's gdb developer, and they thought that the gdb
'c addr' behaviour ought to be "look at bit 0 and switch to
Thumb or Arm mode accordingly".

thanks
-- PMM
