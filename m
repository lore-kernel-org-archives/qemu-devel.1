Received: from eggs.gnu.org ([2001:4830:134:3::10]:42750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5N-00026q-KQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5K-0002Ok-Ep
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:57 -0400
Date: Mon, 10 Apr 2017 15:31:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410053109.GN27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-16-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-16-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 15/21] ppc/pnv: add initial IPMI sensors
 for the BMC simulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:40PM +0200, C=E9dric Le Goater wrote:
> Skiboot, the firmware for the PowerNV platform, expects the BMC to
> provide some specific IPMI sensors. These sensors are exposed in the
> device tree and their values are updated by the firmware at boot time.
>=20
> Sensors of interest are :
>=20
> 	"FW Boot Progress"
> 	"Boot Count"
>=20
> As such a device is defined on the command line, we can only detect
> its presence at reset time.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/Makefile.objs |  2 +-
>  hw/ppc/pnv.c         | 17 +++++++++++
>  hw/ppc/pnv_bmc.c     | 81 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/pnv.h |  7 +++++
>  4 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 hw/ppc/pnv_bmc.c
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index ef67ea820158..7efc68674819 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -6,7 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o sp=
apr_rtas.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
=2Eo
>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
>  # IBM PowerNV
> -obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o
> +obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>  obj-y +=3D spapr_pci_vfio.o
>  endif
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index dfa1cf849b35..c7caecad0aa6 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -35,6 +35,7 @@
>  #include "qapi/visitor.h"
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
> +#include "hw/ipmi/ipmi.h"
> =20
>  #include "hw/ppc/xics.h"
>  #include "hw/ppc/pnv_xscom.h"
> @@ -458,16 +459,32 @@ static void *powernv_create_fdt(MachineState *machi=
ne)
>      }
> =20
>      powernv_populate_isa(pnv->isa_bus, fdt);
> +
> +    if (pnv->bmc) {
> +        pnv_bmc_populate_sensors(pnv->bmc, fdt);
> +    }
> +
>      return fdt;
>  }
> =20
>  static void ppc_powernv_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
>      void *fdt;
> =20
>      qemu_devices_reset();
> =20
> +    /* OpenPOWER systems have a BMC, which can be defined on the
> +     * command line with:
> +     *
> +     *   -device ipmi-bmc-sim,id=3Dbmc0
> +     *
> +     * This is the internal simulator but it could also be an external
> +     * BMC.
> +     */
> +    pnv->bmc =3D object_resolve_path_type("", TYPE_IPMI_BMC, NULL);

I'd suggest typing the pointer and doing the cast/test here, rather
than in the functions that need to manipulate it.

