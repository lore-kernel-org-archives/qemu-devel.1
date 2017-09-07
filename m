Received: from eggs.gnu.org ([2001:4830:134:3::10]:38748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3BN-0003zp-9a
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3BI-0001zr-Bh
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq3BI-0001z4-1o
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:13:44 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Sep 2017 22:13:14 +0200
Message-Id: <20170907201335.13956-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/21] s390x cleanups and CPU hotplug via
 device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

The first patches are a bunch of cleanups. I decided to go the
extra mile and implement CPU hotplug via "device_add", as well as
"query-hotpluggable-cpus".

On s390x, only complete cores can be plugged. CPU hot unplug is currently
not supported by the architecture.

In contrast to v2, this series now also adds support for hotplugging CPUs
in random core-id order (last two patches). We once hat a KVM bug
preventing this, but the stable patch should now be included in relevant
places - 152e9f65d66f ("KVM: s390: fix wrong lookup of VCPUs by array
index"). Current tooling will plug them in sequential order anyway, so
it should not hurt.

I am pretty sure now that this patch series won't grow even more :)


v2 -> v3:
* "exec,dump,i386,ppc,s390x: don't include exec/cpu-all.h explicitly"
 - dropped removal of one unrelated include
* "s390x: move subsystem_reset() to s390-virtio-ccw.h"
 - previously "s390x: move two function declarations to s390-virtio-ccw.h"
 - as Thomas requested, s390_cpu_addr2state() will be later moved to cpu.c
* "s390x: move sclp_service_call() to sclp.h"
 - previously "s390x: move sclp_service_call() to interrupt.c"
 - only move the declaration and make it compile
* "s390x: allow only 1 CPU with TCG"
 - switch to simple ifdef. Let's see what people think about this one :)
* "s390x: print CPU definitions in sorted order"
 - fix host model getting reported as static :(
* "s390x: CPU hot unplug via device_del cannot work"
 - use the term "currently" instead of "never"
* "s390x: implement query-hotpluggable-cpus"
 - as requested by Thomas, moving s390_cpu_addr2state() to cpu.c
* added "s390x: generate sclp cpu information from possible_cpus"
* added "s390x: allow CPU hotplug in random core-id order"


David Hildenbrand (21):
  exec,dump,i386,ppc,s390x: don't include exec/cpu-all.h explicitly
  cpu: drop old comments describing members
  s390x: get rid of s390-virtio.c
  s390x: rename s390-virtio.h to s390-virtio-hcall.h
  target/s390x: move typedef of S390CPU to its definition
  s390x: move s390_virtio_hypercall() to s390-virtio-hcall.h
  s390x: move subsystem_reset() to s390-virtio-ccw.h
  s390x: move sclp_service_call() to sclp.h
  target/s390x: use trigger_pgm_exception() in
    s390_cpu_handle_mmu_fault()
  target/s390x: use program_interrupt() in per_check_exception()
  s390x: allow only 1 CPU with TCG
  target/s390x: set cpu->id for linux user when realizing
  target/s390x: use "core-id" for cpu number/address/id handling
  target/s390x: rename next_cpu_id to next_core_id
  s390x: print CPU definitions in sorted order
  s390x: allow cpu hotplug via device_add
  s390x: CPU hot unplug via device_del cannot work for now
  s390x: implement query-hotpluggable-cpus
  s390x: get rid of cpu_s390x_create()
  s390x: generate sclp cpu information from possible_cpus
  s390x: allow CPU hotplug in random core-id order

 dump.c                             |   1 -
 exec.c                             |   1 -
 hw/s390x/Makefile.objs             |   1 -
 hw/s390x/s390-virtio-ccw.c         | 245 +++++++++++++++++++++++++++++++++++--
 hw/s390x/s390-virtio-hcall.c       |   2 +-
 hw/s390x/s390-virtio-hcall.h       |  21 ++++
 hw/s390x/s390-virtio.c             |  37 ------
 hw/s390x/s390-virtio.h             |  35 ------
 hw/s390x/sclp.c                    |  34 +++--
 include/hw/s390x/s390-virtio-ccw.h |   2 +
 include/hw/s390x/sclp.h            |   2 +
 include/qom/cpu.h                  |   6 +-
 qapi-schema.json                   |  16 +++
 target/i386/arch_dump.c            |   1 -
 target/i386/arch_memory_mapping.c  |   1 -
 target/i386/svm_helper.c           |   1 -
 target/ppc/arch_dump.c             |   1 -
 target/s390x/arch_dump.c           |   1 -
 target/s390x/cpu-qom.h             |   4 +-
 target/s390x/cpu.c                 | 101 ++++++---------
 target/s390x/cpu.h                 |  17 +--
 target/s390x/cpu_models.c          |  58 ++++++---
 target/s390x/diag.c                |   1 +
 target/s390x/excp_helper.c         |   5 +-
 target/s390x/helper.c              |  47 +------
 target/s390x/internal.h            |   1 -
 target/s390x/kvm.c                 |   1 +
 target/s390x/misc_helper.c         |  21 ++--
 target/s390x/translate.c           |   5 +-
 29 files changed, 400 insertions(+), 269 deletions(-)
 create mode 100644 hw/s390x/s390-virtio-hcall.h
 delete mode 100644 hw/s390x/s390-virtio.h

-- 
2.13.5
