Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY8zP-0002Hp-Dw
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY8zM-00020V-CE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:51:59 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:58143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fY8zM-0001nS-4G
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:51:56 -0400
Received: from player789.ha.ovh.net (unknown [10.109.120.90])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 991A4D4474
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:51:45 +0200 (CEST)
References: <20180626135928.23950-1-clg@kaod.org>
	<20180627033321-mutt-send-email-mst@kernel.org>
	<1d70c0f9179990cd33d7c82c5190179e60ae4ce3.camel@kernel.crashing.org>
	<20180627072825.GH14434@umbus.fritz.box>
	<65c545f3-6279-62af-9bd8-2be93a3d7d18@kaod.org>
	<9f9a4454bec8e7009a02d544d7a98f6215bd1fa0.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <59b83c9b-6afd-9b37-9dc0-375835f54650@kaod.org>
Date: Wed, 27 Jun 2018 13:51:35 +0200
MIME-Version: 1.0
In-Reply-To: <9f9a4454bec8e7009a02d544d7a98f6215bd1fa0.camel@kernel.crashing.org>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>

On 06/27/2018 10:41 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2018-06-27 at 09:46 +0200, C=C3=A9dric Le Goater wrote:
>> So the "IBM PHB3 PCIE Root Port" is already user createable.
>>
>> I can take a look at user createable PHB3s. I think this is OK from a =
model
>> perspective. The object is rather standalone, it needs the machine for=
=20
>> the XICS fabric and a couple of ids, phb id and chip id. These can com=
e
>> from the command line.
>>
>> We want at least one PHB3 per socket/chip though.=20
>=20
> We don't want the user to specify the SCOM addresses though

We don't need to.

>  (for the MMIO windows we should get skiboot to assign them).

yes. That's a small fix yet to be done. It can come later.

> If the user gets to specify a thing it would be which of the 3 or 4 HW
> PHBs of the chip it is, the SCOM addresses gets deduced.


So I modified a bit the model to support user creatable PHB3 devices and
could start a QEMU powernv machine with these options :
 =20
Raid controller on PHB0 :

  -device megasas,id=3Dscsi0,bus=3Dpci.0,addr=3D0x1
  -drive file=3D$file,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,cac=
he=3Dnone
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Dd=
rive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1

Ethernet controller on PHB0 :

  -device e1000,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpci.0,addr=3D=
0x2
  -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3D=
virbr0,id=3Dnet0

USB controller on PHB0 :

  -device nec-usb-xhci,bus=3Dpci.0,addr=3D0x7

Extra PHB1 on chip 0 :

  -device pnv-phb3,chip-id=3D0,phb-id=3D1,id=3Dphb0.1

USB controller on PHB1 :

  -device nec-usb-xhci,bus=3Dpci.1,addr=3D0x7=20

Most of the code changes are fine and even fix a few problems. =20

But, user created PHB3 devices are not parented to the PnvChip and=20
this means that we need to :=20

 1 - scan the full object hierarchy to populate the device tree=20
 2 - look for the owning chip in the PHP3 realize routine=20
 3 - grab the pnv machine to get the XICS fabric

2 & 3 are somewhat violation of the QOM models but we can live with=20
that. 1 is annoying. I think.

So may be we should forget about the -device possibility and use fixed
values for the number of PHBs. The value would depend on the chip flavor.
=20

Cheers,

C.=20
