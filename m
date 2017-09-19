Received: from eggs.gnu.org ([2001:4830:134:3::10]:44233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxA-0001s6-8j
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJx5-0007HV-Dw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJx5-0007GT-67
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:43 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:55:58 +0200
Message-Id: <20170919145636.9389-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/38] various s390x patches (+some fixes)
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

The following changes since commit 11e06ce1ed28fd0ffcbc1e2436b72f3412b4ec=
c8:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' int=
o staging (2017-09-19 10:13:51 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170919

for you to fetch changes up to 4f195287a30f1d58e4aee911aed310883bb819db:

  MAINTAINERS/s390x: add terminal3270.c (2017-09-19 15:32:26 +0200)

----------------------------------------------------------------
Assorted s390x patches:
- introduce virtio-gpu-ccw, with virtio-gpu endian fixes
- lots of cleanup in the s390x code
- make device_add work for s390x cpus
- enable seccomp on s390x
- an ivshmem endian fix
- set the reserved DHCP client architecture id for netboot
- fixes in the css and pci support

----------------------------------------------------------------

Christian Borntraeger (1):
  MAINTAINERS/s390x: add terminal3270.c

Cornelia Huck (1):
  s390x/ccw: create s390 phb for compat reasons as well

David Hildenbrand (22):
  exec,dump,i386,ppc,s390x: don't include exec/cpu-all.h explicitly
  cpu: drop old comments describing members
  s390x: get rid of s390-virtio.c
  s390x: rename s390-virtio.h to s390-virtio-hcall.h
  s390x: move s390_virtio_hypercall() to s390-virtio-hcall.h
  s390x: move subsystem_reset() to s390-virtio-ccw.h
  target/s390x: move some s390x typedefs to cpu-qom.h
  s390x: move sclp_service_call() to sclp.h
  target/s390x: use trigger_pgm_exception() in
    s390_cpu_handle_mmu_fault()
  target/s390x: use program_interrupt() in per_check_exception()
  s390x: allow only 1 CPU with TCG
  target/s390x: set cpu->id for linux user when realizing
  target/s390x: use "core-id" for cpu number/address/id handling
  target/s390x: rename next_cpu_id to next_core_id
  s390x: print CPU definitions in sorted order
  s390x: allow cpu hotplug via device_add
  s390x: CPU hot unplug via device_del cannot work for now
  s390x: implement query-hotpluggable-cpus
  s390x: get rid of cpu_states and use possible_cpus instead
  s390x: get rid of cpu_s390x_create()
  s390x: generate sclp cpu information from possible_cpus
  s390x: allow CPU hotplug in random core-id order

Farhan Ali (2):
  virtio-gpu: Handle endian conversion
  virtio-ccw: Create a virtio gpu device for the ccw bus

Halil Pasic (5):
  s390x/css: fix cc handling for XSCH
  s390x/css: drop data-check in interpretation
  s390x/css: fix NULL handling for CCW addresses
  s390x/css: remove unused error handling branch
  virtio-ccw: remove stale comments on endianness

Thomas Huth (3):
  tests: Enable the drive_del test also on s390x
  hw/misc/ivshmem: Fix ivshmem_recv_msg() to also work on big endian
    systems
  configure: Allow --enable-seccomp on s390x, too

Viktor Mihajlovski (1):
  s390: set DHCP client architecure id for netboot

Yi Min Zhao (3):
  s390x/pci: remove idx from msix msg data
  s390x/pci: fixup ind_offset of msix routing entry
  s390x/pci: add iommu replay callback

 MAINTAINERS                        |   1 +
 configure                          |   2 +-
 dump.c                             |   1 -
 exec.c                             |   1 -
 hw/display/virtio-gpu.c            |  70 +++++++++--
 hw/misc/ivshmem.c                  |   2 +-
 hw/s390x/Makefile.objs             |   1 -
 hw/s390x/css.c                     |  28 +----
 hw/s390x/s390-pci-bus.c            |  28 +++--
 hw/s390x/s390-pci-bus.h            |   2 +
 hw/s390x/s390-pci-inst.c           |  24 ----
 hw/s390x/s390-pci-stub.c           |   3 +-
 hw/s390x/s390-virtio-ccw.c         | 239 +++++++++++++++++++++++++++++++=
++++--
 hw/s390x/s390-virtio-hcall.c       |   2 +-
 hw/s390x/s390-virtio-hcall.h       |  21 ++++
 hw/s390x/s390-virtio.c             | 201 -------------------------------
 hw/s390x/s390-virtio.h             |  35 ------
 hw/s390x/sclp.c                    |  34 +++---
 hw/s390x/virtio-ccw.c              |  51 +++++++-
 hw/s390x/virtio-ccw.h              |  10 ++
 include/hw/s390x/s390-virtio-ccw.h |   2 +
 include/hw/s390x/sclp.h            |   2 +
 include/qom/cpu.h                  |   6 +-
 pc-bios/s390-ccw/netboot.mak       |   2 +-
 qapi-schema.json                   |  16 +++
 target/i386/arch_dump.c            |   1 -
 target/i386/arch_memory_mapping.c  |   1 -
 target/i386/svm_helper.c           |   1 -
 target/ppc/arch_dump.c             |   1 -
 target/s390x/arch_dump.c           |   1 -
 target/s390x/cpu-qom.h             |   7 +-
 target/s390x/cpu.c                 |  85 ++++---------
 target/s390x/cpu.h                 |  13 +-
 target/s390x/cpu_models.c          |  61 +++++++---
 target/s390x/cpu_models.h          |   8 +-
 target/s390x/diag.c                |   1 +
 target/s390x/excp_helper.c         |   5 +-
 target/s390x/helper.c              |  47 +-------
 target/s390x/internal.h            |   1 -
 target/s390x/kvm.c                 |  15 ++-
 target/s390x/misc_helper.c         |  21 ++--
 target/s390x/translate.c           |   5 +-
 tests/Makefile.include             |   3 +-
 tests/drive_del-test.c             |  25 ++--
 tests/libqos/virtio.c              |  17 +++
 tests/libqos/virtio.h              |   3 +
 46 files changed, 589 insertions(+), 517 deletions(-)
 create mode 100644 hw/s390x/s390-virtio-hcall.h
 delete mode 100644 hw/s390x/s390-virtio.c
 delete mode 100644 hw/s390x/s390-virtio.h

--=20
2.13.5
