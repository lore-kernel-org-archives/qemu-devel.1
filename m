Received: from eggs.gnu.org ([2001:4830:134:3::10]:56188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Ef-0001AP-3A
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Ed-0004rw-RY
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Ed-0004rT-IK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:52:59 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:08 +0200
Message-Id: <20170830165252.13421-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/44] first batch of s390x patches for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8=
ec:

  Update version for v2.10.0 release (2017-08-30 17:02:54 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170830

for you to fetch changes up to 2f21b8d431030bcb7478ee9521bdfd3d0ef3901d:

  s390x/pci: fixup trap_msix() (2017-08-30 18:23:26 +0200)

----------------------------------------------------------------
First batch of s390x patches:
- 2.11 compat machine
- support the new --s390-pgste linker option, making it possible to
  avoid enabling the global vm.allocate_pgste systl if all pieces
  are in place
- correctly identify some devices as not hotpluggable
- clean up some tests and enable them for s390x
- wire up the diag288 watchdog in tcg
- clean up dependencies on CONFIG_PCI, making it possible to disable
  it by hand
- lots of cleanup in target/s390x/
- fix alignment of the ccw1 structure in the s390-ccw bios
- and some more bugfixes

----------------------------------------------------------------

Christian Borntraeger (1):
  configure: enable --s390-pgste linker option

Cornelia Huck (13):
  s390x: introduce 2.11 compat machine
  s390x/tcg: specification exception for unknown diag
  s390x: wire up diag288 in tcg
  9pfs: fix dependencies
  kvm: remove hard dependency on pci
  s390x/pci: add stubs
  s390x: chsc nt2 events are pci-only
  s390x/pci: do not advertise pci on non-pci builds
  s390x/ccw: create s390 phb conditionally
  s390x/sclp: properly guard pci-specific functions
  s390x/pci: fence off instructions for non-pci
  s390x: refine pci dependencies
  pc-bios/s390-ccw.img: update image

David Hildenbrand (18):
  s390x/kvm: drop KVMState parameter from s390_get_memslot_count()
  s390x/kvm: drop KVMState parameter from kvm_s390_set_mem_limit()
  target/s390x: simplify ri_allowed()
  target/s390x: simplify gs_allowed()
  target/s390x: no need to pass kvm_state to savevm_gtod handlers
  s390x/cpumodel: factor out determination of default model name
  s390x: drop inclusion of sysemu/kvm.h from some files
  target/s390x: move gtod_*() declarations to s390-virtio.h
  target/s390x: move cc_name() to helper.c
  target/s390x: move cpu_mmu_idx_to_asc() to excp_helper.c
  target/s390x: move psw_key_valid() to mem_helper.c
  target/s390x: move s390_do_cpu_reset() to diag.c
  target/s390x: move get_per_in_range() to misc_helper.c
  target/s390x: introduce internal.h
  target/s390x: move a couple of functions to cpu.c
  s390x: avoid calling kvm_ functions outside of target/s390x/
  s390x/kvm: move KVM declarations and stubs to separate files
  target/s390x: cleanup cpu.h

Dong Jia Shi (2):
  s390x/css: use macro for event-information pending error recover code
  s390x/css: generate solicited crw for rchp completion signaling

Farhan Ali (1):
  s390-ccw: Fix alignment for CCW1

Thomas Huth (8):
  s390x/ipl: The s390-ipl device is not hot-pluggable
  tests/boot-sector: Do not overwrite the x86 buffer on other
    architectures
  tests/pxe: Check virtio-net-ccw on s390x
  tests: Run filter-redirector and -mirror test only on POSIX systems
  tests: Add network filter tests to the check-qtest-s390x list
  watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggable
  s390x/s390-skeys: Mark the storage key devices with user_creatable =3D
    false
  s390x/s390-stattrib: Mark the storage attribute as not user_creatable

Yi Min Zhao (1):
  s390x/pci: fixup trap_msix()

 accel/kvm/kvm-all.c               |   6 +-
 configure                         |  21 +-
 default-configs/s390x-softmmu.mak |   2 +-
 fsdev/Makefile.objs               |   9 +-
 hw/9pfs/Makefile.objs             |   2 +-
 hw/Makefile.objs                  |   2 +-
 hw/intc/s390_flic_kvm.c           |   1 +
 hw/pci/pci-stub.c                 |  14 +
 hw/pci/pci.c                      |   2 +
 hw/s390x/Makefile.objs            |   3 +-
 hw/s390x/css.c                    |  16 +-
 hw/s390x/ipl.c                    |   2 +
 hw/s390x/s390-pci-bus.c           |  18 +-
 hw/s390x/s390-pci-bus.h           |  12 +-
 hw/s390x/s390-pci-inst.c          |   4 +-
 hw/s390x/s390-pci-stub.c          |  76 ++++
 hw/s390x/s390-skeys-kvm.c         |   4 +
 hw/s390x/s390-skeys.c             |   4 +
 hw/s390x/s390-stattrib-kvm.c      |   5 +
 hw/s390x/s390-stattrib.c          |   6 +-
 hw/s390x/s390-virtio-ccw.c        |  54 +--
 hw/s390x/s390-virtio.c            |   7 +-
 hw/s390x/s390-virtio.h            |   2 +
 hw/s390x/sclp.c                   |  42 ++-
 hw/s390x/sclpcpu.c                |   1 -
 hw/watchdog/wdt_diag288.c         |   1 +
 include/hw/compat.h               |   3 +
 include/hw/pci/pci.h              |   2 +
 include/hw/s390x/css.h            |   4 +-
 include/hw/s390x/ioinst.h         |  12 +-
 include/hw/s390x/sclp.h           |  17 +-
 pc-bios/s390-ccw.img              | Bin 30520 -> 26416 bytes
 pc-bios/s390-ccw/cio.h            |   2 +-
 target/s390x/Makefile.objs        |   1 +
 target/s390x/arch_dump.c          |   2 +-
 target/s390x/cc_helper.c          |   1 +
 target/s390x/cpu.c                |  89 +++++
 target/s390x/cpu.h                | 759 ++++----------------------------=
------
 target/s390x/cpu_models.c         |  11 +
 target/s390x/diag.c               |   8 +
 target/s390x/excp_helper.c        |  15 +
 target/s390x/fpu_helper.c         |   1 +
 target/s390x/gdbstub.c            |   1 +
 target/s390x/helper.c             |  49 +++
 target/s390x/int_helper.c         |   1 +
 target/s390x/internal.h           | 391 ++++++++++++++++++++
 target/s390x/interrupt.c          |   2 +
 target/s390x/ioinst.c             |  17 +
 target/s390x/kvm-stub.c           | 111 ++++++
 target/s390x/kvm.c                |  76 ++--
 target/s390x/kvm_s390x.h          |  47 +++
 target/s390x/machine.c            |   2 +
 target/s390x/mem_helper.c         |  12 +
 target/s390x/misc_helper.c        |  18 +-
 target/s390x/mmu_helper.c         |   2 +
 target/s390x/translate.c          |   1 +
 tests/Makefile.include            |  12 +-
 tests/boot-sector.c               |  61 ++-
 tests/pxe-test.c                  |   7 +
 tests/test-filter-mirror.c        |  14 +-
 tests/test-filter-redirector.c    |  32 +-
 tests/test-netfilter.c            |  11 +-
 62 files changed, 1257 insertions(+), 853 deletions(-)
 create mode 100644 hw/s390x/s390-pci-stub.c
 create mode 100644 target/s390x/internal.h
 create mode 100644 target/s390x/kvm-stub.c
 create mode 100644 target/s390x/kvm_s390x.h

--=20
2.13.5
