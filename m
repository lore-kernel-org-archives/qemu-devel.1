Received: from eggs.gnu.org ([2001:4830:134:3::10]:35931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gXnJN-0003If-3x
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gXnJH-0005NP-NV
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:15:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gXnJH-0005LK-CP
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:15:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBEDF4NL090362
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 08:15:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pcca6tpj7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 08:15:17 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Dec 2018 13:15:14 -0000
References: <1544792887-14575-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Dec 2018 14:15:10 +0100
MIME-Version: 1.0
In-Reply-To: <1544792887-14575-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <d068a183-1162-c720-e5f0-16f168f2b607@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix bad mask in time2tod()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org



On 14.12.2018 14:08, Thomas Huth wrote:
> The time2tod() function tries to deal with the 9 uppermost bits in the
> time value, but uses the wrong mask for this: 0xff80000000000000 should
> be used instead of 0xff10000000000000 here.
> 
> Fixes: 14055ce53c2d901d826ffad7fb7d6bb8ab46bdfd

Can you alsways have commit id and subject

like
Fixes: 14055ce53c2d ("s390x/tcg: avoid overflows in time2tod/tod2time")

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/s390x/tod.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
> index cbd7552..47ef9de 100644
> --- a/include/hw/s390x/tod.h
> +++ b/include/hw/s390x/tod.h
> @@ -56,7 +56,7 @@ typedef struct S390TODClass {
>  /* Converts ns to s390's clock format */
>  static inline uint64_t time2tod(uint64_t ns)
>  {
> -    return (ns << 9) / 125 + (((ns & 0xff10000000000000ull) / 125) << 9);
> +    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
>  }
>  
>  /* Converts s390's clock format to ns */
> 
