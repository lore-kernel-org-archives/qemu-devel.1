Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A882075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="hSWw+7pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A882075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qkM-00039V-8q
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 14:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0qjZ-0002bZ-1X; Wed, 29 Jul 2020 14:23:21 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0qjV-00040p-2p; Wed, 29 Jul 2020 14:23:20 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 081C6BF616;
 Wed, 29 Jul 2020 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596046994;
 bh=eOYfg29PKjFAZTtXHj8Zuyc4t4W8d95/cekkUArarBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hSWw+7pEphp25dFfAoubr30O5SsVYpaodEG/J1VkPNZ5IRQGQxa4G6vcU5TFEzuaN
 ipH8ARd8vk2RlrAxmZB6nVzK9VxWBkczby00yRcc1oLL77QrYsIckZSJZmjCWyIeS/
 YNx4P6CGqtjzUEmWz9UFFiY4bMLwpPwkxmgVzmGY7a7Up2M7lymhHH1MTeB3Sau41w
 KhaSN7UNOuEzli8kN3wBX1a/l2sh0Qvo4M3bV5w8vj9TRWTWrtEt8cMGxsqKJ8guDE
 n1WM6zv0RN9Mx8E8Gl4ZkY4/LX+zW0g+NSdZCXvYte2Mutwtrq/aL9bpJH538i6vBY
 wpKfyjV6YKjQw==
Date: Wed, 29 Jul 2020 20:23:10 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 02/16] hw/block/nvme: add mapping helpers
Message-ID: <20200729182310.GA213853@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-3-its@irrelevant.dk>
 <0d7e4cb66c28d89b4bd5362d3f133f02287fac13.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d7e4cb66c28d89b4bd5362d3f133f02287fac13.camel@redhat.com>
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

On Jul 29 16:57, Maxim Levitsky wrote:
> On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
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
> > @@ -109,6 +109,11 @@ static uint16_t nvme_sqid(NvmeRequest *req)
> >      return le16_to_cpu(req->sq->sqid);
> >  }
> >  
> > +static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
> > +{
> > +    return &n->cmbuf[addr - n->ctrl_mem.addr];
> I would add an assert here just in case we do out of bounds array access.

We never end up in nvme_addr_to_cmb without nvme_addr_is_cmb checking
the bounds. But an assert cant hurt if someone decides to use it in
error.

I'll add it!

