Received: from eggs.gnu.org ([2001:4830:134:3::10]:42566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYGQO-0003tD-5L
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYGQL-0005QG-2e
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:48:20 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:43978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fYGQK-0005PI-SN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:48:17 -0400
Received: from player759.ha.ovh.net (unknown [10.109.122.47])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1F4D3E898E
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 21:48:14 +0200 (CEST)
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
	<8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
	<9704639c-1c76-103a-7a90-6cfbb5aa4968@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <79161afb-96ae-0dd7-5f1e-fc4410950789@kaod.org>
Date: Wed, 27 Jun 2018 21:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <9704639c-1c76-103a-7a90-6cfbb5aa4968@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 06/27/2018 02:18 PM, C=C3=A9dric Le Goater wrote:
> On 06/27/2018 12:22 PM, Andrea Bolognani wrote:
>> On Tue, 2018-06-26 at 19:02 +0200, C=C3=A9dric Le Goater wrote:
>>> On 06/26/2018 05:57 PM, Andrea Bolognani wrote:
>>>> On Tue, 2018-06-26 at 15:59 +0200, C=C3=A9dric Le Goater wrote:
>>>>> This is a model of the PCIe host bridge found on Power8 chips,
>>>>> including PowerBus logic interface, IOMMU support, PCIe root comple=
x,
>>>>> XICS MSI and LSI interrupt sources.
>>>>>
>>>>> 4 PHBs are provisioned under the Power8 chip model to fit hardware =
but
>>>>> only one is currently initialized.
>>>>
>>>> What's the advantage in creating 4 PHBs instead of a single one,
>>>
>>> The Power8 chip comes in different flavors: Venice, Murano, Naple,=20
>>> each having a different number of PHBs. We don't need to initialize=20
>>> them all to plug only a couple of devices (net, storage, usbs)=20
>>>
>>> When time comes, we might want to test some more complex configuratio=
ns
>>> or extend the modeling with CAPI support. That's why we have a :
>>>
>>> 	#define PNV_MAX_CHIP_PHB 4
>>> 	    PnvPHB3      phbs[PNV_MAX_CHIP_PHB];
>>>
>>> under the chip, and a 'num_phbs' attribute to increase the number
>>> of controllers. It still needs to be tested but that's the goal.
>>
>> I was a bit confused about the difference between "provisioning"
>> and "initializing" a PHB, I guess.
>=20
> objects have different states : allocated, initialized, realized
> I guess "provision (memory)" is not the best choice for the first
> state.
>=20
>> Now that I've looked at the code, my (very uneducated) reading is
>> that you're allocating memory for 4 PHBs along with the chip, but
>> only actually initializing num_phbs of them, with 1 being the
>> default.
>=20
> Yes. I had the idea to increase the number of PHBs with a machine
> option later on if needed.
>=20
>> I have no idea what this implies when it comes to adding PCI
>> controller to the guest, though. If I run a guest with num_phbs=3D1,
>> are ids pci.1..pci.3 reserved even though the corresponding PHBs
>> have not been initialized?=20
>=20
> They don't exist on the PowerNV machine if you don't have a PHB3
> device backing them.
>=20
>> Is num_phbs the only way you can control how many PHBs a PowerNV=20
>> guest will have?
>=20
> yes. Unless we make them user creatable but that's a discussion in
> progress. I am not sure user creatable PHB3s are needed. We will
> see.
> =20
>> I would play around and try to figure out all the kinks on my own,
>> but I can't actually compile QEMU with this patch applied:
>=20
> you need to use David's branch :
>=20
> 	https://github.com/dgibson/qemu/tree/ppc-for-3.0

I have pushed a tree here :

	https://github.com/legoater/qemu/tree/phb3-3.0

with two patches, the one we have been discussing about, with some
cleanups and fixes, and one adding user creatable PHB3 devices so=20
that extra phbs and devices can be defined on the command line :

-device pnv-phb3,chip-id=3D1,index=3D1,id=3Dphb-1.1 -device nec-usb-xhci,=
bus=3Dpci.1,addr=3D0x7

The PHB identifier is named 'index' now, to be compatible with the=20
libvirt attribute.=20

Cheers,

C.=20
