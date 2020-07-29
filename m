Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE35C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7222075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="L02Dq4tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7222075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qza-0002eU-Kg
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 14:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0qy4-0001X2-6N; Wed, 29 Jul 2020 14:38:20 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0qy1-0006Cl-Bm; Wed, 29 Jul 2020 14:38:19 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 9EBA3BF616;
 Wed, 29 Jul 2020 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596047895;
 bh=ogM/vGz5Mkay7EmN15Aa4BezvWY+5ToRgcfoidBh1lo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L02Dq4tIQdjp8gv1dRqfEShxWvotkiYSfww94BkCH3ubbKgdMKkMs1sZC1ZIm3XC/
 ZyoS3RMGjPmdzr6gErXAmhh2U6mJVXz+azN6nrI7H8/xp4tv5ZDCfXoWtxRCS1ULHO
 IFjkv6iOjIC3NaQqscFx6PSF/mzq03p71EcgxvnA9m9z+nljO3lku4CujEJO7t8TnR
 DMDF4xq33hzgKrIitsPzxVzeoylThuZQNKff8FNy9nd+D4/U18hAYQyq4h6+ZNO9fz
 P/cQZNCNjvzNklZ3Swasyf41uyI8jkjki2cyKK+/BMSkdnEulwRGlAlwRDCOpreIYm
 2g2XdLhsfOVRQ==
Date: Wed, 29 Jul 2020 20:38:13 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 05/16] hw/block/nvme: refactor dma read/write
Message-ID: <20200729183813.GC213853@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-6-its@irrelevant.dk>
 <ae04c5a7230a8debb5ae251b816cc1a0f44bd80e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae04c5a7230a8debb5ae251b816cc1a0f44bd80e.camel@redhat.com>
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

On Jul 29 20:35, Maxim Levitsky wrote:
> On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Refactor the nvme_dma_{read,write}_prp functions into a common function
> > taking a DMADirection parameter.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  hw/block/nvme.c | 88 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 43 insertions(+), 45 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 6a1a1626b87b..d314a604db81 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -361,55 +361,50 @@ unmap:
> >      return status;
> >  }
> >  
> > -static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > -                                   uint64_t prp1, uint64_t prp2)
> > +static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > +                             uint64_t prp1, uint64_t prp2, DMADirection dir)
> >  {
> >      QEMUSGList qsg;
> >      QEMUIOVector iov;
> >      uint16_t status = NVME_SUCCESS;
> >  
> > -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> > -        return NVME_INVALID_FIELD | NVME_DNR;
> > +    status = nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
> > +    if (status) {
> > +        return status;
> >      }
> > +
> >      if (qsg.nsg > 0) {
> > -        if (dma_buf_write(ptr, len, &qsg)) {
> > -            status = NVME_INVALID_FIELD | NVME_DNR;
> > +        uint64_t residual;
> > +
> > +        if (dir == DMA_DIRECTION_TO_DEVICE) {
> > +            residual = dma_buf_write(ptr, len, &qsg);
> > +        } else {
> > +            residual = dma_buf_read(ptr, len, &qsg);
> >          }
> > -        qemu_sglist_destroy(&qsg);
> > -    } else {
> > -        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
> > -            status = NVME_INVALID_FIELD | NVME_DNR;
> > -        }
> > -        qemu_iovec_destroy(&iov);
> > -    }
> > -    return status;
> > -}
> >  
> > -static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > -    uint64_t prp1, uint64_t prp2)
> > -{
> > -    QEMUSGList qsg;
> > -    QEMUIOVector iov;
> > -    uint16_t status = NVME_SUCCESS;
> > -
> > -    trace_pci_nvme_dma_read(prp1, prp2);
> > -
> > -    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> > -        return NVME_INVALID_FIELD | NVME_DNR;
> > -    }
> > -    if (qsg.nsg > 0) {
> > -        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
> > +        if (unlikely(residual)) {
> >              trace_pci_nvme_err_invalid_dma();
> >              status = NVME_INVALID_FIELD | NVME_DNR;
> >          }
> > +
> >          qemu_sglist_destroy(&qsg);
> >      } else {
> > -        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) != len)) {
> > +        size_t bytes;
> > +
> > +        if (dir == DMA_DIRECTION_TO_DEVICE) {
> > +            bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
> > +        } else {
> > +            bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
> > +        }
> > +
> > +        if (unlikely(bytes != len)) {
> >              trace_pci_nvme_err_invalid_dma();
> >              status = NVME_INVALID_FIELD | NVME_DNR;
> >          }
> > +
> >          qemu_iovec_destroy(&iov);
> >      }
> > +
> I know I reviewed this, but thinking now, why not to add an assert here
> that we don't have both iov and qsg with data.
> 

Good point. I added it after the nvme_map_prp call.

