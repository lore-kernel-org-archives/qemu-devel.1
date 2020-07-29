Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440F7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183082068F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183082068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0svF-0004w6-Ca
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0ss3-0003SS-1O; Wed, 29 Jul 2020 16:40:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:47693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0ss0-0004zj-LX; Wed, 29 Jul 2020 16:40:14 -0400
IronPort-SDR: 40ZBH56V3WroBNYT9SiRYFGnLAiWyg7SzULWXjqsTY/JpV75d0AM+vKlla0Rb/LQGu+/KoJpCq
 v07of32H4r7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="215981945"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="215981945"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 13:40:06 -0700
IronPort-SDR: QYVtkcIcHQfCz0BlyK47aWjqqPRC3KsYUaPvq9FJRts2sgA3gJsNa3CgIzdYP30N7tJ9P9rXOg
 WHzQhI2fgH7g==
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="394768725"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.191.249])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 13:40:06 -0700
Subject: Re: [PATCH 02/16] hw/block/nvme: add mapping helpers
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-3-its@irrelevant.dk>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <b5e82d6a-471e-8894-f418-73f7d99094da@linux.intel.com>
Date: Wed, 29 Jul 2020 13:40:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720113748.322965-3-its@irrelevant.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 16:40:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 4:37 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
> use them in nvme_map_prp.
> 
> This fixes a bug where in the case of a CMB transfer, the device would
> map to the buffer with a wrong length.
> 
> Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 109 +++++++++++++++++++++++++++++++++++-------
>  hw/block/trace-events |   2 +
>  2 files changed, 94 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 4d7b730a62b6..9b1a080cdc70 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -109,6 +109,11 @@ static uint16_t nvme_sqid(NvmeRequest *req)
>      return le16_to_cpu(req->sq->sqid);
>  }
>  
> +static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
> +{
> +    return &n->cmbuf[addr - n->ctrl_mem.addr];
> +}
> +
>  static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  {
>      hwaddr low = n->ctrl_mem.addr;
> @@ -120,7 +125,7 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
>      if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
> -        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
> +        memcpy(buf, nvme_addr_to_cmb(n, addr), size);
>          return;
>      }
>  
> @@ -203,29 +208,91 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
>      }
>  }
>  
> +static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
> +                                  size_t len)
> +{
> +    if (!len) {
> +        return NVME_SUCCESS;
> +    }
> +
> +    trace_pci_nvme_map_addr_cmb(addr, len);
> +
> +    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len - 1)) {
> +        return NVME_DATA_TRAS_ERROR;
> +    }
> +
> +    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> +                              hwaddr addr, size_t len)
> +{
> +    if (!len) {
> +        return NVME_SUCCESS;
> +    }
> +
> +    trace_pci_nvme_map_addr(addr, len);
> +
> +    if (nvme_addr_is_cmb(n, addr)) {
> +        if (qsg && qsg->sg) {
> +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +        }
> +
> +        assert(iov);
> +
> +        if (!iov->iov) {
> +            qemu_iovec_init(iov, 1);
> +        }
> +
> +        return nvme_map_addr_cmb(n, iov, addr, len);
> +    }
> +
> +    if (iov && iov->iov) {
> +        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +    }
> +
> +    assert(qsg);
> +
> +    if (!qsg->sg) {
> +        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
> +    }
> +
> +    qemu_sglist_add(qsg, addr, len);
> +
> +    return NVME_SUCCESS;
> +}
> +
>  static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                               uint64_t prp2, uint32_t len, NvmeCtrl *n)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>      trans_len = MIN(len, trans_len);
>      int num_prps = (len >> n->page_bits) + 1;
> +    uint16_t status;
>  
>      if (unlikely(!prp1)) {
>          trace_pci_nvme_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
> -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
> -        qsg->nsg = 0;
> +    }
> +
> +    if (nvme_addr_is_cmb(n, prp1)) {
>          qemu_iovec_init(iov, num_prps);
> -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
>      } else {
>          pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> -        qemu_sglist_add(qsg, prp1, trans_len);
>      }
> +
> +    status = nvme_map_addr(n, qsg, iov, prp1, trans_len);
> +    if (status) {
> +        goto unmap;
> +    }
> +
>      len -= trans_len;
>      if (len) {
>          if (unlikely(!prp2)) {
>              trace_pci_nvme_err_invalid_prp2_missing();
> +            status = NVME_INVALID_FIELD | NVME_DNR;
>              goto unmap;
>          }
>          if (len > n->page_size) {
> @@ -242,6 +309,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                  if (i == n->max_prp_ents - 1 && len > n->page_size) {
>                      if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                          trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
> +                        status = NVME_INVALID_FIELD | NVME_DNR;
>                          goto unmap;
>                      }
>  
> @@ -255,14 +323,14 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>  
>                  if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                      trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
> +                    status = NVME_INVALID_FIELD | NVME_DNR;
>                      goto unmap;
>                  }
>  
>                  trans_len = MIN(len, n->page_size);
> -                if (qsg->nsg){
> -                    qemu_sglist_add(qsg, prp_ent, trans_len);
> -                } else {
> -                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
> +                status = nvme_map_addr(n, qsg, iov, prp_ent, trans_len);
> +                if (status) {
> +                    goto unmap;
>                  }
>                  len -= trans_len;
>                  i++;
> @@ -270,20 +338,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>          } else {
>              if (unlikely(prp2 & (n->page_size - 1))) {
>                  trace_pci_nvme_err_invalid_prp2_align(prp2);
> +                status = NVME_INVALID_FIELD | NVME_DNR;
>                  goto unmap;
>              }
> -            if (qsg->nsg) {
> -                qemu_sglist_add(qsg, prp2, len);
> -            } else {
> -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
> +            status = nvme_map_addr(n, qsg, iov, prp2, len);
> +            if (status) {
> +                goto unmap;
>              }
>          }
>      }
>      return NVME_SUCCESS;
>  
> - unmap:
> -    qemu_sglist_destroy(qsg);
> -    return NVME_INVALID_FIELD | NVME_DNR;
> +unmap:
> +    if (iov && iov->iov) {
> +        qemu_iovec_destroy(iov);
> +    }
> +
> +    if (qsg && qsg->sg) {
> +        qemu_sglist_destroy(qsg);
> +    }
> +
> +    return status;

I think it would make sense to move whole unmap block to a separate function.
That function could be called from here and after completing IO and would contain
unified deinitialization block - so no code repetitions would be necessary.
Other than that it looks good to me. Thx!

Reviewed-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>

>  }
>  
>  static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 7b7303cab1dd..f3b2d004e078 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -33,6 +33,8 @@ pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>  pci_nvme_irq_pin(void) "pulsing IRQ pin"
>  pci_nvme_irq_masked(void) "IRQ is masked"
>  pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> +pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
> +pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
>  pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
>  pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
>  pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> 


