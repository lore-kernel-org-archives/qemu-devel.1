Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E6DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CF820775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3GKQCYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CF820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Q8-0003Qy-Bd
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Ok-0001vA-Sf
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Oj-0007RU-1i
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:36:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23385)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Oi-0007QF-7Q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXoVgNrHhfl93vtNgtQ9I+IRtlcqK7vUYbrQwFMyHOM=;
 b=T3GKQCYhglKLhTiV1sNhRMmDI/Skhdg/+3kCCHlMFLhBc5DK5c1weEF4AvjPLGdoQXOfAM
 63acrH2YnktgxF1vfMIqNDJhiX9yg8oZhv0WVahkRMpGXQ9C5kWVx1BbDEoUSCt8uD4vI2
 gfUxQ0RqdnLUw8clUyueBxh5t/bIbM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-hrk8NQENOUqXCZOqMXEZEg-1; Wed, 25 Mar 2020 06:36:30 -0400
X-MC-Unique: hrk8NQENOUqXCZOqMXEZEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFC2E18C8C01;
 Wed, 25 Mar 2020 10:36:28 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFF905D9C5;
 Wed, 25 Mar 2020 10:36:26 +0000 (UTC)
Message-ID: <59011b73f432e5a734936263a63cb2570db08b50.camel@redhat.com>
Subject: Re: [PATCH v6 03/42] nvme: move device parameters to separate struct
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:36:25 +0200
In-Reply-To: <20200316142928.153431-4-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-4-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Move device configuration parameters to separate struct to make it
> explicit what is configurable and what is set internally.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 44 ++++++++++++++++++++++----------------------
>  hw/block/nvme.h | 16 +++++++++++++---
>  2 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9740948b354a..b532818b4b76 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -64,12 +64,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  
>  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
>  {
> -    return sqid < n->num_queues && n->sq[sqid] != NULL ? 0 : -1;
> +    return sqid < n->params.num_queues && n->sq[sqid] != NULL ? 0 : -1;
>  }
>  
>  static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
>  {
> -    return cqid < n->num_queues && n->cq[cqid] != NULL ? 0 : -1;
> +    return cqid < n->params.num_queues && n->cq[cqid] != NULL ? 0 : -1;
>  }
>  
>  static void nvme_inc_cq_tail(NvmeCQueue *cq)
> @@ -631,7 +631,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>          trace_nvme_dev_err_invalid_create_cq_addr(prp1);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> -    if (unlikely(vector > n->num_queues)) {
> +    if (unlikely(vector > n->params.num_queues)) {
>          trace_nvme_dev_err_invalid_create_cq_vector(vector);
>          return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
>      }
> @@ -783,7 +783,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> -        result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
> +        result = cpu_to_le32((n->params.num_queues - 2) |
> +                             ((n->params.num_queues - 2) << 16));
>          trace_nvme_dev_getfeat_numq(result);
>          break;
>      case NVME_TIMESTAMP:
> @@ -827,9 +828,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_NUMBER_OF_QUEUES:
>          trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
>                                      ((dw11 >> 16) & 0xFFFF) + 1,
> -                                    n->num_queues - 1, n->num_queues - 1);
> -        req->cqe.result =
> -            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
> +                                    n->params.num_queues - 1,
> +                                    n->params.num_queues - 1);
> +        req->cqe.result = cpu_to_le32((n->params.num_queues - 2) |
> +                                      ((n->params.num_queues - 2) << 16));
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> @@ -900,12 +902,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>  
>      blk_drain(n->conf.blk);
>  
> -    for (i = 0; i < n->num_queues; i++) {
> +    for (i = 0; i < n->params.num_queues; i++) {
>          if (n->sq[i] != NULL) {
>              nvme_free_sq(n->sq[i], n);
>          }
>      }
> -    for (i = 0; i < n->num_queues; i++) {
> +    for (i = 0; i < n->params.num_queues; i++) {
>          if (n->cq[i] != NULL) {
>              nvme_free_cq(n->cq[i], n);
>          }
> @@ -1308,7 +1310,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      int64_t bs_size;
>      uint8_t *pci_conf;
>  
> -    if (!n->num_queues) {
> +    if (!n->params.num_queues) {
>          error_setg(errp, "num_queues can't be zero");
>          return;
>      }
> @@ -1324,7 +1326,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          return;
>      }
>  
> -    if (!n->serial) {
> +    if (!n->params.serial) {
>          error_setg(errp, "serial property not set");
>          return;
>      }
> @@ -1341,25 +1343,25 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>  
>      n->num_namespaces = 1;
> -    n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
> +    n->reg_size = pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4);
>      n->ns_size = bs_size / (uint64_t)n->num_namespaces;
>  
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
> -    n->sq = g_new0(NvmeSQueue *, n->num_queues);
> -    n->cq = g_new0(NvmeCQueue *, n->num_queues);
> +    n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
> +    n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
>  
>      memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
>                            "nvme", n->reg_size);
>      pci_register_bar(pci_dev, 0,
>          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>          &n->iomem);
> -    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
> +    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
>  
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
>      strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
>      strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
> -    strpadcpy((char *)id->sn, sizeof(id->sn), n->serial, ' ');
> +    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
>      id->rab = 6;
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
> @@ -1388,7 +1390,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      n->bar.vs = 0x00010200;
>      n->bar.intmc = n->bar.intms = 0;
>  
> -    if (n->cmb_size_mb) {
> +    if (n->params.cmb_size_mb) {
>  
>          NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
>          NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> @@ -1399,7 +1401,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
>          NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
>          NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> -        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
> +        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
>  
>          n->cmbloc = n->bar.cmbloc;
>          n->cmbsz = n->bar.cmbsz;
> @@ -1438,7 +1440,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>      g_free(n->cq);
>      g_free(n->sq);
>  
> -    if (n->cmb_size_mb) {
> +    if (n->params.cmb_size_mb) {
>          g_free(n->cmbuf);
>      }
>      msix_uninit_exclusive_bar(pci_dev);
> @@ -1446,9 +1448,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>  
>  static Property nvme_props[] = {
>      DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
> -    DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
> -    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
> -    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
> +    DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 557194ee1954..9957c4a200e2 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -1,7 +1,19 @@
>  #ifndef HW_NVME_H
>  #define HW_NVME_H
> +
>  #include "block/nvme.h"
>  
> +#define DEFINE_NVME_PROPERTIES(_state, _props) \
> +    DEFINE_PROP_STRING("serial", _state, _props.serial), \
> +    DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
> +    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
> +
> +typedef struct NvmeParams {
> +    char     *serial;
> +    uint32_t num_queues;
> +    uint32_t cmb_size_mb;
> +} NvmeParams;
> +
>  typedef struct NvmeAsyncEvent {
>      QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
>      NvmeAerResult result;
> @@ -63,6 +75,7 @@ typedef struct NvmeCtrl {
>      MemoryRegion ctrl_mem;
>      NvmeBar      bar;
>      BlockConf    conf;
> +    NvmeParams   params;
>  
>      uint32_t    page_size;
>      uint16_t    page_bits;
> @@ -71,10 +84,8 @@ typedef struct NvmeCtrl {
>      uint16_t    sqe_size;
>      uint32_t    reg_size;
>      uint32_t    num_namespaces;
> -    uint32_t    num_queues;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> -    uint32_t    cmb_size_mb;
>      uint32_t    cmbsz;
>      uint32_t    cmbloc;
>      uint8_t     *cmbuf;
> @@ -82,7 +93,6 @@ typedef struct NvmeCtrl {
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
>      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
>  
> -    char            *serial;
>      NvmeNamespace   *namespaces;
>      NvmeSQueue      **sq;
>      NvmeCQueue      **cq;
Looks the same, the indention fixed indeed.
So this keeps my reviewed-by as well.

Best regards,
	Maxim Levitsky






