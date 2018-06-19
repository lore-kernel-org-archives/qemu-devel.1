Received: from eggs.gnu.org ([2001:4830:134:3::10]:54423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fV8nN-0006v3-9W
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fV8nK-0003vJ-6Z
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:03:09 -0400
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:54774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fV8nJ-0003us-T4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:03:06 -0400
Received: from player759.ha.ovh.net (unknown [10.109.120.50])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3636A1BDD1D
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 07:03:04 +0200 (CEST)
References: <20180618170540.12143-1-clg@kaod.org>
	<20180618170540.12143-3-clg@kaod.org>
	<20180619002818.GJ25461@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ea21c994-9a0a-2543-3237-bfc181606ecf@kaod.org>
Date: Tue, 19 Jun 2018 07:03:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180619002818.GJ25461@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ppc/pnv: consolidate the creation
 of the ISA bus device tree
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

On 06/19/2018 02:28 AM, David Gibson wrote:
> On Mon, Jun 18, 2018 at 07:05:40PM +0200, C=E9dric Le Goater wrote:
>> The device tree node of the ISA bus was being partially done in
>> different places. Move all the nodes creation under the same routine.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv.c | 51 +++++++++++++++++++++++----------------------------
>>  1 file changed, 23 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index a29ea996b45d..7401ffe5b01c 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -265,18 +265,6 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, =
uint32_t pir,
>>      g_free(reg);
>>  }
>> =20
>> -static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
>> -{
>> -    char *name;
>> -    int offset;
>> -
>> -    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
>> -                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM=
_LPC_BASE);
>> -    offset =3D fdt_path_offset(fdt, name);
>> -    g_free(name);
>> -    return offset;
>> -}
>> -
>>  static void pnv_dt_chip(PnvChip *chip, void *fdt)
>>  {
>>      const char *typename =3D pnv_chip_core_typename(chip);
>> @@ -285,16 +273,6 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
>> =20
>>      pnv_dt_xscom(chip, fdt, 0);
>> =20
>> -    /* The default LPC bus of a multichip system is on chip 0. It's
>> -     * recognized by the firmware (skiboot) using a "primary"
>> -     * property.
>> -     */
>> -    if (chip->chip_id =3D=3D 0x0) {
>> -        int lpc_offset =3D pnv_chip_lpc_offset(chip, fdt);
>> -
>> -        _FDT((fdt_setprop(fdt, lpc_offset, "primary", NULL, 0)));
>> -    }
>> -
>>      for (i =3D 0; i < chip->nr_cores; i++) {
>>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
>> =20
>> @@ -418,16 +396,35 @@ static int pnv_dt_isa_device(DeviceState *dev, v=
oid *opaque)
>>      return 0;
>>  }
>> =20
>> -static void pnv_dt_isa(ISABus *bus, void *fdt, int lpc_offset)
>> +static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
>=20
> AFAICT, this only has one caller, so you could probably fold it in
> there.  Not a big deal, though.

yes. Next round I think. With P9, it becomes :

static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
{
    char *name;
    int offset;

    if (pnv_chip_is_power9(chip)) {
        name =3D g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                               (uint64_t) PNV9_LPCM_BASE(chip));
    } else {
        name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
                               (uint64_t) PNV_XSCOM_BASE(chip),
                               PNV_XSCOM_LPC_BASE);
    }
    offset =3D fdt_path_offset(fdt, name);
    g_free(name);
    return offset;
}

I need to simplify that. Probably with the patch I already sent
moving the name under the LPC model.

Thanks,

C.

>=20
>> +{
>> +    char *name;
>> +    int offset;
>> +
>> +    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
>> +                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM=
_LPC_BASE);
>> +    offset =3D fdt_path_offset(fdt, name);
>> +    g_free(name);
>> +    return offset;
>> +}
>> +
>> +/* The default LPC bus of a multichip system is on chip 0. It's
>> + * recognized by the firmware (skiboot) using a "primary" property.
>> + */
>> +static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
>>  {
>> +    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
>>      ForeachPopulateArgs args =3D {
>>          .fdt =3D fdt,
>> -        .offset =3D lpc_offset,
>> +        .offset =3D isa_offset,
>>      };
>> =20
>> +    _FDT((fdt_setprop(fdt, isa_offset, "primary", NULL, 0)));
>> +
>>      /* ISA devices are not necessarily parented to the ISA bus so we
>>       * can not use object_child_foreach() */
>> -    qbus_walk_children(BUS(bus), pnv_dt_isa_device, NULL, NULL, NULL,=
 &args);
>> +    qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NU=
LL, NULL,
>> +                       &args);
>>  }
>> =20
>>  static void *pnv_dt_create(MachineState *machine)
>> @@ -438,7 +435,6 @@ static void *pnv_dt_create(MachineState *machine)
>>      char *buf;
>>      int off;
>>      int i;
>> -    int lpc_offset;
>> =20
>>      fdt =3D g_malloc0(FDT_MAX_SIZE);
>>      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
>> @@ -480,8 +476,7 @@ static void *pnv_dt_create(MachineState *machine)
>>      }
>> =20
>>      /* Populate ISA devices on chip 0 */
>> -    lpc_offset =3D pnv_chip_lpc_offset(pnv->chips[0], fdt);
>> -    pnv_dt_isa(pnv->isa_bus, fdt, lpc_offset);
>> +    pnv_dt_isa(pnv, fdt);
>> =20
>>      if (pnv->bmc) {
>>          pnv_dt_bmc_sensors(pnv->bmc, fdt);
>=20
