Received: from eggs.gnu.org ([2001:4830:134:3::10]:40861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dkc4r-0001Sq-VF
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dkc4o-0002Mq-Q6
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dkc4o-0002LD-Gy
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:16:34 -0400
References: <1503506783.3438.19.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ddb6f49e-6617-a659-08bf-cf093f658a8c@redhat.com>
Date: Wed, 23 Aug 2017 23:16:27 +0300
MIME-Version: 1.0
In-Reply-To: <1503506783.3438.19.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Number of usable slots in PCIe Root Port / PCIe
 Switch Downstream Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <mapfelba@redhat.com>, laine@laine.org, Lukas Doktor <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 23/08/2017 19:46, Andrea Bolognani wrote:
> AFAIK some PCI controllers, particularly:
>=20
>    * PCIe Root Port (pcie-root-port, ioh3420)
>    * PCIe Switch Downstream Port (xio3130-downstream)
>=20
> only have a single usable slot. libvirt knows about this
> fact, and will prevent you from adding more than one
> device to the respective bus.
>=20
> However, as Luk=C3=A1=C5=A1 recently noticed, QEMU won't complain
> if you add more devices:
>=20
>    $ qemu-system-x86_64 \
>      -nodefaults -nographic \
>      -M q35 -monitor stdio \
>      -device pcie-root-port,id=3Dpci.1 \
>      -device virtio-scsi-pci,bus=3Dpci.1 \
>      -device virtio-scsi-pci,bus=3Dpci.1
>    QEMU 2.9.0 monitor - type 'help' for more information
>    (qemu) info qtree
>    bus: main-system-bus
>      type System
>      [...]
>      dev: q35-pcihost, id ""
>        [...]
>        bus: pcie.0
>          type PCIE
>          dev: pcie-root-port, id "pci.1"
>            [...]
>            bus: pci.1
>              type PCIE
>              dev: virtio-scsi-pci, id ""
>                [...]
>                addr =3D 01.0
>                bus: virtio-bus
>                  type virtio-pci-bus
>                  dev: virtio-scsi-device, id ""
>                    [...]
>                    bus: scsi.1
>                      type SCSI
>              dev: virtio-scsi-pci, id ""
>                [...]
>                addr =3D 00.0
>                bus: virtio-bus
>                  type virtio-pci-bus
>                  dev: virtio-scsi-device, id ""
>                    [...]
>                    bus: scsi.0
>                      type SCSI
>    (qemu)
>=20

Hi Andrea,

> As you can see, all devices will show up in the qtree;
> only the one with addr=3D00.0, however, will actually be
> visible to the guest OS according to my tests.
>=20
> Is such a configuration considered valid?=20

Definitely no.

>Should QEMU
> complain loudly about it and refuse to start?=20

Yes, but we need a clean way to do it. Eduardo is working
on a series that would expose to libvirt this info,
Eduardo can you please confirm?

Or should
> libvirt and the guest OS / firmware start allowing it?
>=20

I thought libvirt does not allow it anyway and yes, is a bug,
but considered low priority.
I personally hoped Eduardo's work can also help in this direction
(classifying PCI Buses, we can add a 'rule' to allow only one
PCIe device per bus.)

But maybe a simple patch preventing QEMU to start would be enough.

Thanks for bringing the issue to my attention,
Marcel
