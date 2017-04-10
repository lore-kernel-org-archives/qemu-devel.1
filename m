Received: from eggs.gnu.org ([2001:4830:134:3::10]:60770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZGB-0004KP-GO
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZG7-0005bi-I8
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:21:35 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:54510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxZG7-0005aC-Ck
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:21:31 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1C984354F8
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:21:28 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-12-git-send-email-clg@kaod.org>
	<20170410151634.538043c8@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <34241c5a-b650-04e3-eb75-e19291b4e254@kaod.org>
Date: Mon, 10 Apr 2017 15:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170410151634.538043c8@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 11/21] ppc/pnv: scan ISA bus to
 populate device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/10/2017 03:16 PM, Greg Kurz wrote:
> On Wed,  5 Apr 2017 14:41:36 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> This is an empty shell that we will use to include nodes in the device
>> tree for ISA devices. We expect RTC, UART and IPMI BT devices.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 493c7eed7980..a3c8f6594d10 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -281,6 +281,36 @@ static void powernv_populate_chip(PnvChip *chip, =
void *fdt)
>>      g_free(typename);
>>  }
>> =20
>> +typedef struct ForeachPopulateArgs {
>> +    void *fdt;
>> +    int offset;
>> +} ForeachPopulateArgs;
>> +
>> +static int powernv_populate_isa_device(DeviceState *dev, void *opaque=
)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void powernv_populate_isa(ISABus *bus, void *fdt)
>> +{
>> +    int lpc_offset;
>> +    ForeachPopulateArgs args;
>> +
>> +    lpc_offset =3D fdt_node_offset_by_compatible(fdt, -1, "ibm,lpc");
>> +    if (lpc_offset < 0) {
>> +        error_report("Could find the lpc node !?");
>=20
> s/Could find/Could not find ?

yes. I will fix that. =20

Thanks,

C.=20

>=20
>> +        return;
>> +    }
>> +
>> +    args.fdt =3D fdt;
>> +    args.offset =3D lpc_offset;
>> +
>> +    /* ISA devices are not necessarily parented to the ISA bus so we
>> +     * can not use object_child_foreach() */
>> +    qbus_walk_children(BUS(bus), powernv_populate_isa_device,
>> +                       NULL, NULL, NULL, &args);
>> +}
>> +
>>  static void *powernv_create_fdt(MachineState *machine)
>>  {
>>      const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
>> @@ -328,6 +358,8 @@ static void *powernv_create_fdt(MachineState *mach=
ine)
>>      for (i =3D 0; i < pnv->num_chips; i++) {
>>          powernv_populate_chip(pnv->chips[i], fdt);
>>      }
>> +
>> +    powernv_populate_isa(pnv->isa_bus, fdt);
>>      return fdt;
>>  }
>> =20
>=20
