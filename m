Received: from eggs.gnu.org ([2001:4830:134:3::10]:48840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQXE-0003sm-VM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQX9-0007fx-U8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drQX9-0007eB-KY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:21:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 17:21:29 +0200
Message-Id: <20170911152150.12535-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/21] s390x cleanups and CPU hotplug via
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
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

The first patches are a bunch of cleanups. I decided to go the
extra mile and implement CPU hotplug via "device_add", as well as
"query-hotpluggable-cpus".

On s390x, only complete cores can be plugged. CPU hot unplug is currently
not supported by the architecture.

Support for hotplugging CPUs in random core-id order (last two patches)
is added. We once hat a KVM bug preventing this, but the stable patch
should now be included in relevant places - 152e9f65d66f ("KVM: s390: fix
wrong lookup of VCPUs by array index"). Current tooling will plug them in
sequential order anyway, so it should not hurt.


v3 -> v4:
* Dropped "target/s390x: move typedef of S390CPU to its definition"
* Added "target/s390x: move some s390x typedefs to cpu-qom.h"
 - this moves some typedefs and makes cpu-qom.h independent from
   cpu_models.h. This is necessary to cleanly use cpu-qom.h in sclp.c
   later.
* "s390x: move sclp_service_call() to sclp.h"
 - Use cpu-qom.h now as a s390x replacement for typedefs.h
* "target/s390x: use "core-id" for cpu number/address/id handling"
 - Indicate also in error messages the property name "core-id". So just
   the error messages were touched.


David Hildenbrand (21):
  exec,dump,i386,ppc,s390x: don't include exec/cpu-all.h explicitly
  cpu: drop old comments describing members
  s390x: get rid of s390-virtio.c
  s390x: rename s390-virtio.h to s390-virtio-hcall.h
  s390x: move s390_virtio_hypercall() to s390-virtio-hcall.h
  s390x: move subsystem_reset() to s390-virtio-ccw.h
  target/s390x: move some s390x typedefs to cpu-qom.h
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
 target/s390x/cpu-qom.h             |   7 +-
 target/s390x/cpu.c                 | 102 ++++++---------
 target/s390x/cpu.h                 |  18 +--
 target/s390x/cpu_models.c          |  58 ++++++---
 target/s390x/cpu_models.h          |   8 +-
 target/s390x/diag.c                |   1 +
 target/s390x/excp_helper.c         |   5 +-
 target/s390x/helper.c              |  47 +------
 target/s390x/internal.h            |   1 -
 target/s390x/kvm.c                 |   1 +
 target/s390x/misc_helper.c         |  21 ++--
 target/s390x/translate.c           |   5 +-
 30 files changed, 410 insertions(+), 272 deletions(-)
 create mode 100644 hw/s390x/s390-virtio-hcall.h
 delete mode 100644 hw/s390x/s390-virtio.h

-- 
2.13.5
