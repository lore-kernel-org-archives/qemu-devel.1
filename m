Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A3FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C052071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C052071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ7lW-0000Qp-Od
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 01:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iZ7kb-0008N1-8B
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iZ7ka-0003ss-1S
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:21:33 -0500
Received: from charlie.dont.surf ([128.199.63.193]:47396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iZ7kW-0003rk-Lz; Mon, 25 Nov 2019 01:21:28 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id B35F7BF62A;
 Mon, 25 Nov 2019 06:21:25 +0000 (UTC)
Date: Mon, 25 Nov 2019 07:21:22 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 15/20] nvme: add support for scatter gather lists
Message-ID: <20191125062122.GA21341@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-16-its@irrelevant.dk>
 <CADSWDzupax=4s4=wb6NOR-imKNc_SkfBf1aDWdS_eN8oynJj6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzupax=4s4=wb6NOR-imKNc_SkfBf1aDWdS_eN8oynJj6A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 03:25:18PM +0000, Beata Michalska wrote:
> Hi Klaus,
> 
> On Tue, 15 Oct 2019 at 11:57, Klaus Jensen <its@irrelevant.dk> wrote:
> > +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg,
> > +    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
> > +{
> > +    const int MAX_NSGLD = 256;
> > +
> > +    NvmeSglDescriptor segment[MAX_NSGLD];
> > +    uint64_t nsgld;
> > +    uint16_t status;
> > +    bool sgl_in_cmb = false;
> > +    hwaddr addr = le64_to_cpu(sgl.addr);
> > +
> > +    trace_nvme_map_sgl(req->cid, NVME_SGL_TYPE(sgl.type), req->nlb, len);
> > +
> > +    pci_dma_sglist_init(qsg, &n->parent_obj, 1);
> > +
> > +    /*
> > +     * If the entire transfer can be described with a single data block it can
> > +     * be mapped directly.
> > +     */
> > +    if (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_DATA_BLOCK) {
> > +        status = nvme_map_sgl_data(n, qsg, &sgl, 1, &len, req);
> > +        if (status) {
> > +            goto unmap;
> > +        }
> > +
> > +        goto out;
> > +    }
> > +
> > +    /*
> > +     * If the segment is located in the CMB, the submission queue of the
> > +     * request must also reside there.
> > +     */
> > +    if (nvme_addr_is_cmb(n, addr)) {
> > +        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
> > +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > +        }
> > +
> > +        sgl_in_cmb = true;
> > +    }
> > +
> > +    while (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_SEGMENT) {
> > +        bool addr_is_cmb;
> > +
> > +        nsgld = le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
> > +
> > +        /* read the segment in chunks of 256 descriptors (4k) */
> > +        while (nsgld > MAX_NSGLD) {
> > +            nvme_addr_read(n, addr, segment, sizeof(segment));
> Is there any chance this will go outside the CMB?
> 

Yes, there certainly was a chance of that. This has been fixed in a
general way for both nvme_map_sgl and nvme_map_sgl_data.

> > +
> > +            status = nvme_map_sgl_data(n, qsg, segment, MAX_NSGLD, &len, req);
> > +            if (status) {
> > +                goto unmap;
> > +            }
> > +
> > +            nsgld -= MAX_NSGLD;
> > +            addr += MAX_NSGLD * sizeof(NvmeSglDescriptor);
> > +        }
> > +
> > +        nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescriptor));
> > +
> > +        sgl = segment[nsgld - 1];
> > +        addr = le64_to_cpu(sgl.addr);
> > +
> > +        /* an SGL is allowed to end with a Data Block in a regular Segment */
> > +        if (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_DATA_BLOCK) {
> > +            status = nvme_map_sgl_data(n, qsg, segment, nsgld, &len, req);
> > +            if (status) {
> > +                goto unmap;
> > +            }
> > +
> > +            goto out;
> > +        }
> > +
> > +        /* do not map last descriptor */
> > +        status = nvme_map_sgl_data(n, qsg, segment, nsgld - 1, &len, req);
> > +        if (status) {
> > +            goto unmap;
> > +        }
> > +
> > +        /*
> > +         * If the next segment is in the CMB, make sure that the sgl was
> > +         * already located there.
> > +         */
> > +        addr_is_cmb = nvme_addr_is_cmb(n, addr);
> > +        if ((sgl_in_cmb && !addr_is_cmb) || (!sgl_in_cmb && addr_is_cmb)) {
> > +            status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > +            goto unmap;
> > +        }
> > +    }
> > +
> > +    /*
> > +     * If the segment did not end with a Data Block or a Segment descriptor, it
> > +     * must be a Last Segment descriptor.
> > +     */
> > +    if (NVME_SGL_TYPE(sgl.type) != SGL_DESCR_TYPE_LAST_SEGMENT) {
> > +        trace_nvme_err_invalid_sgl_descriptor(req->cid,
> > +            NVME_SGL_TYPE(sgl.type));
> > +        return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
> Shouldn't we handle a case here that requires calling unmap ?

Woops. Fixed.

> > +static uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > +    NvmeSglDescriptor sgl, NvmeCmd *cmd, NvmeRequest *req)
> > +{
> > +    QEMUSGList qsg;
> > +    uint16_t err = NVME_SUCCESS;
> > +
> Very minor: Mixing convention: status vs error
> 

Fixed by proxy in another refactor.

> >
> > +#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
> > +#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
> Minor: This one is slightly misleading - as per the naming and it's usage:
> the PSDT is a field name and as such does not imply using SGLs
> and it is being used to verify if given command is actually using
> SGLs.
> 

Ah, is this because I do

  if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {

in the code? That is, just checks for it not being zero? The value of
the PRP or SGL for Data Transfer (PSDT) field *does* specify if the
command uses SGLs or not. 0x0: PRPs, 0x1 SGL for data, 0x10: SGLs for
both data and metadata. Would you prefer the condition was more
explicit?


Thanks!
Klaus

