Received: from eggs.gnu.org ([2001:4830:134:3::10]:45187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ejKLM-0003id-Hm
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ejKLJ-0007z2-EX
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:40:36 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47650)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ejKLJ-0007y5-64
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:40:33 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180206124431.31433.91946.stgit@pasha-VirtualBox>
	<0dfe3d4e-fc7e-8fdf-214c-f1c7a0b6f027@vivier.eu>
	<000c01d39f4e$9af80f90$d0e82eb0$@ru>
	<144d840e-8ae8-437a-5ca8-c86593869e9b@vivier.eu>
In-Reply-To: <144d840e-8ae8-437a-5ca8-c86593869e9b@vivier.eu>
Date: Wed, 7 Feb 2018 10:40:34 +0300
Message-ID: <000301d39fe6$f011f700$d035e500$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v4] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Laurent Vivier' <laurent@vivier.eu>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: huth@tuxfamily.org

> From: Laurent Vivier [mailto:laurent@vivier.eu]
> Le 06/02/2018 =C3=A0 14:30, Pavel Dovgalyuk a =C3=A9crit :
> >> From: Laurent Vivier [mailto:laurent@vivier.eu]
> > Thanks!
> >
> > By the way, we also handled reset interrupt, but it is not =
compatible with other m68k
> platforms:
> >
> > @@ -66,8 +66,9 @@ static void m68k_cpu_reset(CPUState *s)
> >      cpu_m68k_set_fpcr(env, 0);
> >      env->fpsr =3D 0;
> >
> > -    /* TODO: We should set PC from the interrupt vector.  */
> > -    env->pc =3D 0;
> > +    env->vbr =3D 0;
> > +    /* PC and SP (for m68k) will be initialized by the reset =
handler */
> > +    s->exception_index =3D EXCP_RESET;
> >  }
> >
> > @@ -378,6 +380,8 @@ static void m68k_interrupt_all(CPUM68KState =
*env, int is_hw)
> >          cpu_m68k_set_sr(env, sr &=3D ~SR_M);
> >          sp =3D env->aregs[7] & ~1;
> >          do_stack_frame(env, &sp, 1, oldsr, 0, retaddr);
> > +    } else if (cs->exception_index =3D=3D EXCP_RESET) {
> > +        sp =3D cpu_ldl_kernel(env, env->vbr + vector - 4);
> >      } else {
> >          do_stack_frame(env, &sp, 0, oldsr, 0, retaddr);
> >      }
>=20
> It looks better of what I have already coded :)
>=20
> Do you work using code in
> https://github.com/vivier/qemu-m68k , branch q800-dev ?

No, it was a project for our students couple of years ago.
We used Qemu 2.3 with not-yet-included patches for 68000.
I believe that someday we'll port our peripherals onto the new version.

There were some fixes for processing the interrupts. As I can see, all =
of them are
not needed for the mainline Qemu.

We didn't find a solution for 24-bit address bus of 68000. Macintosh =
stores 32-bit values=20
in address registers and uses them to access the memory. We just =
duplicated the memory layout,
but I believe that there is a better solution.

> I'm already emulating a Quadra 800, it can help for Macintosh-128k

Here is the repository with Mac-128: https://github.com/Dovgalyuk/qemu
We didn't finally fix all the bugs, but it can boot the OS, using some =
hacks.
One of the hack is related to IWM. We couldn't emulate all timings for =
that.
CPU controls disk rotation speed through controlling the strobe signal.
It was hard to synchronize this, because icount wasn't fully working and =
we used
semihosting - we intercepted the file operation system calls and didn't =
execute
ROM code, emulating them in Qemu instead.

Pavel Dovgalyuk
