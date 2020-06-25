Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1C9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CE6206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CE6206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPpn-00031b-Fv
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1joPol-0001PZ-Bf; Thu, 25 Jun 2020 07:13:19 -0400
Received: from charlie.dont.surf ([128.199.63.193]:38806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1joPoh-0006ab-AN; Thu, 25 Jun 2020 07:13:19 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 6D499BF432;
 Thu, 25 Jun 2020 11:13:12 +0000 (UTC)
Date: Thu, 25 Jun 2020 13:13:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v3 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200625111308.42473x7wfzukp4ve@apples.localdomain>
References: <20200622182511.17252-1-andrzej.jakowski@linux.intel.com>
 <20200622182511.17252-3-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622182511.17252-3-andrzej.jakowski@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 07:08:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 22 11:25, Andrzej Jakowski wrote:
> So far it was not possible to have CMB and PMR emulated on the same
> device, because BAR2 was used exclusively either of PMR or CMB. This
> patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
> 
> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
>  hw/block/nvme.c      | 119 +++++++++++++++++++++++++++----------------
>  hw/block/nvme.h      |   3 +-
>  include/block/nvme.h |   4 +-
>  3 files changed, 80 insertions(+), 46 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9f11f3e9da..ec97b7af3c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -22,12 +22,12 @@
>   *              [pmrdev=<mem_backend_file_id>,] \
>   *              max_ioqpairs=<N[optional]>
>   *
> - * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
> - * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> + * Note cmb_size_mb denotes size of CMB in MB. CMB when configured is assumed
> + * to be resident in BAR4 at certain offset - this is because BAR4 is also
> + * used for storing MSI-X table that is available at offset 0 in BAR4.
>   *
> - * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
> - * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
> - * both provided.
> + * pmrdev is assumed to be resident in BAR2/BAR3. When configured it consumes
> + * whole BAR2/BAR3 exclusively.
>   * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
>   * For example:
>   * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
> @@ -57,8 +57,8 @@
>  #define NVME_MAX_IOQPAIRS 0xffff
>  #define NVME_REG_SIZE 0x1000
>  #define NVME_DB_SIZE  4
> -#define NVME_CMB_BIR 2
>  #define NVME_PMR_BIR 2
> +#define NVME_MSIX_BIR 4
>  
>  #define NVME_GUEST_ERR(trace, fmt, ...) \
>      do { \
> @@ -69,18 +69,19 @@
>  
>  static void nvme_process_sq(void *opaque);
>  
> -static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> +static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr, int size)
>  {
> -    hwaddr low = n->ctrl_mem.addr;
> -    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
> +    hwaddr low = n->bar4.addr + n->cmb_offset;
> +    hwaddr hi  = low + NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
>  
> -    return addr >= low && addr < hi;
> +    return addr >= low && (addr + size) < hi;

I think the hi check is off by one? Should be `(addr + size + 1) < hi`
or `<=`) right? Otherwise we reject a valid read against the last
address in the CMB.

Also, a check for wrap-around is missing (`hi < addr` post-addition).

Anyway, I would really prefer that we do not change nvme_addr_is_cmb
since it is a useful function on its own. I use it a lot in my PRP
mapping refactor and SGL patches, so I would need to re-add another
function that does what nvme_addr_is_cmb used to do.

But, see my next comment.

>  }
>  
>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
> -    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
> -        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
> +    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
> +    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr, size)) {
> +        memcpy(buf, (void *)&n->cmbuf[addr - cmb_addr], size);
>          return;
>      }

