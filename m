Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8EAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB72720866
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB72720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ybh-0004uM-S4
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 22:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1j8yVY-0000lt-Ib
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 22:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1j8yVV-0002wC-9r
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 22:46:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:28058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1j8yVV-0002vI-2C
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 22:46:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Mar 2020 19:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; d="scan'208";a="263059421"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2020 19:46:03 -0800
Date: Mon, 2 Mar 2020 22:36:39 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Yi Sun <yi.y.sun@linux.intel.com>
Subject: Re: [PATCH v1] memory: remove assert to avoid unnecessary coredump
Message-ID: <20200303033639.GA18980@joy-OptiPlex-7040>
References: <20200303031114.21111-1-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303031114.21111-1-yi.y.sun@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 03, 2020 at 11:11:14AM +0800, Yi Sun wrote:
> It is too strict to use assert to make qemu coredump if
> the notification does not overlap with registered range.
> Skip it is fine enough.
> 
> During test, we found such a case for vhost net device:
>     memory_region_notify_one: entry->iova=0xfee00000, entry_end=0xfeffffff, notifier->start=0xfef00000, notifier->end=0xffffffffffffffff
>
so for range from 0xfef00000 to 0xfefffff,  would notification for this
range get lost?

Thanks
Yan

> Skip this notification but not coredump makes everything
> work well.
> 
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 06484c2bff..62ad0f3377 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1921,12 +1921,11 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>       * Skip the notification if the notification does not overlap
>       * with registered range.
>       */
> -    if (notifier->start > entry_end || notifier->end < entry->iova) {
> +    if (notifier->start > entry_end || notifier->end < entry->iova ||
> +        entry->iova < notifier->start || entry_end > notifier->end) {
>          return;
>      }
>  
> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> -
>      if (entry->perm & IOMMU_RW) {
>          request_flags = IOMMU_NOTIFIER_MAP;
>      } else {
> -- 
> 2.15.1
> 

