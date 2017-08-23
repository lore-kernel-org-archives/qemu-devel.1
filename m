Received: from eggs.gnu.org ([2001:4830:134:3::10]:60434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkdzc-0000O6-7Q
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkdzb-00063i-7H
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:19:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkdza-000637-TX
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:19:19 -0400
Date: Wed, 23 Aug 2017 19:19:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823221914.GA15315@localhost.localdomain>
References: <1503506783.3438.19.camel@redhat.com>
	<ddb6f49e-6617-a659-08bf-cf093f658a8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddb6f49e-6617-a659-08bf-cf093f658a8c@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <mapfelba@redhat.com>, laine@laine.org, Lukas Doktor <ldoktor@redhat.com>

On Wed, Aug 23, 2017 at 11:16:27PM +0300, Marcel Apfelbaum wrote:
> On 23/08/2017 19:46, Andrea Bolognani wrote:
> > AFAIK some PCI controllers, particularly:
> >=20
> >    * PCIe Root Port (pcie-root-port, ioh3420)
> >    * PCIe Switch Downstream Port (xio3130-downstream)
> >=20
> > only have a single usable slot. libvirt knows about this
> > fact, and will prevent you from adding more than one
> > device to the respective bus.
> >=20
> > However, as Luk=C3=A1=C5=A1 recently noticed, QEMU won't complain
> > if you add more devices:
> >=20
> >    $ qemu-system-x86_64 \
> >      -nodefaults -nographic \
> >      -M q35 -monitor stdio \
> >      -device pcie-root-port,id=3Dpci.1 \
> >      -device virtio-scsi-pci,bus=3Dpci.1 \
> >      -device virtio-scsi-pci,bus=3Dpci.1
> >    QEMU 2.9.0 monitor - type 'help' for more information
> >    (qemu) info qtree
> >    bus: main-system-bus
> >      type System
> >      [...]
> >      dev: q35-pcihost, id ""
> >        [...]
> >        bus: pcie.0
> >          type PCIE
> >          dev: pcie-root-port, id "pci.1"
> >            [...]
> >            bus: pci.1
> >              type PCIE
> >              dev: virtio-scsi-pci, id ""
> >                [...]
> >                addr =3D 01.0
> >                bus: virtio-bus
> >                  type virtio-pci-bus
> >                  dev: virtio-scsi-device, id ""
> >                    [...]
> >                    bus: scsi.1
> >                      type SCSI
> >              dev: virtio-scsi-pci, id ""
> >                [...]
> >                addr =3D 00.0
> >                bus: virtio-bus
> >                  type virtio-pci-bus
> >                  dev: virtio-scsi-device, id ""
> >                    [...]
> >                    bus: scsi.0
> >                      type SCSI
> >    (qemu)
> >=20
>=20
> Hi Andrea,
>=20
> > As you can see, all devices will show up in the qtree;
> > only the one with addr=3D00.0, however, will actually be
> > visible to the guest OS according to my tests.
> >=20
> > Is such a configuration considered valid?
>=20
> Definitely no.
>=20
> > Should QEMU
> > complain loudly about it and refuse to start?
>=20
> Yes, but we need a clean way to do it. Eduardo is working
> on a series that would expose to libvirt this info,
> Eduardo can you please confirm?

The work has two parts: 1) actually preventing invalid
configurations; 2) providing a query interface to let libvirt
know which configurations are valid.

My focus is on (2) (adding a query-device-slots interface), but
we surely need to address bugs related to (1) first, so both the
device-plugging code and slot-querying code are correct and agree
with each other.

--=20
Eduardo
