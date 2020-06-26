Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA742C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7332076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7332076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1johH3-0001jL-2U
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 01:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1johG6-0000ff-3U; Fri, 26 Jun 2020 01:50:42 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1johG3-0007BF-R5; Fri, 26 Jun 2020 01:50:41 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 97E71BF450;
 Fri, 26 Jun 2020 05:50:36 +0000 (UTC)
Date: Fri, 26 Jun 2020 07:50:33 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v3 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200626055033.6vxqvi4s5pll7som@apples.localdomain>
References: <20200622182511.17252-1-andrzej.jakowski@linux.intel.com>
 <20200622182511.17252-3-andrzej.jakowski@linux.intel.com>
 <20200625111308.42473x7wfzukp4ve@apples.localdomain>
 <f9ea530c-06fd-1773-b036-5b00b9c80d4f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9ea530c-06fd-1773-b036-5b00b9c80d4f@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:50:37
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, kbusch@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 25 15:57, Andrzej Jakowski wrote:
> On 6/25/20 4:13 AM, Klaus Jensen wrote:
> > 
> > Come to think of it, the above might not even be sufficient since if just one
> > of the nvme_addr_is_cmb checks fails, we end up issuing an invalid
> > pci_dma_read. But I think that it will error out gracefully on that. But
> > this needs to be checked.
> > 
> > I suggest that you just drop the size check from this patch since it's not
> > needed and might need more work to be safe in the context of SGLs anyway.
> > 
> 
> How about just MMIO access to CMB region? It can be done to any address.
> What guarantees that this will not go outside of CMB region?
> 

This was addressed in commit 87ad860c622c ("nvme: fix out-of-bounds
access to the CMB").

> >> @@ -1453,33 +1457,62 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> >>      id_ns->nuse = id_ns->ncap;
> >>  }
> >>  
> >> -static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> >> +static void nvme_bar4_init(PCIDevice *pci_dev, Error **errp)
> >>  {
> >> -    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
> >> -    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
> >> -
> >> -    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> >> -    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> >> -    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> >> -    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> >> -    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> >> -    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> >> -    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> >> -
> >> -    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> >> -    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
> >> -                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> >> -    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
> >> +    NvmeCtrl *n = NVME(pci_dev);
> >> +    int status;
> >> +    uint64_t bar_size;
> >> +    uint32_t msix_vectors;
> >> +    uint32_t nvme_pba_offset;
> >> +    uint32_t cmb_size_units;
> >> +
> >> +    msix_vectors = n->params.max_ioqpairs + 1;
> >> +    nvme_pba_offset = PCI_MSIX_ENTRY_SIZE * msix_vectors;
> >> +    bar_size = nvme_pba_offset + QEMU_ALIGN_UP(msix_vectors, 64) / 8;
> >> +
> >> +    if (n->params.cmb_size_mb) {
> >> +        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
> >> +        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
> >> +        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
> >> +        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
> >> +        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
> >> +        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
> >> +        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
> >> +
> >> +        cmb_size_units = NVME_CMBSZ_GETSIZEUNITS(n->bar.cmbsz);
> >> +        n->cmb_offset = QEMU_ALIGN_UP(bar_size, cmb_size_units);
> >> +
> >> +        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_MSIX_BIR);
> >> +        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, n->cmb_offset / cmb_size_units);
> >> +
> >> +        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
> >> +
> >> +        bar_size += n->cmb_offset;
> >> +        bar_size += NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
> >> +    }
> >> +
> >> +    bar_size = pow2ceil(bar_size);
> >> +
> >> +    memory_region_init_io(&n->bar4, OBJECT(n), &nvme_cmb_ops, n,
> >> +                          "nvme-bar4", bar_size);
> >> +
> >> +    status = msix_init(pci_dev, n->params.max_ioqpairs + 1,
> >> +                       &n->bar4, NVME_MSIX_BIR, 0,
> >> +                       &n->bar4, NVME_MSIX_BIR, nvme_pba_offset,
> >> +                       0, errp);
> > 
> > This needs to use n->params.msix_qsize instead of
> > n->params.max_ioqpairs.
> 
> Makese sense.

Another thing here. You are initializing a single memory region for bar4
and use nvme_cmb_ops as callbacks for that.

msix_init then overlays two memory regions ontop of this (for the table
and the pba). I'm not sure this is... correct? Paolo, can you shed any
light on this?

It looks to me like we need to do something more like what
msix_init_exclusive_bar does:

  1. do a memory_region_init for n->bar4
  2. msix_init adds io regions for the msix table and pba.
  3. we should then add an io region for the cmb like msix_init does
     (with a memory_region_init_io and a memory_region_add_subregion
     pair) and keep n->ctrl_mem around.
  4. pci_register_bar on n->bar4

Thus, no "general" mmio_ops are registered for bar4, but only for the
ctrl_mem and the msix_{table,pba}_mmio regions.

