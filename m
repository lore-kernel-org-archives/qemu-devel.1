Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D9CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1595206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="xDkoXTQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1595206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0taC-0004pX-5P
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 17:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0tZN-0004FV-Vm; Wed, 29 Jul 2020 17:25:03 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0tZL-0002nt-9n; Wed, 29 Jul 2020 17:25:01 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 25715BF616;
 Wed, 29 Jul 2020 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596057896;
 bh=j7VYVJCoL5ZhIn0pECX4kCR/pz3va0Rw5eoCx70f9yY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xDkoXTQNiIoVgzZV6zatZfeJz4JtCi+R+JbC77HFKE4uC15noi3AfvrIS+i2Gwjbn
 V9Evi2i5ui+ayZynmNFWes92Kmt1/FOTeEXA3u14Mnz+3zrGRCBfcr16nSfRTJfPl5
 g8EdBO2sfR+ylMjUQxJ6wY1F8kGgLP30BFzhTrxidwfw0mX4VXhRggod0Uf1i5uryv
 joFZ1qY7xHahU1MDSkjFVds8s2FDP4vR0w/05t/lvbIKFeuVYWJw4LgUM89x1ga/zJ
 jvTTE7d+qIPjAgGwTCnKPx90uIHb36XNoYq8prtVwn0UtLQ0Q9njHe+QY5B/XXLaSK
 xK+q85XfUTEFA==
Date: Wed, 29 Jul 2020 23:24:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH 02/16] hw/block/nvme: add mapping helpers
Message-ID: <20200729212432.GA332974@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-3-its@irrelevant.dk>
 <b5e82d6a-471e-8894-f418-73f7d99094da@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5e82d6a-471e-8894-f418-73f7d99094da@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 29 13:40, Andrzej Jakowski wrote:
> On 7/20/20 4:37 AM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
> > use them in nvme_map_prp.
> > 
> > This fixes a bug where in the case of a CMB transfer, the device would
> > map to the buffer with a wrong length.
> > 
> > Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c       | 109 +++++++++++++++++++++++++++++++++++-------
> >  hw/block/trace-events |   2 +
> >  2 files changed, 94 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 4d7b730a62b6..9b1a080cdc70 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -270,20 +338,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
> >          } else {
> >              if (unlikely(prp2 & (n->page_size - 1))) {
> >                  trace_pci_nvme_err_invalid_prp2_align(prp2);
> > +                status = NVME_INVALID_FIELD | NVME_DNR;
> >                  goto unmap;
> >              }
> > -            if (qsg->nsg) {
> > -                qemu_sglist_add(qsg, prp2, len);
> > -            } else {
> > -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
> > +            status = nvme_map_addr(n, qsg, iov, prp2, len);
> > +            if (status) {
> > +                goto unmap;
> >              }
> >          }
> >      }
> >      return NVME_SUCCESS;
> >  
> > - unmap:
> > -    qemu_sglist_destroy(qsg);
> > -    return NVME_INVALID_FIELD | NVME_DNR;
> > +unmap:
> > +    if (iov && iov->iov) {
> > +        qemu_iovec_destroy(iov);
> > +    }
> > +
> > +    if (qsg && qsg->sg) {
> > +        qemu_sglist_destroy(qsg);
> > +    }
> > +
> > +    return status;
> 
> I think it would make sense to move whole unmap block to a separate function.
> That function could be called from here and after completing IO and would contain
> unified deinitialization block - so no code repetitions would be necessary.
> Other than that it looks good to me. Thx!
> 
> Reviewed-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> 
 
Hi Andrzej,

Thanks for the review :)

Yes, this is done in a later patch ("hw/block/nvme: consolidate qsg/iov
clearing"), but kept here to reduce churn.

