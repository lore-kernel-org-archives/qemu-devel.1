Received: from eggs.gnu.org ([2001:4830:134:3::10]:59534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkUMR-00017O-5P
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkUML-0001Oe-6W
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:06:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fkUML-0001OI-0c
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:06:41 -0400
Date: Tue, 31 Jul 2018 15:06:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180731150636.6ecc8850.cohuck@redhat.com>
In-Reply-To: <20180731120908.9202-3-frankja@linux.ibm.com>
References: <20180731120908.9202-1-frankja@linux.ibm.com>
	<20180731120908.9202-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, david@redhat.com

On Tue, 31 Jul 2018 13:09:08 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> QEMU has had huge page support for a longer time already, but KVM
> memory management under s390x needed some changes to work with huge
> backings.
> 
> Now that we have support, let's enable it if requested and
> available. Otherwise we now properly tell the user if there is no
> support and back out instead of failing to run the VM later on.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index d923cf4240..f961c3b84a 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -34,6 +34,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "qemu/mmap-alloc.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/hw.h"
> @@ -285,6 +286,20 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> +    if (mem_path) {
> +        if (qemu_mempath_getpagesize(mem_path) != (1 << 20)) {

1 * MiB ?

> +            error_report("Huge page backing with pages > 1M was specified, "
> +                         "but KVM does not support this memory backing");
> +            return -EINVAL;
> +
> +        }
> +        if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
> +            error_report("Huge page backing with 1M pages was specified, "
> +                         "but KVM does not support this memory backing");
> +            return -EINVAL;
> +        }
> +    }
> +
>      mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
>      cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
>      cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
