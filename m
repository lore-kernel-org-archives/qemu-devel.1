Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hHmrm-000119-FZ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hHmdG-0005HP-Qj
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:50:04 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hHmdG-0005GV-M6
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:50:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so2646097ywd.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 02:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190419103722.17062-1-shahab.vahedi@gmail.com>
	<871s1xha0f.fsf@zen.linaroharston>
In-Reply-To: <871s1xha0f.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 20 Apr 2019 11:49:48 +0200
Message-ID: <CAAdtpL5yj3dDoxQ+_V32MDPE3bYa15wGHKSBOEgGdDSujPxgxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Shahab Vahedi <shahab.vahedi@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Alex,

Le sam. 20 avr. 2019 01:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> a =C3=
=A9crit :

>
> Shahab Vahedi <shahab.vahedi@gmail.com> writes:
>
> > This change adapts io_readx() to its input access_type. Currently
> > io_readx() treats any memory access as a read, although it has an
> > input argument "MMUAccessType access_type". This results in:
> >
> > 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> > 2) Considering only entry->addr_read as the tlb_addr
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
>
> This bug talks about the distinction between DATA_LOAD and INST_FETCH
> but...
>
> >
> > Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> > ---
> >  accel/tcg/cputlb.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 88cc8389e9..0daac0e806 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env,
> CPUIOTLBEntry *iotlbentry,
> >          CPUTLBEntry *entry;
> >          target_ulong tlb_addr;
> >
> > -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> > +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
> >
> >          entry =3D tlb_entry(env, mmu_idx, addr);
> > -        tlb_addr =3D entry->addr_read;
> > +        tlb_addr =3D
> > +            (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  :
> > +            (access_type =3D=3D MMU_DATA_STORE) ? entry->addr_write :
> > +            entry->addr_code;
>
> ...why do we care here about MMU_DATA_STORE?
>
> We could just assert (access_type =3D=3D MMU_DATA_LOAD || access_type =3D=
=3D
> MMU_INST_FETCH) and then have:
>

Is asserting the best we can do here?


>   (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  : entry->addr_c=
ode
>
>
> >          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
> >              /* RAM access */
> >              uintptr_t haddr =3D addr + entry->addend;
>
>
> --
> Alex Benn=C3=A9e
>
>
