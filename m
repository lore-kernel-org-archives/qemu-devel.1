Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EB9C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 13:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5ED2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 13:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5ED2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdaV6-0001wZ-54
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 09:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hdaU0-0001NZ-Ob
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 09:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hdaTz-0003gM-IP
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 09:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hdaTz-0003Eu-BY
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 09:18:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5195E330272;
 Wed, 19 Jun 2019 13:17:47 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 337A161090;
 Wed, 19 Jun 2019 13:17:42 +0000 (UTC)
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com
References: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <39c4c32b-e34a-8d8f-abbc-ab346ec5bed7@redhat.com>
Date: Wed, 19 Jun 2019 15:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1560934185-14152-1-git-send-email-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 19 Jun 2019 13:17:47 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yan,

[+ Peter]

On 6/19/19 10:49 AM, Yan Zhao wrote:
> even if an entry overlaps with notifier's range, should not map/unmap
> out of bound part in the entry.

I don't think the patch was based on the master as the trace at the very
end if not part of the upstream code.
> 
> This would cause problem in below case:
> 1. initially there are two notifiers with ranges
> 0-0xfedfffff, 0xfef00000-0xffffffffffffffff,
> IOVAs from 0x3c000000 - 0x3c1fffff is in shadow page table.
> 
> 2. in vfio, memory_region_register_iommu_notifier() is followed by
> memory_region_iommu_replay(), which will first call address space unmap,
> and walk and add back all entries in vtd shadow page table. e.g.
> (1) for notifier 0-0xfedfffff,
>     IOVAs from 0 - 0xffffffff get unmapped,
>     and IOVAs from 0x3c000000 - 0x3c1fffff get mapped

While the patch looks sensible, the issue is the notifier scope used in
vtd_address_space_unmap is not a valid mask (ctpop64(size) != 1). Then
the size is recomputed (either using n = 64 - clz64(size) for the 1st
notifier or n = s->aw_bits for the 2d) and also the entry (especially
for the 2d notifier where it becomes 0) to get a proper alignment.

vtd_page_walk sends notifications per block or page (with valid
addr_mask) so stays within the notifier.

Modifying the entry->iova/addr_mask again in memory_region_notify_one
leads to unaligned start address / addr_mask. I don't think we want that.

Can't we modity the vtd_address_space_unmap() implementation to split
the invalidation in smaller chunks instead?


Thanks

Eric


> (2) for notifier 0xfef00000-0xffffffffffffffff
>     IOVAs from 0 - 0x7fffffffff get unmapped,>     but IOVAs from 0x3c000000 - 0x3c1fffff cannot get mapped back.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/memory.c b/memory.c
> index 07c8315..a6b9da6 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1948,6 +1948,14 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>          return;
>      }
>  
> +    if (entry->iova < notifier->start) {
> +        entry->iova = notifier->start;
> +    }
> +
> +    if (entry->iova + entry->addr_mask > notifier->end) {
> +        entry->addr_mask = notifier->end - entry->iova;> +    }
> +
>      if (entry->perm & IOMMU_RW) {
>          printf("map %lx %lx\n", entry->iova, entry->iova + entry->addr_mask);
>          request_flags = IOMMU_NOTIFIER_MAP;

> 

