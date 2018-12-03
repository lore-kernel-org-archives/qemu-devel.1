Received: from eggs.gnu.org ([2001:4830:134:3::10]:51490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE3-0007pf-2a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqDy-0003oG-04
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqDx-0003mL-Ox
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:29 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:13 +0100
Message-Id: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 00/71] qtest: qgraph driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

Patches 1-14 are actually a refactoring of vhost and vhost-user-test so
that it can be "qtested" on all targets that support virtio-net.

Patches 15-18 are other small refactorings to the libqos library and fixe=
s
to the Makefile.

Patch 19 is the framework, including unit tests, while the rest is conver=
sions
of existing tests.  We tried to pick tests that used a mix of features of
qtest, and that cover as many use cases as possible within qgraph.=20
In particular:

- sdhci-test was the motivating example for the duplication between
  PCI and MMIO versions of the same devices, so it come first

- all virtio tests were converted, since they also have both MMIO and
  PCI variants and they taught us a lot about modeling devices within
  qgraph

- all PCI devices that had "nop" tests only were converted, so that they
  can avoid defining their copy of the test, and can instead use a
  common test

- finally, three more PCI devices were converted as an example - e1000e,
  nvme and megasas

This submission includes quite a few changes and cleanups that we did
not manage to complete before Emanuele restarted classes, but this
is almost entirely his baby; don't be fooled by the number of patches
authored by him vs. myself.  I have noted my changes to the framework
in the commit message to patch 19, to help people that followed the
previous submissions; apart from that my changes consist of porting
vhost-user-test and turning the nop tests into generic PCI and virtio
tests (even though Emanuele had done the conversion to qgraph, he had
left the tests in the nodes due to lack of time).

Thanks,

Paolo

Based-on: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>

Emanuele Giuseppe Esposito (45):
  tests/libqos: introduce virtio_start_device
  tests/libqos: rename qpci_init_pc and qpci_init_spapr functions
  tests: qgraph API for the qtest driver framework
  tests/libqos: pci-pc driver and interface nodes
  tests/libqos: x86_64/pc machine node
  tests/libqos: sdhci driver and interface nodes
  tests/libqos: arm/raspi2 machine node
  tests/libqos: arm/smdkc210 machine node
  tests/libqos: arm/sabrelite machine node
  tests/libqos: arm/xilinx-zynq-a9 machine node
  tests/libqos: aarch64/xlnx-zcu102 machine node
  qos-test: sdhci test node
  tests/libqos: pci-spapr driver and interface nodes
  tests/qgraph: ppc64/pseries machine node
  tests/libqos: has_buggy_msi flag
  tests/libqos: e1000e driver and interface nodes
  qos-test: e1000e test node
  tests/libqos: virtio-pci driver and interface nodes
  tests/libqos: virtio-mmio driver and interface nodes
  tests/libqos: arm/virt machine node
  tests/libqos: virtio-serial driver and interface nodes
  qos-test: virtio-console and virtio-serial test node
  tests/libqos: virtio-9p driver and interface nodes
  qos-test: virtio-9p test node
  tests/libqos: virtio-balloon driver and interface nodes
  tests/qgraph: remove virtio-balloon-test
  tests/libqos: virtio-rng driver and interface nodes
  qos-test: virtio-rng test node
  tests/libqos: virtio-blk driver and interface nodes
  tests/libqos: virtio-net driver and interface nodes
  qos-test: virtio-net test node
  tests/libqos: virtio-scsi driver and interface nodes
  qos-test: virtio-scsi test node
  qos-test: ac97 test node
  qos-test: tpci200 test node
  qos-test: ipoctal232 test node
  qos-test: ne2k_pci test node
  qos-test: nvme test node
  qos-test: pcnet test node
  qos-test: spapr-phb test node
  qos-test: usb-hcd-ohci test node
  qos-test: vmxnet3 test node
  qos-test: es1370 test node
  qos-test: eepro100 test node
  qos-test: e1000 test node

