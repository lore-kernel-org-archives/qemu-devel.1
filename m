Received: from eggs.gnu.org ([2001:4830:134:3::10]:33776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRgm-0004iT-K1
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRgj-0002zq-Cr
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:27:52 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Nov 2017 17:27:28 +0100
Message-Id: <20171130162744.25442-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 00/16] s390x/tcg: cleanup and fix
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

I have quite some patches on my queue for 2.12. (booting Fedora 26/27
guests, floating interrupts, machine checks, missing instructions ...)

So let's start slowly  This series gets rid of program_interrupt() and
potential_page_fault(). We now always properly restore the cpu state when
injecting/delivering a program interrupt. So there is no need to update
the state via potential_page_fault() anymore.

In addition, handling for program interrupts comming via
s390_cpu_virt_mem_rw() was missing something for the TCG case. Also fixed.

v2 -> v3:
- "s390x/tcg: don't exit the cpu loop in s390_cpu_virt_mem_rw()"
--  don't break old KVM
- Unfortunately not able to come up with a better solution for
  "s390x: handle exceptions during s390_cpu_virt_mem_rw() correctly (TCG)"
  so I assume we'll go with this for now.

v1 -> v2:
- renamed program_interrupt_ra() to s390_program_interrupt()
- introduce and use RA_IGNORED for KVM.
- switch to cpu_exit_loop_restore() and don't check if ra is set
- "s390x: handle exceptions during s390_cpu_virt_mem_rw() correctly (TCG)"
 -> split out "s390x/tcg: don't exit the cpu loop in s390_cpu_virt_mem_rw()"
- "s390x/tcg: use program_interrupt_ra() in SCLP Service Call"
 -> moved qemu_mutex_lock_iothread(); further up
- "s390x/tcg: drop program_interrupt()"
 -> move restore to tcg_s390_program_interrupt() via cpu_loop_exit_restore()
- smaller requested cleanups

David Hildenbrand (16):
  s390x/tcg: introduce and use s390_program_interrupt()
  s390x/tcg: get rid of runtime_exception()
  s390x/tcg: rip out dead tpi code
  s390x/ioinst: pass the retaddr to all IO instructions
  s390x/pci: pass the retaddr to all PCI instructions
  s390x/diag: pass the retaddr into handle_diag_308()
  s390x: handle exceptions during s390_cpu_virt_mem_rw() correctly (TCG)
  s390x/tcg: don't exit the cpu loop in s390_cpu_virt_mem_rw()
  s390x/tcg: io instructions don't need potential_page_fault()
  s390x/tcg: use s390_program_interrupt() in SCLP Service Call
  s390x/tcg: use s390_program_interrupt() in DIAG
  s390x/tcg: use s390_program_interrupt() in per_check_exception()
  s390x/tcg: use s390_program_interrupt() in SACF
  s390x/tcg: use s390_program_interrupt() in STSI
  s390x/tcg: drop program_interrupt()
  s390x/tcg: drop potential_page_fault()

 hw/s390x/css.c               |   6 ---
 hw/s390x/s390-pci-inst.c     |  90 +++++++++++++++++++---------------
 hw/s390x/s390-pci-inst.h     |  16 +++---
 include/hw/s390x/css.h       |   1 -
 target/s390x/cc_helper.c     |   2 +-
 target/s390x/cpu.h           |   5 +-
 target/s390x/crypto_helper.c |   7 +--
 target/s390x/diag.c          |  14 +++---
 target/s390x/excp_helper.c   |   5 +-
 target/s390x/fpu_helper.c    |   2 +-
 target/s390x/int_helper.c    |  14 +++---
 target/s390x/internal.h      |  35 +++++++-------
 target/s390x/interrupt.c     |   9 ++--
 target/s390x/ioinst.c        | 113 +++++++++++++++++++------------------------
 target/s390x/kvm.c           |  43 ++++++++--------
 target/s390x/mem_helper.c    |  35 +++++---------
 target/s390x/misc_helper.c   |  52 +++++++-------------
 target/s390x/mmu_helper.c    |  23 +++++++--
 target/s390x/translate.c     |  27 +----------
 19 files changed, 228 insertions(+), 271 deletions(-)

-- 
2.14.3
