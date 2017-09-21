Received: from eggs.gnu.org ([2001:4830:134:3::10]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duzXo-0005RV-8e
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duzXk-00050L-9V
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:21:24 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:57288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duzXk-0004w5-1Q
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:21:20 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B9593AABFB
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 13:21:17 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org> <20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
	<20170921013548.GB4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
Date: Thu, 21 Sep 2017 13:21:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170921013548.GB4998@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 18/21] ppc/xive: add device tree
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/21/2017 03:35 AM, David Gibson wrote:
> On Wed, Sep 20, 2017 at 02:26:32PM +0200, C=E9dric Le Goater wrote:
>> On 09/19/2017 10:44 AM, David Gibson wrote:
>>> On Mon, Sep 11, 2017 at 07:12:32PM +0200, C=E9dric Le Goater wrote:
>>>> Like for XICS, the XIVE interface for the guest is described in the
>>>> device tree under the "interrupt-controller" node. A couple of new
>>>> properties are specific to XIVE :
>>>>
>>>>  - "reg"
>>>>
>>>>    contains the base address and size of the thread interrupt
>>>>    managnement areas (TIMA), also called rings, for the User level a=
nd
>>>>    for the Guest OS level. Only the Guest OS level is taken into
>>>>    account today.
>>>>
>>>>  - "ibm,xive-eq-sizes"
>>>>
>>>>    the size of the event queues. One cell per size supported, contai=
ns
>>>>    log2 of size, in ascending order.
>>>>
>>>>  - "ibm,xive-lisn-ranges"
>>>>
>>>>    the interrupt numbers ranges assigned to the guest. These are
>>>>    allocated using a simple bitmap.
>>>>
>>>> and also under the root node :
>>>>
>>>>  - "ibm,plat-res-int-priorities"
>>>>
>>>>    contains a list of priorities that the hypervisor has reserved fo=
r
>>>>    its own use. Simulate ranges as defined by the PowerVM Hypervisor=
.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/spapr_xive_hcall.c  | 54 ++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>  include/hw/ppc/spapr_xive.h |  1 +
>>>>  2 files changed, 55 insertions(+)
>>>>
>>>> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
>>>> index 4c77b65683de..7b19ea6373dd 100644
>>>> --- a/hw/intc/spapr_xive_hcall.c
>>>> +++ b/hw/intc/spapr_xive_hcall.c
>>>> @@ -874,3 +874,57 @@ void spapr_xive_hcall_init(sPAPRMachineState *s=
papr)
>>>>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>>>>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>>>>  }
>>>> +
>>>> +void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phand=
le)
>>>> +{
>>>> +    int node;
>>>> +    uint64_t timas[2 * 2];
>>>> +    uint32_t lisn_ranges[] =3D {
>>>> +        cpu_to_be32(xive->nr_irqs - xive->nr_targets + xive->ics->o=
ffset),
>>>> +        cpu_to_be32(xive->nr_targets),
>>>> +    };
>>>> +    uint32_t eq_sizes[] =3D {
>>>> +        cpu_to_be32(12), /* 4K */
>>>> +        cpu_to_be32(16), /* 64K */
>>>> +        cpu_to_be32(21), /* 2M */
>>>> +        cpu_to_be32(24), /* 16M */
>>>> +    };
>>>> +
>>>> +    /* Use some ranges to exercise the Linux driver, which should
>>>> +     * result in Linux choosing priority 6. This is not strictly
>>>> +     * necessary
>>>> +     */
>>>> +    uint32_t reserved_priorities[] =3D {
>>>> +        cpu_to_be32(1),  /* start */
>>>> +        cpu_to_be32(2),  /* count */
>>>> +        cpu_to_be32(7),  /* start */
>>>> +        cpu_to_be32(0xf8),  /* count */
>>>> +    };
>>>> +    int i;
>>>> +
>>>> +    /* Thread Interrupt Management Areas : User and OS */
>>>> +    for (i =3D 0; i < 2; i++) {
>>>> +        timas[i * 2] =3D cpu_to_be64(xive->tm_base + i * (1 << xive=
->tm_shift));
>>>> +        timas[i * 2 + 1] =3D cpu_to_be64(1 << xive->tm_shift);
>>>> +    }
>>>> +
>>>> +    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
>>>> +
>>>> +    _FDT(fdt_setprop_string(fdt, node, "name", "interrupt-controlle=
r"));
>>>
>>> Shouldn't need this - SLOF will figure it out from the node name abov=
e.
>>
>> It is in the specs. phyp has it. we might as well keep it.
>=20
> You misunderstand.  SLOF will *create* the name property based on the
> node name.  Adding it here has *no effect*.

ok. I was not ware of that. I will remove it then.
=20
>>>> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe")=
);
>>>> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
>>>> +
>>>> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivp=
e"));
>>>> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
>>>> +                     sizeof(eq_sizes)));
>>>> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges=
,
>>>> +                     sizeof(lisn_ranges)));
>>>
>>> I note this doesn't have the interrupt-controller or #interrupt-cells
>>> properties.  So what acts as the interrupt parent for all the devices
>>> in the tree with XIVE?
>>
>> these properties are not in the specs anymore for the interrupt-contro=
ller
>> node and I don't think Linux makes use of them (even for XICS). So=20
>> it just works fine.
>=20
> Um.. what!?  Are you saying that the PAPR XIVE spec completely broke
> how interrupt specifiers have worked in the device tree since forever?

Let me be more precise. I am saying that the interrupt-controller=20
and #interrupt-cells properties are not needed under the main interrupt=20
controller node. They can be removed from the tree and the Linux guest=20
kernel will boot perfectly well.
 =20
These properties still are needed under the sub nodes like :

/proc/device-tree/vdevice/interrupt-controller
/proc/device-tree/event-sources/interrupt-controller

C.


> And I'm pretty sure Linux does make use of them.  Without
> #interrupt-cells, there's no way it can properly interpret the
> interrupts properties in the device nodes.
>=20
