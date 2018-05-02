Received: from eggs.gnu.org ([2001:4830:134:3::10]:35870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fDrJR-0001OL-JG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fDrJN-000711-LB
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:56:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53026
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fDrJN-00070i-Fu
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:56:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w42CoW4T109816
	for <qemu-devel@nongnu.org>; Wed, 2 May 2018 08:56:43 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hqcgguhq6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 08:56:43 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 2 May 2018 13:56:35 +0100
References: <20180502125221.4877-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 2 May 2018 14:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180502125221.4877-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a6eef4fc-712a-5495-4bab-0130937ad3fb@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 05/02/2018 02:52 PM, Cornelia Huck wrote:
> We currently pass an integer as the subcode parameter. However,
> the upper bits of the register containing the subcode need to
> be 0, which is not guaranteed unless we explicitly specify the
> subcode to be an unsigned long value.
> 
> Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  pc-bios/s390-ccw/iplb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 5357a36d51..ded20c834e 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -101,10 +101,11 @@ static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
>  {
>      register unsigned long addr asm("0") = (unsigned long) iplb;
>      register unsigned long rc asm("1") = 0;
> +    unsigned long subcode = store ? 6 : 5;
>  
>      asm volatile ("diag %0,%2,0x308\n"
>                    : "+d" (addr), "+d" (rc)
> -                  : "d" (store ? 6 : 5)
> +                  : "d" (subcode)

We could also use 6UL : 5UL instead of a local variable, but I certainly do not care enough.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


>                    : "memory", "cc");
>      return rc == 0x01;
>  }
> 
