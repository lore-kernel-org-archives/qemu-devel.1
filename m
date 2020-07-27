Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38A0C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789482075D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHtc2NZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789482075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09zi-000214-Q4
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1k09z9-0001WO-4I; Mon, 27 Jul 2020 16:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1k09z7-0003WR-Dt; Mon, 27 Jul 2020 16:44:34 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 45C412074F;
 Mon, 27 Jul 2020 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595882670;
 bh=ZeI2yVyYLGLhUasMw/9MXqgu6ezaF1A+ks+pgRP/hqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rHtc2NZKEzGAX/RWWjKtBDLxOPrPA1WqJJSA3KaCeLzdz/bHkoo5RLHwB2ZYRz4Sd
 g8zEXa8uKEithIyyo0uDzEUbRsG97BV7+7FaCN14Wc9nOMm52JCfnBVz4AeFJv+/uY
 NnxG9EoiWhJfhXyRVJpMtvJeCzEwfYmnHlKP+ftE=
Date: Mon, 27 Jul 2020 13:44:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 00/16] hw/block/nvme: dma handling and address mapping
 cleanup
Message-ID: <20200727204428.GA797630@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200727094246.GA53366@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727094246.GA53366@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 16:44:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 11:42:46AM +0200, Klaus Jensen wrote:
> On Jul 20 13:37, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > This series consists of patches that refactors dma read/write and adds a
> > number of address mapping helper functions.
> > 
> > Based-on: <20200706061303.246057-1-its@irrelevant.dk>
> > 
> > Klaus Jensen (16):
> >   hw/block/nvme: memset preallocated requests structures
> >   hw/block/nvme: add mapping helpers
> >   hw/block/nvme: replace dma_acct with blk_acct equivalent
> >   hw/block/nvme: remove redundant has_sg member
> >   hw/block/nvme: refactor dma read/write
> >   hw/block/nvme: pass request along for tracing
> >   hw/block/nvme: add request mapping helper
> >   hw/block/nvme: verify validity of prp lists in the cmb
> >   hw/block/nvme: refactor request bounds checking
> >   hw/block/nvme: add check for mdts
> >   hw/block/nvme: be consistent about zeros vs zeroes
> >   hw/block/nvme: refactor NvmeRequest clearing
> >   hw/block/nvme: add a namespace reference in NvmeRequest
> >   hw/block/nvme: consolidate qsg/iov clearing
> >   hw/block/nvme: remove NvmeCmd parameter
> >   hw/block/nvme: use preallocated qsg/iov in nvme_dma_prp
> > 
> >  block/nvme.c          |   4 +-
> >  hw/block/nvme.c       | 498 +++++++++++++++++++++++++++---------------
> >  hw/block/nvme.h       |   4 +-
> >  hw/block/trace-events |   4 +
> >  include/block/nvme.h  |   4 +-
> >  5 files changed, 331 insertions(+), 183 deletions(-)
> > 
> > -- 
> > 2.27.0
> > 
> 
> Gentle ping on this.

I'll have free time to get back to this probably end of the week,
possibly early next week.

