Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C885920772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMdN036J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C885920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3TO-0001SJ-Ur
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3SN-00089K-NX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3SL-0001n2-Op
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3SL-0001m5-LN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sBL/8GIpl/NGS2/jC48IRqMZMS1LzNXWFjmSHIn/sI=;
 b=VMdN036JvQvzg8LUUXEjuxcxkcBuR9CKDUVwjhOYp726KbO9iCtYShbdTkP+CRpdH0w8ba
 uiFNpat2+E51wrbF7TW4rmycglA+1XHJ8dk/GlRcH46gWPbXiHQRYsqTtUPTzJACuaFh7R
 H7T9dr764H/ivJ4Xv9/v03nA4GtjK5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-G-j9GHJqN5ilOHIbvpuwQw-1; Wed, 25 Mar 2020 06:40:08 -0400
X-MC-Unique: G-j9GHJqN5ilOHIbvpuwQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 351F7107ACCC;
 Wed, 25 Mar 2020 10:40:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A180C5DA7C;
 Wed, 25 Mar 2020 10:40:01 +0000 (UTC)
Message-ID: <90747b4189423d1f29917e8980b91373f6eb6523.camel@redhat.com>
Subject: Re: [PATCH v6 10/42] nvme: refactor device realization
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:40:00 +0200
In-Reply-To: <20200316142928.153431-11-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-11-its@irrelevant.dk>
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
> This patch splits up nvme_realize into multiple individual functions,
> each initializing a different subset of the device.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c | 178 ++++++++++++++++++++++++++++++------------------
>  hw/block/nvme.h |  23 ++++++-
>  2 files changed, 134 insertions(+), 67 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7dfd8a1a392d..665485045066 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -44,6 +44,8 @@
>  #include "trace.h"
>  #include "nvme.h"
>  
> +#define NVME_CMB_BIR 2
> +
>  #define NVME_GUEST_ERR(trace, fmt, ...) \
>      do { \
>          (trace_##trace)(__VA_ARGS__); \
> @@ -63,7 +65,7 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  
>  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
>  {
> -    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> +    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
>          memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
>          return;
>      }
> @@ -157,7 +159,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>      if (unlikely(!prp1)) {
>          trace_nvme_dev_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
> +    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
>                 prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
>          qsg->nsg = 0;
>          qemu_iovec_init(iov, num_prps);
> @@ -1324,14 +1326,9 @@ static const MemoryRegionOps nvme_cmb_ops = {
>      },
>  };
>  
> -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
>  {
> -    NvmeCtrl *n = NVME(pci_dev);
> -    NvmeIdCtrl *id = &n->id_ctrl;
> -
> -    int i;
> -    int64_t bs_size;
> -    uint8_t *pci_conf;
> +    NvmeParams *params = &n->params;
>  
>      if (n->params.num_queues) {
>          warn_report("nvme: num_queues is deprecated; please use max_ioqpairs "
> @@ -1340,57 +1337,100 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          n->params.max_ioqpairs = n->params.num_queues - 1;
>      }
>  
> -    if (!n->params.max_ioqpairs) {
> -        error_setg(errp, "max_ioqpairs can't be less than 1");
> +    if (params->max_ioqpairs < 1 ||
> +        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
> +        error_setg(errp, "nvme: max_ioqpairs must be ");
Looks like the error message is not complete now.
> +        return -1;
>      }
>  
>      if (!n->conf.blk) {
> -        error_setg(errp, "drive property not set");
> -        return;
> +        error_setg(errp, "nvme: block backend not configured");
> +        return -1;
>      }
>  
> -    bs_size = blk_getlength(n->conf.blk);
> -    if (bs_size < 0) {
> -        error_setg(errp, "could not get backing file size");
> -        return;
> +    if (!params->serial) {
> +        error_setg(errp, "nvme: serial not configured");
> +        return -1;
>      }
>  
> -    if (!n->params.serial) {
> -        error_setg(errp, "serial property not set");
> -        return;
> -    }
> +    return 0;
> +}
> +
> +static int nvme_init_blk(NvmeCtrl *n, Error **errp)
> +{
>      blkconf_blocksizes(&n->conf);
>      if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
>                                         false, errp)) {
> -        return;
> +        return -1;
>      }
>  
> -    pci_conf = pci_dev->config;
> -    pci_conf[PCI_INTERRUPT_PIN] = 1;
> -    pci_config_set_prog_interface(pci_dev->config, 0x2);
> -    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
> -    pcie_endpoint_cap_init(pci_dev, 0x80);
> +    return 0;
> +}
>  
> +static void nvme_init_state(NvmeCtrl *n)
> +{
>      n->num_namespaces = 1;
>      n->reg_size = pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
> -    n->ns_size = bs_size / (uint64_t)n->num_namespaces;
> -
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>      n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
>      n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> +}
>  
> -    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
> -                          "nvme", n->reg_size);
> -    pci_register_bar(pci_dev, 0,
> -        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
> -        &n->iomem);
> +static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
> +    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> +
> +    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> +    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> +    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
> +    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> +
> +    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> +                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> +    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> +}
> +
> +static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
> +{
> +    uint8_t *pci_conf = pci_dev->config;
> +
> +    pci_conf[PCI_INTERRUPT_PIN] = 1;
> +    pci_config_set_prog_interface(pci_conf, 0x2);
> +    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> +    pci_config_set_device_id(pci_conf, 0x5845);
> +    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
> +    pcie_endpoint_cap_init(pci_dev, 0x80);
> +
> +    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
> +                          n->reg_size);
> +    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
>      msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
>  
> +    if (n->params.cmb_size_mb) {
> +        nvme_init_cmb(n, pci_dev);
> +    }
> +}
> +
> +static void nvme_init_ctrl(NvmeCtrl *n)
> +{
> +    NvmeIdCtrl *id = &n->id_ctrl;
> +    NvmeParams *params = &n->params;
> +    uint8_t *pci_conf = n->parent_obj.config;
> +
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
>      strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
>      strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
> -    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
> +    strpadcpy((char *)id->sn, sizeof(id->sn), params->serial, ' ');
>      id->rab = 6;
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
> @@ -1431,46 +1471,54 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>  
>      n->bar.vs = 0x00010200;
>      n->bar.intmc = n->bar.intms = 0;
> +}
>  
> -    if (n->params.cmb_size_mb) {
> +static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> +{
> +    int64_t bs_size;
> +    NvmeIdNs *id_ns = &ns->id_ns;
>  
> -        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
> -        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> +    bs_size = blk_getlength(n->conf.blk);
> +    if (bs_size < 0) {
> +        error_setg_errno(errp, -bs_size, "blk_getlength");
> +        return -1;
> +    }
>  
> -        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> -        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> -        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> -        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> -        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> +    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> +    n->ns_size = bs_size;
>  
> -        n->cmbloc = n->bar.cmbloc;
> -        n->cmbsz = n->bar.cmbsz;
> +    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
>  
> -        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> -                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> -            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
> -            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> +    /* no thin provisioning */
> +    id_ns->ncap = id_ns->nsze;
> +    id_ns->nuse = id_ns->ncap;
>  
> +    return 0;
> +}
> +
> +static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    NvmeCtrl *n = NVME(pci_dev);
> +    int i;
> +
> +    if (nvme_check_constraints(n, errp)) {
> +        return;
> +    }
> +
> +    nvme_init_state(n);
> +
> +    if (nvme_init_blk(n, errp)) {
> +        return;
>      }
>  
>      for (i = 0; i < n->num_namespaces; i++) {
> -        NvmeNamespace *ns = &n->namespaces[i];
> -        NvmeIdNs *id_ns = &ns->id_ns;
> -        id_ns->nsfeat = 0;
> -        id_ns->nlbaf = 0;
> -        id_ns->flbas = 0;
> -        id_ns->mc = 0;
> -        id_ns->dpc = 0;
> -        id_ns->dps = 0;
> -        id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> -        id_ns->ncap  = id_ns->nuse = id_ns->nsze =
> -            cpu_to_le64(n->ns_size >>
> -                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
> +        if (nvme_init_namespace(n, &n->namespaces[i], errp)) {
> +            return;
> +        }
>      }
> +
> +    nvme_init_pci(n, pci_dev);
> +    nvme_init_ctrl(n);
>  }
>  
>  static void nvme_exit(PCIDevice *pci_dev)
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 98f5b9479244..b7c465560eea 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -67,6 +67,22 @@ typedef struct NvmeNamespace {
>      NvmeIdNs        id_ns;
>  } NvmeNamespace;
>  
> +static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> +{
> +    NvmeIdNs *id_ns = &ns->id_ns;
> +    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> +}
> +
> +static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> +{
> +    return nvme_ns_lbaf(ns)->ds;
> +}
> +
> +static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
> +{
> +    return 1 << nvme_ns_lbads(ns);
> +}
> +
>  #define TYPE_NVME "nvme"
>  #define NVME(obj) \
>          OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> @@ -88,8 +104,6 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> -    uint32_t    cmbsz;
> -    uint32_t    cmbloc;
>      uint8_t     *cmbuf;
>      uint64_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> @@ -103,4 +117,9 @@ typedef struct NvmeCtrl {
>      NvmeIdCtrl      id_ctrl;
>  } NvmeCtrl;
>  
> +static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    return n->ns_size >> nvme_ns_lbads(ns);
> +}
> +
>  #endif /* HW_NVME_H */

Small nitpick: To be honest this not only refactoring in the device realization since you also (rightfully)
removed the duplicated cmbsz/cmbloc so I would add a mention for this in the commit message.
But that doesn't matter that much, so

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky






