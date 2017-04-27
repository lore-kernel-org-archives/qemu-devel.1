Received: from eggs.gnu.org ([2001:4830:134:3::10]:42606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3pSA-0004QW-OF
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3pS6-0001Qo-FX
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d3pS6-0001PX-6E
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 15:51:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3RJmYgM142961
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:51:42 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3j0keh34-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:51:42 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 15:51:41 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170427072843.8089-5-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-5-david@gibson.dropbear.id.au>
Date: Thu, 27 Apr 2017 14:51:31 -0500
Message-Id: <149332269179.32299.14843802405313026595@loki>
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
To: David Gibson <david@gibson.dropbear.id.au>, aik@ozlabs.ru, clg@kaod.org, groug@kaod.org, nikunj@linux.vnet.ibm.com
Cc: agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Quoting David Gibson (2017-04-27 02:28:43)
> Migrating between different CPU versions is a bit complicated for ppc.
> A long time ago, we ensured identical CPU versions at either end by
> checking the PVR had the same value.  However, this breaks under KVM
> HV, because we always have to use the host's PVR - it's not
> virtualized.  That would mean we couldn't migrate between hosts with
> different PVRs, even if the CPUs are close enough to compatible in
> practice (sometimes identical cores with different surrounding logic
> have different PVRs, so this happens in practice quite often).
> =

> So, we removed the PVR check, but instead checked that several flags
> indicating supported instructions matched.  This turns out to be a bad
> idea, because those instruction masks are not architected information, but
> essentially a TCG implementation detail.  So changes to qemu internal CPU
> modelling can break migration - this happened between qemu-2.6 and
> qemu-2.7.  That was addressed by 146c11f1 "target-ppc: Allow eventual
> removal of old migration mistakes".
> =

> Now, verification of CPU compatibility across a migration basically doesn=
't
> happen.  We simply ignore the PVR of the incoming migration, and hope the
> cpu on the destination is close enough to work.
> =

> Now that we've cleaned up handling of processor compatibility modes for
> pseries machine type, we can do better.  We allow migration if:
> =

>     * The source and destination PVRs are for the same type of CPU, as
>       determined by CPU class's pvr_match function
> OR  * When the source was in a compatibility mode, and the destination CPU
>       supports the same compatibility mode
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/machine.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 68 insertions(+), 3 deletions(-)
> =

> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 6cb3a48..20a46c9 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -8,6 +8,7 @@
>  #include "helper_regs.h"
>  #include "mmu-hash64.h"
>  #include "migration/cpu.h"
> +#include "qapi/error.h"
> =

>  static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
>  {
> @@ -195,6 +196,30 @@ static void cpu_pre_save(void *opaque)
>      }
>  }
> =

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
> +    if (pcc->pvr_match) {
> +        return pcc->pvr_match(pcc, pvr);
> +    }
> +    return false;
> +}
> +
>  static int cpu_post_load(void *opaque, int version_id)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -203,10 +228,31 @@ static int cpu_post_load(void *opaque, int version_=
id)
>      target_ulong msr;
> =

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
> @@ -560,6 +606,24 @@ static const VMStateDescription vmstate_tlbmas =3D {
>      }
>  };
> =

> +static bool compat_needed(void *opaque)
> +{
> +    PowerPCCPU *cpu =3D opaque;
> +
> +    return cpu->vhyp !=3D NULL;
> +}

Would it make sense to relax this to:

  cpu->vhyp !=3D NULL && cpu->compat_pvr

? This would at least allow cross-version migration in cases where we
weren't previously running in a compatibility mode. As it stands it
seems like this would rule out both new->old and old->new migration.

Another possibility might be to only enable migration/checking of
compat_pvr for 2.10 and later, similar to the cpu_pre_2_8_migration
stuff.

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
> @@ -613,6 +677,7 @@ const VMStateDescription vmstate_ppc_cpu =3D {
>          &vmstate_tlb6xx,
>          &vmstate_tlbemb,
>          &vmstate_tlbmas,
> +        &vmstate_compat,
>          NULL
>      }
>  };
> -- =

> 2.9.3
>=20
