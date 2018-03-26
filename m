Received: from eggs.gnu.org ([2001:4830:134:3::10]:38535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0NeL-0003LA-Ps
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0NeI-0000M0-NU
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:38:41 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-5-git-send-email-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3d85cfec-e3d8-8506-f65f-2cbed50980bd@redhat.com>
Date: Mon, 26 Mar 2018 10:38:22 +0200
MIME-Version: 1.0
In-Reply-To: <1521156300-19296-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/7] s390x/kvm: interface to interpret
 AP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 16.03.2018 00:24, Tony Krowiak wrote:
> The VFIO AP device exploits interpretive execution of AP
> instructions (APIE). APIE is enabled by setting a device attribute
> via the KVM_SET_DEVICE_ATTR ioctl.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  target/s390x/kvm.c       |   16 ++++++++++++++++
>  target/s390x/kvm_s390x.h |    2 ++
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 33e5ec3..2812e28 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -277,6 +277,22 @@ static void kvm_s390_init_dea_kw(void)
>      }
>  }
>  
> +int kvm_s390_set_interpret_ap(uint8_t enable)
> +{
> +    struct kvm_device_attr attribute = {
> +        .group = KVM_S390_VM_CRYPTO,
> +        .attr  = KVM_S390_VM_CRYPTO_INTERPRET_AP,
> +        .addr = 1,
> +    };
> +
> +    if (!kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
> +                           KVM_S390_VM_CRYPTO_INTERPRET_AP)) {
> +        return -EOPNOTSUPP;
> +    }
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
> +}
> +
>  void kvm_s390_crypto_reset(void)
>  {
>      if (s390_has_feat(S390_FEAT_MSA_EXT_3)) {
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 34ee7e7..0d6c6e7 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -40,4 +40,6 @@ void kvm_s390_crypto_reset(void);
>  void kvm_s390_restart_interrupt(S390CPU *cpu);
>  void kvm_s390_stop_interrupt(S390CPU *cpu);
>  
> +int kvm_s390_set_interpret_ap(uint8_t enable);
> +
>  #endif /* KVM_S390X_H */
> 

Wonder if a capability - like we use e.g. for SIGP user space
interpretation - would be a better fit.

We can provide the AP feature to the guest in case:
- KVM_S390_VM_CPU_FEAT_AP ("interpretation support") is available
- KVM_S390_VM_CRYPTO_INTERPRET_AP ("interception support") is available

I am missing the second check in your code. (for now you only rely on
KVM_S390_VM_CPU_FEAT_AP)

I think you have to change the order of the patches so they work also
properly when bisectin.

-- 

Thanks,

David / dhildenb
