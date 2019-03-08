Received: from eggs.gnu.org ([209.51.188.92]:36608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h29Py-00006g-9J
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h29Px-0001RV-BB
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:55:42 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:54733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h29Px-0001Or-2x
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:55:41 -0500
Received: from player756.ha.ovh.net (unknown [10.109.160.39])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 944B5E5DE8
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 07:55:38 +0100 (CET)
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-6-clg@kaod.org>
	<20190308000107.GD7722@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <52db5166-7d8f-8758-3e1d-fd4b8738eb4d@kaod.org>
Date: Fri, 8 Mar 2019 07:55:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190308000107.GD7722@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/15] ppc/pnv: add a 'dt_isa_nodename'
 to the chip
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

On 3/8/19 1:01 AM, David Gibson wrote:
> On Thu, Mar 07, 2019 at 11:35:38PM +0100, C=E9dric Le Goater wrote:
>> The ISA bus has a different DT nodename on POWER9. Compute the name
>> when the PnvChip is realized, that is before it is used by the machine
>> to populate the device tree with the ISA devices.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I still tend to think that passing an offset into pnv_dt_isa would
> have been a better solution, but this will serve.  Applied.

Do you mean something like below possibly ?=20

   int isa_offset =3D fdt_path_offset(fdt, pnv->chips[0]->dt_isa_nodename=
);

   /* Populate ISA devices on chip 0 */
   pnv_dt_isa(pnv->isa_bus, fdt, isa_offset);


pnv_dt_isa() is called at the machine level but we could change it
to be called at the chip level for chip0 only.

C.


>> ---
>>  include/hw/ppc/pnv.h |  2 ++
>>  hw/ppc/pnv.c         | 18 +++++-------------
>>  2 files changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index 8d80cb34eebb..c81f157f41a9 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -58,6 +58,8 @@ typedef struct PnvChip {
>>      MemoryRegion xscom_mmio;
>>      MemoryRegion xscom;
>>      AddressSpace xscom_as;
>> +
>> +    gchar        *dt_isa_nodename;
>>  } PnvChip;
>> =20
>>  #define TYPE_PNV8_CHIP "pnv8-chip"
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 922e3ec48bb5..6625562d276d 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -417,24 +417,12 @@ static int pnv_dt_isa_device(DeviceState *dev, v=
oid *opaque)
>>      return 0;
>>  }
>> =20
>> -static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
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
>>  /* The default LPC bus of a multichip system is on chip 0. It's
>>   * recognized by the firmware (skiboot) using a "primary" property.
>>   */
>>  static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
>>  {
>> -    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
>> +    int isa_offset =3D fdt_path_offset(fdt, pnv->chips[0]->dt_isa_nod=
ename);
>>      ForeachPopulateArgs args =3D {
>>          .fdt =3D fdt,
>>          .offset =3D isa_offset,
>> @@ -866,6 +854,10 @@ static void pnv_chip_power8_realize(DeviceState *=
dev, Error **errp)
>>                               &error_fatal);
>>      pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xsc=
om_regs);
>> =20
>> +    chip->dt_isa_nodename =3D g_strdup_printf("/xscom@%" PRIx64 "/isa=
@%x",
>> +                                            (uint64_t) PNV_XSCOM_BASE=
(chip),
>> +                                            PNV_XSCOM_LPC_BASE);
>> +
>>      /* Interrupt Management Area. This is the memory region holding
>>       * all the Interrupt Control Presenter (ICP) registers */
>>      pnv_chip_icp_realize(chip8, &local_err);
>=20
