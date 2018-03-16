Received: from eggs.gnu.org ([2001:4830:134:3::10]:44677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewmjN-0004h4-8S
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewmjK-0007wB-6N
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:37:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59724
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ewmjK-0007vr-1G
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:36:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GAY4Sl077657
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 06:36:57 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gr9tke4mh-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 06:36:56 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 10:36:55 -0000
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-5-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 11:36:48 +0100
MIME-Version: 1.0
In-Reply-To: <1521156300-19296-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <de870e1c-d891-1c89-2b83-e855647442b5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 16/03/2018 00:24, Tony Krowiak wrote:
> The VFIO AP device exploits interpretive execution of AP
> instructions (APIE). APIE is enabled by setting a device attribute
> via the KVM_SET_DEVICE_ATTR ioctl.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   target/s390x/kvm.c       |   16 ++++++++++++++++
>   target/s390x/kvm_s390x.h |    2 ++
>   2 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 33e5ec3..2812e28 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -277,6 +277,22 @@ static void kvm_s390_init_dea_kw(void)
>       }
>   }
>
> +int kvm_s390_set_interpret_ap(uint8_t enable)
> +{
> +    struct kvm_device_attr attribute =3D {
> +        .group =3D KVM_S390_VM_CRYPTO,
> +        .attr  =3D KVM_S390_VM_CRYPTO_INTERPRET_AP,
> +        .addr =3D 1,
> +    };
> +
> +    if (!kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
> +                           KVM_S390_VM_CRYPTO_INTERPRET_AP)) {

Isn't it enough to have the CPU feature ?
What are expecting here?

> +        return -EOPNOTSUPP;
> +    }
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);

Shouldn't you use the "enable" parameter somewhere?

> +}
> +
>   void kvm_s390_crypto_reset(void)
>   {
>       if (s390_has_feat(S390_FEAT_MSA_EXT_3)) {
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 34ee7e7..0d6c6e7 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -40,4 +40,6 @@ void kvm_s390_crypto_reset(void);
>   void kvm_s390_restart_interrupt(S390CPU *cpu);
>   void kvm_s390_stop_interrupt(S390CPU *cpu);
>
> +int kvm_s390_set_interpret_ap(uint8_t enable);
> +
>   #endif /* KVM_S390X_H */


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
