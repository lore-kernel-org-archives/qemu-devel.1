Received: from eggs.gnu.org ([2001:4830:134:3::10]:49307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0su-0006mF-D7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0so-0006PQ-G8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:12:04 -0400
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:48453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT0so-0006OY-5w
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:11:58 -0400
Received: from player793.ha.ovh.net (unknown [10.109.120.75])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4DC2D162AE7
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:11:54 +0200 (CEST)
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6a1cc08b-5509-f03d-7da7-97429d7003c5@kaod.org>
Date: Wed, 13 Jun 2018 10:11:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180613065707.30766-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] spapr: Clean up cpu realize/unrealize
 paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/13/2018 08:57 AM, David Gibson wrote:
> spapr_cpu_init() and spapr_cpu_destroy() are only called from the spapr
> cpu core realize/unrealize paths, and really can only be called from th=
ere.
>=20
> Those are all short functions, so fold the pairs together for simplicit=
y.
> While we're there rename some functions and change some parameter types
> for brevity and clarity.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Still a call to spapr_cpu_reset(cpu). We should try to get rid of it
one day.
=20
Thanks,

C.

> ---
>  hw/ppc/spapr_cpu_core.c | 69 +++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 44 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index f3e9b879b2..7fdb3b6667 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -83,26 +83,6 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, targ=
et_ulong nip, target_ulong r
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
>  }
> =20
> -static void spapr_cpu_destroy(PowerPCCPU *cpu)
> -{
> -    qemu_unregister_reset(spapr_cpu_reset, cpu);
> -}
> -
> -static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
> -                           Error **errp)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -
> -    /* Set time-base frequency to 512 MHz */
> -    cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> -
> -    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> -    kvmppc_set_papr(cpu);
> -
> -    qemu_register_reset(spapr_cpu_reset, cpu);
> -    spapr_cpu_reset(cpu);
> -}
> -
>  /*
>   * Return the sPAPR CPU core type for @model which essentially is the =
CPU
>   * model specified with -cpu cmdline option.
> @@ -122,44 +102,47 @@ const char *spapr_get_cpu_core_type(const char *c=
pu_type)
>      return object_class_get_name(oc);
>  }
> =20
> -static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
> +static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
> +{
> +    qemu_unregister_reset(spapr_cpu_reset, cpu);
> +    object_unparent(cpu->intc);
> +    cpu_remove_sync(CPU(cpu));
> +    object_unparent(OBJECT(cpu));
> +}
> +
> +static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
>  {
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(dev);
>      int i;
> =20
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        Object *obj =3D OBJECT(sc->threads[i]);
> -        DeviceState *dev =3D DEVICE(obj);
> -        CPUState *cs =3D CPU(dev);
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -        spapr_cpu_destroy(cpu);
> -        object_unparent(cpu->intc);
> -        cpu_remove_sync(cs);
> -        object_unparent(obj);
> +        spapr_unrealize_vcpu(sc->threads[i]);
>      }
>      g_free(sc->threads);
>  }
> =20
> -static void spapr_cpu_core_realize_child(Object *child,
> -                                         sPAPRMachineState *spapr, Err=
or **errp)
> +static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
> +                               Error **errp)
>  {
> +    CPUPPCState *env =3D &cpu->env;
>      Error *local_err =3D NULL;
> -    CPUState *cs =3D CPU(child);
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -    object_property_set_bool(child, true, "realized", &local_err);
> +    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err=
);
>      if (local_err) {
>          goto error;
>      }
> =20
> -    spapr_cpu_init(spapr, cpu, &local_err);
> -    if (local_err) {
> -        goto error;
> -    }
> +    /* Set time-base frequency to 512 MHz */
> +    cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> +
> +    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> +    kvmppc_set_papr(cpu);
> =20
> -    cpu->intc =3D icp_create(child, spapr->icp_type, XICS_FABRIC(spapr=
),
> +    qemu_register_reset(spapr_cpu_reset, cpu);
> +    spapr_cpu_reset(cpu);
> +
> +    cpu->intc =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC=
(spapr),
>                             &local_err);
>      if (local_err) {
>          goto error;
> @@ -220,9 +203,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> -        obj =3D OBJECT(sc->threads[j]);
> -
> -        spapr_cpu_core_realize_child(obj, spapr, &local_err);
> +        spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
>          if (local_err) {
>              goto err;
>          }
> @@ -249,7 +230,7 @@ static void spapr_cpu_core_class_init(ObjectClass *=
oc, void *data)
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
> =20
>      dc->realize =3D spapr_cpu_core_realize;
> -    dc->unrealize =3D spapr_cpu_core_unrealizefn;
> +    dc->unrealize =3D spapr_cpu_core_unrealize;
>      dc->props =3D spapr_cpu_core_properties;
>      scc->cpu_type =3D data;
>  }
>=20
