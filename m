Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CF8207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJctVTwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CF8207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCd3-0006ZQ-0e
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJCcK-00063n-TH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJCcJ-0005fG-AR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:51:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJCcJ-0005ey-6M
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585644686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RbLNCVW5cyHI6on2lu/dPAxljdE+voS4BL9wMWmRZgI=;
 b=ZJctVTwXmPehyvt971XZO1Y2+/K5U6/Nkf2KOnfscqiDHmeW5HJvPiZPBnugnob11YCbCo
 q/x69udtQKz1KYE8LD1wZi+TOKrBkwZaNrGAYYBbMNfQ0ILXYQF6+j3lp3CT8WjhdwMiEs
 TexB7OWnf56VHRAqotmMuS46k8hVgoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-9wcRbWwsM9KoJQbCVYtKiw-1; Tue, 31 Mar 2020 04:51:23 -0400
X-MC-Unique: 9wcRbWwsM9KoJQbCVYtKiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9666A8010F3;
 Tue, 31 Mar 2020 08:51:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4795FD768A;
 Tue, 31 Mar 2020 08:51:19 +0000 (UTC)
Message-ID: <586ae8bcadfc5ae382d8fff7c28fd8bcfdc41862.camel@redhat.com>
Subject: Re: [PATCH v6 36/42] nvme: add support for scatter gather lists
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 11:51:18 +0300
In-Reply-To: <20200331054753.dqxttb7rgxcwok5d@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-37-its@irrelevant.dk>
 <ab590abcfe5ea854aa9760086ad3bb000c4564be.camel@redhat.com>
 <20200331054753.dqxttb7rgxcwok5d@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:48 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:58, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > For now, support the Data Block, Segment and Last Segment descriptor
