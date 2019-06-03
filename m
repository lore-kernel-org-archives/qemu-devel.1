Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09921C282DC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 01:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25D627A7A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 01:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25D627A7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55671 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXbsx-0003q9-V1
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 21:35:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXbs4-0003MB-6g
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 21:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXbs3-0000rt-00
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 21:34:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:53740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hXbs2-00005G-Md
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 21:34:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jun 2019 18:33:35 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2019 18:33:34 -0700
Date: Mon, 3 Jun 2019 09:33:05 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190603013305.GA7784@richard>
References: <20190507031703.856-1-richardw.yang@linux.intel.com>
	<20190531164337.GK3169@work-vm> <20190601033441.GB4958@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601033441.GB4958@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram: leave RAMBlock->bmap blank
 on allocating
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 01, 2019 at 11:34:41AM +0800, Peter Xu wrote:
>On Fri, May 31, 2019 at 05:43:37PM +0100, Dr. David Alan Gilbert wrote:
>> * Wei Yang (richardw.yang@linux.intel.com) wrote:
>> > During migration, we would sync bitmap from ram_list.dirty_memory to
>> > RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().
>> > 
>> > Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
>> > means at the first round this sync is meaningless and is a duplicated
>> > work.
>> > 
>> > Leaving RAMBlock->bmap blank on allocating would have a side effect on
>> > migration_dirty_pages, since it is calculated from the result of
>> > cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
>> > set migration_dirty_pages to 0 in ram_state_init().
>> > 
>> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> 
>> I've looked at this for a while, and I think it's OK, so
>> 
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> Peter, Juan: Can you just see if there's arny reason this would be bad,
>> but I think it's actually more sensible than what we have.
>
>I really suspect it will work in all cases...  Wei, have you done any
>test (or better, thorough tests) with this change?  My reasoning of
>why we should need the bitmap all set is here:
>

I have done some migration cases, like migrate a linux guest through tcp.

Other cases suggested to do?

>https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07361.html
>
>Regards,
>
>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

