Received: from eggs.gnu.org ([2001:4830:134:3::10]:50838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgRxj-0003d9-Tk
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgRxf-0006fl-26
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:44:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgRxe-0006eh-SV
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:44:30 -0400
Date: Fri, 20 Jul 2018 17:44:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720094423.GC16910@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-16-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-16-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 15/17] kvm: add vCPU failed memeory
 access processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:58PM +0300, Denis Plotnikov wrote:
> Is done with support of the KVM patch returning the faulting address.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

I feel like these two kvm-related patches can be put at the end of the
series as an extension to kvm support.  E.g., without these kvm
patches one should still be able to do live snapshot with TCG.  Then
even if your KVM patches are not settled (along with the header
update) there's still chance that your framework can be merged first.

> ---
>  target/i386/kvm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3ac5302bc5..55b8860d1a 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -45,6 +45,8 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "migration/blocker.h"
> +#include "migration/savevm.h"
> +#include "migration/ram.h"
>  #include "exec/memattrs.h"
>  #include "trace.h"
>  
> @@ -3130,6 +3132,18 @@ static bool host_supports_vmx(void)
>      return ecx & CPUID_EXT_VMX;
>  }
>  
> +static int kvm_handle_fail_mem_access(CPUState *cpu)
> +{
> +    struct kvm_run *run = cpu->kvm_run;
> +    int ret = ram_process_page_fault((void *)run->fail_mem_access.hva);
> +
> +    if (ret >= 0) {
> +        cpu_resume(cpu);
> +    }
> +
> +    return ret;
> +}
> +
>  #define VMX_INVALID_GUEST_STATE 0x80000021
>  
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> @@ -3188,6 +3202,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>          ioapic_eoi_broadcast(run->eoi.vector);
>          ret = 0;
>          break;
> +    case KVM_EXIT_FAIL_MEM_ACCESS:
> +        ret = kvm_handle_fail_mem_access(cs);
> +        break;
>      default:
>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>          ret = -1;
> -- 
> 2.17.0
> 
> 

Regards,

-- 
Peter Xu
