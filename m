Received: from eggs.gnu.org ([2001:4830:134:3::10]:33813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAk6-0006GX-C2
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAk1-00057h-G4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:18 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Jun 2018 15:44:01 +0200
Message-Id: <20180627134410.4901-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/9] s390x: TOD refactoring + TCG CPU
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

The third patch also refactors TOD handling for KVM (moved into a new
TOD device). The second patch makes sure that we can use a const pointer
for the new TOD clock struct.

v3 -> v4:
- "s390x/kvm: pass values instead of pointers to kvm_s390_set_clock_*()"
-- Added a note in the patch description as reuested
- "[PATCH v3 5/9] s390x/tcg: properly implement the TOD"
-- tod->low < td->base.low -> td->base.low > tod->low
-- access td->base.low directly in sckc handler

v2 -> v3:
- added "s390x/tcg: avoid overflows in time2tod/tod2time"
- added "s390x/kvm: pass values instead of pointers to kvm_s390_set_clock_*()"
- "s390x/tod: factor out TOD into separate device"
-- Use "const" for parameters in function definitions
-- Use "s390-tod-qemu" and "s390-tod-kvm" as type names
-- Drop hotpluggable=false
- "s390x/tcg: properly implement the TOD"
-- s390_get_tod() -> s390_get_todstate()
-- use error_abort
- "s390x/tcg: SET CLOCK COMPARATOR can clear CKC interrupts"
-- Add a comment for the -1ULL check
- "s390x/tcg: implement SET CLOCK"
-- use error_abort
- "s390x/tcg: fix CPU hotplug with single-threaded TCG"
-- add a comment describing the run_on_cpu() difference

v1 -> v2:
- "s390x/tcg: properly implement the TOD"
-- introduce "tcg_s390x.h" similar to "kvm_s390x.h"
-- dropped one unnecessary include introduction
- "s390x/tcg: rearm the CKC timer during migration"
-- introduce "tcg-stub.c" similar to "kvm-stub.c"

David Hildenbrand (9):
  s390x/tcg: avoid overflows in time2tod/tod2time
  s390x/kvm: pass values instead of pointers to kvm_s390_set_clock_*()
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
 hw/s390x/tod-qemu.c        |  87 +++++++++++++++++++++++++
 hw/s390x/tod.c             | 130 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/tod.h     |  65 +++++++++++++++++++
 target/s390x/Makefile.objs |   1 +
 target/s390x/cpu.c         |  57 ++++------------
 target/s390x/cpu.h         |   4 --
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def |   3 +-
 target/s390x/internal.h    |  15 -----
 target/s390x/kvm-stub.c    |   4 +-
 target/s390x/kvm.c         |  12 ++--
 target/s390x/kvm_s390x.h   |   6 +-
 target/s390x/machine.c     |   6 ++
 target/s390x/misc_helper.c |  50 ++++++++++++--
 target/s390x/tcg-stub.c    |  20 ++++++
 target/s390x/tcg_s390x.h   |  18 +++++
 target/s390x/translate.c   |   9 +++
 20 files changed, 475 insertions(+), 137 deletions(-)
 create mode 100644 hw/s390x/tod-kvm.c
 create mode 100644 hw/s390x/tod-qemu.c
 create mode 100644 hw/s390x/tod.c
 create mode 100644 include/hw/s390x/tod.h
 create mode 100644 target/s390x/tcg-stub.c
 create mode 100644 target/s390x/tcg_s390x.h

-- 
2.17.1