Paolo Bonzini (26):
  vhost-net: move stubs to a separate file
  vhost-net-user: add stubs for when no virtio-net device is present
  vhost: restrict Linux dependency to kernel vhost
  vhost-net: compile it on all targets that have virtio-net.
  vhost-net: revamp configure logic
  vhost-user-test: use g_cond_broadcast
  vhost-user-test: signal data_cond when s->rings changes
  vhost-user: support cross-endian vnet headers
  vhost-user-test: support VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
  vhost-user-test: skip if there is no memory at address 0
  vhost-user-test: reduce usage of global_qtest
  vhost-user-test: create a main loop per TestServer
  vhost-user-test: small changes to init_hugepagefs
  vhost-user-test: create a temporary directory per TestServer
  tests: remove rule for nonexisting qdev-monitor-test
  tests/libqos: embed allocators instead of malloc-ing them
  tests/qgraph: add generic PCI testcases
  tests/libqos: remove global_qtest from virtio endianness checks
  tests/qgraph: add generic virtio testcases
  qos-test: virtio-blk test node
  tests/libqos: support multiqueue for virtio-net
  vhost-user-test: always use 256 MiB of guest memory
  qos-test: vhost-user test node
  tests/libqos: remove pre-qgraph QVirtioPCIDevice API
  tests: move virtio entirely to qos-test
  qos-test: megasas test node

 backends/Makefile.objs                     |   5 +-
 configure                                  | 104 ++--
 default-configs/virtio.mak                 |   4 +-
 hw/net/Makefile.objs                       |   4 +-
 hw/net/vhost_net-stub.c                    |  95 ++++
 hw/net/vhost_net.c                         |  78 +--
 hw/virtio/Makefile.objs                    |   5 +-
 hw/virtio/vhost-backend.c                  |  11 +-
 include/exec/poison.h                      |   1 -
 include/qemu/module.h                      |   2 +
 net/Makefile.objs                          |   4 +-
 net/net.c                                  |   2 +-
 net/vhost-user-stub.c                      |  23 +
 net/vhost-user.c                           |  13 +
 tests/Makefile.include                     | 133 +++--
 tests/ac97-test.c                          |  47 +-
 tests/ahci-test.c                          |   6 +-
 tests/drive_del-test.c                     |  25 +-
 tests/e1000-test.c                         |  64 ++-
 tests/e1000e-test.c                        | 358 +++-----------
 tests/eepro100-test.c                      |  65 ++-
 tests/es1370-test.c                        |  46 +-
 tests/i440fx-test.c                        |   2 +-
 tests/ide-test.c                           |  19 +-
 tests/ipoctal232-test.c                    |  35 +-
 tests/libqos/aarch64-xlnx-zcu102-machine.c |  93 ++++
 tests/libqos/ahci.c                        |   2 +-
 tests/libqos/arm-raspi2-machine.c          |  91 ++++
 tests/libqos/arm-sabrelite-machine.c       |  91 ++++
 tests/libqos/arm-smdkc210-machine.c        |  91 ++++
 tests/libqos/arm-virt-machine.c            |  90 ++++
 tests/libqos/arm-xilinx-zynq-a9-machine.c  |  94 ++++
 tests/libqos/e1000e.c                      | 260 ++++++++++
 tests/libqos/e1000e.h                      |  53 ++
 tests/libqos/libqos-pc.c                   |   5 +-
 tests/libqos/libqos-spapr.c                |   5 +-
 tests/libqos/libqos.c                      |  13 +-
 tests/libqos/libqos.h                      |  13 +-
 tests/libqos/malloc-generic.c              |  39 --
 tests/libqos/malloc-generic.h              |  21 -
 tests/libqos/malloc-pc.c                   |  18 +-
 tests/libqos/malloc-pc.h                   |   4 +-
 tests/libqos/malloc-spapr.c                |  19 +-
 tests/libqos/malloc-spapr.h                |   4 +-
 tests/libqos/malloc.c                      |  41 +-
 tests/libqos/malloc.h                      |  21 +-
 tests/libqos/pci-pc.c                      |  86 ++--
 tests/libqos/pci-pc.h                      |  22 +-
 tests/libqos/pci-spapr.c                   | 119 +++--
 tests/libqos/pci-spapr.h                   |  26 +-
 tests/libqos/pci.c                         |  46 +-
 tests/libqos/pci.h                         |  16 +
 tests/libqos/ppc64_pseries-machine.c       | 111 +++++
 tests/libqos/qgraph.c                      | 760 +++++++++++++++++++++++=
