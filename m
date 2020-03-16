Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F5C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9CD20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9CD20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkVm-0005ma-08
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDkPr-00047h-DB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDkPp-0000Bx-6I
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:44:03 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDkPk-00074x-6C; Mon, 16 Mar 2020 03:43:56 -0400
Received: from apples.localdomain (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 15DFCBF5E1;
 Mon, 16 Mar 2020 07:43:52 +0000 (UTC)
Date: Mon, 16 Mar 2020 00:43:48 -0700
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v5 08/26] nvme: refactor device realization
Message-ID: <20200316074348.wxmxsox6j42r6rw5@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095220eucas1p186b0de598359750d49278e0226ae45fb@eucas1p1.samsung.com>
 <20200204095208.269131-9-k.jensen@samsung.com>
 <fbacd1f4623decc7f30b3e21b6095989311cecbc.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbacd1f4623decc7f30b3e21b6095989311cecbc.camel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Feb 12 11:27, Maxim Levitsky wrote:
> On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > This patch splits up nvme_realize into multiple individual functions,
> > each initializing a different subset of the device.
> > 
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > ---
> >  hw/block/nvme.c | 175 +++++++++++++++++++++++++++++++-----------------
> >  hw/block/nvme.h |  21 ++++++
> >  2 files changed, 133 insertions(+), 63 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index e1810260d40b..81514eaef63a 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -44,6 +44,7 @@
> >  #include "nvme.h"
> >  
> >  #define NVME_SPEC_VER 0x00010201
> > +#define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
> >  
> >  #define NVME_GUEST_ERR(trace, fmt, ...) \
> >      do { \
> > @@ -1325,67 +1326,106 @@ static const MemoryRegionOps nvme_cmb_ops = {
> >      },
> >  };
> >  
> > -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> > +static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
> >  {
> > -    NvmeCtrl *n = NVME(pci_dev);
> > -    NvmeIdCtrl *id = &n->id_ctrl;
> > -
> > -    int i;
> > -    int64_t bs_size;
> > -    uint8_t *pci_conf;
> > -
> > -    if (!n->params.num_queues) {
> > -        error_setg(errp, "num_queues can't be zero");
> > -        return;
> > -    }
> > +    NvmeParams *params = &n->params;
> >  
> >      if (!n->conf.blk) {
> > -        error_setg(errp, "drive property not set");
> > -        return;
> > +        error_setg(errp, "nvme: block backend not configured");
> > +        return 1;
> As a matter of taste, negative values indicate error, and 0 is the success value.
> In Linux kernel this is even an official rule.
> >      }

Fixed.

> >  
> > -    bs_size = blk_getlength(n->conf.blk);
> > -    if (bs_size < 0) {
> > -        error_setg(errp, "could not get backing file size");
> > -        return;
> > +    if (!params->serial) {
> > +        error_setg(errp, "nvme: serial not configured");
> > +        return 1;
> >      }
> >  
> > -    if (!n->params.serial) {
> > -        error_setg(errp, "serial property not set");
> > -        return;
> > +    if ((params->num_queues < 1 || params->num_queues > NVME_MAX_QS)) {
> > +        error_setg(errp, "nvme: invalid queue configuration");
> Maybe something like "nvme: invalid queue count specified, should be between 1 and ..."?
> > +        return 1;
> >      }

Fixed.

> > +
> > +    return 0;
> > +}
> > +
> > +static int nvme_init_blk(NvmeCtrl *n, Error **errp)
> > +{
> >      blkconf_blocksizes(&n->conf);
> >      if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
> > -                                       false, errp)) {
> > -        return;
> > +        false, errp)) {
> > +        return 1;
> >      }
> >  
> > -    pci_conf = pci_dev->config;
> > -    pci_conf[PCI_INTERRUPT_PIN] = 1;
> > -    pci_config_set_prog_interface(pci_dev->config, 0x2);
> > -    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
> > -    pcie_endpoint_cap_init(pci_dev, 0x80);
> > +    return 0;
> > +}
> >  
> > +static void nvme_init_state(NvmeCtrl *n)
> > +{
> >      n->num_namespaces = 1;
> >      n->reg_size = pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4);
> 
> Isn't that wrong?
> First 4K of mmio (0x1000) is the registers, and that is followed by the doorbells,
> and each doorbell takes 8 bytes (assuming regular doorbell stride).
> so n->params.num_queues + 1 should be total number of queues, thus the 0x1004 should be 0x1000 IMHO.
> I might miss some rounding magic here though.
> 

