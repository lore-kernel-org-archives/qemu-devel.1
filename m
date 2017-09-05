Received: from eggs.gnu.org ([2001:4830:134:3::10]:58273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dp8dx-0005TN-2U
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dp8ds-000756-AR
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:51:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59004
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dp8ds-00074n-4F
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:51:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v857nCkV089286
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 03:51:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cshw8fh4t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 03:51:26 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 5 Sep 2017 08:51:24 +0100
References: <20170904154316.4148-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Sep 2017 09:51:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <67bc4b1b-d934-dff6-9ce6-f5f34c11c9ca@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/19] s390x cleanups and CPU hotplug
 via device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

I think we certainly want to have device_add as well (as long as the old
interface stays for a while).

Adding Matt. Can you have a look at the cpu hotplug bits?



On 09/04/2017 05:42 PM, David Hildenbrand wrote:
> The first patches are a bunch of cleanups. I decided to go the
> extra mile and implement CPU hotplug via "device_add", as well as
> "query-hotpluggable-cpus". So the last patches in this series differ
> to v1. I tried to stick as much as possible to x86.
> 
> On s390x, only complete cores can be plugged. Cores have to be plugged in
> the right order (core-id 0, 1, 2 ...). CPU hot unplug is not supported
> by the architecture.
> 
> In addition, we now also print the CPU model list in sorted order and allow
> only 1 CPU for TCG.
> 
> v1 -> v2:
> - "exec,dump,i386,ppc,s390x: don't include exec/cpu-all.h explicitly"
> -- added a few instances I missed
> - "s390x: get rid of s390-virtio.c"
> -- move everything in the first shot and clean the "cpu_states" stuff up
>    in later patches, when we have ms->possible_cpus.
> - Added "target/s390x: move typedef of S390CPU to its definition"
> - Added "s390x: move s390_virtio_hypercall() to s390-virtio-hcall.h"
> - Added "s390x: move two function declarations to s390-virtio-ccw.h"
> - Added "s390x: move sclp_service_call() to interrupt.c"
> - "target/s390x: use program_interrupt() in per_check_exception()"
> -- Add a comment describing my concern
> - "s390x: allow only 1 CPU with TCG"
> -- Add a #define to easily be able to change it (e.g. for development)
> - Added "target/s390x: set cpu->id for linux user when realizing"
> - "target/s390x: use "core-id" for cpu number/address/id handling"
> -- I now use "core-id" as property name, because that will be used by
>    device_add
> - "target/s390x: rename next_cpu_id to next_core_id"
> -- Also change to the term "core_id"
> - Added "s390x: print CPU definitions in sorted order"
> - Added "s390x: allow cpu hotplug via device_add"
> - Added "s390x: CPU hot unplug via device_del cannot work"
> - Added "s390x: implement query-hotpluggable-cpu"
> - Added "s390x: get rid of cpu_s390x_create()"
> 
> David Hildenbrand (19):
>   exec,dump,i386,ppc,s390x: don't include exec/cpu-all.h explicitly
>   cpu: drop old comments describing members
>   s390x: get rid of s390-virtio.c
>   s390x: rename s390-virtio.h to s390-virtio-hcall.h
>   target/s390x: move typedef of S390CPU to its definition
>   s390x: move s390_virtio_hypercall() to s390-virtio-hcall.h
>   s390x: move two function declarations to s390-virtio-ccw.h
>   s390x: move sclp_service_call() to interrupt.c
>   target/s390x: use trigger_pgm_exception() in
>     s390_cpu_handle_mmu_fault()
>   target/s390x: use program_interrupt() in per_check_exception()
>   s390x: allow only 1 CPU with TCG
>   target/s390x: set cpu->id for linux user when realizing
>   target/s390x: use "core-id" for cpu number/address/id handling
>   target/s390x: rename next_cpu_id to next_core_id
>   s390x: print CPU definitions in sorted order
>   s390x: allow cpu hotplug via device_add
>   s390x: CPU hot unplug via device_del cannot work
>   s390x: implement query-hotpluggable-cpus
>   s390x: get rid of cpu_s390x_create()
> 
>  dump.c                             |   1 -
>  exec.c                             |   2 -
>  hw/s390x/Makefile.objs             |   1 -
>  hw/s390x/s390-virtio-ccw.c         | 259 +++++++++++++++++++++++++++++++++++--
>  hw/s390x/s390-virtio-hcall.c       |   2 +-
>  hw/s390x/s390-virtio-hcall.h       |  21 +++
>  hw/s390x/s390-virtio.c             |  37 ------
>  hw/s390x/s390-virtio.h             |  35 -----
>  hw/s390x/sclp.c                    |  51 +-------
>  include/hw/s390x/s390-virtio-ccw.h |   3 +
>  include/hw/s390x/sclp.h            |   1 +
>  include/qom/cpu.h                  |   6 +-
>  qapi-schema.json                   |  16 +++
>  target/i386/arch_dump.c            |   1 -
>  target/i386/arch_memory_mapping.c  |   1 -
>  target/i386/svm_helper.c           |   1 -
>  target/ppc/arch_dump.c             |   1 -
>  target/s390x/arch_dump.c           |   1 -
>  target/s390x/cpu-qom.h             |   4 +-
>  target/s390x/cpu.c                 |  86 ++++--------
>  target/s390x/cpu.h                 |  19 +--
>  target/s390x/cpu_models.c          |  65 ++++++----
>  target/s390x/diag.c                |   1 +
>  target/s390x/excp_helper.c         |   5 +-
>  target/s390x/helper.c              |  47 +------
>  target/s390x/internal.h            |   1 -
>  target/s390x/interrupt.c           |  52 ++++++++
>  target/s390x/kvm.c                 |   3 +-
>  target/s390x/misc_helper.c         |  22 ++--
>  target/s390x/translate.c           |   5 +-
>  30 files changed, 443 insertions(+), 307 deletions(-)
>  create mode 100644 hw/s390x/s390-virtio-hcall.h
>  delete mode 100644 hw/s390x/s390-virtio.h
> 
