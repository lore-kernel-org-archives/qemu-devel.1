Received: from eggs.gnu.org ([2001:4830:134:3::10]:38675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cdMMm-0006Zm-RS
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cdMMi-0008OA-NA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:32:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cdMMi-0008KA-Ei
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:32:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1DJTZnV076954
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 14:32:46 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28kjhy94g0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 14:32:45 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 13 Feb 2017 17:32:43 -0200
Date: Mon, 13 Feb 2017 17:32:31 -0200
From: joserz@linux.vnet.ibm.com
References: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
	<23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
Message-Id: <20170213193231.GA20638@pacoca>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: fill target sigcontext struct
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: riku.voipio@iki.fi
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Up

On Wed, Feb 01, 2017 at 09:43:57PM +0100, Laurent Vivier wrote:
> Le 31/01/2017 =C3=A0 23:05, Jose Ricardo Ziviani a =C3=A9crit :
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
> > @@ -5155,6 +5155,7 @@ static void setup_rt_frame(int sig, struct targ=
et_sigaction *ka,
> >      target_ulong rt_sf_addr, newsp =3D 0;
> >      int i, err =3D 0;
> >  #if defined(TARGET_PPC64)
> > +    struct target_sigcontext *sc =3D 0;
> >      struct image_info *image =3D ((TaskState *)thread_cpu->opaque)->=
info;
> >  #endif
> > =20
> > @@ -5183,6 +5184,10 @@ static void setup_rt_frame(int sig, struct tar=
get_sigaction *ka,
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
> This is correct, but QEMU and kernel implementation are really differen=
t.
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
>         sigset_t        __unused[15];   /* Allow for uc_sigmask growth =
*/
>         struct sigcontext uc_mcontext;  /* last for extensibility */
> #else
> ...
> }
>=20
> kernel &frame->uc.uc_mcontext is qemu &rt_sf->uc.tuc_sigcontext
>=20
> uc_sigcontext.mcontext doesn't exit in the kernel.
>=20
> But QEMU code works because tuc_sigcontext.mcontext is where we have th=
e
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
