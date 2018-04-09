Received: from eggs.gnu.org ([2001:4830:134:3::10]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f5VJR-0002Z9-Tn
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f5VJN-00059R-Du
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:50:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f5VJM-00058R-Rx
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:50:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w39Bn3kl117716
	for <qemu-devel@nongnu.org>; Mon, 9 Apr 2018 07:50:11 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h83ekbbn7-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 07:50:11 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 9 Apr 2018 12:50:08 +0100
References: <20180409113019.14568-1-david@redhat.com>
	<20180409113019.14568-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 9 Apr 2018 13:50:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180409113019.14568-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8d2a6da1-f45c-ba59-38cd-5e66db2bfd69@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.12 1/2] s390x/mmu:
 don't overwrite pending exception in mmu translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 04/09/2018 01:30 PM, David Hildenbrand wrote:
> If we already triggered another exception, don't overwrite it with a
> protection exception.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>


Can you add your description from the cover letter regarding
"only applies to old KVM instances without the virtual memory access
IOCTL in KVM."

with that
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 1deeb6e6e4..a25deef5dd 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -325,7 +325,7 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
>  
>      r = mmu_translate_region(env, vaddr, asc, asce, level, raddr, flags, rw,
>                               exc);
> -    if (rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
> +    if (!r && rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
>          trigger_prot_fault(env, vaddr, asc, rw, exc);
>          return -1;
>      }
> 
