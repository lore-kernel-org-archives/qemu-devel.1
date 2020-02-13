Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3FBC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D57C2086A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D57C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Mkl-0001hv-BO
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1j2Mji-00019B-AJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1j2Mjh-0000Tw-2p
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:13:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:48786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1j2Mjg-0000F6-Ph
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:13:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Feb 2020 14:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; d="scan'208";a="267323283"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2020 14:13:19 -0800
Date: Fri, 14 Feb 2020 06:13:37 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration/postcopy: not necessary to discard all RAM at
 the beginning
Message-ID: <20200213221337.GA20833@richard>
References: <20191007091008.9435-1-richardw.yang@linux.intel.com>
 <20200213101704.GD2960@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101704.GD2960@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 10:17:04AM +0000, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> ram_discard_range() unmap page for specific range. To be specific, this
>> clears related page table entries so that userfault would be triggered.
>> But this step is not necessary at the very beginning.
>> 
>> ram_postcopy_incoming_init() is called when destination gets ADVISE
>> command. ADVISE command is sent when migration thread just starts, which
>> implies destination is not running yet. This means no page fault
>> happened and memory region's page tables entries are empty.
>> 
>> This patch removes the discard at the beginning.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/postcopy-ram.c | 46 ----------------------------------------
>>  migration/postcopy-ram.h |  7 ------
>>  migration/ram.c          | 16 --------------
>>  migration/ram.h          |  1 -
>>  migration/savevm.c       |  4 ----
>>  5 files changed, 74 deletions(-)
>> 
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 5da6de8c8b..459be8e780 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -443,32 +443,6 @@ out:
>>      return ret;
>>  }
>>  
>> -/*
>> - * Setup an area of RAM so that it *can* be used for postcopy later; this
>> - * must be done right at the start prior to pre-copy.
>> - * opaque should be the MIS.
>> - */
>> -static int init_range(RAMBlock *rb, void *opaque)
>> -{
>> -    const char *block_name = qemu_ram_get_idstr(rb);
>> -    void *host_addr = qemu_ram_get_host_addr(rb);
>> -    ram_addr_t offset = qemu_ram_get_offset(rb);
>> -    ram_addr_t length = qemu_ram_get_used_length(rb);
>> -    trace_postcopy_init_range(block_name, host_addr, offset, length);
>> -
>> -    /*
>> -     * We need the whole of RAM to be truly empty for postcopy, so things
>> -     * like ROMs and any data tables built during init must be zero'd
>> -     * - we're going to get the copy from the source anyway.
>> -     * (Precopy will just overwrite this data, so doesn't need the discard)
>> -     */
>
>But this comment explains why we want to do the discard; we want to make
>sure that any memory that's been populated by the destination during the
>init process is discarded and replaced by content from the source.
>

OK, you are right. I missed the init stage.


>Dave
>

-- 
Wei Yang
Help you, Help me

