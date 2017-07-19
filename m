Received: from eggs.gnu.org ([2001:4830:134:3::10]:52883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXfYT-0007WH-Hl
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXfYO-0005Oa-HX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:21:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52935
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dXfYO-0005OV-Ch
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:21:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J3Iwdh033335
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:21:35 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsq0ub2hc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:21:35 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 23:21:35 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
	[9.57.199.108])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6J3LXcI20447270
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 03:21:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98A2AB2052
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:19:02 -0400 (EDT)
Received: from [9.197.255.203] (unknown [9.197.255.203])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id E9DEFB2046
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:19:01 -0400 (EDT)
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-8-cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 11:21:30 +0800
MIME-Version: 1.0
In-Reply-To: <20170718142455.32676-8-cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <c64d191c-c424-542f-cd60-4e587e412db8@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 7/9] s390x/pci: fence off
 instructions for non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



=D4=DA 2017/7/18 =CF=C2=CE=E710:24, Cornelia Huck =D0=B4=B5=C0:
> If a guest running on a machine without zpci issues a pci instruction,
> throw them an exception.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/s390x/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++----=
---------
>   1 file changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 880eccd58a..60688888c3 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1191,7 +1191,11 @@ static int kvm_clp_service_call(S390CPU *cpu, st=
ruct kvm_run *run)
>   {
>       uint8_t r2 =3D (run->s390_sieic.ipb & 0x000f0000) >> 16;
>
> -    return clp_service_call(cpu, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return clp_service_call(cpu, r2);
> +    } else {
> +        return -1;
> +    }
Hi Conny,

Should we use a global value to store s390_has_feat(S390_FEAT_ZPCI)?
I'm not sure it's a good idea.

Yi Min
>   }
>
>   static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1199,7 +1203,11 @@ static int kvm_pcilg_service_call(S390CPU *cpu, =
struct kvm_run *run)
>       uint8_t r1 =3D (run->s390_sieic.ipb & 0x00f00000) >> 20;
>       uint8_t r2 =3D (run->s390_sieic.ipb & 0x000f0000) >> 16;
>
> -    return pcilg_service_call(cpu, r1, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return pcilg_service_call(cpu, r1, r2);
> +    } else {
> +        return -1;
> +    }
>   }
>
>   static int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1207,7 +1215,11 @@ static int kvm_pcistg_service_call(S390CPU *cpu,=
 struct kvm_run *run)
>       uint8_t r1 =3D (run->s390_sieic.ipb & 0x00f00000) >> 20;
>       uint8_t r2 =3D (run->s390_sieic.ipb & 0x000f0000) >> 16;
>
> -    return pcistg_service_call(cpu, r1, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return pcistg_service_call(cpu, r1, r2);
> +    } else {
> +        return -1;
> +    }
>   }
>
>   static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run=
)
> @@ -1216,10 +1228,14 @@ static int kvm_stpcifc_service_call(S390CPU *cp=
u, struct kvm_run *run)
>       uint64_t fiba;
>       uint8_t ar;
>
> -    cpu_synchronize_state(CPU(cpu));
> -    fiba =3D get_base_disp_rxy(cpu, run, &ar);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        cpu_synchronize_state(CPU(cpu));
> +        fiba =3D get_base_disp_rxy(cpu, run, &ar);
>
> -    return stpcifc_service_call(cpu, r1, fiba, ar);
> +        return stpcifc_service_call(cpu, r1, fiba, ar);
> +    } else {
> +        return -1;
> +    }
>   }
>
>   static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1247,7 +1263,11 @@ static int kvm_rpcit_service_call(S390CPU *cpu, =
struct kvm_run *run)
>       uint8_t r1 =3D (run->s390_sieic.ipb & 0x00f00000) >> 20;
>       uint8_t r2 =3D (run->s390_sieic.ipb & 0x000f0000) >> 16;
>
> -    return rpcit_service_call(cpu, r1, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return rpcit_service_call(cpu, r1, r2);
> +    } else {
> +        return -1;
> +    }
>   }
>
>   static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1257,10 +1277,14 @@ static int kvm_pcistb_service_call(S390CPU *cpu=
, struct kvm_run *run)
>       uint64_t gaddr;
>       uint8_t ar;
>
> -    cpu_synchronize_state(CPU(cpu));
> -    gaddr =3D get_base_disp_rsy(cpu, run, &ar);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        cpu_synchronize_state(CPU(cpu));
> +        gaddr =3D get_base_disp_rsy(cpu, run, &ar);
>
> -    return pcistb_service_call(cpu, r1, r3, gaddr, ar);
> +        return pcistb_service_call(cpu, r1, r3, gaddr, ar);
> +    } else {
> +        return -1;
> +    }
>   }
>
>   static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
> @@ -1269,10 +1293,14 @@ static int kvm_mpcifc_service_call(S390CPU *cpu=
, struct kvm_run *run)
>       uint64_t fiba;
>       uint8_t ar;
>
> -    cpu_synchronize_state(CPU(cpu));
> -    fiba =3D get_base_disp_rxy(cpu, run, &ar);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        cpu_synchronize_state(CPU(cpu));
> +        fiba =3D get_base_disp_rxy(cpu, run, &ar);
>
> -    return mpcifc_service_call(cpu, r1, fiba, ar);
> +        return mpcifc_service_call(cpu, r1, fiba, ar);
> +    } else {
> +        return -1;
> +    }
>   }
>
>   static int handle_b9(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
