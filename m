Received: from eggs.gnu.org ([2001:4830:134:3::10]:48134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciWSM-0008Nr-1A
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciWSK-0003VL-Hv
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:19:57 -0500
Date: Tue, 28 Feb 2017 12:09:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228010905.GM17615@umbus.fritz.box>
References: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
	<23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PCv3LdRyJ68gHPUM"
Content-Disposition: inline
In-Reply-To: <23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] linux-user: fill target
 sigcontext struct accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, riku.voipio@iki.fi, qemu-ppc@nongnu.org


--PCv3LdRyJ68gHPUM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 09:43:57PM +0100, Laurent Vivier wrote:
> Le 31/01/2017 =E0 23:05, Jose Ricardo Ziviani a =E9crit :
> > A segfault is noticed when an emulated program uses any of ucontext
> > regs fields. Risu detected this issue in the following operation when
> > handling a signal:
> >   ucontext_t *uc =3D (ucontext_t*)uc;
> >   uc->uc_mcontext.regs->nip +=3D 4;
> >=20
> > but this works fine:
> >   uc->uc_mcontext.gp_regs[PT_NIP] +=3D 4;
> >=20
> > This patch set regs to a valid location as well as other sigcontext
> > fields.
> >=20
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> >  linux-user/signal.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/linux-user/signal.c b/linux-user/signal.c
> > index 5064de0..8209539 100644
> > --- a/linux-user/signal.c
> > +++ b/linux-user/signal.c
> > @@ -5155,6 +5155,7 @@ static void setup_rt_frame(int sig, struct target=
_sigaction *ka,
> >      target_ulong rt_sf_addr, newsp =3D 0;
> >      int i, err =3D 0;
> >  #if defined(TARGET_PPC64)
> > +    struct target_sigcontext *sc =3D 0;
> >      struct image_info *image =3D ((TaskState *)thread_cpu->opaque)->in=
fo;
> >  #endif
> > =20
> > @@ -5183,6 +5184,10 @@ static void setup_rt_frame(int sig, struct targe=
t_sigaction *ka,
> >  #if defined(TARGET_PPC64)
> >      mctx =3D &rt_sf->uc.tuc_sigcontext.mcontext;
> >      trampptr =3D &rt_sf->trampoline[0];
> > +
> > +    sc =3D &rt_sf->uc.tuc_sigcontext;
> > +    __put_user(h2g(mctx), &sc->regs);
> > +    __put_user(sig, &sc->signal);
> >  #else
> >      mctx =3D &rt_sf->uc.tuc_mcontext;
> >      trampptr =3D (uint32_t *)&rt_sf->uc.tuc_mcontext.tramp;
> >=20
>=20
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>=20
> This is correct, but QEMU and kernel implementation are really
> different.

Laurent, I'm a bit clear on what the upshot is here.

Should I merge the patch above?

>=20
> In the kernel:
>=20
> handle_rt_signal64()
> ...
>     frame =3D get_sigframe(ksig, get_tm_stackpointer(tsk),
>                          sizeof(*frame), 0);
> ...
>     err |=3D setup_sigcontext(&frame->uc.uc_mcontext, tsk, ksig->sig,
>                             NULL,
>                             (unsigned long)ksig->ka.sa.sa_handler,
>                             1);
>=20
> static long setup_sigcontext(struct sigcontext __user *sc,
>                 struct task_struct *tsk, int signr, sigset_t *set,
>                 unsigned long handler, int ctx_has_vsx_region)
>=20
>         err |=3D __put_user(&sc->gp_regs, &sc->regs);
> ...
>         err |=3D __put_user(signr, &sc->signal);
> ...
>=20
> According to kernel definition of ucontext:
>=20
> struct ucontext {
> ...
> #ifdef __powerpc64__
>         sigset_t        __unused[15];   /* Allow for uc_sigmask growth */
>         struct sigcontext uc_mcontext;  /* last for extensibility */
> #else
> ...
> }
>=20
> kernel &frame->uc.uc_mcontext is qemu &rt_sf->uc.tuc_sigcontext
>=20
> uc_sigcontext.mcontext doesn't exit in the kernel.
>=20
> But QEMU code works because tuc_sigcontext.mcontext is where we have the
> CPU registers in sigcontext:
>=20
> kernel:
>=20
> struct sigcontext {
>         unsigned long   _unused[4];
>         int             signal;
> #ifdef __powerpc64__
>         int             _pad0;
> #endif
>         unsigned long   handler;
>         unsigned long   oldmask;
>         struct pt_regs  __user *regs;
> #ifdef __powerpc64__
>         elf_gregset_t   gp_regs;
>         elf_fpregset_t  fp_regs;
> ...
>=20
> Qemu:
>=20
> struct target_sigcontext {
>     target_ulong _unused[4];
>     int32_t signal;
> #if defined(TARGET_PPC64)
>     int32_t pad0;
> #endif
>     target_ulong handler;
>     target_ulong oldmask;
>     target_ulong regs;      /* struct pt_regs __user * */
> #if defined(TARGET_PPC64)
>     struct target_mcontext mcontext;
> #endif
> };
>=20
> struct target_mcontext {
>     target_ulong mc_gregs[48];
>     /* Includes fpscr.  */
>     uint64_t mc_fregs[33];
> ...
>=20
> I think we do like that to use the same
> save_user_regs()/save_user_regs() functions with PPC and PPC64... but
> comparison with kernel becomes harder.
>=20
> Laurent
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PCv3LdRyJ68gHPUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtM2uAAoJEGw4ysog2bOSmoAP/jWFCAjVN+Oyd5iCV/+k3NyS
1smP8MCPUddb+6uM0Egs12wSXU07LAFWIg7/WS8zNSHl+Mv92mgQQGXySmXGRYUP
GlZ4da9PSCrnCHHlpQ3wu2mGW0VIvuMajzNJk8HwBrAilR9Ie6etG0GgC8qq9Hav
lF6Bvu4QNh8jKYkfo29iHD+mA/d2JEx4plUcfW4fZnSDEOGMt9iO0Cty22GyZwa1
uCWZEZPmlgTlnAKJTdOZeto4tgkZ483sqUtAtH22ER3xnw+Qkx1HqhWF9bdE7YPn
xETNtINFBkleeNrC/5cD8koctZFypFQ8SehrD67CZOv76CaN6p58/d9gDw0Wim+1
jW0XFx+30bCtPMtFWo3IGJVLwPeMkkvXuR05fGOuO+syA3JmxcbNQ0pXFkKBCgfV
E+9ERYhrYxkK2DPlKJb+EQTz3gqXTIqBWYBop6+xRsk9yoiWXzpbj+Cb/ZNvzaAJ
aYy1JClyBL/f7KkfwZDRj9fQU7aDS0/1g6iXrmeixLId9sWl8lBKyft36g9OAoS0
oA5ztAF3t8O7Aharlq8CAKlE120bb3ZbQlu3lDflnLid9hkk+9tsN0LgEYZA0NCX
kTiofVUCc8O5yb9v4SM+toVLYdmt7lodlQSMHb0W/YWCyoT4cobyAsCeuJ1RPOAP
IRJIW4pBr+BxV3YjEkxU
=15IB
-----END PGP SIGNATURE-----

--PCv3LdRyJ68gHPUM--
