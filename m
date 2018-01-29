Received: from eggs.gnu.org ([2001:4830:134:3::10]:51365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg8zB-0004BQ-IC
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg8z7-0001xN-L6
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:56:33 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 29 Jan 2018 13:56:05 +0100
Message-Id: <20180129125623.21729-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/18] s390x: flic rework,
 tcg flic support and STSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

This patch series implements floating interrupt support for TCG and fixes
STSI so we can remove warnings related to s390x SMP and MTTCG.

KVM code has to be touched in order to factor out the injection routines
into the flic ("s390x/flic: factor out injection of floating interrupts").
Basic testing didn't reveal any problems so far.

With this series I am now able to run fedora 26/27 and Ubuntu 17.10+ with
16 VCPUs (MTTCG) on a 8CPU host, doing a make -j16 in the guest. I got
nasty stalls in the guest beforehand.

Now also included: More flic related caching to avoid recurring
conversions.

Available at: https://github.com/davidhildenbrand/qemu.git s390x-queue

v2 -> v3:
 - "s390x: fix size + content of STSI blocks"
  - CamelCase the structs/typedefs
 - "s390x/tcg: simplify machine check handling"
  - Fix wrong assert

David Hildenbrand (18):
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

 configure                    |   1 +
 hw/intc/s390_flic.c          | 257 +++++++++++++++++++++++++++++++++++++++--
 hw/intc/s390_flic_kvm.c      |  84 +++++++++++---
 hw/s390x/css.c               |  10 +-
 hw/s390x/s390-virtio-ccw.c   |   4 -
 hw/s390x/virtio-ccw.c        |   4 +-
 include/hw/s390x/s390_flic.h |  57 ++++++++--
 target/s390x/cpu.c           |  10 --
 target/s390x/cpu.h           |  99 ++++++++--------
 target/s390x/excp_helper.c   | 147 +++++++++---------------
 target/s390x/helper.h        |   1 +
 target/s390x/insn-data.def   |   1 +
 target/s390x/internal.h      |   5 -
 target/s390x/interrupt.c     | 100 ++++------------
 target/s390x/kvm-stub.c      |  13 ---
 target/s390x/kvm.c           |  70 +-----------
 target/s390x/kvm_s390x.h     |  10 +-
 target/s390x/misc_helper.c   | 266 +++++++++++++++++++++++++++----------------
 target/s390x/translate.c     |   8 ++
 19 files changed, 680 insertions(+), 467 deletions(-)

-- 
2.14.3
