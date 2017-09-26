Received: from eggs.gnu.org ([2001:4830:134:3::10]:53656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwqHk-0008BT-Gn
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwqHf-0007WJ-HU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwqHf-0007Vn-7s
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:52:23 -0400
References: <20170925102302.60587-1-borntraeger@de.ibm.com>
	<20170925102302.60587-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3a77203f-2f9e-b867-3be3-86243ccd72f1@redhat.com>
Date: Tue, 26 Sep 2017 15:52:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170925102302.60587-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390/kvm: Support for get/set of
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On 25.09.2017 12:23, Christian Borntraeger wrote:
> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> 
> Provides an interface for getting and setting the guest's extended
> TOD-Clock via a single ioctl to kvm. If the ioctl fails because it
> is not support by kvm, then we fall back to the old style of
> retrieving the clock via two ioctls.
> 
> If kvm fails to set a nonzero epoch index, then we ultimately fail
> the migration altogether and the guest will resume normally on the
> original host machine.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c |  8 +++-----
>  target/s390x/cpu.c         | 26 +++++++++++++++++++-------
>  target/s390x/kvm-stub.c    | 10 ++++++++++
>  target/s390x/kvm.c         | 35 +++++++++++++++++++++++++++++++++++
>  target/s390x/kvm_s390x.h   |  2 ++
>  5 files changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fafbc6d..bad09f5 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -213,13 +213,11 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
>  
>      r = s390_set_clock(&tod_high, &tod_low);
>      if (r) {
> -        warn_report("Unable to set guest clock for migration: %s",
> -                    strerror(-r));
> -        error_printf("Guest clock will not be restored "
> -                     "which could cause the guest to hang.");
> +        error_report("Unable to set guest clock value. "
> +                     "s390_get_clock returned error %d.\n", r);
>      }

This should go into a separate patch (I think also Conny referred to
that in her comment).

>  
> -    return 0;
> +    return r;
>  }
>  
[..]
.c
> index ebb75ca..ef7374c 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -643,6 +643,25 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
>      return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
>  }
>  
> +int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
> +{
> +    int r;
> +
> +    struct kvm_s390_vm_tod_clock gtod;
> +

Please drop spaces between initializers.

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
> @@ -663,6 +682,22 @@ int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
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

dito

> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_TOD,
> +        .attr = KVM_S390_VM_TOD_EXT,
> +        .addr = (uint64_t)(&gtod),
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

Apart from that looks good to me (although I am still 99.9% sure that
the kernel part is not fully correct, but have no time to look into it)

-- 

Thanks,

David
