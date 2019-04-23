Received: from eggs.gnu.org ([209.51.188.92]:34119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hIq8V-0001iS-2O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hIq8U-0002qV-1y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:31624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hIq8T-0002nl-PA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:38 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Tue, 23 Apr 2019 15:44:25 +0800
Message-Id: <20190423074428.23031-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/3] numa: move numa global variables into
 MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com
Cc: tao3.xu@intel.com, jingqi.liu@intel.com, qemu-devel@nongnu.org

The aim of this patch is to add struct NumaState in MachineState
and move existing numa global nb_numa_nodes into NumaState.
And add variable numa_support into MachineClass to decide which
submachines support NUMA.

---
Changes in v3 -> v2:
    - rename the "NumaState::nb_numa_nodes" as "NumaState::num_nodes",
    and rename the "NumaState::numa_info" as "NumaState::nodes" (Eduardo)
    - use machine_num_numa_nodes(MachineState *ms) to check if
    ms->numa_state is NULL before using NumaState::num_nodes (Eduardo)
    - check if ms->numa_state == NULL in the set_numa_options to avoid
    using -numa in a machine-type which don't support numa

Changes in v2:
    - fix the mistake in numa_complete_configuration in numa.c
    - add MachineState into some functions to avoid using
    qdev_get_machine
    - add some if experssion to avoid the NumaState is null

Tao Xu (3):
  numa: move numa global variable nb_numa_nodes into MachineState
  numa: move numa global variable have_numa_distance into MachineState
  numa: move numa global variable numa_info into MachineState

 exec.c                              |  5 +-
 hw/acpi/aml-build.c                 |  9 ++--
 hw/arm/boot.c                       |  4 +-
 hw/arm/virt-acpi-build.c            | 17 ++++---
 hw/arm/virt.c                       |  8 +++-
 hw/core/machine.c                   | 21 ++++++--
 hw/i386/acpi-build.c                |  4 +-
 hw/i386/pc.c                        | 11 +++--
 hw/mem/pc-dimm.c                    |  2 +
 hw/pci-bridge/pci_expander_bridge.c |  2 +
 hw/ppc/spapr.c                      | 25 ++++++++--
 hw/ppc/spapr_pci.c                  |  2 +
 include/hw/acpi/aml-build.h         |  2 +-
 include/hw/boards.h                 | 22 +++++++++
 include/sysemu/numa.h               | 13 +----
 monitor.c                           |  4 +-
 numa.c                              | 74 +++++++++++++++++------------
 17 files changed, 155 insertions(+), 70 deletions(-)

-- 
2.17.1
