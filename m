Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE6D223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE6D223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMUi-0003o0-Bc
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iXMSS-00018b-G3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iXMSN-0005DU-6L
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:39:32 -0500
Received: from charlie.dont.surf ([128.199.63.193]:38966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iXMSG-0005An-R1; Wed, 20 Nov 2019 04:39:21 -0500
Received: from apples.localdomain (unknown [194.62.217.4])
 by charlie.dont.surf (Postfix) with ESMTPSA id AB182BF65A;
 Wed, 20 Nov 2019 09:39:18 +0000 (UTC)
Date: Wed, 20 Nov 2019 10:39:14 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 13/20] nvme: refactor prp mapping
Message-ID: <20191120093914.GA1052314@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-14-its@irrelevant.dk>
 <CADSWDzs6mECPKv2qAojEF75Vxi1i5_2fkvDtjWkQU22F9a4a7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzs6mECPKv2qAojEF75Vxi1i5_2fkvDtjWkQU22F9a4a7g@mail.gmail.com>
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

On Tue, Nov 12, 2019 at 03:23:43PM +0000, Beata Michalska wrote:
> Hi Klaus,
> 
> On Tue, 15 Oct 2019 at 11:57, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > Instead of handling both QSGs and IOVs in multiple places, simply use
> > QSGs everywhere by assuming that the request does not involve the
> > controller memory buffer (CMB). If the request is found to involve the
> > CMB, convert the QSG to an IOV and issue the I/O. The QSG is converted
> > to an IOV by the dma helpers anyway, so the CMB path is not unfairly
> > affected by this simplifying change.
> >
> 
> Out of curiosity, in how many cases the SG list will have to
> be converted to IOV ? Does that justify creating the SG list in vain ?
> 

You got me wondering. Only using QSGs does not really remove much
complexity, so I readded the direct use of IOVs for the CMB path. There
is no harm in that.

> > +static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, uint64_t prp1,
> > +    uint64_t prp2, uint32_t len, NvmeRequest *req)
> >  {
> >      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
> >      trans_len = MIN(len, trans_len);
> >      int num_prps = (len >> n->page_bits) + 1;
> > +    uint16_t status = NVME_SUCCESS;
> > +    bool prp_list_in_cmb = false;
> > +
> > +    trace_nvme_map_prp(req->cid, req->cmd.opcode, trans_len, len, prp1, prp2,
> > +        num_prps);
> >
> >      if (unlikely(!prp1)) {
> >          trace_nvme_err_invalid_prp();
> >          return NVME_INVALID_FIELD | NVME_DNR;
> > -    } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
> > -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
> > -        qsg->nsg = 0;
> > -        qemu_iovec_init(iov, num_prps);
> > -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
> > -    } else {
> > -        pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> > -        qemu_sglist_add(qsg, prp1, trans_len);
> >      }
> > +
> > +    if (nvme_addr_is_cmb(n, prp1)) {
> > +        req->is_cmb = true;
> > +    }
> > +
> This seems to be used here and within read/write functions which are calling
> this one. Maybe there is a nicer way to track that instead of passing
> the request
> from multiple places ?
> 

Hmm. Whether or not the command reads/writes from the CMB is really only
something you can determine by looking at the PRPs (which is done in
nvme_map_prp), so I think this is the right way to track it. Or do you
have something else in mind?

> > +    pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> > +    qemu_sglist_add(qsg, prp1, trans_len);
> > +
> >      len -= trans_len;
> >      if (len) {
> >          if (unlikely(!prp2)) {
> >              trace_nvme_err_invalid_prp2_missing();
> > +            status = NVME_INVALID_FIELD | NVME_DNR;
> >              goto unmap;
> >          }
> > +
> >          if (len > n->page_size) {
> >              uint64_t prp_list[n->max_prp_ents];
> >              uint32_t nents, prp_trans;
> >              int i = 0;
> >
> > +            if (nvme_addr_is_cmb(n, prp2)) {
> > +                prp_list_in_cmb = true;
> > +            }
> > +
> >              nents = (len + n->page_size - 1) >> n->page_bits;
> >              prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
> > -            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
> > +            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
> >              while (len != 0) {
> > +                bool addr_is_cmb;
> >                  uint64_t prp_ent = le64_to_cpu(prp_list[i]);
> >
> >                  if (i == n->max_prp_ents - 1 && len > n->page_size) {
> >                      if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
> >                          trace_nvme_err_invalid_prplist_ent(prp_ent);
> > +                        status = NVME_INVALID_FIELD | NVME_DNR;
> > +                        goto unmap;
> > +                    }
> > +
> > +                    addr_is_cmb = nvme_addr_is_cmb(n, prp_ent);
> > +                    if ((prp_list_in_cmb && !addr_is_cmb) ||
> > +                        (!prp_list_in_cmb && addr_is_cmb)) {
> 
> Minor: Same condition (based on different vars) is being used in
> multiple places. Might be worth to move it outside and just pass in
> the needed values.
> 

I'm really not sure what I was smoking when writing those conditions.
It's just `var != nvme_addr_is_cmb(n, prp_ent)`. I fixed that. No need
to pull it out I think.

> >  static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > -                                   uint64_t prp1, uint64_t prp2)
> > +    uint64_t prp1, uint64_t prp2, NvmeRequest *req)
> >  {
> >      QEMUSGList qsg;
> > -    QEMUIOVector iov;
> >      uint16_t status = NVME_SUCCESS;
> >
> > -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> > -        return NVME_INVALID_FIELD | NVME_DNR;
> > +    status = nvme_map_prp(n, &qsg, prp1, prp2, len, req);
> > +    if (status) {
> > +        return status;
> >      }
> > -    if (qsg.nsg > 0) {
> > -        if (dma_buf_write(ptr, len, &qsg)) {
> > -            status = NVME_INVALID_FIELD | NVME_DNR;
> > -        }
> > -        qemu_sglist_destroy(&qsg);
> > -    } else {
> > -        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
> > +
> > +    if (req->is_cmb) {
> > +        QEMUIOVector iov;
> > +
> > +        qemu_iovec_init(&iov, qsg.nsg);
> > +        dma_to_cmb(n, &qsg, &iov);
> > +
> > +        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) != len)) {
> > +            trace_nvme_err_invalid_dma();
> >              status = NVME_INVALID_FIELD | NVME_DNR;
> >          }
> > +
> >          qemu_iovec_destroy(&iov);
> > +
> Aren't we missing the sglist cleanup here ?
> (goto as in nvme_dma_read_prp)
> 
> Aside: both nvme_write_prp and nvme_read_prp seem to differ only
> with the final call to either dma or qemu_ioves calls.
> Might be worth to unify it and move it to a single function with additional
> parameter that will determine the type of the transaction.
> 

True. I have combined them into a single nvme_dma_prp function.

> > +static void nvme_init_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > +{
> > +    memset(&req->cqe, 0, sizeof(req->cqe));
> > +    req->cqe.cid = cmd->cid;
> > +    req->cid = le16_to_cpu(cmd->cid);
> > +
> > +    memcpy(&req->cmd, cmd, sizeof(NvmeCmd));
> > +    req->status = NVME_SUCCESS;
> > +    req->is_cmb = false;
> > +    req->is_write = false;
> 
> What is the use case for this one ?
> It does not seem to be referenced in this patch.
> 

That crept in there by mistake. I have removed it.

