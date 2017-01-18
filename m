Received: from eggs.gnu.org ([2001:4830:134:3::10]:56718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnk-0001sf-K9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnj-0007Bi-BF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtnj-0007BS-2a
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:35 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:16 +0100
Message-Id: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 00/13] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>


Series introduces a new CLI option to allow mapping cpus to numa
nodes using public properties [socket|core|thread]-ids instead of
internal cpu-index and moving cpu<->node mapping from global bitmaps
to PCMachineState struct.

It focuses on PC in RFC version to see if approach is suitable in general,
later we can move generic parts to common code or do a bigger non RFC
version of this series that would take care of all concerned targets
(arm-virt/spapr/pc).
Thing which I've kept PC specific but could be generalized is:
  * moving array possible_cpus to generic MachineState where
    we already have possible_cpu_arch_ids(). I plan to reuse it
    in virt-arm for CPU hotplug/-device cpu support and as this series
    shows it also could be used for numa mapping.
    Perhaps it could be used in simmilar manner for core based SPAPR
    but I haven't looked it yet. So any opions on if we should move it there.

So far it only provides CLI interface to do mapping, there is no QMP
one as I haven't found a suitable place/way to update/set mapping
after machine_done for QEMU started with -S (stoppod mode) so that
mgmt could query hopluggable-cpus first, then map them to numa nodes
in runtime before actually allowing guest to run.
Any suggestions on how to make it work are welcome.

PS:
skipped travis-ci build as currently it seems to be broken.

CC: Dou Liyang <douly.fnst@cn.fujitsu.com>
CC: fanc.fnst@cn.fujitsu.com
CC: caoj.fnst@cn.fujitsu.com
CC: stefanha@redhat.com
CC: izumi.taku@jp.fujitsu.com
CC: vilanova@ac.upc.edu
CC: ehabkost@redhat.com
CC: peter.maydell@linaro.org
CC: Andrew Jones <drjones@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Thomas Huth <thuth@redhat.com>

Igor Mammedov (13):
  numa: access CPU's node id via property in hmp_info_numa()
  pc: cleanup: move smbios_set_cpuid() into pc_build_smbios()
  pc: don't return cpu pointer from pc_new_cpu() as it's not needed
    anymore
  make possible_cpu_arch_ids() return const pointer
  pc: move pcms->possible_cpus init out of pc_cpus_init()
  pc: calculate topology only once when possible_cpus is initialised
  pc: pass apic_id to pc_find_cpu_slot() directly so lookup could be
    done without CPU object
  pc: add writeonly 'cpu' property to PCMachine
  numa: introduce '-numa cpu' cpu option
  numa: replace cpu_index_to_socket_id() with
    cpu_index_to_instance_props()
  numa: use new machine.cpu property with -numa cpus=... CLI
  pc: drop usage of legacy numa_get_node_for_cpu()
  pc: cpu: make sure that cpu.node-id matches -numa mapping

 include/hw/acpi/acpi_dev_interface.h |   2 +-
 include/hw/boards.h                  |  14 ++-
 include/hw/i386/pc.h                 |   2 +-
 include/qom/cpu.h                    |   2 -
 include/sysemu/numa.h                |   3 +-
 target/arm/cpu.h                     |   2 +
 target/i386/cpu.h                    |   1 +
 target/ppc/cpu.h                     |   2 +
 hw/acpi/cpu.c                        |  13 +--
 hw/acpi/cpu_hotplug.c                |   4 +-
 hw/arm/virt.c                        |  12 +-
 hw/i386/acpi-build.c                 |  25 ++---
 hw/i386/pc.c                         | 210 +++++++++++++++++++++++------------
 hw/ppc/spapr.c                       |  15 ++-
 hw/ppc/spapr_cpu_core.c              |   2 +-
 monitor.c                            |   7 +-
 numa.c                               |  89 +++++++++++----
 qapi-schema.json                     |   3 +-
 stubs/pc_madt_cpu_entry.c            |   2 +-
 target/arm/cpu.c                     |   1 +
 target/i386/cpu.c                    |   1 +
 target/ppc/translate_init.c          |   1 +
 vl.c                                 |   4 +-
 23 files changed, 269 insertions(+), 148 deletions(-)

-- 
2.7.4
