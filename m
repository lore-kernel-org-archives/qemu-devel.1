Received: from eggs.gnu.org ([2001:4830:134:3::10]:56480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJagE-0006R1-8k
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJagB-0005Qt-4b
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:24:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fJagA-0005QZ-VY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 694234067F19
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-111.ams2.redhat.com
	[10.36.117.111])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 249B92023582
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:23:57 +0000 (UTC)
References: <20180517085927.24925-1-peterx@redhat.com>
	<20180517085927.24925-7-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <48a97e95-23d3-afa0-8513-beb822149eca@redhat.com>
Date: Fri, 18 May 2018 10:23:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180517085927.24925-7-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/12] intel-iommu: pass in address
 space when page walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Peter,

On 05/17/2018 10:59 AM, Peter Xu wrote:
> We pass in the VTDAddressSpace too.  It'll be used in the follow up
> patches.
So you evetually preferred to keep .aw. I don't have a strong opinion
but maybe a small preference to v2 version.

Nevertheless
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4953d02ed0..fe5ee77d46 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -753,9 +753,11 @@ typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
>   * @hook_fn: hook func to be called when detected page
>   * @private: private data to be passed into hook func
>   * @notify_unmap: whether we should notify invalid entries
> + * @as: VT-d address space of the device
>   * @aw: maximum address width
>   */
>  typedef struct {
> +    VTDAddressSpace *as;
>      vtd_page_walk_hook hook_fn;
>      void *private;
>      bool notify_unmap;
> @@ -1460,6 +1462,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>                      .private = (void *)&vtd_as->iommu,
>                      .notify_unmap = true,
>                      .aw = s->aw_bits,
> +                    .as = vtd_as,
>                  };
>  
>                  /*
> @@ -2941,6 +2944,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>                  .private = (void *)n,
>                  .notify_unmap = false,
>                  .aw = s->aw_bits,
> +                .as = vtd_as,
>              };
>  
>              vtd_page_walk(&ce, 0, ~0ULL, &info);
> 
