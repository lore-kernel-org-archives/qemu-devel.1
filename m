Received: from eggs.gnu.org ([2001:4830:134:3::10]:47997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYWbz-0008Qc-7R
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYWbs-000336-Sy
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:05:23 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:54807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fYWbs-000329-Lf
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:05:16 -0400
Received: from player771.ha.ovh.net (unknown [10.109.122.14])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E22A51834FA
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 15:05:13 +0200 (CEST)
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
	<8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
	<20180628035909.GE23134@umbus.fritz.box>
	<b84cc6b91f3af188c3eece0713f849031c5256c8.camel@redhat.com>
	<f1175077-6eab-036f-7aa2-d06f2f4dfa1e@kaod.org>
	<597423567e18da819be8174ff593a2cb4b08517d.camel@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <76f6f78f-421c-1080-40ce-f29c7057208e@kaod.org>
Date: Thu, 28 Jun 2018 15:05:03 +0200
MIME-Version: 1.0
In-Reply-To: <597423567e18da819be8174ff593a2cb4b08517d.camel@redhat.com>
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

On 06/28/2018 01:40 PM, Andrea Bolognani wrote:
> On Thu, 2018-06-28 at 12:04 +0200, C=C3=A9dric Le Goater wrote:
>> On 06/28/2018 10:00 AM, Andrea Bolognani wrote:
>>> On Thu, 2018-06-28 at 13:59 +1000, David Gibson wrote:
>>>> Well.. sure.. but it doesn't.  pSeries is a virtual platform, so we
>>>> have a reasonable amount of flexibility to define it as we want.
>>>> PowerNV is an emulation of existing hardware which has a specific
>>>> behaviour which we need to match.
>>>
>>> Sure, that's something to keep in mind.
>>>
>>> But the thing is, you still need to have *some* flexibility in
>>> the number of PHBs, since there is variation among real Power8
>>> and Power9 chips; in the current incarnation, that flexibility
>>> is provided by the num_phbs parameter, which is an entirely new
>>> interface that's exclusive to PowerNV.
>>>
>>> What I'm suggesting is that the same amount of flexibility is
>>> offered through a standard interface, namely -device, instead.
>>
>> Yes. I don't know to be honest. Adding support for -device is not=20
>> complex.
>>
>> v2 proposes to initialize a fixed set of PHBs 2, 3, 4 depending on=20
>> the CPU. I think this is the best modeling option to fit the HW.
>=20
> That approach would require even more hacks in libvirt if we ever
> wanted to support PowerNV - basing the PCI address allocation on
> the CPU model is not something that's really ever happened before.

It's even more complex than that but let's keep it "simple" and
consider that some CPU flavors can have more or less PHBs.

May be, we could agree on a common number of PHBs per chip which=20
would be statically initialized. *two* PHBs should cover all CPU=20
flavors. Extra PHBs created by the user with -device would be=20
allowed but capped by a per CPU flavor limit. How's that ?=20

C.  =20

>=20
> To make it somewhat reasonable, information about the number of
> PHBs created for each CPU model would have to be exposed through
> QMP. And I wonder what a multi-chip guest would look like...
>=20
> Plus, as soon as you try something like
>=20
>   $ qemu-system-ppc64 \
>     -nodefaults -display none \
>     -machine powernv -cpu POWER8E \
>     -device pci-bridge,id=3Dpci.1,chassis_nr=3D1,bus=3Dpci.0,addr=3D0x1=
 \
>     -device megasas,id=3Dscsi0,bus=3Dpci.1,addr=3D0x1
>=20
> very interesting things will start happening :)
>=20
