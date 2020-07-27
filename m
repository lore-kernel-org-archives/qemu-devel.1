Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA44C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1C2206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="D2KQcIBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1C2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzfg-0004LT-6Y
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jzzep-0003YF-Ma; Mon, 27 Jul 2020 05:42:56 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jzzen-0005ix-5R; Mon, 27 Jul 2020 05:42:55 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 3AE00BF62F;
 Mon, 27 Jul 2020 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595842970;
 bh=X7OvIbIOgh9Po0RGuaTU00+m/VSMMsGC45R7lfKFeR4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D2KQcIBkqmh71GzL1WZX9uFF6tWcEot0ZHbIizRHrazHkHvpHLIxY9Hv8zC/qmx3X
 o41NNi1R+xfUH+ByaPTGbVRCr5vcs/1Ffco429kJtQFL+0SebNm0b+RxPtVwMVOaFX
 5kqhs/B59vSe6Q20xou4t15qmwNgZDTiCNns1EPNbStKns7GHqhGuvNJ0RgLRxholB
 e6Qi3XeVzkEIMzpHhnrlDcbgmQ1XzbPw0GPt7b/c3MMXnz1kwbOBekp27l/3LwN5pj
 rauxf1An4AwiOMqRegqw8VJTvPlYVU8rgW6HFqdi3t7LjI92w/zNaCIvvhOn6UpI26
 nd9hGzo1l7hMg==
Date: Mon, 27 Jul 2020 11:42:46 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/16] hw/block/nvme: dma handling and address mapping
 cleanup
Message-ID: <20200727094246.GA53366@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-1-its@irrelevant.dk>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 05:06:13
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
Cc: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 20 13:37, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This series consists of patches that refactors dma read/write and adds a
> number of address mapping helper functions.
> 
> Based-on: <20200706061303.246057-1-its@irrelevant.dk>
> 
> Klaus Jensen (16):
>   hw/block/nvme: memset preallocated requests structures
>   hw/block/nvme: add mapping helpers
>   hw/block/nvme: replace dma_acct with blk_acct equivalent
>   hw/block/nvme: remove redundant has_sg member
>   hw/block/nvme: refactor dma read/write
>   hw/block/nvme: pass request along for tracing
>   hw/block/nvme: add request mapping helper
>   hw/block/nvme: verify validity of prp lists in the cmb
>   hw/block/nvme: refactor request bounds checking
>   hw/block/nvme: add check for mdts
>   hw/block/nvme: be consistent about zeros vs zeroes
>   hw/block/nvme: refactor NvmeRequest clearing
>   hw/block/nvme: add a namespace reference in NvmeRequest
>   hw/block/nvme: consolidate qsg/iov clearing
>   hw/block/nvme: remove NvmeCmd parameter
>   hw/block/nvme: use preallocated qsg/iov in nvme_dma_prp
> 
>  block/nvme.c          |   4 +-
>  hw/block/nvme.c       | 498 +++++++++++++++++++++++++++---------------
>  hw/block/nvme.h       |   4 +-
>  hw/block/trace-events |   4 +
>  include/block/nvme.h  |   4 +-
>  5 files changed, 331 insertions(+), 183 deletions(-)
> 
> -- 
> 2.27.0
> 

Gentle ping on this.

Requesting reviews on

  [02/16]: hw/block/nvme: add mapping helpers
  [11/16]: hw/block/nvme: be consistent about zeros vs zeroes
  [12/16]: hw/block/nvme: refactor NvmeRequest clearing
  [13/16]: hw/block/nvme: add a namespace reference in NvmeRequest
  [14/16]: hw/block/nvme: consolidate qsg/iov clearing
  [15/16]: hw/block/nvme: remove NvmeCmd parameter

I think only 02/16 has some meat on it.


Thanks,
Klaus

