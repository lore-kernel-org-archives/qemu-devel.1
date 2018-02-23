Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1epAzF-0000wO-5d
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1epAz3-0007Tf-O5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:53:57 -0500
References: <20180223101919.21075-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d98a1816-d8ac-57b1-b9d5-ff799308f799@redhat.com>
Date: Fri, 23 Feb 2018 11:53:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180223101919.21075-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: remove s390_get_memslot_count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 23.02.2018 11:19, Cornelia Huck wrote:
> Not needed anymore after removal of the memory hotplug code.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/s390x/sclp.h  | 1 -
>  target/s390x/cpu.c       | 9 ---------
>  target/s390x/cpu.h       | 4 ----
>  target/s390x/kvm-stub.c  | 5 -----
>  target/s390x/kvm.c       | 5 -----
>  target/s390x/kvm_s390x.h | 1 -
>  6 files changed, 25 deletions(-)
> 
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 476cbf78f2..f9db243484 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -35,7 +35,6 @@
>  #define SCLP_FC_ASSIGN_ATTACH_READ_STOR         0xE00000000000ULL
>  #define SCLP_STARTING_SUBINCREMENT_ID           0x10001
>  #define SCLP_INCREMENT_UNIT                     0x10000
> -#define MAX_AVAIL_SLOTS                         32
>  #define MAX_STORAGE_INCREMENTS                  1020
>  
>  /* CPU hotplug SCLP codes */
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index f02ed19c70..627002b225 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -437,15 +437,6 @@ void s390_cmma_reset(void)
>      }
>  }
>  
> -int s390_get_memslot_count(void)
> -{
> -    if (kvm_enabled()) {
> -        return kvm_s390_get_memslot_count();
> -    } else {
> -        return MAX_AVAIL_SLOTS;
> -    }
> -}
> -
>  int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
>                                  int vq, bool assign)
>  {
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 5bd6de7e8e..c5ef930876 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -621,9 +621,6 @@ QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
>  /* SIGP order code mask corresponding to bit positions 56-63 */
>  #define SIGP_ORDER_MASK 0x000000ff
>  
> -/* from s390-virtio-ccw */
> -#define MAX_AVAIL_SLOTS              32
> -
>  /* machine check interruption code */
>  
>  /* subclasses */
> @@ -695,7 +692,6 @@ int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
>  int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
>  void s390_crypto_reset(void);
>  bool s390_get_squash_mcss(void);
> -int s390_get_memslot_count(void);
>  int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
>  void s390_cmma_reset(void);
>  void s390_enable_css_support(S390CPU *cpu);
> diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
> index 8cdcf83845..29b10542cc 100644
> --- a/target/s390x/kvm-stub.c
> +++ b/target/s390x/kvm-stub.c
> @@ -84,11 +84,6 @@ void kvm_s390_cmma_reset(void)
>  {
>  }
>  
> -int kvm_s390_get_memslot_count(void)
> -{
> -  return MAX_AVAIL_SLOTS;
> -}
> -
>  void kvm_s390_reset_vcpu(S390CPU *cpu)
>  {
>  }
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8ef509ece4..656aaea2cd 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1854,11 +1854,6 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>      return kvm_vm_ioctl(kvm_state, KVM_IOEVENTFD, &kick);
>  }
>  
> -int kvm_s390_get_memslot_count(void)
> -{
> -    return kvm_check_extension(kvm_state, KVM_CAP_NR_MEMSLOTS);
> -}
> -
>  int kvm_s390_get_ri(void)
>  {
>      return cap_ri;
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 7a3b862eea..c383bf4ee9 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -30,7 +30,6 @@ int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
>  void kvm_s390_enable_css_support(S390CPU *cpu);
>  int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>                                      int vq, bool assign);
> -int kvm_s390_get_memslot_count(void);
>  int kvm_s390_cmma_active(void);
>  void kvm_s390_cmma_reset(void);
>  void kvm_s390_reset_vcpu(S390CPU *cpu);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
