Received: from eggs.gnu.org ([2001:4830:134:3::10]:55439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKRLF-0002h7-5A
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKRL9-0005bD-1q
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:05:37 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:55538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKRL8-0005Ze-7q
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:05:30 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3923B125D6B
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 17:05:28 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
	<e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
	<20171129045941.GH3023@umbus.fritz.box>
	<512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
	<c620afca-f6df-b3ed-8317-c805ec66b31b@kaod.org>
	<20171130042857.GA3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <08e720c1-a5df-8322-38bb-efd1422a5af0@kaod.org>
Date: Thu, 30 Nov 2017 16:05:22 +0000
MIME-Version: 1.0
In-Reply-To: <20171130042857.GA3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/25] spapr: add MMIO handlers for the
 XIVE interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "list@suse.de:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/30/2017 04:28 AM, David Gibson wrote:
> On Wed, Nov 29, 2017 at 05:23:25PM +0100, C=E9dric Le Goater wrote:
>> On 11/29/2017 02:56 PM, C=E9dric Le Goater wrote:
>>>>>>> +    switch (offset) {
>>>>>>> +    case 0:
>>>>>>> +        spapr_xive_source_eoi(xive, lisn);
>>>>>>
>>>>>> Hrm.  I don't love that you're dealing with clearing that LSI bit
>>>>>> here, but setting it at a different level.
>>>>>>
>>>>>> The state machines are doing my head in a bit, is there any way
>>>>>> you could derive the STATUS_SENT bit from the PQ bits?
>>>>>
>>>>> Yes. I should.=20
>>>>>
>>>>> I am also lacking a guest driver to exercise these LSIs so I didn't
>>>>> pay a lot of attention to level interrupts. Any idea ?
>>>>
>>>> How about an old-school emulated PCI device?  Maybe rtl8139?
>>>
>>> Perfect. The current model is working but I will see how I can=20
>>> improve it to use the PQ bits instead.
>>
>> Using the PQ bits is simplifying the model but we still have to=20
>> maintain an array to store the IRQ type.=20
>>
>> There are 3 unused bits in the IVE descriptor, bits[1-3]: =20
>>
>>   #define IVE_VALID       PPC_BIT(0)
>>   #define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ b=
lock# */
>>   #define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ i=
ndex */
>>   #define IVE_MASKED      PPC_BIT(32)              /* Masked */
>>   #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to =
the EQ */
>>
>> We could hijack one of them to store the LSI type and get rid of=20
>> the type array. Would you object to that ?
>=20
> Hrm.  These IVE bits are architected, aren't they? =20

Yes and unused.

> In which case I'd
> be wary of stealing a reserved bit in case of future extensions.
>=20
> I'm wondering if we want another word / structure for storing
> non-architected, implementation specific flags or info.

That's what is done with the status array. As migration will put=20
pressure on future changes, may be, we should go for an extra=20
word for these model non-architected needs.
=20
> How does this work at the hardware level?  Presumbly the actual
> hardware components don't communicate with the XIVE to request edge or
> level. =20

No.

> So how does it know?  Specific ranges for LSIs?=20
=20
When OPAL allocates interrupt numbers for a device, it records=20
their type to handle the EOI a little differently for LSIs.=20
For sPAPR, it is really the same, the hcall H_INT_GET_SOURCE_INFO=20
gives the interrupt type to the guest and the EOI is handled=20
with a specific load. A part from that, the LSI interrupts follow=20
the same path as the MSI.
=20
The device controller must have some extra logic to handle the=20
level for these interrupts but I am no expert in the domain.=20

> If that we should probably do the same.

Modeling the LSI level with the PQ bits looks fine. We just need=20
to store the IRQ type information somewhere under the XIVE object.=20
We can keep it in a byte array or a bitmap to reduce the size.=20
But if we foresee additional state to store, we might want to use=20
the byte array directly.

Thanks,

C.
=20
