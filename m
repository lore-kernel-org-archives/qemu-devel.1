Received: from eggs.gnu.org ([2001:4830:134:3::10]:44154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6F-0001Sn-RE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6A-000323-TG
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:27 -0500
Received: from mail.kernel.org ([198.145.29.136]:50996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6A-000308-Jl
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:22 -0500
Date: Thu, 2 Mar 2017 08:20:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/15] virtio, pc: fixes, features
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

The following changes since commit 1e0addb682c3c552fd97480037d4f8ff18e2b87e:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170228-tag' into staging (2017-03-01 20:33:47 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 077dd74239a99f6c1e77c5c1aa24cfc7f58cd20c:

  hw/pxb-pcie: fix PCI Express hotplug support (2017-03-02 07:31:26 +0200)

----------------------------------------------------------------
virtio, pc: fixes, features

virtio support for region caches broke a bunch of stuff - fixing most of
it though it's not ideal.  Still pondering the right way to fix it.
New: VM gen ID and hotplug for PXB.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ben Warren (6):
      linker-loader: Add new 'write pointer' command
      docs: VM Generation ID device description
      ACPI: Add vmgenid blob storage to the build tables
      ACPI: Add Virtual Machine Generation ID support
      tests: Move reusable ACPI code into a utility file
      MAINTAINERS: Add VM Generation ID entries

Cornelia Huck (1):
      virtio: guard vring access when setting notification

Igor Mammedov (1):
      qmp/hmp: add query-vm-generation-id and 'info vm-generation-id' commands

Jason Wang (1):
      virtio: unbreak virtio-pci with IOMMU after caching ring translations

Marcel Apfelbaum (1):
      hw/pxb-pcie: fix PCI Express hotplug support

Michael S. Tsirkin (2):
      acpi: simplify _OSC
      tests/acpi: update DSDT after last patch

Paolo Bonzini (1):
      virtio: check for vring setup in virtio_queue_empty

Stefan Hajnoczi (2):
      virtio: invalidate memory in vring_set_avail_event()
      virtio: add missing region cache init in virtio_load()

 docs/specs/vmgenid.txt               | 245 +++++++++++++++++++++++++++++++++
 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 qapi-schema.json                     |  20 +++
 hmp.h                                |   1 +
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/aml-build.h          |   1 +
 include/hw/acpi/bios-linker-loader.h |   7 +
 include/hw/acpi/vmgenid.h            |  35 +++++
 tests/acpi-utils.h                   |  94 +++++++++++++
 hmp.c                                |   9 ++
 hw/acpi/aml-build.c                  |   2 +
 hw/acpi/bios-linker-loader.c         |  66 ++++++++-
 hw/acpi/vmgenid.c                    | 258 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                 |  24 +++-
 hw/virtio/virtio-pci.c               |   2 +-
 hw/virtio/virtio.c                   |  32 ++++-
 stubs/vmgenid.c                      |   9 ++
 tests/acpi-utils.c                   |  65 +++++++++
 tests/bios-tables-test.c             | 132 ++----------------
 MAINTAINERS                          |  11 ++
 dtc                                  |   2 +-
 hmp-commands-info.hx                 |  14 ++
 hw/acpi/Makefile.objs                |   1 +
 stubs/Makefile.objs                  |   1 +
 tests/Makefile.include               |   2 +-
 tests/acpi-test-data/q35/DSDT        | Bin 7860 -> 7824 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7877 -> 7841 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8323 -> 8287 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7935 -> 7899 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9225 -> 9189 bytes
 31 files changed, 902 insertions(+), 134 deletions(-)
 create mode 100644 docs/specs/vmgenid.txt
 create mode 100644 include/hw/acpi/vmgenid.h
 create mode 100644 tests/acpi-utils.h
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 stubs/vmgenid.c
 create mode 100644 tests/acpi-utils.c
