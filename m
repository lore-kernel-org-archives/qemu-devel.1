Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB5C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6880206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHZMpNAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6880206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcFw-00069I-VG
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcFM-0005f2-OH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcFK-0006c2-Uo
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:14:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcFK-0006bf-Qt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586934846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qU6MRHYDS/obZ26E8N/3CNm30oDrlK7GtENjusjZAvI=;
 b=MHZMpNAcTVezzUqsA5lrmURbWNNsR+ie2eArpyCnwWVMlafwSua1RK2RkkGwujWdf6I+jG
 gJ2lK0GxahcBwweT+SqRO+MaBZbldu51rfQ3q9roOEbv2yIvBz13q9f2Yeogi3E99F+MtP
 2rr5TswSZ88PHMB+31Ob+kKmMz+sXQ0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-je2k_E8HOp2r8okpC2PPag-1; Wed, 15 Apr 2020 03:14:04 -0400
X-MC-Unique: je2k_E8HOp2r8okpC2PPag-1
Received: by mail-ed1-f71.google.com with SMTP id ba30so2145863edb.6
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qU6MRHYDS/obZ26E8N/3CNm30oDrlK7GtENjusjZAvI=;
 b=eGDjzcbCb77m6I0Vs/6SBpOO7QT2Sy+P1fpf1F2syX8VyGvb4PhDFpZJIMUEcTP4Ng
 m+e1pZhdNcZkDH8EYo8z6a3Zpd/hH3p7J5I7r4frgo154Q8tcVEv0CaU+yd0vP5BzE5V
 lWap9wQ4F1/MkPJZBXOPuM42l3mWma5vwR8/GE7EP3x0r9WO97l5m+oyFSqQOUUYcZH7
 6SwSPs9LRlWBEAVk4FPqQUbbtu7r1hnbEY3QI82cYIMv7lXmJazuvB/NFN6YUKEro8GM
 1NcJTbP7KIiXqgTjbnBgJx7vSxz5bUWsnIyAH1XvCnRUdxSAdVqM01koTYlZSpIbs1q+
 SFiw==
X-Gm-Message-State: AGi0PuY+DF73yjfQiW+sueikWaqNfgtJXsgT/UiZHC4PsCzWFKeY+3H5
 Y+XYy5UNLOm6Ar9HsZuJFhKLZDZnNXwbWFZS4g4QXqCF6uxs4Ibgbz3PYC42bpkx7jMKrYCd1Wa
 xkJXMvCEz+LGDDkw=
X-Received: by 2002:a17:906:970e:: with SMTP id
 k14mr3722833ejx.202.1586934842949; 
 Wed, 15 Apr 2020 00:14:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJKXr5da94xwQH4YunO2/H/rUmMKkSy5YJ1XueJjY9mZjydhvSha/9KOAsnBIjOGeDFDMLJgw==
X-Received: by 2002:a17:906:970e:: with SMTP id
 k14mr3722816ejx.202.1586934842661; 
 Wed, 15 Apr 2020 00:14:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v5sm2022726edf.56.2020.04.15.00.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:14:02 -0700 (PDT)
Subject: Re: [PATCH v7 11/48] nvme: refactor device realization
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-12-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e79da783-872a-4cda-a33e-4ba795fb4a59@redhat.com>
Date: Wed, 15 Apr 2020 09:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-12-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 4/15/20 7:51 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This patch splits up nvme_realize into multiple individual functions,
> each initializing a different subset of the device.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
>   hw/block/nvme.c | 178 +++++++++++++++++++++++++++++++-----------------
>   hw/block/nvme.h |  21 ++++++
>   2 files changed, 136 insertions(+), 63 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 123539a5d0ae..d1c42ee4765c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -44,6 +44,8 @@
>   #include "trace.h"
>   #include "nvme.h"
>   
> +#define NVME_CMB_BIR 2
> +
>   #define NVME_GUEST_ERR(trace, fmt, ...) \
>       do { \
>           (trace_##trace)(__VA_ARGS__); \
> @@ -1322,73 +1324,112 @@ static const MemoryRegionOps nvme_cmb_ops = {
>       },
>   };
>   
> -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
>   {
> -    NvmeCtrl *n = NVME(pci_dev);
> -    NvmeIdCtrl *id = &n->id_ctrl;
> +    NvmeParams *params = &n->params;
>   
> -    int i;
> -    int64_t bs_size;
> -    uint8_t *pci_conf;
> -
> -    if (n->params.num_queues) {
> +    if (params->num_queues) {
>           warn_report("nvme: num_queues is deprecated; please use max_ioqpairs "
>                       "instead");
>   
> -        n->params.max_ioqpairs = n->params.num_queues - 1;
> +        params->max_ioqpairs = params->num_queues - 1;
>       }
>   
> -    if (!n->params.max_ioqpairs) {
> -        error_setg(errp, "max_ioqpairs can't be less than 1");
> +    if (params->max_ioqpairs < 1 ||
> +        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
> +        error_setg(errp, "nvme: max_ioqpairs must be between 1 and %d",
> +                   PCI_MSIX_FLAGS_QSIZE);
> +        return -1;
>       }
>   
>       if (!n->conf.blk) {
> -        error_setg(errp, "drive property not set");
> -        return;
> +        error_setg(errp, "nvme: block backend not configured");
> +        return -1;
>       }
>   
> -    bs_size = blk_getlength(n->conf.blk);
> -    if (bs_size < 0) {
> -        error_setg(errp, "could not get backing file size");
> -        return;
> +    if (!params->serial) {
> +        error_setg(errp, "nvme: serial not configured");
> +        return -1;
>       }
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
>       blkconf_blocksizes(&n->conf);
>       if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
>                                          false, errp)) {
> -        return;
> +        return -1;
>       }
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
>       n->num_namespaces = 1;
>       n->reg_size = pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
> -    n->ns_size = bs_size / (uint64_t)n->num_namespaces;
> -
>       n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>       n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
>       n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
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
>       msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
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
>       id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>       id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
>       strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
>       strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
> -    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
> +    strpadcpy((char *)id->sn, sizeof(id->sn), params->serial, ' ');
>       id->rab = 6;
>       id->ieee[0] = 0x00;
>       id->ieee[1] = 0x02;
> @@ -1429,43 +1470,54 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>   
>       n->bar.vs = 0x00010200;
>       n->bar.intmc = n->bar.intms = 0;
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
> -        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> -                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> -        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> -            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
> -            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> +    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
>   
> +    /* no thin provisioning */
> +    id_ns->ncap = id_ns->nsze;
> +    id_ns->nuse = id_ns->ncap;
> +
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
>       }
>   
>       for (i = 0; i < n->num_namespaces; i++) {
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
>       }
> +
> +    nvme_init_pci(n, pci_dev);
> +    nvme_init_ctrl(n);

This patch is a pain to review... Could you split it? I'd use one 
trivial patch for each function extracted from nvme_realize().

>   }
>   
>   static void nvme_exit(PCIDevice *pci_dev)
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index ad1786953be9..b7c465560eea 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -67,6 +67,22 @@ typedef struct NvmeNamespace {
>       NvmeIdNs        id_ns;
>   } NvmeNamespace;
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
>   #define TYPE_NVME "nvme"
>   #define NVME(obj) \
>           OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> @@ -101,4 +117,9 @@ typedef struct NvmeCtrl {
>       NvmeIdCtrl      id_ctrl;
>   } NvmeCtrl;
>   
> +static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    return n->ns_size >> nvme_ns_lbads(ns);
> +}
> +
>   #endif /* HW_NVME_H */
> 


