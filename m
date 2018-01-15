Received: from eggs.gnu.org ([2001:4830:134:3::10]:54258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb3Y0-0002Im-5E
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb3Xv-00043T-7Y
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:07:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eb3Xv-00042t-1W
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:07:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so1486769wmv.2
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 04:07:23 -0800 (PST)
References: <20171215052326.21386-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5383f04-554d-3db9-85a1-e9661aba23a5@redhat.com>
Date: Mon, 15 Jan 2018 13:07:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171215052326.21386-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] kvm: Add kvm_set_user_memory
 tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 15/12/2017 06:23, Alexey Kardashevskiy wrote:
> This adds a tracepoint to trace the KVM_SET_USER_MEMORY_REGION ioctl
> parameters which is quite useful for debugging VFIO memory regions
> being actually registered with KVM.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * added forgotten change to trace-events
> ---
>  accel/kvm/kvm-all.c    | 6 +++++-
>  accel/kvm/trace-events | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f290f48..b91fcb7 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -235,6 +235,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
>  {
>      KVMState *s = kvm_state;
>      struct kvm_userspace_memory_region mem;
> +    int ret;
>  
>      mem.slot = slot->slot | (kml->as_id << 16);
>      mem.guest_phys_addr = slot->start_addr;
> @@ -248,7 +249,10 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
>          kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>      }
>      mem.memory_size = slot->memory_size;
> -    return kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +    trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
> +                              mem.memory_size, mem.userspace_addr, ret);
> +    return ret;
>  }
>  
>  int kvm_destroy_vcpu(CPUState *cpu)
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index f89ba55..58e98ef 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -12,4 +12,5 @@ kvm_irqchip_commit_routes(void) ""
>  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>  kvm_irqchip_release_virq(int virq) "virq %d"
> +kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
>  
> 

Queued, thanks.

Paolo
