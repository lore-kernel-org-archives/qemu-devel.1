Received: from eggs.gnu.org ([2001:4830:134:3::10]:43222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4w9-0001r1-5H
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4w4-0005ri-NF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:24:55 +0100
Message-Id: <20180209092524.31348-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/29] s390x: assorted updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c=
96:

  Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' i=
nto staging (2018-02-08 14:31:51 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180209

for you to fetch changes up to ced01bb7e5d353a9055743d68d54f3581b29328c:

  MAINTAINERS: add David as additional tcg/s390 maintainer (2018-02-09 09=
:37:13 +0100)

----------------------------------------------------------------
s390x updates:
- rework interrupt handling for tcg, smp is now considered non-experiment=
al
- some general improvements in the flic
- improvements in the pci code, and wiring it up in tcg
- add PTFF subfunctions for multiple-epoch to the cpu model
- maintainership updates
- various other fixes and improvements

----------------------------------------------------------------

Alice Frosi (1):
  Fix configure for s390 qemu on alpine and other busybox environments

Christian Borntraeger (1):
  s390x/sclp: fix event mask handling

Cornelia Huck (5):
  s390x/tcg: wire up pci instructions
  s390x/cpumodel: allow zpci features in qemu model
  MAINTAINERS: add myself as overall s390x maintainer
  MAINTAINERS: reorganize s390-ccw bios maintainership
  MAINTAINERS: add David as additional tcg/s390 maintainer

David Hildenbrand (19):
  s390x/tcg: deliver multiple interrupts in a row
  s390x/flic: simplify flic initialization
  s390x/tcg: simplify lookup of flic
  s390x/tcg: simplify machine check handling
  s390x/flic: factor out injection of floating interrupts
  s390x/flic: no need to call s390_io_interrupt() from flic
  s390x/tcg: tolerate wrong wakeups due to floating interrupts
  s390x/flic: make floating interrupts on TCG actually floating
  s390x/tcg: implement TEST PENDING INTERRUPTION
  s390x/flic: implement qemu_s390_clear_io_flic()
  s390x/flic: optimize CPU wakeup for TCG
  s390x: fix size + content of STSI blocks
  s390x/tcg: STSI overhaul
  s390x/tcg: remove SMP warning
  configure: s390x supports mttcg now
  s390x/tcg: cache the qemu flic in a central function
  s390x/kvm: cache the kvm flic in a central function
  s390x/flic: cache the common flic class in a central function
  s390x/cpumodel: model PTFF subfunctions for Multiple-epoch facility

Yi Min Zhao (3):
  s390x/pci: fixup the code walking IOMMU tables
  s390x/pci: fixup global refresh
  s390x/pci: use the right pal and pba in reg_ioat()

 MAINTAINERS                     |  35 +++-
 configure                       |   5 +-
 hw/intc/s390_flic.c             | 257 +++++++++++++++++++++++++++--
 hw/intc/s390_flic_kvm.c         |  84 ++++++++--
 hw/s390x/css.c                  |  10 +-
 hw/s390x/event-facility.c       |   4 +-
 hw/s390x/s390-pci-bus.c         | 233 +++++++++++++++++++++-----
 hw/s390x/s390-pci-bus.h         |  17 ++
 hw/s390x/s390-pci-inst.c        | 103 ++++++++----
 hw/s390x/s390-virtio-ccw.c      |   4 -
 hw/s390x/virtio-ccw.c           |   4 +-
 include/hw/s390x/s390_flic.h    |  57 ++++++-
 target/s390x/cpu.c              |  10 --
 target/s390x/cpu.h              |  99 ++++++-----
 target/s390x/cpu_features.c     |   5 +
 target/s390x/cpu_features_def.h |   4 +
 target/s390x/cpu_models.c       |   6 +
 target/s390x/excp_helper.c      | 147 +++++++----------
 target/s390x/gen-features.c     |  17 +-
 target/s390x/helper.h           |  10 ++
 target/s390x/insn-data.def      |  14 ++
 target/s390x/internal.h         |   5 -
 target/s390x/interrupt.c        | 100 +++--------
 target/s390x/kvm-stub.c         |  13 --
 target/s390x/kvm.c              |  78 ++-------
 target/s390x/kvm_s390x.h        |  10 +-
 target/s390x/misc_helper.c      | 355 +++++++++++++++++++++++++++++-----=
------
 target/s390x/translate.c        | 110 +++++++++++++
 28 files changed, 1244 insertions(+), 552 deletions(-)

--=20
2.13.6
