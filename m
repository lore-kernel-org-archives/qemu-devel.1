Received: from eggs.gnu.org ([2001:4830:134:3::10]:45663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJMd2-00041R-98
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJMcx-0007Tm-GP
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:23:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fJMcx-0007T4-AD
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:23:43 -0400
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-10-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a314f61b-b40e-5d50-0e4d-4ead93b8d0f1@redhat.com>
Date: Thu, 17 May 2018 19:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180504030811.28111-10-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/10] intel-iommu: don't unmap all for
 shadow page table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

Hi Peter,

On 05/04/2018 05:08 AM, Peter Xu wrote:
> IOMMU replay was carried out before in many use cases, e.g., context
> cache invalidations, domain flushes.  We used this mechanism to sync the
> shadow page table by firstly (1) unmap the whole address space, then
> (2) walk the page table to remap what's in the table.
> 
> This is very dangerous.
> 
> The problem is that we'll have a very small window (in my measurement,
> it can be about 3ms) during above step (1) and (2) that the device will
> see no (or incomplete) device page table.  Howerver the device never
> knows that.  This can cause DMA error of devices, who assumes the page
> table is always there.
But now you have the QemuMutex can we have a translate and an
invalidation that occur concurrently? Don't the iotlb flush and replay
happen while the lock is held?

Thanks

Eric
> 
> So the point is that, for MAP typed notifiers (vfio-pci, for example)
> they'll need the mapped page entries always be there.  We can never
> unmap any existing page entries like what we did in (1) above.
> 
> The only solution is to remove step (1).  We can't do that before since
> we didn't know what device page was mapped and what was not, so we unmap
> them all.  Now with the new IOVA tree QEMU knows what has mapped and
> what has not.  We don't need this step (1) any more.  Remove it.
> 
> Note that after removing that global unmap flushing, we'll need to
> notify unmap now during page walkings.
> 
> This should fix the DMA error problem that Jintack Lim reported with
> nested device assignment.  This problem won't not happen always, e.g., I
> cannot reproduce the error.  However after collecting logs it shows that
> this is the possible cause to Jintack's problem.
> 
> Reported-by: Jintack Lim <jintack@cs.columbia.edu>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 16b3514afb..9439103cac 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3003,10 +3003,8 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>  
>      /*
>       * The replay can be triggered by either a invalidation or a newly
> -     * created entry. No matter what, we release existing mappings
> -     * (it means flushing caches for UNMAP-only registers).
> +     * created entry.
>       */
> -    vtd_address_space_unmap(vtd_as, n);
>  
>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
>          trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
> @@ -3015,8 +3013,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>                                    ce.hi, ce.lo);
>          if (vtd_as_notify_mappings(vtd_as)) {
>              /* This is required only for MAP typed notifiers */
> -            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
> +            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, true,
>                            vtd_as);
> +        } else {
> +            vtd_address_space_unmap(vtd_as, n);
>          }
>      } else {
>          trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> 