++++++
 tests/libqos/qgraph.h                      | 575 ++++++++++++++++++++++
 tests/libqos/qgraph_internal.h             | 264 ++++++++++
 tests/libqos/sdhci.c                       | 163 +++++++
 tests/libqos/sdhci.h                       |  70 +++
 tests/libqos/tpci200.c                     |  65 +++
 tests/libqos/virtio-9p.c                   | 173 +++++++
 tests/libqos/virtio-9p.h                   |  42 ++
 tests/libqos/virtio-balloon.c              | 113 +++++
 tests/libqos/virtio-balloon.h              |  39 ++
 tests/libqos/virtio-blk.c                  | 124 +++++
 tests/libqos/virtio-blk.h                  |  40 ++
 tests/libqos/virtio-mmio.c                 | 116 +++--
 tests/libqos/virtio-mmio.h                 |   6 +-
 tests/libqos/virtio-net.c                  | 195 ++++++++
 tests/libqos/virtio-net.h                  |  41 ++
 tests/libqos/virtio-pci.c                  | 187 ++++---
 tests/libqos/virtio-pci.h                  |  18 +-
 tests/libqos/virtio-rng.c                  | 110 +++++
 tests/libqos/virtio-rng.h                  |  39 ++
 tests/libqos/virtio-scsi.c                 | 117 +++++
 tests/libqos/virtio-scsi.h                 |  39 ++
 tests/libqos/virtio-serial.c               | 110 +++++
 tests/libqos/virtio-serial.h               |  39 ++
 tests/libqos/virtio.c                      |  24 +-
 tests/libqos/virtio.h                      |  11 +-
 tests/libqos/x86_64_pc-machine.c           | 110 +++++
 tests/libqtest.h                           |   6 +
 tests/megasas-test.c                       |  80 +--
 tests/ne2000-test.c                        |  46 +-
 tests/nvme-test.c                          |  78 +--
 tests/pci-test.c                           |  25 +
 tests/pcnet-test.c                         |  46 +-
 tests/q35-test.c                           |   4 +-
 tests/qos-test.c                           | 470 ++++++++++++++++++
 tests/rtas-test.c                          |   2 +-
 tests/rtl8139-test.c                       |   2 +-
 tests/sdhci-test.c                         | 185 +------
 tests/spapr-phb-test.c                     |  32 +-
 tests/tco-test.c                           |   2 +-
 tests/test-qgraph.c                        | 434 ++++++++++++++++
 tests/tpci200-test.c                       |  31 --
 tests/usb-hcd-ehci-test.c                  |   2 +-
 tests/usb-hcd-ohci-test.c                  |  54 +-
 tests/vhost-user-test.c                    | 516 +++++++++-----------
 tests/virtio-9p-test.c                     | 220 +++------
 tests/virtio-balloon-test.c                |  33 --
 tests/virtio-blk-test.c                    | 471 +++++++-----------
 tests/virtio-console-test.c                |  38 --
 tests/virtio-net-test.c                    | 167 ++-----
 tests/virtio-rng-test.c                    |  27 +-
 tests/virtio-scsi-test.c                   | 145 +++---
 tests/virtio-serial-test.c                 |  27 +-
 tests/virtio-test.c                        |  25 +
 tests/vmxnet3-test.c                       |  46 +-
 108 files changed, 7084 insertions(+), 2365 deletions(-)
 create mode 100644 hw/net/vhost_net-stub.c
 create mode 100644 net/vhost-user-stub.c
 create mode 100644 tests/libqos/aarch64-xlnx-zcu102-machine.c
 create mode 100644 tests/libqos/arm-raspi2-machine.c
 create mode 100644 tests/libqos/arm-sabrelite-machine.c
 create mode 100644 tests/libqos/arm-smdkc210-machine.c
 create mode 100644 tests/libqos/arm-virt-machine.c
 create mode 100644 tests/libqos/arm-xilinx-zynq-a9-machine.c
 create mode 100644 tests/libqos/e1000e.c
 create mode 100644 tests/libqos/e1000e.h
 delete mode 100644 tests/libqos/malloc-generic.c
 delete mode 100644 tests/libqos/malloc-generic.h
 create mode 100644 tests/libqos/ppc64_pseries-machine.c
 create mode 100644 tests/libqos/qgraph.c
 create mode 100644 tests/libqos/qgraph.h
 create mode 100644 tests/libqos/qgraph_internal.h
 create mode 100644 tests/libqos/sdhci.c
 create mode 100644 tests/libqos/sdhci.h
 create mode 100644 tests/libqos/tpci200.c
 create mode 100644 tests/libqos/virtio-9p.c
 create mode 100644 tests/libqos/virtio-9p.h
 create mode 100644 tests/libqos/virtio-balloon.c
 create mode 100644 tests/libqos/virtio-balloon.h
 create mode 100644 tests/libqos/virtio-blk.c
 create mode 100644 tests/libqos/virtio-blk.h
 create mode 100644 tests/libqos/virtio-net.c
 create mode 100644 tests/libqos/virtio-net.h
 create mode 100644 tests/libqos/virtio-rng.c
 create mode 100644 tests/libqos/virtio-rng.h
 create mode 100644 tests/libqos/virtio-scsi.c
 create mode 100644 tests/libqos/virtio-scsi.h
 create mode 100644 tests/libqos/virtio-serial.c
 create mode 100644 tests/libqos/virtio-serial.h
 create mode 100644 tests/libqos/x86_64_pc-machine.c
 create mode 100644 tests/pci-test.c
 create mode 100644 tests/qos-test.c
 create mode 100644 tests/test-qgraph.c
 delete mode 100644 tests/tpci200-test.c
 delete mode 100644 tests/virtio-balloon-test.c
 delete mode 100644 tests/virtio-console-test.c
 create mode 100644 tests/virtio-test.c

--=20
1.8.3.1
