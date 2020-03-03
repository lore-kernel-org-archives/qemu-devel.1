Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DC8C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 05:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CF8206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 05:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CF8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j906c-0000jF-Fp
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 00:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.y.sun@linux.intel.com>) id 1j905z-0000H8-7v
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 00:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.y.sun@linux.intel.com>) id 1j905y-0003SN-55
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 00:27:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:14493)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
 id 1j905x-0003S8-Sw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 00:27:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Mar 2020 21:27:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; d="scan'208";a="258254825"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.100])
 by orsmga002.jf.intel.com with ESMTP; 02 Mar 2020 21:27:50 -0800
Date: Tue, 3 Mar 2020 13:22:26 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v1] memory: remove assert to avoid unnecessary coredump
Message-ID: <20200303052226.GA3409@yi.y.sun>
References: <20200303031114.21111-1-yi.y.sun@linux.intel.com>
 <20200303033639.GA18980@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200303033639.GA18980@joy-OptiPlex-7040>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-03-02 22:36:39, Yan Zhao wrote:
> On Tue, Mar 03, 2020 at 11:11:14AM +0800, Yi Sun wrote:
> > It is too strict to use assert to make qemu coredump if
> > the notification does not overlap with registered range.
> > Skip it is fine enough.
> > 
> > During test, we found such a case for vhost net device:
> >     memory_region_notify_one: entry->iova=0xfee00000, entry_end=0xfeffffff, notifier->start=0xfef00000, notifier->end=0xffffffffffffffff
> >
> so for range from 0xfef00000 to 0xfefffff,  would notification for this
> range get lost?
> 
Yes, that is an issue although there is no any problem found during test
with this fix.

I think we should notify the intersection between entry and notifier. How
do you think?

> Thanks
> Yan
> 
> > Skip this notification but not coredump makes everything
> > work well.
> > 
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > ---
> >  memory.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/memory.c b/memory.c
> > index 06484c2bff..62ad0f3377 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1921,12 +1921,11 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> >       * Skip the notification if the notification does not overlap
> >       * with registered range.
> >       */
> > -    if (notifier->start > entry_end || notifier->end < entry->iova) {
> > +    if (notifier->start > entry_end || notifier->end < entry->iova ||
> > +        entry->iova < notifier->start || entry_end > notifier->end) {
> >          return;
> >      }
> >  
> > -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> > -
> >      if (entry->perm & IOMMU_RW) {
> >          request_flags = IOMMU_NOTIFIER_MAP;
> >      } else {
> > -- 
> > 2.15.1
> > 

