Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D80AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B736215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B736215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFD0e-0005T4-Fg
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 03:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFCzv-0004x9-Ni
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFCzu-00063M-LW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:55:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:19102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iFCzu-0005wT-D3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:55:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 00:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; d="scan'208";a="392352503"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2019 00:54:53 -0700
Date: Tue, 1 Oct 2019 15:54:35 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: check length directly to make
 sure the range is aligned
Message-ID: <20191001075435.GA1425@richard>
References: <20190712032704.7826-1-richardw.yang@linux.intel.com>
 <20190719175400.GJ3000@work-vm>
 <0fd200f7-ad92-d753-23ca-8c89a27fd346@redhat.com>
 <20190719180651.GM3000@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719180651.GM3000@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 07:06:51PM +0100, Dr. David Alan Gilbert wrote:
>* Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 19/07/19 19:54, Dr. David Alan Gilbert wrote:
>> >> -        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
>> >> -            error_report("ram_block_discard_range: Unaligned end address: %p",
>> >> -                         host_endaddr);
>> >> +        if (length & (rb->page_size - 1)) {
>> >> +            error_report("ram_block_discard_range: Unaligned length: %lx",
>> >> +                         length);
>> > Yes, I *think* this is safe, we'll need to watch out for any warnings;
>> 
>> Do you mean compiler or QEMU warning?
>
>No, I mean lots of these error reports being printed out in some common
>case.
>
>Dave
>
>  The patch is safe since there's an

Dave,

Any further comment for this patch? or What should I do next?

>> 
>>     if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
>>         error_report("ram_block_discard_range: Unaligned start address: %p",
>>                      host_startaddr);
>>         goto err;
>>     }
>> 
>> just before this context.
>> 
>> Paolo
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

