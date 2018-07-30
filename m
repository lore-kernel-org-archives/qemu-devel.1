Received: from eggs.gnu.org ([2001:4830:134:3::10]:44031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk3yw-0005i6-UP
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk3yt-0006Mi-4U
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:56:47 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:59555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fk3ys-0006JQ-T1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:56:43 -0400
Received: from player773.ha.ovh.net (unknown [10.109.143.249])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6FA6AE8CC7
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:56:33 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<f6500bf1-792b-aba5-9deb-adc3303eeee7@kaod.org>
	<20180727053247.GK3694@umbus.fritz.box>
	<e642d9da57a167aeb5ae65566dd61317fcd37d2c.camel@kernel.crashing.org>
	<d743b921-d1bc-2bc8-cbad-cd1a90d33850@kaod.org>
	<7a9314f5f53d59f4116fbd5ff1a45226ff16a257.camel@kernel.crashing.org>
	<5751e644-8f95-c5dd-3fd9-8e5a813bb460@kaod.org>
Message-ID: <11f1017a-f670-c9ee-67cb-b59121f94dce@kaod.org>
Date: Mon, 30 Jul 2018 10:56:22 +0200
MIME-Version: 1.0
In-Reply-To: <5751e644-8f95-c5dd-3fd9-8e5a813bb460@kaod.org>
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

On 07/27/2018 11:19 AM, C=C3=A9dric Le Goater wrote:
> On 07/27/2018 10:43 AM, Benjamin Herrenschmidt wrote:
>> On Fri, 2018-07-27 at 10:25 +0200, C=C3=A9dric Le Goater wrote:
>>> Each PHB creates a pci-bridge device and the PCI bus that comes with =
it.=20
>>> It makes things easier to define PCI devices.=20
>>>
>>> It is still quite complex ... Here is a sample :
>>>
>>> qemu-system-ppc64 -m 2G -machine powernv \
>>>   -cpu POWER8 -smp 2,cores=3D2,threads=3D1 -accel tcg,thread=3Dmulti =
\
>>>   -kernel ./zImage.epapr -initrd ./rootfs.cpio.xz -bios ./skiboot.lid=
 \
>>>   \
>>>   -device megasas,id=3Dscsi0,bus=3Dpci.0,addr=3D0x1 \
>>>   -drive file=3D./rhel7-ppc64le.qcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-=
0,format=3Dqcow2,cache=3Dnone \
>>>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2 \
>>>   \
>>>   -device ich9-ahci,id=3Dsata0,bus=3Dpci.1,addr=3D0x1 \
>>>   -drive file=3D./ubuntu-ppc64le.qcow2,if=3Dnone,id=3Ddrive0,format=3D=
qcow2,cache=3Dnone \
>>>   -device ide-hd,bus=3Dsata0.0,unit=3D0,drive=3Ddrive0,id=3Dide,booti=
ndex=3D1 \
>>>   -device e1000,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpci.1,add=
r=3D0x2 \
>>>   -netdev bridge,helper=3D/usr/libexec/qemu-bridge-helper,br=3Dvirbr0=
,id=3Dnet0 \
>>>   -device nec-usb-xhci,bus=3Dpci.1,addr=3D0x7 \
>>
>> I don't understand why. That means you can't put emulated (or real)
>> PCIe device below it ?
>=20
> Well, skiboot does seem to find them. But that's not a good reason.
> I will dig in.

Nothing is wrong in skiboot, that was my misunderstanding of the overall=20
device layout.

Each PHB3 device exposes a single PCIE root port on which a *single* devi=
ce=20
can be plugged. It can be a any adapter or a bridge/switch. The QEMU devi=
ce=20
hierarchy is rather deep if you want to have multiple devices on a single=
=20
PHB3 :

dev: pnv-phb3
  bus: phb3-root-bus
    dev: phb3-root-port
      bus: pcie=20
         dev: pcie-bridge (only one device allowed)=20
            bus: pcie=20
               dev: e1000e
               dev: ...


So it makes the command line rather heavy :/ or you need to have=20
more phb3s to define an adapter on each. How about 3 per chip ?


Here is a quick survey,

On OpenPower systems:=20

  palmetto:  3 PHBs - one 16x, one 8x, one 4x backed by a switch
             with the BMC devices=20

  habanero:  3 PHBs - one 16x, one 8x, one 8x backed by a switch=20
             with the BMC devices=20

  firestone: socket 0 : 2 16x PHBs
             socket 1 : 3 PHBs - one 16x, one 8x, one 8x backed =20
                        by a switch with the BMC devices =20

  garrison:  socket 0 : 1 16x PHB, 2 8x PHB linked to the GPUs, 1 8x PHB,=
=20
             socket 1 : 1 16x PHB, 2 8x PHB linked to the GPUs, 1 8x PHB
	                backed by a switch with the BMC devices =20


On IBM systems :

  tuletas:   2 16x PHB, 2 8x PHB, backed with a switch.=20
 =20

Thanks,

C.=20
