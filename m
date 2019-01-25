Received: from eggs.gnu.org ([209.51.188.92]:35226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmwWd-000413-Pt
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmwSx-0001Yq-Rf
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:03:56 -0500
References: <1548349076-350255-1-git-send-email-imammedo@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3b4eef57-dc27-356e-5487-0b9b53a75cb1@redhat.com>
Date: Fri, 25 Jan 2019 09:03:49 +0100
MIME-Version: 1.0
In-Reply-To: <1548349076-350255-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: remove direct reference to mem_path
 global form s90x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, cohuck@redhat.com, borntraeger@de.ibm.com, rth@twiddle.net, qemu-s390x@nongnu.org

On 24.01.19 17:57, Igor Mammedov wrote:
> I plan to deprecate -mem-path option and replace it with memory-backend,
> for that it's necessary to get rid of mem_path global variable.
> Do it for s390x case, replacing it with alternative way to enable
> 1Mb hugepages capability.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS:
> Original code nor the new one probably is not entirely correct when
> huge pages are enabled in case where mixed initial RAM and memory
> backends are used, backend's page size might not match initial RAM's
> so I'm not sure if enabling 1MB cap is correct in this case on s390
> (should it be the same for all RAM???).
> With new approach 1Mb cap is not enabled if the smallest page size
> is not 1Mb.

There is no memory hotplug (DIMM/NVDIMM), so there really only is
initial memory.

> ---
>  target/s390x/kvm.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2ebf26a..22e868a 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -285,33 +285,28 @@ void kvm_s390_crypto_reset(void)
>      }
>  }
>  
> -static int kvm_s390_configure_mempath_backing(KVMState *s)
> +static int kvm_s390_configure_hugepage_backing(KVMState *s)
>  {
> -    size_t path_psize = qemu_mempath_getpagesize(mem_path);
> +    size_t psize = qemu_getrampagesize();
>  
> -    if (path_psize == 4 * KiB) {

if you keep this (modified) check you have to do minimal changes in the
code below. (e.g. not indent error messages)

> -        return 0;
> -    }
> -> -    if (!hpage_1m_allowed()) {
> -        error_report("This QEMU machine does not support huge page "
> -                     "mappings");
> -        return -EINVAL;
> -    }
> +    if (psize == 1 * MiB) {
> +        if (!hpage_1m_allowed()) {
> +            error_report("This QEMU machine does not support huge page "
> +                         "mappings");
> +            return -EINVAL;
> +        }
>  
> -    if (path_psize != 1 * MiB) {
> +        if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
> +            error_report("Memory backing with 1M pages was specified, "
> +                         "but KVM does not support this memory backing");
> +            return -EINVAL;
> +        }
> +        cap_hpage_1m = 1;
> +    } else if (psize == 2 * GiB) {
>          error_report("Memory backing with 2G pages was specified, "
>                       "but KVM does not support this memory backing");
>          return -EINVAL;
>      }
> -
> -    if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
> -        error_report("Memory backing with 1M pages was specified, "
> -                     "but KVM does not support this memory backing");
> -        return -EINVAL;
> -    }
> -
> -    cap_hpage_1m = 1;
>      return 0;
>  }
>  
> @@ -319,7 +314,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> -    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
> +    if (kvm_s390_configure_hugepage_backing(s)) {
>          return -EINVAL;
>      }
>  
> 

Apart from that looks good to me.

-- 

Thanks,

David / dhildenb
