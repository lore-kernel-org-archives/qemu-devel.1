Received: from eggs.gnu.org ([2001:4830:134:3::10]:43344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL6rr-0002HA-RX
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL6rn-0003y5-SP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:58:19 -0400
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <47281818-f0cf-0ed1-c479-fbcaca5c5167@redhat.com>
Date: Tue, 22 May 2018 14:58:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, patches@linaro.org

Hi Peter,
On 05/21/2018 04:03 PM, Peter Maydell wrote:
> If an IOMMU supports mappings that care about the memory
> transaction attributes, then it no longer has a unique
> address -> output mapping, but more than one. We can
> represent these using an IOMMU index, analogous to TCG's
> mmu indexes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/memory.h | 52 +++++++++++++++++++++++++++++++++++++++++++
>  memory.c              | 23 +++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 309fdfb89b..f6226fb263 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -206,6 +206,20 @@ enum IOMMUMemoryRegionAttr {
>   * to report whenever mappings are changed, by calling
>   * memory_region_notify_iommu() (or, if necessary, by calling
>   * memory_region_notify_one() for each registered notifier).
> + *
> + * Conceptually an IOMMU provides a mapping from input address
> + * to an output TLB entry.
actually it takes a source identifier too (ARM streamid + substreamID,
this latter is not yet supported).
At the moment we have 1 IOMMUMRRegion per sid on ARM. For each
IOMMUMRRegion we would now have 2 indexes (1 for secure and 1 for
unsecure). How do you see the implementation of PASIDs (substreamids).
Would that be based on indexes or not?
 If the IOMMU is aware of memory transaction
> + * attributes and the output TLB entry depends on the transaction
> + * attributes, we represent this using IOMMU indexes. Each index
> + * selects a particular translation table that the IOMMU has:
> + *   @attrs_to_index returns the IOMMU index for a set of transaction attributes
> + *   @translate takes an input address and an IOMMU index
> + * and the mapping returned can only depend on the input address and the
> + * IOMMU index.
> + *
> + * Most IOMMUs don't care about the transaction attributes and support
> + * only a single IOMMU index. A more complex IOMMU might have one index
> + * for secure transactions and one for non-secure transactions.
>   */
>  typedef struct IOMMUMemoryRegionClass {
>      /* private */
> @@ -290,6 +304,26 @@ typedef struct IOMMUMemoryRegionClass {
>       */
>      int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr attr,
>                      void *data);
> +
> +    /* Return the IOMMU index to use for a given set of transaction attributes.
> +     *
> +     * Optional method: if an IOMMU only supports a single IOMMU index then
> +     * the default implementation of memory_region_iommu_attrs_to_index()
> +     * will return 0.
> +     *
> +     * The indexes supported by an IOMMU must be contiguous, starting at 0.
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     * @attrs: memory transaction attributes
> +     */
> +    int (*attrs_to_index)(IOMMUMemoryRegion *iommu, MemTxAttrs attrs);
> +
> +    /* Return the number of IOMMU indexes this IOMMU supports.
> +     *
> +     * Optional method: if this method is not provided, then
> +     * memory_region_iommu_num_indexes() will return 1, indicating that
> +     * only a single IOMMU index is supported.
> +     */
>  } IOMMUMemoryRegionClass;
>  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> @@ -1077,6 +1111,24 @@ int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>                                   enum IOMMUMemoryRegionAttr attr,
>                                   void *data);
>  
> +/**
> + * memory_region_iommu_attrs_to_index: return the IOMMU index to
> + * use for translations with the given memory transaction attributes.
> + *
> + * @iommu_mr: the memory region
> + * @attrs: the memory transaction attributes
> + */
> +int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
> +                                       MemTxAttrs attrs);
> +
> +/**
> + * memory_region_iommu_num_indexes: return the total number of IOMMU
> + * indexes that this IOMMU supports.
is it IOMMU wide characteristics or per IOMMUMRRegion (SID)?

Thanks

Eric
> + *
> + * @iommu_mr: the memory region
> + */
> +int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
> +
>  /**
>   * memory_region_name: get a memory region's name
>   *
> diff --git a/memory.c b/memory.c
> index 10fa2ddd31..07d5fa7862 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1918,6 +1918,29 @@ int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>      return imrc->get_attr(iommu_mr, attr, data);
>  }
>  
> +int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
> +                                       MemTxAttrs attrs)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +
> +    if (!imrc->attrs_to_index) {
> +        return 0;
> +    }
> +
> +    return imrc->attrs_to_index(iommu_mr, attrs);
> +}
> +
> +int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +
> +    if (!imrc->num_indexes) {
> +        return 1;
> +    }
> +
> +    return imrc->num_indexes(iommu_mr);
> +}
> +
>  void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
>  {
>      uint8_t mask = 1 << client;
> 
