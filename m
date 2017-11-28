Received: from eggs.gnu.org ([2001:4830:134:3::10]:46246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJmZU-0000nq-9o
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJmZQ-0003Uy-Br
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:33:36 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 28 Nov 2017 21:33:10 +0100
Message-Id: <20171128203326.6062-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 00/15] s390x/tcg: cleanup and fix
 program interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

I have quite some patches on my queue for 2.12. (booting Fedora 26/27
guests, floating interrupts, machine checks, missing instructions ...)

So let's start slowly :) This series gets rid of program_interrupt() and
potential_page_fault(). We now always properly restore the cpu state when
injecting/delivering a program interrupt. So there is no need to update
the state via potential_page_fault() anymore.

In addition, handling for program interrupts comming via
s390_cpu_virt_mem_rw() was missing something for the TCG case. Also fixed.

David Hildenbrand (15):
  s390x/tcg: introduce and use program_interrupt_ra()
  s390x/tcg: get rid of runtime_exception()
  s390x/tcg: rip out dead tpi code
  s390x/ioinst: pass the retaddr to all IO instructions
  s390x/pci: pass the retaddr to all PCI instructions
  s390x/diag: pass the retaddr into handle_diag_308()
  s390x: handle exceptions during s390_cpu_virt_mem_rw() correctly (TCG)
  s390x/tcg: io instructions don't need potential_page_fault()
  s390x/tcg: use program_interrupt_ra() in SCLP Service Call
  s390x/tcg: use program_interrupt_ra() in DIAG
  s390x/tcg: use program_interrupt_ra() in per_check_exception()
  s390x/tcg: use program_interrupt_ra() in SACF
  s390x/tcg: use program_interrupt_ra() in STSI
  s390x/tcg: drop program_interrupt()
  s390x/tcg: drop potential_page_fault()

 hw/s390x/css.c               |   6 ---
 hw/s390x/s390-pci-inst.c     |  90 ++++++++++++++++++----------------
 hw/s390x/s390-pci-inst.h     |  16 ++++---
 include/hw/s390x/css.h       |   1 -
 target/s390x/cc_helper.c     |   2 +-
 target/s390x/cpu.h           |   4 +-
 target/s390x/crypto_helper.c |   7 +--
 target/s390x/diag.c          |  14 +++---
 target/s390x/excp_helper.c   |   5 +-
 target/s390x/fpu_helper.c    |   2 +-
 target/s390x/int_helper.c    |  14 +++---
 target/s390x/internal.h      |  35 +++++++-------
 target/s390x/interrupt.c     |   9 +++-
 target/s390x/ioinst.c        | 112 ++++++++++++++++++++-----------------------
 target/s390x/kvm.c           |  42 ++++++++--------
 target/s390x/mem_helper.c    |  35 +++++---------
 target/s390x/misc_helper.c   |  50 +++++++------------
 target/s390x/mmu_helper.c    |  19 +++++++-
 target/s390x/translate.c     |  27 +----------
 19 files changed, 226 insertions(+), 264 deletions(-)

-- 
2.14.3
