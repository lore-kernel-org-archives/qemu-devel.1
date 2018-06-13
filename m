Received: from eggs.gnu.org ([2001:4830:134:3::10]:50871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT11S-0002oK-RX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT11O-0004wy-MN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:54 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT11O-0004uf-Ez
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:50 -0400
Received: from player758.ha.ovh.net (unknown [10.109.108.3])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id AF12418394A
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:20:48 +0200 (CEST)
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-5-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dff8eff9-89da-5fcb-579d-656b356924a4@kaod.org>
Date: Wed, 13 Jun 2018 10:20:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180613065707.30766-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] pnv: Clean up cpu realize path
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
> pnv_cpu_init() is only called from the the pnv cpu core realize path, a=
nd
> really only can be called from there.  So fold it into its caller, whic=
h
> we also rename for brevity.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

I think we should set the default CPU settings (PIR) before creating
the 'intc' object. I have cleanup for that in the pnv patchset.=20
Nevertheless,=20

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv_core.c | 56 ++++++++++++++++++-----------------------------
>  1 file changed, 21 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 59309e149c..c9648fd1ad 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -54,28 +54,6 @@ static void pnv_cpu_reset(void *opaque)
>      env->msr |=3D MSR_HVB; /* Hypervisor mode */
>  }
> =20
> -static void pnv_cpu_init(PowerPCCPU *cpu, Error **errp)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -    int core_pir;
> -    int thread_index =3D 0; /* TODO: TCG supports only one thread */
> -    ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
> -
> -    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &er=
ror_abort);
> -
> -    /*
> -     * The PIR of a thread is the core PIR + the thread index. We will
> -     * need to find a way to get the thread index when TCG supports
> -     * more than 1. We could use the object name ?
> -     */
> -    pir->default_value =3D core_pir + thread_index;
> -
> -    /* Set time-base frequency to 512 MHz */
> -    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> -
> -    qemu_register_reset(pnv_cpu_reset, cpu);
> -}
> -
>  /*
>   * These values are read by the PowerNV HW monitors under Linux
>   */
> @@ -121,29 +99,39 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> -static void pnv_core_realize_child(Object *child, XICSFabric *xi, Erro=
r **errp)
> +static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **=
errp)
>  {
> +    CPUPPCState *env =3D &cpu->env;
> +    int core_pir;
> +    int thread_index =3D 0; /* TODO: TCG supports only one thread */
> +    ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
>      Error *local_err =3D NULL;
> -    CPUState *cs =3D CPU(child);
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -    object_property_set_bool(child, true, "realized", &local_err);
> +    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err=
);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> -    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
> +    cpu->intc =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err=
);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> -    pnv_cpu_init(cpu, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &er=
ror_abort);
> +
> +    /*
> +     * The PIR of a thread is the core PIR + the thread index. We will
> +     * need to find a way to get the thread index when TCG supports
> +     * more than 1. We could use the object name ?
> +     */
> +    pir->default_value =3D core_pir + thread_index;
> +
> +    /* Set time-base frequency to 512 MHz */
> +    cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> +
> +    qemu_register_reset(pnv_cpu_reset, cpu);
>  }
> =20
>  static void pnv_core_realize(DeviceState *dev, Error **errp)
> @@ -184,9 +172,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> -        obj =3D OBJECT(pc->threads[j]);
> -
> -        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
> +        pnv_realize_vcpu(pc->threads[j], XICS_FABRIC(xi), &local_err);
>          if (local_err) {
>              goto err;
>          }
>=20
