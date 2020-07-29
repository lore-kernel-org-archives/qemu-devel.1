Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4182CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4B92083E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSvUVLD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4B92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mbX-0002zy-9z
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0mag-0001Z4-By
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:57:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27403
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0mad-0005GF-4h
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596031069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yJ1iH0CYopzN1xqwRMo6jREFfHfTBwgxYHAkYKBdgM=;
 b=hSvUVLD9W3Vx2CXBTwA1XG7nJR8iy09MB5uOdIxP2nFKI29DzObyCGYfYAiQo1xW6zTpRm
 sxtBWFuzPByTU9mBwUZrSDn77al4lhZy5xiy/hyy+UGvzK7WsS46yAyerNOqjA7s6qn0jI
 b7GowQaVnD1uO62UStgHoaK7eA1jP40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-W1uUwzDeMD2Xx3SZbuy4mQ-1; Wed, 29 Jul 2020 09:57:47 -0400
X-MC-Unique: W1uUwzDeMD2Xx3SZbuy4mQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3E408912F3;
 Wed, 29 Jul 2020 13:57:45 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF22610013C4;
 Wed, 29 Jul 2020 13:57:41 +0000 (UTC)
Message-ID: <0d7e4cb66c28d89b4bd5362d3f133f02287fac13.camel@redhat.com>
Subject: Re: [PATCH 02/16] hw/block/nvme: add mapping helpers
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Wed, 29 Jul 2020 16:57:40 +0300
In-Reply-To: <20200720113748.322965-3-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-3-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
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
I would add an assert here just in case we do out of bounds array access.
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
OK.
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
OK
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
OK
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

Looks good. I could have missed something, but compared to older version of similiar code I reviewed, 
this looks much better and easy to t understand.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


