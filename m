Received: from eggs.gnu.org ([2001:4830:134:3::10]:39670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erwAo-0001bn-J5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 20:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erwAn-0005mM-12
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 20:41:18 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erwAm-0005m5-PW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 20:41:16 -0500
Received: by mail-ot0-x244.google.com with SMTP id t2so10421029otj.4
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 17:41:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180104205353.30f96d3b75f8a0e0dbc22583@gmail.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-4-git-send-email-mjc@sifive.com>
	<20180104094759.704eaee0a681d5ec26e9aa9d@gmail.com>
	<CAHNT7NvROn++kq96OZBwuGPhXk2DOFrCpCKycEUHTc2anR9V4w@mail.gmail.com>
	<20180104205353.30f96d3b75f8a0e0dbc22583@gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 3 Mar 2018 14:41:15 +1300
Message-ID: <CAHNT7Nv=w0MFzzEi5Eq4aC2PsjQOnaB0z2goX5ziBjy9X1FhNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 03/21] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Hi Antony,

As of v8 of the RISC-V QEMU target patch series, you can now define the
reset vector in your CPU initializer:

https://github.com/riscv/riscv-qemu/blob/qemu-upstream-v8/target/riscv/cpu.c#L110-L168

Michael.

On Fri, Jan 5, 2018 at 6:53 AM, Antony Pavlov <antonynpavlov@gmail.com>
wrote:

> On Thu, 4 Jan 2018 20:33:57 +1300
> Michael Clark <mjc@sifive.com> wrote:
>
> > On Thu, Jan 4, 2018 at 7:47 PM, Antony Pavlov <antonynpavlov@gmail.com>
> > wrote:
> >
> > > On Wed,  3 Jan 2018 13:44:07 +1300
> > > Michael Clark <mjc@sifive.com> wrote:
> > >
> > > > Add CPU state header, CPU definitions and initialization routines
> > > >
> > > > Signed-off-by: Michael Clark <mjc@sifive.com>
> > > > ---
> > > >  target/riscv/cpu.c      | 338 ++++++++++++++++++++++++++++++
> +++++++++
> > > >  target/riscv/cpu.h      | 363 ++++++++++++++++++++++++++++++
> > > ++++++++++++
> > > >  target/riscv/cpu_bits.h | 411 ++++++++++++++++++++++++++++++
> > > ++++++++++++++++++
> > > >  3 files changed, 1112 insertions(+)
> > > >  create mode 100644 target/riscv/cpu.c
> > > >  create mode 100644 target/riscv/cpu.h
> > > >  create mode 100644 target/riscv/cpu_bits.h
> > > >
> > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > >
> > > ...
> > >
> > > > +static void riscv_cpu_reset(CPUState *cs)
> > > > +{
> > > > +    RISCVCPU *cpu = RISCV_CPU(cs);
> > > > +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> > > > +    CPURISCVState *env = &cpu->env;
> > > > +
> > > > +    mcc->parent_reset(cs);
> > > > +#ifndef CONFIG_USER_ONLY
> > > > +    tlb_flush(cs);
> > > > +    env->priv = PRV_M;
> > > > +    env->mtvec = DEFAULT_MTVEC;
> > > > +#endif
> > > > +    env->pc = DEFAULT_RSTVEC;
> > >
> > > The RISC-V Privileged Architecture Manual v1.10 states that
> > >
> > >   The pc is set to an implementation-defined reset vector.
> > >
> > > But hard-coded DEFAULT_RSTVEC leaves no chance for changing reset
> vector.
> > >
> > > Can we add a mechanism for changing reset vector?
> > >
> >
> > That can be added very easily at some point when necessary.
> >
> > All 5 RISC-V machines in the QEMU port currently have their emulated Mask
> > ROMs at 0x1000 so its not necessary until we add a machine that needs a
> > different value. I certainly wouldn't reject a patch that adds that
> > functionality if we had a machine with a different reset vector, although
> > given we have 5 machines using the same vector, it may remain a sensible
> > default. I would think twice about adding a property that no machines
> sets,
> > or duplicate code and have all machines set their reset vector even when
> > they are all the same? Shall we add the functionality when we need it?
>
> Actually it is me who needs this functionality.
>
> At the moment my board code needs this dirty hack:
>
> https://github.com/miet-riscv-workgroup/riscv-qemu/commit/
> bfc8221d89b9bb828f3742f17eb89d8513a75aae#diff-
> 429448b1b26e0bc4256cc290758c0ab5
>
> >
> > I'd categorise this as a feature request. #define DEFAULT_RSTVEC
> 0x00001000
> > is the "implementation-defined reset vector"
> >
> > Folk on the RISC-V mailing list are actually seeking guidance on the
> blanks
> > in the RISC-V specification so it may be that a de-facto standard emerges
> > for some of these "implementation defined" blanks, in which case it may
> > become part of a platform spec (vs the ISA spec).
> >
> > E.g. there is the "reset-hivecs" property in the ARM emulation code
> > > so SoC-specific code can change reset vector.
>
> --
> Best regards,
>   Antony Pavlov
>
