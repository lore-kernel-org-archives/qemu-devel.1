Received: from eggs.gnu.org ([2001:4830:134:3::10]:51756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eX9Ul-0005ny-GA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eX9Uh-0002r6-8Q
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:39:59 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:42569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1eX9Uh-0002qB-1J
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:39:55 -0500
Received: by mail-lf0-x242.google.com with SMTP id e27so2556395lfb.9
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:39:54 -0800 (PST)
Date: Thu, 4 Jan 2018 20:53:53 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20180104205353.30f96d3b75f8a0e0dbc22583@gmail.com>
In-Reply-To: <CAHNT7NvROn++kq96OZBwuGPhXk2DOFrCpCKycEUHTc2anR9V4w@mail.gmail.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-4-git-send-email-mjc@sifive.com>
	<20180104094759.704eaee0a681d5ec26e9aa9d@gmail.com>
	<CAHNT7NvROn++kq96OZBwuGPhXk2DOFrCpCKycEUHTc2anR9V4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 03/21] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Thu, 4 Jan 2018 20:33:57 +1300
Michael Clark <mjc@sifive.com> wrote:

> On Thu, Jan 4, 2018 at 7:47 PM, Antony Pavlov <antonynpavlov@gmail.com>
> wrote:
>=20
> > On Wed,  3 Jan 2018 13:44:07 +1300
> > Michael Clark <mjc@sifive.com> wrote:
> >
> > > Add CPU state header, CPU definitions and initialization routines
> > >
> > > Signed-off-by: Michael Clark <mjc@sifive.com>
> > > ---
> > >  target/riscv/cpu.c      | 338 +++++++++++++++++++++++++++++++++++++++
> > >  target/riscv/cpu.h      | 363 ++++++++++++++++++++++++++++++
> > ++++++++++++
> > >  target/riscv/cpu_bits.h | 411 ++++++++++++++++++++++++++++++
> > ++++++++++++++++++
> > >  3 files changed, 1112 insertions(+)
> > >  create mode 100644 target/riscv/cpu.c
> > >  create mode 100644 target/riscv/cpu.h
> > >  create mode 100644 target/riscv/cpu_bits.h
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >
> > ...
> >
> > > +static void riscv_cpu_reset(CPUState *cs)
> > > +{
> > > +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> > > +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> > > +    CPURISCVState *env =3D &cpu->env;
> > > +
> > > +    mcc->parent_reset(cs);
> > > +#ifndef CONFIG_USER_ONLY
> > > +    tlb_flush(cs);
> > > +    env->priv =3D PRV_M;
> > > +    env->mtvec =3D DEFAULT_MTVEC;
> > > +#endif
> > > +    env->pc =3D DEFAULT_RSTVEC;
> >
> > The RISC-V Privileged Architecture Manual v1.10 states that
> >
> >   The pc is set to an implementation-defined reset vector.
> >
> > But hard-coded DEFAULT_RSTVEC leaves no chance for changing reset vecto=
r.
> >
> > Can we add a mechanism for changing reset vector?
> >
>=20
> That can be added very easily at some point when necessary.
>=20
> All 5 RISC-V machines in the QEMU port currently have their emulated Mask
> ROMs at 0x1000 so its not necessary until we add a machine that needs a
> different value. I certainly wouldn't reject a patch that adds that
> functionality if we had a machine with a different reset vector, although
> given we have 5 machines using the same vector, it may remain a sensible
> default. I would think twice about adding a property that no machines set=
s,
> or duplicate code and have all machines set their reset vector even when
> they are all the same? Shall we add the functionality when we need it?

Actually it is me who needs this functionality.

At the moment my board code needs this dirty hack:

https://github.com/miet-riscv-workgroup/riscv-qemu/commit/bfc8221d89b9bb828=
f3742f17eb89d8513a75aae#diff-429448b1b26e0bc4256cc290758c0ab5

>=20
> I'd categorise this as a feature request. #define DEFAULT_RSTVEC 0x000010=
00
> is the "implementation-defined reset vector"
>=20
> Folk on the RISC-V mailing list are actually seeking guidance on the blan=
ks
> in the RISC-V specification so it may be that a de-facto standard emerges
> for some of these "implementation defined" blanks, in which case it may
> become part of a platform spec (vs the ISA spec).
>=20
> E.g. there is the "reset-hivecs" property in the ARM emulation code
> > so SoC-specific code can change reset vector.

--=20
Best regards,
=A0 Antony Pavlov
