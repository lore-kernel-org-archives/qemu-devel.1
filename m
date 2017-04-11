Received: from eggs.gnu.org ([2001:4830:134:3::10]:35058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlnd-0006r5-BQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlna-0008Ci-Ge
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:44:57 -0400
Date: Tue, 11 Apr 2017 12:44:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411024435.GY27571@umbus>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
	<1491832618-27536-8-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I/wet25DnWlSyk1C"
Content-Disposition: inline
In-Reply-To: <1491832618-27536-8-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 7/8] ppc/pnv: add initial IPMI sensors
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


--I/wet25DnWlSyk1C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 03:56:57PM +0200, C=E9dric Le Goater wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  Changes since v1:
>=20
>  - fixed test on sdr->header.rec_type which was incorrect
>  - changed the type of the 'bmc' attribute of the machine and changed
>    accordingly the prototype of the helper routines
>=20
>  hw/ppc/Makefile.objs |  2 +-
>  hw/ppc/pnv.c         | 21 ++++++++++++++
>  hw/ppc/pnv_bmc.c     | 81 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/pnv.h |  9 ++++++
>  4 files changed, 112 insertions(+), 1 deletion(-)
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
> index ec5d62a479b3..bb9bb746e04a 100644
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
> @@ -458,16 +459,36 @@ static void *powernv_create_fdt(MachineState *machi=
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
> +    Object *obj;
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
> +    obj =3D object_resolve_path_type("", TYPE_IPMI_BMC, NULL);
> +    if (obj) {
> +        pnv->bmc =3D IPMI_BMC(obj);
> +    }
> +
>      fdt =3D powernv_create_fdt(machine);
> =20
>      /* Pack resulting tree */
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> new file mode 100644
> index 000000000000..a0820dca559b
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
> +void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt)
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
> +    for (i =3D 0; !ipmi_bmc_sdr_find(bmc, i, &sdr, &nextrec); i++) {
> +        int off;
> +        char *name;
> +
> +        if (sdr->header.rec_type !=3D IPMI_SDR_COMPACT_TYPE &&
> +            sdr->header.rec_type !=3D IPMI_SDR_FULL_TYPE) {
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
> index b45a0d91c813..02f6cf565ca4 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -118,6 +118,8 @@ typedef struct PnvChipClass {
>  #define POWERNV_MACHINE(obj) \
>      OBJECT_CHECK(PnvMachineState, (obj), TYPE_POWERNV_MACHINE)
> =20
> +typedef struct IPMIBmc IPMIBmc;
> +
>  typedef struct PnvMachineState {
>      /*< private >*/
>      MachineState parent_obj;
> @@ -130,12 +132,19 @@ typedef struct PnvMachineState {
> =20
>      ISABus       *isa_bus;
>      uint32_t     cpld_irqstate;
> +
> +    IPMIBmc      *bmc;
>  } PnvMachineState;
> =20
>  #define PNV_FDT_ADDR          0x01000000
>  #define PNV_TIMEBASE_FREQ     512000000ULL
> =20
>  /*
> + * BMC helpers
> + */
> +void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt);
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

--I/wet25DnWlSyk1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7EMSAAoJEGw4ysog2bOSzMIP/1+ndYnmpwa1ebayvroW6nlj
jFHdFuXiE+N93qNRMGjhl0dezCoduVePvdGmCXDXlp2PXxkHwDPwqxGtsUDZ89eU
/5v8oYFmZ/7PU3Qyrsqmuq/Hxw2IuhP9R0a2AWkoO63BbZQfnlLsw9T5g0/8X8iK
5tZnIhqd0Kv81qdS5SktKdogZjtGlY5DLICHb4h0QFXjcU6ekgaCbJ8uUlAX4pKs
q3Fc/0FVFkAiBF8yl7wVww1zpsXi8ERc9vnpMXy2Cn3I6OGRb+/RMHp7PteHf0uZ
F/tbr6XabRlm3SQQYUIRlSbsC4SrdDVXUm95WRGsbUfU9AAM2nXqctGfV/WT7fh6
M/aPICDsr2/MmQSyzZglKZkJOFtlsgPSjFPVopKci1mjquuYR2Xph6DufF7GxUjo
pd4aOr/SL6MFHo6KTSzV8fLGGUBp6HyTw5nHg046T2NI76kWWYzAmTjx39P063ew
fY13PAqwG/wX5WWdzsZOqdkC2m9FWsvpT5xx5Et2UPeWoUPcOK1jNTSYgd0jHlDz
pzqIzmI0puyl8nYimWJba1Sat8wk9bPQCqDBML3/zr6QSLeTwZmBcXoQueROKzSk
8ieugbWwD5dzoz4Dd3Zs3kR+h5x62aUToh8+M4sh1NsNj8ZLZXnG/bV0cACPEhBX
XsUv0NWHY7KOc6TQ63ZC
=UWYC
-----END PGP SIGNATURE-----

--I/wet25DnWlSyk1C--
