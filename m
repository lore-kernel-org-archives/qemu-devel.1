Received: from eggs.gnu.org ([2001:4830:134:3::10]:48806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE6qi-0001Uv-B2
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE6qg-0002Y8-Pb
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:27:40 -0400
Date: Fri, 26 May 2017 14:16:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170526041630.GJ12929@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-5-david@gibson.dropbear.id.au>
	<20170504120747.208d9cea@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline
In-Reply-To: <20170504120747.208d9cea@bahia>
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
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 12:07:47PM +0200, Greg Kurz wrote:
> On Thu, 27 Apr 2017 17:28:43 +1000
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
>=20
> As already mentioned during the review of RFCv2, this calls
> cpu_synchronize_state(CPU(cpu)) and trashes the registers.
>=20
> The following changes avoid that:

This is a really ugly fix, and I think it misses the point.

If a synchronize_state() trashes state here, it means we've already
altered register state while not synchronized, which is a pre-existing
bug.

>=20
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -118,7 +118,8 @@ bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compa=
t_pvr,
>      return true;
>  }
> =20
> -void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
> +void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, bool sync_need=
ed,
> +                    Error **errp)
>  {
>      const CompatInfo *compat =3D compat_by_pvr(compat_pvr);
>      CPUPPCState *env =3D &cpu->env;
> @@ -138,7 +139,9 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_=
pvr, Error **errp)
>          pcr =3D compat->pcr;
>      }
> =20
> -    cpu_synchronize_state(CPU(cpu));
> +    if (sync_needed) {
> +        cpu_synchronize_state(CPU(cpu));
> +    }
> =20
>      cpu->compat_pvr =3D compat_pvr;
>      env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> @@ -162,7 +165,7 @@ static void do_set_compat(CPUState *cs, run_on_cpu_da=
ta arg)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      SetCompatState *s =3D arg.host_ptr;
> =20
> -    ppc_set_compat(cpu, s->compat_pvr, &s->err);
> +    ppc_set_compat(cpu, s->compat_pvr, true, &s->err);
>  }
> =20
>  void ppc_set_compat_all(uint32_t compat_pvr, Error **errp)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 1d8f2fcd4a46..057785347820 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1364,7 +1364,8 @@ static inline int cpu_mmu_index (CPUPPCState *env, =
bool ifetch)
>  #if defined(TARGET_PPC64)
>  bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
>                        uint32_t min_compat_pvr, uint32_t max_compat_pvr);
> -void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
> +void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, bool sync_need=
ed,
> +                    Error **errp);
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
>  #endif
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 20a46c95a596..fda63532b041 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -239,7 +239,7 @@ static int cpu_post_load(void *opaque, int version_id)
>      if (cpu->compat_pvr) {
>          Error *local_err =3D NULL;
> =20
> -        ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
> +        ppc_set_compat(cpu, cpu->compat_pvr, false, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              error_free(local_err);
>=20
>=20
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
> > =20
> > +static bool compat_needed(void *opaque)
> > +{
> > +    PowerPCCPU *cpu =3D opaque;
> > +
> > +    return cpu->vhyp !=3D NULL;
> > +}
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

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJ6wcAAoJEGw4ysog2bOSMEQQANSJiFVM/rgJe6B3QMBkCjaJ
HKePg5Obb0aKhrZrj2oElv4g5xfL375V4Q2DP6qO7JT7au3WiExgwGEmrvJRTPtT
44b/20LaPXhBHAdEF/0XdNzO1QJh2WLAan8Tt8Y1m5fr4MRQfUbhGeROTJEKjaBI
jSpOqCWO5Jz1vuwKZ0n/EN92wrrZwPm555V+aqgY2pgtgcCOM0o5ozqcAyDFop6F
FU6p9Szhcoy4Y7KSZoA0fiVmWepDreWy079YW1j8DtYLSMRPHJbSI5D4wEuLstO1
NSLVjEpBDvX8QjzgIV/9fe0wPGmcEMPbEKesELfMhYAL7QmKY5j+21lDM4zWv0Ns
88eO9y8h6sN/rntKbw6Avgk/7RNDe+Jll88HIaRS0pBpvKJ/Didi0A5VVcRt0xbS
+fmEduPHQ5Wh/6bQUjSCJXL3IkI3tdNbE37c0FSVxHu0URRJW1EWE4tsuKDRSQ2L
Y+BzCKAN+lceSleFUAMDzt8fvTsda9NxVQi9FNLIlps4KliFCZqQVAenUnbVC9lo
5EtJ04eUQJk4jzp6lw5KJvAdrHKjfo2QR++7sIh+H7YWaQmzUFdKV7okM98jlZ9k
j5xhjoiEp4ol9Vynud0ky+NG/38kz+KMNDhjqCudS3W6FieAJwjuJjqkCe1BWzGR
xcO5+uNIducsduqo+bcs
=iep6
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--
