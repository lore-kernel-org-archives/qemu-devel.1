Received: from eggs.gnu.org ([209.51.188.92]:44420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gti4o-00024w-2l
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gti49-0008Lt-7i
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:06:18 -0500
Message-ID: <8adeacf3681e03343d64fac82b73505ffa122bfd.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 13 Feb 2019 11:04:27 +1100
In-Reply-To: <20190212060227.GO1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-9-clg@kaod.org>
	<20190212060227.GO1884@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/19] target/ppc: Fix nip on power
 management instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2019-02-12 at 17:02 +1100, David Gibson wrote:
> On Mon, Jan 28, 2019 at 10:46:14AM +0100, C=C3=A9dric Le Goater wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > Those instructions currently raise an exception from within
> > the helper. This tends to result in a bogus nip value in
> > the env context (typically the beginning of the TB). Such
> > a helper needs a gen_update_nip() first.
> >=20
> > This fixes it with a different approach which is to throw
> > the exception from translate.c instead of the helper using
> > gen_exception_nip() which does the right thing.
> >=20
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  target/ppc/excp_helper.c |  1 -
> >  target/ppc/translate.c   | 12 ++++++++----
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 751d759fcc1d..8407e0ade938 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -958,7 +958,6 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_i=
nsn_t insn)
> >       * but this doesn't seem to be a problem.
> >       */
> >      env->msr |=3D (1ull << MSR_EE);
> > -    raise_exception(env, EXCP_HLT);
> >  }
> >  #endif /* defined(TARGET_PPC64) */
> > =20
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 7d40a1fbe6bd..55281a8975e0 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -3571,7 +3571,8 @@ static void gen_doze(DisasContext *ctx)
> >      t =3D tcg_const_i32(PPC_PM_DOZE);
> >      gen_helper_pminsn(cpu_env, t);
> >      tcg_temp_free_i32(t);
> > -    gen_stop_exception(ctx);
> > +    /* Stop translation, as the CPU is supposed to sleep from now */
> > +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>=20
> IIUC this also changes from EXCP_STOP to EXCP_HLT, is that intentional?

Off the top of my head, it might be to break out of the outer exec
loop, but I don't remember off hand.

> >  #endif /* defined(CONFIG_USER_ONLY) */
> >  }
> > =20
> > @@ -3586,7 +3587,8 @@ static void gen_nap(DisasContext *ctx)
> >      t =3D tcg_const_i32(PPC_PM_NAP);
> >      gen_helper_pminsn(cpu_env, t);
> >      tcg_temp_free_i32(t);
> > -    gen_stop_exception(ctx);
> > +    /* Stop translation, as the CPU is supposed to sleep from now */
> > +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> >  #endif /* defined(CONFIG_USER_ONLY) */
> >  }
> > =20
> > @@ -3606,7 +3608,8 @@ static void gen_sleep(DisasContext *ctx)
> >      t =3D tcg_const_i32(PPC_PM_SLEEP);
> >      gen_helper_pminsn(cpu_env, t);
> >      tcg_temp_free_i32(t);
> > -    gen_stop_exception(ctx);
> > +    /* Stop translation, as the CPU is supposed to sleep from now */
> > +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> >  #endif /* defined(CONFIG_USER_ONLY) */
> >  }
> > =20
> > @@ -3621,7 +3624,8 @@ static void gen_rvwinkle(DisasContext *ctx)
> >      t =3D tcg_const_i32(PPC_PM_RVWINKLE);
> >      gen_helper_pminsn(cpu_env, t);
> >      tcg_temp_free_i32(t);
> > -    gen_stop_exception(ctx);
> > +    /* Stop translation, as the CPU is supposed to sleep from now */
> > +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> >  #endif /* defined(CONFIG_USER_ONLY) */
> >  }
> >  #endif /* #if defined(TARGET_PPC64) */
