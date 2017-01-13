Received: from eggs.gnu.org ([2001:4830:134:3::10]:52984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvLr-0005sq-Kj
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvLq-0001tk-QE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:39 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:06 +1100
Message-Id: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 00/17] target/ppc: Implement POWER9 pseries
 tcg legacy kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This patch set provides the initial implementation of support for the 
POWER9 processor running in tcg mode under the pseries machine type.

To use a POWER9 cpu provide the command line option "-cpu POWER9".

This is the initial work to make the mmu emulation model look like a POWER9

Currently only legacy kernels are supported (hash without segment tables).

This patch set will be followed by two more in the near future to support
the new process table capabilities added in ISAv3.00; hash via segment
tables and radix. Kernels with support for this will currently fail when
they try to register a process table as this isn't yet implemented.

The assumption is that we're running a legacy kernel, in the event the
guest registers a process table (when support exists) we will handle it
accordingly.

The main changes are:
 - Define a new mmu model and fault handler
 - Add new LPCR fields and check them accordingly
 - Add a partition table entry to the machine state
 - Point to the partition table entry in the cpu state
 - Remove SDR1
 - Adapt to new pte format
 - NOOP the cp_abort instruction
 - Small bug fixes

This was intially one huge patch so I've tried to break it up into what I
think are logical chunks, how exactly this should be split up is up for 
debate.

A current upstream kernel with POWER9 support added to the architecture
vector should correctly report a POWER9 cpu under /proc/cpuinfo.

Suraj Jitindar Singh (17):
  powerpc/cpu-models: rename ISAv3.00 logical PVR definition
  hw/ppc/spapr: Add POWER9 to pseries cpu models
  target/ppc: Add pcr_supported to POWER9 cpu class definition
  target/ppc/POWER9: Add ISAv3.00 MMU definition
  target/ppc/POWER9: Adapt LPCR handling for POWER9
  target/ppc/POWER9: Direct all instr and data storage interrupts to the
    hypv
  target/ppc/POWER9: Add partition table pointer to sPAPRMachineState
  target/ppc/POWER9: Add external partition table pointer to cpu state
  target/ppc/POWER9: Remove SDR1 register
  target/ppc/POWER9: Add POWER9 mmu fault handler
  target/ppc/POWER9: Update to new pte format for POWER9 accesses
  target/ppc/POWER9: Add POWER9 pa-features definition
  target/ppc/POWER9: Add cpu_has_work function for POWER9
  target/ppc/debug: Print LPCR register value if register exists
  tcg/POWER9: NOOP the cp_abort instruction
  target/ppc/mmu_hash64: Fix printing unsigned as signed int
  target/ppc/mmu_hash64: Fix incorrect shift value in amr calculation

 hw/ppc/spapr.c              | 56 ++++++++++++++++++++++++---
 hw/ppc/spapr_cpu_core.c     | 15 +++++++-
 hw/ppc/spapr_hcall.c        | 51 +++++++++++++------------
 include/hw/ppc/spapr.h      |  1 +
 target/ppc/cpu-models.h     |  2 +-
 target/ppc/cpu-qom.h        |  5 ++-
 target/ppc/cpu.h            | 24 +++++++++++-
 target/ppc/kvm.c            | 10 ++++-
 target/ppc/mmu-hash64.c     | 68 +++++++++++++++++++++++++++------
 target/ppc/mmu-hash64.h     | 73 +++++++++++++++++++++++++----------
 target/ppc/mmu.h            | 27 +++++++++++++
 target/ppc/mmu_helper.c     | 61 ++++++++++++++++++++++++++++++
 target/ppc/translate.c      | 14 ++++++-
 target/ppc/translate_init.c | 92 +++++++++++++++++++++++++++++++++++++++------
 14 files changed, 418 insertions(+), 81 deletions(-)
 create mode 100644 target/ppc/mmu.h

-- 
2.5.5