> > > types.
> > > 
> > > See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > Acked-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  hw/block/nvme.c       | 310 +++++++++++++++++++++++++++++++++++-------
> > >  hw/block/trace-events |   4 +
> > >  2 files changed, 262 insertions(+), 52 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 49d323566393..b89b96990f52 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -76,7 +76,12 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> > >  
> > >  static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> > >  {
> > > -    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
> > > +    hwaddr hi = addr + size;
> > > +    if (hi < addr) {
> > > +        return 1;
> > > +    }
> > > +
> > > +    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {
> > 
> > I would suggest to split this into a separate patch as well, since this contains not just one but 2 bugfixes
> > for this function and they are not related to sg lists.
> > Or at least move this to 'nvme: refactor nvme_addr_read' and rename this patch
> > to something like 'nvme: fix and refactor nvme_addr_read'
> > 
> 
> I've split it into a patch.
> 
> > 
> > >          memcpy(buf, nvme_addr_to_cmb(n, addr), size);
> > >          return 0;
> > >      }
> > > @@ -328,13 +333,242 @@ unmap:
> > >      return status;
> > >  }
> > >  
> > > -static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > > -                             uint64_t prp1, uint64_t prp2, DMADirection dir,
> > > +static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
> > > +                                  QEMUIOVector *iov,
> > > +                                  NvmeSglDescriptor *segment, uint64_t nsgld,
> > > +                                  size_t *len, NvmeRequest *req)
> > > +{
> > > +    dma_addr_t addr, trans_len;
> > > +    uint32_t blk_len;
> > > +    uint16_t status;
> > > +
> > > +    for (int i = 0; i < nsgld; i++) {
> > > +        uint8_t type = NVME_SGL_TYPE(segment[i].type);
> > > +
> > > +        if (type != NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> > > +            switch (type) {
> > > +            case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
> > > +            case NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK:
> > > +                return NVME_SGL_DESCR_TYPE_INVALID | NVME_DNR;
> > > +            default:
> > 
> > To be honest I don't like that 'default'
> > I would explicitly state which segment types remain 
> > (I think segment list and last segment list, and various reserved types)
> > In fact for the reserved types you probably also want to return NVME_SGL_DESCR_TYPE_INVALID)
> > 
> 
> I "negated" the logic which I think is more readable. I still really
> want to keep the default, for instance, nvme v1.4 adds a new type that
> we do not support (the Transport SGL Data Block descriptor).
OK, I'll take a look a that in the next version of the patches.

> 
> > Also this function as well really begs to have a description prior to it,
> > something like 'map a sg list section, assuming that it only contains SGL data descriptions,
> > caller has to ensure this'.
> > 
> 
> Done.
Thanks a lot!
> 
> > 
> > > +                return NVME_INVALID_NUM_SGL_DESCRS | NVME_DNR;
> > > +            }
> > > +        }
> > > +
> > > +        if (*len == 0) {
> > > +            uint16_t sgls = le16_to_cpu(n->id_ctrl.sgls);
> > 
> > Nitpick: I would add a small comment here as well describiing
> > what this does (We reach this point if sg list covers more that that
> > was specified in the commmand, and the NVME_CTRL_SGLS_EXCESS_LENGTH controller
> > capability indicates that we support just throwing the extra data away)
> > 
> 
> Adding a comment. It's the other way around. The size as indicated by
> NLB (or whatever depending on the command) is the "authoritative" souce
> of information for the size of the payload. We will never accept an SGL
> that is too short such that we lose or throw away data, but we might
> accept ignoring parts of the SGL.
Yes, that is what I meant. Thanks!

> 
> > > +            if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {
> > > +                break;
> > > +            }
> > > +
> > > +            trace_nvme_dev_err_invalid_sgl_excess_length(nvme_cid(req));
> > > +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> > > +        }
> > > +
> > > +        addr = le64_to_cpu(segment[i].addr);
> > > +        blk_len = le32_to_cpu(segment[i].len);
> > > +
> > > +        if (!blk_len) {
> > > +            continue;
> > > +        }
> > > +
> > > +        if (UINT64_MAX - addr < blk_len) {
> > > +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> > > +        }
> > 
> > Good!
> > > +
> > > +        trans_len = MIN(*len, blk_len);
> > > +
> > > +        status = nvme_map_addr(n, qsg, iov, addr, trans_len);
> > > +        if (status) {
> > > +            return status;
> > > +        }
> > > +
> > > +        *len -= trans_len;
> > > +    }
> > > +
> > > +    return NVME_SUCCESS;
> > > +}
> > > +
> > > +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> > > +                             NvmeSglDescriptor sgl, size_t len,
> > >                               NvmeRequest *req)
> > > +{
> > > +    /*
> > > +     * Read the segment in chunks of 256 descriptors (one 4k page) to avoid
> > > +     * dynamically allocating a potentially large SGL. The spec allows the SGL
> > > +     * to be larger than the command transfer size, so it is not bounded by
> > > +     * MDTS.
> > > +     */
> > 
> > Now this is a very good comment!
> > 
> > However I don't fully understand the note about the SGL. I assume that you mean
> > that the data that SGL covers still should be less that MDTS, but the actual SGL chain,
> > if assembled really in inefficient way (like 1 byte per each data descriptor) might be larger.
> > 
> 
> Exactly. I'll rephrase.
Thanks!
> 
> > 
> > > +    const int SEG_CHUNK_SIZE = 256;
> > > +
> > > +    NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
> > > +    uint64_t nsgld;
> > > +    uint32_t seg_len;
> > > +    uint16_t status;
> > > +    bool sgl_in_cmb = false;
> > > +    hwaddr addr;
> > > +    int ret;
> > > +
> > > +    sgld = &sgl;
> > > +    addr = le64_to_cpu(sgl.addr);
> > > +
> > > +    trace_nvme_dev_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), req->nlb,
> > > +                           len);
> > > +
> > > +    /*
> > > +     * If the entire transfer can be described with a single data block it can
> > > +     * be mapped directly.
> > > +     */
> > > +    if (NVME_SGL_TYPE(sgl.type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> > > +        status = nvme_map_sgl_data(n, qsg, iov, sgld, 1, &len, req);
> > > +        if (status) {
> > > +            goto unmap;
> > > +        }
> > > +
> > > +        goto out;
> > > +    }
> > > +
> > > +    /*
> > > +     * If the segment is located in the CMB, the submission queue of the
> > > +     * request must also reside there.
> > > +     */
> > > +    if (nvme_addr_is_cmb(n, addr)) {
> > > +        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
> > > +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > > +        }
> > > +
> > > +        sgl_in_cmb = true;
> > > +    }
> > > +
> > > +    for (;;) {
> > > +        seg_len = le32_to_cpu(sgld->len);
> > > +
> > > +        if (!seg_len || seg_len & 0xf) {
> > > +            return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
> > > +        }
> > 
> > It might be worth noting here that we are dealing with sgl (last) segment descriptor
> > and its length indeed must be non zero and multiple of 16.
> > Otherwise I confused this for a moment with the alignment requirements on the data itsel.
> > 
> 
> Done.
Thanks as well!
> 
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 
> > 
> > 
> > 
> 

Best regards,
	Maxim Levitsky



