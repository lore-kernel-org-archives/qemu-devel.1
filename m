Received: from eggs.gnu.org ([2001:4830:134:3::10]:60518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkWNC-0007Aq-45
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkWN9-0000fL-Br
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:11:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dkWN9-0000cl-3b
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:11:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7NEAwkU113986
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:11:05 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ch8m2vb77-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:11:04 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 23 Aug 2017 15:11:01 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-9-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 16:10:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170821091614.28251-9-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <efdc5e12-399e-614e-2a65-12989506039a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 08/10] s390x/pci: fence off instructions
 for non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com



On 08/21/2017 11:16 AM, Cornelia Huck wrote:
> If a guest running on a machine without zpci issues a pci instruction,
> throw them an exception.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index bc62bba5b7..9de165d8b1 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1191,7 +1191,11 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
>  {
>      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> 
> -    return clp_service_call(cpu, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return clp_service_call(cpu, r2);
> +    } else {
> +        return -1;
> +    }

According to the AR the clp instruction ain't zPCI
only. OTOH if I read the AR correctly it might be
the only relevant one at the moment. To be more
precise, the CLP instruction is installed if one or
more of certain tree conditions are met. One of the
conditions is zPCI facility installed, and the other
two I don't really understand based on what I've
looked into.

>  }
> 
>  static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1199,7 +1203,11 @@ static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
>      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> 
> -    return pcilg_service_call(cpu, r1, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return pcilg_service_call(cpu, r1, r2);
> +    } else {
> +        return -1;
> +    }
>  }
> 
>  static int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1207,7 +1215,11 @@ static int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
>      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> 
> -    return pcistg_service_call(cpu, r1, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return pcistg_service_call(cpu, r1, r2);
> +    } else {
> +        return -1;
> +    }
>  }
> 
>  static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1216,10 +1228,14 @@ static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint64_t fiba;
>      uint8_t ar;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -    fiba = get_base_disp_rxy(cpu, run, &ar);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        cpu_synchronize_state(CPU(cpu));
> +        fiba = get_base_disp_rxy(cpu, run, &ar);
> 
> -    return stpcifc_service_call(cpu, r1, fiba, ar);
> +        return stpcifc_service_call(cpu, r1, fiba, ar);
> +    } else {
> +        return -1;
> +    }
>  }
> 
>  static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1247,7 +1263,11 @@ static int kvm_rpcit_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
>      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> 
> -    return rpcit_service_call(cpu, r1, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return rpcit_service_call(cpu, r1, r2);
> +    } else {
> +        return -1;
> +    }
>  }
> 
>  static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1257,10 +1277,14 @@ static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint64_t gaddr;
>      uint8_t ar;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -    gaddr = get_base_disp_rsy(cpu, run, &ar);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        cpu_synchronize_state(CPU(cpu));
> +        gaddr = get_base_disp_rsy(cpu, run, &ar);
> 
> -    return pcistb_service_call(cpu, r1, r3, gaddr, ar);
> +        return pcistb_service_call(cpu, r1, r3, gaddr, ar);
> +    } else {
> +        return -1;
> +    }
>  }
> 
>  static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1269,10 +1293,14 @@ static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint64_t fiba;
>      uint8_t ar;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -    fiba = get_base_disp_rxy(cpu, run, &ar);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        cpu_synchronize_state(CPU(cpu));
> +        fiba = get_base_disp_rxy(cpu, run, &ar);
> 
> -    return mpcifc_service_call(cpu, r1, fiba, ar);
> +        return mpcifc_service_call(cpu, r1, fiba, ar);
> +    } else {
> +        return -1;
> +    }

The rest is directly tied to the zPCI facility.

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

>  }
> 
>  static int handle_b9(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
> 
