Received: from eggs.gnu.org ([2001:4830:134:3::10]:36911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYVur-0005xq-1V
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fYVun-0001nC-2V
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:20:49 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:46065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fYVum-0001l6-SG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:20:44 -0400
Received: from player771.ha.ovh.net (unknown [10.109.105.86])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 26A04187324
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:20:42 +0200 (CEST)
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
	<8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
	<20180628035909.GE23134@umbus.fritz.box>
	<b84cc6b91f3af188c3eece0713f849031c5256c8.camel@redhat.com>
	<f1175077-6eab-036f-7aa2-d06f2f4dfa1e@kaod.org>
	<597423567e18da819be8174ff593a2cb4b08517d.camel@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7391363f-ae0a-7f6c-83df-c411a873352a@kaod.org>
Date: Thu, 28 Jun 2018 14:20:29 +0200
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

ah. hmm, so that's another +1 for the -device approach.

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

Well it boots :)


/ # lspci=20
0000:00:00.0 PCI bridge: IBM POWER8 Host Bridge (PHB3)
0000:01:00.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
0000:02:01.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
0000:02:02.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ether=
net Controller (rev 03)
0000:02:07.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Contr=
oller (rev 03)
0001:00:00.0 PCI bridge: IBM POWER8 Host Bridge (PHB3)
0001:01:00.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
0001:02:01.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID SAS =
1078


C.
