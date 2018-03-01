Received: from eggs.gnu.org ([2001:4830:134:3::10]:52045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erFMx-0000DT-4e
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 22:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erFMu-0007JS-3A
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 22:58:59 -0500
References: <20180228195320.165230-1-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <79f7059b-f2d3-a758-6bb9-29433b31b313@redhat.com>
Date: Thu, 1 Mar 2018 04:58:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180228195320.165230-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/kvm: implement clearing part of
 IPL clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 28.02.2018 20:53, Christian Borntraeger wrote:
> When a guests reboots with diagnose 308 subcode 3 it requests the memory
> to be cleared. We did not do it so far. This does not only violate the
> architecture, it also misses the chance to free up that memory on
> reboot, which would help on host memory over commitment.  By using
> ram_block_discard_range we can cover both cases.

Sounds like a good idea. I wonder whether that release_all_ram()
function should maybe rather reside in exec.c, so that other machines
that want to clear all RAM at reset time can use it, too?

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8f3a422288..2e145ad5c3 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -34,6 +34,8 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "qemu/rcu_queue.h"
> +#include "sysemu/cpus.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/boards.h"
> @@ -41,6 +43,7 @@
>  #include "sysemu/device_tree.h"
>  #include "exec/gdbstub.h"
>  #include "exec/address-spaces.h"
> +#include "exec/ram_addr.h"
>  #include "trace.h"
>  #include "qapi-event.h"
>  #include "hw/s390x/s390-pci-inst.h"
> @@ -1841,6 +1844,14 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
>      return ret;
>  }
>  
> +static void release_all_rams(void)

s/rams/ram/ maybe?

> +{
> +    struct RAMBlock *rb;
> +
> +    QLIST_FOREACH_RCU(rb, &ram_list.blocks, next)
> +        ram_block_discard_range(rb, 0, rb->used_length);

>From a coding style point of view, I think there should be curly braces
around ram_block_discard_range() ?

> +}
> +
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>  {
>      S390CPU *cpu = S390_CPU(cs);
> @@ -1853,6 +1864,14 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>              ret = handle_intercept(cpu);
>              break;
>          case KVM_EXIT_S390_RESET:
> +            if (run->s390_reset_flags & KVM_S390_RESET_CLEAR) {
> +                /*
> +                 * We will stop other CPUs anyway, avoid spurious crashes and
> +                 * get all CPUs out. The reset will take care of the resume.
> +                 */
> +                pause_all_vcpus();
> +                release_all_rams();
> +            }
>              s390_reipl_request();
>              break;
>          case KVM_EXIT_S390_TSCH:
> 

Apart from the cosmetic nits, patch looks good to me.

 Thomas
