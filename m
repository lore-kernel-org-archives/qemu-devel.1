Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVa2S-0001iA-G5
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVa2O-0001pi-Fj
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:32 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Jun 2018 12:08:18 +0200
Message-Id: <20180620100825.22476-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] s390x: TOD refactoring + TCG CPU
 hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

The TOD in TCG is not handled correctly:
- each CPU has its own TOD based on CPU creation time vs. a system TOD
- TOD is not migrated
- TOD timer is not restarted during migration
- CKC interrupts/TOD timer is not cleared when resetting the CKC

This (and a cpu creation problem for single threaded TCG) currently made
CPU hotplug under TCG not work. Now it's working

The fist patch also refactors TOD handling for KVM (moved into a new
TOD device).

v1 -> v2:
- "s390x/tcg: properly implement the TOD"
-- introduce "tcg_s390x.h" similar to "kvm_s390x.h"
-- dropped one unnecessary include introduction
- "s390x/tcg: rearm the CKC timer during migration"
-- introduce "tcg-stub.c" similar to "kvm-stub.c"

David Hildenbrand (7):
  s390x/tod: factor out TOD into separate device
  s390x/tcg: drop tod_basetime
  s390x/tcg: properly implement the TOD
  s390x/tcg: SET CLOCK COMPARATOR can clear CKC interrupts
  s390x/tcg: implement SET CLOCK
  s390x/tcg: rearm the CKC timer during migration
  s390x/tcg: fix CPU hotplug with single-threaded TCG

 hw/s390x/Makefile.objs     |   3 +
 hw/s390x/s390-virtio-ccw.c |  57 +---------------
 hw/s390x/tod-kvm.c         |  64 ++++++++++++++++++
 hw/s390x/tod-qemu.c        |  85 ++++++++++++++++++++++++
 hw/s390x/tod.c             | 131 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/tod.h     |  65 ++++++++++++++++++
 target/s390x/Makefile.objs |   1 +
 target/s390x/cpu.c         |  51 ++-------------
 target/s390x/cpu.h         |   4 --
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def |   3 +-
 target/s390x/internal.h    |  15 -----
 target/s390x/kvm_s390x.h   |   2 +
 target/s390x/machine.c     |   6 ++
 target/s390x/misc_helper.c |  60 +++++++++++++++--
 target/s390x/tcg-stub.c    |  20 ++++++
 target/s390x/tcg_s390x.h   |  18 +++++
 target/s390x/translate.c   |   9 +++
 18 files changed, 468 insertions(+), 127 deletions(-)
 create mode 100644 hw/s390x/tod-kvm.c
 create mode 100644 hw/s390x/tod-qemu.c
 create mode 100644 hw/s390x/tod.c
 create mode 100644 include/hw/s390x/tod.h
 create mode 100644 target/s390x/tcg-stub.c
 create mode 100644 target/s390x/tcg_s390x.h

-- 
2.17.1
