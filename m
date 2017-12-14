Received: from eggs.gnu.org ([2001:4830:134:3::10]:53828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1Z-0007Yn-BS
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1V-0005zx-A1
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:21 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:18 +0100
Message-Id: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/46] First batch of s390x patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b6d:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' into staging (2017-12-14 15:32:32 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20171214

for you to fetch changes up to a9e3065c6579df8652ce38502276ac0a13180d6f:

  s390-ccw-virtio: allow for systems larger that 7.999TB (2017-12-14 17:56:54 +0100)

----------------------------------------------------------------
s390x changes for 2.12:
- Lots of tcg improvements: ccw hotplug is now working and we can run
  a Linux kernel built for z12 under tcg
- zPCI improvements to get virtio-pci working
- get rid of the cssid restrictions for virtual and non-virtual channel
  devices
- we now support 8TB+ systems
- 2.12 compat machine
- fixes and cleanups

----------------------------------------------------------------

Christian Borntraeger (3):
  s390x/migration: use zero flag parameter
  pc-bios/s390-ccw: zero out bss section
  s390-ccw-virtio: allow for systems larger that 7.999TB

Cornelia Huck (4):
  pc-bios/s390-ccw.img: update image
  s390x: introduce 2.12 compat machine
  target/s390x: nuke DPRINTF in helper.c
  s390x/css: attach css bridge

David Hildenbrand (30):
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
  s390x/kvm: factor out build_channel_report_mcic() into cpu.h
  s390x/tcg: fix and cleanup mcck injection
  s390x/tcg: implement SET CLOCK PROGRAMMABLE FIELD
  s390x/tcg: indicate value of TODPR in STCKE
  s390x/tcg: wire up STORE CHANNEL REPORT WORD
  s390x/tcg: ASI/ASGI/ALSI/ALSGI are atomic with Interlocked-acccess
    facility 1
  s390x/tcg: implement Interlocked-Access Facility 2
  s390x/tcg: wire up SET ADDRESS LIMIT
  s390x/tcg: wire up SET CHANNEL MONITOR
  s390x/tcg: Implement STORE CHANNEL PATH STATUS
  s390x/tcg: Implement SIGNAL ADAPTER instruction
  s390x/tcg: implement extract-CPU-time facility
  s390x/tcg: we already implement the Set-Program-Parameter facility
  s390x: change the QEMU cpu model to a stripped down z12

Halil Pasic (2):
  s390x/css: unrestrict cssids
  s390x: deprecate s390-squash-mcss machine prop

Pierre Morel (7):
  s390x/pci: factor out endianess conversion
  s390x/pci: rework PCI STORE
  s390x/pci: rework PCI LOAD
  s390x/pci: rework PCI STORE BLOCK
  s390x/pci: move the memory region read from pcilg
  s390x/pci: move the memory region write from pcistg
  s390x/pci: search for subregion inside the BARs

 hw/s390x/3270-ccw.c          |   2 +-
 hw/s390x/css-bridge.c        |  13 ++
 hw/s390x/css.c               |  34 +----
 hw/s390x/s390-ccw.c          |   2 +-
 hw/s390x/s390-pci-bus.h      |   1 +
 hw/s390x/s390-pci-inst.c     | 337 +++++++++++++++++++++++++------------------
 hw/s390x/s390-pci-inst.h     |  22 ++-
 hw/s390x/s390-virtio-ccw.c   |  58 +++++++-
 hw/s390x/virtio-ccw.c        |   2 +-
 include/hw/compat.h          |   3 +
 include/hw/s390x/css.h       |  13 +-
 pc-bios/s390-ccw.img         | Bin 26416 -> 26416 bytes
 pc-bios/s390-ccw/start.S     |  30 +++-
 qemu-doc.texi                |   8 +
 qemu-options.hx              |   8 +-
 target/s390x/cc_helper.c     |   2 +-
 target/s390x/cpu.h           |  31 +++-
 target/s390x/cpu_models.c    | 103 ++++++-------
 target/s390x/cpu_models.h    |   1 +
 target/s390x/crypto_helper.c |   7 +-
 target/s390x/diag.c          |  14 +-
 target/s390x/excp_helper.c   |  17 +--
 target/s390x/fpu_helper.c    |   2 +-
 target/s390x/gen-features.c  |  88 +++++++++++
 target/s390x/helper.c        |  18 ---
 target/s390x/helper.h        |   6 +-
 target/s390x/insn-data.def   |  29 ++--
 target/s390x/int_helper.c    |  14 +-
 target/s390x/internal.h      |  41 +++---
 target/s390x/interrupt.c     |   9 +-
 target/s390x/ioinst.c        | 113 +++++++--------
 target/s390x/kvm.c           |  84 ++++-------
 target/s390x/mem_helper.c    |  35 ++---
 target/s390x/misc_helper.c   | 111 ++++++++------
 target/s390x/mmu_helper.c    |  23 ++-
 target/s390x/translate.c     | 191 ++++++++++++++++++++----
 36 files changed, 927 insertions(+), 545 deletions(-)

-- 
2.13.6
