Received: from eggs.gnu.org ([2001:4830:134:3::10]:45387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct5Cq-0000KY-1t
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct5Cm-0001Qc-0m
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:27:36 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ct5Cl-0001Pk-LQ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:27:31 -0400
Received: by mail-pg0-x244.google.com with SMTP id o123so1070361pga.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 21:27:31 -0700 (PDT)
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-4-aik@ozlabs.ru>
	<20170328114807.235e8edc@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <44636645-c3f5-6cd2-d7a8-c04408f9c032@ozlabs.ru>
Date: Wed, 29 Mar 2017 15:27:25 +1100
MIME-Version: 1.0
In-Reply-To: <20170328114807.235e8edc@t450s.home>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/3] vfio: Enable in-kernel
 acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 29/03/17 04:48, Alex Williamson wrote:
> On Tue, 28 Mar 2017 20:05:30 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> This enables in-kernel acceleration of TCE update requests via
>> VFIO KVM device.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  include/hw/vfio/vfio-common.h |  1 +
>>  target/ppc/kvm_ppc.h          |  6 ++++++
>>  hw/ppc/spapr_iommu.c          |  4 ++++
>>  hw/vfio/common.c              | 13 +++++++++++++
>>  hw/vfio/spapr.c               | 26 ++++++++++++++++++++++++++
>>  target/ppc/kvm.c              |  7 ++++++-
>>  hw/vfio/trace-events          |  1 +
>>  7 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index c582de18c9..ee8c96cc4a 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
> 
> Two patches intermixed here again it seems.  I'll refer to them as "A"
> and "B".  Seems easy to split at the file level.
> 
> Patch "B"
> 
>> @@ -175,6 +175,7 @@ extern const MemoryListener vfio_prereg_listener;
>>  int vfio_spapr_create_window(VFIOContainer *container,
>>                               MemoryRegionSection *section,
>>                               hwaddr *pgsize);
>> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd, int tablefd);
>>  int vfio_spapr_remove_window(VFIOContainer *container,
>>                               hwaddr offset_within_address_space);
>>  
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index f48243d13f..ce7327a4e0 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
> 
> Patch "A"
> 
>> @@ -46,6 +46,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
>>  int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
>>  int kvmppc_reset_htab(int shift_hint);
>>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
>> +bool kvmppc_has_cap_spapr_vfio(void);
>>  #endif /* !CONFIG_USER_ONLY */
>>  bool kvmppc_has_cap_epr(void);
>>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
>> @@ -216,6 +217,11 @@ static inline bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
>>      return true;
>>  }
>>  
>> +static inline bool kvmppc_has_cap_spapr_vfio(void)
>> +{
>> +    return false;
>> +}
>> +
>>  #endif /* !CONFIG_USER_ONLY */
>>  
>>  static inline bool kvmppc_has_cap_epr(void)
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index b61c8f053e..fc23d81645 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
> 
> Patch "A"
> 
>> @@ -293,6 +293,10 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
>>  
>>      tcet->need_vfio = need_vfio;
>>  
>> +    if (!need_vfio || (tcet->fd != -1 && kvmppc_has_cap_spapr_vfio())) {
>> +        return;
>> +    }


Separation to "A" and "B" makes sense most of the time, however this bit
being put into "A" will look at the capability and change the behaviour
effectively disabling TCE requests handling in the kernel as
vfio_spapr_notify_kvm() only appears in "B". Bad for bisectability.

I could swap "A" and "B", this way vfio_spapr_notify_kvm() would fail but
thing would keep working.



>> +
>>      oldtable = tcet->table;
>>  
>>      tcet->table = spapr_tce_alloc_table(tcet->liobn,
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index c75c7594d5..9aaf861904 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
> 
> Patch "B"
> 
>> @@ -440,6 +440,19 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>              goto fail;
>>          }
>>  
>> +#ifdef CONFIG_KVM
> 
> I don't think we need this just for kvm_enabled(), do we?


We do for vfio_kvm_device_fd - this one is defined under #ifdef.


> 
>> +        if (kvm_enabled() && section->mr->iommu_ops->get_fd) {
>> +            VFIOGroup *group;
>> +            int tablefd =  section->mr->iommu_ops->get_fd(section->mr);
> 
> This would change to
> 
>     tablefd=memory_region_iommu_get_fd(SPAPR_IOMMU_TABLE_FD,section->mr);
> 
>> +
>> +            if (tablefd != -1) {
>> +                QLIST_FOREACH(group, &container->group_list, container_next) {
>> +                    vfio_spapr_notify_kvm(vfio_kvm_device_fd,
>> +                                          group->fd, tablefd);
>> +                }
>> +            }
>> +        }
>> +#endif
>>          vfio_host_win_add(container, section->offset_within_address_space,
>>                            section->offset_within_address_space +
>>                            int128_get64(section->size) - 1, pgsize);
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index 4409bcc0d7..dffef3bd5f 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
> 
> Patch "B"
> 
>> @@ -17,6 +17,9 @@
>>  #include "hw/hw.h"
>>  #include "qemu/error-report.h"
>>  #include "trace.h"
>> +#ifdef CONFIG_KVM
>> +#include "linux/kvm.h"
>> +#endif
>>  
>>  static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
>>  {
>> @@ -187,6 +190,29 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>      return 0;
>>  }
>>  
>> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd, int tablefd)
>> +{
>> +#ifdef CONFIG_KVM
>> +    struct kvm_vfio_spapr_tce param = {
>> +        .groupfd = groupfd,
>> +        .tablefd = tablefd
>> +    };
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_DEV_VFIO_GROUP,
>> +        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
>> +        .addr = (uint64_t)(unsigned long)&param,
>> +    };
>> +
>> +    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> +        error_report("vfio: failed to setup fd %d for a group with fd %d: %s",
>> +                     param.tablefd, param.groupfd, strerror(errno));
>> +        return -errno;
>> +    }
>> +    trace_vfio_spapr_notify_kvm(groupfd, tablefd);
>> +#endif
>> +    return 0;
>> +}
>> +
>>  int vfio_spapr_remove_window(VFIOContainer *container,
>>                               hwaddr offset_within_address_space)
>>  {
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 560ce655c7..bca5fe7329 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
> 
> Patch "A"
> 
>> @@ -131,7 +131,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>>      cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
>>      cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
>> -    cap_spapr_vfio = false;
>> +    cap_spapr_vfio = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);
>>      cap_one_reg = kvm_check_extension(s, KVM_CAP_ONE_REG);
>>      cap_hior = kvm_check_extension(s, KVM_CAP_PPC_HIOR);
>>      cap_epr = kvm_check_extension(s, KVM_CAP_PPC_EPR);
>> @@ -2416,6 +2416,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>>      return cap_mmu_hash_v3;
>>  }
>>  
>> +bool kvmppc_has_cap_spapr_vfio(void)
>> +{
>> +    return cap_spapr_vfio;
>> +}
>> +
>>  static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>>  {
>>      ObjectClass *oc = OBJECT_CLASS(pcc);
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 2561c6d31a..084a92f7c2 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
> 
> Patch "B"
> 
>> @@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"P
>>  vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
>>  vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
>>  vfio_spapr_remove_window(uint64_t off) "offset=%"PRIx64
>> +vfio_spapr_notify_kvm(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
> 


-- 
Alexey
