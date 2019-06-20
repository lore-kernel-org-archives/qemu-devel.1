Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3990C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 04:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6178208CB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 04:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6178208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdoUl-0004q0-Oe
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 00:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hdoTi-0003Lj-0A
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 00:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hdoHd-0005JC-Dg
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 00:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hdoHd-0005IJ-6x
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 00:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F28230860B9;
 Thu, 20 Jun 2019 04:02:42 +0000 (UTC)
Received: from xz-x1 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE5555D719;
 Thu, 20 Jun 2019 04:02:33 +0000 (UTC)
Date: Thu, 20 Jun 2019 12:02:30 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190620040230.GB9073@xz-x1>
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
 <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 20 Jun 2019 04:02:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: do not do out of bound notification
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
Cc: pbonzini@redhat.com, Yan Zhao <yan.y.zhao@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 03:17:41PM +0200, Auger Eric wrote:
> Hi Yan,
> 
> [+ Peter]
> 
> On 6/19/19 10:49 AM, Yan Zhao wrote:
> > even if an entry overlaps with notifier's range, should not map/unmap
> > out of bound part in the entry.
> 
> I don't think the patch was based on the master as the trace at the very
> end if not part of the upstream code.
> > 
> > This would cause problem in below case:
> > 1. initially there are two notifiers with ranges
> > 0-0xfedfffff, 0xfef00000-0xffffffffffffffff,
> > IOVAs from 0x3c000000 - 0x3c1fffff is in shadow page table.
> > 
> > 2. in vfio, memory_region_register_iommu_notifier() is followed by
> > memory_region_iommu_replay(), which will first call address space unmap,
> > and walk and add back all entries in vtd shadow page table. e.g.
> > (1) for notifier 0-0xfedfffff,
> >     IOVAs from 0 - 0xffffffff get unmapped,
> >     and IOVAs from 0x3c000000 - 0x3c1fffff get mapped
> 
> While the patch looks sensible, the issue is the notifier scope used in
> vtd_address_space_unmap is not a valid mask (ctpop64(size) != 1). Then
> the size is recomputed (either using n = 64 - clz64(size) for the 1st
> notifier or n = s->aw_bits for the 2d) and also the entry (especially
> for the 2d notifier where it becomes 0) to get a proper alignment.
> 
> vtd_page_walk sends notifications per block or page (with valid
> addr_mask) so stays within the notifier.
> 
> Modifying the entry->iova/addr_mask again in memory_region_notify_one
> leads to unaligned start address / addr_mask. I don't think we want that.
> 
> Can't we modity the vtd_address_space_unmap() implementation to split
> the invalidation in smaller chunks instead?

Seems workable, to be explicit - we can even cut it into chunks with
different size to be efficient.  Like, this range:

  0x0e00_0000 - 0x1_0000_0000 (size 0xf200_0000)

can be one of this:

  0x0e000000 - 0x1000_0000 (size 0x0200_0000)

plus one of this:

  0x1000_0000 - 0x1_0000_0000 (size 0xf000_0000)

Yan, could you help explain the issue better on how to reproduce and
what's the error when the problem occurs?  For example, is that
happened when a device hot-plugged into an existing VFIO container
(with some mapped IOVAs)?  Did you get host DMA errors later on?

Thanks,

-- 
Peter Xu

