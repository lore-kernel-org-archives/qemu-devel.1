Received: from eggs.gnu.org ([2001:4830:134:3::10]:39776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw3Nk-0004zC-4G
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw3Ng-0007Lm-S5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:07:08 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:43778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw3Ng-0007L4-L3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:07:04 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0F0B67BE45
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 11:07:02 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
Date: Thu, 6 Apr 2017 11:06:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170406042318.GA12179@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 04/06/2017 06:23 AM, David Gibson wrote:
> On Wed, Apr 05, 2017 at 02:41:29PM +0200, C=E9dric Le Goater wrote:
>> Multi chip systems only have one LPC bus, on chip 0. The PnvLPC object
>> will still be created under the PnvChip objects but only the one under
>> chip 0 will be advertise in the device tree.
>>
>> Also remove the comment which is slightly wrong. Only chip 0 has a LPC
>> device node : xscom@3fc0000000000/isa@b0020
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This seems a very round about way of accomplishing the goal.  Wouldn't
> it make more sense for the chip to only construct (or only realize)
> the LPC if it's chip zero, rather than passing the chip id through to
> the lpc object.

hmm, yes. I can do better on this.=20

The object will be initialized which raises some concern because we don't=
=20
have the chip id at the moment but the object is still valid in some way.=
=20
I think I need to remove it from the list of children of the chip or use=20
a pointer instead.

Thanks,

C.=20

>=20
>> ---
>>  hw/ppc/pnv.c             |  2 ++
>>  hw/ppc/pnv_lpc.c         | 20 ++++++++++++--------
>>  include/hw/ppc/pnv_lpc.h |  2 ++
>>  3 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 78133e5d20e1..493c7eed7980 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -811,6 +811,8 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
>>      g_free(typename);
>> =20
>>      /* Create LPC controller */
>> +    object_property_set_int(OBJECT(&chip->lpc), chip->chip_id, "chip-=
id",
>> +                            &error_fatal);
>>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
>>                               &error_fatal);
>>      pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xsco=
m_regs);
>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>> index 20cbb6a0dbbd..1a212a2a399f 100644
>> --- a/hw/ppc/pnv_lpc.c
>> +++ b/hw/ppc/pnv_lpc.c
>> @@ -92,14 +92,6 @@ enum {
>>  #define LPC_HC_REGS_OPB_SIZE    0x00001000
>> =20
>> =20
>> -/*
>> - * TODO: the "primary" cell should only be added on chip 0. This is
>> - * how skiboot chooses the default LPC controller on multichip
>> - * systems.
>> - *
>> - * It would be easly done if we can change the populate() interface t=
o
>> - * replace the PnvXScomInterface parameter by a PnvChip one
>> - */
>>  static int pnv_lpc_populate(PnvXScomInterface *dev, void *fdt, int xs=
com_offset)
>>  {
>>      const char compat[] =3D "ibm,power8-lpc\0ibm,lpc";
>> @@ -110,6 +102,12 @@ static int pnv_lpc_populate(PnvXScomInterface *de=
v, void *fdt, int xscom_offset)
>>          cpu_to_be32(lpc_pcba),
>>          cpu_to_be32(PNV_XSCOM_LPC_SIZE)
>>      };
>> +    PnvLpcController *lpc =3D PNV_LPC(dev);
>> +
>> +    /* Only populate one LPC bus per system, the one on chip 0.*/
>> +    if (lpc->chip_id) {
>> +        return 0;
>> +    }
>> =20
>>      name =3D g_strdup_printf("isa@%x", lpc_pcba);
>>      offset =3D fdt_add_subnode(fdt, xscom_offset, name);
>> @@ -486,6 +484,11 @@ static void pnv_lpc_realize(DeviceState *dev, Err=
or **errp)
>>      lpc->psi =3D PNV_PSI(obj);
>>  }
>> =20
>> +static Property pnv_lpc_properties[] =3D {
>> +    DEFINE_PROP_UINT32("chip-id", PnvLpcController, chip_id, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>  static void pnv_lpc_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>> @@ -494,6 +497,7 @@ static void pnv_lpc_class_init(ObjectClass *klass,=
 void *data)
>>      xdc->populate =3D pnv_lpc_populate;
>> =20
>>      dc->realize =3D pnv_lpc_realize;
>> +    dc->props =3D pnv_lpc_properties;
>>  }
>> =20
>>  static const TypeInfo pnv_lpc_info =3D {
>> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
>> index 53040026c37b..dcfadda90090 100644
>> --- a/include/hw/ppc/pnv_lpc.h
>> +++ b/include/hw/ppc/pnv_lpc.h
>> @@ -67,6 +67,8 @@ typedef struct PnvLpcController {
>> =20
>>      /* PSI to generate interrupts */
>>      PnvPsi *psi;
>> +
>> +    uint32_t chip_id;
>>  } PnvLpcController;
>> =20
>>  #define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down t=
o ... */
>=20
