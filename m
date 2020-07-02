Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3ABC20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3ABC20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwEZ-0003XP-Vc
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqwDi-0002jI-B5; Thu, 02 Jul 2020 06:13:30 -0400
Received: from charlie.dont.surf ([128.199.63.193]:51342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqwDd-0005XH-QI; Thu, 02 Jul 2020 06:13:29 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 0C6F1BF64C;
 Thu,  2 Jul 2020 10:13:21 +0000 (UTC)
Date: Thu, 2 Jul 2020 12:13:18 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 06:13:22
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

On Jul  1 14:48, Andrzej Jakowski wrote:
> So far it was not possible to have CMB and PMR emulated on the same
> device, because BAR2 was used exclusively either of PMR or CMB. This
> patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
> 

Linux craps out when I test this (1MB CMB):

Misaligned __add_pages start: 0xfdd00 end: #fdeff

I tracked it down to check_pfn_span (mm/memory_hotplug.c) failing
because it's not on a 2MB boundary. I then tried to monkey patch the
cmb_offset to be 2MB instead and it succeeds in registering the cmb:

[    8.384565] memmap_init_zone_device initialised 512 pages in 0ms
[    8.385715] nvme 0000:03:00.0: added peer-to-peer DMA memory [mem 0xfd200000-0xfd3fffff 64bit
pref]
[    8.419372] nvme nvme0: 1/0/0 default/read/poll queues

But the kernel then continues to really crap out with a kernel panic:

[    8.440891] DMAR: DRHD: handling fault status reg 2
[    8.440934] BUG: kernel NULL pointer dereference, address: 0000000000000120
[    8.441713] DMAR: [DMA Read] Request device [03:00.0] PASID ffffffff fault addr fd200000 [faul
t reason 06] PTE Read access is not set
[    8.442630] #PF: supervisor write access in kernel mode
[    8.444972] #PF: error_code(0x0002) - not-present page
[    8.445640] PGD 0 P4D 0
[    8.445965] Oops: 0002 [#1] PREEMPT SMP PTI
[    8.446499] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.8.0-rc1-00034-gb6cf9836d07f-dirty #19
[    8.447547] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb0
2-prebuilt.qemu.org 04/01/2014
[    8.448898] RIP: 0010:nvme_process_cq+0xc4/0x200 [nvme]
[    8.449525] Code: cf 00 00 00 48 8b 57 70 48 8b 7c c2 f8 e8 14 e9 32 c1 49 89 c7 0f 1f 44 00 0
0 41 0f b7 44 24 0e 49 8b 14 24 4c 89 ff 66 d1 e8 <49> 89 97 20 01 00 00 66 41 89 87 2a 01 00 00
e8 28 04 33 c1 0f b7
[    8.451662] RSP: 0018:ffffc9000015cf20 EFLAGS: 00010803
[    8.452321] RAX: 000000000000400b RBX: ffff88826faad0c0 RCX: 0000000000000000
[    8.453293] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    8.454312] RBP: ffff8882725d38e4 R08: 00000001f71e225c R09: 0000000000000000
[    8.455319] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888270bb0000
[    8.456334] R13: 0000000000000000 R14: ffffc9000015cfac R15: 0000000000000000
[    8.457311] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS:0000000000000000
[    8.458441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.459380] CR2: 0000000000000120 CR3: 0000000271c8c006 CR4: 0000000000360ee0
[    8.460507] Call Trace:
[    8.460906]  <IRQ>
[    8.461272]  nvme_irq+0x10/0x20 [nvme]
[    8.461951]  __handle_irq_event_percpu+0x45/0x1b0
[    8.462803]  ? handle_fasteoi_irq+0x210/0x210
[    8.463585]  handle_irq_event+0x58/0xb0
[    8.464312]  handle_edge_irq+0xae/0x270
[    8.465027]  asm_call_on_stack+0x12/0x20
[    8.465686]  </IRQ>
[    8.466053]  common_interrupt+0x120/0x1f0
[    8.466717]  asm_common_interrupt+0x1e/0x40
[    8.467429] RIP: 0010:default_idle+0x21/0x170
[    8.468140] Code: eb a6 e8 82 27 ff ff cc cc 0f 1f 44 00 00 41 54 55 53 e8 e2 2e ff ff 0f 1f 4
4 00 00 e9 07 00 00 00 0f 00 2d f3 d4 44 00 fb f4 <e8> ca 2e ff ff 89 c5 0f 1f 44 00 00 5b 5d 41
5c c3 89 c5 65 8b 05
[    8.471286] RSP: 0018:ffffc9000009fec8 EFLAGS: 00000282
[    8.472202] RAX: 0000000000000003 RBX: ffff888276ff0000 RCX: 0000000000000001
[    8.473405] RDX: 0000000000000001 RSI: ffffffff8212355f RDI: ffffffff8212d699
[    8.474571] RBP: 0000000000000003 R08: ffff888277d9e4a0 R09: 0000000000000020
[    8.475717] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    8.476921] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    8.478110]  ? default_idle+0xe/0x170
[    8.478728]  do_idle+0x1e1/0x240
[    8.479283]  ? _raw_spin_lock_irqsave+0x19/0x40
[    8.480040]  cpu_startup_entry+0x19/0x20
[    8.480705]  start_secondary+0x153/0x190
[    8.481400]  secondary_startup_64+0xb6/0xc0
[    8.482114] Modules linked in: libata nvme nvme_core scsi_mod t10_pi crc_t10dif crct10dif_gene
ric crct10dif_common virtio_net net_failover failover virtio_rng rng_core
[    8.484675] CR2: 0000000000000120
[    8.485264] ---[ end trace ff1849437c76af12 ]---
[    8.486065] RIP: 0010:nvme_process_cq+0xc4/0x200 [nvme]
[    8.486953] Code: cf 00 00 00 48 8b 57 70 48 8b 7c c2 f8 e8 14 e9 32 c1 49 89 c7 0f 1f 44 00 0
0 41 0f b7 44 24 0e 49 8b 14 24 4c 89 ff 66 d1 e8 <49> 89 97 20 01 00 00 66 41 89 87 2a 01 00 00
e8 28 04 33 c1 0f b7
[    8.490234] RSP: 0018:ffffc9000015cf20 EFLAGS: 00010803
[    8.491144] RAX: 000000000000400b RBX: ffff88826faad0c0 RCX: 0000000000000000
[    8.492445] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    8.493681] RBP: ffff8882725d38e4 R08: 00000001f71e225c R09: 0000000000000000
[    8.494907] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888270bb0000
[    8.496130] R13: 0000000000000000 R14: ffffc9000015cfac R15: 0000000000000000
[    8.497363] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS:0000000000000000
[    8.498726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.499713] CR2: 0000000000000120 CR3: 0000000271c8c006 CR4: 0000000000360ee0
[    8.500935] Kernel panic - not syncing: Fatal exception in interrupt
[    8.502113] Kernel Offset: disabled
[    8.502728] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

