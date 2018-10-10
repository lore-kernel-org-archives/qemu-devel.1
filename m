Received: from eggs.gnu.org ([2001:4830:134:3::10]:60932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gACpY-0001sc-2J
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gACpU-0008Bp-Cw
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:39:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56144
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gACpU-0008B3-6F
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:39:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ABORVA143849
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:39:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n1ffgbfr9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:39:02 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 10 Oct 2018 12:39:00 +0100
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 10 Oct 2018 13:38:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1bad0d3d-4c6e-4330-b0f1-90a411edb27f@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 3/6] s390x/kvm: enable AP
 instruction interpretation for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com



On 10/09/2018 07:52 PM, Tony Krowiak wrote:
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

Acked-by: Halil Pasic <pasic@linux.ibm.com>

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

Not sure this check is necessary, and that the behavior if it fails
is intuitive, but whatever.

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
