Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65814C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A059206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A059206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPoy-0001HN-Dm
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1joPke-0004GE-Lm; Thu, 25 Jun 2020 07:09:05 -0400
Received: from charlie.dont.surf ([128.199.63.193]:38792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1joPkb-00085R-GA; Thu, 25 Jun 2020 07:09:03 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 32C77BF432;
 Thu, 25 Jun 2020 11:08:58 +0000 (UTC)
Date: Thu, 25 Jun 2020 13:08:54 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH RESEND v2 2/2] nvme: allow cmb and pmr to be enabled on
 same device
Message-ID: <20200625110854.6y6di67g2wsixpou@apples.localdomain>
References: <20200617051857.20508-1-andrzej.jakowski@linux.intel.com>
 <20200617051857.20508-3-andrzej.jakowski@linux.intel.com>
 <20200618092524.posxi5mysb3jjtpn@apples.localdomain>
 <f766ffd1-04d4-9e41-5393-80e61ab37ec2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f766ffd1-04d4-9e41-5393-80e61ab37ec2@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 07:08:58
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 19 10:30, Andrzej Jakowski wrote:
> On 6/18/20 2:25 AM, Klaus Jensen wrote:
> > On Jun 16 22:18, Andrzej Jakowski wrote:
> >> So far it was not possible to have CMB and PMR emulated on the same
> >> device, because BAR2 was used exclusively either of PMR or CMB. This
> >> patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
> >>
> >> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> >> ---
> >>  hw/block/nvme.c      | 122 ++++++++++++++++++++++++++++---------------
> >>  hw/block/nvme.h      |   5 +-
> >>  include/block/nvme.h |   4 +-
> >>  3 files changed, 86 insertions(+), 45 deletions(-)
> >>
> >> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> >> index 9f11f3e9da..62681966b9 100644
> >> --- a/hw/block/nvme.c
> >> +++ b/hw/block/nvme.c
> >> @@ -22,12 +22,12 @@
> >>   *              [pmrdev=<mem_backend_file_id>,] \
> >>   *              max_ioqpairs=<N[optional]>
> >>   *
> >> - * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
> >> - * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> >> + * Note cmb_size_mb denotes size of CMB in MB. CMB when configured is assumed
> >> + * to be resident in BAR4 at certain offset - this is because BAR4 is also
> >> + * used for storing MSI-X table that is available at offset 0 in BAR4.
> > 
> > I would still really like a R-b by a more PCI-competent reviewer to
> > ensure that it is sane to have the MSI-X table here in prefetchable
> > 64-bit address space.
> 
> Having Reviewed-by for that make sense to me. And let me offer some
> evidences of real devices having MSI-X in prefetchable region and 
> non-prefetchable region. Based on those examples I don't think it matters
> where you place your MSI-X vector.
> 
> Why do you think it may not be sane to place MSI-x table in prefetchable
> region?
> 
> Device with MSI-X in non-prefetchable region:
> Region 0: Memory at fb42c000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
>                 Vector table: BAR=0 offset=00002000
>                 PBA: BAR=0 offset=00003000
> 
> Device with MSI-X in prefetchable region
> Region 0: Memory at fbc00000 (64-bit, prefetchable) [size=2M]
>         Region 2: I/O ports at e020 [size=32]
>         Region 4: Memory at fbe04000 (64-bit, prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>                 Address: 0000000000000000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
>                 Vector table: BAR=4 offset=00000000
>                 PBA: BAR=4 offset=00002000
> 
> 

That's good enough for me. I rest my case!

> 
> > 
> >>   *
> >> - * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
> >> - * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
> >> - * both provided.
> >> + * pmrdev is assumed to be resident in BAR2/BAR3. When configured it consumes
> >> + * whole BAR2/BAR3 exclusively.
> >>   * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
> >>   * For example:
> >>   * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
> >> @@ -69,18 +69,19 @@
> >>  
> >>  static void nvme_process_sq(void *opaque);
> >>  
> >> -static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> >> +static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr, int size)
> >>  {
> >> -    hwaddr low = n->ctrl_mem.addr;
> >> -    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
> >> +    hwaddr low = n->bar4.addr + n->cmb_offset;
> >> +    hwaddr hi  = low + NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
> > 
> > Isn't it better to use n->bar4.size?
> 
> My understanding is that cmb doesn't necessarily need to occupy whole BAR,
> which is required to be power-of-two in size.
> 

You are completely right of course.