I'm out of my depth here, but the CMB/BAR offsets/setup seems sane enough -
could this be a kernel bug?

Keith, any thoughts on this?

> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
>  hw/block/nvme.c      | 101 +++++++++++++++++++++++++++++--------------
>  hw/block/nvme.h      |   1 +
>  include/block/nvme.h |   4 +-
>  3 files changed, 72 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9f11f3e9da..f5156bcfe5 100644
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
> @@ -1395,7 +1395,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
>          return;
>      }
>  
> -    if (!n->params.cmb_size_mb && n->pmrdev) {
> +    if (n->pmrdev) {
>          if (host_memory_backend_is_mapped(n->pmrdev)) {
>              char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
>              error_setg(errp, "can't use already busy memdev: %s", path);
> @@ -1453,33 +1453,70 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
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
> +    uint64_t bar_size, cmb_offset = 0;
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
> +        cmb_offset = QEMU_ALIGN_UP(bar_size, cmb_size_units);
> +
> +        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_MSIX_BIR);
> +        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, cmb_offset / cmb_size_units);
> +
> +        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +
> +        bar_size += cmb_offset;
> +        bar_size += NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
> +    }
> +
> +    bar_size = pow2ceil(bar_size);
> +
> +    /* Create memory region for BAR4, then overlap cmb, msix and pba
> +     * tables on top of it.*/
> +    memory_region_init(&n->bar4, OBJECT(n), "nvme-bar4", bar_size);
> +
> +    if (n->params.cmb_size_mb) {
> +        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> +                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +
> +        memory_region_add_subregion(&n->bar4, cmb_offset, &n->ctrl_mem);
> +    }
> +
> +    status = msix_init(pci_dev, n->params.msix_qsize,
> +                       &n->bar4, NVME_MSIX_BIR, 0,
> +                       &n->bar4, NVME_MSIX_BIR, nvme_pba_offset,
> +                       0, errp);
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
> @@ -1537,13 +1574,10 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
> @@ -1583,6 +1617,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>      NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
> +    NVME_CAP_SET_PMRS(n->bar.cap, n->pmrdev ? 1 : 0);
>  
>      n->bar.vs = 0x00010200;
>      n->bar.intmc = n->bar.intms = 0;
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 1d30c0bca2..b2b9d727a5 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -81,6 +81,7 @@ typedef struct NvmeCtrl {
>      PCIDevice    parent_obj;
>      MemoryRegion iomem;
>      MemoryRegion ctrl_mem;
> +    MemoryRegion bar4;
>      NvmeBar      bar;
>      BlockConf    conf;
>      NvmeParams   params;
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

