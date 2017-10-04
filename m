Received: from eggs.gnu.org ([2001:4830:134:3::10]:42322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzi42-0001P6-7y
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzi3x-0007xe-8D
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzi3w-0007vB-UU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:42:05 -0400
References: <20171004105751.24655-1-borntraeger@de.ibm.com>
	<20171004105751.24655-2-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <512050f4-d7f5-7aac-f617-01ac5ef9513f@redhat.com>
Date: Wed, 4 Oct 2017 13:42:00 +0200
MIME-Version: 1.0
In-Reply-To: <20171004105751.24655-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390/kvm: Support for get/set of
 extended TOD-Clock for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 04.10.2017 12:57, Christian Borntraeger wrote:
> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> 
> Provides an interface for getting and setting the guest's extended
> TOD-Clock via a single ioctl to kvm. If the ioctl fails because it
> is not support by kvm, then we fall back to the old style of
> retrieving the clock via two ioctls.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [split failure change from epoch index change]
> ---
>  target/s390x/cpu.c       | 26 +++++++++++++++++++-------
>  target/s390x/kvm-stub.c  | 10 ++++++++++
>  target/s390x/kvm.c       | 35 ++++++++++++++++++++++++++++++++++-
>  target/s390x/kvm_s390x.h |  2 ++
>  4 files changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 34538c3..c8f1219 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -357,22 +357,34 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
>  
>  int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
>  {
> +    int r = 0;
> +
>      if (kvm_enabled()) {
> -        return kvm_s390_get_clock(tod_high, tod_low);
> +        r = kvm_s390_get_clock_ext(tod_high, tod_low);
> +        if (r == -ENXIO) {
> +            return kvm_s390_get_clock(tod_high, tod_low);
> +        }
> +    } else {
> +        /* Fixme TCG */
> +        *tod_high = 0;
> +        *tod_low = 0;
>      }
> -    /* Fixme TCG */
> -    *tod_high = 0;
> -    *tod_low = 0;
> -    return 0;
> +
> +    return r;
>  }
>  
>  int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
>  {
> +    int r = 0;
> +
>      if (kvm_enabled()) {
> -        return kvm_s390_set_clock(tod_high, tod_low);
> +        r = kvm_s390_set_clock_ext(tod_high, tod_low);
> +        if (r == -ENXIO) {
> +            return kvm_s390_set_clock(tod_high, tod_low);
> +        }
>      }
>      /* Fixme TCG */
> -    return 0;
> +    return r;
>  }
>  
>  int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
> diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
> index 261e1cd..43f02c2 100644
> --- a/target/s390x/kvm-stub.c
> +++ b/target/s390x/kvm-stub.c
> @@ -68,11 +68,21 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
>      return -ENOSYS;
>  }
>  
> +int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
> +{
> +    return -ENOSYS;
> +}
> +
>  int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
>  {
>      return -ENOSYS;
>  }
>  
> +int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
> +{
> +    return -ENOSYS;
> +}
> +
>  void kvm_s390_enable_css_support(S390CPU *cpu)
>  {
>  }
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ebb75ca..4c944a5 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -643,10 +643,27 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
>      return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
>  }
>  
> +int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
> +{
> +    int r;
> +    struct kvm_s390_vm_tod_clock gtod;
> +

So you've got a blank line here...

> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_TOD,
> +        .attr = KVM_S390_VM_TOD_EXT,
> +        .addr = (uint64_t)(&gtod),
> +    };
> +
> +    r = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> +    *tod_high = gtod.epoch_idx;
> +    *tod_low  = gtod.tod;
> +
> +    return r;
> +}
> +
>  int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
>  {
>      int r;
> -

... but removed the blank line here ... it would be more consequent to
do it the same way everywhere?

>      struct kvm_device_attr attr = {
>          .group = KVM_S390_VM_TOD,
>          .attr = KVM_S390_VM_TOD_LOW,
> @@ -663,6 +680,22 @@ int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
> +int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
> +{
> +    struct kvm_s390_vm_tod_clock gtod = {
> +        .epoch_idx = *tod_high,
> +        .tod  = *tod_low,
> +    };
> +
> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_TOD,
> +        .attr = KVM_S390_VM_TOD_EXT,
> +        .addr = (uint64_t)(&gtod),

You could remove the parentheses around "&gtod" (same in the
get_clock_ext function).

> +    };
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +}
> +
>  /**
>   * kvm_s390_mem_op:
>   * @addr:      the logical start address in guest memory
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 2d594bd..501fc5a 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -29,7 +29,9 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
>  int kvm_s390_get_ri(void);
>  int kvm_s390_get_gs(void);
>  int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
> +int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
>  int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
> +int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
>  void kvm_s390_enable_css_support(S390CPU *cpu);
>  int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>                                      int vq, bool assign);
> 

Just cosmetic nits... patch looks fine otherwise, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
