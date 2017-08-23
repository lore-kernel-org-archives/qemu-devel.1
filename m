Received: from eggs.gnu.org ([2001:4830:134:3::10]:51623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dkYnY-00049R-4k
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dkYnU-0002n7-7q
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:46:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1dkYnU-0002kx-1B
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:46:28 -0400
Message-ID: <1503506783.3438.19.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 23 Aug 2017 18:46:23 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Number of usable slots in PCIe Root Port / PCIe Switch
 Downstream Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <mapfelba@redhat.com>, laine@laine.org, Lukas Doktor <ldoktor@redhat.com>

AFAIK some PCI controllers, particularly:

  * PCIe Root Port (pcie-root-port, ioh3420)
  * PCIe Switch Downstream Port (xio3130-downstream)

only have a single usable slot. libvirt knows about this
fact, and will prevent you from adding more than one
device to the respective bus.

However, as Luk=C3=A1=C5=A1 recently noticed, QEMU won't complain
if you add more devices:

  $ qemu-system-x86_64 \
    -nodefaults -nographic \
    -M q35 -monitor stdio \
    -device pcie-root-port,id=3Dpci.1 \
    -device virtio-scsi-pci,bus=3Dpci.1 \
    -device virtio-scsi-pci,bus=3Dpci.1
  QEMU 2.9.0 monitor - type 'help' for more information
  (qemu) info qtree
  bus: main-system-bus
    type System
    [...]
    dev: q35-pcihost, id ""
      [...]
      bus: pcie.0
        type PCIE
        dev: pcie-root-port, id "pci.1"
          [...]
          bus: pci.1
            type PCIE
            dev: virtio-scsi-pci, id ""
              [...]
              addr =3D 01.0
              bus: virtio-bus
                type virtio-pci-bus
                dev: virtio-scsi-device, id ""
                  [...]
                  bus: scsi.1
                    type SCSI
            dev: virtio-scsi-pci, id ""
              [...]
              addr =3D 00.0
              bus: virtio-bus
                type virtio-pci-bus
                dev: virtio-scsi-device, id ""
                  [...]
                  bus: scsi.0
                    type SCSI
  (qemu)

As you can see, all devices will show up in the qtree;
only the one with addr=3D00.0, however, will actually be
visible to the guest OS according to my tests.

Is such a configuration considered valid? Should QEMU
complain loudly about it and refuse to start? Or should
libvirt and the guest OS / firmware start allowing it?

--=20
Andrea Bolognani / Red Hat / Virtualization