Yeah. I think you are right. It all becomes slightly more fishy due to
the num_queues device parameter being 1's based and accounts for the
admin queue pair.

But in get/set features, the value has to be 0's based and only account
for the I/O queues, so we need to subtract 2 from the value. It's
confusing all around.

Since the admin queue pair isn't really optional I think it would be
better that we introduces a new max_ioqpairs parameter that is 1's
based, counts number of pairs and obviously only accounts for the io
queues.

I guess we need to keep the num_queues parameter around for
compatibility.

The doorbells are only 4 bytes btw, but the calculation still looks
wrong. With a max_ioqpairs parameter in place, the reg_size should be

    pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4)

Right? Thats 0x1000 for the core registers, 8 bytes for the sq/cq
doorbells for the admin queue pair, and then room for the i/o queue
pairs.

I added a patch for this in v6.

> > -    n->ns_size = bs_size / (uint64_t)n->num_namespaces;
> > -
> >      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
> >      n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
> >      n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
> > +}
> >  
> > -    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
> > -                          "nvme", n->reg_size);
> > +static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> > +{
> > +    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
> It would be nice to have #define for CMB bar number

Added.

> > +    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> > +
> > +    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> > +    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> > +    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> > +    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> > +    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> > +    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
> > +    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> > +
> > +    n->cmbloc = n->bar.cmbloc;
> > +    n->cmbsz = n->bar.cmbsz;
> > +
> > +    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> > +    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> > +                            "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> > +    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> Same here although since you read it here from the controller register,
> then maybe leave it as is. I prefer though for this kind of thing
> to have a #define and use it everywhere. 
> 

Done.

> > +        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
> > +        PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> > +}
> > +
> > +static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
> > +{
> > +    uint8_t *pci_conf = pci_dev->config;
> > +
> > +    pci_conf[PCI_INTERRUPT_PIN] = 1;
> > +    pci_config_set_prog_interface(pci_conf, 0x2);
> Nitpick: How about adding some #define for that as well?
> (I know that this code is copied as is but still)

Yeah. A PCI_PI_NVME or something would be nice. But this should probably
go to some pci related header file? Any idea where that would fit?

> > +    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> > +    pci_config_set_device_id(pci_conf, 0x5845);
> > +    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
> > +    pcie_endpoint_cap_init(pci_dev, 0x80);
> > +
> > +    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
> > +        n->reg_size);
> 
> Code on split lines should start at column right after the '('
> Now its my turn to notice this - our checkpatch.pl doesn't check this,
> and I can't explain how often I am getting burnt on this myself.
> 
> There are *lot* of these issues, I pointed out some of them but you should
> check all the patches for this.
> 

I fixed all that :)

