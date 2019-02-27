Received: from eggs.gnu.org ([209.51.188.92]:38601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gz0Gu-00031v-0p
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gz0Gs-0001OO-Tm
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:33:19 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:41999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gz0Gs-0001Kx-Mg
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:33:18 -0500
Received: from player794.ha.ovh.net (unknown [10.109.143.216])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 12198F32C8
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:33:15 +0100 (CET)
Date: Wed, 27 Feb 2019 15:33:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190227153303.7b890f19@bahia.lan>
In-Reply-To: <20190227085149.38596-5-aik@ozlabs.ru>
References: <20190227085149.38596-1-aik@ozlabs.ru>
	<20190227085149.38596-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu v3 4/6] spapr_iommu: Do not
 replay mappings from just created DMA window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, qemu-ppc@nongnu.org, Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 27 Feb 2019 19:51:47 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On sPAPR vfio_listener_region_add() is called in 2 situations:
> 1. a new listener is registered from vfio_connect_container();
> 2. a new IOMMU Memory Region is added from rtas_ibm_create_pe_dma_window().
> 
> In both cases vfio_listener_region_add() calls
> memory_region_iommu_replay() to notify newly registered IOMMU notifiers
> about existing mappings which is totally desirable for case 1.
> 
> However for case 2 it is nothing but noop as the window has just been
> created and has no valid mappings so replaying those does not do anything.
> It is barely noticeable with usual guests but if the window happens to be
> really big, such no-op replay might take minutes and trigger RCU stall
> warnings in the guest.
> 
> For example, a upcoming GPU RAM memory region mapped at 64TiB (right
> after SPAPR_PCI_LIMIT) causes a 64bit DMA window to be at least 128TiB
> which is (128<<40)/0x10000=2.147.483.648 TCEs to replay.
> 
> This mitigates the problem by adding an "skipping_replay" flag to
> sPAPRTCETable and defining sPAPR own IOMMU MR replay() hook which does
> exactly the same thing as the generic one except it returns early if
> @skipping_replay==true.
> 
> When "ibm,create-pe-dma-window" is complete, the guest will map only
> required regions of the huge DMA window.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/ppc/spapr.h  |  1 +
>  hw/ppc/spapr_iommu.c    | 31 +++++++++++++++++++++++++++++++
>  hw/ppc/spapr_rtas_ddw.c |  7 +++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 86b0488..358bb38 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -727,6 +727,7 @@ struct sPAPRTCETable {
>      uint64_t *mig_table;
>      bool bypass;
>      bool need_vfio;
> +    bool skipping_replay;
>      int fd;
>      MemoryRegion root;
>      IOMMUMemoryRegion iommu;
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 37e98f9..8f23179 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -141,6 +141,36 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
>      return ret;
>  }
>  
> +static void spapr_tce_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> +{
> +    MemoryRegion *mr = MEMORY_REGION(iommu_mr);
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +    hwaddr addr, granularity;
> +    IOMMUTLBEntry iotlb;
> +    sPAPRTCETable *tcet = container_of(iommu_mr, sPAPRTCETable, iommu);
> +
> +    if (tcet->skipping_replay) {
> +        return;
> +    }
> +
> +    granularity = memory_region_iommu_get_min_page_size(iommu_mr);
> +
> +    for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
> +        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, n->iommu_idx);
> +        if (iotlb.perm != IOMMU_NONE) {
> +            n->notify(n, &iotlb);
> +        }
> +
> +        /*
> +         * if (2^64 - MR size) < granularity, it's possible to get an
> +         * infinite loop here.  This should catch such a wraparound.
> +         */
> +        if ((addr + granularity) < addr) {
> +            break;
> +        }
> +    }
> +}

It is a bit unfortunate to duplicate all that code. What about making
a memory_region_iommu_replay_generic() helper out of it and call it
from spapr_tce_replay() and memory_region_iommu_replay() ?

Apart from that, LGTM.

> +
>  static int spapr_tce_table_pre_save(void *opaque)
>  {
>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
> @@ -659,6 +689,7 @@ static void spapr_iommu_memory_region_class_init(ObjectClass *klass, void *data)
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>  
>      imrc->translate = spapr_tce_translate_iommu;
> +    imrc->replay = spapr_tce_replay;
>      imrc->get_min_page_size = spapr_tce_get_min_page_size;
>      imrc->notify_flag_changed = spapr_tce_notify_flag_changed;
>      imrc->get_attr = spapr_tce_get_attr;
> diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
> index cb8a410..9cc020d 100644
> --- a/hw/ppc/spapr_rtas_ddw.c
> +++ b/hw/ppc/spapr_rtas_ddw.c
> @@ -171,8 +171,15 @@ static void rtas_ibm_create_pe_dma_window(PowerPCCPU *cpu,
>      }
>  
>      win_addr = (windows == 0) ? sphb->dma_win_addr : sphb->dma64_win_addr;
> +    /*
> +     * We have just created a window, we know for the fact that it is empty,
> +     * use a hack to avoid iterating over the table as it is quite possible
> +     * to have billions of TCEs, all empty.
> +     */
> +    tcet->skipping_replay = true;
>      spapr_tce_table_enable(tcet, page_shift, win_addr,
>                             1ULL << (window_shift - page_shift));
> +    tcet->skipping_replay = false;
>      if (!tcet->nb_table) {
>          goto hw_error_exit;
>      }
