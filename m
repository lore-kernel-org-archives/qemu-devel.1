Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4031C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 07:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B49420714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 07:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="RJKOUbw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B49420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9Pt-0000nO-OM
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 03:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jy9PH-0000H9-Un; Wed, 22 Jul 2020 03:43:16 -0400
Received: from charlie.dont.surf ([128.199.63.193]:49950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jy9PF-0000WH-4Y; Wed, 22 Jul 2020 03:43:15 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 986E8BF5DD;
 Wed, 22 Jul 2020 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595403789;
 bh=CBVt9ecvmppdOE6kbqlcPvVOb+qAkPa18J2vN3szI/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RJKOUbw72ktZ7fbARqW2fwWJTMYJJcncqsTNZdDfSh3ZTh4XPYmFH8u8bV//GdvIq
 yYPQcJKJ47SlNApeOc4gzxs8FuQmIf2TJtuWumF/kniqDoJWzxHBNoTbXE+D2s0U7H
 LwnPjAoo4DE58TK0lfhLLXbud+9ng93/7G53u8jdpXl7E6Xi5Dx+cL176nBfjNZ9vf
 BJl703S/Mq4KXH9et0O3h+B9kX4saW93Xt/VLdeO4zvKSrI3L/AA8JVSURJC5f7FGs
 nMPbq84qGjTQJKLX2TfhSAbu5cuYcLEvtzIE4aC0P9gdu0w7dW5y5HL6aeakR7canX
 RrmEKnpGc0qGA==
Date: Wed, 22 Jul 2020 09:43:05 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200722074305.GA606300@apples.localdomain>
References: <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
 <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
 <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
 <8f871a0d-47f1-1c8a-fcc2-aab2638c70cf@linux.intel.com>
 <20200702175113.6qtnpxqimpavzx7h@apples.localdomain>
 <191b39ed-0588-b5db-d352-965efd19128a@linux.intel.com>
 <20200706071545.md4tivimefffgyi6@apples.localdomain>
 <16d74d40-bd55-997d-7fd6-e7ec59566a68@linux.intel.com>
 <20200715080658.GA506302@apples.localdomain>
 <9143a543-d32d-f3e7-c37b-b3df7f853952@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9143a543-d32d-f3e7-c37b-b3df7f853952@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 03:43:09
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

@keith, please see below - can you comment on the Linux kernel 2 MB
boundary requirement for the CMB? Or should we hail Stephen (or Logan
maybe) since this seems to be related to p2pdma?

On Jul 21 14:54, Andrzej Jakowski wrote:
> On 7/15/20 1:06 AM, Klaus Jensen wrote:
> > Hi Andrzej,
> > 
> > I've not been ignoring this, but sorry for not following up earlier.
> > 
> > I'm hesitent to merge anything that very obviously breaks an OS that we
> > know is used a lot to this using this device. Also because the issue has
> > not been analyzed well enough to actually know if this is a QEMU or
> > kernel issue.
> 
> Hi Klaus,
> 
> Thx for your response! I understand your hesitance on merging stuff that
> obviously breaks guest OS. 
> 
> > 
> > Now, as far as I can test, having the MSI-X vector table and PBA in BAR
> > 0, PMR in BAR 2 and CMB in BAR 4 seems to make everyone happy
> > (irregardless of IOMMU on/off).
> > 
> > Later, when the issue is better understood, we can add options to set
> > offsets, BIRs etc.
> > 
> > The patch below replaces your "[PATCH v4 2/2] nvme: allow cmb and pmr to
> > be enabled" (but still requires "[PATCH v4 1/2] ...") and applies to
> > git://git.infradead.org/qemu-nvme.git nvme-next branch.
> > 
> > Can you reproduce the issues with that patch? I can't on a stock Arch
> > Linux 5.7.5-arch1-1 kernel.
> 
> While I'm happy that approach with MSIX and PBA in BAR0 works fine, I
> feel that investigation part why it works while mine doesn't is
> missing. It looks to me that both patches are basically following same 
> approach: create memory subregion and overlay on top of other memory
> region. Why one works and the other doesn't then?
> 
> Having in mind that, I have recently focused on understanding problem.
> I observed that when guest assigns address to BAR4, addr field in
> nvme-bar4 memory region gets populated, but it doesn't get automatically
> populated in ctrl_mem (cmb) memory subregion, so later when nvme_addr_is_cmb() 
> is called address check works incorrectly and as a consequence vmm does dma 
> read instead of memcpy.
> I created a patch that sets correct address on ctrl_mem subregion and guest 
> OS boots up correctly.
> 
> When I looked into pci and memory region code I noticed that indeed address
> is only assigned to top level memory region but not to contained subregions.
> I think that because in your approach cmb grabs whole bar exclusively it works
> fine.
> 
> Here is my question (perhaps pci folks can help answer :)): if we consider 
> memory region overlapping for pci devices as valid use case should pci 
> code on configuration cycles walk through all contained subregion and
> update addr field accordingly?
> 
> Thx!
> 

Hi Andrzej,

Thanks for looking into this. I think your analysis helped me nail this.
The problem is that we added the use of a subregion and have some
assumptions that no longer hold.

nvme_addr_is_cmb() assumes that n->ctrl_mem.addr is an absolute address.
But when the memory region is a subregion, addr holds an offset into the
parent container instead. Thus, changing all occurances of
n->ctrl_mem.addr to (n->bar0.addr + n->ctrl_mem.addr) fixes the issue
(this is required in nvme_addr_is_cmb and nvme_map_prp). I patched that
in your original patch[1]. The reason my version worked is because there
was no subregion involved for the CMB, so the existing address
validation calculations were still correct.

This leaves us with the Linux kernel complaining about not being able to
register the CMB if it is not on a 2MB boundary - this is probably just
a constraint in the kernel that we can't do anything about (but I'm no
kernel hacker...), which can be fixed by either being "nice" towards the
Linux kernel by forcing a 2 MB alignment in the device or exposing the
SZU field such that the user can choose 16MiB size units (or higher)
instead of 1MiB. I'm leaning towards ensuring the 2 MB alignment in the
device such that we do not have to introduce new cmb_size parameters,
while also making it easier for the user to configure. But I'm not
really sure.

  [1]: Message-Id: <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>

