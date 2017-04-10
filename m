Received: from eggs.gnu.org ([2001:4830:134:3::10]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxVZe-0006cW-D0
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxVZb-0005N8-8F
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:25:26 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:53447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxVZa-0005MM-Uc
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:25:23 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 74A6A348DD
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 11:25:21 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-16-git-send-email-clg@kaod.org>
	<20170410053109.GN27571@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <81be4d40-9dbd-b424-ccd8-38d63116bbd8@kaod.org>
Date: Mon, 10 Apr 2017 11:25:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170410053109.GN27571@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/10/2017 07:31 AM, David Gibson wrote:
> On Wed, Apr 05, 2017 at 02:41:40PM +0200, C=E9dric Le Goater wrote:
>> Skiboot, the firmware for the PowerNV platform, expects the BMC to
>> provide some specific IPMI sensors. These sensors are exposed in the
>> device tree and their values are updated by the firmware at boot time.
>>
>> Sensors of interest are :
>>
>> 	"FW Boot Progress"
>> 	"Boot Count"
>>
>> As such a device is defined on the command line, we can only detect
>> its presence at reset time.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/Makefile.objs |  2 +-
>>  hw/ppc/pnv.c         | 17 +++++++++++
>>  hw/ppc/pnv_bmc.c     | 81 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/pnv.h |  7 +++++
>>  4 files changed, 106 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/ppc/pnv_bmc.c
>>
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index ef67ea820158..7efc68674819 100644
>> --- a/hw/ppc/Makefile.objs
>> +++ b/hw/ppc/Makefile.objs
>> @@ -6,7 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o=
 spapr_rtas.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_=
rng.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
>>  # IBM PowerNV
>> -obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv=
_psi.o pnv_occ.o
>> +obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv=
_psi.o pnv_occ.o pnv_bmc.o
>>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>>  obj-y +=3D spapr_pci_vfio.o
>>  endif
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index dfa1cf849b35..c7caecad0aa6 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -35,6 +35,7 @@
>>  #include "qapi/visitor.h"
>>  #include "monitor/monitor.h"
>>  #include "hw/intc/intc.h"
>> +#include "hw/ipmi/ipmi.h"
>> =20
>>  #include "hw/ppc/xics.h"
>>  #include "hw/ppc/pnv_xscom.h"
>> @@ -458,16 +459,32 @@ static void *powernv_create_fdt(MachineState *ma=
chine)
>>      }
>> =20
>>      powernv_populate_isa(pnv->isa_bus, fdt);
>> +
>> +    if (pnv->bmc) {
>> +        pnv_bmc_populate_sensors(pnv->bmc, fdt);
>> +    }
>> +
>>      return fdt;
>>  }
>> =20
>>  static void ppc_powernv_reset(void)
>>  {
>>      MachineState *machine =3D MACHINE(qdev_get_machine());
>> +    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
>>      void *fdt;
>> =20
>>      qemu_devices_reset();
>> =20
>> +    /* OpenPOWER systems have a BMC, which can be defined on the
>> +     * command line with:
>> +     *
>> +     *   -device ipmi-bmc-sim,id=3Dbmc0
>> +     *
>> +     * This is the internal simulator but it could also be an externa=
l
>> +     * BMC.
>> +     */
>> +    pnv->bmc =3D object_resolve_path_type("", TYPE_IPMI_BMC, NULL);
>=20
> I'd suggest typing the pointer and doing the cast/test here, rather
> than in the functions that need to manipulate it.

OK.
>=20
>>      fdt =3D powernv_create_fdt(machine);
>> =20
>>      /* Pack resulting tree */
>> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
>> new file mode 100644
>> index 000000000000..2998530dc4c0
>> --- /dev/null
>> +++ b/hw/ppc/pnv_bmc.c
>> @@ -0,0 +1,81 @@
>> +/*
>> + * QEMU PowerNV, BMC related functions
>> + *
>> + * Copyright (c) 2016-2017, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License, version 2, a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/hw.h"
>> +#include "sysemu/sysemu.h"
>> +#include "target/ppc/cpu.h"
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +#include "hw/ipmi/ipmi.h"
>> +#include "hw/ppc/fdt.h"
>> +
>> +#include "hw/ppc/pnv.h"
>> +
>> +#include <libfdt.h>
>> +
>> +/* TODO: include definition in ipmi.h */
>> +#define IPMI_SDR_FULL_TYPE 1
>> +
>> +void pnv_bmc_populate_sensors(Object *bmc, void *fdt)
>> +{
>> +    int offset;
>> +    int i;
>> +    const struct ipmi_sdr_compact *sdr;
>> +    uint16_t nextrec;
>> +
>> +    offset =3D fdt_add_subnode(fdt, 0, "/bmc");
>> +    _FDT(offset);
>> +
>> +    _FDT((fdt_setprop_string(fdt, offset, "name", "bmc")));
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
>> +
>> +    offset =3D fdt_add_subnode(fdt, offset, "sensors");
>> +    _FDT(offset);
>> +
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
>> +
>> +    for (i =3D 0; !ipmi_bmc_sdr_find(IPMI_BMC(bmc), i, &sdr, &nextrec=
); i++) {
>> +        int off;
>> +        char *name;
>> +
>> +        if (sdr->header.rec_type !=3D IPMI_SDR_COMPACT_TYPE ||
>> +            sdr->header.rec_type !=3D IPMI_SDR_FULL_TYPE) {
>=20
> Um.. the condition above is always true.  It's only false if rec_type
> is equal to both FULL_TYPE and COMPACT_TYPE at the same time...

yes. that is a last minute bug ... It should be using "&&".

Thanks,

C.

>=20
>> +            continue;
>> +        }
>> +
>> +        name =3D g_strdup_printf("sensor@%x", sdr->sensor_owner_numbe=
r);
>> +        off =3D fdt_add_subnode(fdt, offset, name);
>> +        _FDT(off);
>> +        g_free(name);
>> +
>> +        _FDT((fdt_setprop_cell(fdt, off, "reg", sdr->sensor_owner_num=
ber)));
>> +        _FDT((fdt_setprop_string(fdt, off, "name", "sensor")));
>> +        _FDT((fdt_setprop_string(fdt, off, "compatible", "ibm,ipmi-se=
nsor")));
>> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-sensor-reading-type",
>> +                               sdr->reading_type)));
>> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-entity-id",
>> +                               sdr->entity_id)));
>> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-entity-instance",
>> +                               sdr->entity_instance)));
>> +        _FDT((fdt_setprop_cell(fdt, off, "ipmi-sensor-type",
>> +                               sdr->sensor_type)));
>> +    }
>> +}
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index b45a0d91c813..050763f6cf54 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -130,12 +130,19 @@ typedef struct PnvMachineState {
>> =20
>>      ISABus       *isa_bus;
>>      uint32_t     cpld_irqstate;
>> +
>> +    Object       *bmc;
>>  } PnvMachineState;
>> =20
>>  #define PNV_FDT_ADDR          0x01000000
>>  #define PNV_TIMEBASE_FREQ     512000000ULL
>> =20
>>  /*
>> + * BMC helpers
>> + */
>> +void pnv_bmc_populate_sensors(Object *objbmc, void *fdt);
>> +
>> +/*
>>   * POWER8 MMIO base addresses
>>   */
>>  #define PNV_XSCOM_SIZE        0x800000000ull
>=20
