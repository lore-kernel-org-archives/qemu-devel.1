Received: from eggs.gnu.org ([2001:4830:134:3::10]:37710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tbv-0002Ee-W0
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tbs-0007iW-RS
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tbs-0007i9-IF
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:14 -0300
Message-Id: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/29] x86 and machine queue, 2017-05-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>

The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887bb:

  Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into staging (2017-05-09 15:49:14 -0400)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to 08b277ac46da8b02e50cec455eca7cb2d12ffcf0:

  migration/i386: Remove support for pre-0.12 formats (2017-05-11 16:08:51 -0300)

----------------------------------------------------------------
x86 and machine queue, 2017-05-11

Highlights:
* New "-numa cpu" option
* NUMA distance configuration
* migration/i386 vmstatification

----------------------------------------------------------------

Daniel P. Berrange (1):
  i386: rewrite way CPUID index is validated

Dr. David Alan Gilbert (3):
  migration/i386: Remove old non-softfloat 64bit FP support
  vmstatification: i386 FPReg
  migration/i386: Remove support for pre-0.12 formats

He Chen (2):
  numa: Allow setting NUMA distance for different NUMA nodes
  tests: acpi: extend cphp and memhp testcase with numa distance check

Igor Mammedov (22):
  tests: add CPUs to numa node mapping test
  hw/arm/virt: extract mp-affinity calculation in separate function
  hw/arm/virt: use machine->possible_cpus for storing possible topology
    info
  hw/arm/virt: explicitly allocate cpu_index for cpus
  numa: move source of default CPUs to NUMA node mapping into boards
  spapr: add node-id property to sPAPR core
  pc: add node-id property to CPU
  virt-arm: add node-id property to CPU
  numa: add check that board supports cpu_index to node mapping
  numa: mirror cpu to node mapping in MachineState::possible_cpus
  numa: do default mapping based on possible_cpus instead of node_cpu
    bitmaps
  pc: get numa node mapping from possible_cpus instead of
    numa_get_node_for_cpu()
  spapr: get numa node mapping from possible_cpus instead of
    numa_get_node_for_cpu()
  virt-arm: get numa node mapping from possible_cpus instead of
    numa_get_node_for_cpu()
  QMP: include CpuInstanceProperties into query_cpus output output
  tests: numa: add case for QMP command query-cpus
  numa: remove no longer need numa_post_machine_init()
  machine: call machine init from wrapper
  numa: use possible_cpus for not mapped CPUs check
  numa: remove node_cpu bitmaps as they are no longer used
  numa: add '-numa cpu,...' option for property based node mapping
  tests: check -numa node,cpu=props_list usecase

Laurent Vivier (1):
  numa: equally distribute memory on nodes

 qapi-schema.json                    |  53 ++++++-
 include/hw/acpi/aml-build.h         |   1 +
 include/hw/boards.h                 |  14 +-
 include/hw/ppc/spapr_cpu_core.h     |   1 +
 include/qemu/typedefs.h             |   1 +
 include/qom/cpu.h                   |   2 +
 include/sysemu/numa.h               |  18 +--
 include/sysemu/sysemu.h             |   4 +
 target/arm/cpu.h                    |   2 +
 cpus.c                              |  10 ++
 hw/acpi/aml-build.c                 |  26 ++++
 hw/acpi/cpu.c                       |   7 +-
 hw/arm/virt-acpi-build.c            |  19 +--
 hw/arm/virt.c                       | 123 ++++++++++++---
 hw/core/machine.c                   | 162 +++++++++++++++++++
 hw/i386/acpi-build.c                |  15 +-
 hw/i386/pc.c                        |  54 +++++--
 hw/i386/pc_piix.c                   |   2 +
 hw/i386/pc_q35.c                    |   2 +
 hw/ppc/spapr.c                      |  46 +++++-
 hw/ppc/spapr_cpu_core.c             |  21 +--
 numa.c                              | 302 ++++++++++++++++++++++++------------
 target/arm/cpu.c                    |  13 +-
 target/i386/cpu.c                   |  36 ++---
 target/i386/machine.c               | 266 ++++++++-----------------------
 tests/bios-tables-test.c            |  16 +-
 tests/numa-test.c                   | 302 ++++++++++++++++++++++++++++++++++++
 vl.c                                |   6 +-
 qemu-options.hx                     |  36 ++++-
 tests/Makefile.include              |   5 +
 tests/acpi-test-data/pc/SLIT.cphp   | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SLIT.memhp  | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SRAT.memhp  | Bin 224 -> 264 bytes
 tests/acpi-test-data/q35/SLIT.cphp  | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SLIT.memhp | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SRAT.memhp | Bin 224 -> 264 bytes
 36 files changed, 1146 insertions(+), 419 deletions(-)
 create mode 100644 tests/numa-test.c
 create mode 100644 tests/acpi-test-data/pc/SLIT.cphp
 create mode 100644 tests/acpi-test-data/pc/SLIT.memhp
 create mode 100644 tests/acpi-test-data/q35/SLIT.cphp
 create mode 100644 tests/acpi-test-data/q35/SLIT.memhp

-- 
2.11.0.259.g40922b1
