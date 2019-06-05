Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF7C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EAA2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EAA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYRgl-00013w-Vu
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 04:54:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hYRg0-0000nC-HT
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hYRfw-00047Y-Kh
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:53:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:5287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hYRft-0001zB-MX
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:53:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2019 01:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,550,1549958400"; d="scan'208";a="181859822"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2019 01:52:32 -0700
Date: Wed, 5 Jun 2019 16:52:07 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190605085207.GA1804@richard>
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
	<20190605064108.GH15459@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605064108.GH15459@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 02:41:08PM +0800, Peter Xu wrote:
>On Wed, Jun 05, 2019 at 09:08:28AM +0800, Wei Yang wrote:
>> In case we gets a queued page, the order of block is interrupted. We may
>> not rely on the complete_round flag to say we have already searched the
>> whole blocks on the list.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/ram.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index d881981876..e9b40d636d 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2290,6 +2290,12 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
>>           */
>>          pss->block = block;
>>          pss->page = offset >> TARGET_PAGE_BITS;
>> +
>> +        /*
>> +         * This unqueued page would break the "one round" check, even is
>> +         * really rare.
>
>Why this is needed?  Could you help explain the problem first?

Peter, Thanks for your question.

I found this issue during code review and I believe this is a corner case.

Below is a draft chart for ram_find_and_save_block:

    ram_find_and_save_block
        do
            get_queued_page()
            find_dirty_block()
            ram_save_host_page()
        while

The basic logic here is : get a page need to migrate and migrate it.

In case we don't have get_queued_page(), find_dirty_block() will search the
whole ram_list.blocks by order. pss->complete_round is used to indicate
whether this search has looped.

Everything works fine after get_queued_page() involved. The block unqueued in
get_queued_page() could be any block in the ram_list.blocks. This means we
have very little chance to break the looped indicator.

                           unqueue_page()  last_seen_block
                                     |     |
    ram_list.blocks                  v     v
    ---------------------------------+=====+---


Just draw a raw picture to demonstrate a corner case.

For example, we start from last_seen_block and search till the end of
ram_list.blocks. At this moment, pss->complete_round is set to true. Then we
get a queued page from unqueue_page() at the point I pointed. So the loop
continues may just continue the range as I marked as "=". We will skip all the
other ranges.

This is really a corner case, since ram_save_host_page() should return 0 and
there should be no dirty page in this range. But I don't see we may avoid this
case.

If I am not correct, just let me know :-)

>
>Thanks,
>
>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

