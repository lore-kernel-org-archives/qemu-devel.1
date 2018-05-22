Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKxaU-0000gc-2F
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKxaS-0008Lg-Vg
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:03:46 -0400
Date: Tue, 22 May 2018 11:03:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180522030333.GB17282@xz-mi>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180521140402.23318-15-peter.maydell@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, patches@linaro.org

On Mon, May 21, 2018 at 03:03:49PM +0100, Peter Maydell wrote:
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
> + * to an output TLB entry. If the IOMMU is aware of memory transaction
> + * attributes and the output TLB entry depends on the transaction
> + * attributes, we represent this using IOMMU indexes. Each index

Hi, Peter,

In what case will an IOMMU translation depend on translation
attributes?  It seems to me that we should always pass in the
translation attributes into the translate() function.  The translate()
function can omit that parameter if the specific IOMMU does not need
that information, but still I am confused about why we need to index
IOMMU by translation attributes.

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

The num_indexes() definition is missing, and I saw that in the next
patch.  We'll possibly want to move it here.

Regards,

-- 
Peter Xu
