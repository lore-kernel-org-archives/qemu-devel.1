Received: from eggs.gnu.org ([2001:4830:134:3::10]:45140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqCw9-00047P-Sj
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqCw4-0008Oh-AH
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:38:45 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:49294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dqCw4-0008Nq-40
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:38:40 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id CC9159527C
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 08:38:36 +0200 (CEST)
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9b9d7198-2758-d9d7-df3b-1efab8a724f2@kaod.org>
Date: Fri, 8 Sep 2017 08:38:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

On 09/06/2017 10:27 AM, Nikunj A Dadhania wrote:
> When the user does not provide the cpu topology, e.g. "-smp 4", machine=
 fails to
> initialize 4 cpus. Compute the chip per cores depending on the number o=
f chips
> and smt threads.

I think we could also use the '-numa' options to define the cpus
per chip but this patch defines a good default layout and fixes=20
an issue. =20

> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

I pushed the patch under the latest powernv tree :

	https://github.com/legoater/qemu.git tags/powernv-2.10

Thanks,

C.

> ---
>  hw/ppc/pnv.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9724719..3fbaafb 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -642,7 +642,7 @@ static void ppc_powernv_init(MachineState *machine)
>      MemoryRegion *ram;
>      char *fw_filename;
>      long fw_size;
> -    int i;
> +    int i, cores_per_chip;
>      char *chip_typename;
>      PCIBus *pbus;
>      bool has_gfx =3D false;
> @@ -710,6 +710,22 @@ static void ppc_powernv_init(MachineState *machine=
)
>      }
> =20
>      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
> +
> +    /* If user has specified number of cores, use it. Otherwise, compu=
te it. */
> +    if (smp_cores !=3D 1) {
> +        cores_per_chip =3D smp_cores;
> +    } else {
> +        cores_per_chip =3D smp_cpus / (smp_threads * pnv->num_chips);
> +    }
> +
> +    if (smp_cpus !=3D (smp_threads * pnv->num_chips * cores_per_chip))=
 {
> +        error_report("cpu topology not balanced: "
> +                     "chips (%u) * cores (%u) * threads (%u) !=3D "
> +                     "number of cpus (%u)",
> +                     pnv->num_chips, cores_per_chip, smp_threads, smp_=
cpus);
> +        exit(1);
> +    }
> +
>      for (i =3D 0; i < pnv->num_chips; i++) {
>          char chip_name[32];
>          Object *chip =3D object_new(chip_typename);
> @@ -728,7 +744,7 @@ static void ppc_powernv_init(MachineState *machine)
>          object_property_add_child(OBJECT(pnv), chip_name, chip, &error=
_fatal);
>          object_property_set_int(chip, PNV_CHIP_HWID(i), "chip-id",
>                                  &error_fatal);
> -        object_property_set_int(chip, smp_cores, "nr-cores", &error_fa=
tal);
> +        object_property_set_int(chip, cores_per_chip, "nr-cores", &err=
or_fatal);
>          object_property_set_int(chip, 1, "num-phbs", &error_fatal);
>          object_property_set_bool(chip, true, "realized", &error_fatal)=
;
>      }
>=20
