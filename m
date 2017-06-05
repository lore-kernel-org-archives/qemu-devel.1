Received: from eggs.gnu.org ([2001:4830:134:3::10]:35558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dHmZy-00023K-U1
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dHmZu-0004Mm-Ec
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:37:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dHmZt-0004Kc-JR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:37:30 -0400
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <593509FB.3070605@huawei.com>
Date: Mon, 5 Jun 2017 15:36:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170503105224.19049-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 2017/5/3 18:52, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> Background
> ==========
> The original idea of this patchset is from Avi who raised it in
> the mailing list during my vMMU development some years ago
>
> This patchset introduces a extremely fast way to write protect
> all the guest memory. Comparing with the ordinary algorithm which
> write protects last level sptes based on the rmap one by one,
> it just simply updates the generation number to ask all vCPUs
> to reload its root page table, particularly, it can be done out
> of mmu-lock, so that it does not hurt vMMU's parallel. It is
> the O(1) algorithm which does not depends on the capacity of
> guest's memory and the number of guest's vCPUs
>
> Implementation
> ==============
> When write protect for all guest memory is required, we update
> the global generation number and ask vCPUs to reload its root
> page table by calling kvm_reload_remote_mmus(), the global number
> is protected by slots_lock
>
> During reloading its root page table, the vCPU checks root page
> table's generation number with current global number, if it is not
> matched, it makes all the entries in the shadow page readonly and
> directly go to VM. So the read access is still going on smoothly
> without KVM's involvement and write access triggers page fault
>
> If the page fault is triggered by write operation, KVM moves the
> write protection from the upper level to the lower level page - by
> making all the entries in the lower page readonly first then make
> the upper level writable, this operation is repeated until we meet
> the last spte
>
> In order to speed up the process of making all entries readonly, we
> introduce possible_writable_spte_bitmap which indicates the writable
> sptes and possiable_writable_sptes which is a counter indicating the
> number of writable sptes in the shadow page, they work very efficiently
> as usually only one entry in PML4 ( < 512 G)，few entries in PDPT (one
> entry indicates 1G memory), PDEs and PTEs need to be write protected for
> the worst case. Note, the number of page fault and TLB flush are the same
> as the ordinary algorithm
>
> Performance Data
> ================
> Case 1) For a VM which has 3G memory and 12 vCPUs, we noticed that:
>     a: the time required for dirty log (ns)
>         before           after
>         64289121         137654      +46603%
>
>     b: the performance of memory write after dirty log, i.e, the dirty
>        log path is not parallel with page fault, the time required to
>        write all 3G memory for all vCPUs in the VM (ns):
>         before           after
>         281735017        291150923   -3%
>        We think the impact, 3%, is acceptable, particularly, mmu-lock
>        contention is not take into account in this case
>
> Case 2) For a VM which has 30G memory and 8 vCPUs, we do the live
>     migration, at the some time, a test case which greedily and repeatedly
>     writes 3000M memory in the VM.
>
>     2.1) for the new booted VM, i.e, page fault is required to map guest
>          memory in, we noticed that:
>          a: the dirty page rate (pages):
>              before       after
>              333092       497266     +49%
> 	that means, the performance for the being migrated VM is hugely
> 	improved as the contention on mmu-lock is reduced
>
> 	b: the time to complete live migration (ms):
> 	    before       after
> 	    12532        18467     -47%
> 	not surprise, the time required to complete live migration is
> 	increased as the VM is able to generate more dirty pages
>
>     2.2) pre-write the VM first, then run the test case and do live
>          migration, i.e, no much page faults are needed to map guest
>          memory in, we noticed that:
> 	a: the dirty page rate (pages):
> 	    before       after
> 	    447435       449284  +0%
> 	
> 	b: time time to complete live migration (ms)
> 	    before       after
> 	    31068        28310  +10%
> 	under this case, we also noticed that the time of dirty log for
> 	the first time, before the patchset is 156 ms, after that, only
> 	6 ms is needed
>
> The patch applied to QEMU
> =========================
> The draft patch is attached to enable this functionality in QEMU:
>
> diff --git a/kvm-all.c b/kvm-all.c
> index 90b8573..9ebe1ac 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -122,6 +122,7 @@ bool kvm_direct_msi_allowed;
>   bool kvm_ioeventfd_any_length_allowed;
>   bool kvm_msi_use_devid;
>   static bool kvm_immediate_exit;
> +static bool kvm_write_protect_all;
>
>   static const KVMCapabilityInfo kvm_required_capabilites[] = {
>       KVM_CAP_INFO(USER_MEMORY),
> @@ -440,6 +441,26 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
>
>   #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
>
> +static bool kvm_write_protect_all_is_supported(KVMState *s)
> +{
> +	return kvm_check_extension(s, KVM_CAP_X86_WRITE_PROTECT_ALL_MEM) &&
> +		kvm_check_extension(s, KVM_CAP_X86_DIRTY_LOG_WITHOUT_WRITE_PROTECT);
> +}
> +
> +static void kvm_write_protect_all_mem(bool write)
> +{
> +	int ret;
> +
> +	if (!kvm_write_protect_all)
> +		return;
> +
> +	ret = kvm_vm_ioctl(kvm_state, KVM_WRITE_PROTECT_ALL_MEM, !!write);
> +	if (ret < 0) {
> +	  printf("ioctl failed %d\n", errno);
> +	  abort();
> +	}
> +}
> +
>   /**
>    * kvm_physical_sync_dirty_bitmap - Grab dirty bitmap from kernel space
>    * This function updates qemu's dirty bitmap using
> @@ -490,6 +511,7 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
>           memset(d.dirty_bitmap, 0, allocated_size);
>
>           d.slot = mem->slot | (kml->as_id << 16);
> +        d.flags = kvm_write_protect_all ? KVM_DIRTY_LOG_WITHOUT_WRITE_PROTECT : 0;
>           if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
>               DPRINTF("ioctl failed %d\n", errno);
>               ret = -1;
> @@ -1622,6 +1644,9 @@ static int kvm_init(MachineState *ms)
>       }
>
>       kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
> +    kvm_write_protect_all = kvm_write_protect_all_is_supported(s);
> +    printf("Write protect all is %s.\n", kvm_write_protect_all ? "supported" : "unsupported");
> +    memory_register_write_protect_all(kvm_write_protect_all_mem);
>       s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
>
>       /* If unspecified, use the default value */
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 4e082a8..7c056ef 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -443,9 +443,12 @@ struct kvm_interrupt {
>   };
>
>   /* for KVM_GET_DIRTY_LOG */
> +
> +#define KVM_DIRTY_LOG_WITHOUT_WRITE_PROTECT	0x1
> +
>   struct kvm_dirty_log {
>   	__u32 slot;
> -	__u32 padding1;
> +	__u32 flags;
>   	union {
>   		void *dirty_bitmap; /* one bit per page */
>   		__u64 padding2;
> @@ -884,6 +887,9 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_PPC_MMU_HASH_V3 135
>   #define KVM_CAP_IMMEDIATE_EXIT 136
>
> +#define KVM_CAP_X86_WRITE_PROTECT_ALL_MEM 144
> +#define KVM_CAP_X86_DIRTY_LOG_WITHOUT_WRITE_PROTECT 145
> +
>   #ifdef KVM_CAP_IRQ_ROUTING
>
>   struct kvm_irq_routing_irqchip {
> @@ -1126,6 +1132,7 @@ enum kvm_device_type {
>   					struct kvm_userspace_memory_region)
>   #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
>   #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
> +#define KVM_WRITE_PROTECT_ALL_MEM _IO(KVMIO,  0x49)
>
>   /* enable ucontrol for s390 */
>   struct kvm_s390_ucas_mapping {
> diff --git a/memory.c b/memory.c
> index 4c95aaf..b836675 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -809,6 +809,13 @@ static void address_space_update_ioeventfds(AddressSpace *as)
>       flatview_unref(view);
>   }
>
> +static write_protect_all_fn write_func;

I think there should be a declaration in memory.h,

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7fc3f48..31f3098 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1152,6 +1152,9 @@ void memory_global_dirty_log_start(void);
   */
  void memory_global_dirty_log_stop(void);

+typedef void (*write_protect_all_fn)(bool write);
+void memory_register_write_protect_all(write_protect_all_fn func);
+
  void mtree_info(fprintf_function mon_printf, void *f);

-- 
Best Regards,
Jay Zhou
