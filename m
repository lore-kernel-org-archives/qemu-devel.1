Received: from eggs.gnu.org ([2001:4830:134:3::10]:44260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eK597-0004GG-3M
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eK593-0003fF-Rj
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:37 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:42873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eK593-0003ef-La
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:33 -0500
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 99A96CBD21
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 17:23:31 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
	<e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
	<20171129045941.GH3023@umbus.fritz.box>
	<512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c620afca-f6df-b3ed-8317-c805ec66b31b@kaod.org>
Date: Wed, 29 Nov 2017 17:23:25 +0100
MIME-Version: 1.0
In-Reply-To: <512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
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

On 11/29/2017 02:56 PM, C=E9dric Le Goater wrote:
>>>>> +    switch (offset) {
>>>>> +    case 0:
>>>>> +        spapr_xive_source_eoi(xive, lisn);
>>>>
>>>> Hrm.  I don't love that you're dealing with clearing that LSI bit
>>>> here, but setting it at a different level.
>>>>
>>>> The state machines are doing my head in a bit, is there any way
>>>> you could derive the STATUS_SENT bit from the PQ bits?
>>>
>>> Yes. I should.=20
>>>
>>> I am also lacking a guest driver to exercise these LSIs so I didn't
>>> pay a lot of attention to level interrupts. Any idea ?
>>
>> How about an old-school emulated PCI device?  Maybe rtl8139?
>=20
> Perfect. The current model is working but I will see how I can=20
> improve it to use the PQ bits instead.

Using the PQ bits is simplifying the model but we still have to=20
maintain an array to store the IRQ type.=20

There are 3 unused bits in the IVE descriptor, bits[1-3]: =20

  #define IVE_VALID       PPC_BIT(0)
  #define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ bloc=
k# */
  #define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ inde=
x */
  #define IVE_MASKED      PPC_BIT(32)              /* Masked */
  #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the=
 EQ */

We could hijack one of them to store the LSI type and get rid of=20
the type array. Would you object to that ?=20

C.
