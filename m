Received: from eggs.gnu.org ([2001:4830:134:3::10]:55962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL3fD-0003nH-Hh
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL3f8-0003gR-J4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:28:31 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:42938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dL3f8-0003bf-8Y
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:28:26 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 12235104660
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:28:23 +0200 (CEST)
Date: Wed, 14 Jun 2017 10:28:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170614102810.49d4389c@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170602031507.29881-5-david@gibson.dropbear.id.au>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<20170602031507.29881-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/6Tm9OArNcRyn6w_szS.b4kp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv5 4/4] ppc: Rework CPU compatibility
 testing across migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, abologna@redhat.com, sbobroff@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/6Tm9OArNcRyn6w_szS.b4kp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  2 Jun 2017 13:15:07 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Migrating between different CPU versions is a bit complicated for ppc.
> A long time ago, we ensured identical CPU versions at either end by
> checking the PVR had the same value.  However, this breaks under KVM
> HV, because we always have to use the host's PVR - it's not
> virtualized.  That would mean we couldn't migrate between hosts with
> different PVRs, even if the CPUs are close enough to compatible in
> practice (sometimes identical cores with different surrounding logic
> have different PVRs, so this happens in practice quite often).
>=20
> So, we removed the PVR check, but instead checked that several flags
> indicating supported instructions matched.  This turns out to be a bad
> idea, because those instruction masks are not architected information, but
> essentially a TCG implementation detail.  So changes to qemu internal CPU
> modelling can break migration - this happened between qemu-2.6 and
> qemu-2.7.  That was addressed by 146c11f1 "target-ppc: Allow eventual
> removal of old migration mistakes".
>=20
> Now, verification of CPU compatibility across a migration basically doesn=
't
> happen.  We simply ignore the PVR of the incoming migration, and hope the
> cpu on the destination is close enough to work.
>=20
> Now that we've cleaned up handling of processor compatibility modes for
> pseries machine type, we can do better.  We allow migration if:
>=20
>     * The source and destination PVRs are for the same type of CPU, as
>       determined by CPU class's pvr_match function
> OR  * When the source was in a compatibility mode, and the destination CPU
>       supports the same compatibility mode
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/machine.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 66 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 6cb3a48..a29aabe 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -8,6 +8,7 @@
>  #include "helper_regs.h"
>  #include "mmu-hash64.h"
>  #include "migration/cpu.h"
> +#include "qapi/error.h"
> =20
>  static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
>  {
> @@ -195,6 +196,27 @@ static void cpu_pre_save(void *opaque)
>      }
>  }
> =20
> +/*
> + * Determine if a given PVR is a "close enough" match to the CPU
> + * object.  For TCG and KVM PR it would probably be sufficient to
> + * require an exact PVR match.  However for KVM HV the user is
> + * restricted to a PVR exactly matching the host CPU.  The correct way
> + * to handle this is to put the guest into an architected
> + * compatibility mode.  However, to allow a more forgiving transition
> + * and migration from before this was widely done, we allow migration
> + * between sufficiently similar PVRs, as determined by the CPU class's
> + * pvr_match() hook.
> + */
> +static bool pvr_match(PowerPCCPU *cpu, uint32_t pvr)
> +{
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +
> +    if (pvr =3D=3D pcc->pvr) {
> +        return true;
> +    }
> +    return pcc->pvr_match(pcc, pvr);
> +}
> +
>  static int cpu_post_load(void *opaque, int version_id)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -203,10 +225,31 @@ static int cpu_post_load(void *opaque, int version_=
id)
>      target_ulong msr;
> =20
>      /*
> -     * We always ignore the source PVR. The user or management
> -     * software has to take care of running QEMU in a compatible mode.
> +     * If we're operating in compat mode, we should be ok as long as
> +     * the destination supports the same compatiblity mode.
> +     *
> +     * Otherwise, however, we require that the destination has exactly
> +     * the same CPU model as the source.
>       */
> -    env->spr[SPR_PVR] =3D env->spr_cb[SPR_PVR].default_value;
> +
> +#if defined(TARGET_PPC64)
> +    if (cpu->compat_pvr) {
> +        Error *local_err =3D NULL;
> +
> +        ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_free(local_err);
> +            return -1;
> +        }
> +    } else
> +#endif
> +    {
> +        if (!pvr_match(cpu, env->spr[SPR_PVR])) {
> +            return -1;
> +        }
> +    }
> +
>      env->lr =3D env->spr[SPR_LR];
>      env->ctr =3D env->spr[SPR_CTR];
>      cpu_write_xer(env, env->spr[SPR_XER]);
> @@ -560,6 +603,25 @@ static const VMStateDescription vmstate_tlbmas =3D {
>      }
>  };
> =20
> +static bool compat_needed(void *opaque)
> +{
> +    PowerPCCPU *cpu =3D opaque;
> +
> +    assert(!(cpu->compat_pvr && !cpu->vhyp));
> +    return (cpu->compat_pvr !=3D 0);

Since the CAS logic rework in 2.9, compat_pvr is likely to be !=3D 0 and
the subsection is sent even for older machine types. This breaks backward
migration of such machines...

> +}
> +
> +static const VMStateDescription vmstate_compat =3D {
> +    .name =3D "cpu/compat",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D compat_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(compat_pvr, PowerPCCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_ppc_cpu =3D {
>      .name =3D "cpu",
>      .version_id =3D 5,
> @@ -613,6 +675,7 @@ const VMStateDescription vmstate_ppc_cpu =3D {
>          &vmstate_tlb6xx,
>          &vmstate_tlbemb,
>          &vmstate_tlbmas,
> +        &vmstate_compat,
>          NULL
>      }
>  };


--Sig_/6Tm9OArNcRyn6w_szS.b4kp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllA85oACgkQAvw66wEB28Iu6wCcD/yWEFbZc+51hsE5GdNfx35Z
GPsAn3aUlj2JZbbn4QAP8utJVEdx4N3U
=iT9b
-----END PGP SIGNATURE-----

--Sig_/6Tm9OArNcRyn6w_szS.b4kp--
