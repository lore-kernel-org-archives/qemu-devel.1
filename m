Received: from eggs.gnu.org ([2001:4830:134:3::10]:51419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diHIU-0003LT-QK
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diHIP-0001r1-P0
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:41:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diHIP-0001p0-FQ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:40:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 534A3C05243B
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 09:40:56 +0000 (UTC)
References: <1502949374-3061-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55204f73-46d3-0f8e-195f-15a9247819d7@redhat.com>
Date: Thu, 17 Aug 2017 11:40:48 +0200
MIME-Version: 1.0
In-Reply-To: <1502949374-3061-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] intel_iommu: fix missing BQL in
 pt fast path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 17/08/2017 07:56, Peter Xu wrote:
> In vtd_switch_address_space() we did the memory region switch, however
> it's possible that the caller of it has not taken the BQL at all. Make
> sure we have it.
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> Paolo: I noticed this qemu_mutex_iothread_locked() function, which might
> simplify the fix, so I decided to use it. Using bottom half should be ok
> as well, but after a second thought it can be complicated: consider the
> case when guest firstly triggered the pt fast path then quickly
> re-enables the IOMMU region before the bottom half being executed. Then
> looks like we need special care on the sync of bottom half task as well.

No, we don't, because the bottom half (as you correctly do below) would
only have to cover vtd_switch_address_space.  So the worst that can
happen is that on of the two calls to vtd_switch_address_space does nothing.

The patch below is okay.  However, vtd_switch_address_space is
expensive, which is why I suggested the bottom half.

Paolo

> That's over-complicated I guess (if with that, I'd prefer to remove the
> pt fast path since it's even not really the default path when pt is
> used...). Please let me know if you don't think so.
> ---
>  hw/i386/intel_iommu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a7bf87a..3a5bb0b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -957,6 +957,8 @@ static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
>  static bool vtd_switch_address_space(VTDAddressSpace *as)
>  {
>      bool use_iommu;
> +    /* Whether we need to take the BQL on our own */
> +    bool take_bql = !qemu_mutex_iothread_locked();
>  
>      assert(as);
>  
> @@ -967,6 +969,15 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
>                                     VTD_PCI_FUNC(as->devfn),
>                                     use_iommu);
>  
> +    /*
> +     * It's possible that we reach here without BQL, e.g., when called
> +     * from vtd_pt_enable_fast_path(). However the memory APIs need
> +     * it. We'd better make sure we have had it already, or, take it.
> +     */
> +    if (take_bql) {
> +        qemu_mutex_lock_iothread();
> +    }
> +
>      /* Turn off first then on the other */
>      if (use_iommu) {
>          memory_region_set_enabled(&as->sys_alias, false);
> @@ -976,6 +987,10 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
>          memory_region_set_enabled(&as->sys_alias, true);
>      }
>  
> +    if (take_bql) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +
>      return use_iommu;
>  }
>  
> 