> 
> >      pci_register_bar(pci_dev, 0,
> >          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
> >          &n->iomem);
> Split line alignment issue here as well.
> >      msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
> >  
> > +    if (n->params.cmb_size_mb) {
> > +        nvme_init_cmb(n, pci_dev);
> > +    }
> > +}
> > +
> > +static void nvme_init_ctrl(NvmeCtrl *n)
> > +{
> > +    NvmeIdCtrl *id = &n->id_ctrl;
> > +    NvmeParams *params = &n->params;
> > +    uint8_t *pci_conf = n->parent_obj.config;
> > +
> >      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
> >      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
> >      strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
> >      strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
> > -    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
> > +    strpadcpy((char *)id->sn, sizeof(id->sn), params->serial, ' ');
> >      id->rab = 6;
> >      id->ieee[0] = 0x00;
> >      id->ieee[1] = 0x02;
> > @@ -1431,46 +1471,55 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >  
> >      n->bar.vs = NVME_SPEC_VER;
> >      n->bar.intmc = n->bar.intms = 0;
> > +}
> >  
> > -    if (n->params.cmb_size_mb) {
> > +static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > +{
> > +    int64_t bs_size;
> > +    NvmeIdNs *id_ns = &ns->id_ns;
> >  
> > -        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
> > -        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> > +    bs_size = blk_getlength(n->conf.blk);
> > +    if (bs_size < 0) {
> > +        error_setg_errno(errp, -bs_size, "blk_getlength");
> > +        return 1;
> > +    }
> >  
> > -        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> > -        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> > -        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> > -        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> > -        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> > -        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> > -        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> > +    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> > +    n->ns_size = bs_size;
> >  
> > -        n->cmbloc = n->bar.cmbloc;
> > -        n->cmbsz = n->bar.cmbsz;
> > +    id_ns->ncap = id_ns->nuse = id_ns->nsze =
> > +        cpu_to_le64(nvme_ns_nlbas(n, ns));
> I myself don't know how to align these splits to be honest.
> I would just split this into multiple statements.
> >  
> > -        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> > -        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> > -                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> > -        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> > -            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
> > -            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
> > +    return 0;
> > +}
> >  
> > +static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> > +{
> > +    NvmeCtrl *n = NVME(pci_dev);
> > +    Error *local_err = NULL;
> > +    int i;
> > +
> > +    if (nvme_check_constraints(n, &local_err)) {
> > +        error_propagate_prepend(errp, local_err, "nvme_check_constraints: ");
> Do we need that hint for the end user?

Removed.

> > +        return;
> > +    }
> > +
> > +    nvme_init_state(n);
> > +
> > +    if (nvme_init_blk(n, &local_err)) {
> > +        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
> Same here

Done.


> > +        return;
> >      }
> >  
> >      for (i = 0; i < n->num_namespaces; i++) {
> > -        NvmeNamespace *ns = &n->namespaces[i];
> > -        NvmeIdNs *id_ns = &ns->id_ns;
> > -        id_ns->nsfeat = 0;
> > -        id_ns->nlbaf = 0;
> > -        id_ns->flbas = 0;
> > -        id_ns->mc = 0;
> > -        id_ns->dpc = 0;
> > -        id_ns->dps = 0;
> > -        id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> > -        id_ns->ncap  = id_ns->nuse = id_ns->nsze =
> > -            cpu_to_le64(n->ns_size >>
> > -                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
> > +        if (nvme_init_namespace(n, &n->namespaces[i], &local_err)) {
> > +            error_propagate_prepend(errp, local_err, "nvme_init_namespace: ");
> And here

Done.


> > +            return;
> > +        }
> >      }
> > +
> > +    nvme_init_pci(n, pci_dev);
> > +    nvme_init_ctrl(n);
> >  }
> >  
> >  static void nvme_exit(PCIDevice *pci_dev)
> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index 9957c4a200e2..a867bdfabafd 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -65,6 +65,22 @@ typedef struct NvmeNamespace {
> >      NvmeIdNs        id_ns;
> >  } NvmeNamespace;
> >  
> > +static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
> > +{
> Its not common to return a structure in C, usually pointer is returned to
> avoid copying. In this case this doesn't matter that much though.

It's actually gonna be used a lot. So swapped to pointer.

> > +    NvmeIdNs *id_ns = &ns->id_ns;
> > +    return id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> > +}
> > +
> > +static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> > +{
> > +    return nvme_ns_lbaf(ns).ds;
> > +}
> > +
> > +static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
> > +{
> > +    return 1 << nvme_ns_lbads(ns);
> > +}
> > +
> >  #define TYPE_NVME "nvme"
> >  #define NVME(obj) \
> >          OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> > @@ -101,4 +117,9 @@ typedef struct NvmeCtrl {
> >      NvmeIdCtrl      id_ctrl;
> >  } NvmeCtrl;
> >  
> > +static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> > +{
> > +    return n->ns_size >> nvme_ns_lbads(ns);
> > +}
> Unless you need all these functions in the future, this feels like
> it is a bit verbose.
> 

These will be used in various places later.
 

