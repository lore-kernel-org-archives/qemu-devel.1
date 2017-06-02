Received: from eggs.gnu.org ([2001:4830:134:3::10]:58576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGccn-0000MV-Hg
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 22:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGcck-0003j4-Go
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 22:47:41 -0400
Date: Fri, 2 Jun 2017 12:25:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602022553.GI13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-6-david@gibson.dropbear.id.au>
	<20170601102318.215e5c32@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Content-Disposition: inline
In-Reply-To: <20170601102318.215e5c32@bahia.lan>
Subject: Re: [Qemu-devel] [PATCHv4 5/5] ppc: Rework CPU compatibility
 testing across migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 10:23:18AM +0200, Greg Kurz wrote:
> On Fri, 26 May 2017 15:23:19 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Migrating between different CPU versions is a bit complicated for ppc.
> > A long time ago, we ensured identical CPU versions at either end by
> > checking the PVR had the same value.  However, this breaks under KVM
> > HV, because we always have to use the host's PVR - it's not
> > virtualized.  That would mean we couldn't migrate between hosts with
> > different PVRs, even if the CPUs are close enough to compatible in
> > practice (sometimes identical cores with different surrounding logic
> > have different PVRs, so this happens in practice quite often).
> >=20
> > So, we removed the PVR check, but instead checked that several flags
> > indicating supported instructions matched.  This turns out to be a bad
> > idea, because those instruction masks are not architected information, =
but
> > essentially a TCG implementation detail.  So changes to qemu internal C=
PU
> > modelling can break migration - this happened between qemu-2.6 and
> > qemu-2.7.  That was addressed by 146c11f1 "target-ppc: Allow eventual
> > removal of old migration mistakes".
> >=20
> > Now, verification of CPU compatibility across a migration basically doe=
sn't
> > happen.  We simply ignore the PVR of the incoming migration, and hope t=
he
> > cpu on the destination is close enough to work.
> >=20
> > Now that we've cleaned up handling of processor compatibility modes for
> > pseries machine type, we can do better.  We allow migration if:
> >=20
> >     * The source and destination PVRs are for the same type of CPU, as
> >       determined by CPU class's pvr_match function
> > OR  * When the source was in a compatibility mode, and the destination =
CPU
> >       supports the same compatibility mode
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/machine.c | 72 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
> >  1 file changed, 69 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 6cb3a48..2c6d9dc 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -8,6 +8,7 @@
> >  #include "helper_regs.h"
> >  #include "mmu-hash64.h"
> >  #include "migration/cpu.h"
> > +#include "qapi/error.h"
> > =20
> >  static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
> >  {
> > @@ -195,6 +196,30 @@ static void cpu_pre_save(void *opaque)
> >      }
> >  }
> > =20
> > +/*
> > + * Determine if a given PVR is a "close enough" match to the CPU
> > + * object.  For TCG and KVM PR it would probably be sufficient to
> > + * require an exact PVR match.  However for KVM HV the user is
> > + * restricted to a PVR exactly matching the host CPU.  The correct way
> > + * to handle this is to put the guest into an architected
> > + * compatibility mode.  However, to allow a more forgiving transition
> > + * and migration from before this was widely done, we allow migration
> > + * between sufficiently similar PVRs, as determined by the CPU class's
> > + * pvr_match() hook.
> > + */
> > +static bool pvr_match(PowerPCCPU *cpu, uint32_t pvr)
> > +{
> > +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +
> > +    if (pvr =3D=3D pcc->pvr) {
> > +        return true;
> > +    }
> > +    if (pcc->pvr_match) {
> > +        return pcc->pvr_match(pcc, pvr);
> > +    }
> > +    return false;
> > +}
>=20
> The base class provides a fallback for pcc->pvr_match that does:
>=20
> static bool ppc_pvr_match_default(PowerPCCPUClass *pcc, uint32_t pvr)
> {
>     return pcc->pvr =3D=3D pvr;
> }
>=20
> so I'm not sure this function is needed, but maybe I'm missing something.

Ah, yes, I think you're right.  I've simplified accordingly.

