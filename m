Received: from eggs.gnu.org ([2001:4830:134:3::10]:49339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1eeI5c-0003yd-6M
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 05:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1eeI5b-0004VK-47
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 05:15:32 -0500
Date: Wed, 24 Jan 2018 11:15:25 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Message-ID: <20180124101525.GA4727@bogon.m.sigxcpu.org>
References: <39441aea4e2d05cc505ed3a373e81d3869eb994a.1516785202.git.agx@sigxcpu.org>
	<7a025be3-2f5c-2970-339e-1dee6d80d15b@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7a025be3-2f5c-2970-339e-1dee6d80d15b@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix register used for 6th
 syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

Hi,
On Wed, Jan 24, 2018 at 10:59:05AM +0100, Laurent Vivier wrote:
> Le 24/01/2018 =E0 10:14, Guido G=FCnther a =E9crit=A0:
> > Unbreaks the testcase from
> >=20
> >     http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.ht=
ml
> >=20
> > Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> > ---
> >  linux-user/host/aarch64/safe-syscall.inc.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/linux-user/host/aarch64/safe-syscall.inc.S b/linux-user/=
host/aarch64/safe-syscall.inc.S
> > index 58a2329b37..e4fbc31454 100644
> > --- a/linux-user/host/aarch64/safe-syscall.inc.S
> > +++ b/linux-user/host/aarch64/safe-syscall.inc.S
> > @@ -36,7 +36,7 @@ safe_syscall_base:
> >  	 *               and return the result in x0
> >  	 * and the syscall instruction needs
> >  	 *               x8 =3D=3D syscall number
> > -	 *               x0 ... x7 =3D=3D syscall arguments
> > +	 *               x0 ... x5 =3D=3D syscall arguments
> >  	 *               and returns the result in x0
> >  	 * Shuffle everything around appropriately.
> >  	 */
> > @@ -47,7 +47,7 @@ safe_syscall_base:
> >  	mov	x2, x4
> >  	mov	x3, x5
> >  	mov	x4, x6
> > -	mov	x6, x7
> > +	mov	x5, x7
> >  	ldr	x7, [sp]
> > =20
> >  	/* This next sequence of code works in conjunction with the
> >=20
>=20
> According to glibc/unix/sysv/linux/aarch64/syscall.S:
>=20
>   AArch64 system calls take between 0 and 7 arguments.
>   ... and any other system call arguments are in register x1..x7.
>=20
> And it seems for qemu last argument is on the stack.
> ...
>          x2 ... x7, (stack) =3D=3D syscall arguments
> ...
>=20
> Should we have something like this?
>=20
> @@ -47,8 +47,8 @@ safe_syscall_base:
>         mov     x2, x4
>         mov     x3, x5
>         mov     x4, x6
> -       mov     x6, x7
> -       ldr     x7, [sp]
> +       mov     x5, x7
> +       ldr     x6, [sp]
>=20
>         /* This next sequence of code works in conjunction with the
>          * rewind_if_safe_syscall_function(). If a signal is taken
>=20
> But do we need to set x7 from the stack too?

That makes sense. The maximum number of arguments in
linux-user/syscall.c is syscall6 so we won't notice but it's better to
have this correct, I'll send an updated patch.
Cheers
 -- Guido
