Received: from eggs.gnu.org ([2001:4830:134:3::10]:60797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dHu3s-0003yc-UN
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dHu3p-0002UY-Ng
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:36:56 -0400
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:55122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dHu3p-0002OL-He
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:36:53 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6A3BBE94ED
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 17:36:44 +0200 (CEST)
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<20170424015927.8933-42-david@gibson.dropbear.id.au>
	<CAFEAcA8FvmfwwhbNEz4qvGCjoPEQn6bJh-WiwRM7Ot0uEV8ACg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3dfac1c5-b23d-8f8a-912a-974b6a96b203@kaod.org>
Date: Mon, 5 Jun 2017 17:36:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8FvmfwwhbNEz4qvGCjoPEQn6bJh-WiwRM7Ot0uEV8ACg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 41/47] ppc/pnv: populate device tree for
 IPMI BT devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 06/05/2017 04:33 PM, Peter Maydell wrote:
> On 24 April 2017 at 02:59, David Gibson <david@gibson.dropbear.id.au> w=
rote:
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> When an ipmi-bt device [1] is defined on the ISA bus, we need to
>> populate the device tree with the object properties. Such devices are
>> created with the command line options :
>>
>>    -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D=
10
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg03168.htm=
l
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index dfa21e4..977e126 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -354,6 +354,39 @@ static void powernv_populate_serial(ISADevice *d,=
 void *fdt, int lpc_off)
>>      _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
>>  }
>>
>> +static void powernv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc=
_off)
>> +{
>> +    const char compatible[] =3D "bt\0ipmi-bt";
>> +    uint32_t io_base;
>> +    uint32_t io_regs[] =3D {
>> +        cpu_to_be32(1),
>> +        0, /* 'io_base' retrieved from the 'ioport' property of 'isa-=
ipmi-bt' */
>> +        cpu_to_be32(3)
>> +    };
>> +    uint32_t irq;
>> +    char *name;
>> +    int node;
>> +
>> +    io_base =3D object_property_get_int(OBJECT(d), "ioport", &error_f=
atal);
>> +    io_regs[1] =3D cpu_to_be32(io_base);
>> +
>> +    irq =3D object_property_get_int(OBJECT(d), "irq", &error_fatal);
>> +
>> +    name =3D g_strdup_printf("%s@i%x", qdev_fw_name(DEVICE(d)), io_ba=
se);
>> +    node =3D fdt_add_subnode(fdt, lpc_off, name);
>> +    _FDT(node);
>> +    g_free(name);
>> +
>> +    fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs));
>> +    fdt_setprop(fdt, node, "compatible", compatible, sizeof(compatibl=
e));
>> +
>> +    /* Mark it as reserved to avoid Linux trying to claim it */
>> +    _FDT((fdt_setprop_string(fdt, node, "status", "reserved")));
>> +    _FDT((fdt_setprop_cell(fdt, node, "interrupts", irq)));
>> +    _FDT((fdt_setprop_cell(fdt, node, "interrupt-parent",
>> +                           fdt_get_phandle(fdt, lpc_off))));
>> +}
>=20
> Hi -- Coverity points out (CID 1374832) that the fdt_setprop() calls
> in this function to set "reg" and "compatible" don't check whether the
> function returns an error. Is there any reason why these calls
> haven't been wrapped with the barf-on-errors _FDT() macro like the
> other fdt_setprop* calls in the function?

none. I will send a fix for it.=20

Thanks,

C.=20
