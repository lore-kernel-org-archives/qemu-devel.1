Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M0t-0005e7-34
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M0p-0003Wi-S5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:21:35 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:32868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0M0p-0003UY-Iv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:21:31 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id EDC6F138175
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 08:21:29 +0200 (CEST)
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-19-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bd961b2f-7843-a9b9-b12a-1de40242a640@kaod.org>
Date: Fri, 6 Oct 2017 08:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <1507220690-265042-19-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 18/23] ppc: pnv: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 10/05/2017 06:24 PM, Igor Mammedov wrote:
> use common cpu_model prasing in vl.c and set default cpu_model
> using generic MachineClass::default_cpu_type.
>=20
> Beside of switching to generic infrastructure it solves several
> issues.
>=20
>  * ppc_cpu_class_by_name() is used to deal with lower/upper case
>    and alias translations into actual cpu type, which fixes
>     '-M powernv -cpu power8' and '-M powernv -cpu power9_v1.0'
>    usecases which error out with:
>     'invalid CPU model 'FOO' for powernv machine'
>  * allows to switch to lower-case typenames in pnv chip/core name
>    (by convention typnames should be lower-case)
>  * replace aliased names /power8, power9, .../ with exact cpu model
>    names (i.e. typenames should be stable but aliases might decide to
>    point to other cpu model withi family or changed by kvm). It will
>    also help to simplify pnv_chip/core code and get rid of dependency
>    on cpu_model parsing.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>  include/hw/ppc/pnv.h |  8 ++++----
>  hw/ppc/pnv.c         | 22 ++++++++++------------
>  hw/ppc/pnv_core.c    |  2 +-
>  3 files changed, 15 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 9c5437d..2525f7f 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -80,19 +80,19 @@ typedef struct PnvChipClass {
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>  } PnvChipClass;
> =20
> -#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-POWER8E"
> +#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-power8e_v2.1"
>  #define PNV_CHIP_POWER8E(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8E)
> =20
> -#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-POWER8"
> +#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-power8_v2.0"
>  #define PNV_CHIP_POWER8(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8)
> =20
> -#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-POWER8NVL"
> +#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-power8nvl_v1.0"
>  #define PNV_CHIP_POWER8NVL(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8NVL)
> =20
> -#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-POWER9"
> +#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-power9_v1.0"
>  #define PNV_CHIP_POWER9(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER9)
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d46d91c..4169837 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -607,16 +607,13 @@ static void ppc_powernv_init(MachineState *machin=
e)
>          }
>      }
> =20
> -    /* We need some cpu model to instantiate the PnvChip class */
> -    if (machine->cpu_model =3D=3D NULL) {
> -        machine->cpu_model =3D "POWER8";
> -    }
> -
>      /* Create the processor chips */
> -    chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cp=
u_model);
> +    i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
> +    chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%.*s",
> +                                    i, machine->cpu_type);
>      if (!object_class_by_name(chip_typename)) {
> -        error_report("invalid CPU model '%s' for %s machine",
> -                     machine->cpu_model, MACHINE_GET_CLASS(machine)->n=
ame);
> +        error_report("invalid CPU model '%.*s' for %s machine",
> +                     i, machine->cpu_type, MACHINE_GET_CLASS(machine)-=
>name);
>          exit(1);
>      }
> =20
> @@ -716,7 +713,7 @@ static void pnv_chip_power8e_class_init(ObjectClass=
 *klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "POWER8E";
> +    k->cpu_model =3D "power8e_v2.1";
>      k->chip_type =3D PNV_CHIP_POWER8E;
>      k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>      k->cores_mask =3D POWER8E_CORE_MASK;
> @@ -738,7 +735,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "POWER8";
> +    k->cpu_model =3D "power8_v2.0";
>      k->chip_type =3D PNV_CHIP_POWER8;
>      k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
> @@ -760,7 +757,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "POWER8NVL";
> +    k->cpu_model =3D "power8nvl_v1.0";
>      k->chip_type =3D PNV_CHIP_POWER8NVL;
>      k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
> @@ -782,7 +779,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "POWER9";
> +    k->cpu_model =3D "power9_v1.0";
>      k->chip_type =3D PNV_CHIP_POWER9;
>      k->chip_cfam_id =3D 0x100d104980000000ull; /* P9 Nimbus DD1.0 */
>      k->cores_mask =3D POWER9_CORE_MASK;
> @@ -1133,6 +1130,7 @@ static void powernv_machine_class_init(ObjectClas=
s *oc, void *data)
>      mc->init =3D ppc_powernv_init;
>      mc->reset =3D ppc_powernv_reset;
>      mc->max_cpus =3D MAX_CPUS;
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device f=
or
>                                        * storage */
>      mc->no_parallel =3D 1;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 6726483..44b0b24 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -227,7 +227,7 @@ static const TypeInfo pnv_core_info =3D {
>  };
> =20
>  static const char *pnv_core_models[] =3D {
> -    "POWER8E", "POWER8", "POWER8NVL", "POWER9"
> +    "power8e_v2.1", "power8_v2.0", "power8nvl_v1.0", "power9_v1.0"
>  };
> =20
>  static void pnv_core_register_types(void)
>=20
