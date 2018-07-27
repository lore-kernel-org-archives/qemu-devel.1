Received: from eggs.gnu.org ([2001:4830:134:3::10]:50519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiyuP-0000fb-Q8
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiyuM-000720-Kc
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:19:37 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:36303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fiyuM-0006xM-EN
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:19:34 -0400
Received: from player687.ha.ovh.net (unknown [10.109.143.232])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8D74719204D
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 11:19:25 +0200 (CEST)
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<f6500bf1-792b-aba5-9deb-adc3303eeee7@kaod.org>
	<20180727053247.GK3694@umbus.fritz.box>
	<e642d9da57a167aeb5ae65566dd61317fcd37d2c.camel@kernel.crashing.org>
	<d743b921-d1bc-2bc8-cbad-cd1a90d33850@kaod.org>
	<7a9314f5f53d59f4116fbd5ff1a45226ff16a257.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5751e644-8f95-c5dd-3fd9-8e5a813bb460@kaod.org>
Date: Fri, 27 Jul 2018 11:19:15 +0200
MIME-Version: 1.0
In-Reply-To: <7a9314f5f53d59f4116fbd5ff1a45226ff16a257.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 07/27/2018 10:43 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2018-07-27 at 10:25 +0200, C=C3=A9dric Le Goater wrote:
>> Each PHB creates a pci-bridge device and the PCI bus that comes with i=
t.=20
>> It makes things easier to define PCI devices.=20
>>
>> It is still quite complex ... Here is a sample :
>>
>> qemu-system-ppc64 -m 2G -machine powernv \
>>   -cpu POWER8 -smp 2,cores=3D2,threads=3D1 -accel tcg,thread=3Dmulti \
>>   -kernel ./zImage.epapr -initrd ./rootfs.cpio.xz -bios ./skiboot.lid =
\
>>   \
>>   -device megasas,id=3Dscsi0,bus=3Dpci.0,addr=3D0x1 \
>>   -drive file=3D./rhel7-ppc64le.qcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0=
,format=3Dqcow2,cache=3Dnone \
>>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3D=
drive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2 \
>>   \
>>   -device ich9-ahci,id=3Dsata0,bus=3Dpci.1,addr=3D0x1 \
>>   -drive file=3D./ubuntu-ppc64le.qcow2,if=3Dnone,id=3Ddrive0,format=3D=
qcow2,cache=3Dnone \
>>   -device ide-hd,bus=3Dsata0.0,unit=3D0,drive=3Ddrive0,id=3Dide,bootin=
dex=3D1 \
>>   -device e1000,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpci.1,addr=
=3D0x2 \
>>   -netdev bridge,helper=3D/usr/libexec/qemu-bridge-helper,br=3Dvirbr0,=
id=3Dnet0 \
>>   -device nec-usb-xhci,bus=3Dpci.1,addr=3D0x7 \
>=20
> I don't understand why. That means you can't put emulated (or real)
> PCIe device below it ?

Well, skiboot does seem to find them. But that's not a good reason.
I will dig in.

> Why force them down the path of having a bridge to legacy PCI always ?
>
> My original intent was to have one such bridge in a machine for the
> various default PCI devices qemu has that aren't (yet) PCIe (and also
> for testing :-) but I never thought we'd throw one onto every PCIe bus.

OK. Let's get of rid it and let's find why the FW doesn't see the PCIe
devices.

Thanks,

C.
