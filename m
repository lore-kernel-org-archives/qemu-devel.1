Received: from eggs.gnu.org ([2001:4830:134:3::10]:35119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkSQM-0005ls-D8
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkSQI-0006v1-6P
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:02:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fkSQH-0006ur-Vw
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 07:02:38 -0400
References: <20180731084236.184728-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3515660f-fcd0-23ed-268b-9de3d574e90b@redhat.com>
Date: Tue, 31 Jul 2018 13:02:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180731084236.184728-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: Enable KVM huge page backing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com

On 31.07.2018 10:42, Janosch Frank wrote:
> From: Janosch Frank <frankja@linux.vnet.ibm.com>
> 
> QEMU has had huge page support for a longer time already, but KVM
> memory management under s390x needed some changes to work with huge
> backings.
> 
> Now that we have support, let's enable it if requested and
> available. Otherwise we now properly tell the user if there is no
> support and back out instead of failing to run the VM later on.
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
> 
> Right now there's a conflict with arm for the capability, so I guess
> I'll have to touch the cap number soonish. :)
> 
> ---
>  linux-headers/linux/kvm.h | 1 +
>  target/s390x/kvm.c        | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 98f389a5a3..e3b1e3070c 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
> +#define KVM_CAP_S390_HPAGE 156
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index d923cf4240..1ce0b42039 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -285,6 +285,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> +    if (mem_path && kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE, 0)) {
> +        error_report("Huge page backing was specified, "
> +                     "but this KVM does not support huge pages.");
> +        return -EINVAL;
> +    }
> +
>      mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
>      cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
>      cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
> 

Okay, I wonder if now is the right time to actually detect the pagesize
instead of relying on mempath pointing at hugetlbfs. I remember Power
already doing such a detection.

mempath is just an indicator.

-- 

Thanks,

David / dhildenb