> > +
> >  static int cpu_post_load(void *opaque, int version_id)
> >  {
> >      PowerPCCPU *cpu =3D opaque;
> > @@ -203,10 +228,31 @@ static int cpu_post_load(void *opaque, int versio=
n_id)
> >      target_ulong msr;
> > =20
> >      /*
> > -     * We always ignore the source PVR. The user or management
> > -     * software has to take care of running QEMU in a compatible mode.
> > +     * If we're operating in compat mode, we should be ok as long as
> > +     * the destination supports the same compatiblity mode.
> > +     *
> > +     * Otherwise, however, we require that the destination has exactly
> > +     * the same CPU model as the source.
> >       */
> > -    env->spr[SPR_PVR] =3D env->spr_cb[SPR_PVR].default_value;
> > +
> > +#if defined(TARGET_PPC64)
> > +    if (cpu->compat_pvr) {
> > +        Error *local_err =3D NULL;
> > +
> > +        ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +            error_free(local_err);
> > +            return -1;
> > +        }
> > +    } else
> > +#endif
> > +    {
> > +        if (!pvr_match(cpu, env->spr[SPR_PVR])) {
> > +            return -1;
> > +        }
> > +    }
> > +
> >      env->lr =3D env->spr[SPR_LR];
> >      env->ctr =3D env->spr[SPR_CTR];
> >      cpu_write_xer(env, env->spr[SPR_XER]);
> > @@ -560,6 +606,25 @@ static const VMStateDescription vmstate_tlbmas =3D=
 {
> >      }
> >  };
> > =20
> > +static bool compat_needed(void *opaque)
> > +{
> > +    PowerPCCPU *cpu =3D opaque;
> > +
> > +    assert(!(cpu->compat_pvr && !cpu->vhyp));
> > +    return (cpu->compat_pvr !=3D 0);
>=20
> Parenthesitis ?
>=20
> > +}
>=20
> This will break backward migration of pre-2.10 machine types. But it can =
be
> fixed in a followup patch if really needed (or even addressed
> downstream).

Ah.. unless we force the source machine into raw mode somehow.
Bother.

Pity we can't mark new migration sections as "safe to ignore" for old
versions.

As you say this could be addressed downstream.  Usually that makes
things ugly, but it might be reasonable in this case.

Anyways, I think I'll address it in a followup, rather than delaying
this.

>=20
> Anyway, since you're the decision maker:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +
> > +static const VMStateDescription vmstate_compat =3D {
> > +    .name =3D "cpu/compat",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D compat_needed,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(compat_pvr, PowerPCCPU),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  const VMStateDescription vmstate_ppc_cpu =3D {
> >      .name =3D "cpu",
> >      .version_id =3D 5,
> > @@ -613,6 +678,7 @@ const VMStateDescription vmstate_ppc_cpu =3D {
> >          &vmstate_tlb6xx,
> >          &vmstate_tlbemb,
> >          &vmstate_tlbmas,
> > +        &vmstate_compat,
> >          NULL
> >      }
> >  };
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMMyuAAoJEGw4ysog2bOSjIYQAJI4RwYHfgdndjqvDafI9cde
yY1zSlgtur3N8UgGoS5YfmnRZaIcMkQe8B93tMzSEsl3i+fC9TSdHOktDevBfHhu
yGB+Qts1N9ifHAR6hPCHMqTCdCYLi0T//xqc0z2ozqLHMZ3/rqqSt70XGXPRDdT/
HMbTsv2xY5DhLJt+nPzPGMO1bu9S9ovi8Clb6lqskTz9e1QDXEF9Ek26tAlRRik7
S//V6+RIzbk4tZsuf29pHWjSyufJlNYYW82U0ow2TePPsHL2GcycnKu03i518xk+
yLS6lYGD6wCf2AIVDj/Yb/usiv3mJqlNFx42WqGl5aMHm221XxEDUs1D2Q2JLsAx
vaGQmgDkHOcDEqpe0HahNGRiQoLoUGd9kMy1iltqcWPnYFU0oOiXJuvZcTgJWYxJ
Y0pnxdZnWRjfCUF26/9kO5BL3vhT0oMh7RMtxiXCySdgxrwyXsqadyv6ZbkphXGk
SQzumDrkP2DkK06jZPlZ5JGgWASq5xYa5RChUji/YS7PiKDAGlu43ZbM198GQoT4
siZRuKa5LrYf6j3q7f7JYdi9be5pCWeVb07Hp661xHdQGYkZHwmA/BYxE+0XQNXt
uhiB1PchTxIZDtYeh8PpEqntuL1aE/z+5l0LCf9oiagVdH3KZz91AO8RqAABLMl1
IoqPWwtAETHaa7jahNgP
=0i1G
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--
