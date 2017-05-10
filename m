Received: from eggs.gnu.org ([2001:4830:134:3::10]:35157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8Pox-0007RB-NO
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8Pow-0001gH-Aa
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:19 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 10 May 2017 13:29:44 +0200
Message-Id: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/18] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

Changes since v2:
   * rebased on top of numa-next tree
   * add comment to spapr_cpu_index_to_props() explaining why
     cpu_index can't used as index in possible_cpus[] (Eduardo)
   * remove obsolete comment in parse_numa_opts() (Eduardo)
   * add to commit message of "pc: add node-id property to CPU"
     why changing CPUState::numa_node default is safe (Eduardo)
   * amend error msg to print:
      "NUMA is not supported by this machine-type" (Eduardo)
   * add comment documenting machine_set_cpu_numa_node() semantics (Eduardo)
   * assert if props->has_node_id == false (Eduardo)
   * drop numa_[has_]node_id() wrappers (ehabkost, dwg)
   * use qapi_NumaCpuOptions_base() instead of copying fields manually (Eduardo)
Changes since v1:
   * arm (Drew)
       - s/virt_idx2mp_affinity/virt_cpu_mp_affinity/
       - add arm_cpu_mp_affinity() to reduce code duplication
       - use cpu list returned by possible_cpu_arch_ids() instead of
         directly accessing MachineState::possible_cpus field
   * various checkpatch/cleanups/spelling fixes (Eric/Drew)
   * simplify spapr_cpu_index_to_props() (David)
   * add/use numa_[has_]node_id() wrappers (Drew)
   * use new NumaCpuOptions instead of CpuInstanceProperties
     in NumaOptions (Eduardo)
   * better documment NumaCpuOptions.node-id in qapi-schema.json (Eduardo)
Changes since RFC:
    * convert all targets that support numa (Eduardo)
    * add numa CLI tests
    * support wildcard matching with "-numa cpu,..." (Paolo)

Series introduces a new CLI option to allow mapping cpus to numa
nodes using public properties [socket|core|thread]-ids instead of
internal cpu_index and moving internal handling of cpu<->node
mapping from cpu_index based global bitmaps to MachineState.

New '-numa cpu' option is supported only on PC and SPAPR
machines that implement hotpluggable-cpus query.
ARM machine user-facing interface stays cpu_index based due to
lack of hotpluggable-cpus support, but internally cpu<->node
mapping will be using the common for PC/SPAPR/ARM approach
(i.e. store mapping info in MachineState:possible_cpus)

It only provides CLI interface to do mapping, there is no QMP
one as I haven't found a suitable place/way to update/set mapping
after machine_done for QEMU started with -S (stopped mode) so that
mgmt could query hopluggable-cpus first, then map them to numa nodes
in runtime before actually allowing guest to run.

Another alternative I've been considering is to add CLI option
similar to -S but that would pause initialization before machine_init()
callback is run so that user can get CPU layout with hopluggable-cpus,
then map CPUs to numa nodes and unpause to let machine_init() initialize
machine using previously predefined numa mapping.
Such option might also be useful for other usecases.


git repo for testing:
   https://github.com/imammedo/qemu.git cphp_numa_cfg_v3
reference to v2:
   http://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00526.html

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Andrew Jones <drjones@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Eric Blake <eblake@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Shannon Zhao <zhaoshenglong@huawei.com>
CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org

Igor Mammedov (18):
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

 include/hw/boards.h             |  12 ++-
 include/hw/ppc/spapr_cpu_core.h |   1 +
 include/qom/cpu.h               |   2 +
 include/sysemu/numa.h           |   9 +-
 cpus.c                          |  10 ++
 hw/acpi/cpu.c                   |   7 +-
 hw/arm/virt-acpi-build.c        |  19 ++--
 hw/arm/virt.c                   |  44 +++++++--
 hw/core/machine.c               | 160 ++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c            |  11 +--
 hw/i386/pc.c                    |  54 ++++++++---
 hw/ppc/spapr.c                  |  45 +++++++--
 hw/ppc/spapr_cpu_core.c         |  21 ++---
 numa.c                          | 150 ++++++++++--------------------
 qapi-schema.json                |  27 +++++-
 qemu-options.hx                 |  20 ++++
 target/arm/cpu.c                |   1 +
 target/i386/cpu.c               |   1 +
 tests/numa-test.c               | 196 ++++++++++++++++++++++++++++++++++++++++
 vl.c                            |   6 +-
 20 files changed, 618 insertions(+), 178 deletions(-)

-- 
2.7.4
