Received: from eggs.gnu.org ([2001:4830:134:3::10]:54007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZ6-0005vx-4F
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZ2-00084K-0v
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZ1-000835-Rq
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:08:55 -0500
Date: Thu, 8 Feb 2018 21:08:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
 fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c=
96:

  Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' i=
nto staging (2018-02-08 14:31:51 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to f4ac9b2e04e8d98854a97bc473353207765aa9e7:

  virtio-balloon: include statistics of disk/file caches (2018-02-08 21:0=
6:42 +0200)

----------------------------------------------------------------
virtio,vhost,pci,pc: features, fixes and cleanups

- a new vhost crypto device
- new stats in virtio balloon
- virtio eventfd rework for boot speedup
- vhost memory rework for boot speedup
- fixes and cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (1):
      virtio-blk: enable multiple vectors when using multiple I/O queues

Dr. David Alan Gilbert (7):
      vhost: Build temporary section list and deref after commit
      vhost: Simplify ring verification checks
      vhost: Merge sections added to temporary list
      vhost: Regenerate region list from changed sections list
      vhost: Clean out old vhost_set_memory and friends
      vhost: Merge and delete unused callbacks
      vhost: Move log_dirty check

Gal Hammer (2):
      virtio: remove event notifier cleanup call on de-assign
      virtio: improve virtio devices initialization time

Gonglei (4):
      cryptodev: add vhost-user as a new cryptodev backend
      cryptodev: add vhost support
      cryptodev-vhost-user: add crypto session handler
      cryptodev-vhost-user: set the key length

Igor Mammedov (1):
      tests: acpi: fix FADT not being compared to reference table

Laszlo Ersek (1):
      pci-bridge/i82801b11: clear bridge registers on platform reset

Marcel Apfelbaum (1):
      hw/pci-bridge: fix pcie root port's IO hints capability

Michael S. Tsirkin (3):
      Revert "vhost: add traces for memory listeners"
      lpc: drop pcie host dependency
      acpi-test: update FADT

Peter Xu (1):
      pci/bus: let it has higher migration priority

Tiwei Bie (1):
      virtio-balloon: unref the memory region before continuing

Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (1):
      virtio-balloon: include statistics of disk/file caches

Yongji Xie (2):
      libvhost-user: Fix resource leak
      libvhost-user: Support across-memory-boundary access

Yoni Bettan (1):
      pci: removed the is_express field since a uniform interface was ins=
erted

 docs/interop/vhost-user.txt                     |  26 ++
 docs/pcie_pci_bridge.txt                        |   2 +-
 configure                                       |  15 +
 contrib/libvhost-user/libvhost-user.h           |   3 +-
 include/hw/compat.h                             |   8 +
 include/hw/pci/pci.h                            |   3 -
 include/hw/pci/pci_bridge.h                     |   4 +-
 include/hw/virtio/vhost-backend.h               |   8 +
 include/hw/virtio/vhost.h                       |   5 +-
 include/hw/virtio/virtio-bus.h                  |   2 +
 include/hw/virtio/virtio-crypto.h               |   1 +
 include/migration/vmstate.h                     |   1 +
 include/standard-headers/linux/virtio_balloon.h |   3 +-
 include/sysemu/cryptodev-vhost-user.h           |  47 +++
 include/sysemu/cryptodev-vhost.h                | 154 ++++++++
 include/sysemu/cryptodev.h                      |   8 +
 backends/cryptodev-builtin.c                    |   1 +
 backends/cryptodev-vhost-user.c                 | 379 ++++++++++++++++++
 backends/cryptodev-vhost.c                      | 347 ++++++++++++++++
 contrib/libvhost-user/libvhost-user.c           | 147 ++++++-
 hw/block/dataplane/virtio-blk.c                 |   2 +
 hw/block/nvme.c                                 |   1 -
 hw/isa/lpc_ich9.c                               |   1 -
 hw/net/e1000e.c                                 |   1 -
 hw/pci-bridge/gen_pcie_root_port.c              |   1 +
 hw/pci-bridge/i82801b11.c                       |   2 +
 hw/pci-bridge/ioh3420.c                         |   1 +
 hw/pci-bridge/pci_bridge_dev.c                  |   1 +
 hw/pci-bridge/pcie_pci_bridge.c                 |   3 +-
 hw/pci-bridge/pcie_root_port.c                  |   1 -
 hw/pci-bridge/xio3130_downstream.c              |   2 +-
 hw/pci-bridge/xio3130_upstream.c                |   2 +-
 hw/pci-host/xilinx-pcie.c                       |   1 -
 hw/pci/pci.c                                    |   8 +-
 hw/pci/pci_bridge.c                             |  24 +-
 hw/scsi/megasas.c                               |   4 -
 hw/scsi/virtio-scsi-dataplane.c                 |   2 +
 hw/usb/hcd-xhci.c                               |   9 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-user.c                          | 104 +++++
 hw/virtio/vhost.c                               | 504 ++++++++----------=
------
 hw/virtio/virtio-balloon.c                      |   2 +
 hw/virtio/virtio-bus.c                          |  14 +-
 hw/virtio/virtio-crypto.c                       |  70 ++++
 hw/virtio/virtio-pci.c                          |  14 +-
 hw/virtio/virtio.c                              |  22 +-
 hw/xen/xen_pt.c                                 |   9 +-
 tests/bios-tables-test.c                        |  35 +-
 vl.c                                            |   6 +
 backends/Makefile.objs                          |   6 +
 hw/virtio/Makefile.objs                         |   2 +-
 hw/virtio/trace-events                          |  12 +-
 qemu-options.hx                                 |  21 +
 tests/acpi-test-data/pc/FACP                    | Bin 116 -> 116 bytes
 tests/acpi-test-data/q35/FACP                   | Bin 116 -> 244 bytes
 55 files changed, 1662 insertions(+), 394 deletions(-)
 create mode 100644 include/sysemu/cryptodev-vhost-user.h
 create mode 100644 include/sysemu/cryptodev-vhost.h
 create mode 100644 backends/cryptodev-vhost-user.c
 create mode 100644 backends/cryptodev-vhost.c
