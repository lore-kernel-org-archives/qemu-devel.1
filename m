Received: from eggs.gnu.org ([2001:4830:134:3::10]:35396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fWIcq-0006ML-HC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fWIcl-0006gA-KR
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:45:04 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:48953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fWIcl-0006fY-AI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:44:59 -0400
Received: from player791.ha.ovh.net (unknown [10.109.108.118])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C90F310A5C0
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 11:44:56 +0200 (CEST)
Date: Fri, 22 Jun 2018 11:44:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180622114439.08447173@bahia.lan>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/23] ppc/pnv: introduce a new
 intc_create() operation to the chip model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, agraf@suse.de, aik@ozlabs.ru, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Hi David,

I'm a bit confused by this massive post... it doesn't have any cover letter=
, but
it contains all the patches you recently pushed to ppc-for-3.0. Was it supp=
osed
to be a pull request ?

Cheers,

--
Greg

On Fri, 22 Jun 2018 14:24:15 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> On Power9, the thread interrupt presenter has a different type and is
> linked to the chip owning the cores.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv.c         | 21 +++++++++++++++++++--
>  hw/ppc/pnv_core.c    | 18 +++++++++---------
>  include/hw/ppc/pnv.h |  1 +
>  3 files changed, 29 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0d2b79f798..c7e127ae97 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -671,6 +671,13 @@ static uint32_t pnv_chip_core_pir_p8(PnvChip *chip, =
uint32_t core_id)
>      return (chip->chip_id << 7) | (core_id << 3);
>  }
> =20
> +static Object *pnv_chip_power8_intc_create(PnvChip *chip, Object *child,
> +                                           Error **errp)
> +{
> +    return icp_create(child, TYPE_PNV_ICP, XICS_FABRIC(qdev_get_machine(=
)),
> +                      errp);
> +}
> +
>  /*
>   *    0:48  Reserved - Read as zeroes
>   *   49:52  Node ID
> @@ -686,6 +693,12 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, =
uint32_t core_id)
>      return (chip->chip_id << 8) | (core_id << 2);
>  }
> =20
> +static Object *pnv_chip_power9_intc_create(PnvChip *chip, Object *child,
> +                                           Error **errp)
> +{
> +    return NULL;
> +}
> +
>  /* Allowed core identifiers on a POWER8 Processor Chip :
>   *
>   * <EX0 reserved>
> @@ -721,6 +734,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
>      k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>      k->cores_mask =3D POWER8E_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> +    k->intc_create =3D pnv_chip_power8_intc_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8E";
>  }
> @@ -734,6 +748,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
>      k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> +    k->intc_create =3D pnv_chip_power8_intc_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8";
>  }
> @@ -747,6 +762,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
>      k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> +    k->intc_create =3D pnv_chip_power8_intc_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
>  }
> @@ -760,6 +776,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
>      k->cores_mask =3D POWER9_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p9;
> +    k->intc_create =3D pnv_chip_power9_intc_create;
>      k->xscom_base =3D 0x00603fc00000000ull;
>      dc->desc =3D "PowerNV Chip POWER9";
>  }
> @@ -892,8 +909,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Erro=
r **errp)
>          object_property_set_int(OBJECT(pnv_core),
>                                  pcc->core_pir(chip, core_hwid),
>                                  "pir", &error_fatal);
> -        object_property_add_const_link(OBJECT(pnv_core), "xics",
> -                                       qdev_get_machine(), &error_fatal);
> +        object_property_add_const_link(OBJECT(pnv_core), "chip",
> +                                       OBJECT(chip), &error_fatal);
>          object_property_set_bool(OBJECT(pnv_core), true, "realized",
>                                   &error_fatal);
>          object_unref(OBJECT(pnv_core));
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index f7cf33f547..a9f129fc2c 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -99,13 +99,14 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> -static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **er=
rp)
> +static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip *chip, Error **err=
p)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      int core_pir;
>      int thread_index =3D 0; /* TODO: TCG supports only one thread */
>      ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
>      Error *local_err =3D NULL;
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> =20
>      object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
>      if (local_err) {
> @@ -113,7 +114,7 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFab=
ric *xi, Error **errp)
>          return;
>      }
> =20
> -    cpu->intc =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err);
> +    cpu->intc =3D pcc->intc_create(chip, OBJECT(cpu), &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -143,13 +144,12 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
>      void *obj;
>      int i, j;
>      char name[32];
> -    Object *xi;
> +    Object *chip;
> =20
> -    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
> -    if (!xi) {
> -        error_setg(errp, "%s: required link 'xics' not found: %s",
> -                   __func__, error_get_pretty(local_err));
> -        return;
> +    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
> +    if (!chip) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'chip' not found: ");
>      }
> =20
>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> @@ -166,7 +166,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> -        pnv_realize_vcpu(pc->threads[j], XICS_FABRIC(xi), &local_err);
> +        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
>          if (local_err) {
>              goto err;
>          }
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 90759240a7..e934e84f55 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -76,6 +76,7 @@ typedef struct PnvChipClass {
>      hwaddr       xscom_base;
> =20
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
> +    Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
>  } PnvChipClass;
> =20
>  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
