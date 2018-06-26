Received: from eggs.gnu.org ([2001:4830:134:3::10]:53290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXrMi-0006bG-CH
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXrMd-000127-GE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:02:52 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:57021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXrMd-00011f-9B
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:02:47 -0400
Received: from player746.ha.ovh.net (unknown [10.109.122.86])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id A8A3B1C635
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 19:02:45 +0200 (CEST)
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
Date: Tue, 26 Jun 2018 19:02:30 +0200
MIME-Version: 1.0
In-Reply-To: <7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
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

On 06/26/2018 05:57 PM, Andrea Bolognani wrote:
> On Tue, 2018-06-26 at 15:59 +0200, C=C3=A9dric Le Goater wrote:
>> This is a model of the PCIe host bridge found on Power8 chips,
>> including PowerBus logic interface, IOMMU support, PCIe root complex,
>> XICS MSI and LSI interrupt sources.
>>
>> 4 PHBs are provisioned under the Power8 chip model to fit hardware but
>> only one is currently initialized.
>=20
> What's the advantage in creating 4 PHBs instead of a single one,

The Power8 chip comes in different flavors: Venice, Murano, Naple,=20
each having a different number of PHBs. We don't need to initialize=20
them all to plug only a couple of devices (net, storage, usbs)=20

When time comes, we might want to test some more complex configurations
or extend the modeling with CAPI support. That's why we have a :

	#define PNV_MAX_CHIP_PHB 4
	    PnvPHB3      phbs[PNV_MAX_CHIP_PHB];

under the chip, and a 'num_phbs' attribute to increase the number
of controllers. It still needs to be tested but that's the goal.

> like we already do for pSeries guests?=20

I didn't follow that discussion but this is "another" kind of PHB.
This one models the baremetal controller as found on OpenPOWER and
IBM Power machines. pSeries has a virtual PHB. =20

> As it is, this will confuse the heck out of libvirt's PCI address > all=
ocation algorithm :)

The pci bus name should be directly related to the PHB index. But
I agree we need to be careful. That's why you are in cc: :)

Thanks,

C. =20
