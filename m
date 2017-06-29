Received: from eggs.gnu.org ([2001:4830:134:3::10]:55638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1dQZls-00057m-JN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1dQZln-00048Z-Nt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:46:12 -0400
Received: from jessie.kos.to ([212.47.231.226]:57596 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1dQZln-00047V-Cn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:46:07 -0400
Date: Thu, 29 Jun 2017 13:46:01 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170629134601.GA9921@kos.to>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-7-laurent@vivier.eu>
	<e94af6f2-8869-b9e7-b2b8-b3f16713b345@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e94af6f2-8869-b9e7-b2b8-b3f16713b345@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 6/6] target-m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 28, 2017 at 10:44:57PM +0200, Laurent Vivier wrote:
> Riku,
>=20
> could you ACK this patch, so I will add it in my next pull request for =
m68k?

Whatabout Richard's comment about using cpu_m68k_set_fpcr ?

Riku
=20
> Thanks,
> Laurent
>=20
> Le 20/06/2017 =C3=A0 22:51, Laurent Vivier a =C3=A9crit :
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> >  linux-user/signal.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >=20
> > diff --git a/linux-user/signal.c b/linux-user/signal.c
> > index 3d18d1b..d3753e4 100644
> > --- a/linux-user/signal.c
> > +++ b/linux-user/signal.c
> > @@ -5673,6 +5673,24 @@ give_sigsegv:
> >      force_sigsegv(sig);
> >  }
> > =20
> > +static inline void target_rt_save_fpu_state(struct target_ucontext *=
uc,
> > +                                           CPUM68KState *env)
> > +{
> > +    int i;
> > +    target_fpregset_t *fpregs =3D &uc->tuc_mcontext.fpregs;
> > +
> > +    __put_user(env->fpcr, &fpregs->f_fpcntl[0]);
> > +    __put_user(env->fpsr, &fpregs->f_fpcntl[1]);
> > +    /* fpiar is not emulated */
> > +
> > +    for (i =3D 0; i < 8; i++) {
> > +        uint32_t high =3D env->fregs[i].d.high << 16;
> > +        __put_user(high, &fpregs->f_fpregs[i * 3]);
> > +        __put_user(env->fregs[i].d.low,
> > +                   (uint64_t *)&fpregs->f_fpregs[i * 3 + 1]);
> > +    }
> > +}
> > +
> >  static inline int target_rt_setup_ucontext(struct target_ucontext *u=
c,
> >                                             CPUM68KState *env)
> >  {
> > @@ -5699,9 +5717,30 @@ static inline int target_rt_setup_ucontext(str=
uct target_ucontext *uc,
> >      __put_user(env->pc, &gregs[16]);
> >      __put_user(sr, &gregs[17]);
> > =20
> > +    target_rt_save_fpu_state(uc, env);
> > +
> >      return 0;
> >  }
> > =20
> > +static inline void target_rt_restore_fpu_state(CPUM68KState *env,
> > +                                               struct target_ucontex=
t *uc)
> > +{
> > +    int i;
> > +    target_fpregset_t *fpregs =3D &uc->tuc_mcontext.fpregs;
> > +
> > +    __get_user(env->fpcr, &fpregs->f_fpcntl[0]);
> > +    __get_user(env->fpsr, &fpregs->f_fpcntl[1]);
> > +    /* fpiar is not emulated */
> > +
> > +    for (i =3D 0; i < 8; i++) {
> > +        uint32_t high;
> > +        __get_user(high, &fpregs->f_fpregs[i * 3]);
> > +        env->fregs[i].d.high =3D high >> 16;
> > +        __get_user(env->fregs[i].d.low,
> > +                   (uint64_t *)&fpregs->f_fpregs[i * 3 + 1]);
> > +    }
> > +}
> > +
> >  static inline int target_rt_restore_ucontext(CPUM68KState *env,
> >                                               struct target_ucontext =
*uc)
> >  {
> > @@ -5733,6 +5772,8 @@ static inline int target_rt_restore_ucontext(CP=
UM68KState *env,
> >      __get_user(temp, &gregs[17]);
> >      cpu_m68k_set_ccr(env, temp);
> > =20
> > +    target_rt_restore_fpu_state(env, uc);
> > +
> >      return 0;
> > =20
> >  badframe:
> >=20
>=20
