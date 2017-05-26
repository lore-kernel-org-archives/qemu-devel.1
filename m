Received: from eggs.gnu.org ([2001:4830:134:3::10]:47333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE6fu-0003ik-CL
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE6fq-0007Iq-WA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:16:30 -0400
Date: Fri, 26 May 2017 13:40:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170526034003.GI12929@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-5-david@gibson.dropbear.id.au>
	<149332269179.32299.14843802405313026595@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <149332269179.32299.14843802405313026595@loki>
Subject: Re: [Qemu-devel] [PATCHv3 4/4] ppc: Rework CPU compatibility
 testing across migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, clg@kaod.org, groug@kaod.org, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 02:51:31PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-04-27 02:28:43)
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
> >  target/ppc/machine.c | 71 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
> >  1 file changed, 68 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 6cb3a48..20a46c9 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -8,6 +8,7 @@
> >  #include "helper_regs.h"
> >  #include "mmu-hash64.h"
> >  #include "migration/cpu.h"
> > +#include "qapi/error.h"
> >=20
> >  static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
> >  {
> > @@ -195,6 +196,30 @@ static void cpu_pre_save(void *opaque)
> >      }
> >  }
> >=20
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
> > +
> >  static int cpu_post_load(void *opaque, int version_id)
> >  {
> >      PowerPCCPU *cpu =3D opaque;
> > @@ -203,10 +228,31 @@ static int cpu_post_load(void *opaque, int versio=
n_id)
> >      target_ulong msr;
> >=20
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
> > @@ -560,6 +606,24 @@ static const VMStateDescription vmstate_tlbmas =3D=
 {
> >      }
> >  };
> >=20
> > +static bool compat_needed(void *opaque)
> > +{
> > +    PowerPCCPU *cpu =3D opaque;
> > +
> > +    return cpu->vhyp !=3D NULL;
> > +}
>=20
> Would it make sense to relax this to:
>=20
>   cpu->vhyp !=3D NULL && cpu->compat_pvr

So, that's equivalent to just cpu->compat_pvr, since it can't be
non-zero if cpu->vhyp isn't set.

> ? This would at least allow cross-version migration in cases where we
> weren't previously running in a compatibility mode. As it stands it
> seems like this would rule out both new->old and old->new migration.

Ah, yes that's a good idea.

> Another possibility might be to only enable migration/checking of
> compat_pvr for 2.10 and later, similar to the cpu_pre_2_8_migration
> stuff.

True.. and that might be a bit more robust, too.  I'll look into it.

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
> > @@ -613,6 +677,7 @@ const VMStateDescription vmstate_ppc_cpu =3D {
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

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJ6OQAAoJEGw4ysog2bOSYdcQALbVVpeO0jBV+nJFNjjr5jW3
kdZmU8ekyGaY9eZDFgBGlzcpn4nQEXA+o6K1OIlu1NwoEzkoi2UeJOAx+yiyHk07
TnFOQyrOsWsR0oGTHh/4sG9juDWRYUxhZP+/Puwkd7DwZ5XdzOzN+uCUwqPiHjF+
IxawHUAseWe3brx5bm/BNDtDLfAMvklQN9h66KrNUe2pItAeW/psKCy1Ps3IScXu
Hro5CicwX29jeLJ9Z6aYF0JbXFrHrXR6ECPzTEcrArxK1Eov8fSj1LRggMVxM0L5
ifQG4EaN9Y3O8Ok3k8zboQJdd3LvYfZgyhJ72E2ASMgQc4iplcKUySJUgpBb7V98
QP5Qy3WUCDPIdrK1qqn1utwd72y7YVNwLtkHx8FZZL5iiAYGjti9/DbQbwri5uzg
fASLJak8ii9VWLYphZ+1JLuddWGyKyb3Mv1joPaAFODtSfwRl9DSYM1aofnPAWlt
hcoV5P4dB2dDHuSAyE42kM9KIFo72OBBmDns9x18nZEG7gHgkGPtFlCf0cwmKDlu
Bawv2JcBVahbBzEF+P6M5W8++ETwa+kelZsWAKz5MlGEFX0e5YNgInG9Zu96K2RY
eE+tiBEfWI5HTWX/C4ClSvzsITZp3DvEvo7Fjbul+izZqMIvX4T5XlClGbvD9AnE
4gGc+uhvViuU9iYlA+jY
=75ei
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
