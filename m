Received: from eggs.gnu.org ([2001:4830:134:3::10]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFjvW-0005Cm-N8
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFjvT-0004mg-I1
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFjvT-0004mP-C9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:23:19 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B25EC059722
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 16:23:18 +0000 (UTC)
References: <1496030545-8719-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <624c0eb9-083f-d6e8-16b7-998082e1e470@redhat.com>
Date: Tue, 30 May 2017 18:23:14 +0200
MIME-Version: 1.0
In-Reply-To: <1496030545-8719-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] exec: fix address_space_get_iotlb_entry
 page mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>



On 29/05/2017 06:02, Peter Xu wrote:
> The IOTLB that it returned didn't guarantee that page_mask is indeed a
> so-called page mask. That won't affect current usage since now only
> vhost is using it (vhost API allows arbitary IOTLB range). However we
> have IOTLB scemantic and we should best follow it. This patch fixes this
> issue to make sure the page_mask is always a valid page mask.
> 
> Fixes: a764040 ("exec: abstract address_space_do_translate()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> Sorry please use this one. The codes is merely the same, just avoided
> moving the codes around unnecessarily.
> ---
>  exec.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index ff16f04..3db247c 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -529,16 +529,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>          section.offset_within_region;
>  
>      if (plen == (hwaddr)-1) {
> -        /*
> -         * We use default page size here. Logically it only happens
> -         * for identity mappings.
> -         */
> -        plen = TARGET_PAGE_SIZE;
> +        /* If not specified during translation, use default mask */
> +        plen = TARGET_PAGE_MASK;
> +    } else {
> +        /* Make it a valid page mask */
> +        assert(plen);
> +        plen = (1ULL << (63 - clz64(plen))) - 1;

Would pow2floor be better?

Thanks,

Paolo

>      }
>  
> -    /* Convert to address mask */
> -    plen -= 1;
> -
>      return (IOMMUTLBEntry) {
>          .target_as = section.address_space,
>          .iova = addr & ~plen,
> 
