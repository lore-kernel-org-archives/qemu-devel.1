Received: from eggs.gnu.org ([2001:4830:134:3::10]:40553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkQU4-00016E-NH
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkQU1-0001O5-99
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:58:24 -0400
Date: Tue, 31 Jul 2018 10:58:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180731105815.3a6fc0e9.cohuck@redhat.com>
In-Reply-To: <20180731084236.184728-1-frankja@linux.ibm.com>
References: <20180731084236.184728-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, qemu-s390x@nongnu.org

On Tue, 31 Jul 2018 09:42:36 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

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

You may want to change author and signoff to the new, shorter address.

> ---
> 
> Right now there's a conflict with arm for the capability, so I guess
> I'll have to touch the cap number soonish. :)

You can fix this by spitting out the linux-headers update into a patch
that will be replaced with a proper headers update :)

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

Please drop the trailing '.', as by the documentation for error_report().

> +        return -EINVAL;
> +    }
> +
>      mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
>      cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
>      cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