>      fdt =3D powernv_create_fdt(machine);
> =20
>      /* Pack resulting tree */
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> new file mode 100644
> index 000000000000..2998530dc4c0
> --- /dev/null
> +++ b/hw/ppc/pnv_bmc.c
> @@ -0,0 +1,81 @@
> +/*
> + * QEMU PowerNV, BMC related functions
> + *
> + * Copyright (c) 2016-2017, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/hw.h"
> +#include "sysemu/sysemu.h"
> +#include "target/ppc/cpu.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/ipmi/ipmi.h"
> +#include "hw/ppc/fdt.h"
> +
> +#include "hw/ppc/pnv.h"
> +
> +#include <libfdt.h>
> +
> +/* TODO: include definition in ipmi.h */
> +#define IPMI_SDR_FULL_TYPE 1
> +
> +void pnv_bmc_populate_sensors(Object *bmc, void *fdt)
> +{
> +    int offset;
> +    int i;
> +    const struct ipmi_sdr_compact *sdr;
> +    uint16_t nextrec;
> +
> +    offset =3D fdt_add_subnode(fdt, 0, "/bmc");
> +    _FDT(offset);
> +
> +    _FDT((fdt_setprop_string(fdt, offset, "name", "bmc")));
> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
> +
> +    offset =3D fdt_add_subnode(fdt, offset, "sensors");
> +    _FDT(offset);
> +
> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
> +
> +    for (i =3D 0; !ipmi_bmc_sdr_find(IPMI_BMC(bmc), i, &sdr, &nextrec); =
i++) {
> +        int off;
> +        char *name;
> +
> +        if (sdr->header.rec_type !=3D IPMI_SDR_COMPACT_TYPE ||
> +            sdr->header.rec_type !=3D IPMI_SDR_FULL_TYPE) {

Um.. the condition above is always true.  It's only false if rec_type
is equal to both FULL_TYPE and COMPACT_TYPE at the same time...

> +            continue;
> +        }
> +
> +        name =3D g_strdup_printf("sensor@%x", sdr->sensor_owner_number);
> +        off =3D fdt_add_subnode(fdt, offset, name);
> +        _FDT(off);
> +        g_free(name);
> +
> +        _FDT((fdt_setprop_cell(fdt, off, "reg", sdr->sensor_owner_number=
)));
> +        _FDT((fdt_setprop_string(fdt, off, "name", "sensor")));
> +        _FDT((fdt_setprop_string(fdt, off, "compatible", "ibm,ipmi-senso=
r")));
> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-sensor-reading-type",
> +                               sdr->reading_type)));
> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-entity-id",
> +                               sdr->entity_id)));
> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-entity-instance",
> +                               sdr->entity_instance)));
> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-sensor-type",
> +                               sdr->sensor_type)));
> +    }
> +}
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index b45a0d91c813..050763f6cf54 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -130,12 +130,19 @@ typedef struct PnvMachineState {
> =20
>      ISABus       *isa_bus;
>      uint32_t     cpld_irqstate;
> +
> +    Object       *bmc;
>  } PnvMachineState;
> =20
>  #define PNV_FDT_ADDR          0x01000000
>  #define PNV_TIMEBASE_FREQ     512000000ULL
> =20
>  /*
> + * BMC helpers
> + */
> +void pnv_bmc_populate_sensors(Object *objbmc, void *fdt);
> +
> +/*
>   * POWER8 MMIO base addresses
>   */
>  #define PNV_XSCOM_SIZE        0x800000000ull

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xidAAoJEGw4ysog2bOS+W8P/ilBGZf/piDJ9u8f6cO5Jnq0
Tz2sE9NcEAlb2bGuwGfrfryNtuFWpp11NHok8rRwPwEB+tWFG6WMrW8Balapgdli
u4hdNVga/BSm2HotigGQJN/+Tdm+RRGgZsHotNYwrTJAA8gJuwCswsAiv9NtiVNt
TxHHYjjuVznu8xeA79+hqFuI2Dhu1d3UnCVT31dtt1Vlp9g//zXAxLlejIrTcgcj
6MRKTMWmEQ8BRJ2bUhLIZabAyBMq6mBlUwf6o0ugjHfjTTNPM/mB+fD++TbHec/U
RyZseU2tfwp5mJBOMCuSvAsEAM10PTPIcGvmmPQ72rHGe3nUaNm8xyeW2I7hInPc
T0EaLPj7ow1/OJASn2JEvOr/mBb9BTyzT60JIO++K1xspplx7CdJIxBXW9Afd6+U
j+xIXvTE5xRH9aCK+6pWia+T9/1SibYPI/uS3IQ7fdSXCJEGmv6oWG9sLtfvOM+3
H11ggktlm+n6RgjGIg6PGDzAXxkTWxgM+FqQ9//YMaL76yLmsJRqK/m+fOVKyqxq
SD7PSY1bYTqxWodwBdwGptBLhjJVqv160AUUiynfofFVMlZWodDLK6x9oUAev5UF
AOte5CaignXbDl7lnTxpXvVxCgkGjogC7K7/cyqN/bqfpfbUXfaqEksnU9FgLV50
h20szMT6ptqEn9ER3nad
=S8si
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
