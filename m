Received: from eggs.gnu.org ([2001:4830:134:3::10]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOOQw-0003vA-Cc
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOOQs-0006aG-2k
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:47:50 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:25 +0100
Message-Id: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 00/15] s390x: flic rework,
 tcg flic support and tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

This patch series implements floating interrupt support for TCG and fixes
STSI so we can remove warnings related to s390x SMP and MTTCG.

KVM code has to be touched in order to factor out the injection routines
into the flic ("s390x/flic: factor out injection of floating interrupts").
Basic testing didn't reveal any problems so far.

With this series I am now able to run fedora 26/27 and Ubuntu 17.10+ with
16 VCPUs (MTTCG) on a 8CPU host, doing a make -j16 in the guest. I got
nasty stalls in the guest beforehand.

I already sent the patches
 - "cpus: make pause_all_cpus() play with SMP on single threaded TCG"
 - "cpu-exec: fix missed CPU kick during interrupt injection"
separately, but as nobody commented so far (e.g. due to 2.11) I am including
them here as they are required to make SMP work reliably.

Based on: https://github.com/cohuck/qemu.git s390x-next
Available at: https://github.com/davidhildenbrand/qemu.git s390x-queue

David Hildenbrand (15):
  cpus: make pause_all_cpus() play with SMP on single threaded TCG
  cpu-exec: fix missed CPU kick during interrupt injection
  s390x/tcg: deliver multiple interrupts in a row
  s390x/flic: simplify flic initialization
  s390x/tcg: simplify machine check handling
  s390x/flic: factor out injection of floating interrupts
  s390x/tcg: tolerate wrong wakeups due to floating interrupts
  s390x/flic: make floating interrupts on TCG actually floating
  s390x/tcg: implement TEST PENDING INTERRUPTION
  s390x/flic: implement qemu_s390_clear_io_flic()
  s390x/flic: optimize CPU wakeup for TCG
  s390x/tcg: fix size + content of STSI blocks
  s390x/tcg: STSI overhaul
  s390x/tcg: remove SMP warning
  configure: s390x supports mttcg now

 accel/tcg/cpu-exec.c         |  12 +-
 configure                    |   1 +
 cpus.c                       |  32 +++---
 hw/intc/s390_flic.c          | 222 +++++++++++++++++++++++++++++++++++-
 hw/intc/s390_flic_kvm.c      |  75 +++++++++---
 hw/s390x/s390-virtio-ccw.c   |   4 -
 include/hw/s390x/s390_flic.h |  55 +++++++--
 target/s390x/cpu.c           |  10 --
 target/s390x/cpu.h           |  75 ++++++------
 target/s390x/excp_helper.c   | 147 +++++++++---------------
 target/s390x/helper.h        |   1 +
 target/s390x/insn-data.def   |   1 +
 target/s390x/internal.h      |   5 -
 target/s390x/interrupt.c     | 100 ++++------------
 target/s390x/kvm-stub.c      |  13 ---
 target/s390x/kvm.c           |  68 +----------
 target/s390x/kvm_s390x.h     |  10 +-
 target/s390x/misc_helper.c   | 266 +++++++++++++++++++++++++++----------------
 target/s390x/translate.c     |   8 ++
 19 files changed, 644 insertions(+), 461 deletions(-)

-- 
2.14.3
