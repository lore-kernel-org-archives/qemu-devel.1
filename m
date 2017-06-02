Received: from eggs.gnu.org ([2001:4830:134:3::10]:49447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGjMk-0007Mz-C5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGjMh-0003K5-D8
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dGjMh-0003Iy-6m
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:59:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED1AB7FD47
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 09:59:29 +0000 (UTC)
Date: Fri, 2 Jun 2017 17:59:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170602095923.GD4056@pxdev.xzpeter.org>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
	<1496320911-51305-24-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1496320911-51305-24-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 23/33] exec: fix
 address_space_get_iotlb_entry page mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jun 01, 2017 at 02:41:41PM +0200, Paolo Bonzini wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The IOTLB that it returned didn't guarantee that page_mask is indeed a
> so-called page mask. That won't affect current usage since now only
> vhost is using it (vhost API allows arbitary IOTLB range). However we
> have IOTLB scemantic and we should best follow it. This patch fixes this
> issue to make sure the page_mask is always a valid page mask.
> 
> Fixes: a764040 ("exec: abstract address_space_do_translate()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-Id: <1496212378-22605-1-git-send-email-peterx@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 29633cd..22b8f0c 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -528,16 +528,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
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
> +        plen = pow2floor(plen) - 1;
>      }
>  
> -    /* Convert to address mask */
> -    plen -= 1;
> -
>      return (IOMMUTLBEntry) {
>          .target_as = section.address_space,
>          .iova = addr & ~plen,
> -- 
> 1.8.3.1

Paolo,

I got a better idea on refactoring address_space_get_iotlb_entry(). If
you haven't started preparing another pull request, please feel free
to drop this one (it fixed the problem but not that complete).
Otherwise I'll just work upon it, which is fine as well.

Sorry for the troublesome.

-- 
Peter Xu
