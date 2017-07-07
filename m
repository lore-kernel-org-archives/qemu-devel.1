Received: from eggs.gnu.org ([2001:4830:134:3::10]:48262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dTSnI-0001PZ-4s
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dTSnF-0004Xb-1k
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:55:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dTSnE-0004WS-NQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:55:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67Cs9kf104103
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 08:55:30 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bj9cy38s2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 08:55:30 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 7 Jul 2017 08:55:29 -0400
References: <20170707122159.24714-1-cohuck@redhat.com>
	<20170707122159.24714-6-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 7 Jul 2017 14:55:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170707122159.24714-6-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <7e4e8d2d-66f6-8884-96a1-83f285171c13@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 5/7] s390x/pci: fence off instructions
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
Cc: agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07/07/2017 02:21 PM, Cornelia Huck wrote:
> If a guest running on a non-pci build issues a pci instruction,
> throw them an exception.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index a3d00196f4..c5c7c27a21 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1160,6 +1160,9 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
>  {
>      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
> 
> +#ifndef CONFIG_PCI
> +    return -1;
> +#endif

Instead of this ifdefing, can you use the cpu model to decide if the instruction
should be available? We need to do this anyway for proper handling.

You can then fence off the PCI bits in the CPU model for
CONFIG_PCI == off.
