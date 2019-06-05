Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF6C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CDD2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CDD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYSO5-0003Ws-0z
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 05:39:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hYSNJ-0003Fi-Oo
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hYSNH-0005i6-Dj
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hYSNG-0005bG-3c
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:38:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB996C18B2C3;
	Wed,  5 Jun 2019 09:38:24 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F20F6601B6;
	Wed,  5 Jun 2019 09:38:21 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:38:19 +0800
From: Peter Xu <peterx@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190605093819.GL15459@xz-x1>
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
	<20190605064108.GH15459@xz-x1> <20190605085207.GA1804@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605085207.GA1804@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 05 Jun 2019 09:38:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram.c: reset complete_round
 when we gets a queued page
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 04:52:07PM +0800, Wei Yang wrote:
> On Wed, Jun 05, 2019 at 02:41:08PM +0800, Peter Xu wrote:
> >On Wed, Jun 05, 2019 at 09:08:28AM +0800, Wei Yang wrote:
> >> In case we gets a queued page, the order of block is interrupted. We may
> >> not rely on the complete_round flag to say we have already searched the
> >> whole blocks on the list.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  migration/ram.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index d881981876..e9b40d636d 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -2290,6 +2290,12 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
> >>           */
> >>          pss->block = block;
> >>          pss->page = offset >> TARGET_PAGE_BITS;
> >> +
> >> +        /*
> >> +         * This unqueued page would break the "one round" check, even is
> >> +         * really rare.
> >
> >Why this is needed?  Could you help explain the problem first?
> 
> Peter, Thanks for your question.
> 
> I found this issue during code review and I believe this is a corner case.
> 
> Below is a draft chart for ram_find_and_save_block:
> 
>     ram_find_and_save_block
>         do
>             get_queued_page()
>             find_dirty_block()
>             ram_save_host_page()
>         while
> 
> The basic logic here is : get a page need to migrate and migrate it.
> 
> In case we don't have get_queued_page(), find_dirty_block() will search the
> whole ram_list.blocks by order. pss->complete_round is used to indicate
> whether this search has looped.
> 
> Everything works fine after get_queued_page() involved. The block unqueued in
> get_queued_page() could be any block in the ram_list.blocks. This means we
> have very little chance to break the looped indicator.
> 
>                            unqueue_page()  last_seen_block
>                                      |     |
>     ram_list.blocks                  v     v
>     ---------------------------------+=====+---
> 
> 
> Just draw a raw picture to demonstrate a corner case.
> 
> For example, we start from last_seen_block and search till the end of
> ram_list.blocks. At this moment, pss->complete_round is set to true. Then we
> get a queued page from unqueue_page() at the point I pointed. So the loop
> continues may just continue the range as I marked as "=". We will skip all the
> other ranges.

Ah I see your point, but I don't think there is a problem - note that
complete_round will be reset for each ram_find_and_save_block(), so
even if we have that iteration of ram_find_and_save_block() to return
we'll still know we have dirty pages to migrate and in the next call
we'll be fine, no?

-- 
Peter Xu

