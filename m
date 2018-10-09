Received: from eggs.gnu.org ([2001:4830:134:3::10]:36040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9y07-00006t-TA
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9y05-0006YK-6k
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:49:03 -0400
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9b8423b2-2b7b-2bde-4439-e20d79238e46@redhat.com>
Date: Tue, 9 Oct 2018 21:48:48 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 3/6] s390x/kvm: enable AP instruction
 interpretation for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

On 09/10/2018 19:52, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Let's use the KVM_SET_DEVICE_ATTR ioctl to enable hardware
> interpretation of AP instructions executed on the guest.
> If the S390_FEAT_AP feature is switched on for the guest,
> AP instructions must be interpreted by default; otherwise,
> they will be intercepted.
> 
> This attribute setting may be overridden by a device. For example,
> a device may want to provide AP instructions to the guest (i.e.,
> S390_FEAT_AP turned on), but it may want to emulate them. In this
> case, the AP instructions executed on the guest must be
> intercepted; so when the device is realized, it must disable
> interpretation.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 348e8cc5467a..d042deed1af3 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2291,11 +2291,26 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>          error_setg(errp, "KVM: host CPU model could not be identified");
>          return;
>      }
> +    /* for now, we can only provide the AP feature with HW support */
> +    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
> +        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
> +        set_bit(S390_FEAT_AP, model->features);
> +    }
>      /* strip of features that are not part of the maximum model */
>      bitmap_and(model->features, model->features, model->def->full_feat,
>                 S390_FEAT_MAX);
>  }
>  
> +static void kvm_s390_configure_apie(bool interpret)
> +{
> +    uint64_t attr = interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
> +                                KVM_S390_VM_CRYPTO_DISABLE_APIE;
> +
> +    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
> +        kvm_s390_set_attr(attr);
> +    }
> +}
> +
>  void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>  {
>      struct kvm_s390_vm_cpu_processor prop  = {
> @@ -2345,6 +2360,10 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>      if (test_bit(S390_FEAT_CMM, model->features)) {
>          kvm_s390_enable_cmma();
>      }
> +
> +    if (test_bit(S390_FEAT_AP, model->features)) {
> +        kvm_s390_configure_apie(true);
> +    }
>  }
>  
>  void kvm_s390_restart_interrupt(S390CPU *cpu)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
