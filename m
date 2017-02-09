Received: from eggs.gnu.org ([2001:4830:134:3::10]:35796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbmak-0001cU-Ga
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbmah-0003zt-Aw
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:46 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  9 Feb 2017 12:08:31 +0100
Message-Id: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] pc/spapr: unify handling of possible CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, ehabkost@redhat.com, drjones@redhat.com, Marcel Apfelbaum <marcel@redhat.com>


Series is prerequsite split of from NUMA cpu mapping
refactoring and includes only possible_cpus[] generalization
to make it reusable for SPAPR and virt-arm targets as
has been requested by Eduardo [1].

Since virt-arm doesn't support -device based CPUs, ARM
patches are not included here and will be posted separately as
 'hw/arm/virt: -device cpu support'
series with dependency on this series.

This series doesn't include any of NUMA refactoring patches,
which will be posted on top once SPAPR and virt-arm would use
possible_cpus[].

Hence goal of this series is to make x86 specific possible_cpus[]
more generic, move it to MachineState and reuse it in SPAPR
machine so we could use it as common storage for topology
information when parsing -smp/-numa and then follow
the same/similar CPU creation pattern across the affected targets.

As result of this series:
  * possible_cpus[] becomes part of MachineState
  * SPAPR machine reuses it for persistent topololy storage
    and core bookkeeping
  * target specific query_hotpluggable_cpus() callbacks are
    generalized into common machine_query_hotpluggable_cpus()

Series depends on:
  [PATCH 0/3] spapr: fix cpu core hotunplug call flow
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg427214.html
which is staged for next pull req in SPAPR tree.

git tree for testing:
  git@github.com:imammedo/qemu.git unify_poissible_cpus_v1

Regression tested CPU hotplug with ppc fedora25 guest on ppc host
with kvm enabled.

 1) "[RFC 00/13] numa: add '-numa cpu' option"
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg423883.html

CC: David Gibson <david@gibson.dropbear.id.au> (supporter:sPAPR)
CC: Alexander Graf <agraf@suse.de> (supporter:sPAPR)
CC: qemu-ppc@nongnu.org 
CC: Bharata B Rao <bharata@linux.vnet.ibm.com>
CC: ehabkost@redhat.com
CC: drjones@redhat.com
CC: Marcel Apfelbaum <marcel@redhat.com>


Igor Mammedov (7):
  machine: move possible_cpus to MachineState
  pc: move pcms->possible_cpus init out of pc_cpus_init()
  pc: calculate topology only once when possible_cpus is initialised
  pc: pass apic_id to pc_find_cpu_slot() directly so lookup could be
    done without CPU object
  change CPUArchId.cpu type to Object*
  spapr: reuse machine->possible_cpus instead of cores[]
  machine: unify [pc_|spapr_]query_hotpluggable_cpus() callbacks

 include/hw/boards.h    |   8 +++-
 include/hw/i386/pc.h   |   1 -
 include/hw/ppc/spapr.h |   1 -
 hw/acpi/cpu.c          |   2 +-
 hw/core/machine.c      |  31 +++++++++++++
 hw/i386/pc.c           | 124 +++++++++++++++++++++----------------------------
 hw/ppc/spapr.c         | 117 +++++++++++++++++++++++++++-------------------
 7 files changed, 162 insertions(+), 122 deletions(-)

-- 
2.7.4