I would prefer that we do the range check here (nvme_addr_read already has the
size parameter) and have nvme_addr_read return a success/fail value. E.g.

     static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
     {
    -    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
    +    hwaddr hi = addr + size - 1;
    +    if (hi < addr) {
    +        return 1;
    +    }
    +
    +    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {
             memcpy(buf, nvme_addr_to_cmb(n, addr), size);
             return 0;
         }

Actually, since the controller only support PRPs at this stage, it is
not required to check the ending address (addr + len - 1) of the CMB access for
validity since it is guaranteed to be in range of the CMB (nvme_addr_read is
only used for reading PRPs and they never cross a page boundary so size is
always <= page_size and the CMB is always at least 4k aligned).

This change is really only needed when the controller adds support for SGLs,
which is why I have the above in my tree that supports SGLs.

Come to think of it, the above might not even be sufficient since if just one
of the nvme_addr_is_cmb checks fails, we end up issuing an invalid
pci_dma_read. But I think that it will error out gracefully on that. But
this needs to be checked.

I suggest that you just drop the size check from this patch since it's not
needed and might need more work to be safe in the context of SGLs anyway.

>  
> @@ -167,17 +168,18 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                               uint64_t prp2, uint32_t len, NvmeCtrl *n)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
> +    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
>      trans_len = MIN(len, trans_len);
>      int num_prps = (len >> n->page_bits) + 1;
>  
>      if (unlikely(!prp1)) {
>          trace_pci_nvme_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
> -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
> +    } else if (n->bar.cmbsz && prp1 >= cmb_addr &&
> +               prp1 < cmb_addr + int128_get64(n->bar4.size)) {
>          qsg->nsg = 0;
>          qemu_iovec_init(iov, num_prps);
> -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
> +        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - cmb_addr], trans_len);
>      } else {
>          pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
>          qemu_sglist_add(qsg, prp1, trans_len);
> @@ -222,7 +224,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                  if (qsg->nsg){
>                      qemu_sglist_add(qsg, prp_ent, trans_len);
>                  } else {
> -                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
> +                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - cmb_addr],
> +                                   trans_len);
>                  }
>                  len -= trans_len;
>                  i++;
> @@ -235,7 +238,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>              if (qsg->nsg) {
>                  qemu_sglist_add(qsg, prp2, len);
>              } else {
> -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
> +                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - cmb_addr],
> +                               trans_len);
>              }
>          }
>      }
> @@ -1395,7 +1399,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
>          return;
>      }
>  
> -    if (!n->params.cmb_size_mb && n->pmrdev) {
> +    if (n->pmrdev) {
>          if (host_memory_backend_is_mapped(n->pmrdev)) {
>              char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
>              error_setg(errp, "can't use already busy memdev: %s", path);
> @@ -1453,33 +1457,62 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>      id_ns->nuse = id_ns->ncap;
>  }
>  
> -static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> +static void nvme_bar4_init(PCIDevice *pci_dev, Error **errp)
>  {
> -    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
> -    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> -
> -    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> -    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> -    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> -    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> -    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> -    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> -    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> -
> -    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> -                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> +    NvmeCtrl *n = NVME(pci_dev);
> +    int status;
> +    uint64_t bar_size;
> +    uint32_t msix_vectors;
> +    uint32_t nvme_pba_offset;
> +    uint32_t cmb_size_units;
> +
> +    msix_vectors = n->params.max_ioqpairs + 1;
> +    nvme_pba_offset = PCI_MSIX_ENTRY_SIZE * msix_vectors;
> +    bar_size = nvme_pba_offset + QEMU_ALIGN_UP(msix_vectors, 64) / 8;
> +
> +    if (n->params.cmb_size_mb) {
> +        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> +        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> +        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> +        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> +        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> +        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> +        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> +
> +        cmb_size_units = NVME_CMBSZ_GETSIZEUNITS(n->bar.cmbsz);
> +        n->cmb_offset = QEMU_ALIGN_UP(bar_size, cmb_size_units);
> +
> +        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_MSIX_BIR);
> +        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, n->cmb_offset / cmb_size_units);
> +
> +        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +
> +        bar_size += n->cmb_offset;
> +        bar_size += NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
> +    }
> +
> +    bar_size = pow2ceil(bar_size);
> +
> +    memory_region_init_io(&n->bar4, OBJECT(n), &nvme_cmb_ops, n,
> +                          "nvme-bar4", bar_size);
> +
> +    status = msix_init(pci_dev, n->params.max_ioqpairs + 1,
> +                       &n->bar4, NVME_MSIX_BIR, 0,
> +                       &n->bar4, NVME_MSIX_BIR, nvme_pba_offset,
> +                       0, errp);

This needs to use n->params.msix_qsize instead of
n->params.max_ioqpairs.

> +
> +    if (status) {
> +        return;
> +    }
> +
> +    pci_register_bar(pci_dev, NVME_MSIX_BIR,
>                       PCI_BASE_ADDRESS_SPACE_MEMORY |
>                       PCI_BASE_ADDRESS_MEM_TYPE_64 |
> -                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> +                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->bar4);
>  }
>  
>  static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
>  {
> -    /* Controller Capabilities register */
> -    NVME_CAP_SET_PMRS(n->bar.cap, 1);
> -
>      /* PMR Capabities register */
>      n->bar.pmrcap = 0;
>      NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
> @@ -1537,13 +1570,10 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>                            n->reg_size);
>      pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                       PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
> -    if (msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, errp)) {
> -        return;
> -    }
>  
> -    if (n->params.cmb_size_mb) {
> -        nvme_init_cmb(n, pci_dev);
> -    } else if (n->pmrdev) {
> +    nvme_bar4_init(pci_dev, errp);
> +
> +    if (n->pmrdev) {
>          nvme_init_pmr(n, pci_dev);
>      }
>  }
> @@ -1583,6 +1613,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>      NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
> +    NVME_CAP_SET_PMRS(n->bar.cap, n->pmrdev ? 1 : 0);
>  
>      n->bar.vs = 0x00010200;
>      n->bar.intmc = n->bar.intms = 0;
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 1d30c0bca2..0ea8cf32a3 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -80,7 +80,7 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
>  typedef struct NvmeCtrl {
>      PCIDevice    parent_obj;
>      MemoryRegion iomem;
> -    MemoryRegion ctrl_mem;
> +    MemoryRegion bar4;
>      NvmeBar      bar;
>      BlockConf    conf;
>      NvmeParams   params;
> @@ -94,6 +94,7 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> +    uint32_t    cmb_offset;
>      uint8_t     *cmbuf;
>      uint32_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 14cf398dfa..76d15bdf9f 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -216,9 +216,11 @@ enum NvmeCmbszMask {
>      (cmbsz |= (uint64_t)(val & CMBSZ_SZU_MASK) << CMBSZ_SZU_SHIFT)
>  #define NVME_CMBSZ_SET_SZ(cmbsz, val)    \
>      (cmbsz |= (uint64_t)(val & CMBSZ_SZ_MASK) << CMBSZ_SZ_SHIFT)
> +#define NVME_CMBSZ_GETSIZEUNITS(cmbsz) \
> +    (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz)))
>  
>  #define NVME_CMBSZ_GETSIZE(cmbsz) \
> -    (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
> +    (NVME_CMBSZ_SZ(cmbsz) * NVME_CMBSZ_GETSIZEUNITS(cmbsz))
>  
>  enum NvmePmrcapShift {
>      PMRCAP_RDS_SHIFT      = 3,
> -- 
> 2.21.1
> 
> 

