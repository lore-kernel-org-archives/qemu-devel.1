Received: from eggs.gnu.org ([2001:4830:134:3::10]:48751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTjCk-0005BP-10
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTjCi-0002XN-Rs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:31:30 -0400
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-9-peter.maydell@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <64ff124d-fe34-75eb-e9e6-7c419827ee3c@redhat.com>
Date: Fri, 15 Jun 2018 09:31:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180604152941.20374-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/13] hw/misc/tz_mpc.c: Honour the
 BLK_LUT settings in translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi Peter,

On 06/04/2018 05:29 PM, Peter Maydell wrote:
> The final part of the Memory Protection Controller we need to
> implement is actually using the BLK_LUT data programmed by the
> guest to determine whether to block the transaction or not.
> 
> Since this means we now change transaction mappings when
> the guest writes to BLK_LUT, we must also call the IOMMU
> notifiers at that point.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/tz-mpc.c     | 50 ++++++++++++++++++++++++++++++++++++++++++--
>  hw/misc/trace-events |  1 +
>  2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
> index 704bb3fb44d..7a6117c90b3 100644
> --- a/hw/misc/tz-mpc.c
> +++ b/hw/misc/tz-mpc.c
> @@ -72,6 +72,50 @@ static void tz_mpc_irq_update(TZMPC *s)
>      qemu_set_irq(s->irq, s->int_stat && s->int_en);
>  }
>  
> +static void tz_mpc_iommu_notify(TZMPC *s, uint32_t lutidx,
> +                                uint32_t oldlut, uint32_t newlut)
> +{
> +    /* Called when the LUT word at lutidx has changed from oldlut to newlut;
> +     * must call the IOMMU notifiers for the changed blocks.
> +     */
> +    IOMMUTLBEntry entry = {
> +        .addr_mask = s->blocksize - 1,
> +    };
> +    hwaddr addr = lutidx * s->blocksize * 32;
> +    int i;
> +
> +    for (i = 0; i < 32; i++, addr += s->blocksize) {
> +        if (!((oldlut ^ newlut) & (1 << i))) {
> +            continue;
> +        }
> +        /* This changes the mappings for both the S and the NS space,
> +         * so we need to do four notifies: an UNMAP then a MAP for each.
> +         */
> +
> +        trace_tz_mpc_iommu_notify(addr);
> +        entry.iova = addr;
> +        entry.translated_addr = addr;
> +
> +        entry.perm = IOMMU_NONE;
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
> +
> +        entry.perm = IOMMU_RW;

> +        if (newlut & (1 << i)) {
Add a comment saying the block is configured as non-secure?
> +            entry.target_as = &s->blocked_io_as;
> +        } else {
> +            entry.target_as = &s->downstream_as;
so this disallows any secure access to non secure blocks. I have a
reduced knowledge of TZ but I would have thought that a secure access
would have sufficient priviledge to access NS memory?

Thanks

Eric
> +        }
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
> +        if (newlut & (1 << i)) {
> +            entry.target_as = &s->downstream_as;
> +        } else {
> +            entry.target_as = &s->blocked_io_as;
> +        }
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
> +    }
> +}
> +
>  static MemTxResult tz_mpc_reg_read(void *opaque, hwaddr addr,
>                                     uint64_t *pdata,
>                                     unsigned size, MemTxAttrs attrs)
> @@ -213,6 +257,7 @@ static MemTxResult tz_mpc_reg_write(void *opaque, hwaddr addr,
>          s->blk_idx = value % s->blk_max;
>          break;
>      case A_BLK_LUT:
> +        tz_mpc_iommu_notify(s, s->blk_idx, s->blk_lut[s->blk_idx], value);
>          s->blk_lut[s->blk_idx] = value;
>          if (size == 4) {
>              s->blk_idx++;
> @@ -362,9 +407,10 @@ static IOMMUTLBEntry tz_mpc_translate(IOMMUMemoryRegion *iommu,
>      /* Look at the per-block configuration for this address, and
>       * return a TLB entry directing the transaction at either
>       * downstream_as or blocked_io_as, as appropriate.
> -     * For the moment, always permit accesses.
> +     * If the LUT cfg_ns bit is 1, only non-secure transactions
> +     * may pass. If the bit is 0, only secure transactions may pass.
>       */
> -    ok = true;
> +    ok = tz_mpc_cfg_ns(s, addr) == (iommu_idx == IOMMU_IDX_NS);
>  
>      trace_tz_mpc_translate(addr, flags,
>                             iommu_idx == IOMMU_IDX_S ? "S" : "NS",
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 72bf9d57000..c956e1419b7 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -90,6 +90,7 @@ tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs wri
>  tz_mpc_mem_blocked_read(uint64_t addr, unsigned size, bool secure) "TZ MPC blocked read: offset 0x%" PRIx64 " size %u secure %d"
>  tz_mpc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, bool secure) "TZ MPC blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
>  tz_mpc_translate(uint64_t addr, int flags, const char *idx, const char *res) "TZ MPC translate: addr 0x%" PRIx64 " flags 0x%x iommu_idx %s: %s"
> +tz_mpc_iommu_notify(uint64_t addr) "TZ MPC iommu: notifying UNMAP/MAP for 0x%" PRIx64
>  
>  # hw/misc/tz-ppc.c
>  tz_ppc_reset(void) "TZ PPC: reset"
> 
