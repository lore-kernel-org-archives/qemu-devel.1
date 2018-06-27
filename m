Received: from eggs.gnu.org ([2001:4830:134:3::10]:40365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY9PA-0000wq-7t
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY9P5-00034W-6p
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:18:36 -0400
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:35420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fY9P4-000331-Sj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:18:31 -0400
Received: from player758.ha.ovh.net (unknown [10.109.105.20])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id E2C941BB84F
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 14:18:28 +0200 (CEST)
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
	<8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9704639c-1c76-103a-7a90-6cfbb5aa4968@kaod.org>
Date: Wed, 27 Jun 2018 14:18:14 +0200
MIME-Version: 1.0
In-Reply-To: <8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
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

On 06/27/2018 12:22 PM, Andrea Bolognani wrote:
> On Tue, 2018-06-26 at 19:02 +0200, C=C3=A9dric Le Goater wrote:
>> On 06/26/2018 05:57 PM, Andrea Bolognani wrote:
>>> On Tue, 2018-06-26 at 15:59 +0200, C=C3=A9dric Le Goater wrote:
>>>> This is a model of the PCIe host bridge found on Power8 chips,
>>>> including PowerBus logic interface, IOMMU support, PCIe root complex=
,
>>>> XICS MSI and LSI interrupt sources.
>>>>
>>>> 4 PHBs are provisioned under the Power8 chip model to fit hardware b=
ut
>>>> only one is currently initialized.
>>>
>>> What's the advantage in creating 4 PHBs instead of a single one,
>>
>> The Power8 chip comes in different flavors: Venice, Murano, Naple,=20
>> each having a different number of PHBs. We don't need to initialize=20
>> them all to plug only a couple of devices (net, storage, usbs)=20
>>
>> When time comes, we might want to test some more complex configuration=
s
>> or extend the modeling with CAPI support. That's why we have a :
>>
>> 	#define PNV_MAX_CHIP_PHB 4
>> 	    PnvPHB3      phbs[PNV_MAX_CHIP_PHB];
>>
>> under the chip, and a 'num_phbs' attribute to increase the number
>> of controllers. It still needs to be tested but that's the goal.
>=20
> I was a bit confused about the difference between "provisioning"
> and "initializing" a PHB, I guess.

objects have different states : allocated, initialized, realized
I guess "provision (memory)" is not the best choice for the first
state.

> Now that I've looked at the code, my (very uneducated) reading is
> that you're allocating memory for 4 PHBs along with the chip, but
> only actually initializing num_phbs of them, with 1 being the
> default.

Yes. I had the idea to increase the number of PHBs with a machine
option later on if needed.

> I have no idea what this implies when it comes to adding PCI
> controller to the guest, though. If I run a guest with num_phbs=3D1,
> are ids pci.1..pci.3 reserved even though the corresponding PHBs
> have not been initialized?=20

They don't exist on the PowerNV machine if you don't have a PHB3
device backing them.

> Is num_phbs the only way you can control how many PHBs a PowerNV=20
> guest will have?

yes. Unless we make them user creatable but that's a discussion in
progress. I am not sure user creatable PHB3s are needed. We will
see.
=20
> I would play around and try to figure out all the kinks on my own,
> but I can't actually compile QEMU with this patch applied:

you need to use David's branch :

	https://github.com/dgibson/qemu/tree/ppc-for-3.0


>   hw/pci-host/pnv_phb3_msi.c: In function =E2=80=98phb3_msi_reset=E2=80=
=99:
>   hw/pci-host/pnv_phb3_msi.c:229:11: error: =E2=80=98ICSStateClass=E2=80=
=99 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=
=98parent_reset=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
>        icsc->parent_reset(dev);
>              ^~~~~~~~~~~~
>              parent_class
>   hw/pci-host/pnv_phb3_msi.c: In function =E2=80=98phb3_msi_realize=E2=80=
=99:
>   hw/pci-host/pnv_phb3_msi.c:260:11: error: =E2=80=98ICSStateClass=E2=80=
=99 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=
=98parent_realize=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
>        icsc->parent_realize(dev, &local_err);
>              ^~~~~~~~~~~~~~
>              parent_class
>   hw/pci-host/pnv_phb3_msi.c: In function =E2=80=98phb3_msi_class_init=E2=
=80=99:
>   hw/pci-host/pnv_phb3_msi.c:293:43: error: =E2=80=98ICSStateClass=E2=80=
=99 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=
=98parent_realize=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
>                                        &isc->parent_realize);
>                                              ^~~~~~~~~~~~~~
>                                              parent_class
>   hw/pci-host/pnv_phb3_msi.c:295:41: error: =E2=80=98ICSStateClass=E2=80=
=99 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=
=98parent_reset=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
>                                      &isc->parent_reset);
>                                            ^~~~~~~~~~~~
>                                            parent_class
>=20
>>> like we already do for pSeries guests?=20
>>
>> I didn't follow that discussion but this is "another" kind of PHB.
>> This one models the baremetal controller as found on OpenPOWER and
>> IBM Power machines. pSeries has a virtual PHB.
>=20
> I understand that, and of course libvirt will need to learn about
> this new type of PHB and make sure both pSeries and PowerNV guests
> get the correct one assigned to them.

yes. we don't want to change libvirt too much so this is a requirement=20
to take into account.

> What I meant is that pSeries guests get a single PHB by default,

yes

> with additional ones being instantiable through -device;=20

yes.

> this is
> also consistent with how PCI controllers are added to other guest
> types including pc, q35 and aarch64/virt, so it would be really
> nice if PowerNV behaved the same way.

OK. So that's a +1 in favor of user creatable PHB3s devices=20

>>> As it is, this will confuse the heck out of libvirt's PCI address > a=
llocation algorithm :)
>>
>> The pci bus name should be directly related to the PHB index. But
>> I agree we need to be careful. That's why you are in cc: :)
>=20
> Thanks, I really appreciate you keeping me in the loop :)
>=20

Thanks for the feedback.

C.
