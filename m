Received: from eggs.gnu.org ([2001:4830:134:3::10]:43335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1flT6Z-0003HX-OK
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 01:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1flT6W-00052X-Mx
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 01:58:27 -0400
References: <20180801131905.148778-3-frankja@linux.ibm.com>
	<20180802070201.257406-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ba21a203-d95b-b42d-3be2-38878df2ccb6@redhat.com>
Date: Fri, 3 Aug 2018 07:58:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180802070201.257406-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5] s390x: Enable KVM huge
 page backing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com

On 08/02/2018 09:02 AM, Janosch Frank wrote:
> QEMU has had huge page support for a longer time already, but KVM
> memory management under s390x needed some changes to work with huge
> backings.
> 
> Now that we have support, let's enable it if requested and
> available. Otherwise we now properly tell the user if there is no
> support and back out instead of failing to run the VM later on.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Now featuring all of the required braces.
> 
> ---
>  target/s390x/kvm.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index d923cf4240..8ba948c324 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -34,6 +34,8 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "qemu/units.h"
> +#include "qemu/mmap-alloc.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/hw.h"
> @@ -139,6 +141,7 @@ static int cap_mem_op;
>  static int cap_s390_irq;
>  static int cap_ri;
>  static int cap_gs;
> +static int cap_hpage_1m;
>  
>  static int active_cmma;
>  
> @@ -220,9 +223,9 @@ static void kvm_s390_enable_cmma(void)
>          .attr = KVM_S390_VM_MEM_ENABLE_CMMA,
>      };
>  
> -    if (mem_path) {
> +    if (cap_hpage_1m) {
>          warn_report("CMM will not be enabled because it is not "
> -                    "compatible with hugetlbfs.");
> +                    "compatible with huge memory backings.");
>          return;
>      }
>      rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> @@ -281,10 +284,38 @@ void kvm_s390_crypto_reset(void)
>      }
>  }
>  
> +static int kvm_s390_configure_mempath_backing(KVMState *s)
> +{
> +    size_t path_psize = qemu_mempath_getpagesize(mem_path);
> +
> +    if (path_psize == 4 * KiB) {
> +        return 0;
> +    }
> +
> +    if (path_psize != 1 * MiB) {
> +        error_report("Memory backing with 2G pages was specified, "
> +                     "but KVM does not support this memory backing");
> +        return -EINVAL;
> +    }
> +
> +    if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
> +        error_report("Memory backing with 1M pages was specified, "
> +                     "but KVM does not support this memory backing");
> +        return -EINVAL;
> +    }
> +
> +    cap_hpage_1m = 1;
> +    return 0;
> +}
> +
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> +    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
> +        return -EINVAL;
> +    }
> +
>      mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
>      cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
>      cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);

Reviewed-by: Thomas Huth <thuth@redhat.com>
